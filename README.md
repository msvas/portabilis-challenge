# Portabilis Challenge - Marcelo Vasques

Este projeto inclui o backend em Ruby on Rails com uma API para cadastro e controle de usuários de uma empresa fictícia.

Uma versão para testes (backend e frontend) está disponível em
https://challenge-marcelo-frontend.herokuapp.com/

A versão hospedada no Heroku possui a cache ligada na requisição que traz todos os usuários, e por isso as mudanças acabam sendo refletidas após 1 minuto.
A busca de usuários não é afetada pela cache e mostra as mudanças sempre atualizadas.

O email de boas vindas, nos testes que fiz com uma conta do Gmail, acabou indo parar na caixa de spam.

As ações disponíveis e seus endpoints estão listados a seguir:
* Criar usuário - POST /auth
* Login de usuário - POST /auth/sign_in
* Lista de usuários (apenas logado) - GET /api/v1/users
* Busca de usuários, com ordenação (apenas logado) - POST /api/v1/users/search
* Remoção de usuário (admin apenas) - DELETE /api/v1/admin/users/:user_id
* Suspensão/ativação de usuário (admin apenas) - GET /api/v1/admin/users/:user_id/suspend

## Pré-requisitos
* Ruby 3.1.2
* PostgreSQL 14
* Memcached (opcional, usado para cache em produção)

* Lembrar de atualizar as credenciais locais do PostgreSQL em `config/database.yml`

## Setup
```bash
# Instala gems
$ bundle install

# Cria bancos de dados
$ rake db:create

# Migra bancos de dados
$ rake db:migrate

# Roda servidor local em localhost:3000
$ rails s
```

## Testes
O projeto usa o framework RSpec para testes, para rodar todos os casos, use o comando
```bash
$ bundle exec rspec
```

## Requisições de exemplo
```bash
# Sign up
curl -v -H "Accept: application/json" -H "Content-type: application/json" -d '{ "email":"test2@test.com", "name":"test", "password":"123456", "password_confirmation":"123456" }' http://localhost:3000/auth

# Sign in, a requisição irá retornar alguns headers que devem estar presentes nas outras requisições que exigem login
# São eles: 'access-token', 'client' e 'uid', além disso é necessário o header 'token-type: Bearer'
curl -v -H "Accept: application/json" -H "Content-type: application/json" -d '{ "email":"adm@adm.com", "password":"123456" }' http://localhost:3000/auth/sign_in

# Lista de usuários (necessário tokens de login)
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "token-type: Bearer" -H "access-token: <TOKEN RETORNADO>" -H "uid: <UID RETORNADO>" -H "client: <CLIENT RETORNADO>" -X GET http://localhost:3000/api/v1/users

# Busca de usuários (necessário tokens de login)
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "token-type: Bearer" -H "access-token: <TOKEN RETORNADO>" -H "uid: <UID RETORNADO>" -H "client: <CLIENT RETORNADO>" --data '{"keyword":"test","sort":["name"],"direction":"asc"}' http://localhost:3000/api/v1/users/search

# Remoção de usuário (necessário tokens de login de administrador)
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "token-type: Bearer" -H "access-token: <TOKEN RETORNADO>" -H "uid: <UID RETORNADO>" -H "client: <CLIENT RETORNADO>" -X DELETE http://localhost:3000/api/v1/admin/users/:user_id

# Suspensão/ativação de usuário (necessário tokens de login de administrador)
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "token-type: Bearer" -H "access-token: <TOKEN RETORNADO>" -H "uid: <UID RETORNADO>" -H "client: <CLIENT RETORNADO>" -X GET http://localhost:3000/api/v1/admin/users/:user_id/suspend
```
