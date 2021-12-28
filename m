Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D01480603
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Dec 2021 05:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhL1Eux (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Dec 2021 23:50:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:64147 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234750AbhL1Eux (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Dec 2021 23:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640667052; x=1672203052;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aiuxcONnj71aXEmgkYr2N1y/JXsnYBJg5uqF4Tlt6qA=;
  b=ib3yEYD8dJwbluBVJ+YK9h4/CwrqacQscE/vPKcMsYmPM38/lt7H56W3
   m2hJ3dzArEwnohodNoSyOkGtelQf9SyKOE/i9IA7rVha8qRgAMmERJixD
   YIFLBNp26XxmTvaqXu+kf+DZCP+rwhFDYAn9daE/hKDYc9ld7jOJhl/uv
   UF1qiToSUM5mxGubRzFyS16a+EDWe6saWGfUt9OK2t3zMbcdcPdS53s7y
   AMyLemHgTyvgiCQVB825IOhlskU8oMVXK6+Ry1THGxKE3kcZUoAJ6/fM0
   XRqS6owlzn5OF2WC26lC5108TVgSkUCHGHhr418lvR8/wt6ZX8EaZNbou
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="265539594"
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="265539594"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 20:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="486200656"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Dec 2021 20:50:50 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n24Rl-0007FD-RC; Tue, 28 Dec 2021 04:50:49 +0000
Date:   Tue, 28 Dec 2021 12:50:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [tytso-ext4:dev 15/32] fs/ext4/super.c:2173:1: warning: unused
 function 'ctx_clear_flags'
Message-ID: <202112281210.5KoelwNW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
head:   856dd2096e2a01f6eb2c9d60f6e0cd587aa273a8
commit: 4437992be7ca3ac5dd0a62cad10357112d4fb43e [15/32] ext4: remove lazyt=
ime/nolazytime mount options handled by MS_LAZYTIME
config: mips-buildonly-randconfig-r006-20211228 (https://download.01.org/0d=
ay-ci/archive/20211228/202112281210.5KoelwNW-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7171af=
744543433ac75b232eb7dfdaef7efd4d7a)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/co=
mmit/?id=3D4437992be7ca3ac5dd0a62cad10357112d4fb43e
        git remote add tytso-ext4 https://git.kernel.org/pub/scm/linux/kern=
el/git/tytso/ext4.git
        git fetch --no-tags tytso-ext4 dev
        git checkout 4437992be7ca3ac5dd0a62cad10357112d4fb43e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dmips SHELL=3D/bin/bash fs/ext4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/super.c:2173:1: warning: unused function 'ctx_clear_flags'
   EXT4_SET_CTX(flags);
   ^
   fs/ext4/super.c:2161:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline void ctx_clear_##name(struct ext4_fs_context ^
   <scratch space>:66:1: note: expanded from here
   ctx_clear_flags
   ^
   fs/ext4/super.c:2173:1: warning: unused function 'ctx_test_flags'
   fs/ext4/super.c:2167:34: note: expanded from macro 'EXT4_SET_CTX'
   static inline unsigned long ^
   <scratch space>:69:1: note: expanded from here
   ctx_test_flags
   ^
   fs/ext4/super.c:2176:1: warning: unused function 'ctx_clear_mount_flags'
   EXT4_SET_CTX(mount_flags);
   ^
   fs/ext4/super.c:2161:20: note: expanded from macro 'EXT4_SET_CTX'
   static inline void ctx_clear_##name(struct ext4_fs_context ^
   <scratch space>:90:1: note: expanded from here
   ctx_clear_mount_flags
   ^
   fs/ext4/super.c:2176:1: warning: unused function 'ctx_test_mount_flags'
   fs/ext4/super.c:2167:34: note: expanded from macro 'EXT4_SET_CTX'
   static inline unsigned long ^
   <scratch space>:93:1: note: expanded from here
   ctx_test_mount_flags
   ^
   fatal error: error in backend: Nested variants found in inline asm strin=
g: ' .set push
   .set mips64r2
   .if ( 0x00 ) !=3D -1)) 0x00 ) !=3D -1)) : ($( static struct ftrace_branc=
h_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_=
branch"))) __if_trace =3D $( .func =3D __func__, .file =3D "arch/mips/inclu=
de/asm/bitops.h", .line =3D 105, $); 0x00 ) !=3D -1)) : $))) ) && ( 0 ); .s=
et push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $1
   or $0, $2
   sc $0, $1
   beqz $0, 1b
   .set pop
   '
   PLEASE submit a bug report to https://bugs.llvm.org/ and include the cra=
sh backtrace, preprocessed source, and associated run script.
   Stack dump:
   0. Program arguments: clang -Wp,-MMD,fs/ext4/.super.o.d -nostdinc -Iarch=
/mips/include -I./arch/mips/include/generated -Iinclude -I./include -Iarch/=
mips/include/uapi -I./arch/mips/include/generated/uapi -Iinclude/uapi -I./i=
nclude/generated/uapi -include include/linux/compiler-version.h -include in=
clude/linux/kconfig.h -include include/linux/compiler_types.h -D__KERNEL__ =
-DVMLINUX_LOAD_ADDRESS=3D0xffffffff80100000 -DLINKER_LOAD_ADDRESS=3D0x80100=
000 -DDATAOFFSET=3D0 -Qunused-arguments -fmacro-prefix-map=3D=3D -DKBUILD_E=
XTRA_WARN1 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-st=
rict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-functio=
n-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Wno-format-secu=
rity -std=3Dgnu89 --target=3Dmipsel-linux -fintegrated-as -Werror=3Dunknown=
-warning-option -Werror=3Dignored-optimization-argument -mno-check-zero-div=
ision -mabi=3D32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_HAS_S=
ET_HARDFLOAT -Wa,-msoft-float -ffreestanding -EL -fno-stack-check -march=3D=
mips32 -Wa,--trap -DTOOLCHAIN_SUPPORTS_VIRT -Iarch/mips/include/asm/mach-au=
1x00 -Iarch/mips/include/asm/mach-generic -fno-asynchronous-unwind-tables -=
fno-delete-null-pointer-checks -Wno-frame-address -Wno-address-of-packed-me=
mber -Os -Wframe-larger-than=3D1024 -fstack-protector -Wimplicit-fallthroug=
h -Wno-gnu -mno-global-merge -Wno-unused-but-set-variable -Wno-unused-const=
-variable -ftrivial-auto-var-init=3Dzero -enable-trivial-auto-var-init-zero=
-knowing-it-will-be-removed-from-clang -fno-stack-clash-protection -pg -Wde=
claration-after-statement -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-st=
rict-overflow -fno-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-p=
ointer-types -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations =
-Wmissing-format-attribute -Wmissing-prototypes -Wold-style-definition -Wmi=
ssing-include-dirs -Wunused-but-set-variable -Wunused-const-variable -Wno-m=
issing-field-initializers -Wno-sign-compare -Wno-type-limits -I fs/ext4 -I =
=2E/fs/ext4 -ffunction-sections -fdata-sections -DKBUILD_MODFILE=3D"fs/ext4=
/ext4" -DKBUILD_BASENAME=3D"super" -DKBUILD_MODNAME=3D"ext4" -D__KBUILD_MOD=
NAME=3Dkmod_ext4 -c -o fs/ext4/super.o fs/ext4/super.c
   1. <eof> parser at end of file
   2. Code generation
   3. Running pass 'Function Pass Manager' on module 'fs/ext4/super.c'.
   4. Running pass 'Mips Assembly Printer' on function '@ext4_read_bh_nowai=
t'
   #0 0x000055a28effc39f Signals.cpp:0:0
   #1 0x000055a28effa2ec llvm::sys::CleanupOnSignal(unsigned long) (/opt/cr=
oss/clang-7171af7445/bin/clang-14+0x33fc2ec)
   #2 0x000055a28ef3df37 llvm::CrashRecoveryContext::HandleExit(int) (/opt/=
cross/clang-7171af7445/bin/clang-14+0x333ff37)
   #3 0x000055a28eff299e llvm::sys::Process::Exit(int, bool) (/opt/cross/cl=
