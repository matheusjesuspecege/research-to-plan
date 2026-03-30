# UC-02 - Backend BDD - Checkout Nominal Gratuito

Funcionalidade: API de Checkout Nominal Gratuito

# Gerenciamento de Sessão

Cenário: Criar nova sessão de checkout
  Dado que o evento possui ingresso nominal gratuito disponível
  Quando o participante enviar requisição para criar sessão
  E incluir os ingressos selecionados
  Então o sistema deve criar a sessão
  E deve definir tempo de expiração de 15 minutos
  E deve retornar os dados da sessão

Cenário: Buscar sessão existente
  Dado que existe uma sessão de checkout ativa
  Quando o frontend buscar os dados da sessão
  Então o sistema deve retornar os dados completos
  E deve incluir o tempo restante

Cenário: Validar sessão ativa
  Dado que uma requisição é feita com sessionId
  Quando a sessão estiver expirada
  Então o sistema deve retornar erro de sessão expirada
  E deve liberar os ingressos reservados

Cenário: Extender tempo de sessão
  Dado que a sessão está próxima do vencimento
  E o usuário realizou uma ação
  Quando o sistema extender a sessão
  Então o novo tempo deve ser adicionado ao atual

Cenário: Expirar sessão automaticamente
  Dado que o tempo de 15 minutos terminou
  Quando o sistema verificar as sessões expiradas
  Então deve liberar os ingressos reservados
  E deve marcar a sessão como expirada

# Validação de Participantes

Cenário: Validar dados dos participantes
  Dado que o frontend enviou os dados dos participantes
  Quando cada participante tiver nome, e-mail e telefone
  E os campos estiverem no formato correto
  Então o sistema deve validar com sucesso
  E deve salvar os participantes na sessão

Cenário: Validar e-mail com formato inválido
  Dado que o participante enviou e-mail "email-invalido"
  Quando o sistema validar o formato
  Então deve retornar erro de formato inválido

Cenário: Validar campos customizados obrigatórios
  Dado que existe campo customizado obrigatório
  Quando o participante não preencher
  Then o sistema deve retornar erro de campo obrigatório

# Responsável pelos Ingressos

Cenário: Salvar responsável como participante
  Dado que o participante escolheu ser o responsável
  E forneceu seus dados
  Quando o sistema salvar o responsável
  Then deve vincular ao primeiro participante

Cenário: Salvar responsável diferente dos participantes
  Dado que outra pessoa foi escolhida como responsável
  E foram fornecidos nome, e-mail e telefone
  Quando o sistema salvar
  Then deve criar registro de responsável separado

# Confirmação do Checkout

Cenário: Confirmar inscrição gratuita
  Dado que todos os dados foram validados
  E o responsável está definido
  E os termos foram aceitos
  Quando confirmar o checkout
  Then o sistema deve criar o pedido
  And deve criar conta automaticamente para o responsável
  And deve vincular os ingressos ao pedido
  And deve enviar e-mail de boas-vindas
  And deve enviar e-mail de confirmação

Cenário: E-mail do responsável já existe
  Dado que o e-mail do responsável já está cadastrado
  Quando confirmar o checkout
  Then o sistema deve usar a conta existente
  And não deve criar nova conta
  And deve vincular os ingressos à conta existente

Cenário: Confirmar checkout com dados incompletos
  Dado que faltam dados obrigatórios
  Quando confirmar o checkout
  Then o sistema deve retornar erro de validação
  And não deve processar a confirmação

# Casos de Exceção - Lei de Murphy

Cenário: Falha na criação de conta automática
  Dado que o sistema tentou criar conta automática
  E ocorreu erro no banco de dados
  When o processo de confirmação falhar
  Then o sistema deve fazer rollback da transação
  And deve retornar erro para o frontend
  And não deve confirmar o pedido

Cenário: Falha no envio de e-mail
  Dado que o pedido foi confirmado
  E o sistema tentou enviar e-mail
  E o serviço de e-mail está indisponível
  Then o pedido deve ser confirmado mesmo assim
  And deve registrar erro para retry posterior

Cenário: Concurrency - dois checkouts simultâneos
  Dado que existem dois participantes tentando comprar
  O último ingresso disponível
  Quando ambos confirmarem simultaneamente
  Then apenas um deve conseguir confirmar
  And o outro deve receber erro de indisponibilidade

Cenário: Sessão expirada durante confirmação
  Dado que o usuário está confirmando
  E a sessão expira nesse momento
  Then o sistema deve rechazar a confirmação
  And deve retornar erro de sessão expirada

Cenário: Falha em validação de cupom
  Dado que o participante tentou aplicar cupom
  E o código é inválido ou expirado
  Then o sistema deve retornar erro de cupom inválido
  And deve manter o valor total como R$ 0,00

Cenário: Dados inconsistentes entre frontend e backend
  Dado que os dados enviados não conferem com a sessão
  Then o sistema deve rechazar a operação
  And deve retornar erro de inconsistência
