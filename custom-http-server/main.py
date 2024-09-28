import mysql.connector
import os
from http.server import HTTPServer, BaseHTTPRequestHandler
  
mydb = mysql.connector.connect(
  host=os.environ["DB_HOST"],
  user=os.environ["DB_USER"],
  password=os.environ["DB_PASS"],
  database=os.environ["DB_NAME"]
)

def get_db_version():
    return mydb.get_server_version()
    
class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        client_ip = self.client_address[0]
        client_ip_array = client_ip.split(".")
        client_ip_array_reversed = client_ip_array[::-1]
        client_ip_reversed = str.join(".", client_ip_array_reversed)

        db_version = get_db_version()
        
        full_text = f"ReversedIp={client_ip_reversed}, DB version={db_version}"
        full_text_bytes = bytes(full_text, 'utf-8')

        self.send_response(200)
        self.end_headers()
        self.wfile.write(full_text_bytes)


if __name__ == "__main__":

        httpd = HTTPServer(('', 8080), SimpleHTTPRequestHandler)
        httpd.serve_forever()