# UC-02 - Realizar Checkout Nominal Gratuito

- **Ator Principal:** Participante
- **Atores Secundários:** Sistema de E-mail
- **Resumo:** Este caso de uso representa o processo pelo qual um participante se inscreve em um evento com ingresso nominal gratuito. O fluxo exibe os Blocos 1 e 2, dispensando o Bloco 3 de pagamento. Ao concluir, o sistema cria uma conta automaticamente para o responsável pelos ingressos e envia o e-mail de boas-vindas.
- **Pré-condições:** O participante deve ter selecionado ingresso(s) nominal(is) gratuito(s) e estar na página de checkout.
- **Pós-condições:** Conta criada automaticamente; Inscrição confirmada; E-mail de boas-vindas enviado.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Acessa o checkout com ingressos nominais gratuitos selecionados | 1.1. Exibe tela única com Bloco 1 (Dados dos Participantes) |
| | 1.2. Exibe painel lateral com resumo do pedido (valor R$ 0,00) |
| 2. Preenche os dados de cada participante (nome, e-mail, celular) | 2.1. Valida campos obrigatórios em tempo real |
| 3. Adiciona campos customizados (se configurados pelo organizador) | 3.1. Valida campos customizados conforme regra de obrigatoriedade |
| 4. Avança para Bloco 2 | 4.1. Valida todos os campos do Bloco 1 |
| 5. Seleciona responsável pelos ingressos (participante ou "Outro") | 5.1. Se participante: pré-preenche com dados do Bloco 1 |
| | 5.2. Se "Outro": exibe campos para preenchimento manual |
| 6. Aceita termos e condições | 6.1. Habilita opção de aceite de contato (opcional) |
| 7. Clica em "Confirmar inscrição" | 7.1. Valida todos os campos dos dois blocos |
| | 7.2. Cria conta automaticamente para o responsável |
| | 7.3. Vincula ingressos à conta criada |
| | 7.4. Envia e-mail de boas-vindas com link de criação de senha |
| | 7.5. Envia e-mail de confirmação de inscrição |
| | 7.6. Exibe tela de confirmação |
| 8. Finaliza | 8.1. Redireciona para página de confirmação ou área do usuário |

### Restrições/Validações

- Todos os campos obrigatórios devem estar preenchidos e válidos para confirmar
- O botão "Confirmar inscrição" permanece desabilitado até validação completa
- Tempo de checkout: 15 minutos de reserva dos ingressos
- O e-mail do responsável pelos ingressos é usado para criação da conta
- Se e-mail já existir na base, usa conta existente sem criar duplicata

### Cenário Alternativo

**CA-01: E-mail já cadastrado**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Usa conta existente automaticamente |
| | 1.2. Vincula inscrições à conta existente |
| | 1.3. Não envia e-mail de boas-vindas |

**CA-02: Tempo de checkout expirou**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Libera os ingressos reservados |
| | 1.2. Redireciona para página do evento |
| 2. Reinicia checkout (se ingressos ainda disponíveis) | 2.1. Inicia novo período de 15 minutos |

### Cenário de Exceção

**CE-01: Campos inválidos no Bloco 1**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Destaca campos inválidos com indicação visual |
| | 1.2. Exibe mensagem explicativa abaixo de cada campo inválido |
| 2. Corrige campos | 2.1. Remove indicação de erro quando válido |

### Requisitos Não-Funcionais

- **Performance:** Tempo de resposta < 2s para validações de campo
- **Usabilidade:** Indicações visuais claras para campos obrigatórios e erros
- **Confiabilidade:** Transação deve ser atômica; rollback em caso de falha
