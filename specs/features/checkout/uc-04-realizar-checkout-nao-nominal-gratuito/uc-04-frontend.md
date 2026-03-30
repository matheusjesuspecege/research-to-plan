# UC-04 - Frontend

## Visão Geral
Este documento define os componentes, interfaces e artefatos frontend necessários para a implementação do caso de uso UC-04 - Realizar Checkout Não Nominal Gratuito.

---

## Order de Implementação (por dependência - Atomic Design)

### Nível 1: Átomos

#### 1.1 Checkbox
**Dependências:** Nenhuma
**Descrição:** Componente checkbox para aceite de termos

#### 1.2 Button
**Dependências:** Nenhuma
**Descrição:** Botão de confirmar inscrição

#### 1.3 LoadingSpinner
**Dependências:** Nenhuma
**Descrição:** Indicador de carregamento

---

### Nível 2: Moléculas

#### 2.1 TermsCheckbox
**Dependências:** Checkbox, Button
**Descrição:** Grupo de checkboxes para termos e consentimento

#### 2.2 OrderSummary
**Dependências:** Nenhuma
**Descrição:** Resumo do pedido com valores

---

### Nível 3: Organismos

#### 3.1 CheckoutBlock2
**Dependências:** TermsCheckbox, OrderSummary, Button
**Descrição:** Bloco 2 do checkout (responsável e termos)

#### 3.2 CheckoutSidebar
**Dependências:** OrderSummary
**Descrição:** Barra lateral com resumo e timer

---

### Nível 4: Templates

#### 4.1 CheckoutTemplate
**Dependências:** CheckoutBlock2, CheckoutSidebar
**Descrição:** Template da página de checkout não nominal gratuito

---

### Nível 5: Páginas

#### 5.1 CheckoutPage
**Dependências:** CheckoutTemplate
**Descrição:** Página completa de checkout

---

## Componentes

### CheckoutPage

```typescript
// components/pages/CheckoutPage.tsx
interface CheckoutPageProps {
  eventId: string;
  tickets: TicketSelection[];
}
```

### CheckoutTemplate

```typescript
// components/templates/CheckoutTemplate.tsx
interface CheckoutTemplateProps {
  session: CheckoutSession;
  orderSummary: OrderSummary;
  onConfirm: (terms: TermsAcceptance) => Promise<void>;
  isLoading: boolean;
  error: string | null;
}
```

### CheckoutBlock2

```typescript
// components/organisms/CheckoutBlock2.tsx
interface CheckoutBlock2Props {
  onTermsChange: (terms: TermsAcceptance) => void;
  terms: TermsAcceptance;
  onConfirm: () => void;
  isLoading: boolean;
  error: string | null;
}
```

### OrderSummary

```typescript
// components/molecules/OrderSummary.tsx
interface OrderSummaryProps {
  tickets: TicketSelection[];
  subtotal: number;
  discount: number;
  total: number;
  currency: string;
}
```

### CheckoutSidebar

```typescript
// components/organisms/CheckoutSidebar.tsx
interface CheckoutSidebarProps {
  orderSummary: OrderSummary;
  expiresAt: number;
  onTimeExpired: () => void;
}
```

### TermsCheckbox

```typescript
// components/molecules/TermsCheckbox.tsx
interface TermsCheckboxProps {
  terms: TermsAcceptance;
  onChange: (terms: TermsAcceptance) => void;
}
```

---

## Hooks

### useCheckout

```typescript
// hooks/useCheckout.ts
interface UseCheckoutReturn {
  session: CheckoutSession | null;
  orderSummary: OrderSummary;
  terms: TermsAcceptance;
  isLoading: boolean;
  error: string | null;
  createSession: (eventId: string, tickets: TicketSelection[]) => Promise<void>;
  confirmCheckout: () => Promise<CheckoutConfirmation | null>;
  setTerms: (terms: TermsAcceptance) => void;
}
```

---

## Contextos

### CheckoutContext

```typescript
// context/CheckoutContext.tsx
interface CheckoutContextValue {
  session: CheckoutSession | null;
  orderSummary: OrderSummary;
  terms: TermsAcceptance;
  isLoading: boolean;
  error: string | null;
  confirmCheckout: () => Promise<void>;
  updateTerms: (terms: TermsAcceptance) => void;
}
```

---

## Cenários de Teste BDD (Frontend)

### Funcional

**Cenário:** Exibir checkout não nominal gratuito
- Dado que o participante está na página de checkout
- Quando carrega com tickets não nominais gratuitos
- Então exibe apenas o Bloco 2
- E exibe resumo com valor R$ 0,00

**Cenário:** Confirmar inscrição
- Dado que o participante aceitou os termos
- Quando clica em confirmar inscrição
- Then redireciona para tela de confirmação

### Lei de Murphy (Cenários de Erro)

**Cenário:** Sessão expirada
- Dado que o tempo de checkout expirou
- Quando tenta confirmar
- Then exibe mensagem de sessão expirada

**Cenário:** Termos não aceitos
- Dado que o participante não aceitou os termos
- Quando clica em confirmar
- Then exibe mensagem de erro de termos

**Cenário:** Erro ao confirmar
- Dado que ocorreu erro na API
- When tenta confirmar
- Then exibe mensagem de erro

**Cenário:** Usuário não autenticado
- Dado que o usuário não está logado
- Quando acessa o checkout
- Then redireciona para página de login

**Cenário:** Rede falha ao confirmar
- Dado que há falha de rede
- Quando tenta confirmar
- Then exibe mensagem de erro de conexão
