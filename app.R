# Load libraries
library(shiny)
library(stringr)
library(tm)
library(tokenizers)

# Read and clean the text
text <- readLines("final/en_US/sample_data.txt", encoding = "UTF-8", warn = FALSE)
text <- tolower(text)
text <- str_replace_all(text, "http[[:alnum:]]*", "")
text <- removePunctuation(text)
text <- stripWhitespace(text)

# Tokenization and frequency tables
unigrams <- unlist(tokenize_ngrams(text, n = 1))
bigrams <- unlist(tokenize_ngrams(text, n = 2))
trigrams <- unlist(tokenize_ngrams(text, n = 3))

unigram_freq <- as.data.frame(table(unigrams))
colnames(unigram_freq) <- c("unigrams", "Freq")
unigram_freq <- unigram_freq[order(-unigram_freq$Freq), ]

bigram_freq <- as.data.frame(table(bigrams))
colnames(bigram_freq) <- c("bigrams", "Freq")
bigram_freq <- bigram_freq[order(-bigram_freq$Freq), ]

trigram_freq <- as.data.frame(table(trigrams))
colnames(trigram_freq) <- c("trigrams", "Freq")
trigram_freq <- trigram_freq[order(-trigram_freq$Freq), ]

# Prediction function
predict_next_word <- function(input_text) {
  input_text <- tolower(input_text)
  input_text <- removePunctuation(input_text)
  input_text <- stripWhitespace(input_text)
  words <- unlist(strsplit(input_text, " "))
  
  if (length(words) < 1) return("Please enter at least one word.")
  
  n <- length(words)
  
  # Trigram match
  if (n >= 2) {
    last_two <- paste(words[(n-1):n], collapse = " ")
    match_tri <- trigram_freq[grep(paste0("^", last_two, " "), trigram_freq$trigrams), ]
    if (nrow(match_tri) > 0) {
      predicted <- strsplit(as.character(match_tri$trigrams[1]), " ")[[1]][3]
      return(predicted)
    }
  }
  
  # Bigram match
  last_one <- words[n]
  match_bi <- bigram_freq[grep(paste0("^", last_one, " "), bigram_freq$bigrams), ]
  if (nrow(match_bi) > 0) {
    predicted <- strsplit(as.character(match_bi$bigrams[1]), " ")[[1]][2]
    return(predicted)
  }
  
  # Default to most common unigram
  return(as.character(unigram_freq$unigrams[1]))
}

# UI
ui <- fluidPage(
  titlePanel("Next Word Prediction using NLP"),
  sidebarLayout(
    sidebarPanel(
      textInput("text", "Enter your text:", value = ""),
      actionButton("predict", "Predict Next Word")
    ),
    mainPanel(
      h3("Predicted Next Word:"),
      verbatimTextOutput("prediction")
    )
  )
)

# Server
server <- function(input, output) {
  observeEvent(input$predict, {
    req(input$text)
    output$prediction <- renderText({
      predict_next_word(input$text)
    })
  })
}

# Run the app
shinyApp(ui = ui, server = server)
