# UC-02 - Frontend BDD - Checkout Nominal Gratuito

Funcionalidade: Realizar Checkout Nominal Gratuito

Contexto:
  Dado que o usuário acessou o checkout com ingresso nominal gratuito selecionado
  E o sistema exibiu a tela única com Bloco 1 e Bloco 2

# Bloco 1 - Dados dos Participantes

Cenário: Exibir campos para preenchimento dos participantes
  Quando o Bloco 1 for carregado
  Então o sistema deve exibir campos para cada participante
  E deve mostrar o número total de participantes necessários

Cenário: Preencher dados de um participante com sucesso
  Dado que o participante está no Bloco 1
  Quando preencher o nome com "João Silva"
  E preencher o e-mail com "joao@email.com"
  E preencher o telefone com "(11) 99999-9999"
  E clicar em "Continuar"
  Então o sistema deve validar os campos
  E deve avançar para o Bloco 2

Cenário: Tentar avançar sem preencher campos obrigatórios
  Dado que o participante está no Bloco 1
  E deixou o campo nome vazio
  Quando clicar em "Continuar"
  Então o sistema deve exibir erro no campo nome
  E deve manter no Bloco 1

Cenário: Preencher e-mail em formato inválido
  Dado que o participante está no Bloco 1
  E preencheu o campo e-mail com "email-invalido"
  Quando o campo perder o foco
  Então o sistema deve exibir erro de formato inválido

Cenário: Adicionar campos customizados do organizador
  Dado que o evento possui campos customizados configurados
  Quando o Bloco 1 for carregado
  Então o sistema deve exibir os campos customizados

Cenário: Preencher campo customizado obrigatório
  Dado que existe um campo customizado obrigatório
  Quando o participante não preencher o campo
  E clicar em "Continuar"
  Então o sistema deve exibir erro no campo customizado

# Bloco 2 - Responsável pelos Ingressos

Cenário: Selecionar responsável como participante
  Dado que o participante avançou para o Bloco 2
  Quando selecionar "Eu serei o responsável"
  E os campos forem pré-preenchidos com dados do primeiro participante
  E clicar em "Confirmar inscrição"
  Então o sistema deve processar a confirmação

Cenário: Selecionar outra pessoa como responsável
  Dado que o participante avançou para o Bloco 2
  Quando selecionar "Outra pessoa será responsável"
  E preencher o nome do responsável
  E preencher o e-mail do responsável
  E preencher o telefone do responsável
  E clicar em "Confirmar inscrição"
  Então o sistema deve processar a confirmação

Cenário: Aceitar termos e condições
  Dado que o participante está no Bloco 2
  Quando marcar "Aceito os termos e condições"
  E clicar em "Confirmar inscrição"
  Então o sistema deve habilitar o botão de confirmação

Cenário: Tentar confirmar sem aceitar termos
  Dado que o participante está no Bloco 2
  E não marcou "Aceito os termos e condições"
  Quando clicar em "Confirmar inscrição"
  Então o sistema deve exibir mensagem para aceitar os termos
  E o botão deve permanecer desabilitado

# Timer de Expiração

Cenário: Exibir contador regressivo
  Dado que o usuário está no checkout
  Então o sistema deve exibir contador de 15 minutos
  E o contador deve decrementar a cada segundo

Cenário: Expirar sessão ao final do tempo
  Dado que o contador chegou a zero
  Quando o tempo expirar
  Então o sistema deve exibir mensagem de sessão expirada
  E deve redirecionar para a página do evento

Cenário: Reiniciar checkout após expiração
  Dado que a sessão expirou
  E o usuário acessa novamente o checkout
  E os ingressos ainda estão disponíveis
  Quando iniciar novo checkout
  Então o sistema deve criar nova sessão com novo timer

# Confirmação

Cenário: Confirmar inscrição com sucesso
  Dado que todos os dados foram validados
  E os termos foram aceitos
  Quando clicar em "Confirmar inscrição"
  Então o sistema deve enviar os dados para o backend
  E deve exibir tela de confirmação
  E deve mostrar mensagem de sucesso

Cenário: E-mail já cadastrado no sistema
  Dado que o e-mail do responsável já existe na base
  Quando confirmar a inscrição
  Então o sistema deve usar a conta existente
  E deve vincular os ingressos à conta existente

Cenário: Erro ao confirmar inscrição
  Dado que houve erro no processamento
  Quando confirmar a inscrição
  Então o sistema deve exibir mensagem de erro
  E deve manter os dados preenchidos

# Casos de Exceção - Lei de Murphy

Cenário: Perda de conexão durante preenchimento
  Dado que o usuário está preenchendo os dados
  E a conexão com a internet é perdida
  Quando tentar continuar
  Então o sistema deve exibir mensagem de erro de conexão
  E deve salvar os dados localmente como rascunho

Cenário: Timeout na resposta do servidor
  Dado que o usuário enviou os dados
  E o servidor não respondeu no tempo esperado
  Quando atingir o timeout
  Então o sistema deve exibir mensagem de erro
  E deve permitir reenvio dos dados

Cenário: Perda de sessão ao retornar para página anterior
  Dado que o usuário navegou para outra aba
  E retornou para o checkout
  Então o sistema deve verificar se a sessão ainda está ativa
  E se expirou, deve notificar o usuário
