# Plano Tático de Implantação - packages

Este documento apresenta o plano de implantação para migração do dashboard para o package `@linka/ui`, ordenado por dependências funcionais dos casos de uso.

---

## Ordem de Implementação dos Casos de Uso

A ordem segue as dependências de inclusão (`<<include>>`) conforme diagrama de caso de uso:

| # | Caso de Uso | Dependências | Fase |
|----|-------------|--------------|------|
| 1 | UC-01: Criar Package @linka/ui | Nenhuma | Infraestrutura |
| 2 | UC-02: Migrar Componentes Gráficos | UC-01 | Infraestrutura |
| 3 | UC-03: Migrar Página de Dashboard | UC-02 | Composição |
| 4 | UC-04: Integrar Package no Organizer | UC-03 (include) | Integração |
| 5 | UC-05: Integrar Package no Backoffice | UC-03 (include) | Integração |
| 6 | UC-06: Desativar Dashboard Anterior | UC-04 (include) | Limpeza |
| 7 | UC-07: Validar Não-Regressão | UC-06 (include) | Validação |

---

## O que pode ser executado em paralelo

- **UC-04 (Organizer) e UC-05 (Backoffice):** Ambos incluem UC-03, podem ser desenvolvidos simultaneamente após UC-03 estar pronto.
- **UC-02:** Os 10 componentes gráficos podem ser migrados em paralelo (diferentes desenvolvedores).

---

## UC-01: Criar Package @linka/ui

**Fase:** Infraestrutura

### Artefatos de Referência

Consultar diagramas já gerados:
- `journey-packages.mermaid` - Seção "Criar Package"
- `structure-packages.mermaid` - Estrutura do package

### Frontend

| Artefato | Descrição | Localização |
|----------|-----------|-------------|
| Diretório packages/ui/ | Pasta raiz do package | `packages/ui/` |
| package.json | Configuração do package | `packages/ui/package.json` |
| tsconfig.json | Configuração TypeScript | `packages/ui/tsconfig.json` |
| index.ts | Exports principais | `packages/ui/src/index.ts` |

### Estrutura de Diretórios (Atomic Design - sem nomes átomos)

```
packages/ui/src/
├── components/
│   ├── charts/        # Gráficos Recharts
│   ├── forms/         # Formulários
│   ├── tables/        # Tabelas
│   ├── dialogs/       # Modais
│   └── common/        # Componentes compartilhados
├── pages/
│   └── Dashboard/     # Página de Dashboard
├── hooks/             # Hooks reutilizáveis
└── utils/             # Utilitários
```

### Backend

Não se aplica (package frontend only).

### Dependências do package.json

```json
{
  "name": "@linka/ui",
  "dependencies": {
    "react": "^19.0.0",
    "recharts": "3.7.0",
    "@tanstack/react-table": "^8.x",
    "@radix-ui/*": "*",
    "date-fns": "^2.x",
    "lucide-react": "*"
  },
  "peerDependencies": {
    "react": "^19.0.0"
  }
}
```

---

## UC-02: Migrar Componentes Gráficos

**Fase:** Infraestrutura  
**Dependência:** UC-01

### Artefatos de Referência

Consultar diagramas já gerados:
- `domain-packages.mermaid` - Seção ChartComponents
- `usecase-packages.plantuml` - Componentes a migrar (10 componentes)

### Frontend - Componentes a Migrar

