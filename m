Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1235C199
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Apr 2021 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbhDLJbm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Apr 2021 05:31:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:49283 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241547AbhDLJ0Y (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 12 Apr 2021 05:26:24 -0400
IronPort-SDR: //xCBzjXUISKkBy5qH2GupK9F38yK3GzAHP/4wrUy6mF5MK/O6iagRXIzPoAumH+Kq3zTk2WJJ
 uKzL9xgr1SSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="193711986"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="193711986"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 02:23:07 -0700
IronPort-SDR: w4msSyw+ZXQTAfYOulD3jnHpjUh8vktJHOE3k7N1wxw9DCB57Iw85WBgHOjj/wYyx3n2Bx7CPi
 KhU/zaa7U2pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="531812677"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2021 02:23:06 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVsmf-0000Ma-BY; Mon, 12 Apr 2021 09:23:05 +0000
Date:   Mon, 12 Apr 2021 17:22:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS WITH WARNING
 fcdf3c34b7abdcbb49690c94c7fa6ce224dc9749
Message-ID: <6074113f.PxhlKGpE2bsY+otN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: fcdf3c34b7abdcbb49690c94c7fa6ce224dc9749  ext4: fix debug format string warning

possible Warning in current branch:

fs/ext4/mballoc.c:2966:13: sparse: sparse: context imbalance in 'ext4_mb_seq_structs_summary_start' - wrong count at exit

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-s031-20210412
|   `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_seq_structs_summary_start-wrong-count-at-exit
|-- x86_64-randconfig-s021-20210412
|   `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_seq_structs_summary_start-wrong-count-at-exit
`-- x86_64-randconfig-s022-20210412
    `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_seq_structs_summary_start-wrong-count-at-exit

elapsed time: 720m

configs tested: 140
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
nds32                            alldefconfig
powerpc                 mpc834x_itx_defconfig
arc                                 defconfig
sh                         apsh4a3a_defconfig
arm                   milbeaut_m10v_defconfig
arm                         nhk8815_defconfig
mips                           ip28_defconfig
mips                           ip27_defconfig
csky                             alldefconfig
arm                       spear13xx_defconfig
mips                           xway_defconfig
arc                           tb10x_defconfig
arm                         assabet_defconfig
ia64                             alldefconfig
powerpc                     pq2fads_defconfig
m68k                          atari_defconfig
mips                malta_qemu_32r6_defconfig
s390                             allmodconfig
arc                          axs101_defconfig
powerpc                     tqm8541_defconfig
arm64                            alldefconfig
m68k                          sun3x_defconfig
arm                          iop32x_defconfig
sh                                  defconfig
nds32                               defconfig
sh                           se7619_defconfig
arm                          pxa910_defconfig
m68k                             allyesconfig
h8300                       h8s-sim_defconfig
m68k                          hp300_defconfig
sh                          polaris_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      pasemi_defconfig
m68k                       bvme6000_defconfig
arm                        vexpress_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7751_defconfig
powerpc                      cm5200_defconfig
x86_64                           alldefconfig
arm                             ezx_defconfig
alpha                               defconfig
powerpc                     kmeter1_defconfig
mips                          rm200_defconfig
sparc                       sparc64_defconfig
arm                        magician_defconfig
arc                              alldefconfig
powerpc                mpc7448_hpc2_defconfig
arm                         shannon_defconfig
sh                   secureedge5410_defconfig
arm                         mv78xx0_defconfig
powerpc                   currituck_defconfig
h8300                    h8300h-sim_defconfig
m68k                         amcore_defconfig
microblaze                          defconfig
m68k                        m5307c3_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            mmp2_defconfig
arm                       cns3420vb_defconfig
arm                            dove_defconfig
mips                            e55_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
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
i386                 randconfig-a003-20210412
i386                 randconfig-a001-20210412
i386                 randconfig-a006-20210412
i386                 randconfig-a005-20210412
i386                 randconfig-a004-20210412
i386                 randconfig-a002-20210412
x86_64               randconfig-a014-20210412
x86_64               randconfig-a015-20210412
x86_64               randconfig-a011-20210412
x86_64               randconfig-a013-20210412
x86_64               randconfig-a012-20210412
x86_64               randconfig-a016-20210412
i386                 randconfig-a015-20210412
i386                 randconfig-a014-20210412
i386                 randconfig-a013-20210412
i386                 randconfig-a012-20210412
i386                 randconfig-a016-20210412
i386                 randconfig-a011-20210412
x86_64               randconfig-a003-20210411
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210411
x86_64               randconfig-a015-20210411
x86_64               randconfig-a011-20210411
x86_64               randconfig-a013-20210411
x86_64               randconfig-a012-20210411
x86_64               randconfig-a016-20210411
x86_64               randconfig-a003-20210412
x86_64               randconfig-a002-20210412
x86_64               randconfig-a001-20210412
x86_64               randconfig-a005-20210412
x86_64               randconfig-a006-20210412
x86_64               randconfig-a004-20210412

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
