import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sizer/sizer.dart';

// company edit about page hook consumer widget with app layout
class CompanyEditAbout extends HookConsumerWidget {
  const CompanyEditAbout({
    super.key,
    this.companyDetails,
  });
  final CompanyDetails? companyDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialDetails = useState(companyDetails);
    return AppLayout(
      mobile: _MobileCompanyEditAbout(
        companyDetails: initialDetails.value,
        companyDetailsNotifier: initialDetails,
        oldDetails: companyDetails,
      ),
      tablet: _TabletCompanyEditAbout(
        companyDetails: initialDetails.value,
        companyDetailsNotifier: initialDetails,
        oldDetails: companyDetails,
      ),
      desktop: _DesktopCompanyEditAbout(
        companyDetails: initialDetails.value,
        companyDetailsNotifier: initialDetails,
        oldDetails: companyDetails,
      ),
    );
  }
}

// mobile company edit about page
class _MobileCompanyEditAbout extends HookConsumerWidget {
  const _MobileCompanyEditAbout({
    this.companyDetails,
    this.companyDetailsNotifier,
    this.oldDetails,
  });
  final CompanyDetails? companyDetails;
  final ValueNotifier<CompanyDetails?>? companyDetailsNotifier;
  final CompanyDetails? oldDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // focus nodes
    final companyNameFocusNode = useFocusNode();
    final companyRegNoFocusNode = useFocusNode();
    final companySEOFocusNode = useFocusNode();
    final companyOverviewFocusNode = useFocusNode();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const DText(
            text: 'Edit About',
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              if (companyDetails != oldDetails) {
                Navigator.pop<CompanyDetails>(context, companyDetails);
              } else {
                Navigator.pop(context);
              }
            },
            icon: const LineIcon.arrowLeft(),
          ),
          pinned: true,
          actions: [
            IconButton(
              onPressed: () {
                // ref.read(companyGalleryProvider.notifier).addGallery(
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
            child: Form(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: companyDetails?.companyName,
                    focusNode: companyNameFocusNode,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      companyDetailsNotifier?.value =
                          companyDetails?.copyWith(companyName: value.trim());
                    },
                    onFieldSubmitted: (value) {
                      // change focus
                      companyRegNoFocusNode.requestFocus();
                      // companyNameFocusNode.unfocus();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Company Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: companyDetails?.registrationNumber,
                    focusNode: companyRegNoFocusNode,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      companyDetailsNotifier?.value = companyDetails?.copyWith(
                          registrationNumber: value.trim());
                    },
                    onFieldSubmitted: (value) {
                      // change focus
                      companySEOFocusNode.requestFocus();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Company Registration Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: companyDetails?.seoDescription,
                    focusNode: companySEOFocusNode,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      companyDetailsNotifier?.value = companyDetails?.copyWith(
                          seoDescription: value.trim());
                    },
                    maxLength: 500,
                    maxLines: 10,
                    minLines: 1,
                    onFieldSubmitted: (value) {
                      // change focus
                      companyOverviewFocusNode.requestFocus();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Company SEO Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: companyDetails?.overview,
                    focusNode: companyOverviewFocusNode,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      companyDetailsNotifier?.value =
                          companyDetails?.copyWith(overview: value.trim());
                    },
                    maxLength: 2000,
                    maxLines: 10,
                    minLines: 1,
                    onFieldSubmitted: (value) {
                      // remove focus
                      companyOverviewFocusNode.unfocus();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Company Overview',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// tablet company edit about page
class _TabletCompanyEditAbout extends HookConsumerWidget {
  const _TabletCompanyEditAbout({
    this.companyDetails,
    this.companyDetailsNotifier,
    this.oldDetails,
  });
  final CompanyDetails? companyDetails;
  final ValueNotifier<CompanyDetails?>? companyDetailsNotifier;
  final CompanyDetails? oldDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const DText(
            text: 'Company Edit About',
          ),
          automaticallyImplyLeading: false,
          pinned: true,
          actions: [
            IconButton(
              onPressed: () {
                // ref.read(companyGalleryProvider.notifier).addGallery(
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              DText(
                text: 'Company Edit About',
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// desktop company edit about page
class _DesktopCompanyEditAbout extends HookConsumerWidget {
  const _DesktopCompanyEditAbout({
    this.companyDetails,
    this.companyDetailsNotifier,
    this.oldDetails,
  });
  final CompanyDetails? companyDetails;
  final ValueNotifier<CompanyDetails?>? companyDetailsNotifier;
  final CompanyDetails? oldDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const DText(
            text: 'Company Edit About',
          ),
          automaticallyImplyLeading: false,
          pinned: true,
          actions: [
            IconButton(
              onPressed: () {
                // ref.read(companyGalleryProvider.notifier).addGallery(
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              DText(
                text: 'Company Edit About',
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
