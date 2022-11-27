import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:layout/layout.dart';
import 'package:sizer/sizer.dart';

class TextInfoCard extends HookConsumerWidget {
  const TextInfoCard({
    super.key,
    this.title,
    this.text,
    this.textCtrl,
    this.companyId,
    this.onTap,
  });
  final String? title;
  final String? text;
  final TextEditingController? textCtrl;
  final String? companyId;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final edit = useState(false);
    final expand = useState(false);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.breakpoint > LayoutBreakpoint.sm ? 1.5.w : 6.w,
        vertical: context.breakpoint > LayoutBreakpoint.sm ? 1.5.h : 2.h,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DText(
                text: title,
                textColor: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              const Spacer(),
              TextButton(
                onPressed: () => expand.value = !expand.value,
                style: TextButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.background.withOpacity(
                            0.2,
                          ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: DText(
                  text: expand.value == false ? 'Expand' : 'Collapse',
                  fontWeight: FontWeight.bold,
                  textColor: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          edit.value == true
              ? Form(
                  child: TextFormField(
                    controller: textCtrl,
                    maxLines: 10,
                    minLines: 1,
                    // build counter for max 150 words
                    maxLength: 1250,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: GoogleFonts.dosis(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      hintText: 'Enter Activity Description',
                    ),
                  ),
                )
              : DText(
                  text: text,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                  minFontSize: 16.0,
                  overflow:
                      expand.value == false ? TextOverflow.ellipsis : null,
                  maxLines: expand.value == false ? 3 : null,
                ),
        ],
      ),
    );
  }
}
