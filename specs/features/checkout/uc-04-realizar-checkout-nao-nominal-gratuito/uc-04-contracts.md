# UC-04 - Contratos

## Visão Geral
Este documento define os contratos (types, interfaces, DTOs) necessários para a implementação do caso de uso UC-04 - Realizar Checkout Não Nominal Gratuito.

---

## Tipos e Interfaces

### Frontend Types

```typescript
// Types do Frontend

interface CheckoutSession {
  id: string;
  eventId: string;
  tickets: TicketSelection[];
  expiresAt: number;
  status: 'pending' | 'completed' | 'expired' | 'cancelled';
}

interface TicketSelection {
  ticketId: string;
  ticketName: string;
  quantity: number;
  price: number;
  isNominal: boolean;
}

interface OrderSummary {
  subtotal: number;
  discount: number;
  total: number;
  currency: string;
}

interface TermsAcceptance {
  termsAccepted: boolean;
  contactConsent: boolean;
}

interface CheckoutConfirmation {
  orderId: string;
  eventId: string;
  tickets: TicketSelection[];
  purchaseDate: string;
  status: 'confirmed' | 'pending' | 'failed';
}

interface CheckoutState {
  session: CheckoutSession | null;
  orderSummary: OrderSummary;
  terms: TermsAcceptance;
  isLoading: boolean;
  error: string | null;
}
```

### Backend Types

```typescript
// DTOs do Backend

interface CreateCheckoutSessionRequest {
  eventId: string;
  ticketSelections: TicketSelectionDto[];
}

interface TicketSelectionDto {
  ticketId: string;
  quantity: number;
}

interface ConfirmCheckoutRequest {
  sessionId: string;
  termsAccepted: boolean;
  contactConsent?: boolean;
}

interface CheckoutSessionResponse {
  id: string;
  eventId: string;
  tickets: TicketSelection[];
  expiresAt: string;
  status: string;
  orderSummary: OrderSummary;
}

interface CheckoutConfirmationResponse {
  orderId: string;
  status: 'confirmed' | 'pending' | 'failed';
  tickets: Ticket[];
  purchaseDate: string;
}

interface Ticket {
  id: string;
  eventId: string;
  eventName: string;
  ticketName: string;
  quantity: number;
  price: number;
}

interface OrderSummaryDto {
  subtotal: number;
  discount: number;
  total: number;
  currency: string;
}
```

---

## Contratos de API

### Endpoints

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /api/checkout/session | Criar sessão de checkout |
| GET | /api/checkout/session/:id | Obter sessão de checkout |
| POST | /api/checkout/confirm | Confirmar inscrição gratuita |
| GET | /api/checkout/confirmation/:orderId | Obter confirmação do pedido |

---

## Validações

### Session Creation
- eventId: obrigatório, UUID válido
- ticketSelections: obrigatório, array não vazio
- ticketId: obrigatório, UUID válido
- quantity: obrigatório, número > 0

### Confirm Checkout
- sessionId: obrigatório, UUID válido
- termsAccepted: obrigatório, booleano true

---

## Códigos de Erro

| Código | Mensagem | HTTP Status |
|--------|----------|--------------|
| SESSION_NOT_FOUND | Sessão não encontrada | 404 |
| SESSION_EXPIRED | Sessão expirada | 400 |
| TERMS_NOT_ACCEPTED | Termos não aceitos | 400 |
| NOT_AUTHENTICATED | Usuário não autenticado | 401 |
| LINKING_FAILED | Falha ao vincular inscrição | 500 |
