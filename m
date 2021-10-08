Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F090426389
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Oct 2021 06:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhJHEHY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Oct 2021 00:07:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:13167 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhJHEHX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 8 Oct 2021 00:07:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="206548232"
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="206548232"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 21:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="489295872"
Received: from lkp-server01.sh.intel.com (HELO 72c3bd3cf19c) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Oct 2021 21:05:27 -0700
Received: from kbuild by 72c3bd3cf19c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mYh8Q-00081I-Rh; Fri, 08 Oct 2021 04:05:26 +0000
Date:   Fri, 08 Oct 2021 12:05:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 d56aaa1fa17ff4b45383c8beb36bb6a1cf835e22
Message-ID: <615fc370.m9QUdVgEck9Z6ywZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: d56aaa1fa17ff4b45383c8beb36bb6a1cf835e22  ext4: refresh the ext4_ext_path struct after dropping i_data_sem.

elapsed time: 724m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   motionpro_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                          atari_defconfig
powerpc                      ppc40x_defconfig
powerpc                     stx_gp3_defconfig
m68k                          multi_defconfig
sh                           se7722_defconfig
sparc                            allyesconfig
sh                           sh2007_defconfig
arm                         orion5x_defconfig
sh                          landisk_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
mips                          ath25_defconfig
arm                          collie_defconfig
s390                       zfcpdump_defconfig
m68k                       m5475evb_defconfig
sparc                            alldefconfig
sparc                       sparc64_defconfig
sh                        sh7757lcr_defconfig
arc                          axs101_defconfig
sh                          kfr2r09_defconfig
mips                        maltaup_defconfig
mips                      loongson3_defconfig
powerpc                         ps3_defconfig
h8300                            allyesconfig
powerpc                      pcm030_defconfig
powerpc                      pasemi_defconfig
powerpc64                           defconfig
mips                       capcella_defconfig
arm                          moxart_defconfig
arm                           sama5_defconfig
arc                     nsimosci_hs_defconfig
m68k                        stmark2_defconfig
arm                     davinci_all_defconfig
sh                          polaris_defconfig
xtensa                          iss_defconfig
arm                       multi_v4t_defconfig
powerpc                     ksi8560_defconfig
mips                        bcm63xx_defconfig
x86_64               randconfig-c001-20211003
i386                 randconfig-c001-20211003
arm                  randconfig-c002-20211003
x86_64               randconfig-c001-20211004
i386                 randconfig-c001-20211004
arm                  randconfig-c002-20211004
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20211004
x86_64               randconfig-a012-20211004
x86_64               randconfig-a016-20211004
x86_64               randconfig-a014-20211004
x86_64               randconfig-a013-20211004
x86_64               randconfig-a011-20211004
i386                 randconfig-a013-20211004
i386                 randconfig-a016-20211004
i386                 randconfig-a014-20211004
i386                 randconfig-a011-20211004
i386                 randconfig-a012-20211004
i386                 randconfig-a015-20211004
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20211004
x86_64               randconfig-a005-20211004
x86_64               randconfig-a001-20211004
x86_64               randconfig-a002-20211004
x86_64               randconfig-a004-20211004
x86_64               randconfig-a006-20211004
i386                 randconfig-a001-20211004
i386                 randconfig-a003-20211004
i386                 randconfig-a005-20211004
i386                 randconfig-a002-20211004
i386                 randconfig-a004-20211004
i386                 randconfig-a006-20211004
hexagon              randconfig-r045-20211007
hexagon              randconfig-r041-20211007
s390                 randconfig-r044-20211007
riscv                randconfig-r042-20211007

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
