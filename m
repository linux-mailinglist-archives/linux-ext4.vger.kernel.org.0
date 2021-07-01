Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9673B8C9C
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Jul 2021 05:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhGAD1y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 23:27:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:2067 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhGAD1x (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 23:27:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="188844534"
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="188844534"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 20:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="457488174"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2021 20:25:18 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lynKH-000AG7-OJ; Thu, 01 Jul 2021 03:25:17 +0000
Date:   Thu, 01 Jul 2021 11:24:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 16aa4c9a1fbe763c147a964cdc1f5be8ed98ed13
Message-ID: <60dd3578.pQifDWloDkHyvvhs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 16aa4c9a1fbe763c147a964cdc1f5be8ed98ed13  jbd2: export jbd2_journal_[un]register_shrinker()

elapsed time: 729m

configs tested: 139
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                    vt8500_v6_v7_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     tqm8548_defconfig
sh                           se7619_defconfig
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
arm                         s5pv210_defconfig
m68k                        m5272c3_defconfig
ia64                             alldefconfig
sh                           se7722_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      mgcoge_defconfig
powerpc                     asp8347_defconfig
arm                         nhk8815_defconfig
m68k                        m5307c3_defconfig
sh                          sdk7786_defconfig
ia64                         bigsur_defconfig
sh                        dreamcast_defconfig
sh                        edosk7705_defconfig
arm                            zeus_defconfig
powerpc                       maple_defconfig
powerpc                 mpc834x_mds_defconfig
arm                          collie_defconfig
sh                           se7721_defconfig
arm                          gemini_defconfig
openrisc                            defconfig
mips                        maltaup_defconfig
sh                             shx3_defconfig
s390                                defconfig
mips                           xway_defconfig
powerpc                     sbc8548_defconfig
arc                          axs103_defconfig
sh                          rsk7203_defconfig
mips                        qi_lb60_defconfig
powerpc                        warp_defconfig
arm                           h5000_defconfig
mips                   sb1250_swarm_defconfig
s390                             allyesconfig
powerpc                     pseries_defconfig
mips                       bmips_be_defconfig
powerpc                   currituck_defconfig
mips                          ath25_defconfig
arm                             pxa_defconfig
sh                           se7206_defconfig
mips                         mpc30x_defconfig
sh                   rts7751r2dplus_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      obs600_defconfig
m68k                        mvme147_defconfig
mips                       lemote2f_defconfig
powerpc                 canyonlands_defconfig
sh                        sh7785lcr_defconfig
sh                      rts7751r2d1_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                       eiger_defconfig
powerpc                     ksi8560_defconfig
sh                         ecovec24_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      tqm8xx_defconfig
nios2                            alldefconfig
mips                     loongson1c_defconfig
sh                           se7343_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210630
x86_64               randconfig-a001-20210630
x86_64               randconfig-a004-20210630
x86_64               randconfig-a005-20210630
x86_64               randconfig-a006-20210630
x86_64               randconfig-a003-20210630
i386                 randconfig-a004-20210630
i386                 randconfig-a001-20210630
i386                 randconfig-a003-20210630
i386                 randconfig-a002-20210630
i386                 randconfig-a005-20210630
i386                 randconfig-a006-20210630
i386                 randconfig-a014-20210630
i386                 randconfig-a011-20210630
i386                 randconfig-a016-20210630
i386                 randconfig-a012-20210630
i386                 randconfig-a013-20210630
i386                 randconfig-a015-20210630
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210630
x86_64               randconfig-a012-20210630
x86_64               randconfig-a015-20210630
x86_64               randconfig-a016-20210630
x86_64               randconfig-a013-20210630
x86_64               randconfig-a011-20210630
x86_64               randconfig-a014-20210630

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
