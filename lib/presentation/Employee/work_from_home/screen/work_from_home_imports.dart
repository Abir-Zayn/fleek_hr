import 'package:fleekhr/common/widgets/app_bar.dart';
import 'package:fleekhr/common/widgets/appstyle.dart';
import 'package:fleekhr/common/widgets/apptext.dart';
import 'package:fleekhr/common/widgets/filtering_bottom_sheet.dart';
import 'package:fleekhr/core/components/unified_request_card.dart';
import 'package:fleekhr/core/service_locator.dart';
import 'package:fleekhr/domain/entities/auth/user_entity.dart';
import 'package:fleekhr/domain/entities/work_from_home/work_from_home_entity.dart';
import 'package:fleekhr/domain/usecase/auth/getuser_usecase.dart';
import 'package:fleekhr/presentation/Employee/work_from_home/cubit/work_from_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'work_from_home.dart';
