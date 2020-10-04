Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7E2827B6
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Oct 2020 03:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgJDBJ4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Oct 2020 21:09:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:44148 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgJDBJ4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 3 Oct 2020 21:09:56 -0400
IronPort-SDR: ncDPWfNAfZqF5i8DIXYrjTkKxYiNdB7La6w6SVps/rMRKB1OugbkKv8AjUtfa6KvBp3ofkmYwU
 Ex39t9cbbwaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9763"; a="227398195"
X-IronPort-AV: E=Sophos;i="5.77,333,1596524400"; 
   d="scan'208";a="227398195"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2020 18:09:55 -0700
IronPort-SDR: dRz1aMk2GKENbcfaLPv2djm25S7Wj9B65YAL5weADZEeJwzMhtDR+cbSrJWgPY9i3+XaFxvrdd
 TJoAgENSh8JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,333,1596524400"; 
   d="scan'208";a="346861035"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2020 18:09:53 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOsXB-0000Ib-7t; Sun, 04 Oct 2020 01:09:53 +0000
Date:   Sun, 04 Oct 2020 09:09:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS d39783839c038802762e45d69fbd5ac3c63d81f0
Message-ID: <5f7920b1.WbswadyWT5eJjcvd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: d39783839c038802762e45d69fbd5ac3c63d81f0  ext4: limit entries returned when counting fsmap records

elapsed time: 722m

configs tested: 215
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm8541_defconfig
mips                           jazz_defconfig
arm                       netwinder_defconfig
sh                        sh7785lcr_defconfig
arm                          moxart_defconfig
sh                               allmodconfig
mips                           ip32_defconfig
arm                       spear13xx_defconfig
arm                       imx_v4_v5_defconfig
powerpc                    klondike_defconfig
mips                          malta_defconfig
arc                        nsim_700_defconfig
arm                          badge4_defconfig
sh                           se7750_defconfig
arm                         s3c6400_defconfig
riscv                            alldefconfig
arc                             nps_defconfig
m68k                        m5272c3_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      ppc6xx_defconfig
csky                                defconfig
arm                         s3c2410_defconfig
arm                           viper_defconfig
arm                         lpc18xx_defconfig
powerpc                      ep88xc_defconfig
powerpc                      ppc64e_defconfig
arm                   milbeaut_m10v_defconfig
arm                          ep93xx_defconfig
arm                         palmz72_defconfig
powerpc                 mpc8540_ads_defconfig
mips                     decstation_defconfig
arm64                            alldefconfig
arm                         lpc32xx_defconfig
arm                         assabet_defconfig
arm                            zeus_defconfig
powerpc                     tqm8555_defconfig
sh                           se7343_defconfig
m68k                        stmark2_defconfig
arm                         axm55xx_defconfig
powerpc                     tqm5200_defconfig
mips                     loongson1b_defconfig
sh                          sdk7786_defconfig
arm                     am200epdkit_defconfig
arm                          gemini_defconfig
sh                ecovec24-romimage_defconfig
ia64                        generic_defconfig
sh                   sh7770_generic_defconfig
arm                         ebsa110_defconfig
um                            kunit_defconfig
arc                        nsimosci_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc832x_mds_defconfig
sparc64                          alldefconfig
mips                      pistachio_defconfig
arm                        oxnas_v6_defconfig
mips                        bcm63xx_defconfig
nios2                         3c120_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         bcm2835_defconfig
arm                       aspeed_g5_defconfig
m68k                          sun3x_defconfig
microblaze                    nommu_defconfig
arm                         cm_x300_defconfig
arm                              zx_defconfig
xtensa                       common_defconfig
arm                            lart_defconfig
powerpc                 mpc8560_ads_defconfig
sh                   rts7751r2dplus_defconfig
mips                   sb1250_swarm_defconfig
nds32                               defconfig
nios2                         10m50_defconfig
sh                   secureedge5410_defconfig
alpha                            allyesconfig
openrisc                    or1ksim_defconfig
m68k                             alldefconfig
arm                            mmp2_defconfig
mips                            gpr_defconfig
powerpc                      ppc44x_defconfig
arm                       mainstone_defconfig
mips                             allyesconfig
powerpc                       holly_defconfig
powerpc                     tqm8540_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                      maltaaprp_defconfig
arm                        spear6xx_defconfig
powerpc                          g5_defconfig
mips                         mpc30x_defconfig
arm                  colibri_pxa270_defconfig
m68k                           sun3_defconfig
sh                          lboxre2_defconfig
sh                          sdk7780_defconfig
m68k                        mvme16x_defconfig
arm                          lpd270_defconfig
arm                        multi_v7_defconfig
mips                  cavium_octeon_defconfig
s390                          debug_defconfig
sh                           se7751_defconfig
arm                        mvebu_v7_defconfig
arm                        vexpress_defconfig
powerpc                     mpc5200_defconfig
arm                      pxa255-idp_defconfig
sh                           se7721_defconfig
sh                           se7780_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201002
x86_64               randconfig-a001-20201002
x86_64               randconfig-a002-20201002
x86_64               randconfig-a005-20201002
x86_64               randconfig-a003-20201002
x86_64               randconfig-a006-20201002
x86_64               randconfig-a004-20201004
x86_64               randconfig-a002-20201004
x86_64               randconfig-a001-20201004
x86_64               randconfig-a003-20201004
x86_64               randconfig-a005-20201004
x86_64               randconfig-a006-20201004
i386                 randconfig-a006-20201003
i386                 randconfig-a005-20201003
i386                 randconfig-a001-20201003
i386                 randconfig-a004-20201003
i386                 randconfig-a003-20201003
i386                 randconfig-a002-20201003
i386                 randconfig-a006-20201002
i386                 randconfig-a005-20201002
i386                 randconfig-a001-20201002
i386                 randconfig-a004-20201002
i386                 randconfig-a003-20201002
i386                 randconfig-a002-20201002
i386                 randconfig-a006-20201004
i386                 randconfig-a005-20201004
i386                 randconfig-a001-20201004
i386                 randconfig-a004-20201004
i386                 randconfig-a003-20201004
i386                 randconfig-a002-20201004
i386                 randconfig-a014-20201004
i386                 randconfig-a015-20201004
i386                 randconfig-a013-20201004
i386                 randconfig-a016-20201004
i386                 randconfig-a011-20201004
i386                 randconfig-a012-20201004
i386                 randconfig-a014-20201003
i386                 randconfig-a013-20201003
i386                 randconfig-a015-20201003
i386                 randconfig-a016-20201003
i386                 randconfig-a011-20201003
i386                 randconfig-a012-20201003
i386                 randconfig-a014-20201002
i386                 randconfig-a013-20201002
i386                 randconfig-a015-20201002
i386                 randconfig-a016-20201002
i386                 randconfig-a011-20201002
i386                 randconfig-a012-20201002
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201003
x86_64               randconfig-a001-20201003
x86_64               randconfig-a002-20201003
x86_64               randconfig-a005-20201003
x86_64               randconfig-a003-20201003
x86_64               randconfig-a006-20201003
x86_64               randconfig-a012-20201002
x86_64               randconfig-a015-20201002
x86_64               randconfig-a014-20201002
x86_64               randconfig-a013-20201002
x86_64               randconfig-a011-20201002
x86_64               randconfig-a016-20201002
x86_64               randconfig-a012-20201004
x86_64               randconfig-a015-20201004
x86_64               randconfig-a014-20201004
x86_64               randconfig-a013-20201004
x86_64               randconfig-a011-20201004
x86_64               randconfig-a016-20201004

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
