if [ $# -eq 0 ]
  then
    echo "Replacing back the original credentials"
    mv ~/.aws/credentials.orig ~/.aws/credentials
    cat ~/.aws/credentials
    exit
fi
aws sts assume-role --role-arn arn:aws:iam::$1:role/SSO-Administrator --role-session-name tmp-session >tmp-session.json
mv -n ~/.aws/credentials ~/.aws/credentials.orig
echo "[default]" >~/.aws/credentials
echo "aws_access_key_id        = $(cat tmp-session.json | jq -r .Credentials.AccessKeyId)" >>~/.aws/credentials
echo "aws_secret_access_key    = $(cat tmp-session.json | jq -r .Credentials.SecretAccessKey)" >>~/.aws/credentials
echo "aws_session_token        = $(cat tmp-session.json | jq -r .Credentials.SessionToken)" >>~/.aws/credentials
echo "x_principal_arn          = $(cat tmp-session.json | jq -r .AssumedRoleUser.Arn)" >>~/.aws/credentials
echo "x_security_token_expires = $(cat tmp-session.json | jq -r .Credentials.Expiration)" >>~/.aws/credentials
rm tmp-session.json
echo "Assumed creds placed in"
cat ~/.aws/credentials
