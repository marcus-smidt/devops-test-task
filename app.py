from flask import Flask, request, abort

app = Flask(__name__)

@app.route('/hello')
def hello():
    if request.headers.get('User-Agent') == 'bad guy':
        abort(403)
    return "hello prozorro"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
