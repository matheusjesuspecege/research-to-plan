# Documento de Referência para Implantação - UC-01

## Visão Geral

Este documento fornece o passo a passo para implementar o caso de uso **UC-01: Acessar Dashboard do Organizador**. O objetivo é criar a infraestrutura necessária para que o Organizador possa visualizar os dados do seu evento em tempo real através do dashboard.

---

## 1. Pré-requisitos

Antes de iniciar a implementação, certifique-se de que:

1. O usuário está autenticado no sistema
2. O Organizador possui pelo menos um evento ativo
3. O evento está selecionado no contexto atual
4. O `package-dashboard` já foi criado (depende do UC-03)

---

## 2. Estrutura de Componentes (Frontend)

### 2.1. Componentes do Dashboard

Com base no Atomic Design, os componentes devem ser organizados如下:

```
src/
├── components/
│   └── dashboard/
│       ├── atoms/
│       │   ├── DashboardCard.tsx       # Card individual com título, valor e ícone
│       │   ├── DashboardMetric.tsx     # Métrica numérica (inscrições, vendas, etc)
│       │   ├── DashboardSkeleton.tsx   # Estado de loading
│       │   └── DashboardError.tsx     # Componente de erro com retry
│       │
│       ├── molecules/
│       │   ├── DashboardCardGroup.tsx  # Grupo de cards (linha com 4 cards)
│       │   ├── DashboardHeader.tsx     # Cabeçalho com título e período
│       │   └── DashboardRefreshIndicator.tsx  # Indicador de atualização
│       │
│       ├── organisms/
│       │   ├── DashboardGrid.tsx        # Grid com todos os componentes
│       │   ├── DashboardContent.tsx     # Conteúdo principal do dashboard
│       │   └── DashboardErrorBoundary.tsx  # Boundary para erros
│       │
│       └── templates/
│           └── DashboardTemplate.tsx   # Template completo da página
```

### 2.2. Componente Principal

```tsx
// packages/package-dashboard/src/Dashboard.tsx
import React from 'react';
import { useDashboard } from './hooks/useDashboard';
import { DashboardTemplate } from './templates/DashboardTemplate';

interface DashboardProps {
  eventId: string;
  onError?: (error: Error) => void;
}

export const Dashboard: React.FC<DashboardProps> = ({ eventId, onError }) => {
  const { data, isLoading, error, refetch } = useDashboard(eventId);

  if (isLoading) {
    return <DashboardTemplate.Skeleton />;
  }

  if (error) {
    return <DashboardTemplate.Error onRetry={refetch} />;
  }

  return <DashboardTemplate data={data} />;
};
```

---

## 3. Hooks e Gestão de Estado

### 3.1. Hook useDashboard

```tsx
// packages/package-dashboard/src/hooks/useDashboard.ts
import { useQuery } from '@tanstack/react-query';

const POLLING_INTERVAL = 30000; // 30 segundos

interface DashboardData {
  registrations: number;
  sales: number;
  checkIns: number;
  revenue: number;
}

export const useDashboard = (eventId: string) => {
  return useQuery<DashboardData>({
    queryKey: ['dashboard', eventId],
    queryFn: () => fetchDashboardData(eventId),
    refetchInterval: POLLING_INTERVAL,
    staleTime: 10000,
  });
};

async function fetchDashboardData(eventId: string): Promise<DashboardData> {
  const response = await fetch(`/api/events/${eventId}/dashboard`);
  
  if (!response.ok) {
    throw new Error('Falha ao carregar dados do dashboard');
  }
  
  return response.json();
}
```

**Referência:** https://tanstack.com/query/latest/docs/framework/react/guides/optimistic-updates

---

## 4. Contratos de API

### 4.1. Endpoint do Dashboard

```typescript
// contracts/dashboard.ts
export interface DashboardResponse {
  eventId: string;
  registrations: {
    total: number;
    pending: number;
    confirmed: number;
  };
  sales: {
    total: number;
    quantity: number;
  };
  checkIns: {
    total: number;
    checkedIn: number;
  };
  revenue: {
    total: number;
    currency: string;
  };
  lastUpdated: string;
}
```

### 4.2. Contrato de Erro

```typescript
// contracts/api-error.ts
export interface ApiError {
  code: string;
  message: string;
  details?: Record<string, unknown>;
}
```

---

## 5. Passos de Implementação

### Passo 1: Criar Estrutura do Package

```bash
# No diretório packages do monorepo
mkdir -p packages/package-dashboard/src
mkdir -p packages/package-dashboard/src/components/dashboard/{atoms,molecules,organisms,templates}
mkdir -p packages/package-dashboard/src/hooks
mkdir -p packages/package-dashboard/src/contracts
mkdir -p packages/package-dashboard/src/services
mkdir -p packages/package-dashboard/src/types
```

### Passo 2: Configurar package.json

