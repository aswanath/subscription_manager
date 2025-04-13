import 'package:flutter_test/flutter_test.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';

void main() {
  group('subscription group model test', () {
    test('should hold correct name and subscriptions', () {
      final group = SubscriptionGroupModel('My Group', ['netflix', 'youtube']);

      expect(group.name, 'My Group');
      expect(group.subscriptions, ['netflix', 'youtube']);
    });

    test('should convert subscriptions to subscriptionModels correctly', () {
      final group = SubscriptionGroupModel('My Group', ['Spotify', 'Dribble']);

      final models = group.subscriptionModels;

      expect(models.length, 2);
      expect(models[0].name, 'Spotify');
      expect(models[1].name, 'Dribble');
    });

    test('should throw if subscription key is missing in AppConstants', () {
      final group = SubscriptionGroupModel('Test Group', ['unknown']);

      expect(
        () => group.subscriptionModels,
        throwsA(isA<TypeError>()),
      );
    });
  });
}
