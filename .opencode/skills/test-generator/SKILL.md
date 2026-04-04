---
name: test-generator
description: Esta SKILL gera os cenários de teste BDD e tdd dos usecases da feature. Use esta SKILL quando a feature estiver pronta para ser implementada e precisa gerar os cenários de testes para iniciar a codificação.
---

# Introdução

Esta SKILL tem o objetivo de gerar os cenários de testes BDD e os cenários TDD equivalentes para iniciar a implementação da feature que já está pronta.

---

## Regras Fundamentais

**Obs:** use como referencia para geração dos arquivos de teste, o arquivo **plan.md** que está ao lado do **research.md**, caso não exista, informe ao usuário, e **encerre a operação**, caso exista, prossiga. 

- É obrigatório a feature existir, caso não exista, encerre a operação.
- Antes de salvar os arquivos de teste, leia os testes, separe o que é frontend e backend.
- Grave todos os testes de frontend no arquivo **feature.frontend** e backend no arquivo **feature.backend**.
- Os cenários de testes BDD e TDD devem estar sincronizados, ou seja, o que o frontend precisa do backend deve estar sincronizado com o que o backend irá testar.
- Os testes seguem o padrão (Arrange, Act, Asset).
- Adicione tambem cenários de testes para testar cenários da **Lei de Murphy**.
- Os nomes e cenarios de teste entre o BDD e o TDD devem estar **totalmente sincronizados**.
- Por padrão, todos os testes com **excessão do primeiro** devem estar com **skip**. 
- Somente os 3 primeiros testes no aquivo **.spec**, deve ter algum **code snipet** todos os outros cenários de teste devem estar com um comentário **TODO** indicando que será implementado em breve.
- O arquivo BDD deve ser salvo com a extensão `.feature` e o TDD deve ser salvo `.spec.ts`
- Gere tambem ao lado do arquivo **TDD** uma documentação de refência de implementação, para **frontend** (caso necessite), e **backend** (caso necessite), seguindo a sessão **Documento de Referência para Implementação** como referência.

**Atenção:** Se não existir testes frontend **não crie** os arquivos de teste frontend, se não existir testes backend **não crie** os arquivos de teste backend.

---

## Passo a Passo

1. Solicite para o usuário o nome da feature e o nome do caso de uso ao qual será gerado os cenários de teste.
2. Analise a especificação do caso de uso da feature informada pelo usuario. 
3. Gere os cenários de teste BDD do caso de uso e salve ao lado da especificação do caso de uso.
4. Gere os cenários TDD referentes ao BDD que foi gerado, salva tambem ao lado da especificação do caso de uso.
5. Encerre a operação.

--- 

## Documento de Referência para Implementação

Este é um documento que descreve a visão **operacional** usado exclusivamente pelos desenvolvedores para ter um ponto de partida inicial dos passos a passos que serão necessários para implementar os testes da feature que será desenvolvida para que todos os critérios de aceite sejam cumpridos com a máxima eficacia.

**Nome do arquivo:** implement-plan-reference.md

**Atenção:** Deve haver **code snipes** com código que funciona para fazer o teste passar para todos os cenários de teste.

- Para cada code snipet, deverá ter o link da documentação oficial da ferramenta, processo, metodologia que foi usada como referência.
  - Antes de gravar o link da documentação, verifique se o link está funcionando e se o conteudo realmente existe na documentação de referencia.
  - Adicione a linha, pagina ou item exato da documentação para ser localizado rapidamente.
- Deve haver um plano passo a passo claro, com code snippets sempre que for necessario para ajudar a compreensão humana.
- Deve ser escrito em uma linguagem simples focada em desenvolvedores juniores.

**Importante:** 
  - Deve ser gerado um arquivo exclusivo e especifico para cada caso de uso, sempre ao lado do arquivo do requisito para facilitar o uso.
  - Adicione uma mensagem curta, objetiva e informativa abaixo do titulo de cada **code-snipet**, informando ao desenvolvedor que o código é apenas uma ideia de implementação que funciona, e pode não representar os padrôes de código real da equipe ou projeto (**gere uma mensagem para que ele implemente seguindo a propria forma de trabalhar e consulte a referência da documentação fornecida para estudo**).

---

## Saída

Informe o usuário o que foi feito e sugira os proximos passos.