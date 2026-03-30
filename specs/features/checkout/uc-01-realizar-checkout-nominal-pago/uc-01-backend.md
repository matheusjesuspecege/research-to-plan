# UC-01 - Backend

Serviços, repositories e artefatos relacionados ao backend para o caso de uso Realizar Checkout Nominal Pago.

---

## 1. Serviços (Services)

### CheckoutService
Responsável por gerenciar toda a sessão de checkout.

**Responsabilidades:**
- Criar e gerenciar sessão de checkout
- Validar disponibilidade de ingressos
- Controlar tempo de expiração (15 minutos)
- Calcular valores do pedido

**Métodos:**
- `createSession(eventId: string, tickets: TicketSelection[]): CheckoutSession`
- `getSession(sessionId: string): CheckoutSession`
- `validateSession(sessionId: string): boolean`
- `extendSession(sessionId: string): CheckoutSession`
- `expireSession(sessionId: string): void`

### ParticipantService
Gerencia dados dos participantes.

**Responsabilidades:**
- Validar dados de participantes
- Salvar dados temporários na sessão

**Métodos:**
- `validateParticipants(participants: ParticipantData[]): ValidationResult`
- `saveParticipants(sessionId: string, participants: ParticipantData[]): void`

### CouponService
Gerencia cupons de desconto.

**Responsabilidades:**
- Validar cupons
- Aplicar descontos

**Métodos:**
- `validateCoupon(code: string, eventId: string, amount: number): CouponValidationResponse`
- `applyCoupon(sessionId: string, coupon: CouponInfo): OrderSummary`
- `removeCoupon(sessionId: string): OrderSummary`

### PaymentService
Processa pagamentos via gateway.

**Responsabilidades:**
- Criar transação de pagamento
- Processar diferentes métodos (Pix, Cartão, Boleto)
- Verificar status de pagamento

**Métodos:**
- `createPayment(request: PaymentRequest): PaymentResponse`
- `processPayment(paymentId: string): PaymentResult`
- `verifyPaymentStatus(transactionId: string): PaymentStatus`
- `cancelPayment(transactionId: string): bool`

### OrderService
Gerencia pedidos.

**Responsabilidades:**
- Criar pedido após pagamento confirmado
- Gerenciar status do pedido

**Métodos:**
- `createOrder(sessionId: string, paymentId: string): Order`
- `getOrder(orderId: string): Order`
- `updateOrderStatus(orderId: string, status: OrderStatus): void`
- `linkTicketsToUser(orderId: string, userId: string): void`

### UserService
Gerencia criação automática de contas.

**Responsabilidades:**
- Criar conta automaticamente após checkout
- Verificar se e-mail já existe
- Vincular pedido à conta existente

**Métodos:**
- `createAccountIfNotExists(email: string, name: string): UserAccount`
- `getUserByEmail(email: string): UserAccount | null`
- `linkOrderToUser(userId: string, orderId: string): void`

### EmailService
Envia e-mails transacionais.

**Responsabilidades:**
- Enviar e-mail de boas-vindas
- Enviar e-mail comingressos

**Métodos:**
- `sendWelcomeEmail(userId: string, tempPassword?: string): void`
- `sendTicketEmail(orderId: string, userId: string): void`
- `sendConfirmationEmail(orderId: string): void`

---

## 2. Repositories

### CheckoutSessionRepository
- `findById(sessionId: string): CheckoutSession`
- `save(session: CheckoutSession): void`
- `update(session: CheckoutSession): void`
- `delete(sessionId: string): void`

### OrderRepository
- `findById(orderId: string): Order`
- `save(order: Order): void`
- `findByUserId(userId: string): Order[]`
- `findByEventId(eventId: string): Order[]`

### TicketRepository
- `findById(ticketId: string): Ticket`
- `reserveTickets(tickets: TicketSelection[]): Reservation`
- `releaseTickets(reservationId: string): void`
- `confirmTickets(reservationId: string, userId: string): void`

### CouponRepository
- `findByCode(code: string): Coupon`
- `validate(coupon: Coupon, amount: number): boolean`

---

## 3. Controllers/Routes

| Método | Endpoint | Controller |
|--------|----------|------------|
| GET | `/api/v1/checkout/session/:sessionId` | CheckoutController |
| POST | `/api/v1/checkout/participants` | CheckoutController |
| POST | `/api/v1/checkout/responsible` | CheckoutController |
| POST | `/api/v1/checkout/validate-coupon` | CheckoutController |
| POST | `/api/v1/checkout/complete` | CheckoutController |
| GET | `/api/v1/orders/:orderId` | OrderController |

---

## 4. Casos de BDD (Backend)

### Feature: Checkout Nominal Pago

```gherkin
# Scenario: Checkout com pagamento aprovado
Given que o participante selecionou tickets nominais pagos
And preencheu os dados de todos os participantes corretamente
And selecionou o responsável pelos ingressos
And escolheu método de pagamento "pix"
When o pagamento for aprovado pelo gateway
Then deve criar conta automática para o responsável
And deve vincular os ingressos à conta
And deve enviar e-mail de boas-vindas
And deve enviar e-mail com os ingressos
And deve retornar status de sucesso

# Scenario: Checkout com pagamento recusado
Given que o participante selecionou tickets nominais pagos
And preencheu os dados corretamente
When o pagamento for recusado pelo gateway
Then deve retornar erro de pagamento
And deve manter os dados preenchidos
And não deve criar conta
And não deve enviar e-mails

# Scenario: Checkout com tempo expirado
Given que o participante iniciou o checkout
When o tempo de 15 minutos expirar
Then deve liberar os ingressos reservados
And deve redirecionar para página do evento

# Scenario: Cupom válido aplicado
Given que o participante insere um código de cupom válido
When o sistema validar o cupom
Then deve aplicar o desconto no total
And deve exibir valor atualizado no resumo

# Scenario: Cupom inválido
Given que o participante insere um código de cupom inválido
When o sistema validar o cupom
Then deve exibir mensagem de erro
And não deve aplicar desconto

# Scenario: E-mail já cadastrado
Given que o e-mail do responsável já existe na base
When o checkout for concluído com sucesso
Then deve usar conta existente
And deve vincular ingressos à conta existente
And não deve enviar e-mail de boas-vindas

# Scenario: Múltiplos participantes com dados inválidos
Given que o participante preenche dados de múltiplos participantes
When um dos participantes tiver dados inválidos
Then deve indicar qual campo está inválido
And deve bloquear avanço para próximo bloco

# Scenario:Alteração de método de pagamento
Given que o participante selecionou método de pagamento "cartão"
And os dados do cartão foram informados
When o participante decidir alterar para "pix"
Then deve limpar os dados do cartão
And exibir campos do método pix

# Scenario: Remoção de cupom aplicado
Given que o participante tem um cupom aplicado
When clicar para remover o cupom
Then deve remover o desconto
And deve atualizar o total para valor original
```

---

## 5. Dependências Externas

- **Gateway de Pagamento**: Integração com API de pagamento (Pix, Cartão, Boleto)
- **Serviço de E-mail**: Envio de e-mails transacionais
- **Banco de Dados**: Persistência de pedidos, usuários, sessões

---

## 6. Ordens de Implementação

1. **CheckoutSession** - Base do fluxo
2. **ParticipantService** - Validação de dados
3. **CouponService** - Descontos
4. **PaymentService** - Integração com gateway
5. **OrderService** - Criação de pedidos
6. **UserService** - Criação automática de contas
7. **EmailService** - Envio de e-mails
8. **Controllers** - Exposição da API
