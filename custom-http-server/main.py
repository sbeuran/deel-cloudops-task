from http.server import HTTPServer, BaseHTTPRequestHandler
  

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        client_ip = self.client_address[0]
        client_ip_array = client_ip.split(".")
        client_ip_array_reversed = client_ip_array[::-1]
        client_ip_reversed = str.join(".", client_ip_array_reversed)

        client_ip_reversed_bytes = bytes(client_ip_reversed, 'utf-8')

        self.send_response(200)
        self.end_headers()
        self.wfile.write(client_ip_reversed_bytes)


if __name__ == "__main__":

        httpd = HTTPServer(('0.0.0.0', 8080), SimpleHTTPRequestHandler)
        httpd.serve_forever()