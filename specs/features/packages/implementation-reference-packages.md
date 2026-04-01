# Documento de Referência para Implementação - packages

> Este documento descreve a visão operacional para desenvolvedores começarem a implementar a feature `packages`. Siga os passos na ordem indicada.

---

## Visão Geral

Esta feature migra o dashboard do Organizer para um package compartilhado `@linka/ui` que será utilizado tanto no Organizer quanto no Backoffice.

---

## UC-01: Criar Package @linka/ui

### Objetivo
Criar a estrutura base do package `@linka/ui` no monorepo.

### Passo a Passo

#### 1. Criar diretório do package
```
packages/ui/
```

#### 2. Criar package.json

> ⚠️ **Nota:** O código abaixo é uma ideia de implementação que funciona. Implemente seguindo sua própria forma de trabalho e consulte as referências fornecidas para estudo.

```json
{
  "name": "@linka/ui",
  "version": "0.0.1",
  "private": false,
  "main": "./dist/index.js",
  "module": "./dist/index.mjs",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "import": "./dist/index.mjs",
      "require": "./dist/index.js",
      "types": "./dist/index.d.ts"
    }
  },
  "scripts": {
    "build": "tsup",
    "dev": "tsup --watch"
  },
  "dependencies": {
    "react": "^19.0.0",
    "recharts": "3.7.0",
    "@tanstack/react-table": "^8.20.0",
    "@radix-ui/react-dialog": "^1.1.0",
    "date-fns": "^2.30.0",
    "lucide-react": "^0.460.0"
  },
  "peerDependencies": {
    "react": "^19.0.0"
  },
  "devDependencies": {
    "@types/react": "^19.0.0",
    "tsup": "^8.0.0",
    "typescript": "^5.0.0"
  }
}
```

**Referências:**
- tsup: https://tsup.ego.sh/
- Publishing npm packages: https://docs.npmjs.com/creating-and-publishing-unscoped-public-packages

#### 3. Criar tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "moduleResolution": "bundler",
    "jsx": "react-jsx",
    "declaration": true,
    "declarationMap": true,
    "strict": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "forceConsistentCasingInFileNames": true,
    "outDir": "./dist"
  },
  "include": ["src"],
  "exclude": ["node_modules", "dist"]
}
```

**Referências:**
- TypeScript config: https://www.typescriptlang.org/docs/handbook/tsconfig-json.html

#### 4. Criar estrutura de diretórios

```
packages/ui/src/
├── components/
│   ├── charts/
│   ├── forms/
│   ├── tables/
│   ├── dialogs/
│   └── common/
├── pages/
│   └── Dashboard/
├── hooks/
└── utils/
```

#### 5. Criar index.ts base

```typescript
// packages/ui/src/index.ts
export * from './components';
export * from './pages';
```

---

## UC-02: Migrar Componentes Gráficos

### Objetivo
Migrar os 10 componentes de gráficos do Organizer para o package `@linka/ui`.

### Passo a Passo

#### 1. Copiar componentes para o package

Copie os seguintes arquivos de `apps/organizer/src/ui/pages/dashboard/components/` para `packages/ui/src/components/charts/`:

| # | Componente |
|---|------------|
| 1 | SalesByStatus.tsx |
| 2 | SalesByPaymentMethod.tsx |
| 3 | SalesByTicket.tsx |
| 4 | SalesTotalByDay.tsx |
| 5 | SalesCountByDay.tsx |
| 6 | SalesCountAndTotalByDay.tsx |
| 7 | SalesByType.tsx |
| 8 | TicketsGeneral.tsx |
| 9 | CheckIn.tsx |
| 10 | Coupons.tsx |

#### 2. Adaptar componentes para receber dados via props

> ⚠️ **Nota:** O código abaixo é uma ideia de implementação que funciona. Implemente seguindo sua própria forma de trabalho e consulte as referências fornecidas para estudo.

**Antes (com hook interno):**
```typescript
const SalesByStatus = () => {
  const { data } = useSalesByStatus();
  // ...
};
```

**Depois (com props):**
```typescript
interface SalesByStatusProps {
  data: SalesByStatusData[];
}

export const SalesByStatus = ({ data }: SalesByStatusProps) => {
  // ...
};
```

**Referências:**
- Recharts: https://recharts.org/en-US/
- Composição de componentes React: https://react.dev/learn/passing-data-deeply-with-context

#### 3. Criar index.ts de exports

```typescript
// packages/ui/src/components/charts/index.ts
export { SalesByStatus } from './SalesByStatus';
export { SalesByPaymentMethod } from './SalesByPaymentMethod';
export { SalesByTicket } from './SalesByTicket';
// ... outros exports
```

---

## UC-03: Migrar Página de Dashboard

### Objetivo
Criar a página de Dashboard como componente reutilizável no package.

### Passo a Passo

#### 1. Criar DashboardPage

```typescript
// packages/ui/src/pages/Dashboard/index.tsx
import React from 'react';
import { SalesByStatus, SalesByPaymentMethod } from '../../components/charts';

