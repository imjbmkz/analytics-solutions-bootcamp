# Take-Home Case Study: Image Classification with CIFAR-10

## Analytics Solutions Bootcamp — Artificial Intelligence Essentials

## Background

In the lecture and lab, you explored how neural networks can learn from images. For this take-home exercise, you will work with the **CIFAR-10** dataset and build a convolutional neural network (CNN) that recognizes objects in images.

CIFAR-10 contains small color images belonging to 10 classes:

- Airplane
- Automobile
- Bird
- Cat
- Deer
- Dog
- Frog
- Horse
- Ship
- Truck

This is **not intended to be a full machine learning or exploratory data analysis case study**. The main goal is to give you hands-on experience preparing image data, building a neural network, training it, observing its behavior, and making simple improvements to the model.

---

## Objectives

By completing this case study, you should be able to:

1. Load and inspect image data.
2. Understand the shape of RGB image inputs.
3. Prepare image data for a neural network.
4. Build and train a basic CNN.
5. Use training and validation results to observe model learning.
6. Evaluate the trained model using unseen test images.
7. Make at least one change to the neural network and observe its effect.
8. Use the model to predict the class of individual images.

The emphasis is on **experimentation and understanding**, not achieving the highest possible accuracy.

---

## Dataset

Use the **CIFAR-10 dataset** available directly through Keras.

```python
from tensorflow import keras

(X_train, y_train), (X_test, y_test) = keras.datasets.cifar10.load_data()
```

Each image has the shape:

```text
32 × 32 × 3
```

where:

- `32 × 32` represents the image height and width.
- `3` represents the RGB color channels: Red, Green, and Blue.

The dataset contains 10 possible image classes.

---

## Case Study Tasks

### 1. Load the CIFAR-10 Dataset

Load the training and test datasets using Keras.

Display:

- Shape of the training images
- Shape of the training labels
- Shape of the test images
- Shape of the test labels

Briefly explain what the dimensions of `X_train` represent.

---

### 2. Inspect Sample Images

Display at least **10 sample images**, preferably including examples from different classes.

For each displayed image, show its corresponding class name.

You do not need to perform extensive exploratory data analysis.

The purpose of this step is simply to understand what the neural network will receive as input.

---

### 3. Prepare the Images

Normalize the pixel values before training.

CIFAR-10 pixels originally have values from `0` to `255`.

Convert them to values between `0` and `1`.

Example:

```python
X_train = X_train.astype("float32") / 255.0
X_test = X_test.astype("float32") / 255.0
```

Briefly explain why normalization can help neural network training.

---

## 4. Build Your Baseline CNN

Start with the following architecture.

```python
from tensorflow import keras
from tensorflow.keras import layers

model = keras.Sequential([
    layers.Input(shape=(32, 32, 3)),

    layers.Conv2D(
        32,
        kernel_size=(3, 3),
        activation="relu",
        padding="same"
    ),
    layers.MaxPooling2D(pool_size=(2, 2)),

    layers.Conv2D(
        64,
        kernel_size=(3, 3),
        activation="relu",
        padding="same"
    ),
    layers.MaxPooling2D(pool_size=(2, 2)),

    layers.Flatten(),

    layers.Dense(
        128,
        activation="relu"
    ),

    layers.Dropout(0.3),

    layers.Dense(
        10,
        activation="softmax"
    )
])
```

Use `model.summary()` and inspect how the image representation changes as it passes through the network.

Your baseline architecture follows this general flow:

```text
32 × 32 × 3 RGB Image
        ↓
Conv2D — 32 filters
        ↓
Max Pooling
        ↓
Conv2D — 64 filters
        ↓
Max Pooling
        ↓
Flatten
        ↓
Dense — 128 neurons
        ↓
Dropout — 30%
        ↓
Dense — 10 outputs
        ↓
Predicted Image Class
```

---

## 5. Compile the Model

Compile your model using an appropriate optimizer and loss function.

You may start with:

```python
model.compile(
    optimizer="adam",
    loss="sparse_categorical_crossentropy",
    metrics=["accuracy"]
)
```

Think about why the final layer uses:

```python
layers.Dense(10, activation="softmax")
```

instead of a single sigmoid output.

---

## 6. Train the Model

Train the network using part of the training data for validation.

For example:

```python
history = model.fit(
    X_train,
    y_train,
    validation_split=0.1,
    epochs=15,
    batch_size=64
)
```

You may adjust the number of epochs if needed based on your available computing resources.

During training, observe:

- Training loss
- Training accuracy
- Validation loss
- Validation accuracy

You do not need to extensively tune the model.

---

## 7. Visualize the Training Results

Create plots showing:

### Accuracy

```text
Training Accuracy
vs.
Validation Accuracy
```

### Loss

```text
Training Loss
vs.
Validation Loss
```

Based on the plots, briefly answer:

1. Did the model improve as training progressed?
2. Did you observe signs of overfitting?
3. Around which epoch did validation performance appear to stop improving?

