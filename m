Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E181D2DC590
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 18:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgLPRqp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 12:46:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:37764 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgLPRqp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 12:46:45 -0500
IronPort-SDR: trwjuDz1SWxQJojUCJ7/86G8zqW1C8olPVEos3Tr8vBhh0UMIZgLRG7dUdIyTUE+rcJFwt4nho
 IjRsc4EnWTYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="162851438"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="162851438"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 09:46:04 -0800
IronPort-SDR: tBOIxFpXzmrdO89Z37WLBvEXK96duzOXYbxynDlybfsihwC8ONcB0gIHAQnZfbnQRgqHVeibHy
 0xadomd81Mxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="369205792"
Received: from lkp-server02.sh.intel.com (HELO 070e1a605002) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 16 Dec 2020 09:46:03 -0800
Received: from kbuild by 070e1a605002 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpasE-000086-BM; Wed, 16 Dec 2020 17:46:02 +0000
Date:   Thu, 17 Dec 2020 01:45:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 9f08aedbfeebb4ac266c7f67ca5a412a53d43441
Message-ID: <5fda47a4.zenqf71f4LtvWUqj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 9f08aedbfeebb4ac266c7f67ca5a412a53d43441  ext4: defer saving error info from atomic context

elapsed time: 720m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
arm                           efm32_defconfig
powerpc                  mpc885_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                           tb10x_defconfig
powerpc                     ksi8560_defconfig
powerpc                      katmai_defconfig
arm                        mvebu_v7_defconfig
riscv                             allnoconfig
powerpc                     tqm8548_defconfig
powerpc                     kilauea_defconfig
powerpc                      ppc44x_defconfig
c6x                        evmc6457_defconfig
arm                            zeus_defconfig
xtensa                         virt_defconfig
powerpc                    klondike_defconfig
m68k                            mac_defconfig
mips                      maltasmvp_defconfig
sh                          kfr2r09_defconfig
m68k                        m5407c3_defconfig
mips                          rb532_defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20201216
i386                 randconfig-a004-20201216
i386                 randconfig-a003-20201216
i386                 randconfig-a002-20201216
i386                 randconfig-a006-20201216
i386                 randconfig-a005-20201216
x86_64               randconfig-a016-20201216
x86_64               randconfig-a012-20201216
x86_64               randconfig-a013-20201216
x86_64               randconfig-a015-20201216
x86_64               randconfig-a014-20201216
x86_64               randconfig-a011-20201216
i386                 randconfig-a014-20201216
i386                 randconfig-a013-20201216
i386                 randconfig-a012-20201216
i386                 randconfig-a011-20201216
i386                 randconfig-a015-20201216
i386                 randconfig-a016-20201216
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
