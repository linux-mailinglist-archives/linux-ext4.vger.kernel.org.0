Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA429649F
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 20:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900548AbgJVSXq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Oct 2020 14:23:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:8634 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900273AbgJVSXq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 22 Oct 2020 14:23:46 -0400
IronPort-SDR: gtxmInKgadbhRy+EPjNaycDuxZDdBIpogpcp6bVXjRcAIb6eM0frCrwMSF9sxzXdQc89PrGEt9
 2CbYGkqtsm/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="164979630"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="164979630"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 11:23:45 -0700
IronPort-SDR: ooDxcYUXlCCfjTlZW02LWZiZDHmmVKVJgL/hBOJuvocUjdQArYng/PjmVLBUnS5avoHh+Bj+pX
 TJaJu5E22dyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="466782448"
Received: from lkp-server01.sh.intel.com (HELO 56e21eaf2661) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Oct 2020 11:23:44 -0700
Received: from kbuild by 56e21eaf2661 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kVfFX-00003q-JI; Thu, 22 Oct 2020 18:23:43 +0000
Date:   Fri, 23 Oct 2020 02:22:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS WITH WARNING
 1322181170bb01bce3c228b82ae3d5c6b793164f
Message-ID: <5f91cdfa.qCU1TA7maY4yduBn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 1322181170bb01bce3c228b82ae3d5c6b793164f  ext4: fix invalid inode checksum

Warning in current branch:

fs/ext4/fast_commit.c:964 ext4_fc_commit_dentry_updates() error: double locked 'sbi->s_fc_lock' (orig line 955)

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-m001-20201022
    `-- fs-ext4-fast_commit.c-ext4_fc_commit_dentry_updates()-error:double-locked-sbi-s_fc_lock-(orig-line-)

elapsed time: 766m

configs tested: 85
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
mips                malta_kvm_guest_defconfig
powerpc                      chrp32_defconfig
mips                         bigsur_defconfig
xtensa                  audio_kc705_defconfig
mips                       rbtx49xx_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                   motionpro_defconfig
powerpc                   bluestone_defconfig
arm                        neponset_defconfig
powerpc                    amigaone_defconfig
arm                            xcep_defconfig
powerpc                     sequoia_defconfig
mips                        vocore2_defconfig
mips                           ip22_defconfig
arm                            qcom_defconfig
powerpc                 mpc8560_ads_defconfig
sh                  sh7785lcr_32bit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                               defconfig
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
i386                 randconfig-a002-20201021
i386                 randconfig-a005-20201021
i386                 randconfig-a003-20201021
i386                 randconfig-a001-20201021
i386                 randconfig-a006-20201021
i386                 randconfig-a004-20201021
x86_64               randconfig-a001-20201021
x86_64               randconfig-a002-20201021
x86_64               randconfig-a003-20201021
x86_64               randconfig-a006-20201021
x86_64               randconfig-a005-20201021
x86_64               randconfig-a004-20201021
i386                 randconfig-a016-20201021
i386                 randconfig-a014-20201021
i386                 randconfig-a015-20201021
i386                 randconfig-a013-20201021
i386                 randconfig-a012-20201021
i386                 randconfig-a011-20201021
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
