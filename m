Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297CA446031
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Nov 2021 08:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhKEHkY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Nov 2021 03:40:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:16896 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhKEHkX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Nov 2021 03:40:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="230582449"
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="scan'208";a="230582449"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 00:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="scan'208";a="668165028"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2021 00:37:33 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mitn3-0007N4-0h; Fri, 05 Nov 2021 07:37:33 +0000
Date:   Fri, 05 Nov 2021 15:37:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 124e7c61deb27d758df5ec0521c36cf08d417f7a
Message-ID: <6184df31.he1ZxhaACGGrFibk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 124e7c61deb27d758df5ec0521c36cf08d417f7a  ext4: fix error code saved on super block during file system abort

elapsed time: 947m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211105
powerpc                    sam440ep_defconfig
sh                 kfr2r09-romimage_defconfig
mips                      bmips_stb_defconfig
xtensa                  audio_kc705_defconfig
arm                       spear13xx_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         bcm2835_defconfig
sh                          kfr2r09_defconfig
powerpc                      obs600_defconfig
powerpc                 canyonlands_defconfig
arm                         at91_dt_defconfig
m68k                          atari_defconfig
m68k                            mac_defconfig
sh                               alldefconfig
sh                             espt_defconfig
powerpc                      acadia_defconfig
sh                   rts7751r2dplus_defconfig
mips                           ci20_defconfig
nios2                         3c120_defconfig
arm                            mps2_defconfig
arm                       aspeed_g4_defconfig
arm                       imx_v4_v5_defconfig
arm                             mxs_defconfig
sh                      rts7751r2d1_defconfig
sh                ecovec24-romimage_defconfig
h8300                               defconfig
mips                         tb0287_defconfig
sh                             sh03_defconfig
mips                      pic32mzda_defconfig
mips                        omega2p_defconfig
arm                        oxnas_v6_defconfig
openrisc                         alldefconfig
powerpc                     mpc83xx_defconfig
arm                         orion5x_defconfig
powerpc                 mpc836x_rdk_defconfig
arc                                 defconfig
powerpc                     powernv_defconfig
arm                        keystone_defconfig
powerpc                      walnut_defconfig
sh                           se7712_defconfig
powerpc                     asp8347_defconfig
powerpc                   lite5200b_defconfig
mips                     loongson1c_defconfig
arm                           tegra_defconfig
arm                           sunxi_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     pq2fads_defconfig
riscv                             allnoconfig
m68k                             alldefconfig
powerpc                      pcm030_defconfig
mips                        qi_lb60_defconfig
arm                      pxa255-idp_defconfig
mips                          ath79_defconfig
sh                           se7721_defconfig
arm                            mmp2_defconfig
sh                   sh7770_generic_defconfig
sh                        sh7757lcr_defconfig
powerpc                     redwood_defconfig
powerpc                     pseries_defconfig
sh                        sh7785lcr_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            qcom_defconfig
sh                          r7785rp_defconfig
arm                        cerfcube_defconfig
mips                      maltasmvp_defconfig
powerpc                  mpc885_ads_defconfig
m68k                        mvme16x_defconfig
openrisc                 simple_smp_defconfig
mips                        vocore2_defconfig
sh                           se7722_defconfig
arc                           tb10x_defconfig
powerpc                 mpc834x_mds_defconfig
arc                          axs103_defconfig
arm                  randconfig-c002-20211105
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a012-20211105
x86_64               randconfig-a016-20211105
x86_64               randconfig-a015-20211105
x86_64               randconfig-a013-20211105
x86_64               randconfig-a011-20211105
x86_64               randconfig-a014-20211105
i386                 randconfig-a016-20211105
i386                 randconfig-a014-20211105
i386                 randconfig-a015-20211105
i386                 randconfig-a013-20211105
i386                 randconfig-a011-20211105
i386                 randconfig-a012-20211105
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
mips                 randconfig-c004-20211105
i386                 randconfig-c001-20211105
arm                  randconfig-c002-20211105
s390                 randconfig-c005-20211105
riscv                randconfig-c006-20211105
powerpc              randconfig-c003-20211105
x86_64               randconfig-c007-20211105
x86_64               randconfig-a004-20211105
x86_64               randconfig-a006-20211105
x86_64               randconfig-a001-20211105
x86_64               randconfig-a002-20211105
x86_64               randconfig-a003-20211105
x86_64               randconfig-a005-20211105
i386                 randconfig-a005-20211105
i386                 randconfig-a001-20211105
i386                 randconfig-a003-20211105
i386                 randconfig-a004-20211105
i386                 randconfig-a006-20211105
i386                 randconfig-a002-20211105
hexagon              randconfig-r041-20211105
hexagon              randconfig-r045-20211105

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
