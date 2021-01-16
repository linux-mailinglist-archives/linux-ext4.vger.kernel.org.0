Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9407C2F8C2D
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Jan 2021 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbhAPIEy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 16 Jan 2021 03:04:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:7804 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAPIEy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 16 Jan 2021 03:04:54 -0500
IronPort-SDR: PDd34cqMrFiCQpA4hDkyDYZ7Daf0J9jwFDxOjVWdwUbKxNGnnwE2s1quq31ucdK4tEEXBPKeJy
 +U1B1XEWpHwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="197325573"
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="197325573"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2021 00:04:10 -0800
IronPort-SDR: IstyItBqV3iWXVtD5IXUV6IXlzDHv5aWFGX4Mq9s13hvh2jOIld3CGCvJz8kwLcTuJNRYP1XW7
 RsL7U8YNgOUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="398593582"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jan 2021 00:04:09 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0gZ5-0000o5-Sn; Sat, 16 Jan 2021 08:04:07 +0000
Date:   Sat, 16 Jan 2021 16:03:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS e9f53353e166a67dfe4f8295100f8ac39d6cf10b
Message-ID: <60029dc4.bbN3+ntpiUxCQlEQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: e9f53353e166a67dfe4f8295100f8ac39d6cf10b  ext4: remove expensive flush on fast commit

elapsed time: 726m

configs tested: 132
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                        edosk7760_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm8560_defconfig
arm                           viper_defconfig
xtensa                  cadence_csp_defconfig
mips                  cavium_octeon_defconfig
powerpc                      ppc6xx_defconfig
c6x                              alldefconfig
arc                        nsimosci_defconfig
mips                         rt305x_defconfig
sh                      rts7751r2d1_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           h3600_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          gemini_defconfig
mips                     decstation_defconfig
csky                             alldefconfig
arm                           h5000_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         cobalt_defconfig
sh                          r7785rp_defconfig
arm                          pcm027_defconfig
sparc64                          alldefconfig
arm                            mps2_defconfig
nios2                            alldefconfig
sh                          rsk7264_defconfig
c6x                                 defconfig
sh                               j2_defconfig
mips                          ath25_defconfig
sh                   rts7751r2dplus_defconfig
m68k                         apollo_defconfig
m68k                        m5407c3_defconfig
arm                            pleb_defconfig
m68k                        mvme147_defconfig
arc                                 defconfig
sh                          kfr2r09_defconfig
powerpc                  storcenter_defconfig
riscv                             allnoconfig
arm                          pxa910_defconfig
powerpc                       maple_defconfig
sh                ecovec24-romimage_defconfig
sparc                       sparc64_defconfig
sh                        dreamcast_defconfig
openrisc                    or1ksim_defconfig
mips                         db1xxx_defconfig
powerpc                       holly_defconfig
csky                                defconfig
mips                       rbtx49xx_defconfig
sh                           se7206_defconfig
powerpc                 mpc8560_ads_defconfig
mips                     loongson1c_defconfig
c6x                         dsk6455_defconfig
m68k                             allmodconfig
mips                           jazz_defconfig
sh                            titan_defconfig
arm                      tct_hammer_defconfig
sh                         apsh4a3a_defconfig
arc                        nsim_700_defconfig
arm                        mini2440_defconfig
sh                           se7780_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
x86_64               randconfig-a004-20210115
x86_64               randconfig-a006-20210115
x86_64               randconfig-a001-20210115
x86_64               randconfig-a003-20210115
x86_64               randconfig-a005-20210115
x86_64               randconfig-a002-20210115
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
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
