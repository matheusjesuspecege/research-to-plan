# research-to-plan

Repositório que mantém a **skill research-to-plan** para o opencode. Essa skill transforma a fase de pesquisa (research.md) em artefatos de planejamento técnico.

## O que esse repositório faz?

Quando você já tem um `research.md` aprovado com os requisitos de uma feature, essa skill te ajuda a criar os diagramas e planos que vão guiar a implementação:

- **Diagrama de Casos de Uso** - Quem faz o quê no sistema
- **Diagrama de Navegação** - Como o usuário navega entre telas
- **Jornada do Usuário** - Passos que o usuário segue
- **Diagrama de Classes** (Modelo Conceitual e de Domínio) - Estrutura de dados
- **Diagrama de Sequência** - Como os componentes conversam entre si
- **Plano de Ação** - Lista ordenada do que precisa ser feito

## Estrutura do Repositório

```
research-to-plan/
├── .opencode/skills/research-to-plan/  # A skill em si
│   ├── SKILL.md                        # Instruções da skill
│   └── references/                     # Referências técnicas
│       ├── uc-diagram.md               # Como fazer diagrama de caso de uso
│       └── class-diagram.md            # Como fazer diagrama de classes
├── specs/features/                     # Exemplos de features
│   └── checkout/                        # Feature de exemplo
│       ├── research.md                 # Pesquisa com requisitos
│       ├── prd.md                      # Product Requirements Document
│       └── uc-01-*/                    # Casos de uso individuais
├── README.md                           # Você tá aqui
└── AGENTS.md                           # Info pra IA
```

## Como usar

### Pré-requisito
Você precisa ter um `research.md` aprovado na pasta da sua feature:
```
specs/features/[nome-da-feature]/research.md
```

### Passo a passo

1. **Ative a skill** no opencode:
   ```
   /skill research-to-plan
   ```

2. **Digite o nome da feature** (em kebab-case, ex: `checkout`)

3. **Escolha o tipo de geração:**
   - `1. Global` → Um diagrama mostrando a visão geral da feature inteira
   - `2. Individual` → Diagramas específicos por caso de uso

4. **Escolha qual artefato gerar:**
   ```
   1. Jornada do Usuário
   2. Diagrama de Caso de Uso
   3. Diagrama Navegacional
   4. Diagrama de Classe (Modelo Conceitual)
   5. Diagrama de Sequência
   6. Diagrama de Classe (Modelo de Domínio)
   7. Diagrama de Estrutura Composta
   8. Diagrama de Componentes
   9. Plano de Ação
   10. Encerrar Operação
   ```

5. Os diagramas são salvos como arquivos `.mermaid` que podem ser visualizados em qualquer visualizador de Mermaid (ex: [mermaid.live](https://mermaid.live)).

## Onde os artefatos são salvos

| Tipo | Localização |
|------|-------------|
| **Global** | `specs/features/[feature]/[nome-do-diagrama].mermaid` |
| **Individual** | `specs/features/[feature]/[uc-01]/[uc-01-diagrama].mermaid` |

## Fluxo de Trabalho

```
┌─────────────────┐
│   PRD ( opcional )   │
└────────┬────────┘
         ▼
┌─────────────────┐
│  Research.md    │  ◄── Definiu o que precisa ser feito
└────────┬────────┘
         ▼
┌─────────────────┐
│ Research-to-Plan │  ◄── Você tá aqui! Gera diagramas e planos
└────────┬────────┘
         ▼
┌─────────────────┐
│  Implementação   │
└─────────────────┘
```

## Regras Importantes

- **Não invente nada!** Se o research.md não menciona, não inclua no diagrama
- Se algo estiver ambíguo, pergunte antes de supor
- Nomes de classes, atributos e métodos → em **inglês**
- Todo o resto → em **português (pt-br)**
- Use a sintaxe Mermaid correta (confira a [documentação](https://mermaid.js.org/intro/))

## Contribuir

Quer melhorar essa skill? Veja o [AGENTS.md](./AGENTS.md) para detalhes técnicos de como a skill funciona internamente.

### Como adicionar novos diagramas

1. Edite `SKILL.md` e adicione o novo diagrama na seção "Operações do Terminal"
2. Crie uma referência em `references/` explicando como gerar esse tipo de diagrama
3. Adicione o link da documentação do Mermaid

### Como melhorar as referências

1. Edite os arquivos em `references/`
2. Use exemplos práticos quando possível
3. Mantenha a linguagem simples para devs juniors
