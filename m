Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB852DDEAA
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Dec 2020 07:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbgLRGhY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Dec 2020 01:37:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:24714 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgLRGhX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Dec 2020 01:37:23 -0500
IronPort-SDR: fK1ivfzZVySY0tzzD79LFMFRBHY90vOTF0PjSwKZT9L8iAb4Sb8S8RGEakdfbiLBNKb1jIDQzk
 n26pysPOEd4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="154611914"
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400"; 
   d="scan'208";a="154611914"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 22:36:34 -0800
IronPort-SDR: RwS3qXrhgB2HqNGt+4JzwROoejgzjZ8MNbcGIm/SnbCiZov1B3ckVGXD6dXXoNQTefdL47LpW7
 whkHmvV15M2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,429,1599548400"; 
   d="scan'208";a="388153714"
Received: from lkp-server02.sh.intel.com (HELO c4fb2a2464e8) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Dec 2020 22:36:33 -0800
Received: from kbuild by c4fb2a2464e8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kq9NR-000031-2T; Fri, 18 Dec 2020 06:36:33 +0000
Date:   Fri, 18 Dec 2020 14:35:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 739c541bd3ea1f5943284542abb855116632a84b
Message-ID: <5fdc4db7.IXVRie1A+1VOBRiX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 739c541bd3ea1f5943284542abb855116632a84b  ext4: don't leak old mountpoint samples

elapsed time: 721m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc885_ads_defconfig
sh                          landisk_defconfig
arm                        shmobile_defconfig
m68k                          sun3x_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          kfr2r09_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme147_defconfig
arm                         nhk8815_defconfig
sh                         ap325rxa_defconfig
parisc                generic-64bit_defconfig
arm                        mvebu_v5_defconfig
powerpc                     taishan_defconfig
arm                         assabet_defconfig
c6x                              alldefconfig
sh                           se7750_defconfig
arc                      axs103_smp_defconfig
arc                         haps_hs_defconfig
powerpc                      ppc6xx_defconfig
mips                        nlm_xlr_defconfig
arm                          collie_defconfig
openrisc                         alldefconfig
powerpc                      ppc64e_defconfig
arm                          imote2_defconfig
m68k                          hp300_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7269_defconfig
h8300                               defconfig
arm                      jornada720_defconfig
powerpc                           allnoconfig
mips                  maltasmvp_eva_defconfig
mips                  decstation_64_defconfig
powerpc64                        alldefconfig
m68k                                defconfig
arm                          moxart_defconfig
powerpc                    socrates_defconfig
arm                          ep93xx_defconfig
h8300                       h8s-sim_defconfig
nios2                            alldefconfig
sh                            hp6xx_defconfig
arc                     nsimosci_hs_defconfig
arm                         hackkit_defconfig
arm64                            alldefconfig
mips                        jmr3927_defconfig
powerpc                     tqm8548_defconfig
um                            kunit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
x86_64               randconfig-a003-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a001-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
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
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
