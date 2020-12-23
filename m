Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A2C2E18DB
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Dec 2020 07:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgLWGV7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Dec 2020 01:21:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:22382 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgLWGV7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Dec 2020 01:21:59 -0500
IronPort-SDR: pVTJGlL+CRLnctD01LiHaxklxRWFZ8cP779vl19nSUGHZEPNam5FIca532y7P0cBzaj6/pNafK
 TbW2tmU6vMfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="175192937"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="175192937"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 22:21:18 -0800
IronPort-SDR: +2k+sbGJ5NeJ+eETdBV6DlwHi+/7gwx7r0HkKZBRaYqH8dwPjXOAf3ZqYAYRuMvvvPGteTFFwi
 kVVYyWM/FlwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="457867180"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2020 22:21:17 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1krxWP-000094-1U; Wed, 23 Dec 2020 06:21:17 +0000
Date:   Wed, 23 Dec 2020 14:20:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 5a3b590d4b2db187faa6f06adc9a53d6199fb1f9
Message-ID: <5fe2e1a5.WYLkl3BW5JBr/vJC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 5a3b590d4b2db187faa6f06adc9a53d6199fb1f9  ext4: don't leak old mountpoint samples

elapsed time: 723m

configs tested: 127
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      ppc64e_defconfig
arm                         vf610m4_defconfig
powerpc                 canyonlands_defconfig
sh                  sh7785lcr_32bit_defconfig
c6x                        evmc6474_defconfig
arm                       aspeed_g4_defconfig
mips                           ip27_defconfig
parisc                generic-64bit_defconfig
arm                       spear13xx_defconfig
arc                     nsimosci_hs_defconfig
mips                           ip28_defconfig
powerpc                  mpc866_ads_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      bamboo_defconfig
powerpc                      ppc6xx_defconfig
powerpc                    gamecube_defconfig
powerpc                     pq2fads_defconfig
c6x                                 defconfig
arm                             rpc_defconfig
powerpc                   currituck_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                          lboxre2_defconfig
arm                  colibri_pxa300_defconfig
mips                           gcw0_defconfig
arm                         socfpga_defconfig
sh                        edosk7760_defconfig
sh                            titan_defconfig
arm                           h5000_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                        m5272c3_defconfig
c6x                              alldefconfig
arm                        neponset_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20201223
x86_64               randconfig-a006-20201223
x86_64               randconfig-a002-20201223
x86_64               randconfig-a004-20201223
x86_64               randconfig-a003-20201223
x86_64               randconfig-a005-20201223
x86_64               randconfig-a001-20201221
x86_64               randconfig-a006-20201221
x86_64               randconfig-a002-20201221
x86_64               randconfig-a004-20201221
x86_64               randconfig-a003-20201221
x86_64               randconfig-a005-20201221
i386                 randconfig-a002-20201221
i386                 randconfig-a005-20201221
i386                 randconfig-a006-20201221
i386                 randconfig-a004-20201221
i386                 randconfig-a003-20201221
i386                 randconfig-a001-20201221
x86_64               randconfig-a015-20201222
x86_64               randconfig-a014-20201222
x86_64               randconfig-a016-20201222
x86_64               randconfig-a012-20201222
x86_64               randconfig-a013-20201222
x86_64               randconfig-a011-20201222
i386                 randconfig-a011-20201221
i386                 randconfig-a016-20201221
i386                 randconfig-a014-20201221
i386                 randconfig-a012-20201221
i386                 randconfig-a015-20201221
i386                 randconfig-a013-20201221
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201221
x86_64               randconfig-a014-20201221
x86_64               randconfig-a016-20201221
x86_64               randconfig-a012-20201221
x86_64               randconfig-a013-20201221
x86_64               randconfig-a011-20201221
x86_64               randconfig-a015-20201223
x86_64               randconfig-a014-20201223
x86_64               randconfig-a016-20201223
x86_64               randconfig-a012-20201223
x86_64               randconfig-a013-20201223
x86_64               randconfig-a011-20201223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
