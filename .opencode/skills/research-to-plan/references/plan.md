## 1. Plano de Ação

O arquivo **plan.md** é a visão geral do plano de implantação da feature, ordenado por prioridade dos **use cases** que serão desenvolvidos, caminho para encontrar ou gerar os artefatos necessários para a implantação frontend e backend. 

### 1.1. Regras de Geração
- A ordem deve seguir **dependências funcionais**, ou seja, se algo depende da existência de outra para funcionar, só deve ser implementada quando a outra tiver sido implementada.
    - **Consulte** a seção **6. Tipos de Relacionamento e Impacto na Prioridade** em `./uc-diagram.md` para mais detalhes.
- Não gere os diagramas .mermaid, eles devem ser armazenados e consultados na memoria para servir de base para encontrar os artefatos necessarios.  
- Para descobrir quais contratos (types, services, componentes etc...) que devem ser gerados, primeiro gere e armazene na memória o diagrama necessário usando os artefatos que podem ser encontrados na seção **Artefatos**. Não gere os arquivos e diagramas finais, apenas consulte na memoria. 
- Salve tudo relacionado a interfaces frontend utilizando **Atomic Design** como metodologia, não precisa usar nomes como atomo, molecula etc... (**use o nome do componente real**), apenas siga a filosofia da metodologia como base.

### 1.2. Modelo de Dependência Estrutural

**Um diagrama de caso de uso pode ser interpretado como:**

1. Infraestrutura de regras
2. Serviços reutilizáveis
3. Casos de uso principais
4. Variações de comportamento
5. Extensões opcionais

Essa estrutura permite derivar **camadas naturais de implementação** para permitir automatizar para a seguinte **transição:**

1. User Story
2. Use Case Model
3. Dependency Ordering
4. BDD Scenario Generation
5. TDD Test Generation
6. Implementation Tasks

### 1.3. Onde salvar

Use a **Estrutura do Arquivo** como modelo para salvar.

### Estrutura do Arquivo

- O desenvolvedor precisa ter uma visão tatica clara de tudo que será feito, sem nenhuma duvida: 
- para cada caso de uso, adicione instruções de como o desenvolvedor poderá gerar os artefatos necessários para implementação, principalmente os diagramas.
- Informe ao usuário resumidamente como obter o artefato necessário ex: Diagramas.
- Insira links de referencias uteis que agregam valor na implementação da feature em cada topico específico. 
- Priorize a legibilidade e entendimento humano, use tabelas e recursos visuais com moderação.
- Use como referência os **Critérios de Aceite** do caso de uso ordenados por dependência de implementação.
- Separe claramente frontend de backend.

```markdown
# Plano Tático de Implantação - [feature]

Breve resumo do plano

## Ordem de Implementação dos Casos de Uso

Liste os casos de uso ordenados corretamente por ordem de prioridade de implementação. 

## O que pode ser executado em paralelo

Liste os casos de uso que podem ser executados simultaneamente.
```
