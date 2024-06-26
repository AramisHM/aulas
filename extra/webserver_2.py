# Webserver simples com contador de visita

from http.server import BaseHTTPRequestHandler, HTTPServer

visit_count = 0

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        global visit_count
        visit_count += 1
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(f'<html><body><h1>Hello, World!</h1><p>Visits: {visit_count}</p></body></html>'.encode())

HTTPServer(('localhost', 8000), Handler).serve_forever()