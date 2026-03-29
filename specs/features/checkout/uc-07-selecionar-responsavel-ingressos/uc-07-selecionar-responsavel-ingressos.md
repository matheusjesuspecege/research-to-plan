# UC-07 - Selecionar Responsável pelos Ingressos

- **Ator Principal:** Participante
- **Resumo:** Este caso de uso representa o processo de seleção do responsável pelo recebimento dos ingressos. O responsável é a pessoa que receberá os ingressos por e-mail e poderá gerenciá-los na plataforma.
- **Pré-condições:** Checkout ativo; Participante ter selecionado ingresso(s).
- **Pós-condições:** Responsável selecionado e dados preparados para criação de conta.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Visualiza campo "Responsável pelos ingressos" | 1.1. Exibe dropdown com opções |
| 2. Seleciona participante (checkout nominal) | 2.1. Usa e-mail do participante como destinatário |
| | 2.2. Não exibe campos adicionais |
| 3. Seleciona "Outro" (checkout nominal) ou é o único (checkout não nominal) | 3.1. Exibe campos: nome completo, e-mail, celular |
| | 3.2. Todos os campos são obrigatórios |
| 4. Preenche dados do responsável | 4.1. Valida campos |
| 5. Aceita termos e condições | 5.1. Exibe nota sobre criação automática de conta |
| 6. (Opcional) Aceita receber contato sobre o evento | 6.1. Registra preferência |

### Restrições/Validações

- E-mail do responsável será usado para criação de conta automática
- Se e-mail já existir, usa conta existente
- Checkbox de termos é obrigatório
- Checkbox de aceite de contato é opcional

### Cenário de Exceção

**CE-01: E-mail já cadastrado**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Identifica conta existente |
| | 1.2. Continua sem criar nova conta |

### Requisitos Não-Funcionais

- **Transparência:** Informar claramente que conta será criada
- **Usabilidade:** Campos pré-preenchidos quando participante selecionado
