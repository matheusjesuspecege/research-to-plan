# UC-05 - Processar Pagamento

- **Ator Principal:** Sistema de Pagamento
- **Atores Secundários:** Participante
- **Resumo:** Este caso de uso representa o processo de processamento de pagamento via gateway externo (Pay). O sistema oferece três métodos: Pix, Cartão de Crédito e Boleto. Cada método possui fluxo e tratativas específicas de confirmação e erro.
- **Pré-condições:** Participante deve ter selecionado método de pagamento; Todos os campos de pagamento devem estar válidos.
- **Pós-condições:** Pagamento aprovado: transição para criação de conta; Pagamento recusado: exibição de erro e retorno ao checkout.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Recebe dados do pagamento | 1.1. Valida dados antes de enviar ao gateway |
| | 1.2. Envia transação ao Sistema de Pagamento |
| 2. Processa transação | 2.1. Aguarda resposta do gateway |
| 3. Recebe resposta | 3.1. Interpreta resultado da transação |
| 4. Confirma pagamento | 4.1. Retorna sucesso para o checkout |
| | 4.2. Recebe webhook de confirmação |
| | 4.3. Atualiza status do pedido para "pago" |

### Cenários por Método de Pagamento

#### 5.1. Pagamento via Cartão de Crédito

| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Envia dados do cartão | 1.1. Valida dados do cartão |
| | 1.2. Envia ao gateway |
| 2. Aguarda aprovação da operadora | 2.1. Processa resposta |
| 3. Cartão aprovado | 3.1. Exibe tela de confirmação imediatamente |
| 4. Cartão recusado | 4.1. Mantém dados preenchidos |
| | 4.2. Exibe mensagem de erro com instruções |
| | 4.3. Permite nova tentativa ou alteração de método |

#### 5.2. Pagamento via Pix

| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Seleciona Pix | 1.1. Gera QR Code e código copia e cola |
| | 1.2. Exibe tempo restante para pagamento |
| 2. Participante realiza pagamento | 2.1. Aguarda confirmação via webhook |
| 3. Recebe webhook de confirmação | 3.1. Atualiza status para "pago" |
| | 3.2. Exibe tela de confirmação |

#### 5.3. Pagamento via Boleto

| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Seleciona Boleto | 1.1. Gera boleto com código de barras |
| 2. Exibe tela "Aguardando pagamento" | 2.1. Permite visualizar instruções |
| | 2.2. Permite baixar boleto |
| | 2.3. Permite copiar código |
| 3. Recebe confirmação de compensação | 3.1. Atualiza status para "pago" |
| | 3.2. Exibe tela de confirmação |

### Cenário de Exceção

**CE-01: Timeout na comunicação com gateway**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Exibe mensagem de erro de comunicação |
| | 1.2. Permite retry |

**CE-02: Falha no webhook de confirmação**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Implementar lógica de retry |
| | 1.2. Verificação periódica de status |

### Requisitos Não-Funcionais

- **Segurança:** Não armazenar dados sensíveis do cartão; usar card_id
- **Performance:** Timeout de 30s para comunicação com gateway
- **Confiabilidade:** Implementar retry para webhooks
- **Conformidade:** Seguir normas PCI-DSS para dados de pagamento
