Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0434D42E6E4
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 04:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhJOC6R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 22:58:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:7790 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232233AbhJOC6R (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 Oct 2021 22:58:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="288704518"
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="288704518"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 19:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="527830204"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 14 Oct 2021 19:56:09 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbDOD-000765-4j; Fri, 15 Oct 2021 02:56:09 +0000
Date:   Fri, 15 Oct 2021 10:55:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 916ff8d5ea0e24fd43f113b6b5326d5ea8f68310
Message-ID: <6168eda8.s/9q5cEKAacgYXHy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 916ff8d5ea0e24fd43f113b6b5326d5ea8f68310  ext4: prevent partial update of the extent blocks

elapsed time: 1426m

configs tested: 224
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211014
sh                         microdev_defconfig
powerpc                   lite5200b_defconfig
powerpc                      cm5200_defconfig
powerpc                  iss476-smp_defconfig
m68k                            q40_defconfig
sh                               alldefconfig
arm                           sunxi_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7705_defconfig
powerpc                      chrp32_defconfig
mips                      pic32mzda_defconfig
arm                         orion5x_defconfig
mips                     loongson1b_defconfig
arm                            mmp2_defconfig
mips                          rb532_defconfig
arm                          exynos_defconfig
sh                        edosk7705_defconfig
arm                       aspeed_g5_defconfig
sh                          sdk7786_defconfig
sparc                            alldefconfig
ia64                         bigsur_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            zeus_defconfig
sh                           se7206_defconfig
sh                         ap325rxa_defconfig
sh                   sh7724_generic_defconfig
arm                           spitz_defconfig
arm                       multi_v4t_defconfig
xtensa                           alldefconfig
powerpc                     ep8248e_defconfig
powerpc                     mpc83xx_defconfig
mips                           ip32_defconfig
powerpc                     stx_gp3_defconfig
mips                        bcm63xx_defconfig
arm                        spear3xx_defconfig
sh                          polaris_defconfig
powerpc                     rainier_defconfig
arm                             ezx_defconfig
s390                             alldefconfig
mips                 decstation_r4k_defconfig
arm                          collie_defconfig
s390                       zfcpdump_defconfig
mips                        qi_lb60_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     tqm8560_defconfig
arm                            qcom_defconfig
arc                      axs103_smp_defconfig
powerpc                   currituck_defconfig
mips                  decstation_64_defconfig
powerpc                     skiroot_defconfig
xtensa                         virt_defconfig
um                           x86_64_defconfig
mips                         bigsur_defconfig
arc                              alldefconfig
xtensa                    xip_kc705_defconfig
mips                      maltaaprp_defconfig
sh                        edosk7760_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc8560_ads_defconfig
um                             i386_defconfig
csky                                defconfig
arm                        vexpress_defconfig
powerpc                 mpc837x_mds_defconfig
mips                        workpad_defconfig
mips                     loongson2k_defconfig
arc                     haps_hs_smp_defconfig
m68k                          atari_defconfig
um                                  defconfig
mips                         tb0287_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      pasemi_defconfig
xtensa                    smp_lx200_defconfig
m68k                           sun3_defconfig
powerpc                      tqm8xx_defconfig
powerpc                    adder875_defconfig
arc                        nsim_700_defconfig
arm                       aspeed_g4_defconfig
arm                     eseries_pxa_defconfig
mips                        omega2p_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     redwood_defconfig
powerpc                    klondike_defconfig
sh                          r7785rp_defconfig
powerpc                      katmai_defconfig
arm                         nhk8815_defconfig
arm                       omap2plus_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc8272_ads_defconfig
arm64                            alldefconfig
sh                        sh7757lcr_defconfig
riscv                    nommu_k210_defconfig
sh                           se7722_defconfig
arm                         s3c6400_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
powerpc                    amigaone_defconfig
parisc                              defconfig
powerpc                      arches_defconfig
openrisc                  or1klitex_defconfig
sh                          rsk7269_defconfig
mips                          rm200_defconfig
m68k                             alldefconfig
nds32                               defconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     tqm8541_defconfig
nios2                         3c120_defconfig
mips                      fuloong2e_defconfig
powerpc                        warp_defconfig
openrisc                    or1ksim_defconfig
arm                         lpc18xx_defconfig
sh                          landisk_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                  colibri_pxa300_defconfig
s390                          debug_defconfig
m68k                         apollo_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
mips                        bcm47xx_defconfig
powerpc                      ppc64e_defconfig
powerpc                 canyonlands_defconfig
sh                           se7780_defconfig
powerpc                      pmac32_defconfig
sh                             sh03_defconfig
m68k                       m5249evb_defconfig
sh                             shx3_defconfig
ia64                      gensparse_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                     sequoia_defconfig
m68k                        m5307c3_defconfig
m68k                       m5208evb_defconfig
arm                        mvebu_v7_defconfig
powerpc                    gamecube_defconfig
arm                          ixp4xx_defconfig
xtensa                       common_defconfig
powerpc                      ppc44x_defconfig
arm                  randconfig-c002-20211014
x86_64               randconfig-c001-20211014
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                                defconfig
parisc                           allyesconfig
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
x86_64               randconfig-a006-20211014
x86_64               randconfig-a004-20211014
x86_64               randconfig-a001-20211014
x86_64               randconfig-a005-20211014
x86_64               randconfig-a002-20211014
x86_64               randconfig-a003-20211014
i386                 randconfig-a003-20211014
i386                 randconfig-a001-20211014
i386                 randconfig-a005-20211014
i386                 randconfig-a004-20211014
i386                 randconfig-a002-20211014
i386                 randconfig-a006-20211014
arc                  randconfig-r043-20211013
s390                 randconfig-r044-20211013
riscv                randconfig-r042-20211013
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211014
i386                 randconfig-c001-20211014
s390                 randconfig-c005-20211014
x86_64               randconfig-c007-20211014
powerpc              randconfig-c003-20211014
riscv                randconfig-c006-20211014
x86_64               randconfig-a012-20211014
x86_64               randconfig-a015-20211014
x86_64               randconfig-a016-20211014
x86_64               randconfig-a014-20211014
x86_64               randconfig-a011-20211014
x86_64               randconfig-a013-20211014
i386                 randconfig-a016-20211014
i386                 randconfig-a014-20211014
i386                 randconfig-a011-20211014
i386                 randconfig-a015-20211014
i386                 randconfig-a012-20211014
i386                 randconfig-a013-20211014
hexagon              randconfig-r041-20211014
s390                 randconfig-r044-20211014
riscv                randconfig-r042-20211014
hexagon              randconfig-r045-20211014
hexagon              randconfig-r041-20211013
hexagon              randconfig-r045-20211013

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
