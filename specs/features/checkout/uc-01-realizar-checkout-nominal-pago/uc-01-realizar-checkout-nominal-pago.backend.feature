#language: pt

@backend @checkout @uc-01
Funcionalidade: Checkout Nominal Pago - Backend

# FASE 2 - Validações

@F2.2 @F2.3
Cenário: Validar campos customizados obrigatórios
  Dado campo "CPF" configurado como obrigatório
  Quando API recebe payload sem CPF
  Então retorna erro 400 com detalhes do campo obrigatório

@F2.3
Cenário: Validar formato de e-mail
  Dado payload com e-mail "email-invalido"
  Quando a API valida o registro
  Então retorna erro 400 com mensagem "e-mail inválido"

@F4.3
Cenário: Validar dados do cartão via gateway
  Dado dados do cartão "1234-5678-9012-3456"
  Quando a API valida com gateway
  Então retorna erro se cartão inválido

# FASE 4 - Cupom

@F4.4
Cenário: Aplicar cupom válido
  Dado código "DESCONTO10" existe e está ativo
  E uso não atingiu limite
  E data de validade não expirou
  Quando API processa cupom
  Então retorna desconto aplicável
  E cupom é vinculado ao pedido

@F4.4 @F6.1
Cenário: Cupom inválido - código não existe
  Dado código "INVALIDO" não existe
  Quando API processa cupom
  Então retorna erro 400 com mensagem "cupom não encontrado"

@F4.4 @F6.1
Cenário: Cupom expirado
  Dado código "EXPIRADO" está expirado
  Quando API processa cupom
  Então retorna erro 400 com mensagem "cupom expirado"

@F4.4 @F6.1
Cenário: Cupom com uso esgotado
  Dado código "ESGOTADO" atingiu limite de uso
  Quando API processa cupom
  Então retorna erro 400 com mensagem "cupom esgotado"

@F4.4
Cenário: Substituir cupom existente
  Dado um cupom já está aplicado no pedido
  Quando tentativa de adicionar segundo cupom
  Então o primeiro cupom é substituído pelo novo

@F4.5
Cenário: Remover cupom e restaurar valor
  Dado um cupom está aplicado ao pedido
  Quando API recebe requisição de remoção
  Então desconto é removido
  E valor total é restaurado

# FASE 5 - Processamento de Pagamento

@F5.1
Cenário: Processar pagamento Pix com sucesso
  Dado payload válido com método "pix"
  E valor total calculado corretamente
  Quando API processa pagamento via gateway
  Então retorna status "pending"
  E QR Code é gerado
  E transação é salva com status "pending"

@F5.1
Cenário: Processar pagamento cartão com sucesso
  Dado payload válido com card_token
  E dados do responsável preenchidos
  Quando API processa pagamento via gateway
  Então retorna status "approved"
  E transação é salva com status "approved"

@F5.1 @F6.3
Cenário: Cartão recusado pelo gateway
  Dado payload com card_token inválido
  Quando API processa pagamento
  Então retorna erro do gateway
  E não cria pedidos
  E dados do responsável não são perdidos

@F5.1
Cenário: Timeout durante processamento
  Dado gateway não responde em 30 segundos
  Quando API processa pagamento
  Então retorna erro de timeout
  E rollback é executado

@F5.9
Cenário: Transação atômica - rollback em falha
  Dado pagamento processado com sucesso
  E falha no envio de e-mail
  Quando API tenta completar transação
  Então rollback é executado em toda transação
  E ingresso não é confirmado
  E conta não é criada

@F5.9
Cenário: Transação atômica - falha na criação de conta
  Dado pagamento processado com sucesso
  E falha ao criar conta
  Quando API tenta completar transação
  Então rollback é executado
  E ingresso não é vinculado
  E pagamento é estornado

# FASE 5 - Conta e Vinculação

@F5.2
Cenário: Criar conta para novo e-mail
  Dado e-mail "novo@email.com" não existe na base
  Quando pagamento é confirmado
  Então nova conta é criada
  E ingresso é vinculado à conta

@F5.3
Cenário: Reutilizar conta existente
  Dado e-mail "existente@email.com" já possui conta
  Quando pagamento é confirmado
  Então conta existente é reutilizada
  E ingresso é vinculado à conta existente
  E não cria conta duplicada

@F5.4
Cenário: Vincular múltiplos ingressos a uma conta
  Dado participante comprou 3 ingressos
  Quando pagamento é confirmado
  Então todos os 3 ingressos são vinculados à mesma conta

# FASE 5 - E-mails

@F5.5
Cenário: Enviar e-mail de boas-vindas (nova conta)
  Dado nova conta foi criada para "novo@email.com"
  Quando API dispara e-mail
  Então e-mail de boas-vindas é enviado
  E e-mail contém link de criação de senha

@F5.6
Cenário: Não enviar boas-vindas (conta existente)
  Dado conta existente "existente@email.com" foi reutilizada
  Quando pagamento é confirmado
  Então e-mail de boas-vindas NÃO é enviado

@F5.7
Cenário: Enviar e-mail com PDF dos ingressos
  Dado ingresso foi vinculado à conta
  Quando API gera confirmação
  Então e-mail com PDF dos ingressos é enviado
  E PDF contém QR Code para check-in

# FASE 6 - Timeout

@F6.4
Cenário: Liberar ingressos ao expirar timeout
  Dado reserva com 15 minutos criada
  Quando tempo expira
  Então ingressos são liberados
  E disponíveis para outros participantes

@F6.4
Cenário: Novo período ao reiniciar checkout
  Dado timeout expirou e usuário retornou
  E ingressos ainda estão disponíveis
  Quando inicia novo checkout
  Então novo período de 15 minutos é criado
  E reserva é renovada

# Requisitos Não-Funcionais

@F7.1
Cenário: Dados de cartão não armazenados localmente
  Dado payload com dados de cartão
  Quando API processa pagamento
  Então apenas card_id do gateway é armazenado
  E dados sensíveis não são salvos no banco

@F7.2
Cenário: Validações respondem em tempo aceitável
  Quando API executa validação de campos
  Então resposta é retornada em menos de 2 segundos
