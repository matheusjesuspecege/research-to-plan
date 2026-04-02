## Exemplo de Estrutura de Documentação de um Caso de Uso

```markdown
## UC01 - Escolher Pizza

- **Caso de Uso Geral:** Nome do caso de uso geral a partir do qual o caso de uso atual foi derivado
- **Ator Principal:** identifica o ator que mais interage com o caso de uso (1-3 linhas).
- **Atores Secundários:** interagem em um nível menor com o sado de uso. (Não é obrigatório declarar um ator secundário, visto que pode existir ou não) (1-3 linhas).
- **Resumo:** Este caso de uso representa o processo por meio do qual um cliente pode escolher uma pizza. Ao ter essa opção selecionada, o sistema deverá apresentar um formulário contendo duas divisôes: a primeira apresentará os tamanhos de pizzas que a pizzaria oferece (pequeno, médio e grande) e a segunda, os sabores disponíveis. Por meio desse formulário, primeiramente o cliente deverá escolher o tamanho da pizza que deseja. Após o tamanho escolhido, o cliente poderá escolher tantos sabores quanto os permitidos pelo tamanho. Quando tiver concluido a escolha da pizza, bastará selecionar o botão **Adicionar** para adicionar a pizza ao pedido. O cliente poderá repetir esse processo quantas vezes quiser.
- **Pré-condições:** para que o caso de uso seja executado ou concluído. (1-3 linhas)
- **Pós-condições:** tarefas que devem ser realizadas depois que as etapas do caso de uso tiverem sido concluídas. (1-3 linhas)

### Cenário Principal

No cenário principal, muitas vezes se representa um "caminho feliz" onde tudo funciona conforme o esperado. 

Ações do Ator | Ações do Sistema |
  ----------------|-------------------
| Ações realizadas pelo ator que interage com o sistema | Ações executadas pelo próprio sistema |

**Obs.** As ações do ator e do sistema são numeradas em uma ordem sequencial.

### Restrições/Validações

São as regras de negócio, ou seja, regras que determinam as condições para que o processo seja executado.

### Cenário Alternativo

Os cenários alternativos podem ser executados ou não, dependendo se uma condição for satisfeita.

### Cenário de Exceção

Ações que devem ser tomadas em situações em que um cenário principal ou alternativo não pode ser concluído, em razão de alguma regra de negócio ter sido transgredida, por exemplo.

### Requisitos Não-Funcionais

No final da documentação, insirir os **requisitos não funcionais** que especificam condições de usabilidade, desempenho, confiabilidade ou segurança, por exemplo.

## Critérios de Aceite

Critérios de aceitação, ou seja, todas as tarefas que precisam ser realizadas para que o caso de uso funcione corretamente e cumpra o seu proposito e objetivo. Deve ser ordenado de maneira verificável e compativel para servir de base para geração dos cenários de testes (BDD).
```