from flask import Flask, make_response, redirect,render_template, request, session,url_for,flash, jsonify
from mysql.connector import MySQLConnection
from flask_bcrypt import Bcrypt

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

@app.route('/')
def home():
	return render_template('home.html')

@app.route('/login')
def login():
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
	return render_template('shop.html')

@app.route('/checkout')
def checkout():
		cursor = mysql.connection.cursor()
		query = "SELECT DISTINCT addtocart.*,pimage.imgpath,pdetail.quantity as max FROM project.addtocart JOIN project.pimage ON pimage.pid = addtocart.pid JOIN project.pdetail ON pdetail.pid = addtocart.pid WHERE addtocart.email = %s"
		val=(session['email'], )
		cursor.execute(query, val)
		data=cursor.fetchall()
		return render_template('checkout.html', cartItems=jsonify(data).json)

@app.route('/remove-cart-item', methods =['POST'] )
def removeFromCart():
	cartItemId = int(request.form['cartItem'])
	cursor = cnx.cursor()
	query = "DELETE FROM project.addtocart WHERE addtocart.id = %s"
	val=(cartItemId, )
	cursor.execute(query, val)
	cnx.commit()
	if(cursor.rowcount > 0):
		result={'status': True, 'message': 'Removed from cart'}
	else:
		result={'status': False, 'message': 'Failed to remove from cart'}
	return jsonify(result)

@app.route('/checkoutpage', methods =['POST'] )
def checkoutPage():
	return render_template()

@app.route('/logout')
def logout():
	session.pop('email',None)
	return redirect(url_for("signup"))

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