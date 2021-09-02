Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CB83FECBD
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Sep 2021 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbhIBLOf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Sep 2021 07:14:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:53822 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhIBLOe (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 2 Sep 2021 07:14:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="280084751"
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="280084751"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 04:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="521045429"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2021 04:13:34 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLkf0-0008um-5W; Thu, 02 Sep 2021 11:13:34 +0000
Date:   Thu, 02 Sep 2021 19:13:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS baaae979b112642a41b71c71c599d875c067d257
Message-ID: <6130b1cd.a6Zuo4lYaZWRqHX6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: baaae979b112642a41b71c71c599d875c067d257  ext4: make the updating inode data procedure atomic

elapsed time: 724m

configs tested: 173
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210831
i386                 randconfig-c001-20210901
powerpc                   bluestone_defconfig
sh                          rsk7269_defconfig
sh                         apsh4a3a_defconfig
sh                               j2_defconfig
xtensa                    smp_lx200_defconfig
ia64                            zx1_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          sdk7786_defconfig
arm                            xcep_defconfig
arm                          ep93xx_defconfig
xtensa                         virt_defconfig
riscv                            alldefconfig
m68k                          sun3x_defconfig
sh                            hp6xx_defconfig
s390                                defconfig
nds32                               defconfig
powerpc                    socrates_defconfig
powerpc64                           defconfig
sh                             shx3_defconfig
arm                           sunxi_defconfig
sh                          r7785rp_defconfig
mips                        vocore2_defconfig
powerpc                 linkstation_defconfig
sparc64                             defconfig
powerpc                     sequoia_defconfig
arm                         lpc18xx_defconfig
x86_64                           alldefconfig
arm                      integrator_defconfig
mips                         tb0287_defconfig
sh                          landisk_defconfig
sh                   sh7724_generic_defconfig
mips                           jazz_defconfig
arc                        nsimosci_defconfig
sh                          lboxre2_defconfig
arm                         cm_x300_defconfig
arm                           corgi_defconfig
powerpc                      acadia_defconfig
arm                         bcm2835_defconfig
arm                        mini2440_defconfig
xtensa                          iss_defconfig
sh                        dreamcast_defconfig
nios2                         3c120_defconfig
sh                          urquell_defconfig
mips                        maltaup_defconfig
arm                          pxa910_defconfig
powerpc                  iss476-smp_defconfig
mips                     decstation_defconfig
arm                           spitz_defconfig
powerpc                     tqm8540_defconfig
mips                            e55_defconfig
arm                            mps2_defconfig
sh                           se7750_defconfig
arm                       aspeed_g5_defconfig
sparc64                          alldefconfig
sh                           sh2007_defconfig
sh                        sh7785lcr_defconfig
arm                     davinci_all_defconfig
powerpc                     tqm5200_defconfig
riscv                    nommu_virt_defconfig
arm                           h5000_defconfig
arc                              alldefconfig
sh                              ul2_defconfig
powerpc                  mpc866_ads_defconfig
arm                           h3600_defconfig
arm                         s5pv210_defconfig
mips                           ip28_defconfig
mips                        omega2p_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
powerpc                      pasemi_defconfig
mips                  decstation_64_defconfig
ia64                      gensparse_defconfig
mips                        nlm_xlp_defconfig
arm                          imote2_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210831
x86_64               randconfig-a001-20210831
x86_64               randconfig-a003-20210831
x86_64               randconfig-a002-20210831
x86_64               randconfig-a004-20210831
x86_64               randconfig-a006-20210831
i386                 randconfig-a005-20210831
i386                 randconfig-a002-20210831
i386                 randconfig-a003-20210831
i386                 randconfig-a006-20210831
i386                 randconfig-a001-20210831
i386                 randconfig-a004-20210831
x86_64               randconfig-a016-20210901
x86_64               randconfig-a011-20210901
x86_64               randconfig-a012-20210901
x86_64               randconfig-a015-20210901
x86_64               randconfig-a014-20210901
x86_64               randconfig-a013-20210901
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
s390                 randconfig-c005-20210901
mips                 randconfig-c004-20210901
x86_64               randconfig-c007-20210901
powerpc              randconfig-c003-20210901
i386                 randconfig-c001-20210901
arm                  randconfig-c002-20210901
riscv                randconfig-c006-20210901
i386                 randconfig-c001-20210831
s390                 randconfig-c005-20210831
riscv                randconfig-c006-20210831
powerpc              randconfig-c003-20210831
mips                 randconfig-c004-20210831
arm                  randconfig-c002-20210831
x86_64               randconfig-c007-20210831
x86_64               randconfig-a014-20210831
x86_64               randconfig-a015-20210831
x86_64               randconfig-a013-20210831
x86_64               randconfig-a016-20210831
x86_64               randconfig-a012-20210831
x86_64               randconfig-a011-20210831
i386                 randconfig-a016-20210831
i386                 randconfig-a011-20210831
i386                 randconfig-a015-20210831
i386                 randconfig-a014-20210831
i386                 randconfig-a012-20210831
i386                 randconfig-a013-20210831
hexagon              randconfig-r045-20210901
hexagon              randconfig-r041-20210901
s390                 randconfig-r044-20210831
hexagon              randconfig-r041-20210831
hexagon              randconfig-r045-20210831
riscv                randconfig-r042-20210831

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
