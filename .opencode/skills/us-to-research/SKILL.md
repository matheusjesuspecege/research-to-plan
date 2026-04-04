---
name: us-to-research
description: "Converte requisitos abstratos escritos por Product Owners em um research.md estruturado para desenvolvimento. Use esta skill quando receber uma User Story para desenvolvimento."
license: MIT
---


# Resumo

Esta SKILL converte requisitos abstratos escritos por Product Owners em um research.md estruturado para desenvolvimento.

- O usuário fornece o nome da feature e a skill verifica a existencia da feature e seu arquivo **research.md** na pasta, para saber se é para 'atualizar' ou 'criar' um novo research.md.
- Caso a feature não exista, é criada a pasta da feature com um arquivo **prd.md** onde será adicionado o conteudo do requisito escrito pelo Product Owner para conversão.
- O usuário é avisado que o arquivo foi criado e a skill irá aguardar a confirmação de que o conteudo do requisito foi adicionado no **prd.md**.
- Após a confirmação do usuário, a skill irá ler o conteudo do arquivo prd.md e caso o requisito esteja vago, irá realizar perguntas especificas para remover **ambiguidades e ruídos** da especificação.
- No final, o arquivo research.md é gerado ou atualizado na pasta da feature seguindo a estrutura, padrôes e especificações definidas nesta skill, usando recursos visuais que facilite a compreensão humana.

---

## Regra Fundamental

- **SIGA O REQUISITO ORIGINAL EXATAMENTE COMO FORNECIDO. NÃO INVENTE, NÃO ADICIONE E NÃO SUPONHA NADA QUE NÃO ESTEJA EXPRESSAMENTE DEFINIDO NA US.**
- Se a US não menciona algo, não inclua no research. Se há ambiguidade, pergunte ao usuário antes de supor.
- Caso seja necessário criar diagramas, utilize **mermaid:** https://mermaid.js.org ou **plantuml:** https://plantuml.com/
- Verifique o status na seção **2.1** do **prd.md**, se o status for (proposing, prototyping, refinement), avise o usuário que a feature ainda não está pronta e **encerre a operação**

---

## Opcoes do terminal

- Mostre as seguintes opções obrigatórias no terminal e aguarde a resposta do usuário:
  - 1. Adicionei o conteudo do requisito e quero continuar (execute a etapa **Gravando os dados no arquivo**) com a intenção correta (**criar ou atualizar a feature**).
  - 2. Encerrar (**encerra a operação**).

---

## Passo a Passo

### 1. Receber o requisito

- Solicite ao usuário (se não fornecido) o nome da feature no formato kebab-case.

### 2. Verificar a existencia da feature

