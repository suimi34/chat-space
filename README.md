## messagesテーブル
|column   |type      |option   |
|:--------|:---------|:--------|
|body     |text      |NOT NULL |
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


## group_usersテーブル
|column   |type     |option                           |
|:--------|:--------|:--------------------------------|
|group_id |integer  |NOT NULL & t.references :groups  |
|user_id  |integer  |NOT NULL & t.references :users   |

##アソシエーション
user  :has_many :groups, through: :group_users
user  :has_many :messages
group :has_many :users, through: :group_users
group :has_many :messages, through: :user
message :belongs_to :user
message :has_one :group, through: :user


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
