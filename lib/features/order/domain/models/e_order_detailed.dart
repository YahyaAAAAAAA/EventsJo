import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';

class EOrderDetailed {
  final EOrder order;
  final List<WeddingVenueMeal> meals;
  final List<WeddingVenueDrink> drinks;

  EOrderDetailed({
    required this.order,
    required this.meals,
    required this.drinks,
  });
}
