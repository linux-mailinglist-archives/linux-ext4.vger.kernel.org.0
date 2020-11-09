Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378552ABAD6
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Nov 2020 14:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbgKINVY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Nov 2020 08:21:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:56851 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbgKINVV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Nov 2020 08:21:21 -0500
IronPort-SDR: AfwWEmur0C8DaanKu+8FjiAamM304CSOvKGeUec8hCoAojSruaYq0+vDcHJYfmbUFrRBVBWpfT
 9FbCzjrOhB3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="166286899"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="166286899"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 05:21:19 -0800
IronPort-SDR: nn8tetSCZmIEK1N3AaNjOTJ00pu0PKrVpoU4L1YgIQAlmPrXYDmkBXsw5HWOtIcjlFHAi3Ou+P
 gfFpEAy+/7ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="354125007"
Received: from lkp-server01.sh.intel.com (HELO d0be80f1a028) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2020 05:21:18 -0800
Received: from kbuild by d0be80f1a028 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kc76c-0000C2-KJ; Mon, 09 Nov 2020 13:21:10 +0000
Date:   Mon, 09 Nov 2020 21:20:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 05d5233df85e9621597c5838e95235107eb624a2
Message-ID: <5fa94233.ddPPOcg3+skkz45X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 05d5233df85e9621597c5838e95235107eb624a2  jbd2: fix up sparse warnings in checkpoint code

elapsed time: 722m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                 simple_smp_defconfig
xtensa                  cadence_csp_defconfig
mips                      maltaaprp_defconfig
xtensa                generic_kc705_defconfig
arm                          iop32x_defconfig
arc                                 defconfig
mips                      fuloong2e_defconfig
sh                         microdev_defconfig
arm                            mmp2_defconfig
arm                          collie_defconfig
sh                        sh7757lcr_defconfig
m68k                        m5307c3_defconfig
arm                             rpc_defconfig
m68k                        m5272c3_defconfig
c6x                              alldefconfig
powerpc                      pmac32_defconfig
arm                          imote2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
sh                               allmodconfig
h8300                            allyesconfig
parisc                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201109
x86_64               randconfig-a002-20201109
x86_64               randconfig-a003-20201109
x86_64               randconfig-a005-20201109
x86_64               randconfig-a006-20201109
x86_64               randconfig-a001-20201109
i386                 randconfig-a004-20201109
i386                 randconfig-a006-20201109
i386                 randconfig-a005-20201109
i386                 randconfig-a001-20201109
i386                 randconfig-a003-20201109
i386                 randconfig-a002-20201109
i386                 randconfig-a014-20201109
i386                 randconfig-a015-20201109
i386                 randconfig-a016-20201109
i386                 randconfig-a011-20201109
i386                 randconfig-a012-20201109
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201109
x86_64               randconfig-a015-20201109
x86_64               randconfig-a013-20201109
x86_64               randconfig-a011-20201109
x86_64               randconfig-a014-20201109
x86_64               randconfig-a016-20201109

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
