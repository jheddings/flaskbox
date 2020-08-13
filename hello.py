from flask import Flask, escape, request

app = Flask(__name__, template_folder='/opt/site/html', static_folder='/opt/site/static')

@app.route('/')
def hello():
    name = request.args.get("name", "World")
    return f'Hello, {escape(name)}!'

