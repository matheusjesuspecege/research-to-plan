---
name: research-to-plan
description: "Converte research.md estruturado em artefatos de apoio ao desenvolvimento. Use esta skill quando o research.md já estiver aprovado e pronto para a proxima fase de planejamento."
---

**Esta SKILL converte os artefatos gerados no research.md em artefatos da fase de planejamento técnico, gera os seguintes artefatos de apoio:** 

- Diagrama de Classes (conceitual/dominio) 
- Diagrama de Sequencia
- Plano ordenado de ação.

Esses artefatos servem de apoio ao planejamento do que precisará ser desenvolvido, ou seja, contratos, serviços, tecnologias, testes e outros artefatos taticos que serão necessários para iniciar a implementação.

---

# Regra Fundamental

- **SIGA O REQUISITO ORIGINAL EXATAMENTE COMO FORNECIDO. NÃO INVENTE, NÃO ADICIONE E NÃO SUPONHA NADA QUE NÃO ESTEJA EXPRESSAMENTE DEFINIDO NO RESEARCH.md. recebido**.
- Se o research.md não menciona algo, NÃO inclua. Se há ambiguidade, pergunte ao usuário antes de supor.

---

## Operações do Terminal

**Selecione o artefato que deseja gerar do research da feature [feature]:**
- 1. Diagrama de Classe (Modelo Conceitual) -> consulte a sessão: **Diagrama de Classe Modelo Conceitual**.
- 2. Diagrama de Classe (Modelo de Domínio) -> consulte a sessão: **Diagrama de Classe Modelo de Domínio**.
- 3. Diagrama de Sequencia -> consulte a sessão: **Diagrama de Sequencia**.
- 4. Gerar o plano de ação -> consulte a sessão: **Plano de ação**.
- 5. Encerrar Operação -> **Encerre a operação**
---

## Receber o requisito

- Solicite ao usuário (se não fornecido) o nome da feature no formato kebab-case.
- Verifique a existencia do **research.md** da feature que está localizado em **/specs/features/[nome]/research.md**.
- Se a feature NÃO existir, informe ao usuário para realizar a etapa de **research** primeiro para poder continuar, e encerre a operação.
- Se a feature existir, verifique se a feature possui pelo menos 1 caso de uso.
- **Se existir:**
  - Pergunte ao usuário se será gerado o artefato global ou individual.
  - Se for **Global:** consulte a seção **Geração Global** para mais detalhes.
  - Se for **Individual:** consulte a seção **Geração Individual** para mais detalhes.
  - execute a etapa **Operações do Terminal** com a intenção correta, ou seja (global, individual, etc...) usando as referencias especificas.

---

## Regras de Geração dos Artefatos

Os artefatos utilizam o **mermaid** para geração dos diagramas, use o mais apropriado.
- Consulte a documentação do **mermaid** para obter referencia: https://mermaid.js.org/intro/

**A geração dos artefatos podem ser realizadas de duas maneiras:**
- **global:** consulte a seção **Geração Global** 
- **individual:** consulte a seção **Geração Individual**
  
### Geração Global

- **Localização:** Todos os artefatos globais devem ser salvos na pasta da feature, ao lado do **research.md** no seguinte formato de nomenclatura: `[uc-01-type].mermaid`.

**O que deve ser gerado:**
- Gera o artefato mostrando a visão geral da feature, onde tudo relacionado a feature é mostrado em um unico artefato global para o humano ter uma visão geral dos proximos artefatos individuais que ele pode executar sob demanda.

### Geração Individual

- **Localização:** Todos os artefatos individuais devem ser salvos na pasta do use case corresponde, ao lado da **especificação do caso de uso** no seguinte formato de nomenclatura: `/specs/features/[feature]/[uc-01]/[uc-01-type].mermaid`

**O que deve ser gerado:**
- Gera o artefato mostrando a visão especifica da feature, onde tudo relacionado a feature específica é mostrado em um unico artefato, para o humano ter uma visão geral dos proximos passos individuais que ele pode executar sob demanda, usando a visão global feita em outro passo como apoio e consulta para tomar as melhores decisôes.

---

## Artefatos

### Diagramas de Classe

**Consulte:** `./references/class-diagram.md` para mais detalhes sobre **diagramas de classe**.

### Diagrama de Sequencia

- TODO

### Plano de Ação

- TODO

---
