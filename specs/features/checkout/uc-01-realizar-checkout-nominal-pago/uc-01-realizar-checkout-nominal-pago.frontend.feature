#language: pt

@frontend @checkout @uc-01
Funcionalidade: Checkout Nominal Pago - Frontend

Contexto:
  Dado o participante acessa o checkout com ingresso(s) nominal(is) pago(s) selecionado(s)
  E o evento possui método(s) de pagamento habilitado(s)

# FASE 1 - Estrutura e UI Base

@F1.1 @F1.2 @F1.3
Cenário: Exibir estrutura base do checkout
  Então a tela de checkout é exibida com Bloco 1 visível
  E o painel lateral com resumo do pedido é exibido
  E o contador de 15 minutos é visível no painel

# FASE 2 - Bloco 1: Dados dos Participantes

@F2.1
Cenário: Exibir campos obrigatórios para cada participante
  Dado o participante acessa o checkout com 2 ingressos nominais
  Então são exibidos 2 conjuntos de campos (nome, e-mail, celular)

@F2.2
Cenário: Exibir campos customizados conforme configuração
  Dado o organizador configurou campo customizado "CPF" como obrigatório
  Quando o participante acessa o checkout
  Então o campo "CPF" é exibido e validado

@F2.3
Cenário: Validação em tempo real de campo vazio
  Dado o campo e-mail está vazio
  Quando o usuário digita texto inválido
  Então é exibida indicação visual de erro no campo

@F2.4
Cenário: Indicação visual em campos inválidos
  Dado o usuário inseriu dados inválidos
  Então o campo exibe indicação visual de erro
  E a mensagem de erro é exibida abaixo do campo

@F2.5
Cenário: Botão avançar desabilitado com campos inválidos
  Dado campos obrigatórios estão inválidos
  Quando o usuário tenta avançar
  Então o botão "Avançar" permanece desabilitado

@F2.5
Cenário: Botão avançar habilitado após validação completa
  Dado todos os campos obrigatórios estão preenchidos e válidos
  Quando o usuário tenta avançar
  Então o botão "Avançar" fica habilitado

# FASE 3 - Bloco 2: Responsável pelos Ingressos

@F3.1
Cenário: Exibir opções de responsável
  Dado o usuário está no Bloco 2
  Então a opção "participante" está disponível
  E a opção "Outro" está disponível

@F3.2
Cenário: Pré-preenchimento ao selecionar participante
  Dado existem participantes preenchidos no Bloco 1
  Quando o usuário seleciona "Participante 1"
  Então os campos são pré-preenchidos com dados do Participante 1

@F3.3
Cenário: Campos manuais visíveis ao selecionar "Outro"
  Dado o usuário está no Bloco 2
  Quando o usuário seleciona "Outro"
  Então campos manuais são exibidos para preenchimento

@F3.4
Cenário: Checkbox termos obrigatório deve ser aceito
  Dado o usuário está no Bloco 2
  E o checkbox de termos não está aceito
  Quando tenta avançar
  Então o botão permanece desabilitado

@F3.5
Cenário: Aceite de contato é opcional
  Dado o usuário está no Bloco 2
  E o checkbox de termos está aceito
  E o checkbox de contato está desmarcado
  Quando o usuário avança
  Então o fluxo continua normalmente

# FASE 4 - Bloco 3: Pagamento

@F4.1
Cenário: Selecionar método Pix
  Dado o usuário está no Bloco 3
  Quando seleciona método "Pix"
  Então são exibidos campos específicos para Pix

@F4.1
Cenário: Selecionar método Cartão
  Dado o usuário está no Bloco 3
  Quando seleciona método "Cartão"
  Então são exibidos campos: número, validade, CVV, nome

@F4.1
Cenário: Selecionar método Boleto
  Dado o usuário está no Bloco 3
  Quando seleciona método "Boleto"
  Então são exibidos campos para geração do boleto

@F4.2
Cenário: Campos específicos conforme método
  Dado o usuário está no Bloco 3
  Quando seleciona um método de pagamento
  Então apenas campos relevantes ao método são exibidos

@F4.3
Cenário: Validação de dados do cartão em tempo real
  Dado o usuário digita número de cartão inválido
  Quando sai do campo
  Então é exibida indicação visual de erro

@F4.4
Cenário: Aplicar cupom válido
  Dado o usuário insere código de cupom válido
  Quando clica em "Adicionar"
  Então o desconto é aplicado
  E o valor total no resumo é atualizado

@F4.4
Cenário: Aplicar cupom inválido
  Dado o usuário insere código de cupom inválido
  Quando clica em "Adicionar"
  Então é exibida mensagem de erro abaixo do campo indicando motivo

@F4.4
Cenário: Apenas um cupom por pedido
  Dado um cupom já está aplicado
  Quando o usuário tenta adicionar outro cupom
  Então o primeiro cupom é substituído pelo novo

@F4.5
Cenário: Remover cupom aplicado
  Dado um cupom está aplicado
  Quando o usuário clica em remover cupom
  Então o desconto é removido
  E o valor total no resumo é restaurado

@F4.6
Cenário: Botão avançar habilitado após validação completa
  Dado todos os campos estão preenchidos e válidos
  Quando o usuário clica em "Avançar para pagamento"
  Então o botão está habilitado
  E a requisição de pagamento é enviada

# Processamento e Confirmação

@F5.8
Cenário: Tela de confirmação após pagamento
  Dado o pagamento foi processado com sucesso
  Quando a resposta é recebida
  Então a tela de confirmação é exibida com detalhes do pedido

@F5.8
Cenário: Redirecionamento após finalizar
  Dado o usuário está na tela de confirmação
  Quando clica em "Finalizar"
  Então é redirecionado para área do usuário

# Cenários Alternativos

@F6.2
Cenário: Alterar dados pré-preenchidos
  Dado dados foram pré-preenchidos automaticamente
  Quando o usuário altera algum campo
  Então as alterações são aceitas e salvas

# Cenários de Exceção

@F6.3
Cenário: Cartão recusado mantém dados preenchidos
  Dado o usuário está na tela de pagamento
  E preencheu todos os dados do cartão
  Quando o pagamento é recusado
  Então todos os dados permanecem preenchidos
  E mensagem de erro é exibida com instruções
  E o usuário pode corrigir e tentar novamente

@F6.4
Cenário: Timeout de checkout expirado
  Dado o contador chegou a zero
  Então os ingressos são liberados
  E o usuário é redirecionado para página do evento

# Requisitos Não-Funcionais

@F7.2
Cenário: Validações respondem em tempo aceitável
  Dado o usuário digita em um campo
  Quando a validação é executada
  Então a resposta é exibida em menos de 2 segundos

@F7.3
Cenário: Indicações visuais claras de campos obrigatórios
  Dado o usuário está no checkout
  Então campos obrigatórios possuem indicação visual clara
  E campos com erro possuem indicação visual de erro