- Verique a existencia do **prd.md** e **research.md** da feature que está localizada em **/specs/features/[nome]/*.md**
- Se a feature NÃO existir, execute a etapa **2.2 Criar uma nova feature**
- Se a feature existir, execute a etapa **2.3 Atualizar feature existente**

---

## Criar uma nova feature

- Crie o arquivo **prd.md** na pasta da feature e informe ao usuário que o arquivo foi criado na pasta, siga o template que pode ser localizado em `./references/prd-example.md` preenchendo com exemplos simples em comentários que ajudem o humano preencher.
- Solicite ao usuário que adicione o conteúdo do requisito para que possa iniciar o processo de geração do **research.md**
- Execute a seção **Opcoes do terminal** com a intenção de **criar uma nova feature**
- Para cada caso de uso localizado na seção **Documentação dos Casos de Uso**, salve usando as instruções localizadas em `./references/actor-and-uc.md` na seção **2.2. Localização** usando de recursos visuais que facilite a compreensão humana.
- Grave o conteúdo atualizado no arquivo **research.md** seguindo a estrutuda definida na seção **Estrutura do arquivo** removendo os casos de uso que foram para os arquivos separados e adicionando no lugar a referencia até o arquivo do caso de uso gerado, usando se necessário recursos visuais que facilite a compreensão humana.

---

## Atualizar feature existente

### Passo a passo

- Primeiro, leia o conteúdo atual da feature para obter contexto.
- Execute a seção **Opcoes do terminal** com a intenção de **atualizar uma feature existente** solicitando ao usuário que atualize o arquivo **prd.md** com as novas mudanças que serão atualizadas
- Analise o arquivo **prd.md** que foi atualizado com as atualizações forneceridas pelo usuário.
- Analise o **research.md** e **plan.md** (caso existir) atual da feature e compare tudo que deverá ser atualizado para manter os arquivos sincronizados e atualizados corretamente, com a maxima atenção para não remover o conteúdo atual que já está aprovado, ou seja, inserindo e adaptando somente o que for realmente necessário.
- Grave o conteúdo atualizado nos arquivos **research.md**, **plan.md** e em todos os **Casos de Uso** que precisam ser atualizados usando de recursos visuais que facilite a compreensão humana.

---

## Estrutura do arquivo

- **Autor:** Usuário que gerou o arquivo pela primeira vez (pegar do git)
- **Data e hora da geração:** Data e hora da geração
- **Status:** (proposing, prototyping, refinement, to-develop, developing, code-review, homologating, pending, ready-to-production, published)
- **Ultima modificação:** Data e hora da ultima modificação - (Usuário git que modificou).

### 1. Contexto do Produto

Breve resumo de no máximo (7 linhas).

---

### 2. Problema do Negócio

Descreve o problema que o PO está tentando resolver (7 linhas).

---

### 3. Objetivo da Feature

Qual resultado esperado para o produto (7 linhas).

---

### 4. Cenário de Uso

Descrição narrativa de como o usuário interage com a funcionalidade (7 linhas).

---

### 5. Atores

**Consulte:** `./references/actor-and-uc.md` na seção **1. Atores** para mais detalhes sobre **Atores**.

---

### 6. Casos de Uso

**Consulte:** `./references/actor-and-uc.md` na seção **2. Casos de Uso** para mais detalhes.

**Obs.** deve-se procurar evitar desenvolver casos de uso complexos sempre que possível, priorizando o funcionamento, eficacia e compreensão humana acima de enfeites visuais que não agregam.

---

### 7. Documentação dos Casos de Uso

**Consulte:** `./references/actor-and-uc.md` na seção **2.5. Documentação dos Casos de Uso** para mais detalhes.

---

### 8. Associações

**Consulte:** `./references/actor-and-uc.md` na seção **3. Associações** para mais detalhes.

**Obs.** NÃO é obrigatória a aplicação de associações de inclusão, extensão ou especialização, visto que só devem ser usadas quando for considerado necessário, de acordo com as necessidades do software que está sendo construido.

**8.1. Generalização/Especialização:**

- **Consulte:** `./references/actor-and-uc.md` na seção **3.1. Generalização/Especialização** para mais detalhes.

**8.2. Inclusão:**

- **Consulte:** `./references/actor-and-uc.md` na seção **3.2. Inclusão** para mais detalhes.

**8.3. Extensão:**

- **Consulte:** `./references/actor-and-uc.md` na seção **3.3. Extensão** para mais detalhes.

**8.4. Restrições em Associações de Extensão:**

- **Consulte:** `./references/actor-and-uc.md` na seção **3.4. Restrições em Associações de Extensão** para mais detalhes.

**8.4. Estereótipos:**

- **Consulte:** `./references/actor-and-uc.md` na seção **4. Estereótipos** para mais detalhes.

**8.5. Pontos de Extensão:**

- **Consulte:** `./references/actor-and-uc.md` na seção **3.5. Pontos de Extensão** para mais detalhes.

**8.6. Multiplicidade:**

- **Consulte:** `./references/actor-and-uc.md` na seção **3.6. Multiplicidade** para mais detalhes.

---

### 9. Fronteira de Sistema

**Consulte:** `./references/actor-and-uc.md` na seção **5. Fronteira de Sistema** para mais detalhes.

---

### 10. Jobs To Be Done
- Job principal:
- Jobs secundários:

---

### 11. Métricas de Sucesso
- Métrica de produto
- Métrica técnica

---

### 12. Questôes em Aberto

- Questôes que foi deixada em aberto explicitamente.
- Tópicos que foi marcado com "A definir"

---

## Output

```markdown
# ✅ Research Concluído

## Resumo da Operação

| Propriedade | Valor |
|-------------|-------|
| Feature | [nome-da-feature] |
| Tipo de operação | Criação / Atualização |
| Data | [data/hora] |

---

## 📋 Decisões Tomadas

Durante o processo, as seguintes ambiguidades foram identificadas e resolvidas:

| # | Pergunta | Resposta |
|---|----------|----------|
| 1 | [Pergunta] | [Resposta do usuário] |
| 2 | [Pergunta] | [Resposta do usuário] |

---

## 📁 Arquivos Gerados

### Research Principal
- `specs/features/[feature]/research.md`

### Casos de Uso (Total: X)

| UC | Nome | Tipo | Status |
|----|------|------|--------|
| UC-01 | [Nome] | Primário | ✅ Gerado |
| UC-02 | [Nome] | Secundário | ✅ Gerado |
| ... | ... | ... | ... |

---

## 📊 Conteúdo Incluído no Research

### Seções do Research
- ✅ Contexto do Produto
- ✅ Problema do Negócio  
- ✅ Objetivo da Feature
- ✅ Cenário de Uso
- ✅ Atores (X identificados)
- ✅ Casos de Uso (X identificados)
- ✅ Associações
- ✅ Fronteira de Sistema
- ✅ Jobs To Be Done
- ✅ Métricas de Sucesso
- ✅ Critérios de Aceite

### Tópicos do PRD Migrados
- Tópico X — [Nome] ✅
- Tópico Y — [Nome] ✅
- Tópico Z — [Nome] ⚠️ Placeholder (A definir com time dev)

---

## ⚠️ Items Pendentes / Placeholders

| Item | Motivo | Ação Necessária |
|------|--------|-----------------|
| [Item] | [Motivo] | [Ação] |

---

## 📈 Estatísticas

- **Casos de uso gerados:** X
- **Casos de uso atualizados:** X
- **Atores identificados:** X
- **Associações documentadas:** X
- **Ambiguidades resolvidas:** X / X

---

## 🔗 Próximos Passos

1. Revisar o `research.md` gerado
2. Validar os casos de uso com o PO
3. Executar a skill **research-to-plan** para iniciar o planejamento técnico
```