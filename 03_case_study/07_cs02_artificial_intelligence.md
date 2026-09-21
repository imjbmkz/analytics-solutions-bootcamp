# Take-Home Case Study: News Topic Classification with Reuters Newswire

## Analytics Solutions Bootcamp — Artificial Intelligence Essentials

## Background

In this take-home exercise, you will work with the **Reuters Newswire dataset** and build a neural network that classifies news articles into topics.

Unlike the image classification exercise, the input to this model is **text**. Computers cannot directly process words in the same way people do, so the news articles must first be represented numerically before they can be passed through a neural network.

The Reuters dataset available through Keras contains newswire articles assigned to **46 different topics**.

This is **not intended to be a full natural language processing, machine learning, or exploratory data analysis case study**. The goal is simply to experience working with text data and understand how text can be represented, processed, and classified using a neural network.

---

## Objectives

By completing this case study, you should be able to:

1. Load and inspect text-based data.
2. Understand how words can be represented as numerical tokens.
3. Prepare variable-length text sequences for a neural network.
4. Use an Embedding layer to learn representations of words.
5. Build and train a simple neural network for text classification.
6. Observe training and validation performance.
7. Evaluate the model using unseen news articles.
8. Make at least one change to the neural network and observe its effect.
9. Use the trained model to predict the topic of individual news articles.

The emphasis is on **experimentation and understanding**, not achieving the highest possible classification accuracy.

---

# Dataset

Use the **Reuters Newswire dataset** available directly through Keras.

```python
from tensorflow import keras

(X_train, y_train), (X_test, y_test) = keras.datasets.reuters.load_data(
    num_words=10000
)
```

Setting:

```python
num_words=10000
```

means that the exercise will use the **10,000 most frequently occurring words** in the dataset.

The articles returned by Keras have already been converted into sequences of integer token IDs.

For example, an article may look conceptually like:

```text
[1, 275, 14, 22, 45, 643, 89, 17, ...]
```

These numbers represent words. They are **identifiers**, not measurements.

---

# Case Study Tasks

## 1. Load the Reuters Dataset

Load the training and test datasets.

Display:

- Number of training articles
- Number of test articles
- Shape of the training labels
- Shape of the test labels

Inspect the first training example:

```python
print(X_train[0])
print(y_train[0])
```

Briefly explain what the values in `X_train[0]` represent.

---

## 2. Convert a Sample Back to Words

The Reuters dataset provides a word index that can be used to approximately reconstruct an article.

Load the word index:

```python
word_index = keras.datasets.reuters.get_word_index()
```

Create a reverse lookup:

```python
reverse_word_index = {
    value + 3: key
    for key, value in word_index.items()
}

reverse_word_index[0] = "<PAD>"
reverse_word_index[1] = "<START>"
reverse_word_index[2] = "<OOV>"
reverse_word_index[3] = "<UNUSED>"
```

Then decode one article:

```python
decoded_article = " ".join(
    reverse_word_index.get(token, "?")
    for token in X_train[0]
)

print(decoded_article)
```

Compare:

```text
Token IDs
    ↓
[1, 275, 14, 22, ...]

Words
    ↓
"<START> ... news article ..."
```

The purpose of this step is to understand that the neural network receives **numbers representing words**, rather than raw text.

---

## 3. Inspect Article Lengths

News articles do not all contain the same number of words.

Check the length of a few articles:

```python
for article in X_train[:10]:
    print(len(article))
```

You may also calculate the average article length.

You do **not** need to perform extensive text exploration or EDA.

The purpose is simply to observe that text sequences can have different lengths.

---

# 4. Pad the Text Sequences

Neural networks typically process examples in batches with a consistent input shape.

Choose a maximum sequence length such as:

```python
max_length = 200
```

Then pad or truncate the articles:

```python
X_train_padded = keras.utils.pad_sequences(
    X_train,
    maxlen=max_length,
    padding="post",
    truncating="post"
)

X_test_padded = keras.utils.pad_sequences(
    X_test,
    maxlen=max_length,
    padding="post",
    truncating="post"
)
```

Inspect the resulting shape.

Conceptually:

```text
Article A: 120 tokens
Article B: 87 tokens
Article C: 350 tokens

          ↓ Padding / Truncation

Article A: 200 tokens
Article B: 200 tokens
Article C: 200 tokens
```

Briefly explain why padding is useful when training neural networks on text.

---

# 5. Build Your Baseline Neural Network

Start with the following architecture:

