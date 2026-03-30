---
name: research-to-plan
description: "Converte research.md estruturado em artefatos de apoio ao desenvolvimento. Use esta skill quando o research.md já estiver aprovado e pronto para a proxima fase de planejamento."
---

**Esta SKILL converte os artefatos gerados no research.md em artefatos da fase de planejamento técnico, gera os seguintes artefatos de apoio:** 

- Diagrama de Classes (dominio) 
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
- 1. Jornada do Usuário -> consulta a sessão: **Jornada do Usuário**
- 2. Diagrama de Caso de Uso -> consulte a sessão: **Diagrama de Caso de Uso**
- 3. Diagrama Navegacional -> consulte a sessão: **Diagrama Navegacional**
- 4. Diagrama de Sequencia -> consulte a sessão: **Diagrama de Sequencia**.
- 5. Diagrama de Classe (Modelo de Domínio) -> consulte a sessão: **Diagrama de Classe** con intenção de Modelo de Domínio.
- 6. Diagrama de Estrutura Composta -> consulte a sessão: **Diagrama de Estrutura Composta**
- 7. Gerar o plano de ação -> consulte a sessão: **Plano de ação**.
- 8. Encerrar Operação -> **Encerre a operação**

**Atenção:** responda estritamente conforme especificado na respectiva sessão do diagrama selecionado, caso um diagrama ou opção não esteja especificado, avise o usuário que não está disponível e peça que selecione outro que esteja disponível.

---

## Receber o requisito

- Solicite ao usuário (se não fornecido) o nome da feature no formato kebab-case.
- Verifique a existencia do **research.md** da feature que está localizado em **/specs/features/[nome]/research.md**.
- Se a feature NÃO existir, informe ao usuário para realizar a etapa de **research** primeiro para poder continuar, e **encerre a operação**.
- Se a feature existir, verifique se a feature possui pelo menos 1 caso de uso.
- **Se existir:**
  - Pergunte ao usuário se será gerado o artefato 1. global ou 2. individual.
  - Se for **1. Global:** consulte a seção **Geração Global** para mais detalhes.
  - Se for **2. Individual:** consulte a seção **Geração Individual** para mais detalhes.
  - execute a etapa **Operações do Terminal** com a intenção correta, ou seja (global, individual, etc...) usando as referencias especificas.

---

## Regras de Geração dos Artefatos

Os artefatos utilizam o **mermaid** e **plantuml** para geração dos diagramas, use o mais apropriado.
- Consulte a documentação do **mermaid** para obter referencia: https://mermaid.js.org/intro/
- Consulte a documentação do **plantuml** para obter referencia: https://plantuml.com/

**A geração dos artefatos podem ser realizadas de duas maneiras:**
- **global:** consulte a seção **Geração Global** 
- **individual:** consulte a seção **Geração Individual**
  
### Geração Global

- **Localização:** Todos os artefatos globais devem ser salvos na pasta da feature, ao lado do **research.md** no seguinte formato de nomenclatura: `[uc-01-type].[mermaid/plantuml]`.

**O que deve ser gerado:**
- Gera o artefato mostrando a visão geral da feature, onde tudo relacionado a feature é mostrado em um unico artefato global para o humano ter uma visão geral dos proximos artefatos individuais que ele pode executar sob demanda.

### Geração Individual

- **Localização:** Todos os artefatos individuais devem ser salvos na pasta do use case corresponde, ao lado da **especificação do caso de uso** no seguinte formato de nomenclatura: `/specs/features/[feature]/[uc-01]/[uc-01-type].[mermaid/plantuml]`

**O que deve ser gerado:**
- Gera o artefato mostrando a visão especifica da feature, onde tudo relacionado a feature específica é mostrado em um unico artefato, para o humano ter uma visão geral dos proximos passos individuais que ele pode executar sob demanda, usando a visão global feita em outro passo como apoio e consulta para tomar as melhores decisôes.

---

## Artefatos

**Importante:**
- Antes de gerar o diagrama, leia a documentação do mermaid e use a sintaxe especificada na documentação para evitar erros de sintaxe. O link da documentação pode ser encontrada logo abaixo ao lado do nome do diagrama.
- Gere os diagramas priorizando a simplicidade visual, evitando efeitos decorativos que não agregam na compreensão humana, priorizando apenas cores para ajudar na compreensão.
- Nomes de entidades, classes, atores, atributos, métodos devem ser escritos em inglês, todo o resto em portugues(pt-br).
- Produza diagramas de fácil compreensão que possam ser entendidos por qualquer leitor, sem ser necessário conhecer uma determinada linguagem de programação para entendê-los.

