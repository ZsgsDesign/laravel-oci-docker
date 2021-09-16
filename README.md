# laravel-oci-docker

Laravel OCI Docker is a customized version of bitnami laravel docker image, providing additional support for oracle database connenction. 

## Notable Changes

Rewrite `app-entrypoint.sh` because Oracle 11g databse don't give a response and original `wait_for_db` function would timeout. Also because `wait_for_db` is disabled, we added a `initialized.sem` to skip database migration. You can run `php artisan migrate` manually.

Install packages `autoconf`, `build-essential`, `gcc`, `vim` and `libaio*`.

Change package mirror to `mirrors.aliyun.com`.

## Compile Image Manually

If you want to compile this image on your computer, download instantclient12_1 from Oracle website. We don't include this because Oracle requires you, as a independent user, to accept their user agreement.

Files you need to download are:

- instantclient-basic-linux.x64-12.1.0.2.0.zip
- instantclient-sdk-linux.x64-12.1.0.2.0.zip

Then you just unzip them to `instantclient_12_1`, no extra wrapping folders.

To check that, just open `instantclient_12_1` folder, see if there exist `libocci.so.12.1` file and `sdk` folder.