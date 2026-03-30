## 1. Plano de Ação

O arquivo **plan.md** é o plano geral de implementação da feature, contem a ordem priorizada dos **use cases** que serão desenvolvidos, assim como o caminho para encontrar os artefatos necessários para a implementação frontend e backend. 

### 1.1. Regras de Geração
- A ordem deve seguir **dependências funcionais**, ou seja, se algo depende da existência de outra para funcionar, só deve ser implementada quando a outra tiver sido implementada.
    - **Consulte** a seção **6. Tipos de Relacionamento e Impacto na Prioridade** em `./uc-diagram.md` para mais detalhes.
- Não gere os diagramas .mermaid, eles devem ser armazenados e consultados na memoria para servir de base para encontrar os artefatos necessarios.  
- Para descobrir quais contratos (types, services, componentes etc...) que devem ser gerados, primeiro gere e armazene na memória o diagrama necessário usando os artefatos que podem ser encontrados na seção **Artefatos**. Não gere os arquivos e diagramas finais, apenas consulte na memoria. 
- Salve tudo relacionado a interfaces frontend utilizando **Atomic Design** como metodologia, não precisa usar nomes como atomo, molecula etc... apenas siga a filosofia da metodologia como base.

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

- Salve os contratos gerais que serão utilizados pelo frontend e backend no arquivo **contracts.md** ao lado da documentação do caso de uso da feature, ex: `/specs/features/[nome]/[uc-01-nome]/[uc-01]-contracts.md`.
- Salve os serviços, e tudo relacionado a backend no arquivo **backend.md** ao lado da documentação do caso de uso da feature, ex: `/specs/features/[nome]/[uc-01-nome]/[uc-01]-backend.md`.
- Salve os componentes, interfaces e tudo relacionado a frontend no arquivo **frontend.md** ao lado da documentação do caso de uso da feature, ex: `/specs/features/[nome]/[uc-01-nome]/[uc-01]-frontend.md`

### Estrutura do Arquivo

```markdown
# Plano de Implantação - [feature]

## Ordem de Implementação dos Casos de Uso

Nome do caso de uso, e um link de referencia para encontra-lo, assim como todos os artefatos necessários para implementação, identificados pelo tipo e hierarquia.
```
