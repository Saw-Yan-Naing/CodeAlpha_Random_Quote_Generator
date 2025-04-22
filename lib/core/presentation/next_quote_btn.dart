import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NextQuoteBtn extends HookWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const NextQuoteBtn({super.key, required this.isLoading, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    useEffect(() {
      if (isLoading) {
        controller.repeat(reverse: true);
      } else {
        controller.stop();
      }
      return null;
    }, [isLoading]);

    return MouseRegion(
      onEnter: (event) => controller.forward(),
      onExit: (event) => controller.reverse(),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Colors.white,
        shadowColor: Colors.blueGrey.withValues(alpha: .5),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          hoverColor: Theme.of(context).primaryColor.withValues(alpha: .2),
          onTap: () {
            if (onPressed != null) {
              onPressed?.call();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                isLoading
                    ? Container(
                      padding: const EdgeInsets.all(5),
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.blue,
                        strokeCap: StrokeCap.butt,
                      ),
                    )
                    : Row(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RotationTransition(
                          turns: controller,
                          child: const Icon(Icons.refresh, color: Colors.black),
                        ),

                        Text(
                          'Get New Quote',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
