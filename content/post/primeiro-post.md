---
title: "Primeiro Post"
date: 2017-11-14T20:34:26-03:00
draft: false
---

# Uma análise sobre o Açude Epitácio Pessoa (Boqueirão)

<div id="vis0" width=300></div>
<div id="vis1" width=300></div>
<div id="vis2" width=300></div>


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
          "range": [1999, 2017]
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

asdasdasd
