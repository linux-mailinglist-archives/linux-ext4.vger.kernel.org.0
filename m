Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE8288BC0
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 16:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbgJIOoR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 10:44:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:15637 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387662AbgJIOoQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Oct 2020 10:44:16 -0400
IronPort-SDR: SurwuXIIoL3BWJe4mOcpAYaUsRKGO+7YcqrOniFTulicWsWxlgW0Sd4PMVAOix2TQjEa5lGPSq
 Nsg/ssnX897w==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="153325952"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="153325952"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 07:44:15 -0700
IronPort-SDR: fHPYqDqoxI0JI/NDd1jywllvxYX30JXdJ00BQXkFNe5NgUXYTGNPoYflktpfLeOoJBEWPBYEym
 qgYKo8GxGKXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="354872912"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Oct 2020 07:44:14 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQtcz-0000ZR-AC; Fri, 09 Oct 2020 14:44:13 +0000
Date:   Fri, 09 Oct 2020 22:44:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS WITH WARNING
 ab7b179af3f98772f2433ddc4ace6b7924a4e862
Message-ID: <5f807732.4D2JzwOY6J4y1O8f%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: ab7b179af3f98772f2433ddc4ace6b7924a4e862  Merge branch 'hs/fast-commit-v9' into dev

Warning in current branch:

fs/ext4/fast_commit.c:1079:6: warning: variable 'start_time' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
fs/ext4/fast_commit.c:1079:6: warning: variable 'start_time' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
fs/ext4/fast_commit.c:1135 ext4_fc_commit() error: uninitialized symbol 'start_time'.
fs/ext4/fast_commit.c:1787:6: warning: no previous prototype for function 'ext4_fc_set_bitmaps_and_counters' [-Wmissing-prototypes]
fs/ext4/mballoc.c:5221:6: warning: no previous prototype for function 'ext4_free_blocks_simple' [-Wmissing-prototypes]
fs/jbd2/recovery.c:258:6: warning: variable 'seq' is uninitialized when used here [-Wuninitialized]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-m021-20201009
    `-- fs-ext4-fast_commit.c-ext4_fc_commit()-error:uninitialized-symbol-start_time-.

clang_recent_errors
|-- s390-randconfig-r004-20201009
|   |-- fs-ext4-fast_commit.c:warning:variable-start_time-is-used-uninitialized-whenever-condition-is-true
|   `-- fs-jbd2-recovery.c:warning:variable-seq-is-uninitialized-when-used-here
`-- x86_64-randconfig-a004-20201009
    |-- fs-ext4-fast_commit.c:warning:no-previous-prototype-for-function-ext4_fc_set_bitmaps_and_counters
    |-- fs-ext4-fast_commit.c:warning:variable-start_time-is-used-uninitialized-whenever-condition-is-true
    |-- fs-ext4-fast_commit.c:warning:variable-start_time-is-used-uninitialized-whenever-if-condition-is-true
    |-- fs-ext4-mballoc.c:warning:no-previous-prototype-for-function-ext4_free_blocks_simple
    `-- fs-jbd2-recovery.c:warning:variable-seq-is-uninitialized-when-used-here

elapsed time: 720m

configs tested: 108
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc832x_mds_defconfig
arm                        mvebu_v5_defconfig
arm                           omap1_defconfig
mips                   sb1250_swarm_defconfig
s390                                defconfig
arm                  colibri_pxa300_defconfig
arm                          moxart_defconfig
arm                            u300_defconfig
mips                      maltasmvp_defconfig
arm                          simpad_defconfig
arm                         ebsa110_defconfig
ia64                        generic_defconfig
x86_64                           alldefconfig
arm                      pxa255-idp_defconfig
mips                            e55_defconfig
powerpc                   currituck_defconfig
arm                           tegra_defconfig
mips                            gpr_defconfig
mips                      loongson3_defconfig
arm                          collie_defconfig
arm                         nhk8815_defconfig
arm                         lpc18xx_defconfig
openrisc                         alldefconfig
mips                      pic32mzda_defconfig
arm                          pxa168_defconfig
arm                         cm_x300_defconfig
powerpc                      pcm030_defconfig
arm                       cns3420vb_defconfig
powerpc                      bamboo_defconfig
powerpc                      katmai_defconfig
powerpc                     ksi8560_defconfig
sh                 kfr2r09-romimage_defconfig
ia64                             alldefconfig
arm                        oxnas_v6_defconfig
arm                        trizeps4_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
riscv                    nommu_k210_defconfig
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
