# Documento de Referência para Implementação - UC-02

## Visão Geral

Este documento fornece o passo a passo para implementar o caso de uso **UC-02: Acessar Dashboard do Backoffice**, que consiste em integrar o `package-dashboard` no projeto Backoffice para substituir o PowerBI.

---

## Pré-requisitos

- Node.js 18+
- Turborepo configurado no projeto
- Projeto Backoffice existente
- `package-dashboard` já criado (via UC-03)

---

## Passo a Passo para Implementação

### 1. Verificar Instalação do package-dashboard

Certifique-se de que o `package-dashboard` está configurado no monorepo e visível ao Backoffice.

**Referências:**
- Turborepo Workspaces: https://turbo.build/repo/docs/core-concepts/monorepos/configuring-workspaces
- npm workspaces: https://docs.npmjs.com/cli/v8/using-npm/workspaces

---

### 2. Adicionar Dependência no Backoffice

No arquivo `packages/backoffice/package.json`, adicione a dependência:

```json
{
  "dependencies": {
    "@linka-events/package-dashboard": "workspace:*"
  }
}
```

> **Nota:** O código acima é apenas uma ideia de implementação que funciona, porém não representa os padrões de código real da equipe ou projeto.

Execute o comando para instalar:

```bash
npm install
```

**Referências:**
- npm install: https://docs.npmjs.com/cli/v9/commands/npm-install
- Yarn workspaces: https://yarnpkg.com/features/workspaces

---

### 3. Configurar Menu Lateral

No componente de menu do Backoffice, adicione a opção "Dashboard".

**Referências:**
- React Router - Navigation: https://reactrouter.com/en/main/start/tutorial
- Tailwind CSS - Styling: https://tailwindcss.com/docs

Exemplo simplificado de rota:

```tsx
import { Dashboard } from '@linka-events/package-dashboard';

function App() {
  return (
    <Routes>
      <Route path="/dashboard" element={<Dashboard />} />
    </Routes>
  );
}
```

> **Nota:** O código acima é apenas uma ideia de implementação que funciona, porém não representa os padrões de código real da equipe ou projeto.

---

### 4. Configurar Contexto do Backoffice

O `package-dashboard` recebe dados específicos do contexto. Configure as props ou context provider:

```tsx
import { Dashboard, DashboardProvider } from '@linka-events/package-dashboard';

function DashboardPage() {
  return (
    <DashboardProvider context="backoffice">
      <Dashboard 
        dataSource="/api/backoffice/dashboard"
        refreshInterval={30000}
      />
    </DashboardProvider>
  );
}
```

> **Nota:** O código acima é apenas uma ideia de implementação que funciona, porém não representa os padrões de código real da equipe ou projeto.

**Referências:**
- React Context: https://react.dev/learn/passing-data-deeply-with-context
- React Query - Polling: https://tanstack.com/query/latest/docs/framework/react/guides/queries#query-refetching

---

### 5. Configurar API Backoffice

Crie os endpoints de API para fornecer os dados do dashboard:

| Endpoint | Descrição |
|----------|-----------|
| `GET /api/backoffice/dashboard/inscriptions` | Total de inscrições |
| `GET /api/backoffice/dashboard/sales` | Total de vendas |
| `GET /api/backoffice/dashboard/checkins` | Total de check-ins |
| `GET /api/backoffice/dashboard/revenue` | Total de receita |

**Referências:**
- API RESTful Best Practices: https://restfulapi.net/
- Next.js API Routes: https://nextjs.org/docs/app/building-your-application/routing/route-handlers

---

### 6. Implementar Tratamento de Erros

Configure a exibição de erros e retry conforme especificado no UC-02:

```tsx
import { useQuery } from '@tanstack/react-query';

function DashboardData() {
  const { data, isLoading, error, refetch } = useQuery({
    queryKey: ['dashboard'],
    queryFn: fetchDashboardData,
    retry: 3,
    refetchInterval: 30000,
  });

  if (isLoading) return <LoadingSpinner />;
  if (error) return <ErrorDisplay onRetry={refetch} />;
  
  return <Dashboard data={data} />;
}
```

> **Nota:** O código acima é apenas uma ideia de implementação que funciona, porém não representa os padrões de código real da equipe ou projeto.

**Referências:**
- React Query - Error Handling: https://tanstack.com/query/latest/docs/framework/react/guides/query-functions#handling-errors
- React Query - Retry: https://tanstack.com/query/latest/docs/framework/react/guides/queries#retry

---

### 7. Testar Integração

Execute os testes para validar a integração:

```bash
# Testes unitários
npm run test -- --filter=backoffice

# Teste de integração
npm run test:e2e -- --filter=backoffice
```

**Referências:**
- Jest - Testing: https://jestjs.io/docs/getting-started
- Playwright - E2E: https://playwright.dev/docs/intro

---

## Critérios de Aceite UC-02

| Critério | Status |
|----------|--------|
| Menu lateral do Backoffice exibe opção "Dashboard" | ⬜ |
| Click na opção "Dashboard" carrega o package-dashboard | ⬜ |
| Exibe 4 cards: Inscrições, Vendas, Check-ins, Receita | ⬜ |
| Estrutura visual idêntica ao dashboard do Organizador | ⬜ |
| Dados são específicos do contexto Backoffice | ⬜ |
| Dados são atualizados automaticamente via polling | ⬜ |
| Mensagem de erro exibida em caso de falha na API | ⬜ |
| Opção de retry disponível após falha | ⬜ |

---

## Links Rápidos

- [Research.md da Feature](../../research.md)
- [UC-02 - Caso de Uso](./uc-02-acessar-dashboard-backoffice.md)
- [Documentação React Query](https://tanstack.com/query/latest)
- [Documentação Turborepo](https://turbo.build/repo/docs)
