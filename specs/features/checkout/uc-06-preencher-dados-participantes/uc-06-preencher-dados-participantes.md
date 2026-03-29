# UC-06 - Preencher Dados dos Participantes

- **Ator Principal:** Participante
- **Resumo:** Este caso de uso representa o processo de preenchimento dos dados de cada participante em um checkout nominal. Cada ingresso selecionado gera um card de preenchimento com campos padrão (nome, e-mail, celular) e campos customizados configurados pelo organizador.
- **Pré-condições:** Checkout nominal ativo; Ingresso(s) selecionado(s).
- **Pós-condições:** Dados dos participantes validados e prontos para vinculação.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| 1. Visualiza card de participante para cada ingresso | 1.1. Exibe card identificado por tipo e valor do ingresso |
| 2. Preenche nome do participante | 2.1. Valida formato (mínimo 2 caracteres) |
| 3. Preenche e-mail do participante | 3.1. Valida formato de e-mail |
| 4. Preenche celular com DDI | 4.1. Exibe seletor de DDI com Brasil pré-selecionado |
| | 4.2. Valida formato do celular |
| 5. (Se configurado) Preenche campos customizados | 5.1. Exibe campos abaixo dos padrão |
| | 5.2. Valida conforme regra de obrigatoriedade do organizador |
| 6. Repete para cada participante | 6.1. Permite navegação entre cards |

### Restrições/Validações

- Campos padrão: nome, e-mail e celular (sempre obrigatórios)
- Campos customizados: conforme configuração do organizador
- Validação em tempo real com indicação visual de erros
- Botão de avanço desabilitado até todos os campos válidos

### Cenário de Exceção

**CE-01: Campo inválido**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Destaca campo com indicação visual |
| | 1.2. Exibe mensagem explicativa abaixo do campo |

**CE-02: Campo obrigatório não preenchido**
| Ações do Ator | Ações do Sistema |
|---------------|-------------------|
| | 1.1. Destaca campo |
| | 1.2. Mensagem: "Campo obrigatório" |

### Requisitos Não-Funcionais

- **Usabilidade:** Indicadores visuais claros (cor, ícone)
- **Performance:** Validação em tempo real < 200ms
- **Acessibilidade:** Suporte a leitores de tela
