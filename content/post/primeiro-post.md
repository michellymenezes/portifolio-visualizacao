---
title: "Primeiro Post - Açude Epitácio Pessoa"
date: 2017-11-14T20:34:26-03:00
draft: false
---

# Uma análise sobre o Açude Epitácio Pessoa (Boqueirão)

O açude Epitácio Pessoa - mais conhecido como Açude de Boqueirão devido ao nome da cidade em que está localizado - é um dos principais do estado da Paraíba. A maior cidade que ele abastece é Campina Grande,
a segunda maior do estado, mas suas águas também são distribuídas para outros municípios.

Bem... esse primeiro post é sobre o Açude de Boqueirão que já passou por um período crise
hídrica e, no momento (2017), enfrenta sua segunda grande escassez. O volume está registrado
a partir de 1990 até o ano atual e os dados são fornecidos pelo [INSA](https://portal.insa.gov.br/).

## O açude em anos

Para poder ver e identificar os períodos de crise temos a visualização abaixo. O período da primeira
crise se inicia em 1998 e vai até 2003. A crise atual tem seu início apresentado no ano de 2014.

<div>
<div id="vis0" width=300></div>
<br>
</div>

#### Pontos interessantes ao comparar esses dois períodos:

* O início da primeira crise aparentemente foi repentino enquanto na segunda o volume percentual vai reduzindo aos poucos ao longo dos anos. Talvez isso tenha acontecido quando lançaram um novo e maior
valor correspondente ao tamanho do reservatório, sendo assim o volume relativo diminui.

* O volume percentual na primeira crise manteve sempre entre 20% e 40% aproximadamente, enquanto na
segunda esse valor só reduziu. Inúmeros fatores podem levar a esse comportamento como: grande tempo
de estiagem, maior gasto por parte da população (seja pelo aumento da mesma ou desperdício), altas
temperaturas e nível de evaporação da água, entre outros.

## O açude em meses

Agora temos uma visão um pouco mais detalhada do histórico do açude. No gráfico abaixo podemos
observar o nível do reservatório para cada mês dos anos.

Os meses em que a cor verde aparece mais escuras são geralmente de abril a julho. Esse período
caracteriza o outono e parte do inverno, é a época do ano com maiores volumes de chuva.
A partir de novembro é quando começamos a notar uma redução mais expressiva no volume percentual.

<div>
<div id="vis1" width=300></div>
<br>
</div>

Não é possível notar com tanta clareza, mas do início de 2017 até o mês atual a cor marrom apresenta
uma leve mudança de tonalidade para mais claro. Isso acontece devido a transposição do rio São Francisco.

#### Fato para refletir:

> A primeira crise hídrica durou 6 anos. Nós estamos completando o quinto ano desde o início da atual.
Passaremos então pelo menos mais um ano sem um volume considerável de chuva na região do açude?

## O açude em extremos

Pensando no comportamento do reservatório vemos agora o volume máximo e mínimo atingido em cada
ano. Na visualização abaixo o tamanho da barra representa a diferença entre os extremos dos anos.

<div>
<div id="vis2" width=300></div>
<br>
</div>

#### Com auxílio do gráfico apresentado no tópico anterior podemos chegar a algumas conclusões:

* De 1993 a 1994 o nível de água no açude apresentou um comportamento decrescente. O valor máximo
em janeiro de 1993 estava em torno de 82% chegando a cerca de 56% no fim do mesmo ano. No ano início
do ano seguinte o valor permaneceu o mesmo e continuou diminuindo até atingir pouco menos de 40%
em dezembro.

*  A grande barra em destaque representa o fim da primeira crise hídrica, quando após muitas chuvas
o volume saltou de 25 para 100% de seu volume abastecido.

* De 2012 até 2016 o comportamento é semelhante ao de 1993-1994, o nível de água só diminui. Observe
que com o passar dos anos a barra de diferença também vai reduzindo de tamanho, isso pode ser
reflexo do início do racionamento.

* **Em 2017 o nível máximo atingido não é mais igual ou inferior ao ano anterior, representando aí a
chegada das águas da transposição.**

*Por: Martha Michelly G M*


<script src="https://cdnjs.cloudflare.com/ajax/libs/vega/3.0.7/vega.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vega-lite/2.0.1/vega-lite.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vega-embed/3.0.0-rc7/vega-embed.js"></script>
<script>
    const spec0 = {
      "title": "Mediana do volume percentual ao longo dos anos",
      "$schema": "https://vega.github.io/schema/vega-lite/v2.json",
      "data": {
          "url": "https://api.insa.gov.br/reservatorios/12172/monitoramento",
          "format": {
          "type": "json",
          "property": "volumes",
          "parse": {
              "DataInformacao": "utc:'%d/%m/%Y'"
                  }
              }
          },
      "width": 550,

      "transform":[{
        "filter": {
          "timeUnit": "year",
          "field": "DataInformacao",
          "range": [1990, 2017]
          }
        }],

        "mark": {
          "type": "circle",     
          "size": 100
        },
        "encoding": {

          "x": {
              "timeUnit" : "year",
              "field": "DataInformacao",
              "type": "nominal",
              "axis": {"format": "%Y", "title" : "Anos"}
          },

          "y": {
            "field": "VolumePercentual",
            "type": "quantitative",
            "aggregate": "median",
            "axis":{"title": "Volume percentual"
            }
          },
          "color":{"value": "#66c2a5"    }
        }
      };
      vegaEmbed('#vis0', spec0).catch(console.warn);

</script>
<script>
    const spec1 = {   
      "title": "Mediana do volume percentual ao longo de meses e anos",
      "$schema": "https://vega.github.io/schema/vega-lite/v2.json",
      "data": {
          "url": "https://api.insa.gov.br/reservatorios/12172/monitoramento",
          "format": {
          "type": "json",
          "property": "volumes",
          "parse": {
              "DataInformacao": "utc:'%d/%m/%Y'"
                  }
              }
          },

      "width": 400,
      "mark": "rect",

      "encoding": {
          "x": {
              "timeUnit" : "year",
              "field": "DataInformacao",
              "type": "ordinal",
              "axis": {"format": "%Y", "title" : "Anos"}
          },
          "y": {
              "timeUnit" : "month",
              "field": "DataInformacao",
              "type": "ordinal",
              "axis": {"format": "%m", "title" : "Meses"}
              },
          "color": {
              "field": "VolumePercentual",
              "aggregate": "median",
              "type": "quantitative"
              }
      },
      "config": {
          "range": {
              "heatmap": {
                  "scheme": "brownbluegreen"
              }
          },
          "view": {
              "stroke": "transparent"
          }
      }
    };
      vegaEmbed('#vis1', spec1).catch(console.warn);

</script>

<script>
    const spec2 = {

      "$schema": "https://vega.github.io/schema/vega-lite/v2.json",
      "data": {
          "url": "https://api.insa.gov.br/reservatorios/12172/monitoramento",
          "format": {
          "type": "json",
          "property": "volumes",
          "parse": {
              "DataInformacao": "utc:'%d/%m/%Y'"
                  }
              }
          },
      "transform":[{"filter": {"timeUnit": "year", "field": "DataInformacao", "range": [1990, 2017] }}],

      "width": 550,

      "title": "Diferença do volume percentual máximo e mínimo ao longo dos anos",
      "mark": "rule",
      "encoding": {

      "x": {
          "timeUnit" : "year",
          "field": "DataInformacao",
          "type": "nominal",
          "axis": {"format": "%Y", "title" : "Anos"}
      },

      "y": {
        "field": "VolumePercentual",
        "type": "quantitative",
        "aggregate": "min",
        "axis":{"title": "Volume percentual"}

      },

      "y2": {
        "field": "VolumePercentual",
        "type": "quantitative",
        "aggregate": "max"
      },

        "color": {"value": "#9e765f"},
        "size": {"value": 5},
    }
  };
  vegaEmbed('#vis2', spec2).catch(console.warn);

</script>
