# UC-01 - Backend BDD

Cenários BDD no formato Gherkin para o backend do caso de uso Realizar Checkout Nominal Pago.

---

## Feature: Sessão de Checkout

```gherkin
Feature: Gerenciamento de Sessão de Checkout

  Scenario: Criar sessão de checkout
    Given que o participante selecionou tickets no evento
    When requisitar criação de sessão de checkout
    Then deve criar sessão com tempo de 15 minutos
    And deve bloquear os ingressos selecionados
    And deve retornar ID da sessão

  Scenario: Obter sessão ativa
    Given que existe uma sessão de checkout ativa
    When requisitar os dados da sessão
    Then deve retornar os dados completos
    And deve calcular tempo restante

  Scenario: Extender sessão
    Given que a sessão está prestes a expirar
    When o cliente requisitar extensão
    Then deve estender por mais 15 minutos
    And deve manter os mesmos ingressos

  Scenario: Expirar sessão por tempo
    Given que o tempo de 15 minutos esgotou
    When o sistema detectar expiração
    Then deve liberar os ingressos reservados
    And deve marcar sessão como expirada
    And deve notificar cliente (se conectado)

  Scenario: Expirar sessão manualmente
    Given que o participante abandonou o checkout
    When o tempo expirar
    Then deve liberar os ingressos automaticamente
```

---

## Feature: Dados dos Participantes

```gherkin
Feature: Validação e Salvamento de Participantes

  Scenario: Validar participante com dados válidos
    Given que o participante enviou dados válidos
    When o sistema validar
    Then deve retornar sucesso
    And deve salvar dados temporários

  Scenario: Validar participante com e-mail duplicado no mesmo checkout
    Given que há dois participantes com mesmo e-mail
    When o sistema validar
    Then deve retornar erro "E-mail duplicado no pedido"

  Scenario: Validar campo customizado obrigatório
    Given que o evento tem campo "CPF" obrigatório
    And o participante não preencheu
    When o sistema validar
    Then deve retornar erro "Campo CPF é obrigatório"

  Scenario: Validar e-mail com formato inválido
    Given que o participante enviou e-mail "email-invalido"
    When o sistema validar
    Then deve retornar erro "E-mail inválido"

  Scenario: Salvar dados de múltiplos participantes
    Given que há 3 participantes com dados válidos
    When salvar os dados
    Then deve salvar todos os participantes
    And deve associar à sessão
```

---

## Feature: Cupom de Desconto

```gherkin
Feature: Aplicação de Cupom de Desconto

  Scenario: Validar cupom válido com desconto percentual
    Given que o cupom "DESC20" oferece 20% de desconto
    And o pedido tem valor R$ 100,00
    When validar o cupom
    Then deve retornar desconto de R$ 20,00

  Scenario: Validar cupom válido com desconto fixo
    Given que o cupom "FIXO50" oferece R$ 50,00 fixo
    And o pedido tem valor R$ 100,00
    When validar o cupom
    Then deve retornar desconto de R$ 50,00

  Scenario: Validar cupom expirado
    Given que o cupom "EXPIRADO" está expirado
    When validar o cupom
    Then deve retornar erro "Cupom expirado"

  Scenario: Validar cupom não encontrado
    Given que o código "INEXISTENTE" não existe
    When validar o cupom
    Then deve retornar erro "Cupom não encontrado"

  Scenario: Validar cupom com valor mínimo não atingido
    Given que o cupom requer mínimo R$ 100,00
    And o pedido tem R$ 50,00
    When validar o cupom
    Then deve retornar erro "Valor mínimo não atingido"

  Scenario: Aplicar limite de uso do cupom
    Given que o cupom permite apenas 100 usos
    And já foi usado 100 vezes
    When tentar aplicar o cupom
    Then deve retornar erro "Limite de uso atingido"

  Scenario: Remover cupom aplicado
    Given que há um cupom aplicado
    When requisitar remoção
    Then deve remover desconto
    And deve atualizar valor total
```

---

## Feature: Pagamento

