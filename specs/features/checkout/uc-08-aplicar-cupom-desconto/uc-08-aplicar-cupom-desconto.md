# UC-08 - Aplicar Cupom de Desconto

- **Ator Principal:** Participante
- **Resumo:** Este caso de uso representa o processo de aplicação de cupom de desconto no checkout. O participante insere um código e o sistema valida, aplicando o desconto quando válido.
- **Pré-condições:** Checkout ativo com valor total > 0.
- **Pós-condições:** Cupom válido: desconto aplicado ao pedido; Cupom inválido: mensagem de erro exibida.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Localiza campo de cupom no resumo do pedido | 1.1. Exibe campo de texto e botão "Adicionar" |
| 2. Insere código do cupom | 2.1. Aceita código alfanumérico |
| 3. Clica em "Adicionar" | 3.1. Envia código para validação |
| | 3.2. Valida existência e elegibilidade |
| 4. Cupom válido | 4.1. Exibe desconto aplicado no resumo |
| | 4.2. Mostra nome do cupom e valor descontado |
| | 4.3. Disponibiliza opção de remover cupom |

### Cenário Alternativo

**CA-01: Cupom inválido**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Exibe mensagem de erro abaixo do campo |
| | 1.2. Indica motivo: "não encontrado", "expirado", "já utilizado" |

**CA-02: Remover cupom aplicado**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Clica em remover cupom | 1.1. Remove desconto do resumo |
| | 1.2. Atualiza valor total |

### Restrições/Validações

- Apenas um cupom por pedido
- Cupom é validado no momento do clique em "Adicionar"
- Não há restrição por CPF ou e-mail do participante

### Cenário de Exceção

**CE-01: Cupom expirado**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Mensagem: "Este cupom expirou" |

**CE-02: Cupom não encontrado**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Mensagem: "Cupom não encontrado" |

### Requisitos Não-Funcionais

- **Performance:** Validação < 500ms
- **Feedback:** Mensagens de erro claras e informativas
