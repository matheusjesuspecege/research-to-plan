# Backend - UC-02 Checkout Nominal Gratuito

## Endpoints API

### Sessão de Checkout

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | /checkout/session/{sessionId} | Buscar dados da sessão de checkout |
| POST | /checkout/session | Criar nova sessão de checkout |

### Participantes

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /checkout/participants | Validar e salvar dados dos participantes |
| GET | /checkout/participants/{sessionId} | Listar participantes da sessão |

### Responsável

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /checkout/responsible | Salvar responsável pelos ingressos |
| GET | /checkout/responsible/{sessionId} | Buscar responsável da sessão |

### Confirmação

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | /checkout/confirm | Confirmar inscrição (checkout gratuito) |

### Validações

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | /checkout/validate/email/{email} | Verificar se e-mail já existe |

## Serviços

### CheckoutSessionService

```typescript
interface ICheckoutSessionService {
  createSession(eventId: string, ticketSelections: TicketSelection[]): Promise<CheckoutSession>;
  getSession(sessionId: string): Promise<CheckoutSession | null>;
  validateSession(sessionId: string): boolean;
  extendSession(sessionId: string, minutes: number): Promise<boolean>;
  expireSession(sessionId: string): Promise<void>;
}
```

### ParticipantService

```typescript
interface IParticipantService {
  validateParticipants(participants: ParticipantInput[]): Promise<ValidationResult>;
  saveParticipants(sessionId: string, participants: ParticipantInput[]): Promise<Participant[]>;
  getParticipantsBySession(sessionId: string): Promise<Participant[]>;
}
```

### ResponsibleService

```typescript
interface IResponsibleService {
  validateResponsible(responsible: ResponsibleInput): Promise<ValidationResult>;
  saveResponsible(sessionId: string, responsible: ResponsibleInput): Promise<Responsible>;
  getResponsibleBySession(sessionId: string): Promise<Responsible | null>;
}
```

### OrderService

```typescript
interface IOrderService {
  createOrder(sessionId: string): Promise<Order>;
  confirmOrder(orderId: string): Promise<Order>;
  getOrder(orderId: string): Promise<Order | null>;
  cancelOrder(orderId: string): Promise<boolean>;
}
```

### AccountService

```typescript
interface IAccountService {
  createAccountIfNotExists(email: string, name: string, phone: string): Promise<UserAccount>;
  findByEmail(email: string): Promise<UserAccount | null>;
  linkOrderToAccount(accountId: string, orderId: string): Promise<boolean>;
}
```

### EmailService

```typescript
interface IEmailService {
  sendWelcomeEmail(userId: string, email: string, name: string): Promise<boolean>;
  sendConfirmationEmail(orderId: string, email: string, orderDetails: Order): Promise<boolean>;
}
```

## Ordem de Implementação

1. **CheckoutSessionService** - Gerenciamento de sessão (criação, validação, expiração)
2. **ParticipantService** - Validação e persistência de participantes
3. **ResponsibleService** - Gerenciamento do responsável
4. **OrderService** - Criação e confirmação do pedido
5. **AccountService** - Criação automática de conta
6. **EmailService** - Envio de e-mails transacionais

## Regras de Negócio

1. Sessão expira em 15 minutos
2. E-mail do responsável é usado para criação de conta
3. Se e-mail já existe, usar conta existente
4. Transação deve ser atômica (rollback em caso de falha)
5. Todos os campos obrigatórios devem ser validados antes da confirmação
