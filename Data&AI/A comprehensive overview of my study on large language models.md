### A comprehensive overview of my study on large language models
#### The developmental process of large language models
- Data collection: Conduct extensive data collection of textual content, encompassing a wide range of sources such as books, news articles, social media posts, web pages, etc., with the purpose of training the model.
- Data preprocessing: the collected data undergo cleaning, word segmentation, stop word removal, and stemming to enhance the model's training effectiveness.
- Model design: Opt for an appropriate model architecture, such as Transformer, to facilitate the natural language processing of textual data.
- Model training: involves utilizing the collected data to facilitate the acquisition of rules and patterns within the text data by the model
- Model optimization: involves fine-tuning hyperparameters, implementing regularization techniques, leveraging pre-trained models, and other strategies to enhance performance and improve generalization capabilities.
- Model evaluation: entails the utilization of test data to comprehensively assess the performance and impact of the model.
- Model deployment: The trained model is deployed in a production environment for the purpose of natural language processing of textual data.

  <img width="564" alt="image" src="https://github.com/mingyu110/Best-Practice/assets/48540798/9d58efcf-951f-4779-88cf-5bbcf7b42d32">

#### Training of large language models
- Model Training
  The LLM model must first undergo pre-training on a substantial amount of unlabeled data, during which it can acquire the semantics of words, the grammatical structure of sentences, and the general knowledge and contextual information of text. Pre-training is essentially an unsupervised learning process, resulting in a Pretrained Model or Base Model with broad predictive capabilities. However, to effectively apply the pre-trained model in practical scenarios, fine-tuning is also necessary, encompassing both full fine-tuning and PEFT.
  - The process of fine-tuning involves adjusting all layers and parameters of a pre-trained large model to suit a specific task, utilizing a smaller learning rate and task-specific data. This approach maximizes the benefits derived from the shared characteristics of the pre-trained model, albeit at the cost of increased computational resources.
  - The PEFT (Parameter-Efficient Fine-Tuning) technology aims to enhance the performance of pre-trained models on novel tasks by minimizing the number of fine-tuning parameters and computational complexity, thereby reducing the training cost associated with pre-trained models. Additionally, leveraging the knowledge from pre-trained models enables rapid adaptation to new tasks and facilitates efficient transfer learning.
  - The PEFT technology encompasses LORA, QLoRA, Adapter Tuning, Prefix Tuning, Prompt Tuning, P-Tuning, and P-Tuning v2.
    ![image](https://github.com/mingyu110/Best-Practice/assets/48540798/17da3f1f-91e6-42d4-8647-f302cd190dc1)

#### The framework for training large language models
- Pytorch
  PyTorch is a deep learning framework that has been developed by Facebook's Artificial Intelligence Research team and is available as an open-source platform.One of the key advantages of PyTorch lies in its utilization of Dynamic Computation Graphs (DCGs), enabling runtime modification of graph behavior. This feature renders PyTorch highly flexible and advantageous when confronted with uncertainty or complexity, making it an ideal choice for research and prototyping purposes. Moreover, PyTorch provides a wide range of pre-trained models, including ResNet, VGG, Inception, SqueezeNet, EfficientNet, etc., showcasing its versatility. Additionally, PyTorch efficiently harnesses NVIDIA's CUDA library for GPU computing while also supporting distributed computing to facilitate model training across multiple GPUs or servers.
- TensorFlow
   The TensorFlow computing framework was officially open sourced by Google on November 9, 2015. It utilizes a static graph model for constructing and executing compute graphs. Prior to execution, static graphs require compilation and optimization, resulting in high performance but limited flexibility. TensorFlow offers a wide range of options and tools for distributed training, including tf.distribute.Strategy, enabling flexible implementation of distributed training.It also incorporates various APIs that can be utilized to construct a sophisticated deep learning architecture, such as a Convolutional Neural Network (CNN) or Recurrent Neural Network (RNN).

#### Distributed training framework for training large language models
(1) The deep learning frameworks are equipped with distributed training capabilities
- TensorFlow
  The TensorFlow distributed training methods primarily consist of three strategies: MirroredStrategy, MultiWorkerMirroredStrategy, and Horovod.
- PyTorch
  The distributed training methods in PyTorch primarily encompass DP (DataParallel), DDP (Distributed DataParallel), and Horovod.

(2) Enhance and expand the distributed training capabilities leveraging existing deep learning frameworks
- Megatron-LM（Nvidia）
  Megatron-LM is a large-scale Transformer language model training framework developed by NVIDIA's Applied Deep Learning research team, which supports model parallelism (tensor parallelism, sequence parallelism and pipelining parallelism) and multi-node pre-training. BERT, GPT, and T5 models are currently supported.
- DeepSpeed
  DeepSpeed is an open-source deep learning optimization library developed by Microsoft and built on top of PyTorch, aiming to enhance the efficiency and scalability of large-scale model training. It employs various techniques, including model parallelization, gradient accumulation, dynamic precision scaling, local pattern mixing accuracy, etc., to expedite training. Additionally, DeepSpeed offers tools such as distributed training management, memory optimization, and model compression to facilitate developers in effectively managing and optimizing extensive deep learning training tasks.
- FairScale
  The FairScale library (developed by Facebook) is a PyTorch extension that facilitates high-performance and large-scale training. It offers support for Fully Sharded Data Parallel (FSDP), ensuring optimal scalability and efficiency in training processes. FairScale's user-friendly API minimizes cognitive load, enabling users to easily comprehend and utilize its functionalities. Additionally, the modular design allows seamless integration of multiple FairScale APIs within the training cycle.

#### Inference of large language models
The LLM inference services prioritize two key performance indicators: throughput and latency.
The efficiency and performance of the model can be enhanced during the deployment phase through optimization techniques, including but not limited to:
- Computation: operator fusion and optimization of high-performance operators
- Graphic memory: KV Cache and Paged Attention
- Enhanced quantization techniques include low bit quantization with INT4/INT8 weight only, simultaneous quantization of weight and activation, KV cache quantization, and FP8 under the Hopper architecture
- Distributed computing techniques include tensor parallelism, pipeline parallelism, and optimization of NCCL communication
- Serving : Continuous Batching, Dynamic Batching , Async Serving
(1)Inference framework of large language models
- TensorFlow Serving
- Torch Serve
- ONNX Runtime
- TensorRT
(2)Distributed inference framework of large language models
- DeepSpeed Inference
- FasterTransformer
