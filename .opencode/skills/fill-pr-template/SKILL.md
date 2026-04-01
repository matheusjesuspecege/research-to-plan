---
name: fill-pr-template
description: Preenche o template de pull request com tudo que foi realizado na feature para ser adicionado na descrição da PR do azure devops. Use quando finalizar uma feature e estiver criando uma PR no azure devops.
---

# Introdução

Esta SKILL tem o objetivo de preencher o template de pull request, para que o desenvolvedor possa adicionar na descrição da PR no azure devops. 

---

## Regras Fundamentais

- **SIGA O REQUISITO ORIGINAL EXATAMENTE COMO FORNECIDO. SEM INVENTAR, ADICIONAR OU SUPOR ALGO QUE NÃO ESTEJA EXPRESSAMENTE DEFINIDO NA US.**
- Se há ambiguidade, pergunte ao usuário antes de prosseguir.
- Gere um diagrama navegacional em **mermaid** para que o dev possa incluir facilmente na descrição. 
- Sugira um titulo eficaz e enxuto para descrever o que foi feito.
- O tom de voz da descrição deve ser em terceira pessoa estilo **realizado**.
- Não grave arquivos, apenas retorne no proprio terminal para que o usuário possa copiar e colar no azure devops.

---

## Passo a Passo

1. Solicite para o usuário o nome da feature, caso não exista, informe ao usuário e solicite a correção.
2. Leia a feature informada pelo usuário, entenda o contexto e preencha o arquivo **./assets/pull_request_template.md**, seguindo as **Regras Fundamentais**.
3. Retorne para o usuário, a descrição feita no proprio terminal para que o usuário possa copiar com facilidade.

--- 

## Saída

Retorne um feedback amigavel para o usuário para que ele saiba os proximos passos, principalmente como poderá visualizar o mermaid online, e sugira que ele tire uma print com f12 e cole no azure devops para facilitar a visualização.


