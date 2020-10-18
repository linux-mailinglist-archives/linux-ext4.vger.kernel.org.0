Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7485B291574
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Oct 2020 05:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbgJRDvP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 17 Oct 2020 23:51:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:8665 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgJRDvP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 17 Oct 2020 23:51:15 -0400
IronPort-SDR: GvSrWzt/nre2w1IZgHU+4OZEg8Omyu7omkTWdmspAbYtJYH7VUVxXVHCf6P8+yTgyTJKD51cY0
 RRTR+S/9pcQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9777"; a="146157116"
X-IronPort-AV: E=Sophos;i="5.77,388,1596524400"; 
   d="scan'208";a="146157116"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2020 20:51:09 -0700
IronPort-SDR: DnnIqhrjBgk/SkikCd6/kIRhAq+ZLX0GMEzSa6EVDPjkcp/SBu1JqOQ8NsXkt5XlwKTELsh4Dd
 96AB22p//YCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,388,1596524400"; 
   d="scan'208";a="331565490"
Received: from lkp-server02.sh.intel.com (HELO c383df7b95ee) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Oct 2020 20:51:08 -0700
Received: from kbuild by c383df7b95ee with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTzit-0000D5-TF; Sun, 18 Oct 2020 03:51:07 +0000
Date:   Sun, 18 Oct 2020 11:50:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 76f86a32ac6ff07a687743051e8fc04531e5a37d
Message-ID: <5f8bbba2.wp2IqPyxNxeJlHzC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 76f86a32ac6ff07a687743051e8fc04531e5a37d  ext4: Detect already used quota file early

elapsed time: 723m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     akebono_defconfig
arm                             pxa_defconfig
powerpc                     tqm8541_defconfig
powerpc                    mvme5100_defconfig
sh                           sh2007_defconfig
m68k                        mvme16x_defconfig
sparc64                             defconfig
mips                       capcella_defconfig
arm                         assabet_defconfig
mips                  decstation_64_defconfig
arm                          pxa168_defconfig
arm                        clps711x_defconfig
sh                 kfr2r09-romimage_defconfig
arm                      tct_hammer_defconfig
arm                   milbeaut_m10v_defconfig
riscv                            alldefconfig
parisc                generic-64bit_defconfig
arm                      footbridge_defconfig
powerpc                         wii_defconfig
arm                          lpd270_defconfig
arm                           sunxi_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
