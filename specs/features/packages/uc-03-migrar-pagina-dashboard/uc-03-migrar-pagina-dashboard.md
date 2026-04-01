# UC-03 - Migrar Página de Dashboard para o Package

- **Caso de Uso Geral:** -
- **Ator Principal:** Desenvolvedor
- **Atores Secundários:** -
- **Resumo:** Este caso de uso representa o processo de migração da página completa de Dashboard do Organizer para o package `@linka/ui`. A página será composta pelos componentes gráficos migrados (UC-02) e disponibilizada como `DashboardPage` para reutilização.
- **Pré-condições:** Componentes gráficos migrados (UC-02). Estrutura de `pages/Dashboard/` criada no package.
- **Pós-condições:** Página `DashboardPage` disponível no package e funcional.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Criar estrutura `pages/Dashboard/components/` no package | |
| 2. Identificar componentes específicos do Dashboard (IndicatorCard, ExportButton, etc.) | |
| 3. Migrar componentes específicos para `pages/Dashboard/components/` | |
| 4. Criar composição da página em `pages/Dashboard/index.tsx` | |
| 5. Criar interface de props para a página | |
| 6. Exportar `DashboardPage` em `pages/index.ts` | |
| 7. Executar build do package | Valida compilação |

### Estrutura da Página

```typescript
// pages/Dashboard/index.tsx
interface DashboardPageProps {
  eventId: string;
}

export const DashboardPage: React.FC<DashboardPageProps> = ({ eventId }) => {
  // Composição dos componentes gráficos
};
```

### Restrições/Validações

- A página deve receber `eventId` como prop para buscar dados
- A página não deve conter hooks de data fetching (permanecem nos apps)
- Componentes específicos do dashboard (não reutilizáveis) ficam em `pages/Dashboard/components/`

### Cenário Alternativo

| # | Condição | Ação |
|---|----------|------|
| 1 | Componente é reutilizável em outros contextos | Mover para `components/` |

### Cenário de Exceção

| # | Condição | Ação |
|---|----------|------|
| 1 | Página depende de contexto específico do React | Passar via props ou criar provider |

### Requisitos Não-Funcionais

- **Performance:** Composição deve ser otimizada
- **Tipagem:** Props devem ser tipadas com tipos do `@linka/domain`

---

## Critérios de Aceite

- [ ] `DashboardPage` criado em `packages/ui/src/pages/Dashboard/`
- [ ] Interface de props definida
- [ ] Componentes específicos migrados para `pages/Dashboard/components/`
- [ ] Página exportada em `pages/index.ts`
- [ ] Build executa com sucesso
- [ ] Página recebe eventId via props
