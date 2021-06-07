Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA8339D332
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 04:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFGC7L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Jun 2021 22:59:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:64296 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhFGC7L (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 6 Jun 2021 22:59:11 -0400
IronPort-SDR: aVcTHpN86kE+05qxlRmL4/3soKgvI2gSb2BG+5Dv/lZMBZsuTwQDt7adwtkertsz4VGmynpRJF
 ULWRi4hTm5vA==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="225885003"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="225885003"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 19:57:19 -0700
IronPort-SDR: REw7+WUe+zI7z6QnSVAh8gJfrcN2KtO+T0EZ0f8e/zYhBZ8qIjvrOo7Sv7lolB3+EGBzEzLlpH
 TS/dMa50gtPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="484611854"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2021 19:57:18 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lq5S1-00089q-SP; Mon, 07 Jun 2021 02:57:17 +0000
Date:   Mon, 07 Jun 2021 10:56:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS WITH WARNING
 a492dedb708d287aac857c6799f6f364f3d914b3
Message-ID: <60bd8ad2.86bZkVn/YyzrrEb9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: a492dedb708d287aac857c6799f6f364f3d914b3  ext4: update journal documentation

possible Warning in current branch:

fs/jbd2/journal.c:1718 __jbd2_journal_erase() warn: maybe use && instead of &
fs/jbd2/journal.c:1718:40: sparse: sparse: dubious: x & !y

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-m031-20210604
|   `-- fs-jbd2-journal.c-__jbd2_journal_erase()-warn:maybe-use-instead-of
`-- sh-randconfig-s031-20210606
    `-- fs-jbd2-journal.c:sparse:sparse:dubious:x-y

elapsed time: 724m

configs tested: 96
configs skipped: 2

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                            shmin_defconfig
h8300                    h8300h-sim_defconfig
arc                          axs101_defconfig
arc                                 defconfig
powerpc                    klondike_defconfig
sh                          r7785rp_defconfig
powerpc                     sbc8548_defconfig
powerpc                     tqm8548_defconfig
powerpc                   lite5200b_defconfig
powerpc                     taishan_defconfig
um                               alldefconfig
um                                  defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7721_defconfig
ia64                        generic_defconfig
arc                        nsim_700_defconfig
arm                     am200epdkit_defconfig
openrisc                    or1ksim_defconfig
x86_64                            allnoconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210606
x86_64               randconfig-a004-20210606
x86_64               randconfig-a003-20210606
x86_64               randconfig-a006-20210606
x86_64               randconfig-a005-20210606
x86_64               randconfig-a001-20210606
i386                 randconfig-a003-20210606
i386                 randconfig-a006-20210606
i386                 randconfig-a004-20210606
i386                 randconfig-a001-20210606
i386                 randconfig-a005-20210606
i386                 randconfig-a002-20210606
i386                 randconfig-a015-20210606
i386                 randconfig-a013-20210606
i386                 randconfig-a016-20210606
i386                 randconfig-a011-20210606
i386                 randconfig-a014-20210606
i386                 randconfig-a012-20210606
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210606
x86_64               randconfig-a015-20210606
x86_64               randconfig-a011-20210606
x86_64               randconfig-a014-20210606
x86_64               randconfig-a012-20210606
x86_64               randconfig-a016-20210606
x86_64               randconfig-a013-20210606

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
