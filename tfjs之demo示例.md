---
title: "Tfjs之demo示例"
description: ""
date: 2018-06-11T11:31:10+08:00
author: "uncoder"
tags: []
categories: ["机器学习"]
slug: ""
---

`polynomial-regression-core`中文注释翻译
<!--more-->

```javascript
import * as tf from '@tensorflow/tfjs';
import { generateData } from './data';
import { plotData, plotDataAndPredictions, renderCoefficients } from './ui';

/**
 * 我们想要学习给出以下三次方程的正确解的系数:
 *      y = a * x^3 + b * x^2 + c * x + d
 * 换句话说，我们想要学习价值:
 *      a
 *      b
 *      c
 *      d
 * 这样，这个函数在提供x时为y产生'所需输出'
 * 我们将提供一些'xs'和'ys'的例子，
 * 让这个模型能够学习我们所期望的输出是什么意思，
 * 然后用它来产生符合我们例子所暗示的曲线的y的新值。
 */


// Step 1.
// 设置变量，这些是我们想要的模型学习以便准确地进行预测，我们先通过随机值初始化他们。

const a = tf.variable(tf.scalar(Math.random()));
const b = tf.variable(tf.scalar(Math.random()));
const c = tf.variable(tf.scalar(Math.random()));
const d = tf.variable(tf.scalar(Math.random()));


// Step 2.
// 创建一个优化器，我们将在后面使用，您可以使用其中一些值来查看模型的表现。
// 使用随机梯度下降（SGD）作为我们的优化器
const numIterations = 75;
const learningRate = 0.5;
const optimizer = tf.train.sgd(learningRate);

// Step 3. 编写我们训练处理函数
/*
 * 这个函数代表我们的模型.
 * 给定一个输入'x'它将尝试并预测适当的输出'y'.
 * 它有时也被称为我们训练过程的“前进”步骤.
 * 虽然我们稍后将使用相同的函数进行预测.
 * @return number predicted y value
 */
function predict(x) {
  // y = a * x ^ 3 + b * x ^ 2 + c * x + d
  return tf.tidy(() => {
    return a.mul(x.pow(tf.scalar(3, 'int32')))
      .add(b.mul(x.square()))
      .add(c.mul(x))
      .add(d);
  });
}

/*
 * 这将告诉我们“预测”有多好，是我们实际预期的。
 * “预测”与我们预测的y值是一个张量。
 * labels是模型应该预测的y值的张量。
 */
function loss(prediction, labels) {
  // 具有良好的错误功能是训练机器学习模型的关键
  // 将预测值减去实际值（labels），然后再平方，
  // 最后取平均，得到均方误差
  const error = prediction.sub(labels).square().mean();
  return error;
}

/*
 * 这将迭代地训练我们的模型.
 *
 * xs - training data x values
 * ys — training data y values
 */
async function train(xs, ys, numIterations) {
  for (let iter = 0; iter < numIterations; iter++) {
    // optimizer.minimize 是进行训练的地方.
    // 它所使用的函数必须返回一个数值估计（即损失），
    // 说明我们使用当前在开始时创建的变量的当前状态的情况。
    // 这个优化器会对我们的训练过程进行“后退”步骤，
    // minimize方法自动更新之前定义使用的变量（a,b,c,d），
    // 以便将损失降至最低。
    optimizer.minimize(() => {
      // 将“示例（x以及对应的y）”输入到模型中
      const pred = predict(xs);
      return loss(pred, ys);
    });
    // 使用 tf.nextFrame 不阻塞浏览器.
    await tf.nextFrame();
  }
}

async function learnCoefficients() {
  const trueCoefficients = { a: -.8, b: -.2, c: .9, d: .5 };
  const trainingData = generateData(100, trueCoefficients);
  // 绘制原始数据
  renderCoefficients('#data .coeff', trueCoefficients);
  await plotData('#data .plot', trainingData.xs, trainingData.ys)

  // 用随机系数看看预测的结果
  renderCoefficients('#random .coeff', { a: a.dataSync()[0], b: b.dataSync()[0], c: c.dataSync()[0], d: d.dataSync()[0], });
  const predictionsBefore = predict(trainingData.xs);
  await plotDataAndPredictions('#random .plot', trainingData.xs, trainingData.ys, predictionsBefore);
  // 训练模型!
  await train(trainingData.xs, trainingData.ys, numIterations);

  // 看看训练后的最终结果预测。
  renderCoefficients('#trained .coeff', { a: a.dataSync()[0], b: b.dataSync()[0], c: c.dataSync()[0], d: d.dataSync()[0], });
  const predictionsAfter = predict(trainingData.xs);
  await plotDataAndPredictions('#trained .plot', trainingData.xs, trainingData.ys, predictionsAfter);

  predictionsBefore.dispose();
  predictionsAfter.dispose();
}


learnCoefficients();
```