# AGENTS.md

## Estrutura da Skill

```
.opencode/skills/research-to-plan/
├── SKILL.md           # Workflow principal, regras e menu
└── references/        # Referências técnicas
    ├── uc-diagram.md   # Diagrama de caso de uso
    └── class-diagram.md # Diagrama de classes
```

## Fluxo

1. Solicitar nome da feature (kebab-case)
2. Validar `specs/features/[feature]/research.md`
3. Escolher modo: Global ou Individual
4. Selecionar artefato (menu de 10 opções)
5. Gerar e salvar `.mermaid`

## Regras

- **SIGA O REQUISITO ORIGINAL EXACTAMENTE. NÃO INVENTE, NÃO SUPONHA.**
- Se research.md não menciona, NÃO inclua
- Ambiguidade = perguntar ao usuário

## Geração

| Modo | Local | Escopo |
|------|-------|--------|
| Global | `specs/features/[feature]/[tipo].mermaid` | Feature inteira |
| Individual | `specs/features/[feature]/[uc-01]/[tipo].mermaid` | Um UC |

## Menu de Artefatos

1. Jornada do Usuário (`journey`)
2. Diagrama de Caso de Uso (`flowchart`)
3. Diagrama Navegacional (`flowchart`)
4. Diagrama de Classe Conceitual (`classDiagram`)
5. Diagrama de Sequência (`sequenceDiagram`)
6. Diagrama de Classe Domínio (`classDiagram`)
7. Diagrama de Estrutura Composta (`flowchart`)
8. Diagrama de Componentes
9. Plano de Ação
10. Encerrar

## Convenções

- Features: `kebab-case` | UCs: `uc-XX-description`
- Código/entidades: **inglês** | Descrições: **pt-br**
- Docs: https://mermaid.js.org/intro/
