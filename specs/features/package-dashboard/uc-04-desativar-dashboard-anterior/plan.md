# Plano Tático de Implantação - UC-04: Desativar Dashboard Anterior

## Resumo

Este plano detalha os passos para desativação do componente de dashboard anterior após a migração completa para o `package-dashboard`. O processo envolve remoção do componente antigo em ambos os projetos (Organizador e Backoffice), atualização das rotas de menu e validação final de não-regressão.

---

## Ordem de Implementação

### Fase 1: Validação Prévia (Pré-requisitos)

| Passo | Ação | Dependência |
|-------|------|-------------|
| 1.1 | Validar que `package-dashboard` está funcionando corretamente em staging | UC-03 concluído |
| 1.2 | Executar testes de não-regressão completos | 1.1 |
| 1.3 | Revisar critérios de aceite do UC-04 | 1.2 |
| 1.4 | Obter aprovação do time de desenvolvimento | 1.3 |

### Fase 2: Remoção do Componente do Organizador

| Passo | Ação | Dependência |
|-------|------|-------------|
| 2.1 | Localizar arquivos do componente antigo no projeto Organizador | Fase 1 concluída |
| 2.2 | Remover arquivos do componente de dashboard anterior | 2.1 |
| 2.3 | Atualizar rotas/menu para apontar para `package-dashboard` | 2.2 |
| 2.4 | Executar testes unitários do Organizador | 2.3 |
| 2.5 | Executar build do Organizador | 2.4 |

### Fase 3: Remoção do Componente do Backoffice

| Passo | Ação | Dependência |
|-------|------|-------------|
| 3.1 | Localizar arquivos do componente antigo no projeto Backoffice | Fase 2 concluída |
| 3.2 | Remover arquivos do componente de dashboard anterior | 3.1 |
| 3.3 | Atualizar rotas/menu para apontar para `package-dashboard` | 3.2 |
| 3.4 | Executar testes unitários do Backoffice | 3.3 |
| 3.5 | Executar build do Backoffice | 3.4 |

### Fase 4: Deploy e Validação Final

| Passo | Ação | Dependência |
|-------|------|-------------|
| 4.1 | Executar deploy em ambiente de staging | Fases 2 e 3 concluídas |
| 4.2 | Validar funcionamento do dashboard em staging | 4.1 |
| 4.3 | Executar deploy em produção | 4.2 |
| 4.4 | Monitorar métricas pós-deploy | 4.3 |
| 4.5 | Validar acesso ao dashboard para organizadores | 4.4 |

---

## O que pode ser executado em paralelo

- **Validação de não-regressão** pode ocorrer simultaneamente à preparação dos scripts de remoção
- **Atualização de rotas no Organizador e Backoffice** podem ser feitas em paralelo após a remoção dos componentes

---

##Artefatos Necessários

Para executar este plano, os seguintes artefatos devem ser gerados previamente:

| Artefato | Descrição | Como gerar |
|----------|-----------|------------|
| Diagrama de Sequência | Para entender o fluxo de mensagens durante a desativação | Gerar com a skill (opção 4) |
| Diagrama de Estrutura Composta | Para visualizar componentes internos afetados | Gerar com a skill (opção 6) |
| Documento de Referência Tática | Passos detalhados para implementação | Gerar com a skill (opção 8) |

---

## Critérios de Aceite para Conclusão

- [ ] Componente anterior removido do Organizador
- [ ] Componente anterior removido do Backoffice
- [ ] Rota do menu lateral aponta para `package-dashboard`
- [ ] Todas as informações anteriormente exibidas disponíveis no novo componente
- [ ] Cálculos de inscrições, vendas, check-ins e receita permanecem idênticos
- [ ] Acesso ao dashboard funciona para todos os organizadores com eventos ativos
- [ ] Deploy realizado com sucesso sem indisponibilidade
- [ ] Métricas pós-deploy estão normais

---

## Riscos e Mitigações

| Risco | Probabilidade | Impacto | Mitigação |
|-------|---------------|---------|-----------|
| Regressão nos cálculos de dados | Baixa | Alto | Validação exhaustiva em staging antes de produção |
| Falha no deploy | Baixa | Alto | Rollback automatizado disponível |
| Tempo de indisponibilidade | Baixa | Alto | Deploy com zero-downtime (blue-green ou canary) |

---

## Referências Úteis

- [Documentação Turborepo - Workspaces](https://turbo.build/repo/docs/core-concepts/monorepos)
- [Strategy Pattern para Migração](https://refactoring.guru/design-patterns/strategy)
- [Zero-Downtime Deployment](https://martinfowler.com/bliki/BlueGreenDeployment.html)
- [React Query - Polling](https://tanstack.com/query/latest/docs/framework/react/guides/advanced-ssr)