Keep your interpretation short and focused on what you observed.

---

## 8. Evaluate the Baseline Model

Evaluate the trained model using the test dataset.

```python
test_loss, test_accuracy = model.evaluate(
    X_test,
    y_test
)
```

Record your baseline:

| Model | Test Accuracy |
|---|---:|
| Baseline CNN | Your result |

The purpose is to establish a reference point for your experiment.

---

## 9. Inspect Predictions

Select several test images and ask the model to predict their classes.

Display:

- Image
- Actual class
- Predicted class
- Prediction confidence

Include examples that the model classified correctly and, if possible, examples it classified incorrectly.

Consider whether some mistakes are understandable based on the appearance of the images.

---

# Model Improvement Experiment

Now modify your baseline CNN.

You are **not expected to find the best possible architecture**. The purpose is to experiment with neural network design and observe what happens.

Choose at least **one** improvement.

## Suggested Experiments

### Option A — Add Another Convolutional Layer

Try increasing the network's ability to learn more complex image features.

For example:

```python
layers.Conv2D(
    128,
    kernel_size=(3, 3),
    activation="relu",
    padding="same"
),
layers.MaxPooling2D(pool_size=(2, 2))
```

---

### Option B — Increase the Number of Filters

Experiment with more filters.

For example:

```text
Baseline:
32 → 64

Experiment:
32 → 64 → 128
```

Observe whether additional feature maps improve performance.

---

### Option C — Change the Dense Layer

Try changing:

```python
layers.Dense(128, activation="relu")
```

to another size such as:

```python
layers.Dense(256, activation="relu")
```

Observe how this affects the number of trainable parameters and model performance.

---

### Option D — Change Dropout

Try changing:

```python
layers.Dropout(0.3)
```

to another value such as:

```python
layers.Dropout(0.5)
```

Observe whether stronger regularization affects training and validation performance.

---

### Option E — Add Data Augmentation

Images can be slightly transformed while still representing the same object.

You may experiment with layers such as:

```python
data_augmentation = keras.Sequential([
    layers.RandomFlip("horizontal"),
    layers.RandomRotation(0.1),
    layers.RandomZoom(0.1)
])
```

Use the augmented images during training and observe whether the model generalizes better to unseen images.

---

### Option F — Add Early Stopping

You may use EarlyStopping to stop training when validation performance is no longer improving.

For example:

```python
early_stopping = keras.callbacks.EarlyStopping(
    monitor="val_loss",
    patience=3,
    restore_best_weights=True
)
```

Remember to include the callback when calling `model.fit()`.

---

## 10. Compare Your Models

Compare your baseline model against your modified model.

For example:

| Model | Architecture / Change | Test Accuracy |
|---|---|---:|
| Baseline CNN | 32 → 64 filters | Your result |
| Modified CNN | 32 → 64 → 128 filters | Your result |

Briefly discuss:

- What did you change?
- Why did you choose that change?
- Did performance improve, decline, or remain similar?
- What did you learn from the experiment?

There is no requirement for your modified model to outperform the baseline.

**A model that performs worse can still be a successful experiment if you can explain what you changed and what you observed.**

---

# Optional Challenge

If you want to experiment further, try using your trained model on an image that is **not part of CIFAR-10**.

You may:

1. Find or take an image representing one of the CIFAR-10 classes.
2. Resize it to `32 × 32`.
3. Ensure it has 3 RGB channels.
4. Normalize its pixel values.
5. Pass it to your model.
6. Observe the predicted class and confidence.

Consider why predictions on your own images may be less accurate than predictions on CIFAR-10 test images.

---

# Required Submission

Submit a **Jupyter Notebook (`.ipynb`)** containing:

1. Dataset loading
2. Sample image visualization
3. Image preparation / normalization
4. Baseline CNN architecture
5. Model training
6. Training and validation accuracy/loss plots
7. Baseline test evaluation
8. Sample image predictions
9. At least one model improvement experiment
10. Baseline vs. modified model comparison
11. Short reflection

Your notebook should contain short Markdown explanations so another person can understand what you did and what you observed.

---

# Short Reflection

At the end of your notebook, answer the following:

1. What happens to an image as it passes through the convolutional and pooling layers?
2. What did your CNN appear to learn during training?
3. What change did you make to your baseline architecture?
4. What happened after making the change?
5. What was the most interesting thing you learned from working with image data and neural networks?

Keep your answers concise.

---

## Important Reminder

The objective of this exercise is **not** to achieve state-of-the-art CIFAR-10 accuracy.

You are expected to experience the complete neural network workflow:

```text
Images
  ↓
Prepare Images
  ↓
Build CNN
  ↓
Train
  ↓
Validate
  ↓
Evaluate
  ↓
Predict
  ↓
Modify Architecture
  ↓
Observe What Changes
```

Focus on understanding what happens at each stage and experimenting with the network.
