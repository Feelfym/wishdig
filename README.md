# アプリケーション名

WishDig

# アプリケーション概要

ほしいものリストを作成しながら、それぞれのアイテムについて深掘りをすることで
より満足度の高い、ゆたかな買い物を目指す。

## URL

https://wish-dig.onrender.com

## テスト用アカウント

- メールアドレス：test@test
- パスワード：test1234

## 利用方法

### ユーザー登録

- 名前
- メールアドレス
- パスワード
- パスワード（確認用）

以上を入力しサインアップする。

### ユーザーログイン

- サインアップ後は、自動でログイン済みになる
- 2 回目以降は、メールアドレスとパスワードを入力しログインする

### アイテムを登録する

- 初回ログイン時（初回アイテム作成前）は、オンボーディング画面に遷移する。
- トップ画面からは、画面下部の「＋新規アイテム」ボタンまたは、
- ヘッダーメニューの「メニュー＞新規アイテムを登録」からアイテム新規登録画面へ遷移する。

### アイテムの追加

- アイテム登録画面では、以下の内容を登録する。

  - 画像（任意）
  - アイテムの名称（必須）
  - アイテムの説明・購入理由（必須）
  - 価格（必須）
  - 購入予定日（任意）
  - 商品 URL（任意）

- 入力が完了したら、「作成」ボタンをクリックして登録する。

### アイテムの詳細閲覧、メモの添付

- アイテム一覧画面から、各アイテムの「詳細」画面に遷移する。
- 詳細画面では、アイテムごとにメモをつけることができる。

### メモの作成・削除方法

- メモを作成するには、テーマを必ず選択する必要がある。
- 選択したテーマに沿って、メモを入力する。
- 入力したら「メモを追加」をクリックすることで保存される。
- 保存したメモを削除したい場合は、メモカードの右上にあるｘボタンをクリックする。

### アイテムの編集

- アイテム一覧画面
- アイテム詳細画面
- 比較詳細画面
  上記いずれかの画面で「編集」ボタンをクリックすることで、アイテムを編集できる。

### アイテムの削除

- アイテム一覧画面
- アイテム詳細画面
- 比較詳細画面
  上記いずれかの画面で「編集」ボタンをクリックすることでアイテムを編集できる。

### アイテムを購入済みにする

- アイテム一覧画面または詳細画面から、アイテムを購入済みに変更できる。
- 変更した日付を自動的に取得し、「purchase_date」に保存する。

### アイテム同士を比較する

- メニュー＞比較する＞新しい比較を作成 のページから、アイテムを 2 つ選んで比較ページを作成できる。
  - このとき同じ比較は複数つくることができず、つくった場合はすでに存在する比較ページへ遷移する。
- 比較の詳細ページでは、任意の比較ポイントについてメモを追加することができる。

### 比較を削除する

- アイテムを削除すると、比較も削除される

## アプリケーションを制作した背景

- [問題提起] SNS を中心にインフルエンサーマーケティングが横行している。
  - 皆が同じような商品情報に触れて「なんか良さそう」と刺激を受け、本当に自分が必要としているもの・欲しいものをわからずに買い物をしてしまっている。
  - インフルエンサーの SNS コメントには「〇〇か XX、どっちを買ったほうがいいですか？」などという相談が無数に寄せられている。
  - 自分で製品について調べ、考えて買い物をする思考体力が落ちていると感じた。
- きっかけとなった体験
  - あるとき自分の買い物について、「〇〇だから買ったんです」「XX と比較して、ここが自分にとって必要だったから、〇〇を選んだんです」という話をした
  - すると、「そんなに考えて買い物をしているんですね」と言ってもらえた -「自分の買い物スタイルは、一定の熟慮にもとづいて、根拠をもって行っていた」ことに気づいた
  - そこで、自分が吟味・熟慮のうえ買い物する際のフレームワークをアプリに落とし込むと面白いのではないか？と感じたため、ほしいものリストを中心に「しっかり考えて買い物をする」ことをサポートするアプリを開発することにした。

## 実装した機能

