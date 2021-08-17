Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE5D3EE0E6
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Aug 2021 02:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhHQA3c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Aug 2021 20:29:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:18021 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232995AbhHQA3c (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Aug 2021 20:29:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="203122789"
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="203122789"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP; 16 Aug 2021 17:28:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; 
   d="scan'208";a="510094310"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2021 17:28:57 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mFmyP-000R7H-5p; Tue, 17 Aug 2021 00:28:57 +0000
Date:   Tue, 17 Aug 2021 08:28:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 6c6ce4d7146559511fe4ed70f2bc69a89c2c7a88
Message-ID: <611b029f.HDbkHcflPCEV40o9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 6c6ce4d7146559511fe4ed70f2bc69a89c2c7a88  jbd2: add sparse annotations for add_transaction_credits()

elapsed time: 721m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
arm                            zeus_defconfig
ia64                             allmodconfig
mips                      pic32mzda_defconfig
arm                            mmp2_defconfig
parisc                generic-32bit_defconfig
powerpc                  iss476-smp_defconfig
m68k                          atari_defconfig
powerpc                     taishan_defconfig
arm                       versatile_defconfig
mips                         tb0226_defconfig
sh                          rsk7201_defconfig
powerpc                         ps3_defconfig
powerpc                  mpc866_ads_defconfig
arm                         lpc18xx_defconfig
arm                         lubbock_defconfig
riscv                    nommu_k210_defconfig
arm                        shmobile_defconfig
sh                          r7785rp_defconfig
arm                            dove_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc832x_mds_defconfig
arm                     am200epdkit_defconfig
powerpc                     skiroot_defconfig
mips                       lemote2f_defconfig
powerpc                   bluestone_defconfig
powerpc                     ep8248e_defconfig
arm                        neponset_defconfig
arm                          simpad_defconfig
mips                         rt305x_defconfig
s390                          debug_defconfig
arm                        clps711x_defconfig
arc                     haps_hs_smp_defconfig
i386                                defconfig
arm                         cm_x300_defconfig
arm                             pxa_defconfig
arm                       omap2plus_defconfig
arm                         axm55xx_defconfig
arm                        spear6xx_defconfig
xtensa                         virt_defconfig
ia64                        generic_defconfig
sh                        dreamcast_defconfig
arm                         nhk8815_defconfig
parisc                           alldefconfig
powerpc                     sequoia_defconfig
mips                           ip32_defconfig
arm                          lpd270_defconfig
sh                                  defconfig
arm                           corgi_defconfig
arm                           omap1_defconfig
sh                           sh2007_defconfig
powerpc                      ppc44x_defconfig
h8300                    h8300h-sim_defconfig
h8300                               defconfig
mips                      loongson3_defconfig
mips                        bcm63xx_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      mgcoge_defconfig
mips                        jmr3927_defconfig
arm                        trizeps4_defconfig
i386                             alldefconfig
powerpc                      pcm030_defconfig
openrisc                            defconfig
arm                           tegra_defconfig
arm                         s3c2410_defconfig
arm                         shannon_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                       netwinder_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     tqm8541_defconfig
riscv                            alldefconfig
arm                        mini2440_defconfig
microblaze                          defconfig
x86_64                            allnoconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210816
x86_64               randconfig-a004-20210816
x86_64               randconfig-a003-20210816
x86_64               randconfig-a001-20210816
x86_64               randconfig-a005-20210816
x86_64               randconfig-a002-20210816
i386                 randconfig-a004-20210816
i386                 randconfig-a003-20210816
i386                 randconfig-a002-20210816
i386                 randconfig-a001-20210816
i386                 randconfig-a006-20210816
i386                 randconfig-a005-20210816
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
i386                 randconfig-c001-20210816
x86_64               randconfig-a011-20210816
x86_64               randconfig-a013-20210816
x86_64               randconfig-a016-20210816
x86_64               randconfig-a012-20210816
x86_64               randconfig-a015-20210816
x86_64               randconfig-a014-20210816
i386                 randconfig-a011-20210816
i386                 randconfig-a015-20210816
i386                 randconfig-a013-20210816
i386                 randconfig-a014-20210816
i386                 randconfig-a016-20210816
i386                 randconfig-a012-20210816

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
