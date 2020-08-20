Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354FB24C481
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Aug 2020 19:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgHTR2d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Aug 2020 13:28:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:61958 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgHTR2d (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Aug 2020 13:28:33 -0400
IronPort-SDR: y+LbFV0Cxmvr0Z1ECKy8yrnIB85h3UhMvxBJmVMPzavor9IIPtPnoSyV6fy9GoqQgeYkPPHMwW
 nFcwmF/vz1kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="143162844"
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="143162844"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 10:28:32 -0700
IronPort-SDR: /FJLW/J+/Q8fwmtLF/yt0d6CxWpE+Mv7/4NTL2KQL3+t801kzydxfFb5EZ/2ZIEG8rbfSElUaH
 14KYe4G+kUtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="280049786"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Aug 2020 10:28:30 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k8oMY-0000BR-9c; Thu, 20 Aug 2020 17:28:30 +0000
Date:   Fri, 21 Aug 2020 01:28:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [ext4:dev] BUILD SUCCESS 27bc446e2def38db3244a6eb4bb1d6312936610a
Message-ID: <5f3eb2aa.D4SfozKBAYAIWJHo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
branch HEAD: 27bc446e2def38db3244a6eb4bb1d6312936610a  ext4: limit the length of per-inode prealloc list

elapsed time: 722m

configs tested: 90
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
powerpc                     powernv_defconfig
arm                          pcm027_defconfig
arm                        mvebu_v7_defconfig
arm                          pxa168_defconfig
powerpc                     skiroot_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc8272_ads_defconfig
parisc                              defconfig
m68k                        mvme16x_defconfig
sh                        apsh4ad0a_defconfig
m68k                             allyesconfig
arm                         vf610m4_defconfig
arm                           h5000_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
powerpc                             defconfig
i386                 randconfig-a005-20200818
i386                 randconfig-a002-20200818
i386                 randconfig-a001-20200818
i386                 randconfig-a006-20200818
i386                 randconfig-a003-20200818
i386                 randconfig-a004-20200818
i386                 randconfig-a002-20200820
i386                 randconfig-a004-20200820
i386                 randconfig-a005-20200820
i386                 randconfig-a003-20200820
i386                 randconfig-a006-20200820
i386                 randconfig-a001-20200820
x86_64               randconfig-a013-20200818
x86_64               randconfig-a016-20200818
x86_64               randconfig-a012-20200818
x86_64               randconfig-a011-20200818
x86_64               randconfig-a014-20200818
x86_64               randconfig-a015-20200818
x86_64               randconfig-a015-20200820
x86_64               randconfig-a012-20200820
x86_64               randconfig-a016-20200820
x86_64               randconfig-a014-20200820
x86_64               randconfig-a011-20200820
x86_64               randconfig-a013-20200820
i386                 randconfig-a016-20200818
i386                 randconfig-a011-20200818
i386                 randconfig-a015-20200818
i386                 randconfig-a013-20200818
i386                 randconfig-a012-20200818
i386                 randconfig-a014-20200818
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
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
