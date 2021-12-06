# テーブル定義

|Task|
|------|
|title :string|
|content :text|

# Herokuへのデプロイ手順

#### 環境
+ Ruby3.0.1

+ Rails6.0.3


<br>

1. Herokuに新しいアプリケーションを作成する<br>
```
$ heroku create
```
2. アセットプリコンパイルをする<br>
```
$ rails assets:precompile RAILS_ENV=production
```
3. コミットする<br>
```
$ git add -A
$ git commit -m "init"
```
4. Herokuにデプロイ実行
```
$ git push heroku main
```
5. データベースの移行
```
$ heroku run rails db:migrate
```
6. アプリケーションにアクセス
```
$ heroku open
```