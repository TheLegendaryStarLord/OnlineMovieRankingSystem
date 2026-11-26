from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/SignUp')
def SignUp():
    return render_template('SignUp.html')

@app.route('/SignIn')
def SignIn():
    return render_template('SignIn.html')

@app.route('/title', methods=["GET","POST"])
def title():
    if request.method == "POST":
        movieSearchQuery = request.form.get("title")
        return f"you requested {movieSearchQuery}"

@app.route('/login', methods=["GET","POST"])
def login():
    if request.method == "POST":
        loginEmail = request.form.get("loginEmail")
        loginPassword = request.form.get("loginPassword")
        return f"Login Info {loginEmail} {loginPassword}"

if __name__ == '__main__':
    app.run(debug=True)