| # | Componente | Origem | Destino |
|----|------------|--------|---------|
| 1 | SalesByStatus.tsx | organizer/src/ui/pages/dashboard/components/ | packages/ui/src/components/charts/ |
| 2 | SalesByPaymentMethod.tsx | organizer/src/ui/pages/dashboard/components/ | packages/ui/src/components/charts/ |
| 3 | SalesByTicket.tsx | organizer/src/ui/pages/dashboard/components/ | packages/ui/src/components/charts/ |
| 4 | SalesTotalByDay.tsx | organizer/src/ui/pages/dashboard/components/ | packages/ui/src/components/charts/ |
| 5 | SalesCountByDay.tsx | organizer/src/ui/pages/dashboard/components/ | packages/ui/src/components/charts/ |
| 6 | SalesCountAndTotalByDay.tsx | organizer/src/ui/pages/dashboard/components/ | packages/ui/src/components/charts/ |
| 7 | SalesByType.tsx | organizer/src/ui/pages/dashboard/components/ | packages/ui/src/components/charts/ |
| 8 | TicketsGeneral.tsx | organizer/src/ui/pages/dashboard/components/ | packages/ui/src/components/charts/ |
| 9 | CheckIn.tsx | organizer/src/ui/pages/dashboard/components/ | packages/ui/src/components/charts/ |
| 10 | Coupons.tsx | organizer/src/ui/pages/dashboard/components/ | packages/ui/src/components/charts/ |

### Regras de Migração

1. **Props:** Componentes devem receber dados via props, não via hooks
2. **Tipos:** Usar `@linka/domain` para tipos compartilhados
3. **Libs:** Usar Recharts 3.7.0 conforme especificado no PRD

### Exports

Criar `packages/ui/src/components/charts/index.ts`:
```typescript
export * from './SalesByStatus';
export * from './SalesByPaymentMethod';
// ... outros componentes
```

### Backend

Não se aplica.

---

## UC-03: Migrar Página de Dashboard

**Fase:** Composição  
**Dependência:** UC-02

### Artefatos de Referência

Consultar diagramas já gerados:
- `structure-packages.mermaid` - Seção pages/Dashboard/
- `navigation-packages.mermaid` - Fluxo de navegação

### Frontend

| Artefato | Descrição | Localização |
|----------|-----------|-------------|
| DashboardPage | Componente principal da página | `packages/ui/src/pages/Dashboard/index.tsx` |
| DashboardFilters | Componente de filtros | `packages/ui/src/pages/Dashboard/components/` |
| IndicatorCard | Card de métrica | `packages/ui/src/pages/Dashboard/components/` |
| ExportButton | Botão de exportação | `packages/ui/src/pages/Dashboard/components/` |

### Interface de Props

```typescript
interface DashboardPageProps {
  eventId: string;
  // Props opcionais podem ser adicionadas conforme necessidade
}
```

### Exports

Em `packages/ui/src/pages/index.ts`:
```typescript
export { DashboardPage } from './Dashboard';
```

### Backend

Não se aplica.

---

## UC-04: Integrar Package no Organizer

**Fase:** Integração  
**Dependência:** UC-03 (include)

### Artefatos de Referência

Consultar diagramas já gerados:
- `sequence-packages.plantuml` - Seção 4. Integrar Organizer

### Frontend

| Artefato | Descrição | Ação |
|----------|-----------|------|
| Install @linka/ui | Adicionar dependência | `pnpm add @linka/ui` no Organizer |
| Substituir imports | Alterar imports do dashboard | De `./ui/pages/dashboard` para `@linka/ui/pages/Dashboard` |
| hooks/ | Manter hooks de data fetching | `apps/organizer/src/ui/hooks/` |
| api/ | Manter services | `apps/organizer/src/api/` |

### Caminho de Import

```typescript
// Antes
import { Dashboard } from './ui/pages/dashboard';

// Depois
import { DashboardPage } from '@linka/ui/pages/Dashboard';
```

### Backend

Não se aplica (hooks permanecem no Organizer).

---

## UC-05: Integrar Package no Backoffice

**Fase:** Integração  
**Dependência:** UC-03 (include)

### Artefatos de Referência

Consultar diagramas já gerados:
- `sequence-packages.plantuml` - Seção 5. Integrar Backoffice

### Frontend

| Artefato | Descrição | Ação |
|----------|-----------|------|
| Install @linka/ui | Adicionar dependência | `pnpm add @linka/ui` no Backoffice |
| powerbi-client-react | Remover dependência | Remover do package.json |
| Substituir Power BI | Componente de dashboard | Substituir por DashboardPage |
| hooks/backoffice/ | Criar hooks específicos | `apps/backoffice/src/ui/hooks/` |

