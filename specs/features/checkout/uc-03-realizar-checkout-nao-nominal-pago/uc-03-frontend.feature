# UC-03 - Frontend BDD

@checkout @non-nominal @paid @frontend
Feature: Realizar Checkout Não Nominal Pago

  Como participante,
  Quero realizar a compra de Ingressos não nominais pagos,
  Para garantir minha vaga no evento com o menor atrito possível.

  # ============================================
  # FLUXO PRINCIPAL
  # ============================================

  @success
  Scenario: Checkout não nominal pago concluído com sucesso
    Given que o evento possui Ingressos não nominais pagos
    And o participante selecionou os Ingressos
    When acessar a página de checkout
    Then não deve exibir Bloco 1 (dados dos participantes)
    And deve exibir Bloco 2 (responsável pelos Ingressos)
    And deve exibir painel lateral com resumo do pedido
    And deve exibir contador de 15 minutos

  @success
  Scenario: Preencher dados do responsável e avançar
    Given que está no Bloco 2 (responsável pelos Ingressos)
    When preencher nome completo válido
    And preencher e-mail válido
    And preencher celular válido
    And aceitar termos e condições
    And clicar em "Avançar"
    Then deve navegar para Bloco 3 (pagamento)
    And deve salvar dados do responsável temporariamente

  @success
  Scenario: Selecionar método Pix e processar pagamento
    Given que está no Bloco 3 (pagamento)
    And preencheu dados do comprador
    When selecionar método de pagamento "pix"
    Then deve exibir QR Code para escaneamento

  @success
  Scenario: Selecionar método cartão de crédito
    Given que está no Bloco 3 (pagamento)
    When selecionar método de pagamento "cartão de crédito"
    Then deve exibir campos do cartão de crédito

  @success
  Scenario: Selecionar método boleto
    Given que está no Bloco 3 (pagamento)
    When selecionar método de pagamento "boleto"
    Then deve exibir código de barras do boleto

  # ============================================
  # VALIDAÇÕES
  # ============================================

  @validation
  Scenario: Exibir erro para e-mail inválido do responsável
    Given que está no Bloco 2 (responsável pelos Ingressos)
    When preencher e-mail no formato inválido
    And o campo perder o foco
    Then deve exibir mensagem de erro "E-mail inválido"
    And deve destacar o campo em vermelho

  @validation
  Scenario: Exibir erro para celular inválido
    Given que está no Bloco 2 (responsável pelos Ingressos)
    When preencher celular com formato inválido
    And o campo perder o foco
    Then deve exibir mensagem de erro "Celular inválido"
    And deve destacar o campo em vermelho

  @validation
  Scenario: Bloquear avanço sem aceitar termos
    Given que está no Bloco 2 (responsável pelos Ingressos)
    And preencheu todos os dados corretamente
    And não aceitou os termos e condições
    When clicar em "Avançar"
    Then deve exibir erro "É necessário aceitar os termos"
    And deve bloquear navegação para Bloco 3

  # ============================================
  # CUPOM DE DESCONTO
  # ============================================

  @coupon
  Scenario: Aplicar cupom de desconto válido
    Given que está no Bloco 3 (pagamento)
    When inserir código de cupom válido "DESC20"
    And clicar em "Aplicar"
    Then deve exibir desconto aplicado no resumo
    And deve atualizar valor total com desconto

  @coupon
  Scenario: Exibir erro para cupom inválido
    Given que está no Bloco 3 (pagamento)
    When inserir código de cupom inválido "INVALIDO"
    And clicar em "Aplicar"
    Then deve exibir mensagem de erro "Cupom inválido"
    And deve manter valor original

  @coupon
  Scenario: Remover cupom aplicado
    Given que tem um cupom aplicado
    When clicar para remover o cupom
    Then deve remover o desconto
    And deve atualizar o total para valor original

  # ============================================
  # COMPRADOR
  # ============================================

  @buyer
  Scenario: Usar mesmos dados do responsável pelos Ingressos
    Given que preencheu dados do responsável pelos Ingressos
    When marcar opção "Same as ticket responsible"
    Then deve pré-preencher campos do comprador com dados do responsável

  @buyer
  Scenario: Preencher dados do comprador diferentes
    Given que desmarcou opção "Same as ticket responsible"
    When preencher dados do comprador
    Then deve validar campos independentemente do responsável

  # ============================================
  # CONTADOR / EXPIRAÇÃO
  # ============================================

  @timer
  Scenario: Contador entra em estado de aviso
    Given que o contador está abaixo de 5 minutos
    When o tempo for atualizado
    Then deve alterar cor do contador para laranja
    And deve exibir mensagem de aviso

  @timer
  Scenario: Contador entra em estado crítico
    Given que o contador está abaixo de 1 minuto
    When o tempo for atualizado
    Then deve alterar cor do contador para vermelho
    And deve exibir mensagem de urgência

  @timer
  Scenario: Tempo expirado durante checkout
    Given que o tempo de 15 minutos expirou
    When o sistema detectar a expiração
    Then deve exibir modal de tempo expirado
    And deve liberar os Ingressos reservados
    And deve redirecionar para página do evento

  # ============================================
  # ERROS (Lei de Murphy)
  # ============================================

  @error
  Scenario: Dados não são salvos ao atualizar página
    Given que preencheu dados do responsável
    When atualizar a página do navegador
    Then deve perder todos os dados preenchidos
    And deve exibir erro de sessão expirada

  @error
  Scenario: Network error ao carregar sessão
    Given que tenta acessar o checkout
    When ocorre erro de rede
    Then deve exibir mensagem de erro de conexão
    And deve permitir tentar novamente

  @error
  Scenario: Erro ao aplicar cupom por timeout
    Given que insere um código de cupom
    When a requisição atinge timeout
    Then deve exibir mensagem de erro de conexão
    And deve permitir tentar novamente

  @error
  Scenario: Dados do cartão não são salvos por segurança
    Given que preencheu dados do cartão de crédito
    When ocorre erro antes da submissão
    Then os dados do cartão devem ser limpos
    And o usuário deve preenchê-los novamente

  @error
  Scenario: Scroll não funciona com erro de validação
    Given que há erro de validação no Bloco 1
    When tenta avançar para Bloco 2
    Then deve manter scroll no Bloco 1
    And deve destacar campos inválidos
    And não deve permitir navegação

  @error
  Scenario: QR Code Pix não carrega
    Given que selecionou método de pagamento "pix"
    When o QR Code não carrega por erro
    Then deve exibir botão para copiar código
    And deve permitir copiar código manualmente

  # ============================================
  # ESTADOS DE CARREGAMENTO
  # ============================================

  @loading
  Scenario: Exibir loading ao carregar sessão
    Given que acessa a página de checkout
    When a sessão está sendo carregada
    Then deve exibir skeleton de carregamento
    And não deve permitir interação

  @loading
  Scenario: Exibir loading ao processar pagamento
    Given que clicou em "Finalizar compra"
    When o pagamento está sendo processado
    Then deve exibir indicador de processamento
    And deve desabilitar campos do formulário

  @loading
  Scenario: Exibir loading ao aplicar cupom
    Given que inseriu código de cupom
    When a validação está em andamento
    Then deve exibir estado de carregamento no botão
    And deve desabilitar campo de cupom
