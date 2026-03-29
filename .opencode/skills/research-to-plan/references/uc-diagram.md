## 1. Atores

Os atores representam papeis desempenhados pelos diversos usuarios que interagem com os serviços e funções do sistema.
- um ator pode representar algum hardware ou outro software que interaja com o sistema. 
- Na maioria das vezes, um ator representará uma pessoa que utilizará o sistema. 
- Cada ator deve ter um nome e um estereótipo que pode ser encontrado na sessão **4. Estereótipos**, que torna explicito que não é um ator humano, e sim sistemas de software ou hardware.
- Em resumo um ator é um usuário que pode representar mais de um papel no sistema

**Obs.** A utilização de estereótipo de sistemas de software ou hardware não é obrigatório, é apenas recomendado para destacar a caracteristica especial que o diferencia dos atores mais comuns.

### 1.1 Como identificar atores

- Deve-se procurar e identificar as entidades externas que interagirão com o sistema, tanto usuários humanos, como também, eventualmente, softwares e/ou hardwares especiais.

- **Candidatos a atores:**
    - Que tipos de usuários poderão usar o sistema?
    - Quais usuários estão interessados ou usarão quais funcionalidades e serviços do software?
    - Quem fornecerá informações ao sistema?
    - Quem usará as informações do sistema?
    - Existe algum outro software que interagirá com o sistema?
    - Existe algum hardware especial (com oum robô, por exemplo) que interagirá com o software?

- **Exemplo de atores válidos**
    - Gerente
    - Funcionario
    - Cliente
    - Sistema Integrado
    - Medidor de Radiação

**Obs.** Os candidatos a atores devem ser listados e deve-se tantar atribuir responsabilidades e objetivos a cada um deles, ou seja, metas que cada ator poderia desejar atingir ao usar o software. Atores para os quais não é possível atribuir um objetivo dificilmente serão atores verdadeiros e deverão ser eliminados.

---

## 2. Casos de Uso

Os casos de uso são usados para capturar os requisitos funcionais do sistema (serviços, tarefas, funcionalidades) identificadas como necessários ao software e que podem ser usados de alguma maneira pelos **atores**. Descrevem e documentam os comportamentos pretendidos para as funções do software.

- Descreve de forma resumida a funcionalidade ao qual o caso de uso se refere.
- O caso de uso costuma ser descrito com um verbo que descreve a ação que será realizada quando for executado. ex: **Abrir Conta**.

### 2.2. Localização

- Cada caso de uso e tudo relacionado deve ser salvo dentro de suas pastas individuais com o nome do caso de uso. ex: `/specs/features/[name]/[uc-01-nome-feature]/uc-01-nome-feature.md` kebab-case, cada feature em sua pasta propria.

### 2.3. Classificação

Os casos de uso podem ser classificados em dois tipos: **primários** ou **secundários**

- **Primários**:
    - Se refere a um processo importante, relacionado com um dos requisitos funcionais do software, ex: **Realizar um saque** ou **Emitir um extrato** em um sistema de controle bancário.
- **Secundários**:
    - Se refere a processos menos importantes, como manutençôes simples. 

**Obs.** É importante retornar o maximo de casos de uso, primários e secundários, detalhando-os o máximo possível para evitar inconsistências e frustrações com a entrega final do software.

### 2.4. Como identificar Casos de Uso

**Para identificar os casos de uso, é necessário determinar as funcionalidades necessárias ao software, ou seja:**
- Funçôes
- Serviços que correspondem aos requisitos funcionais declarados como necessários ao sistema

Uma maneira de auxiliar na identificação das funcionalidades é verificar a lista dos atores que comporão o sistema e quais os objetivos de cada ator. Esses objetivos muitas vezes corresponderão a uma ou mais funcionalidades. Tambem pode ser útil identificar os eventos externos que afetarão o software.Tais eventos muitas vezes acarretam a execução de uma funcionalidade ou influenciam de alguma forma seu processamento.

Outra maneira de identificar casos de uso é verificar a lista de requisitos funcionais estabelecidos e se cada um deles possui um (ou até mais) caso de uso especificando seu comportamento e, obviamente, qual ator ou atores podem utilizá-lo.

