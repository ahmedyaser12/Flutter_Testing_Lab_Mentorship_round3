import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/helper/shoping_cart_helper.dart';

void main() {
  group('ShoppingCart Tests', () {
    test(
      '1️⃣ Adding duplicate items should increase quantity (not create new entry)',
      () {
        final cart = ShoppingCartHelper();

        cart.addItem('1', 'Item 1', 10.0, 1);
        cart.addItem('1', 'Item 1', 10.0, 1);

        expect(
          cart.getItems().length,
          1,
          reason: 'Should have only one entry for the same product',
        );
        expect(
          cart.getItems().first.quantity,
          2,
          reason: 'Quantity should increase when adding the same item again',
        );
      },
    );

    test('2️⃣ Discount calculation should apply percentage correctly', () {
      final cart = ShoppingCartHelper();
      cart.addItem('1', 'Item 1', 100.0, 2, discount: 0.1); // 10% discount

      // subtotal = 100 * 2 = 200
      // discount = 200 * 0.1 = 20
      expect(cart.subtotal, 200.0);
      expect(
        cart.totalDiscount,
        closeTo(20.0, 0.01),
        reason: 'Total discount should be 10% of subtotal',
      );
    });

    test('3️⃣ Total amount should subtract discount, not add it', () {
      final cart = ShoppingCartHelper();
      cart.addItem('1', 'Item 1', 100.0, 1, discount: 0.1); // 10% off

      // subtotal = 100
      // discount = 10
      // total = 100 - 10 = 90
      expect(
        cart.totalAmount,
        closeTo(90.0, 0.01),
        reason: 'Total should equal subtotal minus discount',
      );
    });
    test('4️⃣ Remove item from cart should remove one by id', () {
      final cart = ShoppingCartHelper();
      cart.addItem('1', 'Item 1', 100.0, 1, discount: 0.1); // 10% off
      cart.addItem('2', 'Item 2', 200.0, 1, discount: 0.2); // 20% off
      cart.removeItem('1');
      for (var item in cart.getItems()) {
        expect(item.id == '1', false);
      }
    });

    test('5️⃣ Updating quantity below 1 removes item', () {
      final cart = ShoppingCartHelper();
      cart.addItem('1', 'Item', 50.0, 1);
      cart.updateQuantity('1', 6);
      expect(cart.getItems()[0].quantity, 6);
    });

    test('6️⃣ Clearing the cart removes all items', () {
      final cart = ShoppingCartHelper();
      cart.addItem('1', 'Item', 50.0, 2);
      cart.clearCart();
      expect(cart.getItems().isEmpty, true);
    });
  });
}
