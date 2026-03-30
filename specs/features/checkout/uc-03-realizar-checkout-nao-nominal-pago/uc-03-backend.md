# UC-03 - Backend

Serviços, repositories e artefatos relacionados ao backend para o caso de uso Realizar Checkout Não Nominal Pago.

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

### TicketResponsibleService
Gerencia dados do responsável pelos Ingressos.

**Responsabilidades:**
- Validar dados do responsável
- Salvar responsável na sessão (única opção: "Outro")

**Métodos:**
- `validateResponsible(responsible: TicketResponsible): ValidationResult`
- `saveTicketResponsible(sessionId: string, responsible: TicketResponsible): void`

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
- `cancelPayment(transactionId: string): boolean`

### OrderService
Gerencia pedidos.

**Responsabilidades:**
- Criar pedido após pagamento confirmado
- Gerenciar status do pedido
- Gerar códigos QR para Ingressos

**Métodos:**
- `createOrder(sessionId: string, paymentId: string, ticketResponsible: TicketResponsible): Order`
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
- Enviar e-mail com Ingressos

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
| POST | `/api/v1/checkout/ticket-responsible` | CheckoutController |
| POST | `/api/v1/checkout/validate-coupon` | CheckoutController |
| POST | `/api/v1/checkout/complete` | CheckoutController |
| GET | `/api/v1/orders/:orderId` | OrderController |

---

## 4. Casos de BDD (Backend)

### Feature: Checkout Não Nominal Pago

```gherkin
# Scenario: Checkout com pagamento aprovado
Given que o participante selecionou tickets não nominais pagos
And preencheu os dados do responsável pelos Ingressos corretamente
And escolheu método de pagamento "pix"
When o pagamento for aprovado pelo gateway
Then deve criar conta automática para o responsável pelos Ingressos
And deve gerar Ingressos vinculados ao responsável
And deve enviar e-mail de boas-vindas
And deve enviar e-mail com os Ingressos
And deve retornar status de sucesso

# Scenario: Checkout com pagamento recusado
Given que o participante selecionou tickets não nominais pagos
And preencheu os dados corretamente
When o pagamento for recusado pelo gateway
Then deve retornar erro de pagamento
And deve manter os dados preenchidos
And não deve criar conta
And não deve enviar e-mails

# Scenario: Checkout com tempo expirado
Given que o participante iniciou o checkout
When o tempo de 15 minutos expirar
Then deve liberar os Ingressos reservados
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

# Scenario: E-mail do responsável já cadastrado
Given que o e-mail do responsável pelos Ingressos já existe na base
When o checkout for concluído com sucesso
Then deve usar conta existente
And deve vincular Ingressos à conta existente
And não deve enviar e-mail de boas-vindas

# Scenario: Dados do responsável inválidos
Given que o participante preencheu dados do responsável com e-mail inválido
When clicar em "Avançar"
Then deve exibir erro de validação
And deve bloquear avanço para próximo bloco

# Scenario: Alteração de método de pagamento
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

# Scenario: Responsável pelos Ingressos diferente do comprador
Given que o participante preencheu dados do responsável pelos Ingressos
And preencheu dados do comprador diferentes
When o checkout for concluído
Then deve criar conta para o responsável pelos Ingressos
And deve vincular Ingressos ao responsável
And deve vincular compra ao comprador

# Scenario: Ingresso não nominal não exibe dados de participantes
Given que o evento tem apenas Ingressos não nominais
When o participante acessar o checkout
Then não deve exibir Bloco 1 (dados dos participantes)
And deve iniciar no Bloco 2 (responsável pelos Ingressos)
```

---

## 5. Dependências Externas

- **Gateway de Pagamento**: Integração com API de pagamento (Pix, Cartão, Boleto)
- **Serviço de E-mail**: Envio de e-mails transacionais
- **Banco de Dados**: Persistência de pedidos, usuários, sessões

---

## 6. Ordens de Implementação

1. **CheckoutSession** - Base do fluxo
2. **TicketResponsibleService** - Dados do responsável (única opção "Outro")
3. **CouponService** - Descontos
4. **PaymentService** - Integração com gateway
5. **OrderService** - Criação de pedidos e geração de Ingressos
6. **UserService** - Criação automática de contas
7. **EmailService** - Envio de e-mails
8. **Controllers** - Exposição da API