- ユーザー管理機能
  - 登録
  - ログイン
  - 削除
- アイテム管理機能
  - アイテム新規登録
  - ほしいもの一覧
  - 買ったもの一覧
  - アイテム詳細画面
  - アイテム編集
  - アイテム削除
- アイテムごとにメモを追加・削除する機能
  - あらかじめ用意されたテーマから選んでメモを記入する
- ほしいもの一覧画面
  - 未購入アイテムの購入予定月ごとにフィルタし、該当月の総額を表示する機能
  - アイテムを購入済みにし、買ったものリストに入れる機能
- 買ったもの一覧画面
  - 買ったものリストの購入月ごとにフィルタし、総額を表示する機能
- 商品の比較機能
  - 2 つのアイテムを選んで比較できる機能
  - 2 つのアイテムについて、任意のタイトルをつけたメモができる機能
  - 選択した 2 つのアイテムについて、その順番を問わず、すでに作成済みの比較がある場合は比較の作成をスキップし、既存の比較画面に遷移する機能

## 実装予定の機能

- 各アイテムから、そのアイテムが参加している比較ページへ遷移できる機能
- 各アイテムについて比較ページで記述した項目を、アイテム詳細画面で閲覧できる機能

## DB 設計

[![Image from Gyazo](https://i.gyazo.com/fa8864d205a3ce541eaf293281c45ca6.png)](https://gyazo.com/fa8864d205a3ce541eaf293281c45ca6)

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

- has_many :items, dependent: :destroy

## items テーブル

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

### association

- belongs_to :user
- has_many :memos, dependent: :destroy
- has_one_attached :image

## memos テーブル

| column     | type     | options                                 |
| ---------- | -------- | --------------------------------------- |
| id         | bigint   | null:false, primary_key, auto_increment |
| content    | text     | null:false                              |
| item_id    | int      | null:false                              |
| created_at | datetime | null:false                              |
| updated_at | datetime | null:false                              |
| title_id   | int      | null:false                              |

### association

- belongs_to :title
- belongs_to :item

## comparisons テーブル

| column            | type     | options                                 |
| ----------------- | -------- | --------------------------------------- |
| id                | bigint   | null:false, primary_key, auto_increment |
| primary_item_id   | integer  | null:false                              |
| secondary_item_id | integer  | null:false                              |
| created_at        | datetime | null:false                              |
| updated_at        | datetime | null:false                              |

### association

- belongs_to :primary_item, class_name: 'Item', foreign_key: 'primary_item_id'
- belongs_to :secondary_item, class_name: 'Item', foreign_key: 'secondary_item_id'
- has_many :notes, dependent: :destroy

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

### association

- belongs_to :comparison

## 画面遷移図

[![Image from Gyazo](https://i.gyazo.com/d2f05231f785a94da20a2cd42920d497.png)](https://gyazo.com/d2f05231f785a94da20a2cd42920d497)

## 開発環境

- Bootstrap 4.3
- Ruby 3.2.0
- Ruby on Rails 7

## ローカルでの動作方法

- git clone
- bundle install

## 工夫したポイント

- ユーザー体験を意識して、画面遷移に違和感がないように注意しました。

  - たとえば、詳細画面 → 編集画面 → 確定すると詳細画面に戻り、一覧画面 → 編集 → 確定すると一覧画面に戻るといった動作です。
  - 自分が使っていてできるだけ違和感がないように、細かい動作を実現するための方法を調べて実装しました。
  - また、できるだけ色数を少なくシンプルなデザインに抑えるようにしました。
  - Bootstrap はデフォルトでは色がついた濃いめのボタンができますが、ボタンをアウトラインだけのデザインにするなど、基本的にさっぱりしたデザインにするよう心がけました。

- メインの機能である欲しいものの掘り下げについて、あえてユーザが自分でテーマを決めるのではなくデフォルトでセットされているテーマにそって書くことで、一定の縛りを設けて思考を深めることを意識しました。
- 自由ではないメモだからこそ、深掘りする助けになると考えました。

## 制作時間

およそ 2 週間（50 時間）