```gherkin
Feature: Processamento de Pagamento

  Scenario: Processar pagamento com Pix
    Given que o método escolhido é Pix
    And o valor é R$ 150,00
    When processar pagamento
    Then deve gerar QR Code Pix
    And deve criar transação com status "pending"

  Scenario: Processar pagamento com cartão aprovado
    Given que o método é cartão de crédito
    And os dados do cartão são válidos
    When processar pagamento
    And o gateway aprovar
    Then deve retornar status "approved"
    And deve confirmar transação

  Scenario: Processar pagamento com cartão recusado
    Given que o método é cartão de crédito
    When processar pagamento
    And o gateway recusar
    Then deve retornar status "rejected"
    And deve retornar código de erro

  Scenario: Processar pagamento com boleto gerado
    Given que o método escolhido é boleto
    When processar pagamento
    Then deve gerar código de barras
    And deve criar transação com status "pending"

  Scenario: Verificar status de pagamento
    Given que há uma transação em andamento
    When verificar status
    Then deve retornar status atual

  Scenario: Cancelar pagamento pendente
    Given que há um pagamento pendente
    When requisitar cancelamento
    Then deve cancelar transação
    And deve liberar estoque
```

---

## Feature: Criação Automática de Conta

```gherkin
Feature: Criação Automática de Conta

  Scenario: Criar conta para novo usuário
    Given que o e-mail não existe na base
    When o checkout for concluído
    Then deve criar nova conta
    And deve gerar senha temporária
    And deve enviar e-mail com link de criação de senha

  Scenario: Usar conta existente
    Given que o e-mail já está cadastrado
    When o checkout for concluído
    Then deve usar conta existente
    And não deve criar nova conta
    And não deve enviar e-mail de boas-vindas

  Scenario: Vincular pedido à conta
    Given que a conta foi criada ou existente
    When o checkout for concluído
    Then deve vincular os ingressos à conta
    And deve associar pedido à conta
```

---

## Feature: Envio de E-mails

```gherkin
Feature: E-mails Transacionais

  Scenario: Enviar e-mail de boas-vindas
    Given que nova conta foi criada
    When o checkout for concluído
    Then deve enviar e-mail de boas-vindas
    And deve conter link para criar senha

  Scenario: Enviar e-mail com ingressos
    Given que o pagamento foi aprovado
    When o checkout for concluído
    Then deve enviar e-mail com ingressospdf
    And deve conter QR Code para cada ingresso

  Scenario: Enviar e-mail de confirmação
    Given que o checkout foi concluído
    Then deve enviar e-mail de confirmação
    And deve conter resumo do pedido

  Scenario: E-mail falha no envio
    Given que há falha no serviço de e-mail
    When tentar enviar
    Then deve registrar em log
    And deve tentar novamente (retry)
```

---

## Feature: Exceções e Erros

```gherkin
Feature: Tratamento de Exceções

  Scenario: Falha ao criar sessão por falta de estoque
    Given que não há estoque disponível
    When requisitar checkout
    Then deve retornar erro "Ingressos indisponíveis"

  Scenario: Falha no gateway de pagamento
    Given que o gateway está indisponível
    When processar pagamento
    Then deve retornar erro "Serviço indisponível"
    And deve sugerir nova tentativa

  Scenario: Timeout na comunicação com gateway
    Given que há timeout na comunicação
    When processar pagamento
    Then deve retornar erro "Tempo excedido"
    And deve manter dados para retry

  Scenario: Falha ao criar conta
    Given que há erro na criação de conta
    When checkout for concluído
    Then deve criar pedido mesmo assim
    And deve registrar para criação manual
    And deve notificar administrador

  Scenario: Transação parcialmente completa
    Given que pagamento foi aprovado
    But houve falha ao enviar e-mail
    When checkout for concluído
    Then deve confirmar pedido
    And deve registrar incidente
    And deve tentar enviar e-mail novamente
```

---

## Ordenação para Implementação

1. CheckoutSession (CRUD)
2. ParticipantService (validação)
3. CouponService (validação)
4. PaymentService (integração gateway)
5. OrderService (criação pedido)
6. UserService (criação automática)
7. EmailService (transacionais)
8. Controllers (API REST)
9. Tratamento de exceções
10. Logs e monitoramento
