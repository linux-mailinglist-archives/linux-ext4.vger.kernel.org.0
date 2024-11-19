Return-Path: <linux-ext4+bounces-5249-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 922229D1E4B
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2024 03:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AA2B23556
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2024 02:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4744642D;
	Tue, 19 Nov 2024 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jECky/lX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE178C76
	for <linux-ext4@vger.kernel.org>; Tue, 19 Nov 2024 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983471; cv=none; b=fMSaAZyh6uJz8lu4qPSEUEla1x7uMdis9SWIBjDPAtthx0zftLfJlvlXNiH5bBjO4Uhj5XRLJPLoYdMjkVLy+BphRcSbCygygQWdx47xTsa4lZowqUBmRxxH/ki+4YR+uz3WpX9TWSafsnSwnux2DXhtO2+CpEyrbHGxRmUqlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983471; c=relaxed/simple;
	bh=309xJU2K2GgCY//RnPXuMplD+PMybYXgBVhj3tDiWzU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fkQmRQBOyAOaF851mUdnmitG28feGuqOlIJp3nl1P/x/bsnE2huVJG6Hi4lTy/eR1ZcKdCGdf4C/Vav7wKWCH/x/y2sGgJ8fiRhy0QP8g26gZhsty9heTiVn1MY/jDYFnl8xEM8gUSNAD9OSZDq/72gcm7eGH+uzi7GqykLPvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jECky/lX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731983470; x=1763519470;
  h=date:from:to:cc:subject:message-id;
  bh=309xJU2K2GgCY//RnPXuMplD+PMybYXgBVhj3tDiWzU=;
  b=jECky/lX6f6NC4iocVwCwbR86OVlMp0nYUFn+OTMCADYy0amy6mgXwFE
   t7pYSfLtRrM1troP9pIpYyd7WRyrpdHynCnMOPLKX0wPNpZGGqP7ZRIzV
   9nBjMWkCQiDaziZ8saJ6wsGUT+9Sw0kcI5Qr2EJSKfwR9Uf8B9ih2MjEa
   SdGKRemQ7hsnFDKtNL9nNiS7q9eYEEKhJL50RJycY/iaDdChMsb0poMnx
   JKynCVC6Aj+mIN1YP2VTRu4FLSkKOHChWYjDoVcDtu+2K1Uc+Friy3YiN
   W9k1ZS/5PruDSVWkVWCpdI1a8ZaS0+6gBZ/e4PHuq8lfM9+PgcM5QsJC4
   A==;
X-CSE-ConnectionGUID: VOm9ZCmjS2e3Wa+TUX3tVw==
X-CSE-MsgGUID: HImBXh+8QYW09U+dgDValQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="49399520"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="49399520"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 18:31:09 -0800
X-CSE-ConnectionGUID: 52MynLGqTM2aAgEZ/riNDg==
X-CSE-MsgGUID: U64k5V/xTXamqYhP4w2KZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="120275960"
Received: from lkp-server02.sh.intel.com (HELO 2cc4542d09d4) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 18 Nov 2024 18:31:07 -0800
Received: from kbuild by 2cc4542d09d4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDE1B-000027-14;
	Tue, 19 Nov 2024 02:31:05 +0000
Date: Tue, 19 Nov 2024 09:46:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 f2af46ce2a4985e30910574b4b61c96b331aefbb
Message-ID: <202411190942.G5b8o6cR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: f2af46ce2a4985e30910574b4b61c96b331aefbb  Merge branch 'dev' into test

elapsed time: 723m

