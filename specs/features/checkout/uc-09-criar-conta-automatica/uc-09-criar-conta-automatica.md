# UC-09 - Criar Conta Automaticamente

- **Ator Principal:** Sistema (automação)
- **Atores Secundários:** Participante
- **Resumo:** Este caso de uso representa a criação automática de conta na plataforma após conclusão bem-sucedida do checkout. A conta é criada com os dados do responsável pelos ingressos, permitindo ao usuário gerenciar seus ingressos futuramente.
- **Pré-condições:** Checkout concluído com sucesso; E-mail do responsável não existente na base.
- **Pós-condições:** Conta criada; Credenciais temporárias geradas; E-mail de boas-vindas enviado.

### Cenário Principal

| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| 1. Recebe dados do responsável pelos ingressos | 1.1. Captura nome, e-mail, celular |
| 2. Verifica se e-mail já existe na base | 2.1. Se existe: usar conta existente |
| | 2.2. Se não existe: prosseguir com criação |
| 3. Cria conta com dados do responsável | 3.1. Gera senha temporária ou link de definição |
| 4. Vincula ingresso(s) à nova conta | 4.1. Associa histórico de compra |
| 5. Envia e-mail de boas-vindas | 5.1. Contém link para definição de senha |
| 6. Conta criada com sucesso | 6.1. Participante pode acessar área logada |

### Cenário Alternativo

**CA-01: E-mail já existe na base**
| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| | 1.1. Usa conta existente automaticamente |
| | 1.2. Não envia e-mail de boas-vindas |
| | 1.3. Vincula ingresso à conta existente |

### Cenário de Exceção

**CE-01: Falha na criação da conta**
| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| | 1.1. Registra erro para análise |
| | 1.2. Ingressos permanecem vinculados |
| | 1.3. E-mail de boas-vindas pode ser reenviado manualmente |

**CE-02: E-mail inválido**
| Ações do Sistema | Ações do Participante |
|------------------|-----------------------|
| | 1.1. Validação impede criação |
| | 1.2. Checkout retorna erro |

### Requisitos Não-Funcionais

- **Segurança:** Senha temporária deve ser criptografada
- **Performance:** Criação < 2s
- **Confiabilidade:** Transação atômica com rollback
- **Notificação:** E-mail de boas-vindas deve ser confiável (99% entrega)
