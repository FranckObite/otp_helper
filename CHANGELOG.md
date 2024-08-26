

## 0.0.3

- Updating the README.md file

## 0.0.2

### Bug Fixes

- **Resolved `setState() called after dispose()` error in `OtpPage`:**
  - Added checks to ensure `setState()` is only called if the widget is still mounted.
  - Ensured timers and listeners are properly canceled in the `dispose()` method to prevent memory leaks.
  - Updated the `OtpPage` class to handle state updates safely, preventing the error from occurring.

### Changes

- **Improved `OtpPage` class:**
  - Added `mounted` checks before calling `setState()` to ensure the widget is still in the widget tree.
  - Canceled timers and disposed of controllers and focus nodes in the `dispose()` method to avoid memory leaks.
  - Ensured that the OTP input fields and focus nodes are properly managed and updated.

### Notes

- This update addresses a critical issue that could cause the application to crash or behave unexpectedly when navigating away from the OTP verification screen.
- The changes ensure that the application remains stable and performs efficiently, even when the user interacts with the OTP input fields and navigates between screens.

## 0.0.1

- Initial release.
- Implémentation de la page de vérification OTP avec personnalisation des couleurs et gestion de la validation du code OTP.
- Ajout de la fonctionnalité de renvoi du code OTP après un délai d'attente.
- Support des traductions via une `Map<String, String>` pour permettre à l'utilisateur de définir les traductions.
- Ajout de la possibilité de définir le numéro de téléphone comme variable.
- Tests unitaires pour vérifier le bon fonctionnement de la page OTP.