### Diferenças Organizer vs Backoffice

| Aspecto | Organizer | Backoffice |
|---------|-----------|------------|
| Dados | Por evento específico | Agregados |
| Hooks | useEventDashboardMetrics | Novos hooks específicos |

### Compatibilidade Tailwind

O PRD indica:
- Backoffice: Tailwind v4.1.15
- Package: v3.4.1
- Solução: Usar CSS vars para compatibilidade

### Backend

| Artefato | Descrição | Observação |
|----------|-----------|------------|
| API Endpoints | Dados agregados | Verificar se endpoints existem ou criar novos |

---

## UC-06: Desativar Dashboard Anterior

**Fase:** Limpeza  
**Dependência:** UC-04 (include)

### Artefatos de Referência

Consultar diagramas já gerados:
- `journey-packages.mermaid` - Seção "Integrar Organizer"

### Frontend

| Artefato | Descrição | Ação |
|----------|-----------|------|
| Rota | Manter endpoint | Mesma URL do dashboard anterior |
| Código antigo | Remover/comentar | `apps/organizer/src/ui/pages/dashboard/` |
| Imports | Limpar | Remover imports não utilizados |

### Validações

- Nova página deve ocupar exatamente o mesmo endpoint
- Todas as informações anteriores devem estar disponíveis
- Menu lateral continua funcionando

### Backend

Não se aplica.

---

## UC-07: Validar Não-Regressão

**Fase:** Validação  
**Dependência:** UC-06 (include)

### Artefatos de Referência

Consultar diagramas já gerados:
- `journey-packages.mermaid` - Seção "Validar Não-Regressão"

### Testes - Frontend

| # | Validação | Ferramenta | Descrição |
|----|-----------|------------|-----------|
| 1 | Testes unitários | Vit/Jest | Executar suite existente |
| 2 | Testes E2E | Playwright/Cypress | Testar fluxo completo |
| 3 | Menu lateral | Manual | Verificar navegação |
| 4 | Cross-browser | BrowserStack | Chrome, Firefox, Safari |

### Testes - Backend (Validações de Cálculo)

| # | Métrica | Comparação | Ação |
|----|---------|-------------|------|
| 1 | Inscrições | Antes/depois | Verificar contagem e status |
| 2 | Vendas | Antes/depois | Verificar total e métodos |
| 3 | Check-ins | Antes/depois | Verificar contagem e taxa |
| 4 | Receita | Antes/depois | Verificar valores por período |

### Validação com Usuário

| # | Teste | Ator |
|----|-------|------|
| 1 | Testar com diferentes eventos | Desenvolvedor |
| 2 | Validar acesso via menu lateral | Desenvolvedor |
| 3 | Aprovação final | Organizador (PO) |

---

## Resumo de Artefatos por Tipo

### Frontend

| UC | Arquivos/Componentes |
|----|---------------------|
| UC-01 | package.json, tsconfig.json, index.ts, estrutura de diretórios |
| UC-02 | 10 componentes gráficos em packages/ui/src/components/charts/ |
| UC-03 | DashboardPage, DashboardFilters, IndicatorCard, ExportButton |
| UC-04 | Substituição de imports no Organizer |
| UC-05 | Substituição Power BI, hooks específicos no Backoffice |
| UC-06 | Remoção de código antigo no Organizer |
| UC-07 | Execução de testes (unit, E2E) |

### Backend

| UC | Artefatos |
|----|-----------|
| UC-05 | Verificar/criar endpoints para dados agregados no Backoffice |

---

## Referências

- **Diagrama de Caso de Uso:** `usecase-packages.plantuml`
- **Diagrama de Sequência:** `sequence-packages.plantuml`
- **Estrutura do Package:** `structure-packages.mermaid`
- **Navegação:** `navigation-packages.mermaid`
- **Jornada:** `journey-packages.mermaid`
- **Modelo de Domínio:** `domain-packages.mermaid`

---

*Documento gerado automaticamente via skill research-to-plan*