Todos os artefatos são gravados em formato de diagrama usando **mermaid** ou **plantuml**, nas seguintes referências:
- **Jornada de Usuário:** https://mermaid.js.org/syntax/userJourney.html
- **Diagrama Navegacional:** https://mermaid.js.org/syntax/flowchart.html
- **Diagrama de Caso de Uso:** https://plantuml.com/use-case-diagram
- **Diagrama de Classe:** https://mermaid.js.org/syntax/classDiagram.html
- **Diagrama de Sequencia:** https://plantuml.com/sequence-diagram
- **Diagrama de Estrutura Composta:** https://mermaid.js.org/syntax/flowchart.html

**Onde salvar**
- **Global:** devem ser salvos na pasta da feature (raiz) ao lado do research.md, ex: `/specs/features/[nome]/[nome-diagrama-nome-feature].[mermaid/plantuml]` 
- **Individual:** devem ser salvos na pasta da feature, ao lado da documentação do requisito, ex: `specs/features/[nome]/[uc-01-nome-feature]/[uc-1-nome-diagrama].[mermaid/plantuml]` 

### Jornada do Usuário 

O Diagrama e Jornada de Usuário descreve o caminho que o usuário percorre para atingir um objetivo dentro do produto, focando na experiencia e nas ações do usuário, não na implementação técnica.

**Atributos essenciais de uma Jornada do Usuário**
- **Ator (Persona):** quem está realizando a jornada. Ex: Usuário, Cliente.  
- **Objetivo do Usuário:** O que o usuário quer alcançar ao iniciar a jornada. Ex: Criar uma conta, Finalizar pagamento.
- **Etapas da Jornada:** As ações principais do usuário para atingir o objetivo. Representadas em sequencia, focadas na perspectiva do usuário, sem detalhes técnicos de implementação.
- **Pontos de Decisão:** Momentos em que o usuário precisa escolhar ou validar algo. Ex: termos aceitos? dados válidos?
- **Resultados/Estados Finais:** O que acontece no final da jornada. Ex: compra confirmada, erro de pagamento.

**Importante:**
- A jornada precisa mostrar a ordem das ações. Sequencia clara, fluxo linear ou com decisôes.
- Pode incluir, fricções, erros, estados intermediários.
- A sintax mermaid é `journey` e não `userJourney`.

### Diagrama Navegacional

O Diagrama Navegacional representa como as telas ou páginas de um sistema se conectam e como o usuário navega entre elas. É usado principalmente para definir o fluxo de navegação da interface (frontend).

**Objetivo:**
- Mostrar a estrutura de navegação do sistema, indicando: quais telas existem, como o usuário se move entre elas, quais decisôes mudam o fluxo.

**Atributos essenciais:**
- **Telas/Páginas:** representam as interfaces que o usuário acessa. ex: Página do evento, tela de pagamento.
- **Transições de Navegação:** Mostram como o usuário vai de uma tela para outra. Ex: Clicar em "avançar", escolher método de pagamento.
- **Pontos de Decisão:** Quando a navegação depende de uma condição. Ex: dados válidos?, termos aceitos?
- **Estados de Interface:** Situações que alteram o fluxo da tela. Ex: erro de validação, sessão expirada.

**Importante:** O diagrama foca na interface e descreve a navegação entre telas, não regras de negócio.

### Diagrama de Caso de Uso

**Consulte:** `./references/uc-diagram.md` para mais detalhes sobre **diagramas de caso de uso**.

### Diagramas de Classe

**Consulte:** `./references/class-diagram.md` para mais detalhes sobre **diagramas de classe**.

### Diagrama de Sequencia

O diagrama de sequencia se preocupa com a ordem temporal em que as mensagens são trocadasentre os objetos envolvidos em um determinado processo. Em geral, baseia-se no diagrama de caso de uso e apoia-se no diagrama de classes para determinar os objetos das classes envolvidas em um processo.

Costuma identificar o evento gerador do processo modelado, bem como o ator responsável por esse evento, e determina como o processo deve se desenrolar e ser concluido por meio da chama de métodos disparados por mensagens enviadas entre os objetos.

**Regras gerais:**
- Use uma abordage mais detalhada para facilitar a compreensão.
- Não se basear em nenhuma linguagem de programação específica, é o correto.
- Não é necessário a rigor haver um método **get** e **set** para cada atributo de uma classe, uma vez que o diagrama é de nivel mais alto.

### Diagrama de Estrutura Composta

Descreve a estrutura interna de um classificador, como uma classe ou componente, detalhando as partes internas que o compoem, como estas se comunicam e colaboram entre si. Também é usado para descrever uma colaboração em que um conjunto de instancias coopera entre si para realizar uma tarefa.

### Plano de Ação

**Consulte:** `./references/plan.md` para mais detalhes sobre o arquivo de **Plano de Ação**.

---
