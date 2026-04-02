---
name: spec-sync
description: "Esta SKILL analisa a árvore do git para casos de uso concluídos de uma feature, comparando a implementação real com as especificações (prd.md, research.md, uc-*.md), e indentifica inconsistências entre o código e as specs (sendo as specs a fonte de verdade). Use após concluir um ou mais casos de uso ou critério de aceite para verificar se o que foi implementado está alinhado com o que foi especificado.
---

# Introdução

Esta SKILL analisa a árvore do git para casos de uso concluídos de uma feature, comparando a implementação real com as especificações (**prd.md, research.md, uc-*.md**), e indentifica inconsistências entre o código e as specs (**sendo as specs a fonte de verdade**). 

---

## Regras Fundamentais

- **Specs são a fonte de verdade:** Qualquer divergência entre código e spec deve ser reportada.
- **Apenas UCs concluídos:** Não analisar casos de uso em andamento.
- **Manter objeto:** Reportar inconsistências sem assumir que devem ser corrigidas agora.
- **Comunicação amigável:** Retornar de uam forma que facilite compreesão humana.

---

## Passo a Passo

**Atenção:** consulte a sessão **Mensagem de Erro/Encerramento** para casos de erro ou uso incorreto da skill.

1. Solicite ao usuário, o nome da feature (caso não tenha fornecido), e liste todos os casos de uso já concluídos (ou verificação automática via plan.md).
2. Leia o **plan.md** da feature, para identificar os casos de uso concluídos.
3. Leia **prd.md** e **research.md** para entender as especificações.
4. Leia o arquivo **uc-*.md** da feature e verifique os critérios de aceite marcados com [x] (concluído).
5. Busque commits relacionados ao UC na árvore do git e verifique a implementação real comparando com os critérios.
6. Para cada item comparado, verifique se está documentada na **especificação** e identifique inconsistências classificando por severidade (alta, média, baixa).


---

## Tipos de Inconsistências

- **tipo:** Versão diferente, lib substituida, dependencias faltantes ou divergentes, versôes das libs desincronizadas.
- **estrutura:** Pasta não criada, nomenclatura diferente.
- **componentes:** Componente não criado, componente extre sem justificativa.
- **exportação:** exports não definidos conforme spec.
- **tipos:** Tipos não usados, como especificado.

---

## Mensagem de Erro/Encerramento

- Se a feature não existir: "Feature não encotnrada. Verifique o nome".
- Se nenhum UC concluído: "Nenhum caso de uso concluido nesta feature ainda".
- Se tudo alinhado: "Implementação alinhada com especificações. Nenhuma inconsistencia encontrada".

---

## Saída

Retornar um relatório estruturado com lista de UCs verificados, inconsistências encontradas, comparação spec vs implementação, severidade, recomendação do que precisa ser ajustado para sincronizar código com spec, e outras informações relevantes.