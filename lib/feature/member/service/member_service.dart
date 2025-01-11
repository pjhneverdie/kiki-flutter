import 'package:injectable/injectable.dart';

import 'package:kiki/common/service/simple_service.dart';
import 'package:kiki/feature/member/model/member.dart';
import 'package:kiki/feature/member/repository/member_repository.dart';

@lazySingleton
class MemberService extends SimpleService {
  final MemberRepository _memberRepository;

  MemberService(this._memberRepository);

  Future<Member> getMember() async {
    return throwOrReturn(
      await _memberRepository.me(),
      expectedExceptionCodes: [],
    )!;
  }

  Future<void> deleteMember() async {
    return throwOrReturn(
      await _memberRepository.deleteMember(),
      expectedExceptionCodes: [],
    );
  }
}
