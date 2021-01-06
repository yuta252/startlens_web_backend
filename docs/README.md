## 概要

Startlens webアプリのバックエンドAPI。
APIドキュメントは[こちら](https://startlens-openapi.firebaseapp.com/)をご参照ください。

## 環境

* Ruby: 2.6.6

* Rails: 5.2.4.4


# 開発環境構築

```bash
$ git clone https://github.com/yuta252/startlens_web_backend.git

$ docker-compose -f docker-compose-dev.yml build

$ docker-compose -f docker-compose-dev.yml exec app rails db:migrate

$ docker-compose -f docker-compose-dev.yml up -d
```

