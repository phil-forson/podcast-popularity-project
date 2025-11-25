# Podcast Sentiment & Popularity Analysis 🎙️

A Big Data analytics project investigating the relationship between **listener sentiment** (extracted via NLP) and **podcast popularity/ratings**. This project processes over **5 million reviews** to determine if positive text sentiment actually predicts "hit" podcasts.

## 🚀 Project Overview

**Goal:** Determine if AI-driven sentiment analysis of review text is a better predictor of podcast success than traditional star ratings.

**Key Findings:**

1.  **Sentiment vs. Ratings:** There is a moderate positive correlation (**0.38**) between text sentiment and star ratings, revealing a "Sentiment Gap" where users' written words don't always match their score.
2.  **The Popularity Curse:** A slight negative correlation (**-0.08**) exists between popularity and sentiment, suggesting massive audiences bring more critical reviews.
3.  **Predictive Power:** Using only review sentiment and volume, we can predict "High Performing" podcasts (>= 4.5 stars) with **~71% accuracy (AUC)**.

## 🛠️ Tech Stack

- **Processing:** Apache Spark (PySpark) for distributed data processing.
- **Database:** DuckDB for efficient local OLAP SQL queries on large JSON/Parquet files.
- **NLP/AI:** Hugging Face Transformers (`nlptown/bert-base-multilingual-uncased-sentiment`) for multilingual sentiment analysis.
- **Machine Learning:** Spark MLlib for Logistic Regression and feature engineering.
- **Visualization:** Pandas & Matplotlib (integrated in notebooks).

## 📂 Data Source

- **Dataset:** Podcast Reviews Dataset (5 Million+ Reviews)
- **Format:** JSON & Parquet
- _Note: Data files are not included in this repo due to size constraints._

## 📊 Methodology

1.  **Data Ingestion:** Loaded raw JSON data into Spark and persisted as Parquet tables for performance.
2.  **Data Cleaning:** Created "Virtual Metadata" by aggregating 5M reviews to bypass incomplete external metadata files.
3.  **Sentiment Analysis:**
    - Sampled reviews from podcasts with >20 reviews.
    - Applied a pre-trained **Multilingual BERT** model to score reviews (1-5 scale).
    - Handled mixed-language content (English, Spanish, Portuguese) effectively.
4.  **Modeling:** Built a Logistic Regression model to classify podcasts as "High Performing" based on their aggregated sentiment scores.

## 📓 How to Run

1.  **Prerequisites:** Docker, Python 3.9+, Java (for Spark).
2.  **Setup:**
    ```bash
    pip install pyspark duckdb transformers torch pandas
    ```
3.  **Run Analysis:**
    Open `notebooks/project.ipynb` and run all cells.
    - _Step 1:_ Loads data & creates virtual metadata.
    - _Step 2:_ Runs BERT sentiment pipeline (CPU/GPU).
    - _Step 3:_ Trains the predictive model.

## 📈 Results Snapshot

| Metric                                    | Result  | Interpretation                                         |
| :---------------------------------------- | :------ | :----------------------------------------------------- |
| **Correlation (Sentiment vs Rating)**     | `0.38`  | Positive link, but text reveals nuances ratings miss.  |
| **Correlation (Sentiment vs Popularity)** | `-0.09` | Larger audiences tend to be slightly more critical.    |
| **Model Accuracy (AUC)**                  | `0.71`  | AI sentiment is a strong predictor of podcast success. |

---

_Project for BUAN 6346 - Big Data Analytics (Fall 2025)_
