# UC-03 - Frontend

Componentes, páginas e artefatos relacionados ao frontend para o caso de uso Realizar Checkout Não Nominal Pago.

---

## 1. Páginas (Pages)

### CheckoutPage
Página principal do checkout.

**Estrutura:**
- Layout com dois blocos verticais (sem Bloco 1)
- Painel lateral com resumo do pedido e contador
- Navegação entre blocos via scroll ou botões

**Estados:**
- `loading` - Carregando sessão
- `active` - Checkout em andamento
- `processing` - Processando pagamento
- `completed` - Checkout concluído
- `expired` - Sessão expirada
- `error` - Erro no processo

---

## 2. Componentes (Components)

### Bloco 1: Recebimento dos Ingressos (Primeiro bloco para não nominal)

#### TicketResponsibleForm
Formulário para preenchimento dos dados do responsável pelos Ingressos.

**Props:**
- `initialData?: TicketResponsible`
- `onChange: (data: TicketResponsible) => void`
- `onValidationChange: (valid: boolean) => void`

**Campos:**
- Nome completo (obrigatório)
- E-mail (obrigatório, válido)
- Celular (obrigatório, formato válido)

**Estados:**
- `empty` - Campo vazio
- `focused` - Campo em foco
- `valid` - Campo válido
- `invalid` - Campo com erro
- `disabled` - Campo desabilitado

#### TermsAcceptance
Componente de aceite de termos.

**Props:**
- `accepted: boolean`
- `onChange: (accepted: boolean) => void`
- `marketingOptIn?: boolean`
- `onMarketingChange: (optIn: boolean) => void`

---

### Bloco 2: Pagamento

#### PaymentMethodSelector
Seleção do método de pagamento.

**Props:**
- `selectedMethod?: PaymentMethod`
- `onChange: (method: PaymentMethod) => void`
- `availableMethods: PaymentMethod[]`

**Métodos disponíveis:**
- Pix
- Cartão de Crédito
- Boleto

#### CreditCardForm
Formulário de dados do cartão de crédito.

**Props:**
- `cardData?: CreditCardData`
- `onChange: (data: CreditCardData) => void`
- `onValidationChange: (valid: boolean) => void`

**Campos:**
- Número do cartão
- Nome no cartão
- Validade
- CVV

#### CouponInput
Campo para inserção de cupom de desconto.

**Props:**
- `appliedCoupon?: CouponInfo`
- `onApply: (code: string) => void`
- `onRemove: () => void`

**Estados:**
- `empty` - Sem cupom
- `applying` - Aplicando cupom
- `applied` - Cupom aplicado
- `error` - Erro na aplicação

#### BuyerDataForm
Dados do comprador (pode ser diferente do responsável pelos Ingressos).

**Props:**
- `buyerData?: CustomerData`
- `onChange: (data: CustomerData) => void`
- `sameAsResponsible?: boolean`
- `onSameAsResponsibleChange?: (same: boolean) => void`

**Funcionalidade:**
- Campo "Same as ticket responsible" para pré-preencher

---

### Componentes Compartilhados

#### OrderSummary
Painel lateral com resumo do pedido.

**Props:**
- `order: OrderSummary`
- `remainingTime: number`

**Exibe:**
- Lista de Ingressos
- Subtotal
- Desconto (se aplicado)
- Total
- Contador regressivo

#### CountdownTimer
Contador regressivo de 15 minutos.

**Props:**
- `expiresAt: string`
- `onExpire: () => void`

**Estados:**
- `normal` - Tempo > 5 min
- `warning` - Tempo <= 5 min e > 1 min
- `critical` - Tempo <= 1 min

#### CheckoutStepper
Indicador de progresso entre blocos.

**Props:**
- `currentStep: number`
- `onStepClick?: (step: number) => void`

---

## 3. Hooks

### useCheckout
Gerencia estado global do checkout.

```typescript
interface UseCheckoutReturn {
  session: CheckoutSession | null;
  ticketResponsible: TicketResponsible;
  buyer: CustomerData;
  orderSummary: OrderSummary;
  paymentMethod: PaymentMethod;
  currentBlock: 1 | 2;
  isLoading: boolean;
  isProcessing: boolean;
  error: string | null;
  
  // Actions
  setTicketResponsible: (responsible: TicketResponsible) => void;
  setBuyer: (buyer: CustomerData) => void;
  applyCoupon: (code: string) => Promise<void>;
  removeCoupon: () => void;
  setPaymentMethod: (method: PaymentMethod) => void;
  nextBlock: () => void;
  prevBlock: () => void;
  completeCheckout: () => Promise<CheckoutCompleteResponse>;
}
```

### useCountdown
Gerencia o timer de expiração.

