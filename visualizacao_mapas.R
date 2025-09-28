# Exemplo de mapa interativo
# obs: está ocorrendo um avio ao gerar o mapa devido ao tipo do shape utilizado pelo geobr, ainda não consegui resolver

# bibliotecas adicionais que serão necessárias
library(sf)
library(leaflet)
library(geobr)

# Criando o objeto com as informações dos novos empregos gerados por estado
saldo_estado <- caged %>%
  group_by(uf) %>%
  filter(uf != "Desconhecido") %>%
  summarise(saldo = sum(saldomovimentação, na.rm = TRUE)) %>%
  mutate(uf = fct_reorder(uf, saldo)) 

# Renomeando a coluna uf para ser compatível com a base da biblioteca geobr
saldo_estado <- saldo_estado %>%
  rename(abbrev_state = uf)

# Baixando a base com os poligonos (shape) dos estados do Brasil pela biblioteca geobr
estados <- read_state(code_state = "all")

# Juntando as duuas bases de dados para poder conter a informação do saldo (objeto que foi criado) e do shape dos estados
mapa_saldo <- left_join(estados, saldo_estado, by = "abbrev_state")

# Criando uma paleta de cores
# Obs: Utilizei a função colorBin pois gosto que fique mostrando os intervalos na legenda do mapa interativo
paleta_cores <- colorBin(
  palette = "RdYlBu",
  bins = c(-3000,-100,0,100,1000,2000,5000,10000,50000)
)

# Essa parte não é ESSENCIAL, porém gosto de adicionar pois deixa o mapa interativo mais interativo 
rotulos <- sprintf(
  "<strong>%s</strong><br/>Saldo: %s",
  mapa_saldo$name_state,
  format(mapa_saldo$saldo, big.mark = ".", decimal.mark = ",", nsmall = 0)
) %>% lapply(htmltools::HTML)

# Criando o objeto qontendo o Mapa
# Obs1: como foco não é a criação do mapa, não detalhei esta parte. Mas, penso em explicar como criar mapas o R Futuramente.
# Obs2: vai aparecer um erro por incompatibilidade de "tipo de shapefile lido" mas não interfere no resultado.
mapa_saldo <- leaflet(mapa_saldo) %>%
  addTiles() %>%  
  addPolygons(
    fillColor = ~paleta_cores(saldo), 
    weight = 2,                      
    opacity = 1,                     
    color = "black",                 
    dashArray = "1",                 
    fillOpacity = 0.7,               
    highlightOptions = highlightOptions( 
      weight = 3,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE
    ),
    label = rotulos,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto"
    )
  ) %>%
  addLegend( 
    pal = paleta_cores,
    values = ~saldo,
    opacity = 0.7,
    title = "Saldo de Movimentação",
    position = "bottomright"
  ) %>%
  addControl("<h3>Saldo de Movimentações por Estado</h3>", position = "topright")

# Exibindo o mapa qe foi criado
mapa_saldo
