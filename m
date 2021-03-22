Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18363446BB
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Mar 2021 15:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCVOIB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Mar 2021 10:08:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:33862 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhCVOHi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 22 Mar 2021 10:07:38 -0400
IronPort-SDR: yseR64xy1xRzfpXusSU0DLwL0vBnt4MVh8auBZg3NbPew/F3Zd3EhKjHEngDPMpy8PspqTDO4h
 LG/vxOiCbczg==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="210345267"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="210345267"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 07:07:36 -0700
IronPort-SDR: epunZLNdL0/AdQKIn1uf/tEAnTsYH98DxXbg4dnY/Wygkyh3VLVQhMLy/YJBhKIZDiinwTHo0L
 eJrHAV5alylw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="390489351"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2021 07:07:32 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lOLDP-00008Y-Ux; Mon, 22 Mar 2021 14:07:31 +0000
Date:   Mon, 22 Mar 2021 22:07:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 64395d950bc476106b39341e42ebfd4d2eb71d2c
Message-ID: <6058a498.HAdckwWriSxc7mbb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 64395d950bc476106b39341e42ebfd4d2eb71d2c  ext4: initialize ret to suppress smatch warning

elapsed time: 725m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
arm                         socfpga_defconfig
m68k                         apollo_defconfig
parisc                generic-64bit_defconfig
xtensa                       common_defconfig
powerpc                 mpc837x_mds_defconfig
sh                                  defconfig
sh                          urquell_defconfig
xtensa                    xip_kc705_defconfig
sh                        sh7757lcr_defconfig
m68k                        m5407c3_defconfig
sh                          polaris_defconfig
powerpc                      mgcoge_defconfig
mips                      pic32mzda_defconfig
powerpc                      arches_defconfig
arm                            mmp2_defconfig
riscv                               defconfig
m68k                       m5475evb_defconfig
mips                          rm200_defconfig
alpha                            allyesconfig
powerpc                     skiroot_defconfig
arc                          axs103_defconfig
arm                            zeus_defconfig
arm                        mvebu_v7_defconfig
s390                                defconfig
mips                        workpad_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                          amiga_defconfig
x86_64                              defconfig
sh                              ul2_defconfig
ia64                      gensparse_defconfig
nds32                            alldefconfig
arm                          pcm027_defconfig
powerpc                       ppc64_defconfig
mips                       lemote2f_defconfig
arm                     eseries_pxa_defconfig
arm                      tct_hammer_defconfig
powerpc                      walnut_defconfig
arm                      footbridge_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    klondike_defconfig
sh                        dreamcast_defconfig
powerpc                     kilauea_defconfig
mips                           ip27_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     kmeter1_defconfig
sh                     magicpanelr2_defconfig
i386                                defconfig
ia64                          tiger_defconfig
arm                        vexpress_defconfig
mips                         db1xxx_defconfig
arm                       versatile_defconfig
arm                            dove_defconfig
mips                        vocore2_defconfig
mips                      fuloong2e_defconfig
sh                          r7780mp_defconfig
mips                        bcm47xx_defconfig
powerpc                        icon_defconfig
mips                           ip28_defconfig
arm                          simpad_defconfig
powerpc                 mpc8272_ads_defconfig
mips                            gpr_defconfig
sh                           se7619_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc8315_rdb_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210322
i386                 randconfig-a003-20210322
i386                 randconfig-a001-20210322
i386                 randconfig-a002-20210322
i386                 randconfig-a006-20210322
i386                 randconfig-a005-20210322
x86_64               randconfig-a012-20210322
x86_64               randconfig-a015-20210322
x86_64               randconfig-a013-20210322
x86_64               randconfig-a014-20210322
x86_64               randconfig-a016-20210322
x86_64               randconfig-a011-20210322
i386                 randconfig-a014-20210322
i386                 randconfig-a011-20210322
i386                 randconfig-a015-20210322
i386                 randconfig-a016-20210322
i386                 randconfig-a012-20210322
i386                 randconfig-a013-20210322
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210322
x86_64               randconfig-a003-20210322
x86_64               randconfig-a001-20210322
x86_64               randconfig-a006-20210322
x86_64               randconfig-a004-20210322
x86_64               randconfig-a005-20210322

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
