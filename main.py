from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user
from flask_mysqldb import MySQL


# MY db connection
local_server= True
app = Flask(__name__)
app.secret_key='jimmy'


# this is for getting unique user access
login_manager=LoginManager(app)
login_manager.login_view='login'

@login_manager.user_loader
def load_user(user_id):
   x= Company.query.get(int(user_id))
   if x==None:
      x= Customer.query.get(int(user_id))
   return x

   
   



   


# app.config['SQLALCHEMY_DATABASE_URL']='mysql://username:password@localhost/databas_table_name'
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/couriermanagmentsystem'
db=SQLAlchemy(app)




# here we will create db models that is tables

class Company(UserMixin,db.Model):
   id=db.Column(db.Integer,primary_key=True)
   branchemail=db.Column(db.String(50),unique=True)
   branchpassword=db.Column(db.String(1000))
   branchcity=db.Column(db.String(50))
   service=db.Column(db.String(50))

class Customer(UserMixin,db.Model):
   id=db.Column(db.Integer,primary_key=True)
   username=db.Column(db.String(50))
   customeremail=db.Column(db.String(50),unique=True)
   customerpassword=db.Column(db.String(1000))
   customercity=db.Column(db.String(50))
   branchid=db.Column(db.Integer)
   customerdob=db.Column(db.String(50),nullable=False)
   gender=db.Column(db.String(50))
   customernumber=db.Column(db.String(50))
   
class Courierbooking(UserMixin,db.Model):
   courid=db.Column(db.Integer,primary_key=True)
   custid=db.Column(db.String(10000))
   receivername=db.Column(db.String(50))
   receivercity=db.Column(db.String(50))
   receiverphone=db.Column(db.String(20))
   branchid=db.Column(db.String(50))
   couriertype=db.Column(db.String(20))
   courierweight=db.Column(db.Integer)
   service=db.Column(db.String(50))
   courierdate=db.Column(db.String(50),nullable=False)

class Trigr(UserMixin,db.Model):
   trid=db.Column(db.Integer,primary_key=True)
   courid=db.Column(db.Integer)
   custid=db.Column(db.String(10000))
   receivername=db.Column(db.String(50))
   receivercity=db.Column(db.String(50))
   receiverphone=db.Column(db.String(20))
   branchid=db.Column(db.String(50))
   couriertype=db.Column(db.String(20))
   courierweight=db.Column(db.Integer)
   action=db.Column(db.String(50))
   datestamp=db.Column(db.String(50),nullable=False)

class Orderdetails(UserMixin,db.Model):
   orderid=db.Column(db.Integer,primary_key=True)
   branchid=db.Column(db.String(50))
   custid=db.Column(db.String(10000))
   revname=db.Column(db.String(50))
   revcity=db.Column(db.String(50))
   revphone=db.Column(db.String(20))
   courtype=db.Column(db.String(20))
   courid=db.Column(db.String(20))
   orderdate=db.Column(db.String(50),nullable=False)

class Approval(UserMixin,db.Model):
   apid=db.Column(db.Integer,primary_key=True)
   apcustid=db.Column(db.String(10000))
   apcourid=db.Column(db.String(50))
   aprevname=db.Column(db.String(50))
   aprevcity=db.Column(db.String(50))
   aprevphone=db.Column(db.String(20))
   apcourtype=db.Column(db.String(20))
   apcourdate=db.Column(db.String(50),nullable=False)

class Bill(UserMixin,db.Model):
   billid=db.Column(db.Integer,primary_key=True)
   courid=db.Column(db.String(20))
   custid=db.Column(db.String(20))
   packtype=db.Column(db.String(20))
   charge=db.Column(db.Integer)

   

#here we will pass end point and run functions

@app.route('/')
def index():
   return render_template('index.html')



@app.route('/customersignup',methods=['POST','GET'])
def customersignup():
   branch=db.engine.execute("SELECT * FROM `company`")
   if request.method == "POST":
      name=request.form.get('customername')
      email=request.form.get('customeremail')
      password=request.form.get('customerpassword')
      city=request.form.get('customercity')
      branchid=request.form.get('branchid')
      date=request.form.get('customerdob')
      gender=request.form.get('gender')
      number=request.form.get('customernumber')
      customer=Customer.query.filter_by(customeremail=email).first()
      if customer:
         flash("Email Already Exist","warning")
         return render_template('customersignup.html')
      encpassword=generate_password_hash(password)

      new_company=db.engine.execute(f"INSERT INTO `customer`(`username`,`customeremail`,`customerpassword`,`customercity`,`branchid`,`customerdob`,`gender`,`customernumber`) VALUES ('{name}','{email}','{encpassword}','{city}','{branchid}','{date}','{gender}','{number}')")

      # this is method 2 to save data in db
      # newuser=User(username=username,email=email,password=encpassword)
      # db.session.add(newuser)
      # db.session.commit()
      flash("Signup Succes Please Login","success")
      return render_template('index.html')
     
   return render_template('customersignup.html',branch=branch)

