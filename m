Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6EE369EB3
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Apr 2021 06:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhDXEMx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Apr 2021 00:12:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:45622 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhDXEMw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 24 Apr 2021 00:12:52 -0400
IronPort-SDR: 2oEOvwH79t3HEMW3EQ/bw02Ny4r9PFE2zyDm1ihYPdhW+6kYzFf96IKFrxvRbg7/ba2kJne936
 ErL8hBKeN4jg==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="194044292"
X-IronPort-AV: E=Sophos;i="5.82,247,1613462400"; 
   d="scan'208";a="194044292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 21:12:10 -0700
IronPort-SDR: CmxUNr1QXbBnHFFg8/FTQm07twtlCwt4du6G1eG4blMlP5FIfn5XOdYzX8QGgjICKircFwE9XS
 1YI7qCXFKcig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,247,1613462400"; 
   d="scan'208";a="421983291"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Apr 2021 21:12:09 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1la9eK-0004z1-HG; Sat, 24 Apr 2021 04:12:08 +0000
Date:   Sat, 24 Apr 2021 12:11:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 6c0912739699d8e4b6a87086401bf3ad3c59502d
Message-ID: <60839a8b.1nrWrpoeZhdOYtIk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 6c0912739699d8e4b6a87086401bf3ad3c59502d  ext4: wipe ext4_dir_entry2 upon file deletion

elapsed time: 720m

configs tested: 170
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                  mpc885_ads_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         bcm2835_defconfig
powerpc                      walnut_defconfig
mips                       capcella_defconfig
arm                        trizeps4_defconfig
sh                          sdk7786_defconfig
arm                            pleb_defconfig
mips                     loongson1c_defconfig
powerpc                    gamecube_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                ecovec24-romimage_defconfig
mips                        omega2p_defconfig
sh                           se7780_defconfig
powerpc                           allnoconfig
arm                            dove_defconfig
sh                           sh2007_defconfig
sh                         ecovec24_defconfig
arm                          lpd270_defconfig
arm                         orion5x_defconfig
arc                        vdk_hs38_defconfig
mips                  maltasmvp_eva_defconfig
m68k                       m5208evb_defconfig
arm                           stm32_defconfig
mips                           ci20_defconfig
mips                        bcm63xx_defconfig
m68k                             alldefconfig
sh                          kfr2r09_defconfig
mips                      pistachio_defconfig
mips                          ath25_defconfig
microblaze                          defconfig
openrisc                    or1ksim_defconfig
s390                          debug_defconfig
arm                           h3600_defconfig
powerpc                     asp8347_defconfig
arm                          iop32x_defconfig
sh                              ul2_defconfig
nios2                            alldefconfig
mips                          rm200_defconfig
powerpc                     skiroot_defconfig
arm                           sama5_defconfig
arc                 nsimosci_hs_smp_defconfig
i386                                defconfig
arm                          exynos_defconfig
ia64                             alldefconfig
m68k                                defconfig
i386                             alldefconfig
powerpc                 xes_mpc85xx_defconfig
arm                             mxs_defconfig
microblaze                      mmu_defconfig
arc                     nsimosci_hs_defconfig
mips                     cu1830-neo_defconfig
parisc                generic-64bit_defconfig
arm                         lubbock_defconfig
powerpc                  storcenter_defconfig
arm                       spear13xx_defconfig
sh                        edosk7760_defconfig
mips                      bmips_stb_defconfig
powerpc                      ppc64e_defconfig
arm                        mvebu_v7_defconfig
mips                            e55_defconfig
sh                          polaris_defconfig
mips                           jazz_defconfig
arm                           viper_defconfig
arm                            mps2_defconfig
arm                       imx_v4_v5_defconfig
sh                               j2_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                         wii_defconfig
mips                           ip28_defconfig
arm                         hackkit_defconfig
sh                             sh03_defconfig
powerpc                   lite5200b_defconfig
um                             i386_defconfig
sh                            migor_defconfig
sh                           se7705_defconfig
xtensa                generic_kc705_defconfig
sh                         microdev_defconfig
arm                       multi_v4t_defconfig
um                               allmodconfig
arm                         lpc18xx_defconfig
powerpc                          g5_defconfig
arc                        nsim_700_defconfig
powerpc                      tqm8xx_defconfig
arm                            qcom_defconfig
arm                        magician_defconfig
mips                        vocore2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210423
x86_64               randconfig-a004-20210423
x86_64               randconfig-a001-20210423
x86_64               randconfig-a005-20210423
x86_64               randconfig-a006-20210423
x86_64               randconfig-a003-20210423
i386                 randconfig-a005-20210423
i386                 randconfig-a002-20210423
i386                 randconfig-a001-20210423
i386                 randconfig-a006-20210423
i386                 randconfig-a004-20210423
i386                 randconfig-a003-20210423
i386                 randconfig-a014-20210423
i386                 randconfig-a012-20210423
i386                 randconfig-a011-20210423
i386                 randconfig-a013-20210423
i386                 randconfig-a015-20210423
i386                 randconfig-a016-20210423
i386                 randconfig-a012-20210424
i386                 randconfig-a014-20210424
i386                 randconfig-a011-20210424
i386                 randconfig-a013-20210424
i386                 randconfig-a016-20210424
i386                 randconfig-a015-20210424
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210423
x86_64               randconfig-a016-20210423
x86_64               randconfig-a011-20210423
x86_64               randconfig-a014-20210423
x86_64               randconfig-a012-20210423
x86_64               randconfig-a013-20210423
x86_64               randconfig-a004-20210424
x86_64               randconfig-a002-20210424
x86_64               randconfig-a003-20210424

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
