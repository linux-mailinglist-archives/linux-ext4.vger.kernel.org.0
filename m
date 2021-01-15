Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0124E2F7F58
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jan 2021 16:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbhAOPUN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jan 2021 10:20:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:59828 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732391AbhAOPUM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 15 Jan 2021 10:20:12 -0500
IronPort-SDR: nqXD5cIfIDdAA2+/lK9bIG85+v/oPHEyKz5p4DnAHqpy3WbrLJCFBUGkJIM/75jz2Rz6Xq6Rff
 9McGAMDfDBHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="178647979"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="178647979"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 07:18:00 -0800
IronPort-SDR: qHTKnJ48VqMgoJ5ioL9mjQzJYaG+QSQm7eFW1f4hnneaqUSTzB5xHo4kdY/mogopghxin/UnoN
 /xzas86omxhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="425343886"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Jan 2021 07:17:59 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0QrO-0000Q2-Ex; Fri, 15 Jan 2021 15:17:58 +0000
Date:   Fri, 15 Jan 2021 23:17:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 8f4949dacec8c83e45922d8fcd4c51993650bb5f
Message-ID: <6001b202.4LEW5ptr2cvXr03J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 8f4949dacec8c83e45922d8fcd4c51993650bb5f  ext4: remove expensive flush on fast commit

elapsed time: 722m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    ge_imp3a_defconfig
i386                             alldefconfig
powerpc                 mpc834x_itx_defconfig
mips                     decstation_defconfig
mips                         bigsur_defconfig
powerpc                        cell_defconfig
riscv                    nommu_k210_defconfig
arm                          gemini_defconfig
powerpc                 mpc8540_ads_defconfig
sh                   secureedge5410_defconfig
mips                           ip32_defconfig
mips                        nlm_xlp_defconfig
arm                  colibri_pxa300_defconfig
sh                           se7712_defconfig
powerpc                     rainier_defconfig
powerpc                       ppc64_defconfig
arm                        multi_v5_defconfig
arm                          lpd270_defconfig
arm                       mainstone_defconfig
powerpc                      ep88xc_defconfig
arm                        shmobile_defconfig
m68k                        mvme147_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210115
i386                 randconfig-a005-20210115
i386                 randconfig-a006-20210115
i386                 randconfig-a001-20210115
i386                 randconfig-a003-20210115
i386                 randconfig-a004-20210115
i386                 randconfig-a012-20210115
i386                 randconfig-a011-20210115
i386                 randconfig-a016-20210115
i386                 randconfig-a015-20210115
i386                 randconfig-a013-20210115
i386                 randconfig-a014-20210115
x86_64               randconfig-a004-20210115
x86_64               randconfig-a006-20210115
x86_64               randconfig-a001-20210115
x86_64               randconfig-a003-20210115
x86_64               randconfig-a005-20210115
x86_64               randconfig-a002-20210115
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
x86_64               randconfig-a015-20210115
x86_64               randconfig-a012-20210115
x86_64               randconfig-a013-20210115
x86_64               randconfig-a016-20210115
x86_64               randconfig-a014-20210115
x86_64               randconfig-a011-20210115

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