@app.route('/branchsignup',methods=['POST','GET'])
def branchsignup():
   if request.method == "POST":
      email=request.form.get('branchemail')
      password=request.form.get('branchpassword')
      city=request.form.get('branchcity')
      service=request.form.get('service')
      company=Company.query.filter_by(branchemail=email).first()
      if company:
         flash("Email Already Exist","warning")
         return render_template('branchsignup.html')
      encpassword=generate_password_hash(password)

      new_company=db.engine.execute(f"INSERT INTO `company`(`branchemail`,`branchpassword`,`branchcity`,`service`) VALUES ('{email}','{encpassword}','{city}','{service}')")

      # this is method 2 to save data in db
      # newuser=User(username=username,email=email,password=encpassword)
      # db.session.add(newuser)
      # db.session.commit()
      flash("Signup Succes Please Login","success")
      return render_template('index.html')
   return render_template('branchsignup.html')


@app.route('/cuslogin',methods=['POST','GET'])
def cuslogin():
   
   if request.method == "POST":
      email=request.form.get('email')
      password=request.form.get('password')
      user=Customer.query.filter_by(customeremail=email).first()
      if user and check_password_hash(user.customerpassword,password):
         login_user(user)
         flash("Login Success","success")
         return redirect(url_for('searchform'))

      else:
         flash("Invalid Credentials","danger")
         return render_template('index.html') 
   return render_template('index.html')


@app.route('/branlogin',methods=['POST','GET'])
def branlogin():
   
   if request.method == "POST":
      email=request.form.get('email')
      password=request.form.get('password')
      userad=Company.query.filter_by(branchemail=email).first()
      if userad and check_password_hash(userad.branchpassword,password):
         login_user(userad)
         flash("Login Success","success")
         return redirect(url_for('orderdetails'))
      else:
         flash("Invalid Credentials","danger")
         return render_template('index.html') 
   return render_template('index.html')


@app.route('/searchform')
def searchform():
   return render_template('searchform.html')
   



@app.route('/customers')
def customers():
   return render_template('customers.html')

@app.route('/destsearch')
@login_required
def destsearch():
   query=db.engine.execute("SELECT * FROM `company`")
   return render_template('destsearch.html',query=query)

@app.route('/company')
def company():
   return render_template('company.html')

@app.route('/courierbooking',methods=['POST','GET'])
@login_required
def courierbooking():
   branch=db.engine.execute("SELECT * FROM `company`")
   if request.method=="POST":
      id=request.form.get('id')
      receivername=request.form.get('receivername')
      receivercity=request.form.get('receivercity')
      receivernumber=request.form.get('receivernumber')
      couriertype=request.form.get('couriertype')
      courierweight=request.form.get('courierweight')
      date=request.form.get('date')
      branchid=request.form.get('branchid')
      service=request.form.get('service')
      query=db.engine.execute(f"INSERT INTO `courierbooking` (`custid`,`receivername`,`receivercity`,`receiverphone`,`branchid`,`couriertype`,`courierweight`,`courierdate`,`service`) VALUES ('{id}','{receivername}','{receivercity}','{receivernumber}','{branchid}','{couriertype}','{courierweight}','{date}','{service}')")
      flash("Booking Confirmed","info")
   return render_template('courierbooking.html',branch=branch)


@app.route('/bookingdetails')
@login_required
def bookingdetails():
   id=current_user.id
   query=db.engine.execute(f"SELECT * FROM `courierbooking` WHERE custid='{id}'")
   return render_template('bookingdetails.html',query=query)
   return render_template('bookingdetails.html')

@app.route('/orderdetails')
@login_required
def orderdetails():
   id=current_user.id
   query=db.engine.execute(f"SELECT * FROM `approval` WHERE branchid='{id}'")
   return render_template('orderdetails.html',query=query)
   return render_template('orderdetails.html')

@app.route('/bills')
@login_required
def bills():
   id=current_user.id
   query=db.engine.execute(f"SELECT * FROM `bill` WHERE custid='{id}'")
   return render_template('bills.html',query=query)
   return render_template('bills.html')


@app.route('/approvedcouriers')
@login_required
def approvedcouriers():
   id=current_user.id
   query=db.engine.execute(f"SELECT * FROM `orderdetails` WHERE branchid='{id}'")
   return render_template('approvedcouriers.html',query=query)
   return render_template('approvedcouriers.html')


