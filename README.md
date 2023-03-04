# Zundarb
## バックエンドでサーバーを起動
このコマンドを使用するには、バックグラウンドで 
VOICEVOX のサーバーを起動する必要があります。

```ps1
foreach ($network in Get-NetIPAddress){ if($network.IPAddress -match "^192\.168\."){$hostaddr = $network.IPAddress} }
."${env:userprofile}\AppData\Local\Programs\VOICEVOX\run.exe" --host $hostaddr
```

## インストール
Gem をインストールし、アプリケーションの Gemfile に追加します。

    $ bundle add zundarb

Bundler で依存関係を管理していない場合は、以下のように実行して Gem をインストールしてください。

    $ gem install zundarb

ソースコードからインストールする場合は、以下のコマンドを実行してください。

    $ rake install


## 使用法
    $ zundarb -h

`--sid` は `<IP ADDR>:50021/speakers` を参照してください。

## テスト
以下のコマンドでテストを実行できます。

```bash
bundle exec zundarb ずんだもんなのだ
```

生成された音声は `voice/` に保存されます。

### 使用例
```bash
# ずんだもんノーマル (3)、音量 0.5、速度 1.5
zundarb 生麦生米生卵 --sid 3 --vol 0.5 --speed 1.5
```

## 開発
レポをチェックアウトした後、`bin/setup` を実行して依存関係をインストールします。また、`bin/console`を実行すると、インタラクティブなプロンプトが表示され、実験することができます。

この Gem をローカルマシンにインストールするには、
`bundle exec rake install` を実行します。
新しいバージョンをリリースするには、`version.rb`のバージョン番号を更新し、`bundle exec rake release`を実行します。
このとき、そのバージョンの Git タグが作成され、
Gitコミットと作成したタグをプッシュし、
`.gem`ファイルを [rubygems.org] (https://rubygems.org) へプッシュします。

## 貢献
バグレポートやプルリクエストはGitHubのhttps://github.com/himeyama/zundarbで受け付けています。
