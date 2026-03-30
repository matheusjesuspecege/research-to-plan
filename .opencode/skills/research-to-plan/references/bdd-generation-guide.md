# Instrução: Como Criar Skill para Gerar Critérios de Aceite e BDD

## Visão Geral

Esta skill transforma um `research.md` de caso de uso em:
1. Critérios de aceite ordenados por dependência
2. Cenários BDD separados por Frontend e Backend

---

## Pré-requisitos

- Pasta `.opencode/skills/[nome-da-skill]/` criada
- Estrutura:
  ```
  .opencode/skills/[nome-da-skill]/
  ├── SKILL.md                    # Workflow principal
  └── references/                 # (opcional) Templates
  ```

---

## Passo 1: Carregar research.md

```markdown
1. Leia o arquivo: specs/features/[feature]/[uc-id]/[uc-id].md
2. Extraia:
   - Ator Principal / Atores Secundários
   - Cenário Principal (tabela de ações)
   - Restrições/Validações
   - Cenários Alternativos
   - Cenários de Exceção
   - Requisitos Não-Funcionais
```

---

## Passo 2: Gerar Critérios de Aceite

### 2.1 - Regra de Rastreabilidade Reversa

Cada linha do UC vira um critério verificável:

| UC diz... | Critério se torna... |
|-----------|---------------------|
| "Sistema exibe..." | Deve ser verificado que o sistema exibe... |
| "Sistema valida..." | Deve ser verificado que o sistema valida... |
| "Sistema processa..." | Deve ser verificado que o sistema processa... |

### 2.2 - Ordenar por Dependência

Agrupe em FASES sequenciais:

```markdown
FASE 1: Estrutura e UI Base (sem dependências)
FASE 2: Bloco 1 - Dados (depende de FASE 1)
FASE 3: Bloco 2 - Responsável (depende de FASE 2)
FASE 4: Bloco 3 - Pagamento (depende de FASE 3)
FASE 5: Processamento (depende de todas)
FASE 6: Cenários Alternativos/Exceção (depende de contextos)
FASE 7: Requisitos Não-Funcionais (transversais)
```

### 2.3 - Separar Frontend e Backend

| Critério | Frontend | Backend |
|----------|:--------:|:-------:|
| Exibe algo na tela | ✅ | |
| Valida dados | ✅ | ✅ |
| Salva no banco | | ✅ |
| Envia e-mail | | ✅ |
| Processa pagamento | | ✅ |
| Indicação visual | ✅ | |

---

## Passo 3: Gerar Cenários BDD

### 3.1 - Sintaxe Gherkin

```gherkin
#language: pt

Funcionalidade: [Nome da Feature]

  Cenário: [Descrição clara]
    Dado [contexto inicial]
    Quando [ação do ator]
    Então [resultado esperado]
```

### 3.2 - Tags por Fase

Use tags para rastreabilidade:

```gherkin
@F1.1 @F1.2 @F1.3
Cenário: Exibir estrutura base

@F2.1 @F2.2
Cenário: Campos do Bloco 1
```

### 3.3 - Frontend vs Backend

**Frontend** - foca em UI e interação:
```gherkin
Cenário: Botão avançar habilitado após validação
  Dado todos os campos estão preenchidos
  Quando o usuário tenta avançar
  Então o botão fica habilitado
```

**Backend** - foca em lógica e API:
```gherkin
Cenário: Criar conta para novo e-mail
  Dado e-mail "novo@email.com" não existe
  Quando pagamento é confirmado
  Então nova conta é criada
```

### 3.4 - Mapear Cenários para Critérios

| Critério | Cenário(s) |
|----------|------------|
| F5.2 - Conta criada se e-mail não existir | Cenário: Criar conta para novo e-mail |
| F5.3 - Conta existente reutilizada | Cenário: Reutilizar conta existente |
| F6.4 - Timeout libera ingressos | Cenário: Timeout de checkout expirado |

---

## Passo 4: Salvar Arquivos

Estrutura de saída:

```
specs/features/[feature]/[uc-id]/
├── [uc-id].md                          # Research original
├── [uc-id].frontend.feature            # Cenários frontend
└── [uc-id].backend.feature            # Cenários backend
```

### Nomenclatura
- Features: `kebab-case`
- Arquivos: `[uc-id].frontend.feature` / `[uc-id].backend.feature`
- Tags: `@frontend`, `@backend`, `@[uc-id]`, `@F[numero]`

---

## Passo 5: Validar Cobertura

Checklist final:

- [ ] Todos os critérios possuem cenário(s) correspondente(s)
- [ ] Cenários cobrem fluxo principal, alternativos e exceção
- [ ] Frontend e Backend separados corretamente
- [ ] Tags @F correspondem aos IDs dos critérios
- [ ] Gherkin válido (Given/When/Then em português)

---

## Exemplo Completo

### Input (research.md snippet):
```markdown
| 12. Clica em "Avançar para pagamento" | 12.1. Valida todos os campos |
|                                         | 12.2. Processa pagamento      |
```

### Output (critério):
```markdown
| F4.6 | Botão avançar habilitado após validação completa | ✅ | ✅ |
```

### Output (BDD Frontend):
```gherkin
@F4.6
Cenário: Botão avançar habilitado após validação completa
  Dado todos os campos estão preenchidos e válidos
  Quando o usuário clica em "Avançar para pagamento"
  Então o botão está habilitado
  E a requisição de pagamento é enviada
```

### Output (BDD Backend):
```gherkin
@F5.1
Cenário: Processar pagamento via gateway
  Dado payload válido com dados do cartão
  Quando API recebe requisição de pagamento
  Então processa via gateway de pagamento
  E retorna status da transação
```

---

## Regras de Ouro

1. **SIGA O REQUISITO ORIGINAL EXACTAMENTE** - não invente, não suponha
2. **Se research.md não menciona** → não inclua no critério ou cenário
3. **Ambiguidade** → pergunte ao usuário antes de interpretar
4. **Limite de contexto** → máximo 28 critérios por UC para caber em janela de agente
5. **Validação > 2s** → marque como problema de performance

---

## Referências

- [Gherkin Reference](https://cucumber.io/docs/gherkin/reference/)
- [Mermaid.js Diagrams](https://mermaid.js.org/intro/)
- [Conventional Commits](https://www.conventionalcommits.org/)