configs tested: 230
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    clang-15
arc                   randconfig-001-20241119    gcc-14.2.0
arc                   randconfig-002-20241119    gcc-14.2.0
arc                        vdk_hs38_defconfig    clang-20
arc                    vdk_hs38_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                        clps711x_defconfig    clang-15
arm                                 defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-20
arm                            hisi_defconfig    clang-20
arm                         lpc32xx_defconfig    clang-15
arm                         nhk8815_defconfig    clang-20
arm                             pxa_defconfig    clang-20
arm                   randconfig-001-20241119    gcc-14.2.0
arm                   randconfig-002-20241119    gcc-14.2.0
arm                   randconfig-003-20241119    gcc-14.2.0
arm                   randconfig-004-20241119    gcc-14.2.0
arm                       spear13xx_defconfig    clang-20
arm                        spear3xx_defconfig    clang-15
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241119    gcc-14.2.0
arm64                 randconfig-002-20241119    gcc-14.2.0
arm64                 randconfig-003-20241119    gcc-14.2.0
arm64                 randconfig-004-20241119    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241119    gcc-14.2.0
csky                  randconfig-002-20241119    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241119    gcc-14.2.0
hexagon               randconfig-002-20241119    gcc-14.2.0
i386                             alldefconfig    clang-20
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241118    gcc-12
i386        buildonly-randconfig-001-20241119    clang-19
i386        buildonly-randconfig-002-20241118    gcc-12
i386        buildonly-randconfig-002-20241119    clang-19
i386        buildonly-randconfig-003-20241118    clang-19
i386        buildonly-randconfig-003-20241119    clang-19
i386        buildonly-randconfig-004-20241118    clang-19
i386        buildonly-randconfig-004-20241119    clang-19
i386        buildonly-randconfig-005-20241118    gcc-12
i386        buildonly-randconfig-005-20241119    clang-19
i386        buildonly-randconfig-006-20241118    gcc-12
i386        buildonly-randconfig-006-20241119    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241118    gcc-12
i386                  randconfig-001-20241119    clang-19
i386                  randconfig-002-20241118    gcc-12
i386                  randconfig-002-20241119    clang-19
i386                  randconfig-003-20241118    gcc-12
i386                  randconfig-003-20241119    clang-19
i386                  randconfig-004-20241118    clang-19
i386                  randconfig-004-20241119    clang-19
i386                  randconfig-005-20241118    gcc-12
i386                  randconfig-005-20241119    clang-19
i386                  randconfig-006-20241118    gcc-12
i386                  randconfig-006-20241119    clang-19
i386                  randconfig-011-20241118    clang-19
i386                  randconfig-011-20241119    clang-19
i386                  randconfig-012-20241118    gcc-12
i386                  randconfig-012-20241119    clang-19
i386                  randconfig-013-20241118    gcc-12
i386                  randconfig-013-20241119    clang-19
i386                  randconfig-014-20241118    gcc-11
i386                  randconfig-014-20241119    clang-19
i386                  randconfig-015-20241118    clang-19
i386                  randconfig-015-20241119    clang-19
i386                  randconfig-016-20241118    gcc-12
i386                  randconfig-016-20241119    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241119    gcc-14.2.0
loongarch             randconfig-002-20241119    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                          hp300_defconfig    clang-15
m68k                       m5208evb_defconfig    clang-20
m68k                       m5249evb_defconfig    clang-20
m68k                       m5275evb_defconfig    clang-15
m68k                        m5307c3_defconfig    clang-20
m68k                            mac_defconfig    clang-20
m68k                        mvme147_defconfig    clang-20
m68k                            q40_defconfig    clang-20
m68k                          sun3x_defconfig    clang-15
m68k                           virt_defconfig    clang-15
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-20
mips                           gcw0_defconfig    clang-15
mips                       rbtx49xx_defconfig    clang-20
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241119    gcc-14.2.0
nios2                 randconfig-002-20241119    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241119    gcc-14.2.0
parisc                randconfig-002-20241119    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                       eiger_defconfig    clang-20
powerpc                     ep8248e_defconfig    clang-15
powerpc                     ep8248e_defconfig    clang-20
powerpc                          g5_defconfig    clang-20
powerpc                       holly_defconfig    clang-20
powerpc                      mgcoge_defconfig    clang-15
powerpc                 mpc836x_rdk_defconfig    clang-15
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                     ppa8548_defconfig    clang-15
powerpc               randconfig-001-20241119    gcc-14.2.0
powerpc               randconfig-002-20241119    gcc-14.2.0
powerpc               randconfig-003-20241119    gcc-14.2.0
powerpc                      tqm8xx_defconfig    clang-20
powerpc64             randconfig-001-20241119    gcc-14.2.0
powerpc64             randconfig-002-20241119    gcc-14.2.0
powerpc64             randconfig-003-20241119    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    clang-20
riscv                 randconfig-001-20241119    gcc-14.2.0
riscv                 randconfig-002-20241119    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241119    gcc-14.2.0
s390                  randconfig-002-20241119    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-20
sh                 kfr2r09-romimage_defconfig    clang-20
sh                    randconfig-001-20241119    gcc-14.2.0
sh                    randconfig-002-20241119    gcc-14.2.0
sh                           se7712_defconfig    clang-20
sh                           se7724_defconfig    clang-15
sh                        sh7763rdp_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241119    gcc-14.2.0
sparc64               randconfig-002-20241119    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    clang-15
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241119    gcc-14.2.0
um                    randconfig-002-20241119    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241119    gcc-12
x86_64      buildonly-randconfig-002-20241119    gcc-12
x86_64      buildonly-randconfig-003-20241119    gcc-12
x86_64      buildonly-randconfig-004-20241119    gcc-12
x86_64      buildonly-randconfig-005-20241119    gcc-12
x86_64      buildonly-randconfig-006-20241119    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241119    gcc-12
x86_64                randconfig-002-20241119    gcc-12
x86_64                randconfig-003-20241119    gcc-12
x86_64                randconfig-004-20241119    gcc-12
x86_64                randconfig-005-20241119    gcc-12
x86_64                randconfig-006-20241119    gcc-12
x86_64                randconfig-011-20241119    gcc-12
x86_64                randconfig-012-20241119    gcc-12
x86_64                randconfig-013-20241119    gcc-12
x86_64                randconfig-014-20241119    gcc-12
x86_64                randconfig-015-20241119    gcc-12
x86_64                randconfig-016-20241119    gcc-12
x86_64                randconfig-071-20241119    gcc-12
x86_64                randconfig-072-20241119    gcc-12
x86_64                randconfig-073-20241119    gcc-12
x86_64                randconfig-074-20241119    gcc-12
x86_64                randconfig-075-20241119    gcc-12
x86_64                randconfig-076-20241119    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                               rhel-9.4    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241119    gcc-14.2.0
xtensa                randconfig-002-20241119    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

