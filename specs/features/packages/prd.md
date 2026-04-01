# 1. PRD - packages

**Status:** developing

## 1.1 Requisito do Produto

**Título:** Migrar novo dashboard para package no monorepo e inserir no organizador/backoffice
**Tipo:** Refactor
**Story Points:** 13
**Tags:** Frontend
**Responsável:** Matheus Gomes Rodrigues de Jesus

---

### Tópico 1 - Contextualização

- O painel do organizador no Linka Eventos conta atualmente com um dashboard que centraliza as principais informações de acompanhamento de um evento, exibindo dados de inscrições, vendas, check-ins, acessos e receita em tempo real. Esse dashboard é acessado diretamente pelo menu lateral do painel do organizador e representa uma das telas mais estratégicas da plataforma, sendo o ponto central de monitoramento durante a realização de um evento;

- O cenário atual apresenta um problema de natureza arquitetural com impacto direto na evolução do produto. O componente de dashboard está implementado de forma isolada, sem estar organizado como um package compartilhável dentro do monorepo da plataforma. Isso limita a capacidade do time de desenvolvimento de reutilizar, manter e evoluir esse componente de maneira eficiente, gerando acoplamento desnecessário e dificultando futuras expansões;

- Como consequência, qualquer evolução no dashboard exige esforço desproporcional, aumenta o risco de inconsistências entre ambientes e torna o ciclo de desenvolvimento mais lento. A ausência de uma estrutura padronizada também compromete a escalabilidade da plataforma a longo prazo;

- A proposta é migrar o dashboard para um package dentro do monorepo e integrá-lo ao painel do organizador, substituindo definitivamente o componente anterior. Essa migração será acompanhada de mudanças visuais no dashboard, entregando ao mesmo tempo uma melhoria arquitetural e uma experiência atualizada para o organizador;

- Os benefícios esperados são a padronização da arquitetura da plataforma, maior facilidade de manutenção e evolução do dashboard, redução do risco de regressões em futuras entregas e uma interface mais moderna e consistente para o organizador acompanhar seus eventos em tempo real.

---

### Tópico 2 - Migração e desativação do dashboard anterior

- Com a conclusão da migração do dashboard para o novo package no monorepo, o componente anterior deve ser definitivamente desativado, deixando de ser renderizado em qualquer contexto da plataforma;

- O novo dashboard deve ocupar exatamente o mesmo ponto de acesso do anterior dentro do menu lateral do painel do organizador, garantindo continuidade na experiência de navegação sem impacto na jornada do organizador;

- O time de desenvolvimento deve validar, antes da desativação do dashboard anterior, que todas as informações anteriormente exibidas estão disponíveis e funcionando corretamente no novo componente.

---

### Tópico 6 - Critérios de não-regressão

- A migração não deve alterar nenhuma das regras de negócio já existentes relacionadas ao cálculo e exibição dos dados de inscrições, vendas, check-ins e receita;

- O acesso ao dashboard pelo menu lateral deve continuar funcionando para todos os organizadores com eventos ativos na plataforma, sem necessidade de qualquer ação adicional por parte deles;

- Caso a migração seja realizada com o ambiente de produção ativo, o time deve garantir que a substituição do componente ocorra de forma atômica, sem período de indisponibilidade do dashboard para os organizadores.

---

## 2. Decisões Técnicas (ADR)

### 2.1. Contexto

O monorepo **linka-eventos-platform** utiliza **Turborepo** com **pnpm** e atualmente possui:

| App | Framework | Port | Propósito |
|-----|-----------|------|-----------|
| `@linka/organizer` | Vite + React 19 | 3000 | Painel do organizador |
| `@linka/backoffice` | Vite + React 19 | 3002 | Backoffice administrativo |
| `@linka/participant` | Next.js 16 | 3001 | Aplicação para participantes |
| `@linka/api` | NestJS 11 | 8080 | API REST |

**Packages existentes:**

| Package | Propósito |
|---------|-----------|
| `@linka/domain` | DTOs, Enums e tipos compartilhados |
| `@linka/ngrok` | Wrapper para túnel ngrok |

**Situação atual do Dashboard:**

- **Organizer**: Dashboard implementado com **Recharts 3.7.0** em `apps/organizer/src/ui/pages/dashboard/`, utilizando componentes de `apps/organizer/src/ui/components/`
- **Backoffice**: Usa **Power BI Embedded** (`powerbi-client-react`) para dashboard

### 2.2. Decisão

Criar o package **`@linka/ui`** para centralizar componentes compartilhados e a página de dashboard.

**Estrutura do package:**