@app.route("/approve/<string:courid>",methods=['POST','GET'])
@login_required
def approve(courid):
   posts=Courierbooking.query.filter_by(courid=courid).first()
   if request.method=="POST":
      cid=request.form.get('cid')
      id=request.form.get('id')
      receivername=request.form.get('receivername')
      receivercity=request.form.get('receivercity')
      receivernumber=request.form.get('receivernumber')
      couriertype=request.form.get('couriertype')
      date=request.form.get('date')
      branchid=request.form.get('branchid')
      charge=request.form.get('couriercharge')
      query=db.engine.execute(f"INSERT INTO `orderdetails` (`courid`,`custid`,`revname`,`revcity`,`revphone`,`branchid`,`courtype`,`orderdate`) VALUES ('{cid}','{id}','{receivername}','{receivercity}','{receivernumber}','{branchid}','{couriertype}','{date}')")
      query=db.engine.execute(f"INSERT INTO `bill` (`courid`,`custid`,`packtype`,`charge`) VALUES ('{cid}','{id}','{couriertype}','{charge}')")
      db.engine.execute(f"DELETE FROM `approval` WHERE `approval`.`courid`={courid}")
      return redirect('/approvedcouriers')
   return render_template('approve.html',posts=posts)





@app.route("/edit/<string:courid>",methods=['POST','GET'])
@login_required
def edit(courid):
   posts=Courierbooking.query.filter_by(courid=courid).first()
   if request.method=="POST":
      id=request.form.get('id')
      receivername=request.form.get('receivername')
      receivercity=request.form.get('receivercity')
      receivernumber=request.form.get('receivernumber')
      couriertype=request.form.get('couriertype')
      courierweight=request.form.get('courierweight')
      date=request.form.get('date')
      branchid=request.form.get('branchid')
      service=request.form.get('service')
      db.engine.execute(f"UPDATE `courierbooking` SET `custid` = '{id}', `receivername` = '{receivername}', `receivercity` = '{receivercity}', `receiverphone` = '{receivernumber}', `branchid` = '{branchid}', `couriertype` = '{couriertype}', `courierweight` = '{courierweight}', `courierdate` = '{date}' ,`service`='{service}' WHERE `courierbooking`.`courid` = {courid}" )
      flash("Booking is Updated","success")
      return redirect('/bookingdetails')
   return render_template('edit.html',posts=posts)


@app.route("/delete/<string:courid>",methods=['POST','GET'])
@login_required
def delete(courid):
   db.engine.execute(f"DELETE FROM `courierbooking` WHERE `courierbooking`.`courid`={courid}")
   db.engine.execute(f"DELETE FROM `approval` WHERE `approval`.`courid`={courid}")
   db.engine.execute(f"DELETE FROM `orderdetails` WHERE `orderdetails`.`courid`={courid}")
   db.engine.execute(f"DELETE FROM `bill` WHERE `bill`.`courid`={courid}")
   flash("Booking Deleted Successful","danger")
   return redirect('/courierbooking')

@app.route("/reject/<string:courid>",methods=['POST','GET'])
@login_required
def reject(courid):
   db.engine.execute(f"DELETE FROM `courierbooking` WHERE `courierbooking`.`courid`={courid}")
   db.engine.execute(f"DELETE FROM `approval` WHERE `approval`.`courid`={courid}")
   flash("Booking Rejected Successful","danger")
   return redirect('/orderdetails')


@app.route("/deletep/<string:courid>",methods=['POST','GET'])
@login_required
def deletep(courid):
   db.engine.execute(f"DELETE FROM `courierbooking` WHERE `courierbooking`.`courid`={courid}")
   db.engine.execute(f"DELETE FROM `orderdetails` WHERE `orderdetails`.`courid`={courid}")
   db.engine.execute(f"DELETE FROM `bill` WHERE `bill`.`courid`={courid}")
   flash(" Deleted Successful","danger")
   return redirect('/approvedcouriers')


@app.route('/trigr')
@login_required
def trigr():
   id=current_user.id
   posts=db.engine.execute(f"SELECT * FROM `trigr` WHERE custid='{id}'")
   return render_template('trigr.html',posts=posts)


@app.route('/logout')
@login_required
def logout():
   logout_user()
   return redirect(url_for('index'))


@app.route('/search',methods=['POST','GET'])
@login_required
def search():
    if request.method=="POST":
        query=request.form.get('search')
        dest=Company.query.filter_by(branchcity=query).first()
        if dest:

            flash("Destination is Available","info")
            return redirect(url_for('courierbooking'))
        else:

            flash("Destination is Not Available","danger")
            return redirect(url_for('destsearch'))
    return render_template('searchform.html')




app.run(debug=True)