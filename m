Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974C847F3A0
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Dec 2021 16:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhLYP1m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Dec 2021 10:27:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:30084 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232046AbhLYP1m (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 25 Dec 2021 10:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640446062; x=1671982062;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=poL0fQf3ZS2pA2j/saSg+hBTAzhKcorALPom1cEDIrQ=;
  b=fBjVSOeExFZGELS11nSVrN2yCe3gZ/uUERj+/OYX3uDgx7x3E5jqQfAw
   5eoM7PyYDflTaYs12CJjHtJL7pDC/w0LA/bJVtR8nvbFFv8TAeuIDp8E1
   mFsMCf0/cG7/j5w+s3q4V5NahFq3e6K2IV/k1UGM5nT7YBF7AefzB/lsc
   d7pwX4luuERfCzAIvBy+HyxwVOwQ+P6u63QshGrLpxpGa/Tg0qVyyZeEL
   qb7zZeHBd/xMf12CcGqlqe2NV+1KYHXrP1Qq0Zb1lEZndGY9u8N6PfWAp
   yq59nY1kx2cBnK7p+ISmyXYxj+EPVgSU6PLjyqWMelmriubu1mYXpsVHF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="240852302"
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="240852302"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 07:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="469307871"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Dec 2021 07:27:40 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n18xQ-0004ON-28; Sat, 25 Dec 2021 15:27:40 +0000
Date:   Sat, 25 Dec 2021 23:27:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD REGRESSION
 cc5fef71a1c741473eebb1aa6f7056ceb49bc33d
Message-ID: <61c73848.ezrkzdC4STslya5j%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: cc5fef71a1c741473eebb1aa6f7056ceb49bc33d  ext4: replace snprintf in show functions with sysfs_emit

Error/Warning reports:

https://lore.kernel.org/linux-ext4/202112101722.3Kpomg0h-lkp@intel.com

possible Error/Warning in current branch (please contact us if interested):

fs/ext4/super.c:2640:22-40: ERROR: reference preceded by free on line 2639

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-c021-20211225
|   `-- fs-ext4-super.c:ERROR:reference-preceded-by-free-on-line
|-- ia64-randconfig-c004-20211225
|   `-- fs-ext4-super.c:ERROR:reference-preceded-by-free-on-line
|-- ia64-randconfig-s032-20211225
|   |-- fs-ext4-super.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-char-const-got-char-noderef-__rcu
|   `-- fs-ext4-super.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-void-const-objp-got-char-noderef-__rcu
|-- powerpc-randconfig-c023-20211225
|   `-- fs-ext4-super.c:ERROR:reference-preceded-by-free-on-line
|-- x86_64-randconfig-c002-20211225
|   `-- fs-ext4-super.c:ERROR:reference-preceded-by-free-on-line
`-- x86_64-randconfig-c022-20211225
    `-- fs-ext4-super.c:ERROR:reference-preceded-by-free-on-line

elapsed time: 722m

configs tested: 99
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211225
ia64                            zx1_defconfig
powerpc                      makalu_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     mpc83xx_defconfig
arm                             pxa_defconfig
ia64                          tiger_defconfig
mips                          rm200_defconfig
arm                       aspeed_g5_defconfig
i386                                defconfig
powerpc                      acadia_defconfig
xtensa                    xip_kc705_defconfig
powerpc                          allyesconfig
nios2                               defconfig
m68k                       m5275evb_defconfig
arm                        mini2440_defconfig
sh                           se7721_defconfig
powerpc                      pmac32_defconfig
sparc                            allyesconfig
arm                  randconfig-c002-20211225
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
sparc                               defconfig
i386                   debian-10.3-kselftests
nds32                             allnoconfig
arc                              allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a013-20211225
x86_64               randconfig-a014-20211225
x86_64               randconfig-a015-20211225
x86_64               randconfig-a011-20211225
x86_64               randconfig-a012-20211225
x86_64               randconfig-a016-20211225
i386                 randconfig-a012-20211225
i386                 randconfig-a011-20211225
i386                 randconfig-a013-20211225
i386                 randconfig-a014-20211225
i386                 randconfig-a016-20211225
i386                 randconfig-a015-20211225
arc                  randconfig-r043-20211225
riscv                randconfig-r042-20211225
s390                 randconfig-r044-20211225
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig

clang tested configs:
i386                 randconfig-a002-20211225
i386                 randconfig-a003-20211225
i386                 randconfig-a005-20211225
i386                 randconfig-a001-20211225
i386                 randconfig-a004-20211225
i386                 randconfig-a006-20211225
x86_64               randconfig-a003-20211225
x86_64               randconfig-a001-20211225
x86_64               randconfig-a005-20211225
x86_64               randconfig-a006-20211225
x86_64               randconfig-a004-20211225
x86_64               randconfig-a002-20211225
hexagon              randconfig-r041-20211225
hexagon              randconfig-r045-20211225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
