String formatArticleDate(String publishedAt) {
  try {
    final dt = DateTime.parse(publishedAt);
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}';
  } catch (_) {
    return '';
  }
}

String readTime(String text) {
  if (text.trim().isEmpty) return '1 min read';
  final words = text.trim().split(RegExp(r'\s+')).length;
  return '${(words / 200).ceil()} min read';
}
