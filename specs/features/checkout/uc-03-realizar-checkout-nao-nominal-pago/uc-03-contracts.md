# UC-03 - Contratos (Contracts)

Contratos gerais utilizados pelo frontend e backend para o caso de uso Realizar Checkout Não Nominal Pago.

---

## Tipos/Interfaces

### TicketSelection
```typescript
interface TicketSelection {
  ticketId: string;
  ticketName: string;
  quantity: number;
  unitPrice: number;
  totalPrice: number;
  isNominal: boolean;
}
```

### OrderSummary
```typescript
interface OrderSummary {
  orderId: string;
  items: TicketSelection[];
  subtotal: number;
  discount: number;
  total: number;
  currency: string;
  appliedCoupon?: CouponInfo;
}
```

### CouponInfo
```typescript
interface CouponInfo {
  code: string;
  discountType: 'percentage' | 'fixed';
  discountValue: number;
  appliedAmount: number;
}
```

### CheckoutSession
```typescript
interface CheckoutSession {
  id: string;
  eventId: string;
  eventName: string;
  tickets: TicketSelection[];
  expiresAt: string;
  status: 'active' | 'expired' | 'completed';
  remainingTime: number;
}
```

### TicketResponsible
```typescript
interface TicketResponsible {
  name: string;
  email: string;
  phone: string;
}
```

### PaymentMethod
```typescript
type PaymentMethod = 'pix' | 'credit_card' | 'boleto';

interface PaymentRequest {
  method: PaymentMethod;
  amount: number;
  currency: string;
  customer: CustomerData;
  cardId?: string;
  paymentDate?: string;
}

interface CustomerData {
  name: string;
  email: string;
  phone?: string;
  document: string;
}

interface PaymentResponse {
  transactionId: string;
  status: 'pending' | 'approved' | 'rejected' | 'cancelled';
  method: PaymentMethod;
  amount: number;
  createdAt: string;
  approvedAt?: string;
  qrCode?: string;
  barcode?: string;
  paymentUrl?: string;
}
```

### CouponValidation
```typescript
interface CouponValidationRequest {
  code: string;
  eventId: string;
  orderAmount: number;
}

interface CouponValidationResponse {
  valid: boolean;
  coupon?: CouponInfo;
  message?: string;
}
```

### UserAccount
```typescript
interface UserAccount {
  id: string;
  email: string;
  name: string;
  createdAt: string;
  isNewAccount: boolean;
}
```

### CheckoutCompleteRequest
```typescript
interface CheckoutCompleteRequest {
  sessionId: string;
  ticketResponsible: TicketResponsible;
  buyer: CustomerData;
  payment: PaymentRequest;
  couponCode?: string;
  termsAccepted: boolean;
  marketingOptIn?: boolean;
}
```

### CheckoutCompleteResponse
```typescript
interface CheckoutCompleteResponse {
  success: boolean;
  orderId: string;
  transactionId: string;
  status: 'confirmed' | 'pending' | 'failed';
  userAccount?: UserAccount;
  tickets: TicketInfo[];
  confirmationEmailSent: boolean;
  errorMessage?: string;
}

interface TicketInfo {
  ticketId: string;
  qrCode: string;
  downloadUrl: string;
}
```

---

## APIs/Endpoints

| Método | Endpoint | Descrição |
|--------|----------|------------|
| GET | `/checkout/session/{sessionId}` | Obter sessão de checkout |
| POST | `/checkout/ticket-responsible` | Salvar responsável pelos ingressos |
| POST | `/checkout/validate-coupon` | Validar cupom de desconto |
| POST | `/checkout/complete` | Finalizar checkout |
| GET | `/checkout/order/{orderId}` | Obter detalhes do pedido |
