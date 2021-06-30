Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B083B85C3
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 17:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbhF3PKW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 11:10:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:63806 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235504AbhF3PKV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 11:10:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="230005718"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="230005718"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 08:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="420028100"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2021 08:07:51 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyboc-0009pY-LA; Wed, 30 Jun 2021 15:07:50 +0000
Date:   Wed, 30 Jun 2021 23:07:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD REGRESSION
 d578b99443fde0968246cc7cbf3bc3016123c2f4
Message-ID: <60dc8895.dA7DgIsiOXrH+dTl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: d578b99443fde0968246cc7cbf3bc3016123c2f4  ext4: notify sysfs on errors_count value change

Error/Warning reports:

https://lore.kernel.org/linux-ext4/202106301543.8S1z2hfe-lkp@intel.com

Error/Warning in current branch:

ERROR: modpost: "jbd2_journal_register_shrinker" undefined!
ERROR: modpost: "jbd2_journal_unregister_shrinker" undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- xtensa-randconfig-s032-20210628
    |-- ERROR:jbd2_journal_register_shrinker-undefined
    `-- ERROR:jbd2_journal_unregister_shrinker-undefined

elapsed time: 724m

configs tested: 161
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0219_defconfig
mips                         db1xxx_defconfig
sh                               j2_defconfig
arm                          badge4_defconfig
powerpc                        icon_defconfig
sh                     magicpanelr2_defconfig
arm                  colibri_pxa300_defconfig
powerpc64                           defconfig
mips                            gpr_defconfig
powerpc                      ppc44x_defconfig
powerpc                      chrp32_defconfig
parisc                              defconfig
arm                            mmp2_defconfig
arm                         palmz72_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc885_ads_defconfig
arm                            zeus_defconfig
riscv                    nommu_k210_defconfig
arc                         haps_hs_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8540_defconfig
arm                     eseries_pxa_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          exynos_defconfig
arm                       spear13xx_defconfig
mips                           ip27_defconfig
ia64                          tiger_defconfig
sh                            hp6xx_defconfig
mips                      maltasmvp_defconfig
mips                        nlm_xlp_defconfig
mips                         tb0287_defconfig
powerpc                     mpc83xx_defconfig
xtensa                           alldefconfig
powerpc                 mpc834x_mds_defconfig
sh                        edosk7705_defconfig
sh                          rsk7203_defconfig
arm                           corgi_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                       versatile_defconfig
arm                          ixp4xx_defconfig
mips                  cavium_octeon_defconfig
arm                       mainstone_defconfig
powerpc                     rainier_defconfig
arm                          pcm027_defconfig
arm                           h3600_defconfig
powerpc                    mvme5100_defconfig
arm                        mvebu_v5_defconfig
arm                             ezx_defconfig
riscv                               defconfig
powerpc                     powernv_defconfig
sh                           se7751_defconfig
mips                        qi_lb60_defconfig
powerpc                     pseries_defconfig
powerpc                       eiger_defconfig
mips                      pic32mzda_defconfig
sh                   secureedge5410_defconfig
arm                       netwinder_defconfig
powerpc                      ppc6xx_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                  nommu_kc705_defconfig
parisc                           alldefconfig
powerpc                      arches_defconfig
powerpc                     tqm8548_defconfig
mips                          ath25_defconfig
arm                        clps711x_defconfig
sparc64                             defconfig
mips                       rbtx49xx_defconfig
um                               alldefconfig
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
s390                             allyesconfig
s390                             allmodconfig
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
i386                 randconfig-a002-20210629
i386                 randconfig-a001-20210629
i386                 randconfig-a003-20210629
i386                 randconfig-a006-20210629
i386                 randconfig-a005-20210629
i386                 randconfig-a004-20210629
i386                 randconfig-a004-20210630
i386                 randconfig-a001-20210630
i386                 randconfig-a003-20210630
i386                 randconfig-a002-20210630
i386                 randconfig-a005-20210630
i386                 randconfig-a006-20210630
x86_64               randconfig-a012-20210628
x86_64               randconfig-a016-20210628
x86_64               randconfig-a015-20210628
x86_64               randconfig-a013-20210628
x86_64               randconfig-a014-20210628
x86_64               randconfig-a011-20210628
i386                 randconfig-a011-20210628
i386                 randconfig-a014-20210628
i386                 randconfig-a013-20210628
i386                 randconfig-a015-20210628
i386                 randconfig-a016-20210628
i386                 randconfig-a012-20210628
i386                 randconfig-a014-20210630
i386                 randconfig-a011-20210630
i386                 randconfig-a016-20210630
i386                 randconfig-a012-20210630
i386                 randconfig-a013-20210630
i386                 randconfig-a015-20210630
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210628
x86_64               randconfig-b001-20210630
x86_64               randconfig-a002-20210628
x86_64               randconfig-a005-20210628
x86_64               randconfig-a001-20210628
x86_64               randconfig-a003-20210628
x86_64               randconfig-a004-20210628
x86_64               randconfig-a006-20210628

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
