Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134A43F3B5B
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Aug 2021 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhHUQJx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Aug 2021 12:09:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:48002 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhHUQJx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 21 Aug 2021 12:09:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10083"; a="196485798"
X-IronPort-AV: E=Sophos;i="5.84,340,1620716400"; 
   d="scan'208";a="196485798"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2021 09:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,340,1620716400"; 
   d="scan'208";a="506783442"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2021 09:09:11 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mHTYU-000Vxs-OL; Sat, 21 Aug 2021 16:09:10 +0000
Date:   Sun, 22 Aug 2021 00:08:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 9e445093e523f3277081314c864f708fd4bd34aa
Message-ID: <612124fe.iMren4mlRaofe3uT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 9e445093e523f3277081314c864f708fd4bd34aa  ext4: fix race writing to an inline_data file while its xattrs are changing

elapsed time: 720m

configs tested: 96
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210821
arm                        clps711x_defconfig
mips                         tb0219_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         palmz72_defconfig
sh                             shx3_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          landisk_defconfig
sh                         ap325rxa_defconfig
arm                            pleb_defconfig
arm                            mmp2_defconfig
arm                        trizeps4_defconfig
powerpc                     mpc5200_defconfig
sh                           se7750_defconfig
sh                        edosk7760_defconfig
arm                             mxs_defconfig
arm                              alldefconfig
x86_64                            allnoconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210821
x86_64               randconfig-a016-20210821
x86_64               randconfig-a015-20210821
x86_64               randconfig-a013-20210821
x86_64               randconfig-a012-20210821
x86_64               randconfig-a011-20210821
i386                 randconfig-a011-20210821
i386                 randconfig-a016-20210821
i386                 randconfig-a012-20210821
i386                 randconfig-a014-20210821
i386                 randconfig-a013-20210821
i386                 randconfig-a015-20210821
arc                  randconfig-r043-20210821
riscv                randconfig-r042-20210821
s390                 randconfig-r044-20210821
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
s390                 randconfig-c005-20210821
i386                 randconfig-c001-20210821
arm                  randconfig-c002-20210821
riscv                randconfig-c006-20210821
powerpc              randconfig-c003-20210821
x86_64               randconfig-c007-20210821
mips                 randconfig-c004-20210821
x86_64               randconfig-a005-20210821
x86_64               randconfig-a001-20210821
x86_64               randconfig-a006-20210821
x86_64               randconfig-a003-20210821
x86_64               randconfig-a004-20210821
x86_64               randconfig-a002-20210821

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
