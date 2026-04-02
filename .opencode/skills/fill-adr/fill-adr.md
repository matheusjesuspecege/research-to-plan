---
name: fill-adr
description: Preenche a seção 2. ADR do prd.md analisando o contexto real do projeto. Use este skill quando estiver preenchendo o prd.md e precisar sincronizar a descrição técnica da ADR escrita com a tecnologia real do projeto.
licence: MIT
---

# Introdução

Esta skill analisa o **prd.md** da feature $ARGUMENTS e o código fonte do monorepo para preencher a seção **2. Decisôes Técnicas (ADR)** do arquivo **prd.md**.

---

## Regras Fundamentais
- **SIGA O REQUISITO ORIGINAL EXATAMENTE COMO FORNECIDO. NÃO INVENTE, NÃO ADICIONE E NÃO SUPONHA NADA QUE NÃO ESTEJA EXPRESSAMENTE DEFINIDO NA US.**
- Se a US não menciona algo, não inclua. Se há ambiguidade, pergunte ao usuário antes de supor.
- Somente deve ser alterado a sessão **2. Decisôes Técnicas (ADR)**, existe uma separação clara entre **requisito do product owner** com as decisôes técnicas da sessão **2. Decisôes Técnicas (ADR)** que deve ser seguida. 
- Todo o conteudo do product owner definido inicialmente deve ser mantido sem alteração, e o novo conteudo deve cumprir os requisitos originais.
- Siga estritamente as versôes definidas no projeto, principalmente no **package.json** e outros arquivos que definem versôes especificas das ferramentas.
- Pergunte ao usuário, caso precise de alguma informação, antes de supor.

---

## Passo a Passo

1. Localize o prd.md em **specs/features/$ARGUMENTS/prd.md** e compreenda o contexto.
2. leia package.json dos apps, packages existentes, estrutura de código (use o agente **explore**) para investigar: **apps/*/src**, **packages/**, estrutura de componentes, hooks, pages e tudo que for necessário no contexto do projeto para ajudar na compreensão.
3. Mapeie dependencias, libs usadas, padrão de imports e preencha a seção **2. ADR** do prd.md com a estrutura correta.
4. Mostre uma prévia para aprovação.
5. Se, aprovado, edite o prd.md substituindo a **seção 2**.

---

## Saída

Gera um feedback visual de forma resumida do que foi feito e os proximos passos.