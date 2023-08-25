# Desafio SideBank - Guia de Instalação e Configuração

## Sobre o Projeto

O Desafio SideBank é um projeto para explorar a gem u-case.

## Instalação

### Clonando o Projeto

Para baixar o projeto, utilize o seguinte comando:

```bash
git clone https://github.com/Diogoloiola/sidebank
```

Após a clonagem, acesse o diretório do projeto:

```bash
cd sidebank
```

### Pré-requisitos
Antes de executar a aplicação localmente, certifique-se de ter o Ruby on Rails instalado. Você pode encontrar instruções detalhadas de instalação , <a href="https://gorails.com/setup/ubuntu/22.04">aqui</a>.


### Configuração do Banco de Dados
Para executar a aplicação, é necessário configurar o arquivo de conexão com o banco de dados. Siga os passos abaixo:

Crie um arquivo chamado database.yml na pasta config.

Adicione o seguinte conteúdo ao arquivo, ajustando as configurações de acordo com o banco de dados em sua máquina:

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  host: localhost
  user: postgres
  password: 12345
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: side_bank_development

test:
  <<: *default
  database: side_bank_test

production:
  <<: *default
  database: side_bank_production
```

Certifique-se de substituir os valores de host, user, password e outros conforme necessário.

### Executando o Servidor

Para iniciar o servidor local, utilize o seguinte comando:

```bash
rails s
```