ang-7171af7445/bin/clang-14+0x33f499e)
   #4 0x000055a28cc7ed1b (/opt/cross/clang-7171af7445/bin/clang-14+0x1080d1=
b)
   #5 0x000055a28ef449dc llvm::report_fatal_error(llvm::Twine const&, bool)=
 (/opt/cross/clang-7171af7445/bin/clang-14+0x33469dc)
   #6 0x000055a28fc22da8 llvm::AsmPrinter::emitInlineAsm(llvm::MachineInstr=
 const (/opt/cross/clang-7171af7445/bin/clang-14+0x4024da8)
   #7 0x000055a28fc1eb49 llvm::AsmPrinter::emitFunctionBody() (/opt/cross/c=
lang-7171af7445/bin/clang-14+0x4020b49)
   #8 0x000055a28d6d7f4e llvm::MipsAsmPrinter::runOnMachineFunction(llvm::M=
achineFunction&) (/opt/cross/clang-7171af7445/bin/clang-14+0x1ad9f4e)
   #9 0x000055a28e36d60d llvm::MachineFunctionPass::runOnFunction(llvm::Fun=
ction&) (.part.53) MachineFunctionPass.cpp:0:0
   #10 0x000055a28e7a6337 llvm::FPPassManager::runOnFunction(llvm::Function=
&) (/opt/cross/clang-7171af7445/bin/clang-14+0x2ba8337)
   #11 0x000055a28e7a64b1 llvm::FPPassManager::runOnModule(llvm::Module&) (=
/opt/cross/clang-7171af7445/bin/clang-14+0x2ba84b1)
   #12 0x000055a28e7a778f llvm::legacy::PassManagerImpl::run(llvm::Module&)=
 (/opt/cross/clang-7171af7445/bin/clang-14+0x2ba978f)
   #13 0x000055a28f30a44a clang::EmitBackendOutput(clang::DiagnosticsEngine=