```json
{
  "name": "@linka-events/package-dashboard",
  "version": "1.0.0",
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "peerDependencies": {
    "react": "^18.0.0",
    "@tanstack/react-query": "^5.0.0"
  },
  "dependencies": {
    "@tanstack/react-query": "^5.0.0"
  },
  "scripts": {
    "build": "tsc",
    "test": "jest"
  }
}
```

### Passo 3: Criar Componentes Atômicos

Crie os componentes na seguinte ordem:
1. `DashboardCard.tsx` - Card base
2. `DashboardMetric.tsx` - Métrica com formatação
3. `DashboardSkeleton.tsx` - Loading state
4. `DashboardError.tsx` - Estado de erro com retry

### Passo 4: Criar Componentes Moleculares

1. `DashboardCardGroup.tsx` - Agrupamento de cards
2. `DashboardHeader.tsx` - Cabeçalho
3. `DashboardRefreshIndicator.tsx` - Indicador de atualização

### Passo 5: Criar Componentes Organísmicos

1. `DashboardGrid.tsx` - Layout do grid
2. `DashboardContent.tsx` - Conteúdo principal
3. `DashboardErrorBoundary.tsx` - Error boundary

### Passo 6: Criar Template

```tsx
// packages/package-dashboard/src/templates/DashboardTemplate.tsx
import React from 'react';
import { DashboardGrid } from '../organisms/DashboardGrid';
import { DashboardHeader } from '../molecules/DashboardHeader';
import { DashboardSkeleton } from '../atoms/DashboardSkeleton';
import { DashboardError } from '../atoms/DashboardError';

interface DashboardTemplateProps {
  data?: {
    registrations: number;
    sales: number;
    checkIns: number;
    revenue: number;
  };
}

export const DashboardTemplate = {
  Skeleton: () => <DashboardSkeleton />,
  
  Error: ({ onRetry }: { onRetry: () => void }) => 
    <DashboardError onRetry={onRetry} />,
  
  Content: ({ data }: DashboardTemplateProps) => (
    <div>
      <DashboardHeader />
      <DashboardGrid data={data} />
    </div>
  ),
};
```

### Passo 7: Integrar no Organizador

```tsx
// No projeto do Organizador
import { Dashboard } from '@linka-events/package-dashboard';

const OrganizadorDashboard = () => {
  const { selectedEventId } = useEventContext();
  
  return <Dashboard eventId={selectedEventId} />;
};
```

---

## 6. Testes

### 6.1. Testes Unitários

```tsx
// tests/Dashboard.test.tsx
import { render, screen, waitFor } from '@testing-library/react';
import { Dashboard } from '../Dashboard';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';

const queryClient = new QueryClient();

const renderWithProvider = (component: React.ReactNode) => {
  return render(
    <QueryClientProvider client={queryClient}>
      {component}
    </QueryClientProvider>
  );
};

describe('Dashboard', () => {
  it('exibe skeleton durante carregamento', () => {
    renderWithProvider(<Dashboard eventId="123" />);
    expect(screen.getByTestId('dashboard-skeleton')).toBeInTheDocument();
  });

  it('exibe cards com dados após carregamento', async () => {
    renderWithProvider(<Dashboard eventId="123" />);
    
    await waitFor(() => {
      expect(screen.getByText('Inscrições')).toBeInTheDocument();
      expect(screen.getByText('Vendas')).toBeInTheDocument();
      expect(screen.getByText('Check-ins')).toBeInTheDocument();
      expect(screen.getByText('Receita')).toBeInTheDocument();
    });
  });

  it('exibe mensagem de erro em caso de falha', async () => {
    renderWithProvider(<Dashboard eventId="invalid" />);
    
    await waitFor(() => {
      expect(screen.getByText(/falha ao carregar/i)).toBeInTheDocument();
    });
  });
});
```

---

## 7. Critérios de Aceite

| # | Critério | Validação |
|---|----------|-----------|
| 1 | Menu lateral exibe opção "Dashboard" | Verificar presença no menu |
| 2 | Click na opção carrega o componente | Teste de navegação |
| 3 | Exibe 4 cards: Inscrições, Vendas, Check-ins, Receita | Verificar renderização |
| 4 | Dados correspondem ao evento selecionado | Teste com diferentes eventos |
| 5 | Atualização automática via polling | Verificar chamadas API periódicas |
| 6 | Mensagem de erro em caso de falha | Teste de cenário de exceção |
| 7 | Opção de retry disponível | Verificar botão e funcionalidade |

---

## 8. Referências

- **React Query (TanStack Query)**: https://tanstack.com/query/latest/docs/framework/react/guides/queries
- **Atomic Design**: https://atomicdesign.bradfrost.com/
- **TypeScript**: https://www.typescriptlang.org/docs/
- **Jest Testing Library**: https://testing-library.com/docs/react-testing-library/intro/
- **React Error Boundaries**: https://react.dev/reference/react/Component#catching-rendering-errors-with-an-error-boundary
- **Turborepo**: https://turbo.build/repo/docs
- **React Query - Polling**: https://tanstack.com/query/latest/docs/framework/react/guides/advanced-solutions#asynchronous-state-reducers