```typescript
interface UseCountdownReturn {
  remainingTime: number;
  isWarning: boolean;
  isCritical: boolean;
  isExpired: boolean;
}
```

---

## 4. Validações (Frontend)

### TicketResponsibleValidation
- Nome: mínimo 2 caracteres, máximo 100
- E-mail: formato válido de e-mail
- Celular: formato válido (+5521...)

### BuyerValidation
- Nome: mínimo 2 caracteres, máximo 100
- E-mail: formato válido de e-mail
- Documento: CPF ou CNPJ válido

### PaymentValidation
- Cartão: número válido (algoritmo de Luhn)
- Validade: data futura
- CVV: 3 ou 4 dígitos

### CheckoutValidation
- Bloco 1: Responsável com dados válidos, termos aceitos
- Bloco 2: Método selecionado, dados do comprador válidos

---

## 5. Casos de BDD (Frontend)

```gherkin
# Scenario: Checkout não nominal não exibe Bloco 1
Given que o evento tem Ingressos não nominais
When o participante acessar o checkout
Then não deve exibir Bloco 1 (dados dos participantes)
And deve exibir diretamente Bloco 2 (responsável pelos Ingressos)

# Scenario: Exibir dados do responsável inválidos
Given que o participante preencheu dados inválidos no campo "e-mail"
When o campo perder o foco
Then deve exibir mensagem de erro abaixo do campo
And deve destacar o campo em vermelho
And deve bloquear botão de avanço

# Scenario: Avançar para Bloco 2 com dados válidos
Given que todos os dados do responsável estão válidos
When clicar em "Avançar"
Then deve navegar para Bloco 2 (pagamento)
And deve salvar dados temporários

# Scenario: Contador entra em estado crítico
Given que o contador está abaixo de 1 minuto
When o tempo restante for atualizado
Then o contador deve ficar vermelho
And deve exibir mensagem de urgência

# Scenario: Tempo expirado durante checkout
Given que o tempo de 15 minutos expirou
When o sistema detectar a expiração
Then deve exibir modal de tempo expirado
And deve liberar os Ingressos
And deve redirecionar para página do evento

# Scenario: Aplicar cupom com sucesso
Given que o participante insere código "DESC20"
When clicar em "Aplicar"
Then deve exibir desconto aplicado
And deve atualizar valor total no resumo

# Scenario: Tentar aplicar cupom inválido
Given que o participante insere código inválido
When clicar em "Aplicar"
Then deve exibir mensagem de erro
And deve manter valor original

# Scenario: Exibir campos de cartão según método selecionado
Given que o método de pagamento é "cartão de crédito"
When o Bloco 2 for exibido
Then deve exibir campos do cartão

# Scenario: Exibir QR Code para método Pix
Given que o método de pagamento é "pix"
When o pagamento for iniciado
Then deve exibir QR Code para escaneamento

# Scenario: Manter dados em caso de erro de pagamento
Given que o pagamento foi recusado
When o erro for exibido
Then deve manter todos os dados preenchidos
And deve permitir nova tentativa

# Scenario: Checkout concluído com sucesso
Given que o pagamento foi aprovado
When o sistema processar a resposta
Then deve exibir tela de confirmação
And deve exibir resumo do pedido
And deve informar sobre criação de conta

# Scenario: Usar mesmos dados do responsável pelos Ingressos
Given que o participante está no Bloco 2 (pagamento)
When marcar opção "Same as ticket responsible"
Then deve pré-preencher campos do comprador com dados do responsável

# Scenario: Comprador diferente do responsável
Given que o participante preencheu dados do responsável
When desmarcar opção "Same as ticket responsible"
Then deve exibir campos para preenchimento do comprador
And deve validar campos independentemente

# Scenario: Scroll para bloco com erro de validação
Given que há erro de validação no Bloco 1
When tentar avançar para Bloco 2
Then deve manter scroll no Bloco 1
And deve destacar campos inválidos
```

---

## 6. Ordens de Implementação

1. **CountdownTimer** - Componente base
2. **OrderSummary** - Exibe dados do pedido
3. **TicketResponsibleForm** - Formulário do responsável
4. **PaymentMethodSelector** - Métodos de pagamento
5. **CouponInput** - Cupom de desconto
6. **BuyerDataForm** - Dados do comprador
7. **CheckoutStepper** - Navegação entre blocos
8. **CheckoutPage** - Composição da página
9. **useCheckout** - Hook de estado
10. **Validações** - Regras de validação

---

## 7. Tecnologias Recomendadas

- Framework: React ou similar
- Estado: Context API ou Zustand
- Formulários: React Hook Form + Zod
- HTTP Client: Axios ou Fetch
- Loading States: React Query ou SWR
