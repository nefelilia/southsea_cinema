import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/booking.dart';

void main() {
  const Booking booking = Booking(
    bookingNumber: 1004,
    summary: '2 x Harry Potter and the Philosopher\'s Stone',
    total: 17.00,
    date: '01/01/2026 09:05',
  );

  test('New bookings omit database ids and convert to map', () {
    expect(booking.id, isNull);
    expect(booking.toMap(), <String, Object?>{
      'booking_number': 1004,
      'summary': '2 x Harry Potter and the Philosopher\'s Stone',
      'total': 17.00,
      'date': '01/01/2026 09:05',
    });
  });

  test('A database map converts back into a booking', () {
    final Map<String, Object?> row = <String, Object?>{
      'id': 7,
      'booking_number': 1010,
      'summary': '1 x Harry Potter and the Chamber of Secrets',
      'total': 9.50,
      'date': '02/01/2026 10:20',
    };

    final Booking restored = Booking.fromMap(row);

    expect(restored.id, 7);
    expect(restored.bookingNumber, 1010);
    expect(restored.summary,
        '1 x Harry Potter and the Chamber of Secrets');
    expect(restored.total, 9.50);
    expect(restored.date, '02/01/2026 10:20');
    expect(restored.toMap(), row);
  });

  test('Whole-number SQLite totals become doubles', () {
    final Map<String, Object?> row = booking.toMap();
    row['total'] = 17;

    final Booking restored = Booking.fromMap(row);

    expect(restored.total, 17.0);
    expect(restored.total, isA<double>());
  });
}