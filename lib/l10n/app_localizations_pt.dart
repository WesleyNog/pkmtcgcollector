// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get language => 'português';

  @override
  String get colectionLabel => 'Coleção';

  @override
  String get pkmList => 'Lista de Pokémon';

  @override
  String get placeholders => 'Buscar Pokémon';

  @override
  String get hintPlaceholder => 'Pokémon Name';

  @override
  String get codeLabel => 'Cód';

  @override
  String get nameLabel => 'Nome';

  @override
  String get rarityLabel => 'Raridade';

  @override
  String get rate => 'Taxas';

  @override
  String get amountPokemon => 'Cartas';

  @override
  String get busterPack => 'Buster';

  @override
  String get clear => 'Limpar';

  @override
  String get noMetrics => 'Sem cartas obtidas!';

  @override
  String get totalsLabel => 'Totais';

  @override
  String get allLabel => 'Todos';

  @override
  String get bestPackLabel => 'Melhor \nBuster';

  @override
  String get newCards => 'Chance (%) - Novas Cartas';

  @override
  String get mew => 'Caminho Mew';

  @override
  String get help => 'Ajuda / Guia';

  @override
  String get introHelp => 'Guia e Informação';

  @override
  String get subIntroHelp => 'Todos precisam saber como funciona o app';

  @override
  String get update => 'Atualizações';

  @override
  String get updateNote_0 =>
      'Versão 1.0.0 em 01/01/2025:\n\nImplementação inicial de todas as funcionalidades como marcação das carta que possui e métricas do quão próxima está para concluir a coleção e/ou os desafios';

  @override
  String get info => 'Informação';

  @override
  String get infoNote_0 =>
      'Bem-vindo à nossa aplicação de gerenciamento de coleção de cartas Pokémon! Aqui você poderá organizar e acompanhar suas cartas de forma prática e eficiente. Abaixo, explicamos como utilizar cada funcionalidade disponível:';

  @override
  String get infoNote_1 =>
      '1. Marcando suas Cartas\nAo acessar a lista de cartas, você poderá visualizar todas as cartas disponíveis no jogo oficial. Para marcar uma carta como obtida, basta tocar sobre a caixa de verificação ao lado do pokémon correspondente. Você pode desmarcar a qualquer momento caso precise ajustar sua coleção.';

  @override
  String get infoNote_2 =>
      '2. Utilizando Filtros\nA lista de cartas pode ser filtrada para facilitar sua busca. Você pode aplicar filtros por:\n- Raridade: Selecione cartas comuns, raras ou lendárias.\n- Pacotes de Coleção: Escolha um conjunto específico de cartas.\n- Cartas Promocionais: Visualize apenas as cartas promocionais especiais.\nEsses filtros permitem uma navegação mais organizada e rápida dentro do aplicativo.';

  @override
  String get infoNote_3 =>
      '3. Acompanhando o Progresso da Coleção\nA aplicação disponibiliza uma tela de métricas onde você pode visualizar seu progresso na coleção através de gráficos interativos. Nessa tela, você encontrará:\n- Porcentagem de Busters Obtidos: Um gráfico exibindo o percentual de cartas que você já coletou em relação ao total disponível.\n- Desafios: Algumas missões personalizadas para incentivar sua coleção, como a obtenção da carta MEW na primeira coleção dentre outras mais.';

  @override
  String get infoNote_4 =>
      'Dicas Extras\n- Mantenha sua coleção sempre atualizada para acompanhar com precisão seu progresso.\n- Utilize os filtros para encontrar rapidamente as cartas que precisa.\n- Verifique frequentemente os desafios para motivar sua busca por novas cartas.';

  @override
  String get guid => 'Guia de Utilização';

  @override
  String get guidInfo_0 =>
      'As cores de fundo de cada card na lista represente cada buster, sendo estes até o momento:\n- Charizard: Representado pela cor Laranja\n- Pikachu: Representado pela cor Amarela\n- Mewtwo: Representado pela cor Liláz\n- Celebi: Representado pela cor Verde\n- Palkia: Representado pela cor Rosa\n- Dialga: Representado pela cor Azul\nLogo abaixo temos um exemplo que ilustra bem isso';

  @override
  String get guidInfo_1 =>
      'Na linha onde exibe as taxas, e exibido a porcentagem para cada lugar onde esta pode aparecer sendo estes:\n- 1-3: Taxa de aparecição nas três primeiras cartas\n- 4: Taxa de aparecição na quarta carta\n- 5: Taxa de aparecição na quinta carta';

  @override
  String get guidInfo_2 =>
      'Sobre o gráfico, este será preenchido a medida que as cartas forem marcadas para cada coleção, e será exibido o total obtido para cada buster, porém ao ultrapassar os 50% de cartas obtidas da coleção, será exibido também uma camada de cor cinza que representa o quanto resta para que seja completada toda a coleção.\n\nAo deslizar a tela para o lado, será exibido as demais coleções disponíveis até o momento com suas devidas informações.';
}