&, clang::HeaderSearchOptions const&, clang::CodeGenOptions const&, clang::=
TargetOptions const&, clang::LangOptions const&, llvm::StringRef, clang::Ba=
ckendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<l=
lvm::raw_pwrite_stream> >) (/opt/cross/clang-7171af7445/bin/clang-14+0x370c=
44a)
   #14 0x000055a28ff37da3 clang::BackendConsumer::HandleTranslationUnit(cla=
ng::ASTContext&) (/opt/cross/clang-7171af7445/bin/clang-14+0x4339da3)
   #15 0x000055a290a3bcf9 clang::ParseAST(clang::Sema&, bool, bool) (/opt/c=
ross/clang-7171af7445/bin/clang-14+0x4e3dcf9)
   #16 0x000055a28ff36bff clang::CodeGenAction::ExecuteAction() (/opt/cross=
/clang-7171af7445/bin/clang-14+0x4338bff)
   #17 0x000055a28f935401 clang::FrontendAction::Execute() (/opt/cross/clan=
g-7171af7445/bin/clang-14+0x3d37401)
   #18 0x000055a28f8cd03a clang::CompilerInstance::ExecuteAction(clang::Fro=
ntendAction&) (/opt/cross/clang-7171af7445/bin/clang-14+0x3ccf03a)
   #19 0x000055a28f9fe46b (/opt/cross/clang-7171af7445/bin/clang-14+0x3e004=
6b)
   #20 0x000055a28cc7fa64 cc1_main(llvm::ArrayRef<char char (/opt/cross/cla=
ng-7171af7445/bin/clang-14+0x1081a64)
   #21 0x000055a28cc7cfab ExecuteCC1Tool(llvm::SmallVectorImpl<char driver.=
cpp:0:0
   #22 0x000055a28f76a0d5 void llvm::function_ref<void ()>::callback_fn<cla=
ng::driver::CC1Command::Execute(llvm::ArrayRef<llvm::Optional<llvm::StringR=
ef> >, std::__cxx11::basic_string<char, std::char_traits<char>, std::alloca=
tor<char> const::'lambda'()>(long) Job.cpp:0:0
   #23 0x000055a28ef3ddf3 llvm::CrashRecoveryContext::RunSafely(llvm::funct=
ion_ref<void ()>) (/opt/cross/clang-7171af7445/bin/clang-14+0x333fdf3)
   #24 0x000055a28f76a9ce clang::driver::CC1Command::Execute(llvm::ArrayRef=
<llvm::Optional<llvm::StringRef> >, std::__cxx11::basic_string<char, std::c=
har_traits<char>, std::allocator<char> const (.part.216) Job.cpp:0:0
   #25 0x000055a28f741557 clang::driver::Compilation::ExecuteCommand(clang:=
:driver::Command const&, clang::driver::Command const (/opt/cross/clang-717=
1af7445/bin/clang-14+0x3b43557)
   #26 0x000055a28f741f37 clang::driver::Compilation::ExecuteJobs(clang::dr=
iver::JobList const&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) const (/opt/cross/clang-7171af7445/bin/clang-14+0x3b43f37)
   #27 0x000055a28f74b799 clang::driver::Driver::ExecuteCompilation(clang::=
driver::Compilation&, llvm::SmallVectorImpl<std::pair<int, clang::driver::C=
ommand >&) (/opt/cross/clang-7171af7445/bin/clang-14+0x3b4d799)
   #28 0x000055a28cba819f main (/opt/cross/clang-7171af7445/bin/clang-14+0x=
faa19f)
   #29 0x00007f08b6be9d0a __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x26d0a)
   #30 0x000055a28cc7caca _start (/opt/cross/clang-7171af7445/bin/clang-14+=
0x107eaca)
   clang-14: error: clang frontend command failed with exit code 70 (use -v=
 to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 7171af744543433ac75b2=
32eb7dfdaef7efd4d7a)
   Target: mipsel-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-7171af7445/bin
   clang-14: note: diagnostic msg:
   Makefile arch fs include kernel nr_bisected scripts source usr


vim +/ctx_clear_flags +2173 fs/ext4/super.c

6e47a3cc68fc52 Lukas Czerner 2021-10-27  2172 =20
6e47a3cc68fc52 Lukas Czerner 2021-10-27 @2173  EXT4_SET_CTX(flags);
6e47a3cc68fc52 Lukas Czerner 2021-10-27  2174  EXT4_SET_CTX(mount_opt);
6e47a3cc68fc52 Lukas Czerner 2021-10-27  2175  EXT4_SET_CTX(mount_opt2);
6e47a3cc68fc52 Lukas Czerner 2021-10-27  2176  EXT4_SET_CTX(mount_flags);
6e47a3cc68fc52 Lukas Czerner 2021-10-27  2177 =20

:::::: The code at line 2173 was first introduced by commit
:::::: 6e47a3cc68fc525428297a00524833361ebbb0e9 ext4: get rid of super bloc=
k and sbi from handle_mount_ops()

:::::: TO: Lukas Czerner <lczerner@redhat.com>
:::::: CC: Theodore Ts'o <tytso@mit.edu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
