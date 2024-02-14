from flask import Flask, make_response, redirect,render_template, request, session,url_for,flash, jsonify
from mysql.connector import MySQLConnection
from flask_bcrypt import Bcrypt
import json
from urllib.parse import quote
import locale

app=Flask(__name__)
bcrypt = Bcrypt(app)
locale.setlocale(locale.LC_ALL, 'en_IN')

config = {
	"host": "localhost",
	"user": "root",
	"password": "",
	"port": 3307,
	"database": "clothing_store",
	"charset": "utf8mb4",
	"collation": "utf8mb4_unicode_ci"
}

cnx=MySQLConnection(**config)
app.secret_key='Cloth'
app.jinja_env.filters['urlquote'] = lambda u: quote(str(u)) if u else ''
app.jinja_env.filters['currency_format'] = lambda v: locale.currency(v, grouping=True) if v else ''

@app.context_processor
def inject_cart_and_user():
	cursor = cnx.cursor(buffered=True, dictionary=True)
	query = "SELECT id,title FROM tbl_categories"
	cursor.execute(query)
	categories = cursor.fetchall()
	cursor.close()
	if session.get('user'):
		cursor = cnx.cursor(dictionary=True)
		query = "SELECT product_info FROM tbl_cart WHERE user_id = %s"
		user = session['user']
		params = (user['id'],)
		cursor.execute(query, params)
		cartData = cursor.fetchone()
		cursor.close()
		if cartData != None:
			data = len(json.loads(cartData['product_info']))
		else:
			data = 0
		return dict(categories = categories, cartCount = data, user = user)
	else:
		return dict(categories = categories)

@app.route('/', methods=['GET'])
def home():
	cursor = cnx.cursor(dictionary=True)
	query = "SELECT p.id, p.name as title, p.thumbnail, COUNT(DISTINCT s.size) as variants, s.price FROM tbl_products p RIGHT JOIN tbl_specifications s ON s.pid = p.id GROUP BY p.name"
	cursor.execute(query)
	products = cursor.fetchall()
	return render_template('home.html', products = products)

@app.route('/login', methods=['GET', 'POST'])
def login():
	if request.method=='POST':
		if request.form.get('email') != None and request.form.get('password'):
			cursor = cnx.cursor(dictionary=True)
			email = request.form.get("email")
			password = request.form.get("password")
			query = "SELECT secret, id, CONCAT(fname, ' ', lname) as name FROM tbl_users WHERE email = %s"
			params = (email,)
			cursor.execute(query, params)
			data = cursor.fetchone()
			if bcrypt.check_password_hash(data['secret'], password):
				session['user'] = dict(email = email, id = data['id'], name = data['name'])
				return jsonify({'status': True})
			else:
				return jsonify({'status': False, 'message': 'Invalid credentials'})
		else:
				return jsonify({'status': False, 'message': 'Invalid data'})
	else:
		if session.get('user'):
			return redirect('/shop')
		else:
			return render_template('login.html')
		
@app.route('/profile', methods=['GET'])
def profile():
	if session.get('user'):
		cursor = cnx.cursor(dictionary=True)
		cursor.execute("SELECT COUNT(id) as addressCount from tbl_addresses WHERE user_id = %s", (session['user']['id'], ))
		addressCount = cursor.fetchone()['addressCount']
		cursor.close()
		user = {'name': session['user']['name'], 'email': session['user']['email']}
		addressCount = int(addressCount)
		if addressCount > 0:
			cursor = cnx.cursor(dictionary=True)
			cursor.execute("SELECT * from tbl_addresses WHERE user_id = %s", (session['user']['id'], ))
			addresses = cursor.fetchall()
			cursor.close()
			return render_template('profile.html', user = user, addressCount = addressCount, addresses= addresses)
		return render_template('profile.html', user = user, addressCount = addressCount)
	else:
		return redirect('/shop')

@app.route('/add-address', methods=['POST'])
def add_address():
	if session.get('user'):
		title = request.form['address_title']
		full = request.form['address_full']
		city = request.form['address_city']
		state = request.form['address_state']
		pincode = request.form['address_pincode']
		contact = request.form['address_contact']
		if title.strip() != '' and full.strip() != '' and city.strip() != '' and state.strip() != '' and pincode.strip() != '' and contact.strip() != '':
			cursor = cnx.cursor(dictionary=True, buffered=True)
			query = "INSERT INTO tbl_addresses (title, full, city, state, pincode, contact, user_id) VALUES (%s,%s,%s,%s,%s,%s,%s)"
			params = (title, full, city, state, pincode, contact, session['user']['id'])
			cursor.execute(query, params)
			cnx.commit()
			count = cursor.rowcount
			cursor.close()
			return jsonify({"status": True if count > 0 else False, "message": "Address added." if count > 0 else "Failed to add address."})
	else:
		return make_response(jsonify({"status": False, "message": "You must be logged in."})), 401

