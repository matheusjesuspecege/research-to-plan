# UC-01 - Frontend

Componentes, páginas e artefatos relacionados ao frontend para o caso de uso Realizar Checkout Nominal Pago.

---

## 1. Páginas (Pages)

### CheckoutPage
Página principal do checkout.

**Estrutura:**
- Layout com três blocos verticais
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

### Bloco 1: Dados dos Participantes

#### ParticipantForm
Formulário para preenchimento dos dados de cada participante.

**Props:**
- `participantIndex: number`
- `initialData?: ParticipantData`
- `customFields?: CustomField[]`
- `onChange: (data: ParticipantData) => void`
- `onValidationChange: (valid: boolean) => void`

**Campos:**
- Nome (obrigatório)
- E-mail (obrigatório, válido)
- Celular (obrigatório, formato válido)
- Campos customizados (se configurados)

**Estados:**
- `empty` - Campo vazio
- `focused` - Campo em foco
- `valid` - Campo válido
- `invalid` - Campo com erro
- `disabled` - Campo desabilitado

#### ParticipantsList
Lista de formulários de participantes.

**Props:**
- `participants: ParticipantData[]`
- `onUpdate: (index: number, data: ParticipantData) => void`
- `onValidationChange: (allValid: boolean) => void`

---

### Bloco 2: Recebimento dos Ingressos

#### ResponsibleSelector
Componente para seleção do responsável pelos ingressos.

**Props:**
- `participants: ParticipantData[]`
- `selectedResponsible?: Responsible`
- `onChange: (responsible: Responsible) => void`

**Opções:**
- "Eu serei o responsável" - Usa dados do primeiro participante
- "Outra pessoa" - Exibe campos para preenchimento

#### TermsAcceptance
Componente de aceite de termos.

**Props:**
- `accepted: boolean`
- `onChange: (accepted: boolean) => void`
- `marketingOptIn?: boolean`
- `onMarketingChange: (optIn: boolean) => void`

---

### Bloco 3: Pagamento

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
Dados do comprador.

**Props:**
- `buyerData?: CustomerData`
- `onChange: (data: CustomerData) => void`

---

### Componentes Compartilhados

#### OrderSummary
Painel lateral com resumo do pedido.

**Props:**
- `order: OrderSummary`
- `remainingTime: number`

**Exibe:**
- Lista de tickets
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
  participants: ParticipantData[];
  responsible: Responsible;
  orderSummary: OrderSummary;
  paymentMethod: PaymentMethod;
  currentBlock: 1 | 2 | 3;
  isLoading: boolean;
  isProcessing: boolean;
  error: string | null;
  
  // Actions
  setParticipants: (participants: ParticipantData[]) => void;
  setResponsible: (responsible: Responsible) => void;
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

### ParticipantValidation
- Nome: mínimo 2 caracteres, máximo 100
- E-mail: formato válido de e-mail
- Celular: formato válido (+5521...)

### PaymentValidation
- Cartão: número válido (algoritmo de Luhn)
- Validade: data futura
- CVV: 3 ou 4 dígitos

### CheckoutValidation
- Bloco 1: Todos os participantes com dados válidos
- Bloco 2: Responsável selecionado, termos aceitos
- Bloco 3: Método selecionado, dados do comprador válidos

---

## 5. Casos de BDD (Frontend)

```gherkin
# Scenario: Exibir dados do participante inválido
Given que o participante preencheu dados inválidos no campo "e-mail"
When o campo perder o foco
Then deve exibir mensagem de erro abaixo do campo
And deve destacar o campo em vermelho
And deve bloquear botão de avanço

# Scenario: Avançar para Bloco 2 com dados válidos
Given que todos os dados dos participantes estão válidos
When clicar em "Avançar"
Then deve navegar para Bloco 2
And deve salvar dados temporários

# Scenario: Selecionar responsável diferente
Given que o participante seleciona "Outra pessoa" como responsável
When a opção for selecionada
Then deve exibir campos para preenchimento
And deve validar campos antes de permitir avanço

# Scenario: Contador entra em estado crítico
Given que o contador está abaixo de 1 minuto
When o tempo restante for atualizado
Then o contador deve ficar vermelho
And deve exibir mensagem de urgência

# Scenario: Tempo expirado durante checkout
Given que o tempo de 15 minutos expirou
When o sistema detectar a expiração
Then deve exibir modal de tempo expirado
And deve liberar os ingressos
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
When o Bloco 3 for exibido
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

# Scenario: Scroll para bloco com erro de validação
Given que há erro de validação no Bloco 2
When tentar avançar para Bloco 3
Then deve manterscroll no Bloco 2
And deve destacar campos inválidos
```

---

## 6. Ordens de Implementação

1. **CountdownTimer** - Componente base
2. **OrderSummary** - Exibe dados do pedido
3. **ParticipantForm** - Formulário de participantes
4. **ResponsibleSelector** - Seleção de responsável
5. **PaymentMethodSelector** - Métodos de pagamento
6. **CouponInput** - Cupom de desconto
7. **CheckoutStepper** - Navegação entre blocos
8. **CheckoutPage** - Composição da página
9. **useCheckout** - Hook de estado
10. **Validações** - Regras de validação

---

## 7. Tecnologias Recomendadas

- Framework: React ou similar
- Estado: Context API ou Zustand
- Formulários: React Hook Form + Zod
-HTTP Client: Axios ou Fetch
- Loading States: React Query ou SWR
