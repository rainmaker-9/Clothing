from flask import Flask, make_response, redirect,render_template, request, session,url_for,flash, jsonify
from mysql.connector import MySQLConnection
from flask_bcrypt import Bcrypt
import json
from urllib.parse import quote
from markupsafe import Markup

app=Flask(__name__)
bcrypt = Bcrypt(app)

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

@app.context_processor
def inject_cart_and_user():
	cursor = cnx.cursor(buffered=True, dictionary=True)
	query = "SELECT title FROM tbl_categories"
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
			data = len(cartData)
		else:
			data = 0
		return dict(categories = categories, cartCount = data, user = user)
	else:
		return dict(categories = categories)

@app.route('/')
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
	
@app.route('/shop')
def shop():
	category = request.args.get('category')

	cursor = cnx.cursor(dictionary=True)
	query = "SELECT p.id, p.name as title, p.thumbnail, COUNT(DISTINCT s.size) as variants, s.price FROM tbl_products p RIGHT JOIN tbl_specifications s ON s.pid = p.id GROUP BY p.name"
	cursor.execute(query)
	products = cursor.fetchall()
	cursor.close()
	return render_template('shop.html', products = products)

@app.route('/cart')
def cart():
	if session.get('user'):
		cursor = cnx.cursor()
		query = "SELECT product_info FROM tbl_cart WHERE user_id = %s"
		params = (session['user']['id'],)
		cursor.execute(query, params)
		data = cursor.fetchone()
		if data != None:
			product_info = json.loads(data[0])
			cursor.close()
			if len(product_info) > 0:
				products = []
				for p in product_info:
					cursor = cnx.cursor(dictionary=True)
					query = "SELECT p.name as title, p.thumbnail, s.size, s.price, s.quantity as stock FROM tbl_products p INNER JOIN tbl_specifications s ON s.pid = p.id WHERE s.id = %s"
					params = (p['spec'],)
					cursor.execute(query, params)
					product = cursor.fetchone()
					product['spec'] = p['spec']
					products.append(product)
				return render_template('cart.html', cartProducts = products)
			else:
				return render_template('cart.html', cartProducts = 0)
		else:
			return render_template('cart.html', cartProducts = 0)
	else:
		return redirect('/login')

@app.route('/checkout')
def checkout():
		cursor = cnx.cursor()
		query = "SELECT DISTINCT addtocart.*,pimage.imgpath,pdetail.quantity as max FROM project.addtocart JOIN project.pimage ON pimage.pid = addtocart.pid JOIN project.pdetail ON pdetail.pid = addtocart.pid WHERE addtocart.email = %s"
		val=(session['email'], )
		cursor.execute(query, val)
		data=cursor.fetchall()
		return render_template('checkout.html', cartItems=jsonify(data).json)

@app.route('/remove-cart-item', methods =['POST'] )
def removeFromCart():
	cartItemId = int(request.form['cartItem'])
	cursor = cnx.cursor()
	query = "SELECT product_info as products FROM tbl_cart WHERE user_id = %s"
	cursor.execute(query, (session['user']['id'],))
	productInfo = cursor.fetchone()
	if productInfo != None:
		productInfo = json.loads(productInfo[0])
		idx = next((i for i, item in enumerate(productInfo) if item["spec"] == cartItemId), None)
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

@app.route('/checkoutpage', methods =['POST'] )
def checkoutPage():
	return render_template()

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