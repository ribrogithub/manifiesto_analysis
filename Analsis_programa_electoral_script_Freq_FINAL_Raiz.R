#------------------------------------------------#

# Cargamos librerías.
library(NLP)
library(stringr)
library(tm)

# Seleccionamos el directorio de trabajo donde están los programas electorales.
setwd("C:/Users/rbroca/Documents/R/Politico")

# Cargamos el archivo TXT.
Programa <- readLines("Ciudadanos_2019.txt")

# Convertimos el objeto anterior en matriz.
Programa_matriz <- Programa %>% as.matrix()

# Transformación y preparación del texto.
Programa_editado <- gsub("[[:cntrl:]]", " ", Programa_matriz)# Eliminamos caracteres de control, como ".
Programa_editado <- tolower(Programa_editado)# Todo a minúsculas.
Programa_editado <- removeWords(Programa_editado, words = stopwords("spanish")) # Eliminar palabras vacías.
Programa_editado <- removePunctuation(Programa_editado) # Elimina los signos de puntuación.
Programa_editado <- removeNumbers(Programa_editado) # Elimina los números.
Programa_editado <- stripWhitespace(Programa_editado) # Elimina los espacios superfluos.

# Creación del corpus de palabras.
Programa_corpus_palabra <- SimpleCorpus(VectorSource(Programa_editado))

# Raíz léxica y  corpus de lemas.
Programa_editado_Raiz <- stemDocument(Programa_editado, language="spanish")# Radicalizar las palabras
Programa_corpus_Raiz <- SimpleCorpus(VectorSource(Programa_editado_Raiz))

# Creación del TDM_palabra y TDM_lema.
Programa_tdm_palabra <- TermDocumentMatrix(Programa_corpus_palabra)
Programa_tdm_Raiz <- TermDocumentMatrix(Programa_corpus_Raiz)

# Cálculo de frecuencias.
  # Frecuencia de cada Palabra.
Programa_tdm_matriz_pal <- as.matrix(Programa_tdm_palabra)
Freq_Lexico_pal <- data.frame(Lexico = rownames(Programa_tdm_matriz_pal), 
                          Frecuencia = rowSums(Programa_tdm_matriz_pal), 
                          row.names = NULL)
  # Frecuencia de cada Raiz
Programa_tdm_matriz_Raiz <- as.matrix(Programa_tdm_Raiz)
Freq_Lexico_Raiz <- data.frame(Lexico = rownames(Programa_tdm_matriz_Raiz), 
                          Frecuencia = rowSums(Programa_tdm_matriz_Raiz), 
                          row.names = NULL)

# Creamos un archivo csv para guardar el resultado de las frecuencias.
write.csv(Freq_Lexico_pal, file = "Ciudadanos_2019_Freq_Pal34.csv")
write.csv(Freq_Lexico_Raiz, file = "Ciudadanos_2019_Freq_Lem34.csv")