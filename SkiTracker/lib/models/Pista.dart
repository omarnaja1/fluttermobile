class Pista {
  String nome = "N/A";
  String difficolta = "N/A";

  Pista(String nome, String difficolta) {
    this.nome = nome;
    this.difficolta = this.getItalianDifficulty(difficolta);
  }

  String getItalianDifficulty(String diff) {
    String difficolta = "N/A";

    switch(diff) {
      case 'novice':
        difficolta = "Novizio"; break;
      case 'easy':
        difficolta = "Facile"; break;
      case 'intermediate':
        difficolta = "Medio"; break;
      case 'advanced':
        difficolta = "Difficile"; break;
    }

    return difficolta;
  }

  String getDifficultyWithIndicator() {
    String difficolta = "❓ N/A";

    switch(this.difficolta) {
      case 'Novizio':
        difficolta = "⚪ Novizio"; break;
      case 'Facile':
        difficolta = "🔵 Facile"; break;
      case 'Medio':
        difficolta = "🔴 Medio"; break;
      case 'Difficile':
        difficolta = "⚫ Difficile"; break;
    }

    return difficolta;
  }
}