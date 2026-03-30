# UC-04 - Desativar Dashboard Anterior

- **Ator Principal:** Desenvolvedor - Membro do time de desenvolvimento responsável por desativar o componente de dashboard anterior após a migração.
- **Atores Secundários:** Sistema (Monorepo) que valida a desativação.
- **Resumo:** Este caso de uso representa o processo de desativação definitiva do componente de dashboard anterior após a conclusão da migração para o `package-dashboard`. O componente anterior deve ser removido de ambos os projetos (Organizador e Backoffice), garantindo que todas as informações anteriormente exibidas estejam disponíveis no novo componente.

- **Pré-condições:**
  - `package-dashboard` deve estar funcionando corretamente
  - Todos os dados devem estar sendo exibidos corretamente
  - Validação de não-regressão deve estar completa
  - Time de desenvolvimento deve ter aprovado a desativação

- **Pós-condições:**
  - Componente anterior removido do Organizador
  - Componente anterior removido do Backoffice
  - Ponto de acesso no menu utiliza novo package

---

## Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Valida que novo dashboard está funcionando | 1. Confirma funcionamento correto |
| 2. Revisa critérios de não-regressão | 2. Lista todos os critérios |
| 3. Confirma que todos estão atendidos | 3. Marca validação como completa |
| 4. Remove componente do Organizador | 4. Deleta arquivos do componente antigo |
| 5. Remove componente do Backoffice | 5. Deleta arquivos do componente antigo |
| 6. Atualiza menu lateral | 6. Garante que rota aponta para novo package |
| 7. Executa testes finais | 7. Valida ambiente de staging |
| 8. Faz deploy em produção | 8. Monitora métricas pós-deploy |

---

## Restrições/Validações

1. **Não-regressão:** Todas as regras de negócio existentes devem ser mantidas:
   - Cálculo de inscrições
   - Cálculo de vendas
   - Cálculo de check-ins
   - Cálculo de receita
2. **Migração atômica:** Substituição deve ocorrer sem indisponibilidade
3. **Validação prévia:** Componente anterior deve ser desativado **após** validação completa
4. **Monitoramento:** Métricas devem ser monitoradas após a desativação

---

## Cenário Alternativo

**Cenário A: Problema identificado após início da desativação**

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Inicia desativação | 1. Remove componente |
| 2. Identifica problema nos dados | 2. Sistema alerta sobre regressão |
| 3. Reverte desativação | 3. Restaura componente anterior |
| 4. Corrige problema | 4. Atualiza package |
| 5. Reinicia processo de desativação | |

---

## Cenário de Exceção

**Exceção 1: Falha no deploy**

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Executa deploy em produção | 1. Deploy falha |
| | 2. Sistema mantém ambiente anterior |
| 3. Diagnostica problema | 4. Reporta erro |
| 5. Corrige e reexecuta deploy | |

---

## Requisitos Não-Funcionais

1. **Zero downtime:** Migração deve ser atômica
2. **Rollback:** Deve ser possível reverter em caso de problemas
3. **Monitoramento:** Métricas devem ser monitoradas pós-migração

---

## Critérios de Aceite

- [ ] Componente anterior removido do projeto Organizador
- [ ] Componente anterior removido do projeto Backoffice
- [ ] Rota do menu lateral aponta para `package-dashboard`
- [ ] Todas as informações anteriormente exibidas estão disponíveis no novo componente
- [ ] Cálculos de inscrições, vendas, check-ins e receita permanecem idênticos
- [ ] Acesso ao dashboard funciona para todos os organizadores com eventos ativos
- [ ] Deploy realizado com sucesso sem indisponibilidade
- [ ] Métricas pós-deploy estão normais
