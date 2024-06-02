class ChatCompletionChunk {
  final String id;
  final String object;
  final int created;
  final String model;
  final String systemFingerprint;
  final List<Choice> choices;

  ChatCompletionChunk({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.systemFingerprint,
    required this.choices,
  });

  factory ChatCompletionChunk.fromJson(Map<String, dynamic> json) {
    return ChatCompletionChunk(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      systemFingerprint: json['system_fingerprint'],
      choices:
          List<Choice>.from(json['choices'].map((x) => Choice.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'created': created,
      'model': model,
      'system_fingerprint': systemFingerprint,
      'choices': List<dynamic>.from(choices.map((x) => x.toJson())),
    };
  }
}

class Choice {
  final int index;
  final Delta delta;
  final dynamic logprobs;
  final String? finishReason;

  Choice({
    required this.index,
    required this.delta,
    this.logprobs,
    this.finishReason,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      index: json['index'],
      delta: Delta.fromJson(json['delta']),
      logprobs: json['logprobs'],
      finishReason: json['finish_reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'delta': delta.toJson(),
      'logprobs': logprobs,
      'finish_reason': finishReason,
    };
  }
}

class Delta {
  final String? role;
  final String? content;

  Delta({
    this.role,
    this.content,
  });

  factory Delta.fromJson(Map<String, dynamic> json) {
    return Delta(
      role: json['role'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}
