Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05CC3BB64E
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jul 2021 06:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhGEE2E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jul 2021 00:28:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:64971 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhGEE2E (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 5 Jul 2021 00:28:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="230632860"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="230632860"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2021 21:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="485202872"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2021 21:25:24 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m0GAd-000CH7-LW; Mon, 05 Jul 2021 04:25:23 +0000
Date:   Mon, 05 Jul 2021 12:25:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS ef3130d1b0b8ca769252d6a722a2e59a00141383
Message-ID: <60e289ab.hImfoHzquqpMz6ez%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: ef3130d1b0b8ca769252d6a722a2e59a00141383  ext4: inline jbd2_journal_[un]register_shrinker()

elapsed time: 721m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          sdk7786_defconfig
powerpc                       holly_defconfig
m68k                       bvme6000_defconfig
powerpc                     mpc83xx_defconfig
arm                          pxa168_defconfig
powerpc                     akebono_defconfig
powerpc                      bamboo_defconfig
x86_64                              defconfig
arm                        cerfcube_defconfig
mips                       bmips_be_defconfig
arm                        oxnas_v6_defconfig
sh                         apsh4a3a_defconfig
arm                        mvebu_v5_defconfig
riscv                               defconfig
sh                           se7750_defconfig
powerpc                      makalu_defconfig
arm                       aspeed_g4_defconfig
powerpc                          g5_defconfig
mips                        maltaup_defconfig
arm                        multi_v5_defconfig
mips                       lemote2f_defconfig
arm                         orion5x_defconfig
arm                            zeus_defconfig
powerpc                     tqm8541_defconfig
sh                           se7206_defconfig
xtensa                    smp_lx200_defconfig
sparc                       sparc64_defconfig
xtensa                         virt_defconfig
nds32                             allnoconfig
mips                        qi_lb60_defconfig
csky                             alldefconfig
arm                         s5pv210_defconfig
arm                           tegra_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                 randconfig-a004-20210705
i386                 randconfig-a006-20210705
i386                 randconfig-a001-20210705
i386                 randconfig-a003-20210705
i386                 randconfig-a005-20210705
i386                 randconfig-a002-20210705
x86_64               randconfig-a015-20210704
x86_64               randconfig-a014-20210704
x86_64               randconfig-a012-20210704
x86_64               randconfig-a011-20210704
x86_64               randconfig-a016-20210704
x86_64               randconfig-a013-20210704
i386                 randconfig-a015-20210704
i386                 randconfig-a016-20210704
i386                 randconfig-a012-20210704
i386                 randconfig-a011-20210704
i386                 randconfig-a014-20210704
i386                 randconfig-a013-20210704
riscv                    nommu_k210_defconfig
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
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210704
x86_64               randconfig-b001-20210705
x86_64               randconfig-a004-20210704
x86_64               randconfig-a002-20210704
x86_64               randconfig-a005-20210704
x86_64               randconfig-a006-20210704
x86_64               randconfig-a003-20210704
x86_64               randconfig-a001-20210704

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
