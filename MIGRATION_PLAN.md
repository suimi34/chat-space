# Chat Space リプレイスプラン: Go + Next.js (App Router)

## 目次

1. [現状分析](#現状分析)
2. [アーキテクチャ設計](#アーキテクチャ設計)
3. [技術スタック](#技術スタック)
4. [マイグレーション戦略](#マイグレーション戦略)
5. [実装フェーズ](#実装フェーズ)
6. [リスクと対策](#リスクと対策)

---

## 現状分析

### システム概要

- **種別**: リアルタイムチャットアプリケーション
- **現行技術**: Ruby on Rails 5.2
- **インフラ**: Google Cloud Run, Cloud Storage
- **主要機能**:
  - ユーザー認証 (Devise)
  - チャットグループ管理
  - メッセージ送信（テキスト・画像）
  - インクリメンタル検索
  - リアルタイム自動更新

### データモデル

```
users
├── name (string, NOT NULL)
├── email (string, unique)
└── password (encrypted)

chat_groups
├── name (string, NOT NULL)
└── has_many messages, users through group_users

group_users (中間テーブル)
├── group_id
└── user_id

messages
├── body (text, NOT NULL)
├── image (string, GCS path)
├── group_id
├── user_id
└── created_at
```

### 主要コントローラー

1. **UsersController**: ユーザー検索
2. **ChatGroupsController**: グループ CRUD
3. **MessagesController**: メッセージ送受信、画像アップロード

### フロントエンド

- HAML + SCSS
- jQuery (Ajax, インクリメンタル検索)
- 自動更新機能 (ポーリング)

### ストレージ

- Google Cloud Storage (画像保存)
- 署名付き URL 生成

---

## アーキテクチャ設計

### 全体構成

```
┌─────────────────────────────────────────────┐
│          Next.js (App Router)               │
│  ┌─────────────┐  ┌────────────────────┐   │
│  │   Pages     │  │  Server Components │   │
│  │   /chat     │  │  /api/auth/[...]   │   │
│  │   /groups   │  │                    │   │
│  └─────────────┘  └────────────────────┘   │
│           ↓                ↓                │
│     Client Actions    Route Handlers       │
└──────────────┬──────────────┬──────────────┘
               │              │
               ↓              ↓
    ┌──────────────────────────────────┐
    │      Go Backend API Server       │
    │  ┌────────────────────────────┐  │
    │  │  Gin/Echo Web Framework    │  │
    │  ├────────────────────────────┤  │
    │  │  RESTful API + WebSocket   │  │
    │  ├────────────────────────────┤  │
    │  │  JWT Authentication        │  │
    │  ├────────────────────────────┤  │
    │  │  Business Logic Layer      │  │
    │  ├────────────────────────────┤  │
    │  │  Repository Pattern        │  │
    │  └────────────────────────────┘  │
    └───────────┬──────────────────────┘
                │
    ┌───────────┴───────────┬────────────────┐
    ↓                       ↓                ↓
┌─────────┐         ┌──────────────┐   ┌─────────┐
│  MySQL  │         │ Google Cloud │   │  Redis  │
│         │         │   Storage    │   │ (Cache) │
└─────────┘         └──────────────┘   └─────────┘
```

---

## 技術スタック

### フロントエンド

- **フレームワーク**: Next.js 15+ (App Router)
- **言語**: TypeScript
- **UI ライブラリ**: Tailwind CSS + shadcn/ui
- **状態管理**: Zustand または Jotai
- **リアルタイム通信**: WebSocket (Socket.io Client / native WebSocket)
- **フォーム管理**: React Hook Form + Zod
- **画像処理**: Sharp (Next.js 組み込み)

### バックエンド

- **言語**: Go 1.22+
- **Web フレームワーク**: Gin または Echo
- **ORM**: sqlx + squirrel (または GORM)
- **認証**: JWT (golang-jwt/jwt)
- **WebSocket**: gorilla/websocket または nhooyr.io/websocket
- **バリデーション**: go-playground/validator
- **画像処理**: go-cloud (GCS 統合)
- **ロギング**: zerolog または zap

### データベース・インフラ

- **DB**: MySQL 8.0+
- **キャッシュ**: Redis (セッション、リアルタイム状態)
- **ストレージ**: Google Cloud Storage
- **コンテナ**: Docker + Docker Compose
- **CI/CD**: GitHub Actions
- **デプロイ**: Cloud Run (既存と同じ)

---

## マイグレーション戦略

### アプローチ: ストラングラーパターン

段階的に新システムへ移行し、リスクを最小化

```
Phase 1: 並行開発・検証
  Rails (既存) ← 本番トラフィック 100%
  Go + Next.js (新規) ← テスト環境

Phase 2: 一部機能移行
  Rails (既存) ← 80%
  Go + Next.js (新規) ← 20% (読み取り専用API)

Phase 3: 完全移行
  Go + Next.js (新規) ← 100%
  Rails (既存) → 廃止
```

---

## 実装フェーズ

### Phase 0: 準備・設計 (2 週間)

- [ ] 詳細設計書作成
- [ ] API 仕様書作成 (OpenAPI 3.0)
- [ ] データベース設計レビュー
- [ ] 開発環境構築 (Docker Compose)
- [ ] リポジトリセットアップ

### Phase 1: バックエンド基盤構築 (3 週間)

#### Week 1: プロジェクト初期化

```bash
backend/
├── cmd/
│   └── api/
│       └── main.go
├── internal/
│   ├── domain/          # ドメインモデル
│   ├── repository/      # データアクセス層
│   ├── service/         # ビジネスロジック
│   ├── handler/         # HTTPハンドラー
│   └── middleware/      # 認証・ログ等
├── pkg/
│   ├── auth/           # JWT
│   └── storage/        # GCS
├── migrations/         # DBマイグレーション
└── docker-compose.yml
```

**実装項目**:

- [ ] プロジェクト構造作成
- [ ] MySQL 接続設定
- [ ] マイグレーションツール導入 (golang-migrate)
- [ ] 基本 CRUD 操作実装 (User, ChatGroup, Message)
- [ ] ヘルスチェックエンドポイント

#### Week 2-3: 認証・コア機能

- [ ] JWT 認証実装
  - サインアップ
  - ログイン
  - トークン検証ミドルウェア
- [ ] User API
  - ユーザー検索 (インクリメンタル検索)
  - プロフィール取得・更新
- [ ] ChatGroup API
  - グループ作成・編集・削除
  - メンバー管理
  - 一覧取得
- [ ] Message API
  - メッセージ送信
  - メッセージ一覧取得 (ペジネーション)
  - 画像アップロード (GCS)
- [ ] WebSocket 実装
  - 接続管理
  - リアルタイムメッセージ配信
  - ルームベースブロードキャスト

**Go コードサンプル (ディレクトリ構造)**:

```go
// internal/domain/user.go
type User struct {
    ID        int64     `db:"id"`
    Name      string    `db:"name"`
    Email     string    `db:"email"`
    Password  string    `db:"password"`
    CreatedAt time.Time `db:"created_at"`
}

// internal/handler/auth.go
type AuthHandler struct {
    authService service.AuthService
}

func (h *AuthHandler) SignUp(c *gin.Context) {
    var req SignUpRequest
    if err := c.ShouldBindJSON(&req); err != nil {
        c.JSON(400, gin.H{"error": err.Error()})
        return
    }
    // ... 認証ロジック
}

// internal/handler/websocket.go
type Hub struct {
    clients    map[int64]map[*Client]bool // groupID -> clients
    broadcast  chan *Message
    register   chan *Client
    unregister chan *Client
}
```

### Phase 2: フロントエンド基盤構築 (3 週間)

#### Week 1: プロジェクト初期化

```bash
frontend/
├── src/
│   ├── app/
│   │   ├── (auth)/
│   │   │   ├── login/
│   │   │   └── register/
│   │   ├── (dashboard)/
│   │   │   ├── groups/
│   │   │   └── chat/[id]/
│   │   ├── api/          # Route Handlers
│   │   ├── layout.tsx
│   │   └── page.tsx
│   ├── components/
│   │   ├── ui/           # shadcn/ui
│   │   ├── chat/
│   │   └── groups/
│   ├── lib/
│   │   ├── api.ts        # API client
│   │   ├── auth.ts       # 認証ヘルパー
│   │   └── websocket.ts  # WebSocket client
│   └── types/
├── public/
└── next.config.js
```

**実装項目**:

- [ ] Next.js App Router プロジェクト作成
- [ ] Tailwind CSS + shadcn/ui セットアップ
- [ ] API client ライブラリ作成 (fetch wrapper)
- [ ] 認証フロー実装
  - ログイン・サインアップフォーム
  - JWT 保存 (httpOnly cookie または localStorage)
  - Protected routes
- [ ] レイアウト作成
  - サイドバー (グループ一覧)
  - ヘッダー (ユーザー情報)

#### Week 2: メイン UI 実装

- [ ] チャットグループ一覧画面
  - グループカード表示
  - 作成・編集モーダル
  - メンバー追加・削除 UI
- [ ] チャット画面
  - メッセージリスト (仮想スクロール対応)
  - メッセージ入力フォーム
  - 画像アップロードプレビュー
  - タイムスタンプ表示
- [ ] ユーザー検索 UI
  - インクリメンタル検索
  - デバウンス処理

#### Week 3: WebSocket 統合

- [ ] WebSocket クライアント実装

```typescript
// lib/websocket.ts
class ChatWebSocket {
  private ws: WebSocket | null = null;

  connect(token: string, groupId: number) {
    this.ws = new WebSocket(
      `ws://localhost:8080/ws?token=${token}&group=${groupId}`
    );

    this.ws.onmessage = (event) => {
      const message = JSON.parse(event.data);
      // Zustandストア更新
      useChatStore.getState().addMessage(message);
    };
  }

  send(message: string, image?: File) {
    // メッセージ送信
  }
}
```

- [ ] リアルタイムメッセージ受信
- [ ] 接続状態管理
- [ ] リコネクション処理

### Phase 3: 統合・テスト (2 週間)

- [ ] E2E テスト (Playwright)
  - ログイン → グループ作成 → メッセージ送信
  - 画像アップロード
  - リアルタイム受信
- [ ] バックエンド単体テスト (Go testing)
- [ ] API ドキュメント生成 (Swagger)
- [ ] パフォーマンステスト
  - 同時接続数
  - メッセージスループット
- [ ] セキュリティ監査
  - XSS 対策
  - CSRF 対策
  - SQL インジェクション対策

### Phase 4: 本番移行 (2 週間)

- [ ] Cloud Run デプロイ設定

```yaml
# cloudbuild.yml
steps:
  # Backend
  - name: "gcr.io/cloud-builders/docker"
    args:
      [
        "build",
        "-t",
        "gcr.io/$PROJECT_ID/chat-backend:$COMMIT_SHA",
        "./backend",
      ]
  - name: "gcr.io/cloud-builders/docker"
    args: ["push", "gcr.io/$PROJECT_ID/chat-backend:$COMMIT_SHA"]

  # Frontend
  - name: "gcr.io/cloud-builders/docker"
    args:
      [
        "build",
        "-t",
        "gcr.io/$PROJECT_ID/chat-frontend:$COMMIT_SHA",
        "./frontend",
      ]
  - name: "gcr.io/cloud-builders/docker"
    args: ["push", "gcr.io/$PROJECT_ID/chat-frontend:$COMMIT_SHA"]

  # Deploy
  - name: "gcr.io/google.com/cloudsdktool/cloud-sdk"
    args:
      - gcloud
      - run
      - deploy
      - chat-backend
      - --image=gcr.io/$PROJECT_ID/chat-backend:$COMMIT_SHA
      - --region=asia-northeast1
```

- [ ] データマイグレーション計画
  - 既存データエクスポート
  - 新 DB インポート検証
- [ ] カナリアリリース (10% → 50% → 100%)
- [ ] モニタリング設定
  - Cloud Monitoring
  - エラー追跡 (Sentry)
- [ ] ロールバック手順確認

---

## 詳細設計

### API エンドポイント設計

#### 認証

```
POST   /api/v1/auth/signup       # ユーザー登録
POST   /api/v1/auth/login        # ログイン
POST   /api/v1/auth/logout       # ログアウト
GET    /api/v1/auth/me           # 現在のユーザー情報取得
```

#### ユーザー

```
GET    /api/v1/users              # ユーザー検索 (q=keyword)
GET    /api/v1/users/:id          # ユーザー詳細
PATCH  /api/v1/users/:id          # ユーザー更新
```

#### チャットグループ

```
GET    /api/v1/groups             # グループ一覧 (自分が所属)
POST   /api/v1/groups             # グループ作成
GET    /api/v1/groups/:id         # グループ詳細
PATCH  /api/v1/groups/:id         # グループ更新
DELETE /api/v1/groups/:id         # グループ削除
POST   /api/v1/groups/:id/members # メンバー追加
DELETE /api/v1/groups/:id/members/:user_id # メンバー削除
```

#### メッセージ

```
GET    /api/v1/groups/:id/messages       # メッセージ一覧 (ペジネーション)
POST   /api/v1/groups/:id/messages       # メッセージ送信
POST   /api/v1/messages/:id/image        # 画像アップロード
```

#### WebSocket

```
WS     /ws?token=<JWT>&group=<group_id>  # WebSocket接続
```

**メッセージフォーマット**:

```json
{
  "type": "message",
  "payload": {
    "id": 123,
    "body": "こんにちは",
    "image": "https://storage.googleapis.com/...",
    "user": {
      "id": 1,
      "name": "太郎"
    },
    "created_at": "2025-10-10T12:34:56Z"
  }
}
```

### データベースマイグレーション

既存のスキーマをほぼ維持し、Go 向けに最適化:

```sql
-- users テーブル (変更なし)
CREATE TABLE users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_name (name),
  INDEX idx_email (email)
);

-- chat_groups テーブル (renamed from groups)
CREATE TABLE chat_groups (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_name (name)
);

-- group_users テーブル (変更なし)
CREATE TABLE group_users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  group_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (group_id) REFERENCES chat_groups(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE KEY unique_group_user (group_id, user_id)
);

-- messages テーブル (変更なし)
CREATE TABLE messages (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  body TEXT NOT NULL,
  image VARCHAR(512),
  group_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (group_id) REFERENCES chat_groups(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_group_created (group_id, created_at DESC)
);
```

### 認証フロー

#### サインアップ

```
Client                  Backend                 DB
  |                        |                     |
  |--- POST /auth/signup ->|                     |
  |    (name, email, pw)   |                     |
  |                        |--- Hash Password -->|
  |                        |--- INSERT User ---->|
  |                        |<-- User ID ---------|
  |                        |--- Generate JWT --->|
  |<-- 201 (token, user) --|                     |
```

#### ログイン

```
Client                  Backend                 DB
  |                        |                     |
  |--- POST /auth/login -->|                     |
  |    (email, password)   |                     |
  |                        |--- SELECT User ---->|
  |                        |<-- User Data -------|
  |                        |--- Verify Password->|
  |                        |--- Generate JWT --->|
  |<-- 200 (token, user) --|                     |
```

#### 認証済みリクエスト

```
Client                  Backend
  |                        |
  |--- GET /api/v1/me ---->|
  |    Header: Authorization: Bearer <JWT>
  |                        |--- Verify JWT ----->|
  |                        |<-- User Claims -----|
  |<-- 200 (user data) ----|
```

### WebSocket フロー

#### 接続確立

```
Client                    Backend (Hub)               Redis
  |                          |                          |
  |-- WS /ws?token=xxx&group=1 ->|                     |
  |                          |--- Verify JWT ---------->|
  |                          |--- Register Client ----->|
  |                          |<-- Subscribe group:1 ----|
  |<-- 101 Switching --------|                          |
```

#### メッセージ送信

```
Client A                   Hub                  Client B (同じグループ)
  |                          |                          |
  |--- Send Message -------->|                          |
  |    {"body": "Hi"}        |                          |
  |                          |--- Save to DB ---------> MySQL
  |                          |--- Publish to group:1 -> Redis
  |                          |--- Broadcast ----------->|
  |                          |                          |
  |<-- Confirmation ---------|                          |
  |                          |                          |
```

---

## パフォーマンス最適化

### バックエンド

1. **データベース**

   - インデックス最適化 (group_id, created_at の複合インデックス)
   - コネクションプール設定 (最大 100 接続)
   - N+1 クエリ対策 (Eager Loading)

2. **キャッシュ戦略**

   - Redis でグループメンバーリストをキャッシュ (TTL: 5 分)
   - メッセージ一覧をキャッシュ (最新 50 件)
   - 画像 URL 署名をキャッシュ (TTL: 1 時間)

3. **WebSocket**
   - Goroutine によるマルチクライアント処理
   - チャネルベースの非同期メッセージング
   - ハートビート (30 秒ごと)

### フロントエンド

1. **レンダリング最適化**

   - Server Components で SEO 対策
   - 動的部分のみ Client Components 化
   - React.memo でメッセージコンポーネント最適化

2. **データフェッチ**

   - SWR または React Query でキャッシュ管理
   - 無限スクロール (react-window)
   - 楽観的更新 (メッセージ送信時)

3. **画像最適化**
   - Next.js Image コンポーネント使用
   - WebP 変換
   - レスポンシブ画像

---

## セキュリティ対策

### 認証・認可

- [ ] JWT の有効期限設定 (15 分 + リフレッシュトークン)
- [ ] HTTPOnly Cookie でのトークン保存
- [ ] CORS 設定 (本番ドメインのみ許可)
- [ ] レート制限 (ログイン: 5 回/分)

### データ保護

- [ ] パスワードハッシュ化 (bcrypt, cost=12)
- [ ] SQL インジェクション対策 (プリペアドステートメント)
- [ ] XSS 対策 (React の自動エスケープ)
- [ ] CSRF 対策 (SameSite Cookie)

### ファイルアップロード

- [ ] ファイルサイズ制限 (最大 10MB)
- [ ] MIME タイプ検証 (image/jpeg, image/png, image/gif)
- [ ] ファイル名サニタイズ
- [ ] ウイルススキャン (Cloud DLP)

---

## モニタリング・ログ

### メトリクス

- **APM**: Go アプリケーションメトリクス
  - リクエスト数、レスポンスタイム
  - エラーレート
  - WebSocket 接続数
- **インフラ**: Cloud Monitoring
  - CPU、メモリ使用率
  - ディスク I/O
  - ネットワーク帯域

### ロギング

```go
// structured logging with zerolog
log.Info().
  Str("user_id", userID).
  Str("group_id", groupID).
  Msg("Message sent")
```

### アラート設定

- エラーレート > 5% で通知
- レスポンスタイム > 3 秒で通知
- WebSocket 切断率 > 10% で通知

---

## リスクと対策

| リスク               | 影響度 | 対策                                            |
| -------------------- | ------ | ----------------------------------------------- |
| データ移行失敗       | 高     | ドライラン 3 回実施、ロールバック計画           |
| パフォーマンス劣化   | 中     | 負荷テスト、カナリアリリース                    |
| WebSocket 接続不安定 | 中     | リコネクション処理、フォールバック (ポーリング) |
| セキュリティ脆弱性   | 高     | セキュリティ監査、依存関係スキャン              |
| スケジュール遅延     | 中     | バッファ期間 2 週間確保、優先度調整             |

---

## タイムライン (全体: 12 週間)

```
Week 1-2:   Phase 0 (準備・設計)
Week 3-5:   Phase 1 (バックエンド基盤)
Week 6-8:   Phase 2 (フロントエンド基盤)
Week 9-10:  Phase 3 (統合・テスト)
Week 11-12: Phase 4 (本番移行)
```

---

## 成功基準

### 機能要件

- [ ] 全既存機能が動作
- [ ] リアルタイムメッセージ配信 (遅延 < 500ms)
- [ ] 画像アップロード成功率 > 99%

### 非機能要件

- [ ] API レスポンスタイム (P95) < 500ms
- [ ] WebSocket 接続維持率 > 95%
- [ ] システム稼働率 > 99.5%
- [ ] 同時接続 1000 ユーザーサポート

### 開発体験

- [ ] CI/CD パイプライン < 10 分
- [ ] ローカル開発環境構築 < 30 分
- [ ] API ドキュメント完備

---

## 追加検討事項

### Phase 5 以降の拡張機能

- [ ] メッセージ検索 (Elasticsearch)
- [ ] ファイル共有 (PDF, Docs)
- [ ] ビデオ通話 (WebRTC)
- [ ] 通知機能 (Push Notifications)
- [ ] メンション機能
- [ ] リアクション機能 (絵文字)
- [ ] メッセージ編集・削除
- [ ] グループ権限管理 (Admin/Member)

### 運用改善

- [ ] 自動バックアップ (日次)
- [ ] ログアーカイブ (90 日保存)
- [ ] A/B テスト基盤
- [ ] ユーザー分析 (Google Analytics)

---

## 参考リソース

### Go

- [Gin Framework](https://gin-gonic.com/)
- [Echo Framework](https://echo.labstack.com/)
- [sqlx](https://github.com/jmoiron/sqlx)
- [golang-jwt](https://github.com/golang-jwt/jwt)

### Next.js

- [Next.js App Router](https://nextjs.org/docs/app)
- [shadcn/ui](https://ui.shadcn.com/)
- [Zustand](https://github.com/pmndrs/zustand)
- [SWR](https://swr.vercel.app/)

### インフラ

- [Cloud Run](https://cloud.google.com/run)
- [Cloud Build](https://cloud.google.com/build)
- [Cloud Storage](https://cloud.google.com/storage)

---

## まとめ

このプランに従い、段階的に Rails 製チャットアプリを Go + Next.js へリプレイスすることで、以下のメリットを享受できます:

1. **パフォーマンス向上**: Go の高速処理、Next.js の最適化されたレンダリング
2. **スケーラビリティ**: Goroutine による効率的な並行処理
3. **開発体験**: TypeScript による型安全性、モダンなツールチェイン
4. **保守性**: クリーンアーキテクチャ、明確な責務分離

リスクを最小化するため、ストラングラーパターンによる段階的移行を採用し、各フェーズでテスト・検証を徹底します。
