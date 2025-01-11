part of 'package:kiki/feature/feed/view/save_feed_view/screen/save_feed_screen.dart';

class _DialogContent extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController _controller;
  final int? _maxLength;
  final String _hintText;
  final String? Function(String?)? _validator;

  const _DialogContent({
    required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    int? maxLength,
    required String hintText,
    String? Function(String?)? validator,
  })  : _validator = validator,
        _hintText = hintText,
        _maxLength = maxLength,
        _controller = controller,
        _formKey = formKey;

  @override
  Widget build(BuildContext context) {
    final Color textColor = useColorMode(
      context,
      context.colors.strongGray,
      context.colors.weakGray,
    );

    final Color hintTextColor = useColorMode(
      context,
      context.colors.weakGray,
      context.colors.weakGray,
    );

    final Color errorColor = useColorMode(
      context,
      Colors.orange,
      Colors.red,
    );

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controller,
            maxLength: _maxLength,
            validator: _validator,
            style: TextStyle(
              color: textColor,
              fontSize: 16.0.autoSizeSP,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText:  _hintText,
              hintStyle: TextStyle(
                color: hintTextColor,
                fontSize: 16.0.autoSizeSP,
                fontWeight: FontWeight.w500,
              ),
              counterStyle: TextStyle(
                color: textColor,
                fontSize: 12.0.autoSizeSP,
                fontWeight: FontWeight.w600,
              ),
              errorStyle: TextStyle(
                color: textColor,
                fontSize: 12.0.autoSizeSP,
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: hintTextColor,
                  width: 1.5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: hintTextColor,
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: errorColor,
                  width: 2,
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: errorColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
