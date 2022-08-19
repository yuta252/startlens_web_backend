# Startlens

![startlens_preview1](https://user-images.githubusercontent.com/42575165/106090819-685aa580-616e-11eb-8a6f-a19f471e2226.png)

## 概要

オンラインから観光地を検索し写真を閲覧することで擬似的に観光ツアーを体験できるアプリです。

## 機能一覧

- JWTトークンによる認証機能
- 複数枚の画像投稿機能
- データベースの多言語対応
- 複数キーワードによる検索機能
- 期間ごとのログ出力
- RSpecテスト

## 開発環境

- Docker
- バックエンド：Ruby on Rails
- フロントエンド：React.js(Redux, TypeScript), Chart.js

## 開発環境の設定

```
$ git clone https://github.com/yuta252/startlens_web_backend.git

# 開発環境用Dockerのビルド
$ docker-compose -f docker-compose-dev.yml build

# 開発用データベースの初期設定
$ docker-compose -f docker-compose-dev.yml exec app bin/rails db:migrate
$ docker-compose -f docker-compose-dev.yml exec app bin/rails db:seed

# 開発用サーバーの起動
$ docker-compose -f docker-compose-dev.yml up -d
```

## 本番環境

- AWS(EKS, RDS, S3, ALB)
- Kubernetes
