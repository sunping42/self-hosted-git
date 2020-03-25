#!/usr/bin/env python3

import os
import subprocess
from http.server import HTTPServer, BaseHTTPRequestHandler
import urllib.parse

class GitWebHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        
        html = """
        <html>
        <head><title>Git Server</title></head>
        <body>
        <h1>Git Repositories</h1>
        <ul>
        """
        
        git_dir = "/var/git"
        if os.path.exists(git_dir):
            for item in os.listdir(git_dir):
                if item.endswith('.git'):
                    repo_name = item[:-4]
                    html += f'<li><a href="/repo/{repo_name}">{repo_name}</a></li>'
        
        html += """
        </ul>
        </body>
        </html>
        """
        
        self.wfile.write(html.encode())

if __name__ == "__main__":
    server = HTTPServer(('0.0.0.0', 8080), GitWebHandler)
    print("Git web interface running on port 8080")
    server.serve_forever()
