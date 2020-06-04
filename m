Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711B81EE4A4
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jun 2020 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgFDMlI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Jun 2020 08:41:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:59379 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgFDMlI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 4 Jun 2020 08:41:08 -0400
IronPort-SDR: Q/jArQWTYAiarAtfuUjsllB/84taFKATT8Cbhe+/VJDhC13cGDiPSxEUccMp+bOz8Fx8X2PCKO
 Cp3/QLZ7Ryrg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 05:41:07 -0700
IronPort-SDR: gFjYo6tafnnd29ufiJ3RAnTKQ4WE3PEJEftRNlLqXFvzRoO8OjgVyrx7rv7wO/nLqxYm1DVCVQ
 M+P9jcsHpoFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,472,1583222400"; 
   d="scan'208";a="471517373"
Received: from lkp-server01.sh.intel.com (HELO 54ff842e15fb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2020 05:41:06 -0700
Received: from kbuild by 54ff842e15fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgpBC-00003S-5J; Thu, 04 Jun 2020 12:41:06 +0000
Date:   Thu, 04 Jun 2020 20:40:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 6b8ed62008a49751fc71fefd2a4f89202a7c2d4d
Message-ID: <5ed8ebb7.+g8AvTMZFrTF24HF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 6b8ed62008a49751fc71fefd2a4f89202a7c2d4d  ext4: avoid unnecessary transaction starts during writeback

Warning in current branch:

fs/ext4/mballoc.c:2209:9: sparse: sparse: context imbalance in 'ext4_mb_good_group_nolock' - different lock contexts for basic block

Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-randconfig-s021-20200603
    `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block

elapsed time: 560m

configs tested: 93
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm                           h3600_defconfig
mips                malta_qemu_32r6_defconfig
microblaze                      mmu_defconfig
arm                         hackkit_defconfig
sh                         apsh4a3a_defconfig
arm                            mmp2_defconfig
arm                        neponset_defconfig
arm                         orion5x_defconfig
arm                         ebsa110_defconfig
arm                          moxart_defconfig
arm                     eseries_pxa_defconfig
arm                           stm32_defconfig
arm                     am200epdkit_defconfig
powerpc                    gamecube_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
