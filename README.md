# PostgreSQL AWS Lambda Layer

An AWS Lambda Layer for Amazon Linux 2023 with PostgreSQL 16.3 and SSL support built-in.

## Description

My use-case was that I wanted to run Rust + Diesel in a lambda to serve a REST API that interacts with an AWS Postgres DB (requiring SSL). I could not use `diesel-async`, although that is supposed to offer better vendored compatibility with cargo-lambda. My only solution was to compile my lambda, and package `libpq` and `libssl` within a lambda layer, since diesel uses system libraries.
 
## Usage

To upload a version from scratch, it is simply:

```sh
make build
make upload
```

You can also just add the ARN to your lambda function:

```
arn:aws:lambda:us-east-1:058264557458:layer:postgresql-libpq-dev:10
```

## References

1. https://github.com/sans-ops/aws-lambda-layer-libpq-ssl
2. https://github.com/DrLuke/postgres-libpq-aws-lambda-layer
3. https://github.com/jetbridge/psycopg2-lambda-layer
4. https://github.com/jkehler/awslambda-psycopg2
5. https://github.com/lambci/docker-lambda
