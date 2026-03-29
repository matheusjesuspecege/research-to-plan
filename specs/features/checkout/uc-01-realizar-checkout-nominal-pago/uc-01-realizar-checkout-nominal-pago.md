# UC-01 - Realizar Checkout Nominal Pago

- **Ator Principal:** Participante
- **Atores Secundários:** Sistema de Pagamento, Sistema de E-mail
- **Resumo:** Este caso de uso representa o processo pelo qual um participante adquire ingressos nominais pagos em um evento. O fluxo exibe três blocos sequenciais: preenchimento dos dados de cada participante, seleção do responsável pelos ingressos e pagamento. Ao concluir, o sistema processa o pagamento, cria uma conta automaticamente para o responsável e envia os e-mails de boas-vindas e confirmação.
- **Pré-condições:** O participante deve ter selecionado ingresso(s) nominal(is) pago(s) e estar na página de checkout. O evento deve ter método(s) de pagamento habilitado(s).
- **Pós-condições:** Pagamento processado com sucesso; Conta criada automaticamente (se e-mail não existir); Ingressos vinculados ao participante; E-mails de boas-vindas e confirmação enviados.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Acessa o checkout com ingressos nominais pagos selecionados | 1.1. Exibe tela única com Bloco 1 (Dados dos Participantes) |
| | 1.2. Exibe painel lateral com resumo do pedido e contador de 15min |
| 2. Preenche os dados de cada participante (nome, e-mail, celular) | 2.1. Valida campos obrigatórios em tempo real |
| 3. Adiciona campos customizados (se configurados pelo organizador) | 3.1. Valida campos customizados conforme regra de obrigatoriedade |
| | 3.2. Destaca campos inválidos com indicação visual |
| 4. Avança para Bloco 2 | 4.1. Valida todos os campos do Bloco 1 |
| 5. Seleciona responsável pelos ingressos (participante ou "Outro") | 5.1. Se participante: pré-preenche com dados do Bloco 1 |
| | 5.2. Se "Outro": exibe campos para preenchimento manual |
| 6. Aceita termos e condições | 6.1. Habilita opção de aceite de contato (opcional) |
| 7. Avança para Bloco 3 | 7.1. Exibe métodos de pagamento disponíveis |
| 8. Seleciona método de pagamento (Pix, Cartão ou Boleto) | 8.1. Exibe campos correspondentes ao método selecionado |
| 9. Seleciona ou informa responsável pelo pagamento | 9.1. Pré-preenche dados se participante selecionado |
| 10. Insere dados do cartão (se aplicável) | 10.1. Valida dados do cartão |
| 11. (Opcional) Insere código de cupom e clica "Adicionar" | 11.1. Valida cupom e exibe desconto aplicado |
| 12. Clica em "Avançar para pagamento" | 12.1. Valida todos os campos dos três blocos |
| | 12.2. Processa pagamento via gateway |
| | 12.3. Ao confirmar pagamento: cria conta automaticamente |
| | 12.4. Vincula ingressos à conta criada |
| | 12.5. Envia e-mail de boas-vindas com link de criação de senha |
| | 12.6. Envia e-mail com ingressos em PDF |
| | 12.7. Exibe tela de confirmação |
| 13. Finaliza | 13.1. Redireciona para página de confirmação ou área do usuário |

### Restrições/Validações

- Todos os campos obrigatórios devem estar preenchidos e válidos para avançar
- O botão "Avançar para pagamento" permanece desabilitado até validação completa
- Tempo de checkout: 15 minutos de reserva dos ingressos
- Apenas um cupom pode estar ativo por pedido
- O e-mail do responsável pelos ingressos é usado para criação da conta
- Se e-mail já existir na base, usa conta existente sem criar duplicata

### Cenário Alternativo

**CA-01: Cupom inválido**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Insere código de cupom e clica "Adicionar" | 1.1. Exibe mensagem de erro abaixo do campo indicando motivo |

**CA-02: Remover cupom aplicado**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Clica na opção de remover cupom | 1.1. Remove desconto e atualiza valor total no resumo |

**CA-03: Alterar dados após pré-preenchimento**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Altera dados pré-preenchidos | 1.1. Aceita alteração e atualiza dados para salvamento |

### Cenário de Exceção

**CE-01: Cartão recusado**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Exibe mensagem de erro com instruções |
| | 1.2. Mantém todos os dados preenchidos |
| 2. Corrige dados ou altera método de pagamento | 2.1. Permite nova tentativa |

**CE-02: Tempo de checkout expirou**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Libera os ingressos reservados |
| | 1.2. Redireciona para página do evento |
| 2. Reinicia checkout (se ingressos ainda disponíveis) | 2.1. Inicia novo período de 15 minutos |

**CE-03: E-mail já cadastrado**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Usa conta existente automaticamente |
| | 1.2. Vincula ingressos à conta existente |
| | 1.3. Não envia e-mail de boas-vindas |

### Requisitos Não-Funcionais

- **Segurança:** Dados de cartão não devem ser armazenados localmente; usar card_id do gateway
- **Performance:** Tempo de resposta < 2s para validações de campo
- **Usabilidade:** Indicações visuais claras para campos obrigatórios e erros
- **Confiabilidade:** Transação deve ser atômica; rollback em caso de falha
