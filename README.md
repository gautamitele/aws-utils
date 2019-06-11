# aws-utils
Random AWS Utilities to make CLI life easier

## assume-cross-account-aws-role.sh
Makes it a little bit easier to assume into cross account roles from CLI. Can be easily modified to assume roles within the same account. Assumes the role name to be SSO-Administrator
Takes one argument which is the account number. When run without arguments, it replaces the original creds file
