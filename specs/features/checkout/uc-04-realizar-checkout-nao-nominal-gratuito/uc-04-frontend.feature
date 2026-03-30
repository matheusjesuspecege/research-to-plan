# UC-04 - Frontend BDD

## Funcional

### Cenário: Exibir checkout não nominal gratuito
**Dado** que o participante está na página de checkout
**Quando** carrega com tickets não nominais gratuitos selecionados
**Então** exibe apenas o Bloco 2 (sem Bloco 1 e sem Bloco 3)
**E** exibe resumo do pedido com valor R$ 0,00

### Cenário: Aceitar termos e condições
**Dado** que o participante está no checkout não nominal gratuito
**Quando** marca checkbox de termos e condições
**Então** o botão de confirmar inscrição é habilitado

### Cenário: Recusar termos e condições
**Dado** que o participante está no checkout não nominal gratuito
**Quando** não marca checkbox de termos e condições
**Então** o botão de confirmar inscrição permanece desabilitado

### Cenário: Confirmar inscrição gratuita com sucesso
**Dado** que o participante aceitou os termos
**E** está autenticado
**Quando** clica em "Confirmar inscrição"
**Então** a API de confirmação é chamada
**E** após sucesso, redireciona para página de confirmação

### Cenário: Exibir consentimento de contato opcional
**Dado** que o participante está no checkout
**Quando** visualiza os termos
**Então** o checkbox de consentimento de contato é opcional

---

## Lei de Murphy (Cenários de Erro)

### Cenário: Sessão expirada
**Dado** que o tempo de 15 minutos expirou
**Quando** o participante tenta confirmar a inscrição
**Então** exibe mensagem de erro "Sessão expirada"
**E** redireciona para página inicial ou重新 cria sessão

### Cenário: Termos não aceitos
**Dado** que o participante não aceitou os termos
**Quando** clica em "Confirmar inscrição"
**Então** exibe mensagem de erro "Você precisa aceitar os termos para continuar"

### Cenário: Erro ao confirmar inscrição
**Dado** que o participante aceitou os termos
**Quando** ocorre erro na API ao confirmar
**Então** exibe mensagem de erro amigável
**E** mantém o participante na página de checkout

### Cenário: Usuário não autenticado ao acessar checkout
**Dado** que o participante não está logado
**Quando** tenta acessar a página de checkout
**Então** redireciona para página de login/cadastro

### Cenário: Usuário não autenticado ao tentar confirmar
**Dado** que o participante está no checkout
**Quando** tenta confirmar sem estar autenticado
**Então** redireciona para página de login

### Cenário: Falha de rede ao carregar sessão
**Dado** que há falha de conexão
**Quando** tenta carregar a página de checkout
**Then** exibe mensagem de erro de conexão
**E** oferece opção de tentar novamente

### Cenário: Falha de rede ao confirmar
**Dado** que há falha de conexão
**Quando** tenta confirmar a inscrição
**Then** exibe mensagem de erro de conexão
**E** mantém os dados preenchidos

### Cenário: Evento não encontrado
**Dado** que o eventId é inválido
**Quando** tenta acessar o checkout
**Then** exibe mensagem de evento não encontrado

### Cenário: Ingressos indisponíveis
**Dado** que os tickets selecionados não estão mais disponíveis
**Quando** carrega o checkout
**Then** exibe mensagem de indisponibilidade
**E** redireciona para página do evento

### Cenário: Timeout da requisição
**Dado** que a requisição demorou mais que 30 segundos
**When** tenta confirmar
**Then** exibe mensagem de timeout
**E** oferece opção de tentar novamente

### Cenário: Erro genérico não mapeado
**Dado** que ocorre um erro inesperado
**Quando** tenta confirmar
**Then** exibe mensagem de erro genérica
**E** registra erro para análise
