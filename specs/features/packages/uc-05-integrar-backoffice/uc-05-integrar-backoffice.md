# UC-05 - Integrar Package no Backoffice

- **Caso de Uso Geral:** -
- **Ator Principal:** Desenvolvedor
- **Atores Secundários:** -
- **Resumo:** Este caso de uso representa o processo de integração do package `@linka/ui` no app Backoffice, substituindo o dashboard Power BI Embedded pela página `DashboardPage` do package. Também inclui a criação de hooks específicos para o Backoffice.
- **Pré-condições:** Package `@linka/ui` com `DashboardPage` disponível (UC-03). App Backoffice com Power BI.
- **Pós-condições:** Backoffice usando `DashboardPage` do package. Power BI removido.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Instalar `@linka/ui` como dependência no Backoffice | |
| 2. Remover `powerbi-client-react` das dependências | |
| 3. Substituir componente Power BI por `DashboardPage` | |
| 4. Criar hooks específicos em `apps/backoffice/src/ui/hooks/` | |
| 5. Configurar acesso aos dados necessários | |
| 6. Executar build do Backoffice | Valida integração |
| 7. Testar aplicação localmente | |

### Diferenças entre Organizer e Backoffice

| Aspecto | Organizer | Backoffice |
|---------|-----------|------------|
| Dados | Por evento específico | Agregados |
| Hooks | `useEventDashboardMetrics` | Novos hooks específicos |
| Acesso | Menu lateral do organizador | Menu administrativo |

### Restrições/Validações

- Tailwind v4.1.15 deve ser compatível com o package (v3.4.1)
- Pode ser necessário ajustar via CSS vars

### Cenário Alternativo

| # | Condição | Ação |
|---|----------|------|
| 1 | Incompatibilidade de Tailwind | Usar CSS vars para compatibilidade |

### Cenário de Exceção

| # | Condição | Ação |
|---|----------|------|
| 1 | Dados não disponíveis no Backoffice | Criar endpoints de API ou usar dados mock |
| 2 | Build falha por Tailwind | Configurar compatibilidade via design tokens |

### Requisitos Não-Funcionais

- **Consistência Visual:** UI deve ser idêntica ao Organizer
- **Eliminação de Dependência:** Power BI Embedded removido

---

## Critérios de Aceite

- [ ] `@linka/ui` instalado no Backoffice
- [ ] `powerbi-client-react` removido
- [ ] `DashboardPage` integrado
- [ ] Hooks específicos criados
- [ ] Build do Backoffice executa com sucesso
- [ ] Dashboard acessível no Backoffice
