# UC-04 - Backend

## Visão Geral
Este documento define os serviços, endpoints e artefatos backend necessários para a implementação do caso de uso UC-04 - Realizar Checkout Não Nominal Gratuito.

---

## Order de Implementação (por dependência)

### 1. CheckoutSessionRepository
**Dependências:** Nenhuma
**Descrição:** Repositório para gerenciar sessões de checkout

### 2. TicketRepository
**Dependências:** Nenhuma
**Descrição:** Repositório para buscar dados de tickets

### 3. OrderRepository
**Dependências:** CheckoutSessionRepository
**Descrição:** Repositório para gerenciar pedidos

### 4. CheckoutSessionService
**Dependências:** CheckoutSessionRepository, TicketRepository
**Descrição:** Serviço para criar e gerenciar sessões de checkout

### 5. EmailService
**Dependências:** Nenhuma
**Descrição:** Serviço para envio de e-mails transacionais

### 6. CheckoutConfirmationService
**Dependências:** CheckoutSessionService, OrderRepository, EmailService
**Descrição:** Serviço para confirmar checkout gratuito

---

## Serviços

### CheckoutSessionService

```typescript
// interfaces/ICheckoutSessionService.ts
interface ICheckoutSessionService {
  createSession(eventId: string, ticketSelections: TicketSelectionDto[]): Promise<CheckoutSession>;
  getSession(sessionId: string): Promise<CheckoutSession | null>;
  validateSession(sessionId: string): Promise<boolean>;
  extendSession(sessionId: string): Promise<boolean>;
}
```

### CheckoutConfirmationService

```typescript
// interfaces/ICheckoutConfirmationService.ts
interface ICheckoutConfirmationService {
  confirmCheckout(sessionId: string, termsAccepted: boolean, contactConsent?: boolean): Promise<CheckoutConfirmationResponse>;
  getConfirmation(orderId: string): Promise<CheckoutConfirmationResponse>;
}
```

---

## Controllers

### CheckoutController

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /api/checkout/session | Criar sessão de checkout |
| GET | /api/checkout/session/:id | Obter sessão |
| POST | /api/checkout/confirm | Confirmar inscrição |
| GET | /api/checkout/confirmation/:orderId | Obter confirmação |

---

## Cenários de Teste BDD (Backend)

### Funcional

**Cenário:** Criar sessão de checkout com tickets não nominais gratuitos
- Dado que o evento existe com tickets não nominais gratuitos
- Quando o participante autenticado solicita criar sessão
- Então a sessão é criada com sucesso

**Cenário:** Confirmar inscrição gratuita
- Dado que a sessão de checkout existe e está válida
- E o participante aceitou os termos
- Quando confirma a inscrição
- Então os tickets são vinculados à conta
- E o e-mail de confirmação é enviado

### Lei de Murphy (Cenários de Erro)

**Cenário:** Sessão expirada ao confirmar
- Dado que a sessão de checkout expirou
- Quando o participante tenta confirmar
- Então retorna erro de sessão expirada

**Cenário:** Termos não aceitos
- Dado que o participante não aceitou os termos
- Quando tenta confirmar
- Then retorna erro de termos não aceitos

**Cenário:** Falha no vínculo da inscrição
- Dado que a sessão é válida e termos aceitos
- Quando ocorre falha ao vincular tickets
- Então retorna erro e mantém sessão

**Cenário:** Usuário não autenticado
- Dado que o participante não está autenticado
- Quando tenta criar sessão
- Then retorna erro de não autenticado

**Cenário:** Evento não encontrado
- Dado que o eventId é inválido
- Quando solicita criar sessão
- Then retorna erro de evento não encontrado

---

## Fluxo de Execução

```
1. createSession(eventId, tickets)
   └── validateEvent(eventId)
   └── validateTickets(tickets)
   └── createCheckoutSession()
   └── return session

2. confirmCheckout(sessionId, terms)
   └── validateSession(sessionId)
   └── validateTerms(terms)
   └── linkTicketsToUser()
   └── createOrder()
   └── sendConfirmationEmail()
   └── return confirmation
```

---

## Integrações Externas

- **EmailService:** Envio de e-mail de confirmação de inscrição
  - Template: checkout-confirmation-free
  - Dados: nome do evento, tickets, data da compra
