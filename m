Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE448CA00
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jan 2022 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbiALRlP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jan 2022 12:41:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:44629 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343828AbiALRlM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 12 Jan 2022 12:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642009272; x=1673545272;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Xdd/w2oH4JUDZeUOuW0uMWyyBNVOdeVlLb+CnAbNxY8=;
  b=UC9cdtQ3xjrqcFUOqEWPC4k8HAn5dnaylHsDRpdD/bIqNN+nii9Hztst
   yOq7+fVHMKsPsJ8aMAiwXOoZxq6MF0Dc9O3JkkUyE/dF8NcilAl/aQ1Xk
   g0za8ln90EGxVJ9CjSd5+mrDzEriOkSiUwMhLZ6AATkN62OmmGSJsNSVG
   nSz6HITL7qDYS2P02/zXl0bkqlMGhlCPSWyZ5iymJjuJMd/Uuvd2BPj1S
   izIEfn/lJ2tygAH/QzFJIHcVxjyEUCvmzsb53i05IAbHS0OjYE9CQjoZ7
   gP5E/cnz5Y86MGScJt0b+MKlNd81JyxQeZJHZ+KnNaCEol8HxU6XSOOyg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243591503"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243591503"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 09:41:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="576623311"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jan 2022 09:41:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7hcO-0006Ag-Mb; Wed, 12 Jan 2022 17:41:04 +0000
Date:   Thu, 13 Jan 2022 01:40:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 6eeaf88fd586f05aaf1d48cb3a139d2a5c6eb055
Message-ID: <61df1278.c6hzlrwi+uEcDs+g%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 6eeaf88fd586f05aaf1d48cb3a139d2a5c6eb055  ext4: don't use the orphan list when migrating an inode

elapsed time: 2784m

configs tested: 223
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220111
mips                 randconfig-c004-20220112
sh                           se7750_defconfig
arm                          badge4_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
s390                             allmodconfig
arm                         cm_x300_defconfig
csky                             alldefconfig
powerpc                      ppc6xx_defconfig
powerpc                         wii_defconfig
nds32                               defconfig
arm                           u8500_defconfig
openrisc                  or1klitex_defconfig
sparc                            allyesconfig
sh                           se7780_defconfig
m68k                       m5475evb_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     mpc83xx_defconfig
mips                      maltasmvp_defconfig
nios2                               defconfig
sh                          sdk7780_defconfig
m68k                        mvme16x_defconfig
arm                        cerfcube_defconfig
h8300                     edosk2674_defconfig
sh                           se7724_defconfig
m68k                          hp300_defconfig
arm                         axm55xx_defconfig
um                             i386_defconfig
sparc                            alldefconfig
arm                           stm32_defconfig
arc                     haps_hs_smp_defconfig
sh                         microdev_defconfig
powerpc                     rainier_defconfig
sh                                  defconfig
powerpc                      ep88xc_defconfig
arm                        mini2440_defconfig
sh                            migor_defconfig
m68k                                defconfig
s390                          debug_defconfig
arc                              allyesconfig
arm                       multi_v4t_defconfig
arm                           viper_defconfig
mips                           jazz_defconfig
openrisc                            defconfig
arc                    vdk_hs38_smp_defconfig
mips                        jmr3927_defconfig
powerpc                    klondike_defconfig
powerpc                      bamboo_defconfig
sh                          rsk7203_defconfig
m68k                       m5275evb_defconfig
sh                        edosk7705_defconfig
arm                        realview_defconfig
powerpc                       holly_defconfig
powerpc                  storcenter_defconfig
arm                         assabet_defconfig
h8300                       h8s-sim_defconfig
sh                           se7751_defconfig
microblaze                          defconfig
arm                       omap2plus_defconfig
sparc64                             defconfig
mips                          rb532_defconfig
arm                          iop32x_defconfig
arc                      axs103_smp_defconfig
sh                          r7780mp_defconfig
sh                             shx3_defconfig
h8300                               defconfig
sh                           se7722_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          landisk_defconfig
sh                           se7712_defconfig
xtensa                generic_kc705_defconfig
powerpc                     tqm8548_defconfig
ia64                             allyesconfig
s390                                defconfig
sh                     magicpanelr2_defconfig
powerpc                     pq2fads_defconfig
parisc                              defconfig
mips                           xway_defconfig
m68k                         amcore_defconfig
arm                            mps2_defconfig
m68k                            q40_defconfig
xtensa                  audio_kc705_defconfig
powerpc                    adder875_defconfig
m68k                        stmark2_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc834x_itx_defconfig
microblaze                      mmu_defconfig
sh                           se7721_defconfig
sh                            titan_defconfig
powerpc                       ppc64_defconfig
arm                        multi_v7_defconfig
arm                            zeus_defconfig
ia64                        generic_defconfig
mips                         mpc30x_defconfig
arc                          axs103_defconfig
powerpc                      pcm030_defconfig
xtensa                       common_defconfig
powerpc                   motionpro_defconfig
sh                          kfr2r09_defconfig
m68k                             allmodconfig
sh                        edosk7760_defconfig
xtensa                           alldefconfig
m68k                         apollo_defconfig
arm                       aspeed_g5_defconfig
um                               alldefconfig
s390                             allyesconfig
arm                  randconfig-c002-20220112
arm                  randconfig-c002-20220111
ia64                             allmodconfig
ia64                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220111
arc                  randconfig-r043-20220111
s390                 randconfig-r044-20220111
arc                  randconfig-r043-20220112
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220111
x86_64                        randconfig-c007
riscv                randconfig-c006-20220111
powerpc              randconfig-c003-20220111
i386                          randconfig-c001
mips                 randconfig-c004-20220111
arm                  randconfig-c002-20220112
riscv                randconfig-c006-20220112
powerpc              randconfig-c003-20220112
mips                 randconfig-c004-20220112
s390                 randconfig-c005-20220111
riscv                          rv32_defconfig
arm                                 defconfig
arm                          pxa168_defconfig
powerpc                     ksi8560_defconfig
arm                        spear3xx_defconfig
arm                  colibri_pxa300_defconfig
mips                          malta_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc836x_mds_defconfig
mips                        workpad_defconfig
mips                          ath79_defconfig
powerpc                        icon_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                   lite5200b_defconfig
powerpc                     ppa8548_defconfig
mips                           ip27_defconfig
powerpc                          allmodconfig
powerpc                     kmeter1_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    ge_imp3a_defconfig
arm                            mmp2_defconfig
arm                         hackkit_defconfig
riscv                             allnoconfig
arm                          ixp4xx_defconfig
mips                          rm200_defconfig
powerpc                      acadia_defconfig
hexagon                          alldefconfig
powerpc                      pmac32_defconfig
mips                           ip22_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         bcm2835_defconfig
powerpc                          allyesconfig
powerpc                 mpc8313_rdb_defconfig
mips                        bcm63xx_defconfig
mips                   sb1250_swarm_defconfig
arm                     davinci_all_defconfig
arm                      pxa255-idp_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220111
hexagon              randconfig-r041-20220111
hexagon              randconfig-r045-20220112
riscv                randconfig-r042-20220112
hexagon              randconfig-r041-20220112

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
