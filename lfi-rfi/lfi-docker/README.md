Exploiting CVE-2016-0752
---

This app serves as a vulnerable Proof of Concept for exploiting CVE-2016-0752. For more information refer to this [blog post](https://nvisium.com/blog/2016/01/26/rails-dynamic-render-to-rce-cve-2016-0752/), which explains the vulnerability, the steps required to exploit, the fix, and a link to a metasploit module.

Getting Started
---


    echo "" > log/development.log # Clear out the log file
    rvm use 2.2.3
    bundle
    rails s

Vulnerable URL: http://localhost/users/dashboard