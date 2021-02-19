Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAD531F994
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 13:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBSMwS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 07:52:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:4496 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSMwO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 19 Feb 2021 07:52:14 -0500
IronPort-SDR: ze2/b9YDcg3njAhndwqSF/5mHZfCMM2FEOaKls8uraguso2AUsMNpbhUK2e3DiljwhoFXn6nUj
 t/WHMdFlHEXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="268685177"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="268685177"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 04:51:33 -0800
IronPort-SDR: rulaPnrJr1/O6X8NGGi4pm7HrS4O7oZhaboON30yS72NFDyg4aXrbecMBayBDmRF8h5NmeaZ/p
 ajobtkG9gBNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="428829477"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 19 Feb 2021 04:51:32 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lD5Fr-000APT-I3; Fri, 19 Feb 2021 12:51:31 +0000
Date:   Fri, 19 Feb 2021 20:51:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS WITH WARNING
 0a76945fd1ba2ab44da7b578b311efdfedf92e6c
Message-ID: <602fb447.FAPCH6QPs6uX6CEd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 0a76945fd1ba2ab44da7b578b311efdfedf92e6c  ext4: add .kunitconfig fragment to enable ext4-specific tests

possible Warning in current branch:

fs/ext4/extents.c:4456 ext4_alloc_file_blocks() error: uninitialized symbol 'ret'.

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20210215
|   `-- fs-ext4-extents.c-ext4_alloc_file_blocks()-error:uninitialized-symbol-ret-.
`-- x86_64-randconfig-m001-20210218
    `-- fs-ext4-extents.c-ext4_alloc_file_blocks()-error:uninitialized-symbol-ret-.

elapsed time: 720m

configs tested: 137
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          amiga_defconfig
powerpc                     ep8248e_defconfig
powerpc                          g5_defconfig
c6x                              alldefconfig
powerpc                      pasemi_defconfig
m68k                        mvme147_defconfig
xtensa                           alldefconfig
arm                          pxa910_defconfig
arc                     nsimosci_hs_defconfig
sh                   sh7724_generic_defconfig
mips                       capcella_defconfig
m68k                            mac_defconfig
ia64                             allyesconfig
arm                          collie_defconfig
arm                              zx_defconfig
powerpc                       holly_defconfig
riscv                             allnoconfig
c6x                        evmc6472_defconfig
powerpc                     kilauea_defconfig
arc                          axs103_defconfig
m68k                       m5475evb_defconfig
powerpc                      obs600_defconfig
powerpc                      ppc6xx_defconfig
sparc                       sparc32_defconfig
sh                           sh2007_defconfig
arm                             pxa_defconfig
arm                       omap2plus_defconfig
m68k                        mvme16x_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                            alldefconfig
riscv                    nommu_virt_defconfig
mips                      maltaaprp_defconfig
arm                     eseries_pxa_defconfig
m68k                        m5307c3_defconfig
sh                             sh03_defconfig
powerpc                      cm5200_defconfig
arm                           stm32_defconfig
mips                      malta_kvm_defconfig
powerpc                     skiroot_defconfig
arm                         bcm2835_defconfig
arm                            mps2_defconfig
sh                        sh7757lcr_defconfig
nios2                         10m50_defconfig
m68k                          sun3x_defconfig
arm                           tegra_defconfig
mips                        nlm_xlp_defconfig
sh                          rsk7264_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     kmeter1_defconfig
arm                          simpad_defconfig
s390                       zfcpdump_defconfig
m68k                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
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
s390                             allmodconfig
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
x86_64               randconfig-a003-20210218
x86_64               randconfig-a001-20210218
x86_64               randconfig-a004-20210218
x86_64               randconfig-a002-20210218
x86_64               randconfig-a005-20210218
x86_64               randconfig-a006-20210218
i386                 randconfig-a005-20210218
i386                 randconfig-a003-20210218
i386                 randconfig-a002-20210218
i386                 randconfig-a004-20210218
i386                 randconfig-a001-20210218
i386                 randconfig-a006-20210218
x86_64               randconfig-a013-20210217
x86_64               randconfig-a016-20210217
x86_64               randconfig-a012-20210217
x86_64               randconfig-a015-20210217
x86_64               randconfig-a014-20210217
x86_64               randconfig-a011-20210217
i386                 randconfig-a016-20210219
i386                 randconfig-a012-20210219
i386                 randconfig-a014-20210219
i386                 randconfig-a013-20210219
i386                 randconfig-a011-20210219
i386                 randconfig-a015-20210219
i386                 randconfig-a016-20210218
i386                 randconfig-a012-20210218
i386                 randconfig-a014-20210218
i386                 randconfig-a013-20210218
i386                 randconfig-a011-20210218
i386                 randconfig-a015-20210218
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210218
x86_64               randconfig-a016-20210218
x86_64               randconfig-a013-20210218
x86_64               randconfig-a015-20210218
x86_64               randconfig-a011-20210218
x86_64               randconfig-a014-20210218

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
