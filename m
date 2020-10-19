Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A7B2921B3
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 06:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgJSEYe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 00:24:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:31089 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgJSEYe (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Oct 2020 00:24:34 -0400
IronPort-SDR: zpD4KlnobDcq6wo5VU3U1IkFA/0jLBF8ttidTpRwvPqlkkGZXRzU7/mOrKdV0G9J+Cni86KQUd
 6CzzGzU05KBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="231157449"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="231157449"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 21:24:28 -0700
IronPort-SDR: Y3SVvl88TQZ0lXCL88rfVqLwNNSmtFyjNMchcqHDt6xeTnng4DweHfKuiNrQ87Jw5klxfGGWqf
 XKEOQIE3UuqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="352867879"
Received: from lkp-server01.sh.intel.com (HELO 0318c0cac2d8) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Oct 2020 21:24:27 -0700
Received: from kbuild by 0318c0cac2d8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kUMih-0000Gi-4H; Mon, 19 Oct 2020 04:24:27 +0000
Date:   Mon, 19 Oct 2020 12:24:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 8d8282d4a35839e8a3c5c2e20ddcf860790880aa
Message-ID: <5f8d14f6.10cWHT7mm/c8y5PU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 8d8282d4a35839e8a3c5c2e20ddcf860790880aa  ext4: add fast commit stats in procfs

elapsed time: 720m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc834x_itx_defconfig
arc                         haps_hs_defconfig
sh                            titan_defconfig
arm                            hisi_defconfig
sh                           sh2007_defconfig
powerpc                        icon_defconfig
mips                        omega2p_defconfig
sh                              ul2_defconfig
xtensa                  nommu_kc705_defconfig
sh                          lboxre2_defconfig
mips                           gcw0_defconfig
arm                          gemini_defconfig
arc                     haps_hs_smp_defconfig
arm                       netwinder_defconfig
sparc64                          alldefconfig
mips                         tb0226_defconfig
sh                      rts7751r2d1_defconfig
powerpc                   motionpro_defconfig
mips                           ip28_defconfig
xtensa                         virt_defconfig
arc                        vdk_hs38_defconfig
powerpc                          g5_defconfig
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
i386                 randconfig-a006-20201018
i386                 randconfig-a005-20201018
i386                 randconfig-a001-20201018
i386                 randconfig-a003-20201018
i386                 randconfig-a004-20201018
i386                 randconfig-a002-20201018
x86_64               randconfig-a016-20201018
x86_64               randconfig-a015-20201018
x86_64               randconfig-a012-20201018
x86_64               randconfig-a013-20201018
x86_64               randconfig-a011-20201018
x86_64               randconfig-a014-20201018
i386                 randconfig-a015-20201018
i386                 randconfig-a013-20201018
i386                 randconfig-a016-20201018
i386                 randconfig-a012-20201018
i386                 randconfig-a011-20201018
i386                 randconfig-a014-20201018
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
x86_64               randconfig-a004-20201018
x86_64               randconfig-a002-20201018
x86_64               randconfig-a006-20201018
x86_64               randconfig-a003-20201018
x86_64               randconfig-a005-20201018
x86_64               randconfig-a001-20201018

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
