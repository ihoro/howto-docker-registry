# Docker Registry @ ubuntu


## 0. The server

* this example is based on DigitalOcean Docker 1.12.6 @ ubuntu 16.04
* and it expects you have domain name for the host


## 1. Create registry container

```bash
$ ./create.sh
```


## 2. Prepare nginx as HTTPS in front

```bash
$ apt install nginx letsencrypt
$ service nginx stop
$ service ufw stop # or disable it completely with 'ufw disable'
$ letsencrypt certonly # use your email and domain name(s)
$ rm /etc/nginx/sites-enabled/default
$ sed -i 's/CUSTOM_DOMAIN/$YOUR_DOMAIN/g' nginx-site.conf
$ ln -s $PWD/nginx-site.conf /etc/nginx/sites-enabled/nginx-site.conf
$ service nginx start
```

Check it:
```bash
$ curl -I https://$YOUR_DOMAIN
```


## 3. Optionally add users

It includes simple htpasswd based authentication, and example var-lib-registry/htpasswd file has 'user' account with 'user' passwod.

You can manage user list as follows:
```bash
$ apt install apache2-utils
$ htpasswd -b var-lib-registry/htpasswd new-user with-password
```


## 4. Test it

```bash
$ docker login -u $user -p $password $YOUR_DOMAIN
$ docker pull alpine:3.4
$ docker tag alpine:3.4 $YOUR_DOMAIN/some-context/alpine:3.4
$ docker push $YOUR_DOMAIN/new-user/alpine:3.4
$ docker logout
```


## TODO list

- [ ] TODO: cover letsencrypt renewal setup
- [ ] TODO: cover case with enabled firewall
