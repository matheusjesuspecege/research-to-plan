# UC-11 - Gerenciar Expiração do Checkout

- **Ator Principal:** Sistema (automação)
- **Atores Secundários:** Participante
- **Resumo:** Este caso de uso representa o gerenciamento do tempo de reserva dos ingressos durante o checkout. O sistema reserva os ingressos por 15 minutos, garantindo que estejam disponíveis até a conclusão ou expiração do prazo.
- **Pré-condições:** Checkout iniciado.
- **Pós-condições:** Tempo expirado: ingressos liberados; Checkout concluído: reserva convertida em compra.

### Cenário Principal

| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| 1. Inicia contador ao abrir checkout | 1.1. Reserva ingressos por 15 minutos |
| 2. Exibe contador no resumo do pedido | 2.1. Atualização a cada segundo |
| 3. Participante preenche checkout | 3.1. Contador continua countdown |
| 4. Checkout concluído antes do fim | 4.1. Reserva convertida em compra |
| | 4.2. Contador encerrado |

### Cenário Alternativo

**CA-01: Tempo expirou durante preenchimento**
| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| | 1.1. Contador chega a 00:00 |
| | 1.2. Libera todos os ingressos reservados |
| | 1.3. Redireciona para página do evento |
| 2. Participante retorna (se ingressos disponíveis) | 2.1. Inicia novo checkout com novo período de 15 minutos |

**CA-02: Cupom expirou junto com checkout**
| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| | 1.1. Cupom não é mantido |
| | 1.2. A definir com time dev |

### Restrições/Validações

- Tempo fixo de 15 minutos por sessão de checkout
- Contador não pode ser pausado
- Cupom pode ou não expirar junto (a definir)

### Cenário de Exceção

**CE-01: Participante fecha aba durante countdown**
| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| | 1.1. Ingressos permanecem reservados até expiração |
| | 1.2. Ao expirar, são liberados |

**CE-02: Perda de conexão durante countdown**
| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| | 1.1. Contador continua no servidor |
| | 1.2. Ao reconectar, exibe tempo restante |

### Requisitos Não-Funcionais

- **Confiabilidade:** Contador deve ser sincronizado com servidor
- **Performance:** Atualização visual suave (60fps)
- **Segurança:** Tempo não pode ser manipulado no cliente
