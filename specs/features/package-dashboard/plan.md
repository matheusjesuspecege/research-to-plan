# Plano Tático de Implantação - Package Dashboard

Este plano define a ordem de implementação dos casos de uso para criação do package compartilhado `package-dashboard` no monorepo, garantindo que as dependências funcionais sejam respeitadas.

## Ordem de Implementação dos Casos de Uso

| Prioridade | UC | Nome | Dependência |
|------------|-----|------|-------------|
| 1º | UC-03 | Migrar Dashboard para Package | Nenhuma (base) |
| 2º | UC-01 | Acessar Dashboard do Organizador | UC-03 |
| 2º | UC-02 | Acessar Dashboard do Backoffice | UC-03 |
| 3º | UC-04 | Desativar Dashboard Anterior | UC-01 e UC-02 |

### Detalhamento

#### 1. UC-03: Migrar Dashboard para Package
**Objetivo:** Criar o package compartilhado no monorepo com os componentes do dashboard.

**Artefatos necessários para implementação:**
- Diagrama de Caso de Uso (visão global)
- Diagrama de Classe (Modelo de Domínio)
- Diagrama de Sequência

**Passos:**
1. Estruturar o package no monorepo (Turborepo)
2. Extrair componentes existentes do Organizador
3. Configurar exports públicos
4. Validar build e types

**Frontend:**
- Componentes: DashboardContainer, StatsCard, Charts
- atomic: Organism (composição de cards e gráficos)
- atomic: Molecule (card individual)

**Referências:**
- [Turborepo - Workspaces](https://turbo.build/repo/docs/core-concepts/monorepos)
- [React - Componentes](https://react.dev/learn/your-first-component)
- [React Query - Polling](https://tanstack.com/query/latest/docs/framework/react/guides/queries#poll)

---

#### 2. UC-01: Acessar Dashboard do Organizador
**Objetivo:** Instanciar o package-dashboard no Organizador.

**Artefatos necessários para implementação:**
- Diagrama Navegacional
- Diagrama de Sequência

**Frontend:**
- Menu lateral: adicionar opção "Dashboard"
- Página: carregar package-dashboard com contexto do Organizador
- Componente: DashboardProvider (contexto React)

**Referências:**
- [React Context](https://react.dev/learn/passing-data-deeply-with-context)
- [React Router - Navegação](https://reactrouter.com/en/main)

---

#### 3. UC-02: Acessar Dashboard do Backoffice
**Objetivo:** Instanciar o package-dashboard no Backoffice.

**Artefatos necessários para implementação:**
- Diagrama Navegacional
- Diagrama de Sequência

**Frontend:**
- Menu lateral: adicionar opção "Dashboard"
- Página:ocarregar package-dashboard com contexto do Backoffice
- Reaproveitar DashboardProvider do UC-01

---

#### 4. UC-04: Desativar Dashboard Anterior
**Objetivo:** Remover componentes antigos após validação.

**Artefatos necessários para implementação:**
- Diagrama de Caso de Uso

**Passos:**
1. Validar que UC-01 e UC-02 estão funcionando
2. Remover código antigo do Organizador
3. Remover código antigo do Backoffice (se houver)
4. Atualizar rotas/menu

---

## O que pode ser executado em paralelo

| UCs | Motivo |
|-----|--------|
| UC-01 e UC-02 | Ambos dependem apenas de UC-03; são projetos independentes |

**Nota:** UC-01 e UC-02 podem ser desenvolvidos simultaneamente por desenvolvedores diferentes, pois não possuem dependência entre si.

---

## Critérios de Aceite - Resumo

### UC-01
- [ ] Menu lateral exibe opção "Dashboard"
- [ ] Click carrega o dashboard
- [ ] Exibe 4 cards: Inscrições, Vendas, Check-ins, Receita
- [ ] Dados correspondem ao evento selecionado
- [ ] Atualização automática via polling

### UC-02
- [ ] Menu lateral exibe opção "Dashboard"
- [ ] Click carrega o dashboard
- [ ] Utiliza o mesmo package-dashboard
- [ ] Exibe dados específicos do contexto Backoffice

### UC-03
- [ ] Package criado na estrutura do monorepo
- [ ] Componentes exportados corretamente
- [ ] Importação funcional no Organizador
- [ ] Importação funcional no Backoffice

### UC-04
- [ ] Componente anterior removido do Organizador
- [ ] Componente anterior removido do Backoffice
- [ ] Ponto de acesso no menu utiliza novo package
- [ ] Todas as informações disponíveis no novo componente