**Observações**
- Um caso de uso costuma ter uma série de passos ou etapas. Uma maneira de determinar se uma funcionalidade é real, ou seja, se realmente corresponde a um caso de uso, é verificar quais ações seriam realizadas quando o caso de uso fosse executado. Se não for possível identificar essas etapas, provavelmente não será um caso de uso real.
- Se o número de passos atribuidos a um caso de uso for muito pequeno, deve-se verificar se esse caso de uso não deveria ser englobado por outro, acrescentando seus passos ás etapas dele ou mesmo se tornando um cenário alternativo de outro caso de uso.

### 2.5. Documentação dos Casos de Uso

A documentação de caso de uso representa o comportamento de um caso de uso da maneira o mais completa possível, mas sem detalhes técnicos de implementação. 

**Obs.**: O detalhamento maior a nível de implementação, será feito em outra etapa posterior (**research-to-plan**). 

Consulte `../assets/uc-spec-example.md` para um exemplo de **Estrutura de Documentação de um Caso de Uso**.

---

## 3. Associações

Representam interações ou relacionamentos entre os atores e os casos de uso e os relacionamentos entre os casos de uso e outros casos de uso. Recebem nomes especiais, como **include**, **extends**, **generalization**.

- Uma associação entre um ator e um caso de uso demonstra que o ator utiliza de alguma maneira a funcionalidade do sistema representada pelo caso de uso em questão, seja requisitando a execução dessa função, seja recebendo o resultado produzido por ela a pedido de outro ator.

**A associação entre um ator e um caso de uso é representada por uma linha ligando o ator ao caso de uso, podendo ocorrer que as extremidades da linha contenham setas, indicando o sentido em que as informações trafegam:**

- Se estas setas são fornecidas pelo ator ao caso de uso, se são transmitidas pelo caso de uso ao ator ou ambos (nesse ultimo caso, a linha não tem setas, significando que as informações são transmitidas nas duas direções)
- As setas tambem servem para indicar quem inicia a comunicação.
- Uma associação pode ter uma descrição propria quando é necessário esclarecer a natureza da informação que está sendo transmitida ou dar um nome a esta, se isso for necessário.

**Exemplo:** Se o ator Cliente utiliza, de alguma forma, a funcionalidade de Abrir Conta, percebemos que o ator Cliente utiliza de alguma forma, a funcionalidade Abrir Conta, e que a informação referente a esse processo trafega nas duas direções.

### 3.1. Generalização/Especialização

Aplica os principios de **herança** da orientação a objetos permitindo que os passos descritos em um caso de uso sejam herdados por outros casos de uso que especializam o caso de uso original chamado geral. A generalização/especialização tambem pode ser aplicado sobre atores, o que é até mais comum.

- Assim, é desnecessário colocar a mesma documentação para todos os casos de uso envolvidos, pois toda a estrutura de um caso de uso generalizado é herdada pelos casos de uso especializados.
- Além disso, os casos de uso especializados herdam tambem quaisquer associações de **inclusão** ou **extensão** que o caso de uso geral venha a ter, bem como quaisquer associações com os atores que utilizam o caso de uso geral.
- É representado pelo estereótipo que pode ser encontrado na seção **4. Estereótipos**.
- Em situações de casos de uso especializados, deve conter o item **Caso de Uso Geral**, onde será especificado a partir de qual caso de uso geral eles foram especializados.

**Obs.** use associações especializadas com parcimônia, em situações em que possam ser utilizadas para evitar a repetição de instruçôes, por exemplo.

### 3.2. Inclusão

A associação de **inclusão** é usada quando existe um cenário, situação ou rotina comum a mais de um caso de uso. Quando isso ocorre, a documentação dessa rotina é oclocada em um caso de uso específico para que outros casos de uso utilizem esse serviço, evitando-se descrever uma mesma sequencia de passos em vários casos de uso, poupando tempo e facilitando futuras manutenções.

- Os relacionamentos de inclusão indicam uma obrigatoriedade, ou seja, quando um determinado caso de uso tem um relacionamento de inclusão com outro, a execução do primeiro obriga também a execução do segundo. pode ser comparado a uma **sub-rotina**.
- É representado pelo estereótipo que pode ser encontrado na seção **4. Estereótipos**.

### 3.3. Extensão

As associações de **extensão** são usadas para descrever cenários opcionais que podem ser estendidos pelos comportamentos de outros casos de uso. 

- Descrevem cenários que apenas serão executados em situações específicas quando determinadas condições forem satisfeitas.
- Indicam a necessidade de um teste no comportamento de um caso de uso para determinar se é necessário executar também o comportamento (os passos) de um caso de uso estendido.
- Representam situações que não ocorrem sempre, o que não significa que sejam incomuns. 
- Tem uma representação semelhante a **inclusão**, sendo representadas por um alinha tracejada, diferenciando-se pelo fato de a seta apontar para o caso de uso que utiliza o o caso de uso estendido.
- É representado pelo estereótipo que pode ser encontrado na seção **4. Estereótipos**.

