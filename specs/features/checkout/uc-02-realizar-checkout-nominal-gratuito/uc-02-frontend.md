# Frontend - UC-02 Checkout Nominal Gratuito

## Componentes (Atomic Design)

### Átomos

| Componente | Descrição |
|------------|-----------|
| InputText | Campo de texto reutilizável |
| InputEmail | Campo de e-mail com validação |
| InputPhone | Campo de telefone com máscara |
| Checkbox | Caixa de seleção |
| Button | Botão primário/secundário |
| ErrorMessage | Mensagem de erro |
| Spinner | Indicador de carregamento |
| Badge | Indicador de status |

### Moléculas

| Componente | Descrição |
|------------|-----------|
| FormField | Label + Input + ErrorMessage |
| ParticipantCard | Card com dados de um participante |
| ResponsibleCard | Card com dados do responsável |
| CouponInput | Campo para aplicar cupom |
| OrderSummary | Resumo do pedido |

### Organismos

| Componente | Descrição |
|------------|-----------|
| ParticipantsForm | Formulário de dados dos participantes |
| ResponsibleForm | Formulário de seleção do responsável |
| CheckoutSummary | Painel lateral com resumo |
| CountdownTimer | Timer regressivo de 15 minutos |
| TermsAcceptance | Bloco de termos e condições |

### Páginas

| Página | Descrição |
|--------|-----------|
| CheckoutPage | Página principal do checkout |
| ConfirmationPage | Página de confirmação pós-checkout |

## API Integrations

```typescript
interface CheckoutAPI {
  getSession(sessionId: string): Promise<CheckoutSessionResponse>;
  saveParticipants(data: CheckoutParticipantsRequest): Promise<ParticipantsValidationResponse>;
  saveResponsible(data: CheckoutResponsibleRequest): Promise<ResponsibleValidationResponse>;
  confirmCheckout(data: CheckoutConfirmationRequest): Promise<CheckoutConfirmationResponse>;
  validateEmail(email: string): Promise<{ exists: boolean }>;
}
```

## Estado Global (Store)

```typescript
interface CheckoutState {
  session: CheckoutSession | null;
  participants: ParticipantInput[];
  responsible: ResponsibleInput | null;
  termsAccepted: boolean;
  currentBlock: 1 | 2;
  errors: ValidationError[];
  isLoading: boolean;
}
```

## Ordem de Implementação

1. **Átomos básicos** - InputText, Button, ErrorMessage
2. **FormField (molécula)** - Combina átomos para campos de formulário
3. **ParticipantsForm (organismo)** - Bloco 1 completo
4. **ResponsibleForm (organismo)** - Bloco 2 completo
5. **CheckoutSummary + CountdownTimer** - Painel lateral
6. **CheckoutPage** - Integração dos organismos
7. **ConfirmationPage** - Tela de sucesso
8. **Validações em tempo real**
9. **Tratamento de erros e estados de loading**
