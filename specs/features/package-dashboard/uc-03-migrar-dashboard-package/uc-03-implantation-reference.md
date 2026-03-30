# Documento de Referência para Implementação - UC-03

## Visão Geral

Este documento fornece o guia tático para migração do dashboard nativo em React para um package compartilhado (`package-dashboard`) dentro do monorepo usando Turborepo.

---

## 1. Estrutura do Monorepo

### 1.1 Verificar Estrutura Atual

Consulte a documentação do Turborepo para entender a estrutura de packages:
- https://turbo.build/repo/docs/core-concepts/monorepos/organizing
- Seção: "Package structure"

### 1.2 Criar Estrutura do Package

Crie a seguinte estrutura de diretórios:

```
packages/
└── package-dashboard/
    ├── src/
    │   ├── components/
    │   │   ├── Dashboard.tsx
    │   │   ├── DashboardCard.tsx
    │   │   ├── StatsChart.tsx
    │   │   └── index.ts
    │   ├── hooks/
    │   │   ├── useDashboardData.ts
    │   │   └── index.ts
    │   ├── types/
    │   │   ├── DashboardData.ts
    │   │   └── index.ts
    │   └── index.ts
    ├── package.json
    ├── tsconfig.json
    └── README.md
```

### 1.3 Configuração do package.json

```json
{
  "name": "@linka-events/package-dashboard",
  "version": "1.0.0",
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "import": "./dist/index.js",
      "types": "./dist/index.d.ts"
    }
  },
  "peerDependencies": {
    "react": "^18.0.0",
    "react-dom": "^18.0.0",
    "@tanstack/react-query": "^5.0.0"
  },
  "dependencies": {
    "recharts": "^2.10.0"
  },
  "scripts": {
    "build": "tsup src/index.ts --dts",
    "dev": "tsup src/index.ts --watch"
  }
}
```

> **Nota:** O código acima é apenas uma ideia de implementação. Implemente seguindo os padrões de código da sua equipe.

---

## 2. Configuração de Exports

### 2.1 Arquivo de Export (src/index.ts)

```typescript
export { Dashboard } from './components/Dashboard';
export { DashboardCard } from './components/DashboardCard';
export { StatsChart } from './components/StatsChart';
export { useDashboardData } from './hooks/useDashboardData';
export type { DashboardData, DashboardProps } from './types';
```

### 2.2 Configuração TypeScript (tsconfig.json)

```json
{
  "extends": "../../tsconfig.base.json",
  "compilerOptions": {
    "outDir": "./dist",
    "rootDir": "./src",
    "declaration": true,
    "declarationMap": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

> **Nota:** O código acima é apenas uma ideia de implementação. Implemente seguindo os padrões de código da sua equipe.

---

## 3. Migração de Componentes

### 3.1 Identificar Componentes Existentes

Localize os componentes do dashboard no projeto Organizador:
- Procure por componentes que renderizam cards de estatísticas
- Identifique hooks que fazem fetching de dados
- Mapeie as dependências (recharts, react-query, etc)

### 3.2 Mover Componentes

1. Copie os componentes para `packages/package-dashboard/src/components/`
2. Ajuste imports para usar caminhos relativos internos
3. Mantenha a tipagem TypeScript

### 3.3 Configurar Dependências

Consulte a documentação de dependências do Turborepo:
- https://turbo.build/repo/docs/core-concepts/monorepos/dependencies
- Seção: "Dependency management"

Execute o comando para instalar dependências:
```bash
pnpm install
```

---

## 4. Configuração no Organizador

### 4.1 Adicionar dependência local

No arquivo `apps/organizador/package.json`:

```json
{
  "dependencies": {
    "@linka-events/package-dashboard": "*"
  }
}
```

### 4.2 Atualizar Importações

No componente que usa o dashboard:

```typescript
// Antes
import { Dashboard } from './components/Dashboard';

// Depois
import { Dashboard } from '@linka-events/package-dashboard';
```

> **Nota:** O código acima é apenas uma ideia de implementação. Implemente seguindo os padrões de código da sua equipe.

---

## 5. Configuração no Backoffice

### 5.1 Adicionar dependência

No arquivo `apps/backoffice/package.json`:

```json
{
  "dependencies": {
    "@linka-events/package-dashboard": "*"
  }
}
```

### 5.2 Configurar Context

O Backoffice precisa passar o contexto específico:

```typescript
import { Dashboard } from '@linka-events/package-dashboard';

function BackofficeDashboard() {
  return (
    <Dashboard 
      dataSource="backoffice"
      apiEndpoint="/api/backoffice/dashboard"
    />
  );
}
```

> **Nota:** O código acima é apenas uma ideia de implementação. Implemente seguindo os padrões de código da sua equipe.

---

## 6. Build e Validação

### 6.1 Executar Build

```bash
# Build de todo o monorepo
pnpm build

# Build apenas do package
cd packages/package-dashboard
pnpm build
```

### 6.2 Executar Testes

```bash
# Testes do package
cd packages/package-dashboard
pnpm test

# Testes de integração no organizador
cd apps/organizador
pnpm test
```

### 6.3 Verificar Exports

Execute o comando para verificar se os exports estão corretos:

```bash
node -e "console.log(require('@linka-events/package-dashboard'))"
```

---

## 7. Checklist de Validação

- [ ] Pasta `packages/package-dashboard` criada
- [ ] Estrutura de arquivos copiada
- [ ] `package.json` configurado
- [ ] Exports funcionais
- [ ] Tipagem TypeScript mantida
- [ ] Build bem-sucedido
- [ ] Importação no Organizador funciona
- [ ] Importação no Backoffice funciona
- [ ] Testes passando

---

## Referências

- Turborepo: https://turbo.build/repo/docs
- Create T3 Turbo (referência de estrutura): https://create.t3.gg/
- tsup (build tool): https://tsup.egoist.dev/
- Atomic Design: https://atomicdesign.bradfrost.com/
