import 'package:flutter_test/flutter_test.dart';
import 'package:news_blog_app/core/utils/formatters.dart';

void main() {
  group('formatArticleDate', () {
    test('parses a valid ISO 8601 date string', () {
      expect(formatArticleDate('2024-01-20T10:00:00Z'), 'Jan 20');
    });

    test('parses each month correctly', () {
      final cases = {
        '2024-01-01T00:00:00Z': 'Jan 1',
        '2024-02-05T00:00:00Z': 'Feb 5',
        '2024-03-15T00:00:00Z': 'Mar 15',
        '2024-04-30T00:00:00Z': 'Apr 30',
        '2024-05-09T00:00:00Z': 'May 9',
        '2024-06-21T00:00:00Z': 'Jun 21',
        '2024-07-04T00:00:00Z': 'Jul 4',
        '2024-08-11T00:00:00Z': 'Aug 11',
        '2024-09-22T00:00:00Z': 'Sep 22',
        '2024-10-31T00:00:00Z': 'Oct 31',
        '2024-11-11T00:00:00Z': 'Nov 11',
        '2024-12-25T00:00:00Z': 'Dec 25',
      };
      cases.forEach((input, expected) {
        expect(formatArticleDate(input), expected, reason: 'Failed for $input');
      });
    });

    test('returns empty string for an invalid date string', () {
      expect(formatArticleDate('not-a-date'), '');
    });

    test('returns empty string for an empty string', () {
      expect(formatArticleDate(''), '');
    });
  });

  group('readTime', () {
    test('returns "1 min read" for an empty string', () {
      expect(readTime(''), '1 min read');
    });

    test('returns "1 min read" for a whitespace-only string', () {
      expect(readTime('   '), '1 min read');
    });

    test('returns "1 min read" for a single word', () {
      expect(readTime('Hello'), '1 min read');
    });

    test('returns "1 min read" for exactly 200 words', () {
      final text = List.filled(200, 'word').join(' ');
      expect(readTime(text), '1 min read');
    });

    test('returns "2 min read" for 201 words', () {
      final text = List.filled(201, 'word').join(' ');
      expect(readTime(text), '2 min read');
    });

    test('returns "2 min read" for exactly 400 words', () {
      final text = List.filled(400, 'word').join(' ');
      expect(readTime(text), '2 min read');
    });

    test('returns "3 min read" for 401 words', () {
      final text = List.filled(401, 'word').join(' ');
      expect(readTime(text), '3 min read');
    });

    test('handles multiple spaces between words', () {
      expect(readTime('one   two   three'), '1 min read');
    });
  });

  group('todayLabel', () {
    test('returns a non-empty string', () {
      expect(todayLabel(), isNotEmpty);
    });

    test('contains the current day name', () {
      const days = [
        'Monday', 'Tuesday', 'Wednesday', 'Thursday',
        'Friday', 'Saturday', 'Sunday',
      ];
      final label = todayLabel();
      final today = days[DateTime.now().weekday - 1];
      expect(label, startsWith(today));
    });

    test('contains the current day number', () {
      final label = todayLabel();
      expect(label, contains(DateTime.now().day.toString()));
    });

    test('matches the expected format "Weekday, D Month"', () {
      final label = todayLabel();
      final pattern = RegExp(
        r'^(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday), \d{1,2} '
        r'(January|February|March|April|May|June|July|August|September|October|November|December)$',
      );
      expect(pattern.hasMatch(label), isTrue, reason: 'Label "$label" does not match expected format');
    });
  });
}
