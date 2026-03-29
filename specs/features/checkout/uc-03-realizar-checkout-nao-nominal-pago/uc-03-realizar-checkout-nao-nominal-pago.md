# UC-03 - Realizar Checkout Não Nominal Pago

- **Ator Principal:** Participante
- **Atores Secundários:** Sistema de Pagamento, Sistema de E-mail
- **Resumo:** Este caso de uso representa o processo pelo qual um participante adquire ingressos não nominais pagos. O fluxo não exibe o Bloco 1 (dados dos participantes), iniciando diretamente no Bloco 2 para seleção do responsável pelos ingressos, seguido do Bloco 3 de pagamento. Ao concluir, o sistema processa o pagamento e cria uma conta automaticamente.
- **Pré-condições:** O participante deve ter selecionado ingresso(s) não nominal(is) pago(s) e estar na página de checkout. O evento deve ter método(s) de pagamento habilitado(s).
- **Pós-condições:** Pagamento processado com sucesso; Conta criada automaticamente; Ingressos vinculados ao responsável.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Acessa o checkout com ingressos não nominais pagos selecionados | 1.1. Exibe tela única com Bloco 2 (sem Bloco 1) |
| | 1.2. Exibe painel lateral com resumo do pedido e contador de 15min |
| 2. Preenche dados do responsável ("Outro") | 2.1. Exibe campos: nome completo, e-mail, celular |
| 3. Aceita termos e condições | 3.1. Habilita opção de aceite de contato (opcional) |
| 4. Avança para Bloco 3 | 4.1. Valida campos do Bloco 2 |
| 5. Seleciona método de pagamento (Pix, Cartão ou Boleto) | 5.1. Exibe campos correspondentes ao método selecionado |
| 6. Seleciona ou informa responsável pelo pagamento ("Outro") | 6.1. Pré-preenche se campo do Bloco 2 for selecionado |
| 7. Insere dados do cartão (se aplicável) | 7.1. Valida dados do cartão |
| 8. (Opcional) Insere código de cupom e clica "Adicionar" | 8.1. Valida cupom e exibe desconto aplicado |
| 9. Clica em "Avançar para pagamento" | 9.1. Valida todos os campos |
| | 9.2. Processa pagamento via gateway |
| | 9.3. Ao confirmar: cria conta automaticamente |
| | 9.4. Vincula ingressos à conta criada |
| | 9.5. Envia e-mail de boas-vindas |
| | 9.6. Envia e-mail com ingressos |
| | 9.7. Exibe tela de confirmação |
| 10. Finaliza | 10.1. Redireciona para página de confirmação |

### Restrições/Validações

- Bloco 1 não é exibido neste tipo de checkout
- Bloco 2 não exibe dropdown de seleção (campo "Outro" é único)
- Responsável pelo pagamento é independente do responsável pelos ingressos
- Todos os campos obrigatórios devem estar válidos para avançar
- Apenas um cupom pode estar ativo por pedido

### Cenário Alternativo

**CA-01: Cupom inválido**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Insere código de cupom e clica "Adicionar" | 1.1. Exibe mensagem de erro indicando motivo |

**CA-02: Tempo expirou**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Libera ingressos e redireciona para página do evento |

### Cenário de Exceção

**CE-01: Cartão recusado**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Exibe mensagem de erro com instruções |
| | 1.2. Mantém todos os dados preenchidos |

**CE-02: E-mail já cadastrado**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Usa conta existente automaticamente |

### Requisitos Não-Funcionais

- **Segurança:** Dados de cartão não devem ser armazenados; usar card_id
- **Performance:** Tempo de resposta < 2s para validações
