# UC-01 - Criar Package @linka/ui

- **Caso de Uso Geral:** -
- **Ator Principal:** Desenvolvedor
- **Atores Secundários:** -
- **Resumo:** Este caso de uso representa o processo de criação do package compartilhado `@linka/ui` dentro do monorepo Turborepo. O package centralizará componentes UI, gráficos e páginas reutilizáveis entre os apps da plataforma (Organizer e Backoffice). O desenvolvedor deve configurar a estrutura inicial do package, definir dependências e exports públicos.
- **Pré-condições:** Monorepo Turborepo configurado com pnpm. Acesso ao repositório linka-eventos-platform.
- **Pós-condições:** Package `@linka/ui` criado e configurado com estrutura base, dependências instaladas e exports públicos definidos.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Criar diretório `packages/ui/` no monorepo | |
| 2. Criar `package.json` com nome `@linka/ui` e versionamento | |
| 3. Configurar `tsconfig.json` com paths para imports internos | |
| 4. Criar estrutura de diretórios (components/, pages/, index.ts) | |
| 5. Definir dependências conforme seção 2.3 do PRD | |
| 6. Configurar exports públicos em `index.ts` | |
| 7. Executar build inicial do package | Valida que o package compila corretamente |
| 8. Executar Turborepo para verificar integração | |

### Restrições/Validações

- O package deve ser construído antes dos apps consumidores (dependsOn: ["^build"])
- O package deve exportar apenas APIs públicas estáveis
- Tipos compartilhados devem ser importados de `@linka/domain`

### Cenário Alternativo

| # | Condição | Ação |
|---|----------|------|
| 1 | Conflito de dependências entre apps | Revisar versões e ajustar no root package.json |

### Cenário de Exceção

| # | Condição | Ação |
|---|----------|------|
| 1 | Build falhar | Corrigir erros de TypeScript antes de prosseguir |
| 2 | Conflito de versões de React | Garantir que todas as apps usem React 19 |

### Requisitos Não-Funcionais

- **Manutenibilidade:** O package deve seguir padrões consistentes de código
- **Performance:** Build do package deve ser otimizado pelo Turborepo
- **Compatibilidade:** Deve funcionar com React 19 e as versões especificadas no PRD

---

## Critérios de Aceite

- [ ] Diretório `packages/ui/` criado no monorepo
- [ ] `package.json` configurado com nome `@linka/ui`
- [ ] Estrutura de diretórios criada (components/, pages/, index.ts)
- [ ] Dependências instaladas conforme PRD seção 2.3
- [ ] Exports públicos definidos em `index.ts`
- [ ] Build executa com sucesso
- [ ] Package utilizável pelos apps consumidores
