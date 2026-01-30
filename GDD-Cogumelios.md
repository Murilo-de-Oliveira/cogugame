# GDD PROJETO COGUMÉLIOS

## VISÃO GERAL
**Título**:  

**Gênero**: RPG por turno

**Plataforma**: PC

**Descrição**: O projeto é um jogo estilo RPG baseado em turnos em homenagens a todos os amigos (e inimigos) que fizemos pelo caminho. O jogo consiste em batalhas de estratégia por turnos com um sistema de posicionamento dinâmico durante o combate. Além disso, o jogados pode encontrar e recrutar os amigos cogumélicos a medida em que avança nos atos.

**Principais Mecânicas**: Combate por turnos, sistema de posicionamento em grade com linha de frente/traseira/flancos, sistema de atributos, progressão de personagens baseado em níveis e itens.

## GAMEPLAY
### Ciclo de Gameplay
O jogador acompanha a história e pode se mover por um mundo aberto, com diferentes áreas para explorar. As áreas são bloqueadas via softlock (jogador fraco demais para os inimigos da área). Quando um inimigo é encontrado (não serão batalhas aleatórias saindo do nada), uma batalha em turnos começa. Ao ganhar, o jogador recebe experiência, itens, ouro e consumíveis (em alguns casos). O objetivo é melhorar os personagens e progredir a história.

### Sistema de combate
- **Ordem dos turnos**: A ordem dos turnos é decidida pela `velocidade` dos personagens

- **Campo de batalha**: O grupo de personagens fica do lado esquerdo da arena, enquanto os inimigos do lado direito. A arena pode ser dividida em 3 partes: lado aliado, lado inimigo e flancos. No lado aliado e lado inimigo, temos 2 linhas verticais em cada: a linhas de *vanguarda* e linha de *retaguarda*. Personagens que ocupam as linhas de *vanguarda* e *retaguarda* não podem atacar personagens da *retaguarda* adversária a menos que possuam uma habilidade que os permita isso. Alguns personagens podem se deslocar para o *flanco* por uma certa quantidade de turnos, podendo acertar personagens da *retaguarda*.

- **Ações por turno**: Cada personagem pode usar apenas uma `ação` por turno. Esta ação pode ser: usar uma habilidade, atacar, se mover para o *flanco* (caso possa), usar um consumível, fugir (não aplicável para chefes ou monstros que devem ser vencidos para continuar a história). Importante: voltar do flanco para a posição inicial não gusta a ação do personagem.
- **Interface de combate**: o jogador pode selecionar diretamente inimigos ou aliados (se aplicável) para executar uma ação. Na parte inferior do centro da tela, o jogador poderá acessar as ações do personagem, além de ver seus respectivos pontos de `vida` e `mana`.

- **Fim do combate**: o jogador sempre receberá uma quantia de `dinheiro` e `experiência` toda vez que vence o combate. Pode ocorrer de receber equipamentos, consumíveis ou outros itens. Não há penalidade por perder um combate. Caso o jogador opte por fugir do combate, não receberá recompensas, não restaurará `vida` e `mana` e os itens consumíveis usados no combate não retornarão.

### Personagens
- **Ideia**: Cada personagem é baseado num cogumélico, com suas habilidades refletindo sua personalidade, piadas internas ou alguma referência.

- **Atributos base**: Os personagens possuem atributos básicos como: `vida`, `mana`, `nível`, `resistência`, `velocidade`, `força`, `inteligência`, `fé`, `sorte`.

- **Atributos de resistência**: Os personagens vão possuir resistências a certos tipos de dano, sendo eles:
>| Atributos    | Cálculos   	|
>|-------------	|---------------            |
>| Física      	| Afetado pela força        |
>| Mágica      	| Afetado pela inteligência |
>| Fogo        	| Afetado pela resistência  |
>| Gelo        	| Afetado pela resistência  |
>| Veneno      	| Afetado pela resistência  |
>| Sangramento 	| Afetado pela resistência  |
>| Raio        	| Afetado pela velocidade  	|
>| Escuridão   	| Afetado pela fé  	        |
>| Divino      	| Afetado pela fé  	        |

- **Habilidades**: Cada personagens terá 4 habilidades exclusivas: passiva, habilidade 1, habilidade 2, suprema. Cada uma dessas habilidades é exclusiva de cada pessoa, referenciando alguma característica, piada interna ou referência. Os personagens também podem fazer um ataque normal, se defender e fugir. 

### Inimigos
> Descrever o funcionamento da IA do inimigo e explicar a classe modelo também

## MUNDO E HISTÓRIA

## ARTE E SOM
> A arte será em 2D e terá com base o jogo Duelyst

## INTERFACE DE USUÁRIO
> A interface vai ser baseada em final fantasy para combates e persona para diálogos

## NÍVEIS E MAPAS



