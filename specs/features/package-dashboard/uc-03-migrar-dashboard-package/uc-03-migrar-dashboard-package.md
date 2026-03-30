# UC-03 - Migrar Dashboard para Package

- **Ator Principal:** Desenvolvedor - Membro do time de desenvolvimento responsável pela migração do dashboard para o monorepo.
- **Atores Secundários:** Monorepo (Turborepo) para hospedagem e distribuição do package.
- **Resumo:** Este caso de uso representa o processo técnico de migração do dashboard nativo em React (atualmente no projeto Organizador) para um package compartilhado (`package-dashboard`) dentro do monorepo usando Turborepo. O objetivo é permitir que o mesmo componente seja utilizado tanto pelo Organizador quanto pelo Backoffice, evitando duplicação de código.

- **Pré-condições:**
  - Monorepo deve estar configurado com Turborepo
  - Projeto Organizador deve ter o dashboard nativo funcionando
  - Estrutura de packages do monorepo deve estar definida

- **Pós-condições:**
  - `package-dashboard` criado e exportado no monorepo
  - Componentes exportados corretamente
  - Importação funcional nos dois projetos

---

## Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Identifica os componentes do dashboard no Organizador | 1. Fornece estrutura de arquivos atual |
| 2. Cria estrutura de package no monorepo | 2. Cria pasta `packages/package-dashboard` |
| 3. Move componentes do dashboard para o package | 3. Copia arquivos de componentes |
| 4. Configura exports do package | 4. Cria `package.json` e arquivos de export |
| 5. Atualiza importações no Organizador | 5. Valida que importações funcionam |
| 6. Importa package no Backoffice | 6. Adiciona dependência no `package.json` |
| 7. Valida funcionamento nos dois projetos | 7. Executa build e testes |
| 8. Documenta uso do package | 8. Gera README ou文档 |

---

## Restrições/Validações

1. **Estrutura do Monorepo:** Package deve seguir a estrutura de packages existente no monorepo
2. **exports:** Componentes devem ser exportados via `index.ts` ou `main`
3. **Tipagem:** Package deve manter tipagem TypeScript completa
4. **Dependências:** Dependências compartilhadas devem ser configuradas como `peerDependencies` se necessário
5. **Build:** Package deve compilar corretamente via Turborepo

---

## Cenário Alternativo

**Cenário A: Dependências compartilhadas**

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Identifica dependências duplicadas | 1. Lista dependências usadas |
| 2. Configura `peerDependencies` | 2. Define versões compatíveis |
| 3. Valida resolução de dependências | 3. Executa install e build |

---

## Cenário de Exceção

**Exceção 1: Conflito de versões**

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Executa build do package | 1. Detecta conflito de versões |
| | 2. Reporta erro de dependências |
| 3. Resolve conflito | 3. Verifica resolução |
| 4. Executa build novamente | |

---

## Requisitos Não-Funcionais

1. **Manutenibilidade:** Package deve ser fácil de manter e evoluir
2. **Reutilização:** Código deve ser reutilizável sem modificações
3. **Performance:** Package deve adicionar overhead mínimo aos projetos consumidores
4. **Testes:** Componentes devem ter cobertura de testes

---

## Critérios de Aceite

- [ ] Pasta `packages/package-dashboard` criada no monorepo
- [ ] Estrutura de arquivos do dashboard movida para o package
- [ ] Arquivo `package.json` configurado corretamente
- [ ] Exports configurados via `index.ts`
- [ ] Tipagem TypeScript mantida
- [ ] Importação funciona no projeto Organizador
- [ ] Importação funciona no projeto Backoffice
- [ ] Build do monorepo completo succeeds
- [ ] Testes passam
