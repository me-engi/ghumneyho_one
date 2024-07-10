String numberToWords(int number) {
  if (number == 0) return 'zero';

  if (number < 0) return 'minus ${numberToWords(-number)}';

  final List<String> units = [
    '',
    'First',
    'Second',
    'Third',
    'Fourth',
    'Fifth',
    'Sixth',
    'seventh',
    'eighth',
    'nineth'
  ];

  final List<String> teens = [
    'tenth',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen'
  ];

  final List<String> tens = [
    '',
    '',
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety'
  ];

  final List<String> thousands = ['', 'thousand', 'million'];

  String convertLessThanThousand(int num) {
    String str = '';

    if (num % 100 < 20) {
      str = num % 100 < 10 ? units[num % 10] : teens[num % 100 - 10];
      num ~/= 100;
    } else {
      str = units[num % 10];
      num ~/= 10;

      str = tens[num % 10] + (str.isNotEmpty ? '-' : '') + str;
      num ~/= 10;
    }

    if (num == 0) return str;

    return units[num] + ' hundred' + (str.isNotEmpty ? ' and ' : '') + str;
  }

  String words = '';
  int thousandCounter = 0;

  while (number > 0) {
    if (number % 1000 != 0) {
      words = convertLessThanThousand(number % 1000) +
          ' ' +
          thousands[thousandCounter] +
          ' ' +
          words;
    }
    number ~/= 1000;
    thousandCounter++;
  }
  return words.trim().replaceAll(RegExp(' +'), ' ');
}
