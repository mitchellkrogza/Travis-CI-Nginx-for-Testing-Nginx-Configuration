server {
    listen 8080 default_server;
    listen [::]:8080 default_server ipv6only=on;
    root {ROOT}/www;
    access_log /tmp/access.log;
    error_log /tmp/error.log;
    
    # Add Any Custom Configurations Here

    location ~* "\.php(/|$)" {
        include fastcgi.conf;
        fastcgi_pass php;
    }

    location / {
        try_files $uri $uri/ /index.html;
    }
}
