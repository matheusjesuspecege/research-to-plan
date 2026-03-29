# UC-10 - Exibir Resumo do Pedido

- **Ator Principal:** Sistema (exibição)
- **Atores Secundários:** Participante
- **Resumo:** Este caso de uso representa a exibição do painel lateral com o resumo do pedido durante todo o processo de checkout. O resumo exibe informações do evento, detalhamento dos ingressos, cupom aplicado (quando houver) e valor total.
- **Pré-condições:** Checkout ativo.
- **Pós-condições:** Resumo atualizado conforme alterações no checkout.

### Cenário Principal

| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| 1. Exibe painel lateral direito | 1.1. Posição fixa durante scroll |
| 2. Exibe informações do evento | 2.1. Nome do evento |
| | 2.2. Data(s) do evento |
| 3. Lista ingressos selecionados | 3.1. Tipo do ingresso |
| | 3.2. Quantidade |
| | 3.3. Valor unitário |
| | 3.4. Subtotal |
| 4. Exibe cupom aplicado (se houver) | 4.1. Nome do cupom |
| | 4.2. Valor do desconto |
| | 4.3. Opção de remover |
| 5. Exibe contador de tempo | 5.1. Tempo restante (15 minutos) |
| 6. Exibe valor total | 6.1. Subtotal - desconto = total |
| | 6.2. Destaque visual para o valor |

### Cenário Alternativo

**CA-01: Cupom aplicado**
| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| | 1.1. Exibe linha de desconto em destaque |
| | 1.2. Atualiza valor total |

**CA-02: Cupom removido**
| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| | 1.1. Remove linha de desconto |
| | 1.2. Restaura valor total original |

**CA-03: Tempo expirando (< 2 minutos)**
| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| | 1.1. Alerta visual no contador |
| | 1.2. Cor diferenciada |

### Restrições/Validações

- Resumo deve estar sempre visível durante scroll
- Valores devem ser formatados em Real brasileiro (R$)
- Contador deve atualizar a cada segundo

### Cenário de Exceção

**CE-01: Tempo expirou**
| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| | 1.1. Contador chega a 00:00 |
| | 1.2. Libera ingressos |
| | 1.3. Redireciona para página do evento |

### Requisitos Não-Funcionais

- **Usabilidade:** Posição fixa (sticky) durante scroll
- **Performance:** Atualização em tempo real < 100ms
- **Design:** Destaque visual para informações importantes