@app.route('/signup', methods=['POST'])
def signup():
	if request.method=='POST':
		fname=request.form.get("fname")
		lname=request.form.get("lname")
		email=request.form.get("email")
		pass1=request.form.get("pass1")
		pass2=request.form.get("pass2")
		cursor=cnx.cursor()
		query="INSERT INTO project.signup(fname,lname,email,pass1,pass2) VALUES(%s,%s,%s,%s,%s)"
		val=(fname,lname,email,pass1,pass2)
		cursor.execute(query,val)
		cnx.commit()
		return render_template("form.html",fname=fname,lname=lname,email=email,pass1=pass1,pass2=pass2)
	
@app.route('/shop', methods=['GET'])
def shop():
	category = request.args.get('category')
	cursor = cnx.cursor(dictionary=True)
	if category != None and str(category).strip() != '':
		category = int(category)
		query = "SELECT p.id, p.name as title, p.thumbnail, COUNT(DISTINCT s.size) as variants, s.price FROM tbl_products p RIGHT JOIN tbl_specifications s ON s.pid = p.id WHERE category = %s GROUP BY p.name"
		cursor.execute(query, (category, ))
	else:
		query = "SELECT p.id, p.name as title, p.thumbnail, COUNT(DISTINCT s.size) as variants, s.price FROM tbl_products p RIGHT JOIN tbl_specifications s ON s.pid = p.id GROUP BY p.name"
		cursor.execute(query)
	products = cursor.fetchall()
	cursor.close()
	return render_template('shop.html', products = products)

@app.route('/product/<int:product_id>', methods=['GET'])
def product(product_id):
	cursor = cnx.cursor(dictionary=True)
	query = "SELECT id, name as title, description, thumbnail FROM tbl_products WHERE id = %s"
	cursor.execute(query, (product_id, ))
	product = cursor.fetchone()
	cursor.close()
	if len(product) > 0:
		colors = [{"name": "Blue", "value": "blue"},{"name": "Black", "value": "black"},{"name": "Brown", "value": "brown"},{"name": "Red", "value": "red"}]
		cursor = cnx.cursor(dictionary=True)
		query = "SELECT id, size FROM tbl_specifications WHERE pid = %s"
		cursor.execute(query, (product_id, ))
		variants = cursor.fetchall()
		return render_template('product.html', product = product, variants = variants, colors = colors)
	
@app.route('/get-product-price', methods =['POST'])
def get_product_price():
	spec = request.form.get('spec-id')
	if spec != None and spec.strip() != '':
		cursor = cnx.cursor(dictionary=True)
		query = "SELECT quantity, price FROM tbl_specifications WHERE id = %s"
		cursor.execute(query, (spec, ))
		variant = cursor.fetchone()
		if variant != None:
			return jsonify({"status": True, "qnt": variant['quantity'], "amt": locale.currency(variant['price'], grouping=True)})
		else:
			return jsonify({"status": False, "message": "Product variant unavailable"})
	else:
		return jsonify({"status": False, "message": "Invalid request"})

@app.route('/cart', methods=['GET'])
def cart():
	if session.get('user'):
		cursor = cnx.cursor(dictionary=True)
		query = "SELECT product_info FROM tbl_cart WHERE user_id = %s"
		params = (session['user']['id'],)
		cursor.execute(query, params)
		data = cursor.fetchone()
		if data != None:
			product_info = json.loads(data['product_info'])
			cursor.close()
			if len(product_info) > 0:
				cursor = cnx.cursor(dictionary=True, buffered=True)
				cursor.execute("SELECT COUNT(id) as addressCount from tbl_addresses WHERE user_id = %s", (session['user']['id'], ))
				addressCount = cursor.fetchone()['addressCount']
				products = []
				for p in product_info:
					query = "SELECT p.id, p.name as title, p.thumbnail, s.size, s.price, s.quantity as stock FROM tbl_products p INNER JOIN tbl_specifications s ON s.pid = p.id WHERE s.id = %s"
					params = (p['spec'],)
					cursor.execute(query, params)
					product = cursor.fetchone()
					product['spec'] = p['spec']
					product['color'] = p['color']
					products.append(product)
				cursor.close()
				return render_template('cart.html', cartProducts = products, addressCount = addressCount)
			else:
				return render_template('cart.html', cartProducts = 0)
		else:
			return render_template('cart.html', cartProducts = 0)
	else:
		return redirect('/login')
	