```python
from tensorflow.keras import layers

model = keras.Sequential([
    layers.Input(shape=(max_length,)),

    layers.Embedding(
        input_dim=10000,
        output_dim=64,
        mask_zero=True
    ),

    layers.LSTM(64),

    layers.Dropout(0.3),

    layers.Dense(
        46,
        activation="softmax"
    )
])
```

Use:

```python
model.summary()
```

to inspect the model.

Your baseline architecture follows this general flow:

```text
News Article
     ↓
Token IDs
     ↓
Padding / Truncation
     ↓
Embedding
     ↓
LSTM
     ↓
Dropout
     ↓
Dense — 46 outputs
     ↓
Predicted News Topic
```

---

# Understanding the New Layers

## Embedding Layer

The input contains token IDs such as:

```text
27
153
804
```

The numerical values themselves do not describe the meaning of the words.

The Embedding layer converts each token into a learned vector.

Conceptually:

```text
Token ID
   ↓
  153
   ↓
Embedding
   ↓
[0.14, -0.32, 0.81, ..., 0.05]
```

The embedding vectors are learned while the neural network is trained.

In the baseline model:

```python
layers.Embedding(
    input_dim=10000,
    output_dim=64
)
```

each of the 10,000 possible tokens can be represented using a learned vector containing **64 values**.

---

## LSTM Layer

LSTM stands for **Long Short-Term Memory**.

Unlike ordinary Dense layers, an LSTM processes a sequence while carrying information from earlier parts of that sequence.

Conceptually:

```text
"The"
  ↓
"company"
  ↓
"reported"
  ↓
"higher"
  ↓
"earnings"
  ↓
 LSTM
  ↓
Article Representation
```

This allows the model to learn patterns involving **word order and context**.

In the baseline model:

```python
layers.LSTM(64)
```

the article is summarized into a learned representation containing 64 values.

---

## Output Layer

The Reuters dataset contains 46 topic classes.

Therefore, the final layer is:

```python
layers.Dense(
    46,
    activation="softmax"
)
```

The model produces a probability for each possible topic.

Conceptually:

```text
Topic 0   → 0.01
Topic 1   → 0.03
Topic 2   → 0.74
...
Topic 45  → 0.01
```

The topic with the highest probability becomes the predicted class.

---

# 6. Compile the Model

Compile your model using:

```python
model.compile(
    optimizer="adam",
    loss="sparse_categorical_crossentropy",
    metrics=["accuracy"]
)
```

Briefly think about why this problem uses:

```text
46-output Softmax
```

instead of:

```text
1-output Sigmoid
```

---

# 7. Train the Model

Train the model using part of the training dataset for validation.

For example:

```python
history = model.fit(
    X_train_padded,
    y_train,
    validation_split=0.1,
    epochs=15,
    batch_size=64
)
```

You may reduce or increase the number of epochs depending on your available computing resources.

During training, observe:

- Training loss
- Training accuracy
- Validation loss
- Validation accuracy

The goal is not to extensively tune the model.

---

# 8. Visualize Training Results

Create two plots.

### Accuracy

Compare:

```text
Training Accuracy
vs.
Validation Accuracy
```

### Loss

Compare:

```text
Training Loss
vs.
Validation Loss
```

Briefly answer:

1. Did training accuracy improve over time?
2. Did validation accuracy improve?
3. Did you observe signs of overfitting?
4. Around which epoch did validation performance appear to stop improving?

Keep your interpretation concise.

---

# 9. Evaluate the Baseline Model

Evaluate the trained model using the test dataset.

```python
test_loss, test_accuracy = model.evaluate(
    X_test_padded,
    y_test
)
```

Record your result:

| Model | Test Accuracy |
|---|---:|
| Baseline LSTM | Your result |

This will serve as your baseline for the next experiment.

---

# 10. Inspect Predictions

Generate predictions for several test articles.

```python
predictions = model.predict(X_test_padded)
```

For an individual article:

```python
import numpy as np

predicted_class = np.argmax(predictions[0])
confidence = np.max(predictions[0])

print("Actual class:", y_test[0])
print("Predicted class:", predicted_class)
print("Confidence:", confidence)
```

For several examples, display:

- A portion of the decoded article
- Actual topic ID
- Predicted topic ID
- Prediction confidence

Include both correct and incorrect predictions if possible.

You are not required to manually interpret every Reuters topic.

---

# Model Improvement Experiment

Now modify your baseline neural network.

You are **not expected to find the best architecture**. The purpose is to change something about the network and observe what happens.

