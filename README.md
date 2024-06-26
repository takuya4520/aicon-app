![aicon-app](app/assets/images/og_image.png)
## ■ サービス名
### [A.Icon（ええアイコン）](https://www.aicon-app.com/)
ゲストログインでお試しいただくことができます。

## ■ サービス概要
A.IconはSNSなどのアイコンを何にしようか迷っている、困っている方向けのサービスになります。誰でも手軽にオリジナルアイコンを作成(AI画像生成)する機能に加え、他の方々がどのようなアイコンを使っているか確認することができます。
A.Iconは、あなたの「これだ！」と思えるアイコン作成をお手伝いします。もっと自分らしいアイコンを、一緒に見つけましょう。

## ■ このサービスへの思い・作りたい理由
SNSのプロフィールを新しく設定する際、どのアイコンを選ぶかで迷う経験は、皆さんにとってもあるのではないでしょうか。  
私もその一人です。「Xは仕事です」この一言で新しくアカウントを作成しましたが、顔となるアイコンを長く悩んだ末よくわからないパンダの写真に決めてしまっていました。
このような悩みを多くの人が持っていると気づき、「もっと手軽に、自分らしい」アイコンにすることができたらいいなと思いこのサービスの開発をしようと考えました。

## ■ サービスの差別化ポイント・推しポイント
画像生成系のサービスはすでに多く存在(代表例：[canva](https://www.canva.com/ja_jp/))していますが、以下の点で差別化をしております。

### ・円形のアイコンに特化した画像生成
A.Iconは、SNSプロフィール画像などで頻繁に使用される円形のアイコン作成に特化しています。この特化により、ユーザーはSNS用のアイコンを手軽に、かつ迅速に作成することができます。さらに、SNSで使われるアイコンに向いている複数のテイストの中から選ぶことができます。

### ・みんなのアイコン一覧を通じたアイデアの共有
A.Iconには、他のユーザーが作成したアイコンを見ることができる「みんなのアイコン一覧」機能があります。この機能を通じて、ユーザーは他人のアイコンから新しいアイデアを得ることができます。

## ■ 機能紹介

|トップ画面| ログイン画面 |
|:-:|:-:|
|![Image from Gyazo](https://gyazo.com/d93dc62b096d0b42019aabda69fb64bd.png)|![Image from Gyazo](https://gyazo.com/475686868faed3aaf28b75be98bb4a97.png)|
|登録せずにサービスをお試しいただくためのゲストログイン機能を実装しました。|ログインIDとパスワードでの認証機能を実装しました。|

|アイコン生成| アイコン保存 |
|:-:|:-:|
|![Image from Gyazo](https://gyazo.com/d03ea7b56dcda279b1c050e098196e00.png)|![Image from Gyazo](https://gyazo.com/6083d70124a026fc4aa2bd828260023f.png)|
|自分の好みのテイストやキーワードを入力することで生成AIがアイコンを生成します。|過去使用していたアイコンや今後使いたいアイコンを保存しておくことができる機能を実装しました。|

|アイコン詳細|マイページ|
|:-:|:-:|
|![Image from Gyazo](https://gyazo.com/5081f879606d882bc4cfd20bd795ab97.png)|![Image from Gyazo](https://i.gyazo.com/515eae4776d24962003841766b601d44.png)|
|生成したアイコンの詳細表示機能を実装しました。公開/非公開設定やシェア機能があります。|マイページ内で自身が生成したアイコンや保存したアイコンを確認することができます。|

|みんなのアイコン一覧|お気に入りアイコン一覧|
|:-:|:-:|
|![Image from Gyazo](https://i.gyazo.com/c67140393aafbf52fa351072f19277a0.jpg)|![Image from Gyazo](https://i.gyazo.com/289b7638d22304c2cc7039c811ca6fee.jpg)|
|他ユーザーの公開中のアイコンを見ることができる機能です。テイスト・キーワードで検索ができます。|お気に入り登録したアイコンを一覧で見ることができる機能です。|

## ■今後の開発
### テスト(RSpec)
メンテナンス性や品質面の向上を目指し、リファクタリングやRSpec等のテストを追加していく予定です。


## ■使用技術
|カテゴリ|技術|
|:-------------|:------------|
|開発環境|Docker|
|使用言語|Ruby 3.2.2/Rails 7.0.8/JavaScript|
|ライブラリ|MiniMagick|
|データベース|PostgreSQL|
|インフラ| Render|
|Web API|OpenAI API/Vision API|
|その他|amazon S3/Tailwindcss/daisyUI|

## ■ER図
```mermaid
erDiagram
    USERS {
        int user_id PK "ユーザーID"
        string name "名前"
        string email "メールアドレス"
        string crypted_password "暗号化パスワード"
        string salt "ソルト"
        string icon_url "アイコン"
        int role "管理権限"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    POST_ICONS {
        int id PK "投稿アイコンID"
        int user_id FK "ユーザーID"
        string title "タイトル"
        string icon_url "アイコン"
        int publicity_status "公開設定"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    CREATED_ICONS {
        int id PK "作成アイコンID"
        int user_id FK "ユーザーID"
        int taste_id FK "テイストID"
        string icon_url "アイコン"
        string keyword "キーワード"
        datetime created_at "作成日"
    }

    POST_ICON_LIKES {
        int user_id FK "ユーザーID"
        int post_icons_id FK "投稿アイコンID"
    }

    CREATED_ICON_LIKES {
        int user_id FK "ユーザーID"
        int created_icons_id FK "作成アイコンID"
    }

    USERS ||--o{ POST_ICONS : "posts"
    USERS ||--o{ CREATED_ICONS : "creates"
    USERS ||--o{ POST_ICON_LIKES : "likes"
    USERS ||--o{ CREATED_ICON_LIKES : "likes"

    POST_ICONS ||--o{ POST_ICON_LIKES : "liked by"
    CREATED_ICONS ||--o{ CREATED_ICON_LIKES : "liked by"

```

## ■画面遷移図(初期のままです)
[画面遷移図](https://www.figma.com/file/r1CkCJNq8dRtqha5bFirlU/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0-1&mode=design&t=7wbMxzTMZGb3KW1S-0)
