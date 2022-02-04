Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A54A932E
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Feb 2022 06:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357021AbiBDE76 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Feb 2022 23:59:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:15306 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357014AbiBDE76 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Feb 2022 23:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643950798; x=1675486798;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RBPfSaYTetBaPMLn4VfKh8I3DkscAxskkT0RnRBfGNo=;
  b=mz1eZ2zb0k4//dELYQ9DtcWfglWkwH8UM7mCNJSvdp8MrR3ePPHfq+za
   VabzpK+kGOKmOh07R4cI/tavtkIXGQQe2GVwogmSbn9T+B+wTXzaGhPIY
   9FPxQTwLhq89xOP3Y7NUCXDW942g/s45nu4yfmhBbNXg+9/fz2heBr8f0
   5nv8oTv8u4NUK9cietRjE24XE/Y843EOjo10WyPJLt2SobcbhsTaKJZUP
   t5YuA0Eja5jpTIxaNWqejgMI59IN1jndy4munI5M0aP7sKQIUEH/68w8x
   GkVLPtIXbqPNKZ4EUMfPyGUCvz+N0QX//1mDWDq31ZXJ40J6cEVfFuvmP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248072806"
X-IronPort-AV: E=Sophos;i="5.88,341,1635231600"; 
   d="scan'208";a="248072806"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 20:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,341,1635231600"; 
   d="scan'208";a="524195021"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Feb 2022 20:59:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFqhQ-000X9h-7P; Fri, 04 Feb 2022 04:59:56 +0000
Date:   Fri, 04 Feb 2022 12:59:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 f340b3d9027485945d59f9c04f1e33070b02cae2
Message-ID: <61fcb2b1.ZMTonWHxpWscujEb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: f340b3d9027485945d59f9c04f1e33070b02cae2  fs/ext4: fix comments mentioning i_mutex

elapsed time: 725m

configs tested: 150
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
i386                          randconfig-c001
ia64                         bigsur_defconfig
sh                   secureedge5410_defconfig
arc                        nsim_700_defconfig
mips                           ci20_defconfig
sh                           se7750_defconfig
sh                         microdev_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
parisc                           allyesconfig
arc                          axs101_defconfig
arm                            mps2_defconfig
arm                           sunxi_defconfig
sparc                            allyesconfig
powerpc                     mpc83xx_defconfig
powerpc                     stx_gp3_defconfig
mips                         bigsur_defconfig
powerpc                   currituck_defconfig
powerpc                     tqm8548_defconfig
powerpc                 canyonlands_defconfig
powerpc                      ep88xc_defconfig
arm                         lubbock_defconfig
mips                          rb532_defconfig
powerpc                      ppc40x_defconfig
sh                   rts7751r2dplus_defconfig
s390                       zfcpdump_defconfig
sh                          lboxre2_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
m68k                       m5249evb_defconfig
arm                             rpc_defconfig
arm                             pxa_defconfig
sh                             espt_defconfig
mips                           ip32_defconfig
microblaze                      mmu_defconfig
xtensa                           allyesconfig
powerpc                     pq2fads_defconfig
powerpc                     rainier_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
nios2                         10m50_defconfig
um                                  defconfig
arm                         nhk8815_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
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
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
arc                  randconfig-r043-20220131
s390                 randconfig-r044-20220130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc                          allyesconfig
powerpc               mpc834x_itxgp_defconfig
arm                  colibri_pxa270_defconfig
x86_64                           allyesconfig
mips                          rm200_defconfig
arm                             mxs_defconfig
powerpc                   lite5200b_defconfig
arm                           sama7_defconfig
mips                          ath79_defconfig
powerpc                     ppa8548_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131
s390                 randconfig-r044-20220131
hexagon              randconfig-r045-20220203
hexagon              randconfig-r041-20220203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
