## Docker
※dockerディレクトリへ移動
コマンド => cd docker
`docker-compose up` を実行（-dは任意）

bash shellに入る
`docker-compose exec react bash`でshellに入る


## buildファイルをコピー
docker container ls -a

buildファイルをローカルにコピー
docker cp コンテナID:/react/portfolio/build ../build
