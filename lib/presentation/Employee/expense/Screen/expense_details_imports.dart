import 'package:fleekhr/common/widgets/app_bar.dart';
import 'package:fleekhr/common/widgets/appbtn.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/data/models/expense/enums/expenseStatus.dart';
import 'package:fleekhr/domain/entities/expense/expense_entity.dart';
import 'package:fleekhr/presentation/Employee/expense/cubit/expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

part 'expense_details_screen.dart';