@app.route('/add-to-cart', methods=['POST'])
def add_to_cart():
	if session.get('user'):
		variant = request.form.get('variant')
		color = request.form.get('color')
		if variant != None and variant.strip() != '' and color != None and color.strip() != '':
			cursor = cnx.cursor(dictionary=True, buffered=True)
			query = "SELECT quantity FROM tbl_specifications WHERE id = %s"
			cursor.execute(query, (variant, ))
			specs = cursor.fetchone()
			if specs != None:
				if int(specs['quantity']) > 0:
					cartItem = {'spec': variant, 'color': color}
					query = "SELECT product_info FROM tbl_cart WHERE user_id = %s"
					params = (session['user']['id'], )
					cursor.execute(query, params)
					products = cursor.fetchone()
					if products != None:
						products = json.loads(products['product_info'])
						for product in products:
							if product['spec'] == cartItem['spec'] and product['color'] == cartItem['color']:
								return jsonify({"status": False, "message": "Product is already in the cart."})
						products.append(cartItem)
						query = "UPDATE tbl_cart SET product_info = %s WHERE user_id = %s"
						params = (json.dumps(products), session['user']['id'])
						cursor.execute(query, params)
						cnx.commit()
					else:
						query = "INSERT INTO tbl_cart (product_info, user_id) VALUES (%s, %s)"
						product = json.dumps([cartItem])
						params = (product, session['user']['id'])
						cursor.execute(query, params)
						cnx.commit()
					return jsonify({"status": True if cursor.rowcount > 0 else False, "message": "Added to cart." if cursor.rowcount > 0 else "Failed to add to cart."})
				else:
					return jsonify({"status": False, "message": "Product currently unavailable."})
			else:
				return jsonify({"status": False, "message": "Something went wrong."})
	else:
		return make_response(jsonify({"status": False, "message": "You must be logged in."})), 401
	
@app.route('/get-calc-product-price', methods=['POST'])
def get_calc_product_price():
	spec = request.form.get('spec-id')
	qnt = int(request.form.get('quantity'))
	if spec != None and spec.strip() != '':
		cursor = cnx.cursor(dictionary=True)
		query = "SELECT quantity, price FROM tbl_specifications WHERE id = %s"
		cursor.execute(query, (spec, ))
		variant = cursor.fetchone()
		if variant != None:
			if qnt <= int(variant['quantity']):
				price = qnt * variant['price']
				return jsonify({"status": True, "price": locale.currency(price, grouping=True)})
			else:
				return jsonify({"status": False, "message": "Invalid product quantity"})
		else:
			return jsonify({"status": False, "message": "Product variant unavailable"})
	else:
		return jsonify({"status": False, "message": "Invalid request"})

@app.route('/remove-cart-item', methods =['POST'])
def removeFromCart():
	cartItemId = int(request.form['cartItem'])
	cursor = cnx.cursor(dictionary=True)
	query = "SELECT product_info as products FROM tbl_cart WHERE user_id = %s"
	cursor.execute(query, (session['user']['id'],))
	productInfo = cursor.fetchone()
	if productInfo != None:
		productInfo = json.loads(productInfo['products'])
		idx = next((i for i, item in enumerate(productInfo) if int(item["spec"]) == cartItemId), None)
		if(idx != None):
			if len(productInfo) == 1:
				query = "DELETE FROM tbl_cart WHERE user_id = %s"
				val=(session['user']['id'],)
				cursor.execute(query, val)
				cnx.commit()
			else:
				del productInfo[idx]
				info = json.dumps(productInfo)
				query = "UPDATE tbl_cart SET product_info = %s WHERE user_id = %s"
				val=(info, session['user']['id'])
				cursor.execute(query, val)
				cnx.commit()
			if(cursor.rowcount > 0):
				result={'status': True, 'message': 'Removed from cart'}
			else:
				result={'status': False, 'message': 'Failed to remove from cart'}
		else:
			result={'status': False, 'message': 'Item not found'}
	else:
		result={'status': False, 'message': 'Your cart is empty'}
	return jsonify(result)

@app.route('/checkout', methods =['POST'])
def checkout():
	return render_template('checkout.html', cartData = request.form)

@app.route('/logout')
def logout():
	session.clear()
	return redirect(url_for("login"))

'''
@app.route('/gen-pass')
def genPassword():
	cursor = cnx.cursor()
	query = "SELECT email,secret FROM tbl_users"
	cursor.execute(query)
	data = cursor.fetchall()
	for user in data:
		query = "UPDATE tbl_users SET secret = %s WHERE email = %s"
		hashed_password = bcrypt.generate_password_hash(user[1]).decode('utf-8') 
		params = (hashed_password, user[0])
		cursor.execute(query, params)
	cnx.commit()
	return make_response('hello')
'''

if (__name__  == '__main__'):
	app.run(debug=True)