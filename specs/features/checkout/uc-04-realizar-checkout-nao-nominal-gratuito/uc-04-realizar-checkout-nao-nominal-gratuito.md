# UC-04 - Realizar Checkout Não Nominal Gratuito

- **Ator Principal:** Participante (deve estar autenticado)
- **Atores Secundários:** Sistema de E-mail
- **Resumo:** Este caso de uso representa o processo pelo qual um participante autenticado se inscreve em um evento com ingresso não nominal gratuito. O participante deve estar logado para acessar o checkout. O fluxo exibe apenas o Bloco 2, dispensando o Bloco 1 (dados dos participantes) e o Bloco 3 (pagamento). Ao concluir, a inscrição é vinculada à conta do participante logado.
- **Pré-condições:** O participante deve estar autenticado no sistema; Ter selecionado ingresso(s) não nominal(is) gratuito(s).
- **Pós-condições:** Inscrição confirmada; Ingressos vinculados à conta do participante.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Acessa o checkout com ingressos não nominais gratuitos selecionados | 1.1. Verifica autenticação do participante |
| | 1.2. Exibe tela única com Bloco 2 (sem Bloco 1 e sem Bloco 3) |
| | 1.3. Exibe painel lateral com resumo do pedido (valor R$ 0,00) |
| 2. Aceita termos e condições | 2.1. Habilita opção de aceite de contato (opcional) |
| 3. Clica em "Confirmar inscrição" | 3.1. Valida aceite dos termos |
| | 3.2. Vincula ingressos à conta do participante logado |
| | 3.3. Envia e-mail de confirmação de inscrição |
| | 3.4. Exibe tela de confirmação |
| 4. Finaliza | 4.1. Redireciona para página de confirmação |

### Restrições/Validações

- Participante deve estar autenticado para acessar o checkout
- Bloco 1 (dados dos participantes) não é exibido
- Bloco 3 (pagamento) não é exibido
- Se participante não estiver logado, redirecionar para tela de login/cadastro

### Cenário Alternativo

**CA-01: Participante não autenticado ao tentar avançar**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Tenta avançar sem estar logado | 1.1. Redireciona para tela de login/cadastro |
| 2. Realiza autenticação | 2.1. Retorna ao checkout no ponto em que estava |

**CA-02: Participante não autenticado ao acessar checkout**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Tenta acessar checkout sem estar logado | 1.1. Redireciona para tela de login/cadastro |

### Cenário de Exceção

**CE-01: Falha na vinculação da inscrição**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Exibe mensagem de erro |
| | 1.2. Mantém participante no checkout |

### Requisitos Não-Funcionais

- **Segurança:** Apenas participantes autenticados podem acessar
- **Usabilidade:** Retornar ao ponto exato do checkout após autenticação
