from http.server import BaseHTTPRequestHandler, HTTPServer
import os

visit_count = 0

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        global visit_count
        visit_count += 1
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        with open('index.html', 'r') as file:
            content = file.read().replace('{{counter}}', str(visit_count))
        self.wfile.write(content.encode())

HTTPServer(('localhost', 8000), Handler).serve_forever()