---
name: azure-mcp-connect
description: "Conecta ao backlog do produto que está no Azure DevOps, permitindo que o desenvolvedor automatize processos, crie de tarefas, leia o prd das US, e obtenha informações do backlog do produto. Use quando estiver na etapa de research e está refinando o entendimento da US com o Product Owner ou durante o desenvolvimento para obter insights."
---

Esta SKILL é usada por desenvolvedores que estão trabalhando em uma US e precisam se conectar ao **Azure DevOps** para obter contexto do backlog e da US em que está trabalhando.

## 1. Regra Fundamental

- **SIGA O REQUISITO ORIGINAL EXATAMENTE COMO FORNECIDO. SEM INVENTAR, ADICIONAR OU SUPOR ALGO QUE NÃO ESTEJA EXPRESSAMENTE DEFINIDO NA US.**
- Se há ambiguidade, pergunte ao usuário antes de prosseguir.
- Somente responda exclusivamente de acordo com as funções disponíveis. avise o usuario, liste as opções disponiveis para que ele pode usar.
- Sempre informe os proximos passos para o usuario, principalmente em momentos que ele terminou de executar uma ação, para que ele saiba o que fazer.

---

## 2. Pré-Requisitos

Para o **MCP do Azure DevOps** funcionar corretamente é necessário configurar **3 coisas:**

- **Organization:** o nome da organização que conecta os grupos de projetos relacionados na empresa.
- **Personal Access Token (PAT):** token de acesso pessoal para autenticação no **Azure DevOps**, identifica o desenvolvedor e determina o grau e escopo de acesso.
- **Variável de ambiente com o token (PAT):** forma de guardar o **PAT** do Azure DevOps com segurança.

---

## 3. Passo a Passo

1. Mostre as instruções de como usar a skill para se conectar no Azure DevOps via MCP.
2. Solicite a url do board do projeto e extraia as informações necessárias, ex: (nome da organização, projeto, board etc...). 
3. Solicite o **personal acess token (pat)**
4. Caso o usuário não possua as informações, mostre no terminal o tutorial que pode ser encontrado na sessão: **Tutorial para Devs**
6. Com os **pré-requisitos** em mãos, extraia as informações necessárias e prossiga
7. Armazene a variavel de ambiente local necessária, com o conteudo do **Personal Access Token (PAT)**, usando as instruções que podem ser encontradas na sessão **Variavel de Ambiente**
8. Conecte-se no MCP do Azure DevOps e informe ao usuário que se conectou com sucesso, e liste os comandos disponiveis para uso que podem ser encontradas na sessão: **Funções disponíveis**

**Obs:** responda somente baseado no contexto do projeto ao qual foi informado pelo usuário.

---

## Variável de Ambiente

O MCP do Azure DevOps usa o PAT através de variaveis de ambiente locais chamada **AZURE_DEVOPS_PAT** sendo o conteúdo o **Personal Access Token (PAT)** informado pelo usuário.

### Como armazenar

**Windows (PowerShell)**
```powershell
$env:AZURE_DEVOPS_PAT="token_aqui"
```

**Mac / Linux**
```bash
export AZURE_DEVOPS_PAT="token_aqui"
```

---

## Tutorial para Devs

Descreve os passos necessários para o desenvolvedor configurar corretamente os **Pré-Requisitos** necessários para usar esta SKILL.

### Encontrando o nome da organização
  - Abra o Azure DevOps: `https://dev.azure.com`
  - Quando entrar em um projeto, a URL ficará algo assim: `https://dev.azure.com/minha-organizacao/meu-projeto/_boards`
  - **minha-organizacao** é o valor que deve ser usado

### Exemplo de arquivo de configuração

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "azure-devops": {
      "type": "local",
      "command": ["npx", "-y", "@azure-devops/mcp", "minha-organizacao"],
      "enabled": true
    }
  }
}
```

## Funçôes Disponíveis

Lista ordenada com todas as funções disponíveis de acordo com as permissôes do usuario. Adicione uma breve descrição de uso de cada uma delas para facilitar a compreensão.