# Startlens

![startlens_preview1](https://user-images.githubusercontent.com/42575165/106090819-685aa580-616e-11eb-8a6f-a19f471e2226.png)

## サイト概要

オンラインから観光地を検索し写真を閲覧することで擬似的に観光ツアーを体験できるアプリです。

### アプリケーションコンセプト

2020年オンラインからはじまる新しい旅

### 開発経緯

コロナ化の旅行者数減少の中で、観光事業者（以下、事業者）にとってはafterコロナに向けてwithコロナ期にどのような対策を取るのかが非常に重要となってきます。
またオンライン観光ツアーを利用するユーザー（以下、ユーザー）にとっても旅行等の移動が制限されている中で、擬似的にでも観光を体験したいニーズはより深まっていくだろうと想定してます。
そこで、事業者が写真及び説明文を投稿し、それをユーザーが閲覧することで擬似的な観光をオンライン上で行い、afterコロナ後に再び観光への移動を促進するために少しでも役に立てればとの想いで制作しています。
また、事業者側のダッシュボードではユーザーの訪問履歴とその属性データをチャートで閲覧することが可能となっています。これは、観光産業が「おもてなし」だけではなく、データを利用したマーケティング戦略を立案する土壌を作り、世界の観光産業の中でいかに日本の観光産業が競争力を高め訪日客を誘致できるかを考える一歩になれば良いと考えています。


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

## 使用素材
- [Unsplash](https://unsplash.com/)