Choose at least **one** improvement.

---

## Option A — Increase the Embedding Size

Change:

```python
layers.Embedding(
    input_dim=10000,
    output_dim=64
)
```

to something such as:

```python
layers.Embedding(
    input_dim=10000,
    output_dim=128
)
```

Observe whether a larger learned representation of each word affects performance.

---

## Option B — Increase the LSTM Size

Change:

```python
layers.LSTM(64)
```

to:

```python
layers.LSTM(128)
```

Observe what happens to:

- Number of parameters
- Training time
- Training accuracy
- Validation accuracy

---

## Option C — Change Dropout

Try changing:

```python
layers.Dropout(0.3)
```

to:

```python
layers.Dropout(0.5)
```

Observe whether stronger regularization changes the difference between training and validation performance.

---

## Option D — Change the Sequence Length

Try changing:

```python
max_length = 200
```

to another value such as:

```python
max_length = 300
```

A longer sequence preserves more of each article but also requires the model to process more information.

Observe whether the additional text helps.

---

## Option E — Add a Dense Layer

After the LSTM, try:

```python
layers.Dense(
    64,
    activation="relu"
),
layers.Dropout(0.3),
layers.Dense(
    46,
    activation="softmax"
)
```

Observe whether adding another learned transformation improves the classifier.

---

## Option F — Add Early Stopping

Use EarlyStopping to stop training when validation performance is no longer improving.

For example:

```python
early_stopping = keras.callbacks.EarlyStopping(
    monitor="val_loss",
    patience=3,
    restore_best_weights=True
)
```

Then include it during training:

```python
history = model.fit(
    X_train_padded,
    y_train,
    validation_split=0.1,
    epochs=20,
    batch_size=64,
    callbacks=[early_stopping]
)
```

Observe which epoch is selected as the best model.

---

# 11. Compare Your Models

Compare your baseline and modified models.

For example:

| Model | Change | Test Accuracy |
|---|---|---:|
| Baseline | Embedding 64 + LSTM 64 | Your result |
| Modified | Embedding 128 + LSTM 64 | Your result |

Briefly discuss:

- What did you change?
- Why did you choose that change?
- Did performance improve, decline, or remain similar?
- Did training time change?
- What did you learn from the experiment?

There is **no requirement for the modified model to outperform the baseline**.

A model that performs worse is still a useful experiment if you can explain what you changed and what you observed.

---

# Optional Challenge

If you want to experiment further, explore one of the following:

### Bidirectional LSTM

```python
layers.Bidirectional(
    layers.LSTM(64)
)
```

This allows the network to process the sequence in both directions.

### Global Average Pooling

Instead of an LSTM, try a simpler architecture:

```python
layers.Embedding(
    input_dim=10000,
    output_dim=64
),
layers.GlobalAveragePooling1D(),
layers.Dense(
    64,
    activation="relu"
),
layers.Dense(
    46,
    activation="softmax"
)
```

Compare its training time and accuracy with your LSTM model.

These are optional experiments and are not required for submission.

---

# Required Submission

Submit a **Jupyter Notebook (`.ipynb`)** containing:

1. Reuters dataset loading
2. Inspection of tokenized articles
3. Decoding at least one article back into words
4. Sequence padding / truncation
5. Baseline neural network
6. Model training
7. Training and validation accuracy/loss plots
8. Baseline test evaluation
9. Sample predictions
10. At least one model improvement experiment
11. Baseline vs. modified model comparison
12. Short reflection

Use short Markdown explanations throughout your notebook so another person can understand what you did and what you observed.

---

# Short Reflection

At the end of your notebook, answer the following:

1. Why can't raw words be passed directly into the neural network?
2. What is the purpose of the Embedding layer?
3. What role does the LSTM play in processing an article?
4. What change did you make to the baseline model?
5. What happened after making the change?
6. What was the most interesting thing you learned from working with text and neural networks?

Keep your answers concise.

---

# Important Reminder

The objective of this exercise is **not** to build a production-quality news classifier or achieve the highest possible Reuters accuracy.

You are expected to experience the basic text neural-network workflow:

```text
News Articles
      ↓
Token IDs
      ↓
Pad / Truncate
      ↓
Embedding
      ↓
LSTM
      ↓
Train
      ↓
Validate
      ↓
Evaluate
      ↓
Predict
      ↓
Modify the Network
      ↓
Observe What Changes
```

Focus on understanding how **text becomes numerical input**, how the neural network processes sequences, and what happens when you modify the network.
