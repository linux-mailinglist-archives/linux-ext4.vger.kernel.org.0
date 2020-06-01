Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54D1E9D26
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jun 2020 07:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgFAFTQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Jun 2020 01:19:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:8417 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgFAFTP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 1 Jun 2020 01:19:15 -0400
IronPort-SDR: bEPxAdhv4L2RcpE9aJlJ/CF9caMXQWLDRubzaTbnrLWzgAUkJoKFO8Phb3heh+mOls/L/CUU3Y
 /PQF/SI4ra2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:19:11 -0700
IronPort-SDR: vDmqgcYnTyitAAuMZtBPkKeBG4yZlulLGIeVaex6XjJY65lO7cwhujMwB5GhTRXLcVwdH1QpPe
 sE3S9gsxFvOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="286163354"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 May 2020 22:19:10 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfcqr-0000Ec-Fe; Mon, 01 Jun 2020 05:19:09 +0000
Date:   Mon, 01 Jun 2020 13:18:23 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 38bd76b9696c5582dcef4ab1af437e0666021f65
Message-ID: <5ed48f9f.pv0w9Bx5zgTYVA1H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 38bd76b9696c5582dcef4ab1af437e0666021f65  Merge branch 'ext4-dax' into dev

Warning in current branch:

fs/ext4/mballoc.c:2209:9: sparse: sparse: context imbalance in 'ext4_mb_good_group_nolock' - different lock contexts for basic block

Warning ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-s001-20200531
|   `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block
|-- i386-randconfig-s002-20200531
|   `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block
|-- microblaze-randconfig-s032-20200529
|   `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block
|-- x86_64-randconfig-s022-20200529
|   `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block
`-- x86_64-randconfig-s022-20200531
    `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block

elapsed time: 4240m

configs tested: 159
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                          pxa3xx_defconfig
arm                         palmz72_defconfig
sh                            shmin_defconfig
ia64                            zx1_defconfig
riscv                          rv32_defconfig
powerpc                      pasemi_defconfig
sparc                       sparc64_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
mips                              allnoconfig
mips                        qi_lb60_defconfig
sh                            migor_defconfig
sh                     magicpanelr2_defconfig
mips                   sb1250_swarm_defconfig
powerpc                  mpc885_ads_defconfig
arm                       aspeed_g5_defconfig
mips                        maltaup_defconfig
arc                             nps_defconfig
sh                          rsk7269_defconfig
ia64                        generic_defconfig
mips                             allyesconfig
arm                       mainstone_defconfig
arm                            hisi_defconfig
powerpc                     mpc83xx_defconfig
m68k                          multi_defconfig
m68k                             allyesconfig
arm                         ebsa110_defconfig
arm                            lart_defconfig
sh                         microdev_defconfig
x86_64                              defconfig
arm                          badge4_defconfig
arm                        oxnas_v6_defconfig
powerpc                     pseries_defconfig
arm                            dove_defconfig
h8300                            alldefconfig
arm                            pleb_defconfig
sh                             espt_defconfig
arm                           omap1_defconfig
arm                       spear13xx_defconfig
sparc64                          allyesconfig
microblaze                    nommu_defconfig
powerpc                             defconfig
arc                           tb10x_defconfig
arm                        mvebu_v7_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
openrisc                            defconfig
mips                          rb532_defconfig
arm                         assabet_defconfig
arc                              alldefconfig
xtensa                       common_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200529
i386                 randconfig-a001-20200529
i386                 randconfig-a002-20200529
i386                 randconfig-a006-20200529
i386                 randconfig-a003-20200529
i386                 randconfig-a005-20200529
i386                 randconfig-a004-20200531
i386                 randconfig-a003-20200531
i386                 randconfig-a006-20200531
i386                 randconfig-a002-20200531
i386                 randconfig-a005-20200531
i386                 randconfig-a001-20200531
x86_64               randconfig-a011-20200531
x86_64               randconfig-a016-20200531
x86_64               randconfig-a012-20200531
x86_64               randconfig-a014-20200531
x86_64               randconfig-a013-20200531
x86_64               randconfig-a015-20200531
i386                 randconfig-a013-20200529
i386                 randconfig-a011-20200529
i386                 randconfig-a012-20200529
i386                 randconfig-a015-20200529
i386                 randconfig-a016-20200529
i386                 randconfig-a014-20200529
i386                 randconfig-a013-20200531
i386                 randconfig-a012-20200531
i386                 randconfig-a015-20200531
i386                 randconfig-a011-20200531
i386                 randconfig-a016-20200531
i386                 randconfig-a014-20200531
x86_64               randconfig-a002-20200529
x86_64               randconfig-a006-20200529
x86_64               randconfig-a005-20200529
x86_64               randconfig-a001-20200529
x86_64               randconfig-a004-20200529
x86_64               randconfig-a003-20200529
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
