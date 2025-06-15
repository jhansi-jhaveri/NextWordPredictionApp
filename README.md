# Next Word Prediction using Natural Language Processing (NLP)

This project is the final capstone of the **Johns Hopkins University Data Science Specialization**. The goal is to develop a predictive text model that suggests the next word based on a user’s input, similar to what you see in smartphone keyboards.

## Overview
Using Natural Language Processing (NLP) and n-gram models, this app predicts the next word for a given phrase. It’s built in R using `shiny`, and trained on real-world English text data from blogs, news, and Twitter.

## Project Structure
NextWordPredictionApp/
├── app.R # Shiny app script
├── final/en_US/ # Contains the dataset (sample_data.txt)
├── R/
│ ├── clean_text.R # Text cleaning functions
│ ├── ngram_model.R # N-gram frequency table creation
│ └── predict_next.R # Word prediction logic
├── presentation/
│ └── NextWordPredictor.Rpres # Project presentation

## Dataset
The model is trained using the **SwiftKey dataset**, which includes:
- Blogs
- News articles
- Twitter posts

### Preprocessing steps include:
- Removing profanity, punctuation, numbers, and special characters
- Lowercasing all text
- Tokenizing text into unigrams, bigrams, and trigrams

## Prediction Algorithm
Implemented using a **back-off strategy**:
1. Trigram match → if not found, then
2. Bigram match → if not found, then
3. Most common unigram

## App Functionality
- Users input a phrase
- App predicts and displays the most likely next word in real time
- Built using R's `shiny` package
- Hosted on shinyapps.io

##  Try the App
(https://jhansi-jhaveri.shinyapps.io/NextWordPredictionApp/)

> https://rpubs.com/Jhansi-Jhaveri/1322411

## Skills Demonstrated
- Natural Language Processing (NLP)
- N-gram modeling
- Data cleaning and tokenization
- Shiny web application development
- R Presentation (`.Rpres`) for reporting

## Author
**Jhansi Jhaveri**  
Capstone project for the Johns Hopkins Data Science Specialization


