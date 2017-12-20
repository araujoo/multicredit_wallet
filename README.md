# README



**Informacoes Tecnicas**
* Versao do Ruby: ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-linux]
* Versao do Rails: Rails 5.0.6
* Banco de dados utilizado: Sqlite3


**Documentacao**
* Software utilizado para modelagem do diagrama UML: Umbrello
* Software utilizado para modelagem do DER: draw.io
* Documentacao das Rotas está descrita na secao abaixo. Diagramas e modelos, sob a pasta "documentation"


**Consideracoes**

1- Importante ressaltar que caso o usuario nao esteja logado, todos os codigos HTTP serao
automaticamente setados como 400, seguido de um json informando erro de autorizacao.

2- O processo de autenticacao consiste no envio de um Token gerado pelo servidor que deve ser passado, obrigatoriamente, como parametro <auth_token> no header de toda requisicao. Caso contrário,
o usuário será considerado não autenticado

3- Para viés de testes, exemplos de json poderão ser encontrados sob a pasta "jsons_samples"

4- Testes foram realizados utilizando SoapUI 5.4.0-EB


**Rotas/Endpoints criados**


**Listar Cartoes**
----
* **URL**
  /credit_cards/list_cards

* **Metodo:**
GET

* **Resposta:**
HTTP Status: 200
Content: json


**Cadastrar Cartoes**
----
* **URL**
  /credit_cards/add_card

* **Metodo:**
POST

* **Parametro de Entrada:**
Content: json com um ou mais cartoes a serem adicionados

* **Resposta:**
HTTP Status: 201
Content: json com os cartoes que foram adicionados e, para os que nao foram, a razao da nao insercao


**Remover Cartoes**
----
* **URL**
  /credit_cards/remove_card

* **Metodo:**
DELETE

* **Parametro de Entrada:**
Content: json contendo a informacao de um cartao a ser removido

* **Resposta:**
HTTP Status: 200
Content: json com retorno da solicitacao

**Atualizar Cartao**
----
* **URL**
  /credit_cards/update_card

* **Metodo:**
PUT

* **Parametro de Entrada:**
Content: json contendo o cartao e as informacoes que deseja alterar

* **Resposta:**
HTTP Status: 200
Content: json com o retorno da solicitacao

**Listar Usuarios Cadastrados**
----
obs: API disponibilizada apenas com intuito de testes pelos avaliadores.

* **URL**
  /users/list_users

* **Metodo:**
GET

* **Resposta:**
HTTP Status: 200
Content: json exibindo todos os usuarios cadastrados no sistema

**Cadastrar Usuarios**
----

* **URL**
  /sign_up

* **Metodo:**
POST

* **Parametro de Entrada:**
Content: json contendo um ou mais usuarios a serem cadastrados no sistema

* **Resposta:**
HTTP Status: 201
Content: json exibindo com a mensagem de retorno da solicitacao


**Autenticar Usuário(Login)**
----

* **URL**
  /sign_in

* **Metodo:**
POST

* **Parametro de Entrada:**
Content: json contendo o email e senha do usuario a se autenticar

* **Resposta:**
HTTP Status: 200 caso consiga autenticar, 400 caso contrario
Content: json contendo o token de autenticacao do usuario

**Logout**
----

* **URL**
  /sign_out

* **Metodo:**
PUT

* **Resposta:**
HTTP Status: 200 caso consiga realizar o logout, 404 caso contrario
Content: json informando que o usuario realizou o logout

**Remover Usuario**
----

* **URL**
  /users/remove_user

* **Metodo:**
DELETE

* **Parametro de Entrada:**
Content: json contendo o e-mail do usuario a ser removido

* **Resposta:**
HTTP Status: 200
Content: json exibindo a mensagem com o retorno da solicitacao


**Atualizar Dados do Usuario**
----

* **URL**
  /users/update_user

* **Metodo:**
PUT

* **Parametro de Entrada:**
Content: json contendo as informacoes do usuario a serem atualizadas

* **Resposta:**  
HTTP Status: 200
Content: json contendo o resultado do processo de atualizacao

**Recuperar Limite da CardWallet**
----

* **URL**
  /card_wallets/read_limit

* **Metodo:**
GET

* **Resposta:**
HTTP Status: 200
Content: json informando o limite da CardWallet que foi definido pelo usuario
  

**Recuperar Limite Disponivel Para Compras**
----

* **URL**
  /card_wallets/read_available_credit

* **Metodo:**
GET

* **Resposta:**
HTTP Status: 200
Content: json informando o limite disponivel para compras (baseado no limite definido pelo usuario)
  

**Recuperar Limite Maximo que o Usuario Pode Setar**
----

* **URL**
  /card_wallets/read_max_lim_available

* **Metodo:**
GET

* **Resposta:**
HTTP Status: 200
Content: json informando o limite maximo que o usuario podera definir (baseado no limite dos cartoes de credito cadastrados)


**Atualizar o Limite da CardWallet**
----

* **URL**
  /card_wallets/update_limit

* **Metodo:**
PUT

* **Parametro de Entrada:**
Content: json contendo o limite desejado

* **Resposta:**  
HTTP Status: 200 caso a atualizacao seja bem sucedida, 400 caso contrario
Content: json com a mensagem de resposta do processo de atualizacao

**Recuperar Historico de Compras do Usuario**
----

* **URL**
  /card_wallets/purchases_history

* **Metodo:**
GET

* **Resposta:**  
HTTP Status: 200
Content: json com a lista de compras realizadas atraves da CardWallet do usuario autenticado
  
**Antecipar Fatura do Cartao**
----

* **URL**
  /purchases/antecipate_payment

* **Metodo:**
POST

* **Parametro de Entrada:**
Content: json contendo a pagar

* **Resposta:**
HTTP Status: 200
Content: json com o resultado da operacao de antecipacao de fatura
  

**Realizar Compra**
----

* **URL**
  /purchases/buy

* **Metodo:**
POST

* **Parametro de Entrada:**
Content: json contendo o valor da compra desejado

* **Resposta:**    
HTTP Status: 200
Content: json com o resultado da operacao de antecipacao de fatura