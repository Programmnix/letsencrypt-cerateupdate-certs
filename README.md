# Let's encrypt create and renew script
This is a script to create and renew the lets encrypt certificates for a single zimbra server.


Usage:

1. Copy the script on your zimbra server
2. Make the file executable:
  ```
  chmod +x create-and-update-lets-encrypt-cert.sh
  ```
3. Update your zimbra certificates:
  ```
  ./create-and-update-lets-encrypt-cert.sh www.example.tdl max.mustermann@example.com
  ```

This script can be used to create and renew the certs for your domain on your nginx-reverse-proxy: https://github.com/jwilder/nginx-proxy

Feel free to fork this repro. :-)
