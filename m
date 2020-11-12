Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454852B0093
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Nov 2020 08:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKLHwx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Nov 2020 02:52:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:8426 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgKLHwx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Nov 2020 02:52:53 -0500
IronPort-SDR: DSq9kun6AhYKMLEcBYtpK3hbqHDOvkibm0/IlqCfRme/mTmfSoCOrNowICjFPCnAoo96Of6k1/
 t8j8PdbJYZdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="170380336"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="170380336"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 23:52:53 -0800
IronPort-SDR: 8WTu+PMi6n0LdfIKfIoufUy/K4Wnt6dw7OTvdgr5RxGAg9BC2fYPpt+CJugkhkTc6g8u6OXBTL
 dABtlw6jWbjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="366257240"
Received: from lkp-server02.sh.intel.com (HELO de5c6a867800) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2020 23:52:49 -0800
Received: from kbuild by de5c6a867800 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kd7PV-0000BI-8d; Thu, 12 Nov 2020 07:52:49 +0000
Date:   Thu, 12 Nov 2020 15:51:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS d196e229a80c39254f4adbc312f55f5198e98941
Message-ID: <5face998.yh5WqATqkjRidgSU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: d196e229a80c39254f4adbc312f55f5198e98941  Revert "ext4: fix superblock checksum calculation race"

elapsed time: 724m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       ebony_defconfig
m68k                          atari_defconfig
mips                        jmr3927_defconfig
sh                           se7206_defconfig
arm                            qcom_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
powerpc                     mpc512x_defconfig
sh                          lboxre2_defconfig
powerpc                     mpc5200_defconfig
arm                       aspeed_g4_defconfig
mips                        workpad_defconfig
sh                           se7712_defconfig
um                            kunit_defconfig
m68k                         apollo_defconfig
powerpc                    mvme5100_defconfig
powerpc                   lite5200b_defconfig
arm                       cns3420vb_defconfig
arm                        mvebu_v5_defconfig
csky                             alldefconfig
m68k                        m5307c3_defconfig
c6x                                 defconfig
sh                   secureedge5410_defconfig
mips                      pistachio_defconfig
ia64                      gensparse_defconfig
powerpc                     tqm8560_defconfig
arm                       mainstone_defconfig
xtensa                    xip_kc705_defconfig
arm                         at91_dt_defconfig
arc                 nsimosci_hs_smp_defconfig
c6x                        evmc6474_defconfig
powerpc                      makalu_defconfig
riscv                    nommu_k210_defconfig
sh                               allmodconfig
ia64                            zx1_defconfig
xtensa                  nommu_kc705_defconfig
sh                             sh03_defconfig
sh                         microdev_defconfig
arm                   milbeaut_m10v_defconfig
riscv                            allmodconfig
arm                         nhk8815_defconfig
sh                           se7705_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
arc                        vdk_hs38_defconfig
powerpc                    gamecube_defconfig
sh                          rsk7201_defconfig
sh                               j2_defconfig
riscv                            alldefconfig
mips                malta_qemu_32r6_defconfig
mips                   sb1250_swarm_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201112
x86_64               randconfig-a005-20201112
x86_64               randconfig-a004-20201112
x86_64               randconfig-a002-20201112
x86_64               randconfig-a006-20201112
x86_64               randconfig-a001-20201112
i386                 randconfig-a006-20201112
i386                 randconfig-a005-20201112
i386                 randconfig-a002-20201112
i386                 randconfig-a001-20201112
i386                 randconfig-a003-20201112
i386                 randconfig-a004-20201112
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
