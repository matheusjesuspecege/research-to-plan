# UC-01 - Frontend BDD

Cenários BDD no formato Gherkin para o frontend do caso de uso Realizar Checkout Nominal Pago.

---

## Feature: Checkout Nominal Pago - Frontend

### Cenários de Validação de Dados

```gherkin
Feature: Validação de Dados dos Participantes

  Scenario: Exibir erro para e-mail inválido
    Given que o participante está no campo "e-mail"
    When inserir "email-invalido" no campo
    And o campo perder o foco
    Then deve exibir mensagem "E-mail inválido"
    And deve destacar o campo com borda vermelha

  Scenario: Exibir erro para celular inválido
    Given que o participante está no campo "celular"
    When inserir "123" no campo
    And o campo perder o foco
    Then deve exibir mensagem "Celular inválido"
    And deve destacar o campo com borda vermelha

  Scenario: Exibir erro para nome muito curto
    Given que o participante está no campo "nome"
    When inserir "A" no campo
    And o campo perder o foco
    Then deve exibir mensagem "Nome deve ter pelo menos 2 caracteres"

  Scenario: Validar campo obrigatório vazio
    Given que o participante deixa o campo "nome" vazio
    When o campo perder o foco
    Then deve exibir mensagem "Campo obrigatório"

  Scenario: Validar e-mail com formato correto
    Given que o participante está no campo "e-mail"
    When inserir "teste@exemplo.com" no campo
    And o campo perder o foco
    Then deve exibir indicador de campo válido
    And deve remover mensagem de erro

  Scenario: Validar campo customizado obrigatório
    Given que o organizador configurou campo customizado obrigatório "CPF"
    When o participante deixa o campo vazio
    Then deve exibir mensagem "CPF é obrigatório"
```

### Cenários de Navegação

```gherkin
Feature: Navegação entre Blocos

  Scenario: Avançar para Bloco 2 com dados válidos
    Given que todos os participantes têm dados válidos
    When clicar em "Avançar para Recebimento"
    Then deve navegar para Bloco 2
    And deve exibir resumo do pedido

  Scenario: Bloquear avanço com dados inválidos
    Given que há participante com dados inválidos
    When clicar em "Avançar para Recebimento"
    Then deve manter no Bloco 1
    And deve exibir destaque nos campos inválidos

  Scenario: Retornar ao Bloco 1 a partir do Bloco 2
    Given que está no Bloco 2
    When clicar em "Voltar"
    Then deve retornar ao Bloco 1
    And deve manter dados preenchidos

  Scenario: Scroll automático para bloco com erro
    Given que há erro de validação no Bloco 1
    When tentar avançar para Bloco 2
    Then deve manter scroll no Bloco 1
    And deve focar no primeiro campo inválido

  Scenario: Bloquear avanço sem aceitar termos
    Given que está no Bloco 2
    And não aceitou os termos e condições
    When clicar em "Avançar para Pagamento"
    Then deve exibir mensagem "É necessário aceitar os termos"
    And deve manter no Bloco 2
```

### Cenários de Contador

```gherkin
Feature: Contador de Tempo

  Scenario: Exibir contador regressivo
    Given que a sessão de checkout está ativa
    Then deve exibir contador regressivo de 15 minutos

  Scenario: Contador entra em estado de aviso
    Given que restam 4 minutos
    When o contador for atualizado
    Then deve exibir contador em cor laranja

  Scenario: Contador entra em estado crítico
    Given que resta menos de 1 minuto
    When o contador for atualizado
    Then deve exibir contador em cor vermelha
    And deve exibir mensagem "Tempo está acabando!"

  Scenario: Tempo expirado
    Given que o tempo chegou a zero
    When o sistema detectar expiração
    Then deve exibir modal "Tempo expirado"
    And deve liberar os ingressos reservados
    And deve redirecionar para página do evento
```

### Cenários de Cupom

```gherkin
Feature: Aplicação de Cupom de Desconto

  Scenario: Aplicar cupom válido
    Given que o participante está no campo de cupom
    When inserir código "DESC20"
    And clicar em "Aplicar"
    Then deve exibir "Cupom aplicado: DESC20"
    And deve descontar R$ 20,00 do total

  Scenario: Aplicar cupom expirado
    Given que o participante insere código de cupom expirado
    When clicar em "Aplicar"
    Then deve exibir mensagem "Cupom expirado"

  Scenario: Aplicar cupom inválido
    Given que o participante insere código inexistente
    When clicar em "Aplicar"
    Then deve exibir mensagem "Cupom inválido"

  Scenario: Aplicar cupom com valor mínimo não atingido
    Given que o pedido é R$ 50,00
    And o cupom requer mínimo R$ 100,00
    When inserir o cupom
    Then deve exibir mensagem "Valor mínimo R$ 100,00 não atingido"

  Scenario: Remover cupom aplicado
    Given que há um cupom aplicado
    When clicar em "Remover"
    Then deve remover o cupom
    And deve restaurar valor original
```

### Cenários de Pagamento

```gherkin
Feature: Pagamento

  Scenario: Selecionar método Pix
    Given que está no Bloco 3
    When selecionar "Pix"
    Then deve exibir QR Code do Pix

  Scenario: Selecionar método Boleto
    Given que está no Bloco 3
    When selecionar "Boleto"
    Then deve exibir código de barras do boleto

  Scenario: Selecionar método Cartão de Crédito
    Given que está no Bloco 3
    When selecionar "Cartão de Crédito"
    Then deve exibir campos do cartão

  Scenario: Validar número do cartão inválido
    Given que está no formulário de cartão
    When inserir número de cartão inválido
    Then deve exibir mensagem "Número do cartão inválido"

  Scenario: Cartão recusado
    Given que o pagamento foi enviado
    When a resposta for "cartão recusado"
    Then deve exibir "Pagamento recusado. Tente novamente."
    And deve manter todos os dados preenchidos
    And deve permitir nova tentativa

  Scenario: Exibir loading durante processamento
    Given que o participante clicou em "Finalizar Compra"
    When o sistema está processando
    Then deve exibir "Processando pagamento..."
    And deve desabilitar campos
```

### Cenários de Confirmação

```gherkin
Feature: Confirmação do Checkout

  Scenario: Checkout concluído com sucesso
    Given que o pagamento foi aprovado
    When o sistema processar a resposta
    Then deve exibir "Compra confirmada!"
    And deve exibir número do pedido
    And deve exibir resumo da compra
    And deve informar "Conta criada automaticamente"
    And deve informar "Verifique seu e-mail"

  Scenario: Checkout com e-mail já cadastrado
    Given que o e-mail do responsável já existe
    When o checkout for concluído
    Then deve exibir "Compra confirmada!"
    And deve informar "Você já tinha uma conta"

  Scenario: Redirecionar após confirmação
    Given que o checkout foi concluído
    When o usuário clicar em "Ver meus ingressos"
    Then deve redirecionar para área do usuário
```

---

## Ordenação para Implementação

1. ParticipantForm e validações
2. ResponsibleSelector
3. CouponInput
4. PaymentMethodSelector e formulários
5. CountdownTimer
6. OrderSummary
7. CheckoutStepper
8. CheckoutPage (integração)
9. Fluxo de erro e exceptions
10. Confirmação e redirecionamento
