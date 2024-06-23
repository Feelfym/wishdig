# アプリケーション名

WantsApp

# アプリケーション概要

ほしいものリストを作成しながら、それぞれのアイテムについて深掘りをすることで
より満足度の高い、ゆたかな買い物を目指す。

## URL

https://wantsapp-40422.onrender.com/

## テスト用アカウント

## 利用方法

### ユーザー管理

#### ユーザー登録

#### ユーザーログイン

### アイテムを登録する

#### アイテムの追加

#### アイテムの編集

#### アイテムの削除

#### アイテムを購入済みにする

### アイテム同士を比較する

#### 比較するアイテムを選択する

#### 比較項目を追加し、メモを記述する

#### 比較を削除する

アイテムを削除すると、比較も削除される

## アプリケーションを制作した背景

SNS を中心にインフルエンサーマーケティングが横行している。

皆が同じような商品に触れて、本当に自分が必要としているもの・欲しいものをわからずに買い物をしてしまっている。

インフルエンサーの SNS コメントには「〇〇か XX、どっちを買ったほうがいいですか？」などという相談が無数に寄せられている。自分で製品について調べ、考えて買い物をする思考体力が落ちていると感じた。

そんな中で、自分の買い物について「〇〇だから買った」「XX と比較して、ここが自分にとって必要だったから、〇〇を選んだ」というような話をしたところ、「そんなに考えて買い物をしているんですね」と言われたことで、自分の買い物スタイルがそれなりの熟慮にもとづいて行われていたことに気づいた。

そこで、自分が吟味・熟慮のうえ買い物する際のフレームワークをアプリに落とし込むと面白いのではないか？と感じ、ほしいものリストを中心に「しっかり考えて買い物をする」ことをサポートするアプリを開発することにした。

# 実装した機能

## ユーザー登録・ログイン・削除機能

## アイテム（ほしいもの）の登録・一覧・編集・削除

## アイテムごとに、テーマを選択してメモを追加・削除する機能

## 未購入アイテムの購入予定月ごとにフィルタし、総額を表示する機能

## アイテムを購入済みにし、買ったものリストに入れる機能

## 買ったものリストの購入月ごとにフィルタし、総額を表示する機能

### アイテムを比較し、任意の項目についてメモができる機能

## 実装予定の機能

### 各アイテムから、そのアイテムが参加している比較ページへ遷移できる機能

### 各アイテムについて比較ページで記述した項目を、アイテム側で持ち回れる機能

# DB 設計

## users テーブル

| column             | type     | options                                 |
| ------------------ | -------- | --------------------------------------- |
| id                 | bigint   | null:false, primary_key, auto_increment |
| email              | varchar  | null:false                              |
| encrypted_password | varchar  | null:false                              |
| created_at         | datetime | null:false                              |
| updated_at         | datetime | null:false                              |
| name               | varchar  | null:false                              |

### association

has_many:items
has_many:memos

### items テーブル

| column             | type     | options                                 |
| ------------------ | -------- | --------------------------------------- |
| id                 | bigint   | null:false, primary_key, auto_increment |
| name               | string   | null:false                              |
| description        | text     | null:false                              |
| price              | integer  | null:false                              |
| created_at         | datetime | null:false                              |
| updated_at         | datetime | null:false                              |
| will_purchase_date | date     | null:true                               |
| url                | string   | null:true                               |
| user_id            | integer  | null:false                              |
| purchased_flag     | boolean  | null:false, default:0                   |
| purchased_date     | date     | null:true                               |

### memos テーブル

| column     | type     | options                                 |
| ---------- | -------- | --------------------------------------- |
| id         | bigint   | null:false, primary_key, auto_increment |
| content    | text     | null:false                              |
| user_id    | int      | null:false                              |
| item_id    | int      | null:false                              |
| created_at | datetime | null:false                              |
| updated_at | datetime | null:false                              |
| title_id   | int      | null:false                              |

## comparisons テーブル

| column            | type     | options                                 |
| ----------------- | -------- | --------------------------------------- |
| id                | bigint   | null:false, primary_key, auto_increment |
| primary_item_id   | integer  | null:false                              |
| secondary_item_id | integer  | null:false                              |
| created_at        | datetime | null:false                              |
| updated_at        | datetime | null:false                              |

## notes テーブル

| column          | type     | options                                 |
| --------------- | -------- | --------------------------------------- |
| id              | bigint   | null:false, primary_key, auto_increment |
| comparison_id   | bigint   | null:false                              |
| attribute_name  | varchar  | null:false                              |
| primary_value   | varchar  | null:false                              |
| secondary_value | varchar  | null:false                              |
| created_at      | datetime | null:false                              |
| updated_at      | datetime | null:false                              |

## 画面遷移図

## 開発環境

## ローカルでの動作方法

## 工夫したポイント

## 改善点

## 制作時間

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
