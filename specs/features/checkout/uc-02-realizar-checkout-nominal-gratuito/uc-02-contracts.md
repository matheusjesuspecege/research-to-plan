# Contratos - UC-02 Checkout Nominal Gratuito

## Tipos/Interfaces

### Frontend → Backend

```typescript
interface CheckoutSessionResponse {
  id: string;
  eventId: string;
  tickets: TicketSelection[];
  expiresAt: number;
  status: 'active' | 'expired' | 'completed';
  totalAmount: number;
}

interface ParticipantInput {
  name: string;
  email: string;
  phone: string;
  customFields?: Record<string, any>;
}

interface ResponsibleInput {
  name: string;
  email: string;
  phone: string;
  isParticipant: boolean;
}

interface CheckoutParticipantsRequest {
  sessionId: string;
  participants: ParticipantInput[];
}

interface CheckoutResponsibleRequest {
  sessionId: string;
  responsible: ResponsibleInput;
  termsAccepted: boolean;
  contactOptIn?: boolean;
}

interface CheckoutConfirmationRequest {
  sessionId: string;
}
```

### Backend → Frontend

```typescript
interface ValidationError {
  field: string;
  message: string;
}

interface ParticipantsValidationResponse {
  valid: boolean;
  errors?: ValidationError[];
}

interface ResponsibleValidationResponse {
  valid: boolean;
  errors?: ValidationError[];
}

interface CheckoutConfirmationResponse {
  success: boolean;
  orderId: string;
  userId: string;
  emailSent: boolean;
  redirectUrl?: string;
}

interface CheckoutErrorResponse {
  error: string;
  code: string;
  details?: any;
}
```

### Entidades

```typescript
interface CheckoutSession {
  id: string;
  eventId: string;
  userId?: string;
  tickets: TicketSelection[];
  participants: Participant[];
  responsible?: Responsible;
  totalAmount: number;
  status: SessionStatus;
  expiresAt: Date;
  createdAt: Date;
}

interface Order {
  id: string;
  eventId: string;
  sessionId: string;
  items: OrderItem[];
  responsible: Responsible;
  participants: Participant[];
  subtotal: number;
  discount: number;
  total: number;
  status: OrderStatus;
  paymentId?: string;
  createdAt: Date;
  confirmedAt?: Date;
}

interface Participant {
  id: string;
  orderId: string;
  ticketId: string;
  name: string;
  email: string;
  phone: string;
  customFields?: Record<string, any>;
  status: ParticipantStatus;
}

interface Responsible {
  id: string;
  orderId: string;
  userId?: string;
  name: string;
  email: string;
  phone: string;
  isParticipant: boolean;
}

type SessionStatus = 'pending' | 'active' | 'expired' | 'completed';
type OrderStatus = 'pending' | 'confirmed' | 'cancelled';
type ParticipantStatus = 'pending' | 'confirmed' | 'cancelled';
```

### Event

```typescript
interface Event {
  id: string;
  name: string;
  date: Date;
  location: string;
  tickets: Ticket[];
}

interface Ticket {
  id: string;
  eventId: string;
  name: string;
  description?: string;
  price: number;
  quantity: number;
  sold: number;
  isNominal: boolean;
  customFields?: CustomField[];
}

interface CustomField {
  id: string;
  name: string;
  type: 'text' | 'number' | 'select' | 'checkbox';
  required: boolean;
  options?: string[];
}
```
