Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F395E3E3387
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Aug 2021 07:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhHGFI0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Aug 2021 01:08:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:46441 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhHGFI0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 7 Aug 2021 01:08:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="212624014"
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="212624014"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 22:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="672741272"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2021 22:08:08 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mCEZ5-000HYU-F2; Sat, 07 Aug 2021 05:08:07 +0000
Date:   Sat, 07 Aug 2021 13:07:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 877ba3f729fd3d8ef0e29bc2a55e57cfa54b2e43
Message-ID: <610e152e.X7eOGtHaS2/7xiBK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 877ba3f729fd3d8ef0e29bc2a55e57cfa54b2e43  ext4: fix potential htree corruption when growing large_dir directories

elapsed time: 723m

configs tested: 136
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210804
i386                 randconfig-c001-20210805
sparc                       sparc64_defconfig
sh                            migor_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                              alldefconfig
mips                malta_qemu_32r6_defconfig
sh                           se7343_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
mips                        workpad_defconfig
powerpc                          g5_defconfig
sh                        sh7785lcr_defconfig
arm                            mps2_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                    sam440ep_defconfig
powerpc                      mgcoge_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
mips                        jmr3927_defconfig
m68k                        m5307c3_defconfig
powerpc                        fsp2_defconfig
arm                      footbridge_defconfig
arm                           spitz_defconfig
powerpc                     stx_gp3_defconfig
arm                          gemini_defconfig
mips                       bmips_be_defconfig
parisc                           allyesconfig
s390                                defconfig
powerpc               mpc834x_itxgp_defconfig
sh                        edosk7760_defconfig
arm                           tegra_defconfig
microblaze                          defconfig
m68k                            q40_defconfig
arm                        multi_v7_defconfig
arc                        nsimosci_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210805
x86_64               randconfig-a006-20210805
x86_64               randconfig-a004-20210805
x86_64               randconfig-a003-20210805
x86_64               randconfig-a001-20210805
x86_64               randconfig-a005-20210805
i386                 randconfig-a005-20210804
i386                 randconfig-a004-20210804
i386                 randconfig-a002-20210804
i386                 randconfig-a006-20210804
i386                 randconfig-a003-20210804
i386                 randconfig-a001-20210804
i386                 randconfig-a005-20210805
i386                 randconfig-a004-20210805
i386                 randconfig-a002-20210805
i386                 randconfig-a006-20210805
i386                 randconfig-a003-20210805
i386                 randconfig-a001-20210805
x86_64               randconfig-a012-20210804
x86_64               randconfig-a016-20210804
x86_64               randconfig-a011-20210804
x86_64               randconfig-a013-20210804
x86_64               randconfig-a014-20210804
x86_64               randconfig-a015-20210804
i386                 randconfig-a012-20210806
i386                 randconfig-a011-20210806
i386                 randconfig-a015-20210806
i386                 randconfig-a013-20210806
i386                 randconfig-a014-20210806
i386                 randconfig-a016-20210806
i386                 randconfig-a012-20210805
i386                 randconfig-a011-20210805
i386                 randconfig-a015-20210805
i386                 randconfig-a013-20210805
i386                 randconfig-a014-20210805
i386                 randconfig-a016-20210805
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210804
x86_64               randconfig-c001-20210805
x86_64               randconfig-a002-20210804
x86_64               randconfig-a006-20210804
x86_64               randconfig-a004-20210804
x86_64               randconfig-a003-20210804
x86_64               randconfig-a001-20210804
x86_64               randconfig-a005-20210804
x86_64               randconfig-a012-20210805
x86_64               randconfig-a016-20210805
x86_64               randconfig-a011-20210805
x86_64               randconfig-a013-20210805
x86_64               randconfig-a014-20210805
x86_64               randconfig-a015-20210805

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
