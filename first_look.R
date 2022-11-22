setwd("D:/projectLN/dea")

# Escolher as bibliotecas
library(dplyr)
library(tidytext)
library(janeaustenr)
library(stringr)
library(scales)
library(ggplot2)
library(forcats)
library(igraph)
library(tidyr)
library(widyr)
library(ggraph)
library(tm)


main_nt <- readLines("NT-121.2020-SRM.ANEEL.pdf.txt", encoding = 'UTF-8')
source("stop_words_br.R", encoding = 'LATIN1')
source("stop_words_br.R", encoding = 'UTF-8')

df_nt <- as.data.frame(main_nt) 
df_nt$main_nt <- removeNumbers(df_nt$main_nt)

colnames(df_nt)[1] <- "palavra"


nt_words <- df_nt |> 
  unnest_tokens(palavra, palavra) |>
  anti_join(stop_words_br) |>
  count(palavra, sort = TRUE)

colnames(df_nt)[1] <- "main_nt"

df_trab <- df_nt |>
  mutate(linha = row_number(),
         pagina = cumsum(str_detect(main_nt, 
                                    regex("^\\* A Nota Técnica",
                                          ignore_case = TRUE)))) |>
  ungroup() |>
  unnest_tokens(palavra, main_nt) |>
  anti_join(stop_words_br)
  
  
df_trab |>
  count(palavra, sort = TRUE) |>
  filter(n > 100) |>
  mutate(palavra = reorder(palavra, n)) |>
  ggplot(aes(n, palavra)) +
  geom_col() +
  labs(y = NULL)




nt_trigrams <- df_nt |>
  unnest_tokens(trigram, main_nt, token = "ngrams", n = 2) |>
  filter(!is.na(trigram))

trigrams_separated <- nt_trigrams |>
  separate(trigram, c("word1", "word2"), sep = " ")

trigrams_filtered <- trigrams_separated |>
  filter(!word1 %in% stop_words_br$palavra) |>
  filter(!word2 %in% stop_words_br$palavra)


trigrams_counts <- trigrams_filtered %>% 
  count(word1, word2, sort = TRUE)

trigrams_united <- trigrams_filtered %>%
  unite(trigram, word1, word2, sep = " ")


# gráfico 

trigram_graph <- trigrams_counts %>%
  filter(n > 20) %>%
  graph_from_data_frame()

set.seed(2017)
ggraph(trigram_graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)

set.seed(2020)

a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

ggraph(trigram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                 arrow = a, end_cap = circle(.07, 'inches')) +
  geom_node_point(color = "lightblue", size = 5) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
  theme_void()


#

files_section_words <- df_nt %>%
  mutate(section = row_number() %/% 10) %>%
  filter(section > 0) %>%
  unnest_tokens(palavra, main_nt) %>%
  filter(!palavra %in% stop_words_br$palavra)

file_pairs <- files_section_words %>%
  pairwise_count(palavra, section, sort = TRUE)

View(file_pairs)



file_cors <- files_section_words %>%
  group_by(palavra) %>%
  filter(n() >= 20) %>%
  pairwise_cor(palavra, section, sort = TRUE)

View(file_cors)


set.seed(1234)
file_cors %>%
  filter(correlation >= 0.8) %>%
  graph_from_data_frame() %>%
  ggraph(layout = "fr") +
  geom_edge_link(aes(edge_alpha = correlation, edge_width = correlation), edge_colour = "darkred") +
  geom_node_point(size = 5) +
  geom_node_text(aes(label = name), repel = TRUE, 
                 point.padding = unit(0.2, "lines")) +
  theme_void()
