# presigned-url-s3

https://docs.aws.amazon.com/ja_jp/AmazonS3/latest/userguide/using-presigned-url.html

## Create Pre-signed URL
### AWS CLI

CLI経由ではGETメソッドでの署名付きURLのみ発行可能

```
$ echo presign > test.txt
$ aws s3 cp test.txt s3://keinomur/presign/
$ PRESIGNED_URL=$(aws s3 presign s3://keinomur/presign/test.txt --expires-in 60) | echo $PRESIGNED_URL
$ curl $PRESIGNED_URL
presign
```

## Restriction Access with Pre-signed URL
> 署名付きURLはURLを知っている人であれば誰でもアクセス可能なので、それなりにちゃんと管理しないと事故る。
> 流出時の安全策としてネットワークアクセス制限をかけることができる
> https://docs.aws.amazon.com/ja_jp/AmazonS3/latest/userguide/using-presigned-url.html#PresignedUrlUploadObject-LimitCapabilities


Pre-signed URLはURLを発行したプリンシパルでアクセス制御される。

そのため、Conditionを使用した送信元IPアドレスで制御することで、該当IPアドレス以外からのS3オブジェクトへのアクセスを防げる。

※ S3でバケットポリシー（リソースベースポリシー）はアイデンティティベースポリシーと `OR` で評価されるため、誤った設定を入れるとアクセス制御が適切に機能しなくなる。

### 確認手順
1. ssh to ec2
1. create pre-signed url
1. curl pre-signed url from ec2 -> Access allowed
1. curl pre-signed url from a different location than the ec2 -> Access denied

## 雑メモ

- 署名付きURLが発行可能な認証情報は下記3つ
	- IAM インスタンスプロファイル: 最大 6 時間有効。
	* AWS Security Token Service: 最大 36 時間有効 (AWS アカウント ルートユーザーや IAM ユーザーの認証情報など、永続的認証情報を使用して署名した場合)。
	* IAM ユーザー: 最大 7 日間有効 (AWS Signature Version 4 を使用した場合)。最大 7 日間有効の署名付き URL を作成するには、まず、使用する SDK への IAM ユーザー認証情報 (アクセスキーとシークレットキー) を指定します。次に、AWS Signature Version 4 を使用して署名付き URL を生成します。

- 署名付きURL発行時には、「HTTPメソッド」「URLの期限」を設定可能
