import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maintenance/maintenance.dart';
import 'package:maintenance/model.dart';

import '../../../global.dart';
import '../../../util/screen.dart';

class RequestFormPage extends StatefulWidget {
  final Maintenance maintenanceApi;

  const RequestFormPage({Key? key, required this.maintenanceApi})
      : super(key: key);

  @override
  _RequestFormPageState createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  final formKey = GlobalKey<FormState>();
  RequestForm? form;
  bool _isSubmitting = false;

  Future<void> _fetchForm() async {
    form = await widget.maintenanceApi.form;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _fetchForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final form = this.form;

    Widget child;
    if (form == null) {
      child = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      final forms = <Widget>[
        TextFormField(
          maxLines: 4,
          maxLength: 200,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: LocaleKeys.Campus_MaintenanceNewDescription.tr(),
          ),
          onChanged: (v) => form.description = v,
          validator: (v) => v!.isNotEmpty
              ? null
              : LocaleKeys.Campus_MaintenanceErrorFormat.tr(),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Observer(
                builder: (_) => DropdownButtonFormField<String>(
                  hint: Text(LocaleKeys.Campus_MaintenanceNewBlock.tr()),
                  items: form.blocks
                      .map((u) => DropdownMenuItem(child: Text(u), value: u))
                      .toList(),
                  value: form.block,
                  onChanged: (v) => form.block = v,
                  validator: (v) => v != null && form.blocks.contains(v)
                      ? null
                      : LocaleKeys.Campus_MaintenanceErrorFormat.tr(),
                ),
              ),
            ),
            const VerticalDivider(),
            Expanded(
              child: Observer(
                builder: (_) => DropdownButtonFormField<String>(
                  hint: Text(LocaleKeys.Campus_MaintenanceNewWing.tr()),
                  items: form.wings
                      .map((u) => DropdownMenuItem(child: Text(u), value: u))
                      .toList(),
                  value: form.wing,
                  onChanged: (v) => form.wing = v,
                  validator: (v) => v != null && form.wings.contains(v)
                      ? null
                      : LocaleKeys.Campus_MaintenanceErrorFormat.tr(),
                ),
              ),
            ),
            const VerticalDivider(),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: LocaleKeys.Campus_MaintenanceNewRoom.tr(),
                ),
                onChanged: (v) => form.room = v,
                validator: (v) => v != null && v.isNotEmpty
                    ? null
                    : LocaleKeys.Campus_MaintenanceErrorFormat.tr(),
              ),
            )
          ],
        ),
        Observer(
          builder: (_) => DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: LocaleKeys.Campus_MaintenanceNewUsage.tr(),
            ),
            items: form.usages
                .map((u) => DropdownMenuItem(child: Text(u), value: u))
                .toList(),
            value: form.usage,
            onChanged: (v) => form.usage = v,
            validator: (v) => v != null && form.usages.contains(v)
                ? null
                : LocaleKeys.Campus_MaintenanceErrorFormat.tr(),
          ),
        ),
        Observer(
          builder: (_) => DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: LocaleKeys.Campus_MaintenanceNewCategory.tr(),
            ),
            items: form.categories
                .map((u) => DropdownMenuItem(child: Text(u), value: u))
                .toList(),
            value: form.category,
            onChanged: (v) => form.category = v,
            validator: (v) => v != null && form.categories.contains(v)
                ? null
                : LocaleKeys.Campus_MaintenanceErrorFormat.tr(),
          ),
        ),
        TextFormField(
          initialValue: form.phoneNumber,
          decoration: InputDecoration(
            labelText: LocaleKeys.Campus_MaintenanceNewContact.tr(),
          ),
          keyboardType: TextInputType.phone,
          onChanged: (v) => form.phoneNumber = v,
          validator: (v) => v != null && v.isNotEmpty
              ? null
              : LocaleKeys.Campus_MaintenanceErrorFormat.tr(),
        ),
        Observer(
          builder: (context) => CheckboxListTile(
            title: Text(LocaleKeys.Campus_MaintenanceNewRecurring.tr()),
            value: form.recurringProblem,
            onChanged: (v) => form.recurringProblem = v!,
          ),
        ),
        const Divider(height: 10, color: Colors.transparent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Observer(
              builder: (context) => FloatingActionButton(
                heroTag: 'camera',
                backgroundColor: Theme.of(context).canvasColor,
                tooltip:
                    'Campus.MaintenanceNew${form.file == null ? 'Add' : 'Delete'}Photo'
                        .tr(),
                child: Icon(
                  form.file == null ? Icons.camera : Icons.delete_outline,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () async {
                  if (form.file != null) {
                    form.file = null;
                    return;
                  }
                  final imageFile =
                      await ImagePicker().getImage(source: ImageSource.camera);
                  if (imageFile != null) form.file = File(imageFile.path);
                },
              ),
            ),
            FloatingActionButton(
              disabledElevation: 0,
              child: const Icon(Icons.check),
              onPressed: () async {
                if (!formKey.currentState!.validate() || _isSubmitting) return;
                _isSubmitting = true;
                await widget.maintenanceApi.submitForm(form);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ];

      child = Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: context.padBody,
          ),
          children: forms,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Campus_MaintenanceNew.tr()),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Hide when keyboard appears.
          // TODO: Platform
          // TODO: Overlap
          if (MediaQuery.of(context).viewInsets.bottom == 0)
            Positioned(
              right: 5,
              bottom: 10,
              child: SvgPicture.asset(
                'res/campus/maintenance.svg',
                width: MediaQuery.of(context).size.width / 3.3,
              ),
            ),
          child,
        ],
      ),
    );
  }
}