# UC-04 - Backend BDD

## Funcional

### Cenário: Criar sessão de checkout
**Dado** que o evento existe com tickets não nominais gratuitos
**Quando** o participante autenticado solicita criar sessão com tickets
**Então** a sessão é criada com status "pending"
**E** retorna os dados da sessão com tempo de expiração

### Cenário: Obter sessão de checkout
**Dado** que a sessão de checkout existe
**Quando** solicita os dados da sessão
**Então** retorna os dados completos da sessão

### Cenário: Confirmar inscrição gratuita
**Dado** que a sessão de checkout existe e está válida
**E** o participante aceitou os termos
**Quando** confirma a inscrição
**Then** os tickets são vinculados à conta do participante
**E** o pedido é criado com status "confirmed"
**E** o e-mail de confirmação é enviado

### Cenário: Confirmar sem opt-in de contato
**Dado** que o participante confirma sem consentimento de contato
**Quando** o sistema processa a confirmação
**Então** cria o vínculo sem opt-in de marketing
**E** envia apenas e-mail transacional

---

## Lei de Murphy (Cenários de Erro)

### Cenário: Sessão não encontrada
**Dado** que o sessionId é inválido
**Quando** tenta obter a sessão
**Then** retorna erro 404 "Sessão não encontrada"

### Cenário: Sessão expirada
**Dado** que a sessão de checkout expirou
**Quando** o participante tenta confirmar
**Then** retorna erro 400 "Sessão expirada"

### Cenário: Sessão já utilizada
**Dado** que a sessão já foi utilizada
**When** tenta confirmar novamente
**Then** retorna erro 400 "Sessão já utilizada"

### Cenário: Termos não aceitos
**Dado** que o participante não aceitou os termos
**When** tenta confirmar
**Then** retorna erro 400 "Termos não aceitos"

### Cenário: Usuário não autenticado
**Dado** que o participante não está autenticado
**When** tenta criar sessão
**Then** retorna erro 401 "Usuário não autenticado"

### Cenário: Evento não encontrado
**Dado** que o eventId é inválido
**When** tenta criar sessão
**Then** retorna erro 404 "Evento não encontrado"

### Cenário: Ticket não encontrado
**Dado** que um ticketId é inválido
**When** tenta criar sessão
**Then** retorna erro 404 "Ticket não encontrado"

### Cenário: Ticket indisponível
**Dado** que não há disponibilidade do ticket
**When** tenta criar sessão
**Then** retorna erro 400 "Ticket indisponível"

### Cenário: Falha ao vincular tickets
**Dado** que a sessão é válida e termos aceitos
**Quando** ocorre falha no banco de dados ao vincular
**Then** retorna erro 500 "Falha ao vincular inscrição"
**E** não cria o pedido

### Cenário: Falha ao enviar e-mail
**Dado** que a confirmação foi concluída
**Quando** o envio de e-mail falha
**Then** retorna sucesso na criação do pedido
**E** registra erro de falha de e-mail para retry

### Cenário: Usuário não encontrado durante confirmação
**Dado** que a sessão existe
**Quando** o usuário não é encontrado no sistema
**Then** retorna erro 404 "Usuário não encontrado"

### Cenário: Quantidade inválida de tickets
**Dado** que a quantidade de tickets é zero ou negativa
**When** tenta criar sessão
**Then** retorna erro 400 "Quantidade inválida"

### Cenário: Múltiplas tentativas simultâneas
**Dado** que o participante tenta confirmar múltiplas vezes simultaneamente
**When** o sistema processa as requisições
**Then** apenas uma confirmação é processada
**E** as demais retornam erro

### Cenário: Banco de dados indisponível
**Dado** que o banco de dados está indisponível
**When** tenta criar sessão
**Then** retorna erro 503 "Serviço temporariamente indisponível"
