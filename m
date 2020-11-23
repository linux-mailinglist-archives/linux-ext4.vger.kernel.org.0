Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3162BFEBC
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 04:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgKWDcE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Nov 2020 22:32:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:50682 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgKWDcD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 22 Nov 2020 22:32:03 -0500
IronPort-SDR: ncqDaeGJZ+3sneKvF3i9kG6Oj7/DHb9vXtGDiF0//Rg14R9tJ5LuvgcMKiQj5oNBPDw/nXH8xW
 I/8E1P5dxvMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="171858934"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="171858934"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 19:32:03 -0800
IronPort-SDR: 9jLNk7oeSkh5QR9QU1Vldgp2zetmYjr4Fhfb7Ev7/jXnoDm2uq8jMm/hxMJe/U4VoLWqJM1V/K
 yVHbigEcZgqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="312084128"
Received: from lkp-server01.sh.intel.com (HELO ce8054c7261d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Nov 2020 19:32:01 -0800
Received: from kbuild by ce8054c7261d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kh2a8-0000QC-TH; Mon, 23 Nov 2020 03:32:00 +0000
Date:   Mon, 23 Nov 2020 11:31:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS f902b216501094495ff75834035656e8119c537f
Message-ID: <5fbb2cff.z1RXaejZ5ZNEn/Mq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: f902b216501094495ff75834035656e8119c537f  ext4: fix bogus warning in ext4_update_dx_flag()

elapsed time: 722m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    adder875_defconfig
m68k                          atari_defconfig
arm                            hisi_defconfig
c6x                              alldefconfig
riscv                          rv32_defconfig
sh                          polaris_defconfig
powerpc                       ebony_defconfig
arm                         s3c6400_defconfig
mips                        omega2p_defconfig
um                           x86_64_defconfig
mips                     loongson1b_defconfig
mips                        jmr3927_defconfig
arm                          ep93xx_defconfig
mips                         rt305x_defconfig
sh                          landisk_defconfig
powerpc                    mvme5100_defconfig
arm                         s3c2410_defconfig
arm                          imote2_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20201122
x86_64               randconfig-a003-20201122
x86_64               randconfig-a004-20201122
x86_64               randconfig-a005-20201122
x86_64               randconfig-a001-20201122
x86_64               randconfig-a002-20201122
i386                 randconfig-a004-20201122
i386                 randconfig-a003-20201122
i386                 randconfig-a002-20201122
i386                 randconfig-a005-20201122
i386                 randconfig-a001-20201122
i386                 randconfig-a006-20201122
i386                 randconfig-a012-20201122
i386                 randconfig-a013-20201122
i386                 randconfig-a011-20201122
i386                 randconfig-a016-20201122
i386                 randconfig-a014-20201122
i386                 randconfig-a015-20201122
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201122
x86_64               randconfig-a011-20201122
x86_64               randconfig-a014-20201122
x86_64               randconfig-a016-20201122
x86_64               randconfig-a012-20201122
x86_64               randconfig-a013-20201122

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
