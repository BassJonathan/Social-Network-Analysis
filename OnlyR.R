#POC Skript

# install.packages("igraph", dependencies = T)
# install.packages("igraphdata", dependencies = T)
# install.packages("tidygraph", dependencies = T)
# install.packages("tidyverse", dependencies = T)
# install.packages("ggraph", dependencies = T)
# install.packages("ggthemes", dependencies = TRUE) # a collection of a lot of themes for dataviz!
# install.packages("gganimate", dependencies = TRUE) # an dynamic animation package
# install.packages("gifski", dependencies = TRUE) # an engine to render gifs
# install.packages("rnetcarto", dependencies = TRUE)

library(igraph)
library(igraphdata)

library(ggraph)
library(ggthemes)
library(gganimate)
library(gifski)

library(tidyverse)
library(tidygraph)

library(RColorBrewer)
library(rnetcarto)

rm(list = ls())

#Step 1
data("rfid")
rfid

#Step 2
df <- as.undirected(simplify(rfid))
df

#Step 3
df.mat=as_adjacency_matrix(df, sparse = F)
df.mat

#Step 4
rnc=netcarto(df.mat)
rnc

#Step 5
df %>% as_tbl_graph() %>% activate(nodes) %>% mutate(name = row_number()) -> klm
klm

#Step 6
test <- merge(x = klm , y = rnc[[1]], by = "name", all = TRUE)
test

#Step 7
ggplot(test, aes(y = connectivity, x = participation)) + geom_point(aes(color=Status, shape=role, size=module))

#Step 8
rect(xleft = 0.1, ybottom = -1.54, xright = 0.5, ytop = 0.99, col = NA, border = "orange", lwd = 2)
text(x = 0.3, y = 0.9, labels = "Peripherals", col = "orange")
rect(xleft = 0.1, ybottom = 1.01, xright = 0.5, ytop = 3.2, col = NA, border = "green", lwd = 2)
text(x = 0.3, y = 3.1, labels = "Stay in their communities", col = "green")
rect(xleft = 0.51, ybottom = -1.54, xright = 0.785, ytop = 1, col = NA, border = "blue", lwd = 2)
text(x = 0.65, y = 0.9, labels = "Connectors", col = "blue")
rect(xleft = 0.51, ybottom = 1.01, xright = 0.785, ytop = 3.2, col = NA, border = "red", lwd = 2)
text(x = 0.65, y = 3.1, labels = "Hubs", col = "red")
