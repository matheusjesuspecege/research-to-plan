# UC-07 - Validar Não-Regressão de Funcionalidades

- **Caso de Uso Geral:** -
- **Ator Principal:** Desenvolvedor
- **Atores Secundários:** Organizador (usuário final)
- **Resumo:** Este caso de uso representa o processo de validação de que a migração do dashboard para o package não introduziu regressões nas funcionalidades existentes. Inclui validação técnica e validação com usuário final.
- **Pré-condições:** Dashboard anterior desativado (UC-06). Ambiente de staging/produção disponível.
- **Pós-condições:** Validação completa de não-regressão aprovada.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Executar suite de testes existentes | |
| 2. Validar cálculos de métricas: | |
| 2.1 Inscrições | Verificar contagem e status |
| 2.2 Vendas | Verificar total e métodos de pagamento |
| 2.3 Check-ins | Verificar contagem e taxa |
| 2.4 Receita | Verificar valores por período |
| 3. Validar acesso pelo menu lateral | |
| 4. Testar com diferentes eventos | |
| 5. Verificar performance de carregamento | |
| 6. Validar em diferentes navegadores | |

### Regras de Não-Regressão (do PRD)

| # | Regra | Validação |
|---|-------|-----------|
| 1 | Cálculo de inscrições inalterado | Comparar valores antes/depois |
| 2 | Cálculo de vendas inalterado | Comparar valores antes/depois |
| 3 | Cálculo de check-ins inalterado | Comparar valores antes/depois |
| 4 | Cálculo de receita inalterado | Comparar valores antes/depois |
| 5 | Acesso via menu lateral funcional | Navegação sem erros |
| 6 | Acesso para todos organizadores com eventos ativos | Testar com múltiplas contas |

### Restrições/Validações

- Se migrar com ambiente de produção ativo, substituição deve ser atômica

### Cenário Alternativo

| # | Condição | Ação |
|---|----------|------|
| 1 | Diferença em valores encontrados | Investigar causa antes deaprovar |

### Cenário de Exceção

| # | Condição | Ação |
|---|----------|------|
| 1 | Regressão encontrada | Reverter e corrigir antes deaprovar |
| 2 | Usuário reporta problema | Investigar e corrigir |

### Requisitos Não-Funcionais

- **Confiabilidade:** 100% de equivalência funcional
- **Performance:** Tempo de resposta deve ser equivalente ou melhor

---

## Critérios de Aceite

- [ ] Suite de testes passando
- [ ] Cálculos de inscrições iguais
- [ ] Cálculos de vendas iguais
- [ ] Cálculos de check-ins iguais
- [ ] Cálculos de receita iguais
- [ ] Menu lateral funcional
- [ ] Acesso para todos os organizadores
- [ ] Performance aceitável
- [ ] Aprovação do PO
