# Startlens

![startlens_preview1](https://user-images.githubusercontent.com/42575165/106090819-685aa580-616e-11eb-8a6f-a19f471e2226.png)

## サイト概要

オンラインから観光地を検索し写真を閲覧することで擬似的に観光ツアーを体験できるアプリです。

### サイトテーマ

2020年オンラインからはじまる新しい旅

### テーマを選んだ理由

コロナ化の旅行者数減少の中で、観光事業者（以下、事業者）にとってはafterコロナに向けてwithコロナ期にどのような対策を取るのかが非常に重要となってきます。
またオンライン観光ツアーを利用するユーザー（以下、ユーザー）にとっても旅行等の移動が制限されている中で、擬似的にでも観光を体験したいニーズはより深まっていくだろうと想定してます。
そこで、事業者が写真及び説明文を投稿し、それをユーザーが閲覧することで擬似的な観光をオンライン上で行い、afterコロナ後に再び観光への移動を促進するために少しでも役に立てればとの想いで制作しています。
また、事業者側のダッシュボードではユーザーの訪問履歴とその属性データをチャートで閲覧することが可能となっています。これは、観光産業が「おもてなし」だけではなく、データを利用したマーケティング戦略を立案する土壌を作り、世界の観光産業の中でいかに日本の観光産業が競争力を高め訪日客を誘致できるかを考える一歩になれば良いと考えています。

### ターゲットユーザ

* 事業者

日本全国各地の観光事業者

* ユーザー

10~40代の旅行好きな層

### 主な利用シーン

Instagramはユーザー同士が写真を投稿し楽しむことが利用用途であるが、観光地ごとに情報や写真がまとまっていない。
また最近はオンライン観光ツアーを旅行会社が企画しているが、マネタイズがしやすい企画やプロジェクトベースである。
そこで本アプリでは、ユーザーが場所、カテゴリー、スポット名で検索しお気に入りの事業者を見つけ、写真や観光ガイド（文字情報）を閲覧することを想定している。
一方で事業者側は観光地としてアピールしたい写真や説明文を投稿しユーザーを惹きつける広告とできる。また、ダッシュボードで訪問したユーザー数やその属性をチャートで閲覧できマーケティング戦略に役立てることができる。


## 機能一覧
<https://docs.google.com/spreadsheets/d/1ZkRBoDHrSGZKMspNmfvi_UQZ5BktbQoqcuUHHUlB8IQ/edit?usp=sharing>

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

## 使用素材
- [Unsplash](https://unsplash.com/)
