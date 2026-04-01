# UC-02 - Migrar Componentes Gráficos para o Package

- **Caso de Uso Geral:** -
- **Ator Principal:** Desenvolvedor
- **Atores Secundários:** -
- **Resumo:** Este caso de uso representa o processo de migração dos componentes gráficos do dashboard atual (localizados em `apps/organizer/src/ui/pages/dashboard/components/`) para o novo package `@linka/ui`. Cada gráfico será movido para `packages/ui/src/components/charts/` com devidas adaptações para remover dependências diretas do Organizer.
- **Pré-condições:** Package `@linka/ui` criado (UC-01). Componentes originais identificados em `apps/organizer/src/ui/pages/dashboard/components/`.
- **Pós-condições:** Todos os componentes gráficos migrados para o package com testes passando.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Identificar componentes gráficos existentes no Organizer | |
| 2. Para cada componente: | |
| 2.1 Copiar código para `packages/ui/src/components/charts/` | |
| 2.2 Remover imports de componentes locais do Organizer | |
| 2.3 Substituir imports por componentes do @linka/ui ou libs externas | |
| 2.4 Adaptar tipos para usar `@linka/domain` | |
| 2.5 Exportar componente em `components/charts/index.ts` | |
| 3. Executar build do package | Valida compilação |
| 4. Executar testes existentes | Valida não-regressão |

### Componentes a Migrar

| Componente | Destino |
|------------|---------|
| SalesByStatus.tsx | packages/ui/src/components/charts/ |
| SalesByPaymentMethod.tsx | packages/ui/src/components/charts/ |
| SalesByTicket.tsx | packages/ui/src/components/charts/ |
| SalesTotalByDay.tsx | packages/ui/src/components/charts/ |
| SalesCountByDay.tsx | packages/ui/src/components/charts/ |
| SalesCountAndTotalByDay.tsx | packages/ui/src/components/charts/ |
| SalesByType.tsx | packages/ui/src/components/charts/ |
| TicketsGeneral.tsx | packages/ui/src/components/charts/ |
| CheckIn.tsx | packages/ui/src/components/charts/ |
| Coupons.tsx | packages/ui/src/components/charts/ |

### Restrições/Validações

- Componentes devem receber dados via props, não via hooks
- Todos os tipos devem ser importados de `@linka/domain`
- Gráficos devem usar Recharts 3.7.0

### Cenário Alternativo

| # | Condição | Ação |
|---|----------|------|
| 1 | Componente depende de hook específico do Organizer | Manter componente no Organizer ou criar versão genérica |

### Cenário de Exceção

| # | Condição | Ação |
|---|----------|------|
| 1 | Componente usa dependência incompatível | Avaliar refatoração ou manter no Organizer |
| 2 | Teste falha após migração | Ajustar componente e verificarvalidação |

### Requisitos Não-Funcionais

- **Reutilização:** Componentes devem funcionar em qualquer app que use o package
- **Consistência:** UI deve seguir design tokens do @ads/tokens

---

## Critérios de Aceite

- [ ] Todos os componentes gráficos migrados para `packages/ui/src/components/charts/`
- [ ] Componentes exportados corretamente
- [ ] Build do package executa com sucesso
- [ ] Tipos使用的是 `@linka/domain`
- [ ] Componentes funcionam sem dependências do Organizer