interface DashboardPageProps {
  eventId: string;
}

export const DashboardPage: React.FC<DashboardPageProps> = ({ eventId }) => {
  return (
    <div className="dashboard-page">
      {/* Composição dos componentes de gráficos */}
      <SalesByStatus eventId={eventId} />
      <SalesByPaymentMethod eventId={eventId} />
    </div>
  );
};
```

#### 2. Exportar no index principal

```typescript
// packages/ui/src/pages/index.ts
export { DashboardPage } from './Dashboard';
```

**Referências:**
- Atomic Design: https://atomicdesign.bradfrost.com/

---

## UC-04: Integrar Package no Organizer

### Objetivo
Substituir o dashboard local pelo package `@linka/ui` no Organizer.

### Passo a Passo

#### 1. Adicionar dependência

```bash
cd apps/organizer
pnpm add @linka/ui
```

#### 2. Substituir imports

**Antes:**
```typescript
import { Dashboard } from './ui/pages/dashboard';
```

**Depois:**
```typescript
import { DashboardPage } from '@linka/ui/pages/Dashboard';
```

#### 3. Atualizar a rota

```typescript
// apps/organizer/src/routes/index.tsx
<Route path="/dashboard" element={<DashboardPage eventId={eventId} />} />
```

**Referências:**
- Turborepo workspaces: https://turbo.build/repo/docs/core-concepts/monorepos/internal-packages

---

## UC-05: Integrar Package no Backoffice

### Objetivo
Substituir o Power BI Embedded pelo dashboard do package `@linka/ui`.

### Passo a Passo

#### 1. Adicionar dependência

```bash
cd apps/backoffice
pnpm add @linka/ui
```

#### 2. Remover Power BI (se ainda existir)

```bash
pnpm remove powerbi-client powerbi-client-react
```

#### 3. Criar hooks específicos para Backoffice

> ⚠️ **Nota:** O código abaixo é uma ideia de implementação que funciona. Implemente seguindo sua própria forma de trabalho e consulte as referências fornecidas para estudo.

```typescript
// apps/backoffice/src/hooks/useAggregatedMetrics.ts
import { useQuery } from '@tanstack/react-query';

export const useAggregatedMetrics = () => {
  return useQuery({
    queryKey: ['aggregated-metrics'],
    queryFn: async () => {
      const response = await fetch('/api/metrics/aggregated');
      return response.json();
    },
  });
};
```

#### 4. Compatibilidade Tailwind (CSS Variables)

Se houver conflitos de versão do Tailwind, use CSS variables para compatibilidade:

```css
/* packages/ui/src/styles/variables.css */
:root {
  --color-primary: #3b82f6;
  --color-secondary: #8b5cf6;
  /* ... outras variáveis */
}
```

**Referências:**
- Tailwind CSS: https://tailwindcss.com/docs
- React Query: https://tanstack.com/query/latest/docs/framework/react/overview

---

## UC-06: Desativar Dashboard Anterior

### Objetivo
Remover o código antigo do dashboard no Organizer.

### Passo a Passo

#### 1. Remover código antigo

```
apps/organizer/src/ui/pages/dashboard/
```

#### 2. Verificar imports

Certifique-se de que não há imports apontando para o diretório antigo.

#### 3. Manter rota

A rota `/dashboard` deve permanecer ativa, apontando para o novo componente.

---

## UC-07: Validar Não-Regressão

### Objetivo
Garantir que todas as funcionalidades continuam funcionando após a migração.

### Passo a Passo

#### 1. Executar testes unitários

```bash
pnpm test
```

#### 2. Executar testes E2E (se existirem)

```bash
pnpm test:e2e
```

#### 3. Validar manualmente

| # | Teste | Descrição |
|---|-------|-----------|
| 1 | Menu lateral | Acessar dashboard pelo menu |
| 2 | Filtros | Verificar se filtros funcionam |
| 3 | Gráficos | Todos os gráficos renderizando |
| 4 | Responsividade | Works em diferentes tamanhos |

#### 4. Verificar cálculos

Comparar valores antes e depois da migração:
- Total de vendas
- Inscrições por status
- Receita por período

**Referências:**
- Vitest: https://vitest.dev/
- Playwright: https://playwright.dev/

---

## Resumo de Comandos Úteis

```bash
# Build do package
cd packages/ui && pnpm build

# Adicionar ao Organizer
cd apps/organizer && pnpm add @linka/ui

# Adicionar ao Backoffice
cd apps/backoffice && pnpm add @linka/ui

# Executar testes
pnpm test

# Executar E2E
pnpm test:e2e
```

---

*Documento gerado automaticamente via skill research-to-plan*