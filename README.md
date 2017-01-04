This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation


## messagesテーブル
|column   |type      |option   |
|:--------|:---------|:--------|
|body     |text      |         |
|image    |string    |         |
|group_id |integer   |NOT NULL |
|user_id  |integer   |NOT NULL |


## groupsテーブル
|column   |type      |option                |
|:--------|:---------|:---------------------|
|name     |string    |NOT NULL & add_index  |


## usersテーブル
|column   |type      |option                |
|:------- |:---------|:---------------------|
|name     |string    |NOT NULL & add_index  |
|email    |string    |NOT NULL & unique true|
|password |string    |NOT NULL              |


## groups_usersテーブル
|column   |type     |option                           |
|:--------|:--------|:--------------------------------|
|group_id |integer  |NOT NULL & t.references :groups  |
|user_id  |integer  |NOT NULL & t.references :users   |



* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