```
packages/ui/
├── src/
│   ├── components/
│   │   ├── forms/           # Inputs, Select, DatePicker, etc.
│   │   ├── tables/          # DataTable, Pagination, etc.
│   │   ├── charts/          # TODOS os gráficos reutilizáveis
│   │   │   ├── SalesByStatus.tsx
│   │   │   ├── SalesByPaymentMethod.tsx
│   │   │   ├── SalesByTicket.tsx
│   │   │   ├── SalesTotalByDay.tsx
│   │   │   ├── SalesCountByDay.tsx
│   │   │   ├── SalesCountAndTotalByDay.tsx
│   │   │   ├── SalesByType.tsx
│   │   │   ├── TicketsGeneral.tsx
│   │   │   ├── CheckIn.tsx
│   │   │   ├── Coupons.tsx
│   │   │   └── ...
│   │   ├── dialogs/         # Dialog, AlertDialog, etc.
│   │   ├── common/          # Button, Badge, Tooltip, Avatar, etc.
│   │   └── index.ts
│   ├── pages/
│   │   ├── Dashboard/
│   │   │   ├── index.tsx           # Composição da página
│   │   │   ├── components/         # IndicatorCard, ExportButton, ExportDialog (específicos)
│   │   │   ├── tables/             # Tabelas específicas do dashboard
│   │   │   └── index.ts
│   │   └── index.ts
│   └── index.ts
├── package.json
└── tsconfig.json
```

**Exportação pública:**

```typescript
// @linka/ui - Componentes
export * from './components/forms';
export * from './components/tables';
export * from './components/charts';
export * from './components/dialogs';
export * from './components/common';

// @linka/ui - Páginas
export { DashboardPage } from './pages/Dashboard';
```

### 2.3. Dependências do Package

O package **`@linka/ui`** gerencia as seguintes dependências para que os apps consumidores não precisem instalá-las:

| Categoria | Dependência | Uso |
|-----------|-------------|-----|
| Gráficos | `recharts@^3.7.0` | Gráficos do dashboard |
| Tabelas | `@tanstack/react-table@^8.x` | Tabelas de dados |
| Forms | `react-hook-form`, `@hookform/resolvers`, `zod` | Validação |
| UI Base | `@ads/components-react`, `@ads/tokens` | Componentes e tokens |
| UI Primitives | `@radix-ui/*` | Dialog, Popover, etc. |
| Datas | `date-fns@^2.x` | Manipulação de datas |
| Ícones | `lucide-react` | Ícones |
| Utils | `clsx`, `class-variance-authority` | Helper de classes |

### 2.4. Padrões de Arquitetura

**1. Composição:**
```typescript
// Páginas e componentes recebem dados via props
interface DashboardPageProps {
  eventId: string;
}
```

**2. Customização via props:**
```typescript
<IndicatorCard 
  label="Total de Vendas"
  value={metrics.totalSales}
  format="currency"
/>
```

**3. Hooks permanecem nos apps consumidores:**
```typescript
// apps/organizer/src/ui/hooks/
// useEventDashboardMetrics, useDownloadReport, etc.
```

**4. Tipos compartilhados via `@linka/domain`:**
```typescript
import { DashboardMetrics, DashboardFilters } from '@linka/domain/dtos';
```

### 2.5. Migração dos Apps

**Organizer:**
1. Instalar `@linka/ui` como dependência
2. Substituir imports de `apps/organizer/src/ui/pages/dashboard/*` por `@linka/ui/pages/Dashboard`
3. **Manter hooks em `apps/organizer/src/ui/hooks/`** (useEventDashboardMetrics, etc.)
4. Manter services de API locais (`apps/organizer/src/api/`)

**Backoffice:**
1. Instalar `@linka/ui`
2. Remover `powerbi-client-react`
3. Migrar dashboard Power BI para `@linka/ui/pages/Dashboard`
4. **Criar hooks específicos em `apps/backoffice/src/ui/hooks/`**

### 2.6. Consequências

**Positivas:**
- Reutilização de componentes entre organizer e backoffice
- Manutenção centralizada dos gráficos em `components/charts/`
- Consistência visual pelo design system (`@ads/tokens`)
- Eliminação do Power BI Embedded no backoffice

**Pontos de Atenção:**
- **Tailwind**: Backoffice usa v4.1.15, Organizer usa v3.4.1 - configurar compatibilidade via CSS vars
- **Build**: Turborepo com `dependsOn: ["^build"]` garante build do package antes dos apps
- **Hooks**: Cada app mantém seus próprios hooks para data fetching (via `@tanstack/react-query`)
- **Types**: `@linka/domain` utilizado para tipagem entre packages

---

## 3. Itens Filhos

| ID | Título |
|----|--------|
| 27566 | - |
| 27567 | - |
| 27565 | - |
| 27564 | - |

---

## 4. Links Relacionados

| Tipo | Detalhes |
|------|----------|
| Branch | GBus/27375 |
| Commit | ea647f0d2a0d2e177318a32b0020dbbc7a3b5c60 |
| Pull Request | #24429 |

---

## 5. Informações Adicionais

- **Estado:** Active
- **Coluna:** Developing
- **Criado em:** 2026-03-17
- **Última alteração:** 2026-03-30