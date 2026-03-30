# UC-03 - Backend BDD

@checkout @non-nominal @paid @backend
Feature: Realizar Checkout Não Nominal Pago - Backend

  Como sistema backend,
  Quero processar a compra de Ingressos não nominais pagos,
  Para garantir a conclusão segura da transação.

  # ============================================
  # CRIAÇÃO DE SESSÃO
  # ============================================

  @session
  Scenario: Criar sessão de checkout para Ingressos não nominais
    Given que o participante selecionou Ingressos não nominais pagos
    When solicitar criação de sessão de checkout
    Then deve criar sessão com tempo de expiração de 15 minutos
    And deve bloquear Ingressos para esta sessão

  @session
  Scenario: Obter sessão de checkout ativa
    Given que existe uma sessão de checkout ativa
    When solicitar os dados da sessão
    Then deve retornar os dados da sessão
    And deve retornar tempo restante

  @session
  Scenario: Sessão expirada
    Given que o tempo de 15 minutos expirou
    When o sistema detectar expiração
    Then deve liberar os Ingressos reservados
    And deve marcar sessão como expirada

  # ============================================
  # RESPONSÁVEL PELOS INGRESSOS
  # ============================================

  @responsible
  Scenario: Salvar dados do responsável pelos Ingressos
    Given que a sessão está ativa
    When enviar dados do responsável pelos Ingressos
    Then deve validar os dados
    And deve salvar temporariamente na sessão
    And deve retornar sucesso

  @responsible
  Scenario: Validar dados do responsável inválidos
    Given que a sessão está ativa
    When enviar e-mail inválido do responsável
    Then deve retornar erro de validação
    And não deve salvar na sessão

  # ============================================
  # CUPOM DE DESCONTO
  # ============================================

  @coupon
  Scenario: Validar cupom de desconto aplicável
    Given que o participante insere código de cupom "DESC20"
    When validar cupom para o evento e valor
    Then deve retornar que o cupom é válido
    And deve retornar informações do desconto

  @coupon
  Scenario: Validar cupom expirado
    Given que o participante insere código de cupom expirado
    When validar cupom
    Then deve retornar que o cupom expirou
    And deve retornar mensagem explicativa

  @coupon
  Scenario: Validar cupom com valor mínimo não atingido
    Given que o participante insere cupom com valor mínimo de R$ 100
    And o pedido tem valor de R$ 50
    When validar cupom
    Then deve retornar que valor mínimo não foi atingido
    And deve informar valor mínimo necessário

  @coupon
  Scenario: Aplicar múltiplos cupons
    Given que já existe um cupom aplicado
    When tentar aplicar outro cupom
    Then deve retornar erro "Apenas um cupom por pedido"
    And deve manter cupom original

  # ============================================
  # PAGAMENTO
  # ============================================

  @payment
  Scenario: Criar pagamento com método Pix
    Given que o participante selecionou método "pix"
    When criar transação de pagamento
    Then deve gerar QR Code para pagamento
    And deve criar registro de transação pendente

  @payment
  Scenario: Criar pagamento com cartão de crédito
    Given que o participante selecionou método "cartão"
    When criar transação de pagamento
    Then deve enviar dados ao gateway
    And deve criar registro de transação

  @payment
  Scenario: Criar pagamento com boleto
    Given que o participante selecionou método "boleto"
    When criar transação de pagamento
    Then deve gerar código de barras
    And deve criar registro com data de vencimento

  @payment
  Scenario: Payment gateway retorna timeout
    Given que o sistema tenta processar pagamento
    When o gateway atinge timeout
    Then deve retornar erro de conexão
    And não deve criar transação

  @payment
  Scenario: Payment gateway retorna cartão recusado
    Given que o sistema enviou dados do cartão
    When o gateway retorna recusa
    Then deve retornar status de pagamento recusado
    And deve informar motivo da recusa

  # ============================================
  # CRIAÇÃO DE CONTA
  # ============================================

  @account
  Scenario: Criar conta automática após checkout
    Given que o checkout foi concluído com sucesso
    And o e-mail do responsável não existe
    When criar conta automática
    Then deve gerar senha temporária
    And deve enviar e-mail de boas-vindas
    And deve retornar conta criada

  @account
  Scenario: Usar conta existente
    Given que o checkout foi concluído com sucesso
    And o e-mail do responsável já existe
    When verificar existência de conta
    Then deve usar conta existente
    And não deve enviar e-mail de boas-vindas
    And deve vincular pedido à conta existente

  # ============================================
  # PEDIDO E INGRESSOS
  # ============================================

  @order
  Scenario: Criar pedido após pagamento aprovado
    Given que o pagamento foi aprovado
    When criar pedido
    Then deve gerar número do pedido
    And deve criar Ingressos não nominais
    And deve vincular Ingressos ao responsável
    And deve retornar dados do pedido

  @order
  Scenario: Gerar QR Codes dos Ingressos
    Given que o pedido foi criado
    When gerar Ingressos
    Then deve gerar QR Code único para cada Ingresso
    And deve armazenar URL de download

  @order
  Scenario: Enviar e-mail com Ingressos
    Given que o pedido foi criado e pago
    When processar envio de e-mails
    Then deve enviar e-mail com Ingressos em PDF
    And deve incluir QR Codes

  # ============================================
  # FLUXO COMPLETO
  # ============================================

  @flow
  Scenario: Checkout completo com sucesso
    Given que o participante tem sessão ativa
    And preencheu dados do responsável corretamente
    And tem método de pagamento selecionado
    When submeter checkout completo
    Then deve processar pagamento
    And deve criar conta automática
    And deve criar pedido
    And deve gerar Ingressos
    And deve enviar e-mails
    And deve retornar confirmação

  @flow
  Scenario: Checkout com falha no pagamento
    Given que o participante tem sessão ativa
    And preencheu todos os dados
    When o pagamento for recusado
    Then deve retornar erro
    And não deve criar conta
    And não deve criar pedido
    And não deve enviar e-mails

  # ============================================
  # ERROS (Lei de Murphy)
  # ============================================

  @error
  Scenario: Ingressos esgotam durante checkout
    Given que o participante tem sessão ativa
    When outro participante compra os mesmos Ingressos
    And tenta finalizar checkout
    Then deve retornar erro "Ingressos indisponíveis"
    And deve liberar sessão

  @error
  Scenario: Sessão não encontrada
    Given que tenta acessar sessão inexistente
    When buscar sessão
    Then deve retornar erro 404

  @error
  Scenario: Cupom não encontrado
    Given que insere código de cupom inexistente
    When validar cupom
    Then deve retornar "Cupom não encontrado"

  @error
  Scenario: Duplicidade na criação de pedido
    Given que o pagamento foi aprovado
    When recebe segunda requisição de checkout
    Then deve identificar duplicidade
    And deve retornar pedido existente
    And não deve criar duplicata

  @error
  Scenario: Falha ao enviar e-mail
    Given que o pedido foi criado com sucesso
    When o serviço de e-mail está indisponível
    Then deve marcar e-mail como pendente
    And deve finalização do checkout
    And deve registrar para retry

  @error
  Scenario: banco de dados indisponível
    Given que tenta salvar dados
    When o banco de dados não responde
    Then deve retornar erro de conexão
    And deve permitir retry

  @error
  Scenario: Race condition na criação de conta
    Given que o e-mail está em processo de criação
    When recebe segunda requisição simultânea
    Then deve evitar criação duplicada
    And deve usar conta já criada

  # ============================================
  # VALIDAÇÕES
  # ============================================

  @validation
  Scenario: CPF do comprador inválido
    Given que o participante insere CPF inválido
    When validar dados do comprador
    Then deve retornar erro "CPF inválido"

  @validation
  Scenario: Dados do cartão com algoritmo de Luhn inválido
    Given que o participante insere número de cartão inválido
    When validar cartão
    Then deve retornar erro "Número do cartão inválido"

  @validation
  Scenario: Validade do cartão expirada
    Given que o participante insere data de validade passada
    When validar cartão
    Then deve retornar erro "Cartão expirado"
