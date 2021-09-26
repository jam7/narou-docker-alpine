# narou-docker-alpine
A docker container to run narou as a host user.

## Prerequisite

Need to install docker.

## Install

Download container and run it to generate kindlegen script.

```
$ docker pull jam7/narou
$ docker run --rm jam7/narou > narou
$ chmod a+x narou
```

Don't add `-ti` to `docker run`.  Otherwise, your narou script may contains
crlf.

Run a generated script to download AozoraEpub3 to `$HOME/.narou/AozoraEpub3*`
and initialize environment for narou.rb.

```
$ ./narou list
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   632  100   632    0     0   2202      0 --:--:-- --:--:-- --:--:--  2209
100 4765k  100 4765k    0     0  5719k      0 --:--:-- --:--:-- --:--:-- 9845k
.narou/ を作成しました
小説データ/ を作成しました
------------------------------
AozoraEpub3の設定を行います
                            !!!WARNING!!!
AozoraEpub3の構成ファイルを書き換えます。narouコマンド用に別途新規インストールしておくことをオススメします

(次のファイルを書き換えました)
/opt/narou/AozoraEpub3-1.1.1b9Q/chuki_tag.txt

(次のファイルをコピーor上書きしました)
/opt/narou/AozoraEpub3-1.1.1b9Q/AozoraEpub3.ini
/opt/narou/AozoraEpub3-1.1.1b9Q/template/OPS/css_custom/vertical_font.css
AozoraEpub3の設定を終了しました
初期化が完了しました！
現在のフォルダ下で各種コマンドが使用出来るようになりました。
まずは narou help で簡単な説明を御覧ください。
device を kindle に設定しました
端末をKindleに指定したことで、以下の関連設定が変更されました
  → default.enable_half_indent_bracket が true に変更されました

$
```

## How to use it

Use a generated narou script.  All downloaded data is stored at
$HOME/.narou.

```
$ narou d https://ncode.syosetu.com/n6813gp/
```

### How to send mobi to kindle

From WSL2, perform mount first.

```
$ sudo mkdir -p /mnt/Kindle
$ sudo mount -t drvfs d:/ /mnt/Kindle
```

Then, use `narou send`.

```
$ narou send
```

Unmount them.  It is required to run umount three times on Ubuntu-20.04 with
WSL2.

```
$ sudo umount d:/
$ sudo umount d:/
$ sudo umount d:/
$ sudo umount d:/
umount: d:/: no mount point specified.
```

### Run as web service (not tested recently)

Use `docker run -p IP-ADDRESS:8000-8001:8000-8001 narou web -p 8000 -n`.
The narou.rb uses sepecified port 8000 for web server and +1 port 8001
for push_server.

## How to convert old data

From v1.14, narou-docker changes to run as a host user.  So, it is required
to chown $HOME/.narou to a host user is required.  Old narou-docker runs as
a root user.

```
$ sudo chown -R `id -u`:`id -g` $HOME/.narou
```

## Build

In order to build image by yourself, perform `make`

```
$ make
```

## License

@ 2017-2021 Kazushi (Jam) Marukawa, All rights reserved.

This project including all of its source files is released under the terms of [GNU General Public License (version 3 or later)](http://www.gnu.org/licenses/gpl.txt)

## Related projects

narou.rb is in https://github.com/whiteleaf7/narou.
