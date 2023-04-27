class Card {
  late int uid;
  late String title;
  late String description;
  late bool isExpanded = true;

  Card({
    required this.uid,
    required this.title,
    required this.description,
    required this.isExpanded,
  });

  static List<Card> generateItems(int quantItems) {
    return List<Card>.generate(quantItems, (index) {
      return Card(
          uid: index + 1,
          title: 'Questao $index',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam porttitor rutrum tellus sed tincidunt. Integer egestas, tellus in rutrum porta, nunc justo rutrum nunc, ut mollis lectus velit at arcu. Suspendisse ipsum neque, venenatis vitae malesuada in, vehicula in ante. Donec quis mattis risus, maximus aliquam massa. Curabitur in viverra erat. Fusce ultrices mi eget nisl rhoncus, eget mattis libero imperdiet. Mauris porttitor, augue in egestas ullamcorper, libero neque congue ligula, ac lobortis velit elit eu arcu. Donec risus est, consectetur in volutpat quis, consectetur sed ex. Mauris eu porta quam.',
          isExpanded: true);
    });
  }
}
