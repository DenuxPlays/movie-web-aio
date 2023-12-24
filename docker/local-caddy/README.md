# Local-Caddy

A test setup for using caddy with local https certificates.<br>
**DO NOT USE THIS IN PRODUCTION!!!!!**

This setup uses subdomains to route to different services. The subdomains are defined in the `Caddyfile`.<br>
Please ensure to add the following lines to your `/etc/hosts` (on windows: `C:\Windows\System32\Drivers\etc\hosts`)
file:

```
127.0.0.1 movies.localhost mv-backend.localhost mv-proxy.localhost
```
