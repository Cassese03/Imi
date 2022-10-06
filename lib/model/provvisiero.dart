const String tableNotes = 'imi';

class imiField {
  static final List<String> values = [id, isImportant, number];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
}

class imi {
  final int? id;
  final bool isImportant;
  final int number;
  const imi({
    this.id,
    required this.isImportant,
    required this.number,
  });

  static imi fromJson(Map<String, Object?> json) => imi(
        id: json[imiField.id] as int?,
        isImportant: json[imiField.isImportant] == 1,
        number: json[imiField.number] as int,
      );

  Map<String, Object?> toJson() => {
        imiField.id: id,
        imiField.isImportant: isImportant ? 1 : 0,
        imiField.number: number,
      };

  imi copy({
    int? id,
    bool? isImportant,
    int? number,
  }) =>
      imi(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
      );
}