**Exemplo:** Em um formulário de login em que o cliente deverá informar seu nome-login e senha para poder se autenticar no sistema. No cenário ideal desse processo, o cliente informará um nome-login e senha válidos e lhe será permitido acessar o software. Contudo, pode acontecer de o cliente estar acessando a esse formulario pela primeira vez e não possuir cadastro no sistema. Ao prever essa possibilidade, o formuario permite que o cliente se registre, apresentando a opção de pressionar o botão **Autoregistrar** para se cadastrar no sistema. Obviamente, o cliente só fará isso na primeira vez, seguindo o processo normal nas vezes seguintes. Uma vez que o processo de Autoregistrar poderá ser chamado a partir do processo de **Login**, mediante a condiçção de o cliente nao estar cadastrando.

### 3.4. Restrições em Associações de Extensão

São utilizadas para definir validações, consistências, condições etc... que devem ser aplicadas a um determinado componente ou situação.

- Ao tratar de extensôes, ás vezes nem sempre fica claro qual é a condição para um caso de uso estendido seja executado. Assim, pode-se acrescentar um estereótio que pode ser localizado na seção **4. Estereótipos**.

**Obs.** essas restrições nada mais são do que regras de negócio referentes ao processo.

### 3.5. Pontos de Extensão

Um ponto de extensão identifica um ponto no comportamento de um caso de uso a partir do qual esse comportamento poderá ser estendido pelo comportamento de outro caso de uso, se a condição para que isso ocorra for satisfeita.

### 3.6. Multiplicidade

A multiplicidade em uma associação entre um ator e um caso de uso basicamente especifica o número de vezes que um ator pode usar um determinado caso de uso.

- 1:1
- 1:N
- N:N

--- 

## 4. Estereótipos

Os estereótipos possibilitam certo grau de extensibilidade aos componentes ou associações da UML. além de permitir a identificação de componentes ou associações que, embora semelhantes aos outros, tenham alguma caracteristica que os diferencie, dando-lhes mais destaque no diagrama.
- Podem atribuir funções extras a um componente, permitindo que este possa ser usado para modelar situaçôes diferentes daquelas para as quais foi originalmente projetado.

**Exemplos de estereótipos**:
- **`<<extend>>`:** É representada de forma muito semelhante a **inclusão**, diferenciando-se pelo fato de a seta apontar para o caso de uso que utiliza o caso de uso estendido, e por haver um estereótipo contendo o texto **extend**.
- **`<<include>>`:** É representada por uma linha tracejada contendo uma seta em uma de suas extremidades, a qual aponta para o caso de uso incluido no caso de uso posicionado na outra extremidade da linha. Costumam tambem apresentar um estereótipo que contém o texto **include**
- **`<<system>>`**
- **generalização/especialização:** É representada por uma linha com uma seta mais grossa, que indica qual o caso de uso geral (para o qual a seta aponta) e quais os casos de uso especializados (os que se encontram na outra extremidade da seta, apontando para o caso de uso geral). **ex:** 'Abrir Conta Comum' é o caso de uso geral, e (Abrir Conta Especial, Abrir Conta Poupança) são especializações do caso de uso **Abrir Conta Comum** e detalham as particularidades em sua própria documentação.
- **restrições em associações de extensão:** Pode-se acrescentar uma condição á associação de extensão por meio de uma nota explicativa, determinando a condição para que o caso de uso seja executado. A seta tracehada que une o componente é chamada âncora.

**Obs.** Existe uma grande quantidade de estereótipos que podem ser aplicados aos mais diversos componentes da UML. O engenheiro de software pode criar seus proprios estereótipos se necessário. Use a documentação oficial da UML como **referência**: https://www.omg.org/uml/ exibindo os estereótipos de maneira textual.

## 5. Fronteira de Sistema

Uma fronteira de sistema indentifica um classificador que contém um conjunto de casos de uso. Permite identificar um subsistema ou mesmo um sistema completo, além de destacar o  que está contido no sistema e o que não está.

- Atores são externos ao sistema, enquanto casos de uso são internos.
- É representada por um retêngulo envolvendo os casos de uso nela contidos, além de um título que a descreve.