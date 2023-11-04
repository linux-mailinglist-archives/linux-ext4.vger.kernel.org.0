Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B887E0F21
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Nov 2023 12:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjKDLb2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 4 Nov 2023 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjKDLb2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 4 Nov 2023 07:31:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A74CD49
        for <linux-ext4@vger.kernel.org>; Sat,  4 Nov 2023 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699097485; x=1730633485;
  h=date:from:to:cc:subject:message-id;
  bh=BAGx5nZ5lm82zN5Ig43Pm1OovPp6O7ORn79UmyB4ljs=;
  b=Po+PBcfYh7n52vfm+tXUWNrw1+Ha0xh8iHw2i0YIkFoz397SRzYdxwe7
   KTpNUUDofPMlOT/UHfMkBMh3ecpHdWqWWA43lY9RIwbZ2g923DssXtDSS
   cNh2wUjg+X8DWCkR6p51sQ/etAxnOaIZA+NG1VAZYlkSsi/SbkmeeUXRp
   vnjXjqOiEY7/kDSvRnUlF+vlRDLC4TvOHtCES85mGgJIgJaltwLBgehLc
   BRtNg01+0NKY+ZRnwt6yKSfMdDbCxXcX5SL3eHDpOaLqydsIriwRLigzD
   uWE0LAQLi3IIm8AT6N4wthP8RINBEPqbtT+k9g0cTVOOWJxPKkZuZEyXu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="10614383"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="10614383"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 04:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="796868592"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="796868592"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Nov 2023 04:31:23 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzEs4-00047N-2i;
        Sat, 04 Nov 2023 11:31:20 +0000
Date:   Sat, 04 Nov 2023 19:30:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 91562895f8030cb9a0470b1db49de79346a69f91
Message-ID: <202311041955.jmzc2LhO-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 91562895f8030cb9a0470b1db49de79346a69f91  ext4: properly sync file size update after O_SYNC direct IO

elapsed time: 4855m

configs tested: 164
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231101   gcc  
arc                   randconfig-002-20231101   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231101   gcc  
arm                   randconfig-002-20231101   gcc  
arm                   randconfig-003-20231101   gcc  
arm                   randconfig-004-20231101   gcc  
arm                       versatile_defconfig   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231101   gcc  
arm64                 randconfig-002-20231101   gcc  
arm64                 randconfig-003-20231101   gcc  
arm64                 randconfig-004-20231101   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231101   gcc  
csky                  randconfig-002-20231101   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231101   gcc  
i386         buildonly-randconfig-002-20231101   gcc  
i386         buildonly-randconfig-003-20231101   gcc  
i386         buildonly-randconfig-004-20231101   gcc  
i386         buildonly-randconfig-005-20231101   gcc  
i386         buildonly-randconfig-006-20231101   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231101   gcc  
i386                  randconfig-002-20231101   gcc  
i386                  randconfig-003-20231101   gcc  
i386                  randconfig-004-20231101   gcc  
i386                  randconfig-005-20231101   gcc  
i386                  randconfig-006-20231101   gcc  
i386                  randconfig-012-20231101   gcc  
i386                  randconfig-013-20231101   gcc  
i386                  randconfig-014-20231101   gcc  
i386                  randconfig-015-20231101   gcc  
i386                  randconfig-016-20231101   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231101   gcc  
loongarch             randconfig-002-20231101   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231101   gcc  
nios2                 randconfig-002-20231101   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231101   gcc  
parisc                randconfig-002-20231101   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc               randconfig-001-20231101   gcc  
powerpc               randconfig-002-20231101   gcc  
powerpc               randconfig-003-20231101   gcc  
powerpc64             randconfig-001-20231101   gcc  
powerpc64             randconfig-002-20231101   gcc  
powerpc64             randconfig-003-20231101   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231101   gcc  
riscv                 randconfig-002-20231101   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231101   gcc  
s390                  randconfig-002-20231101   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231101   gcc  
x86_64                randconfig-002-20231101   gcc  
x86_64                randconfig-003-20231101   gcc  
x86_64                randconfig-004-20231101   gcc  
x86_64                randconfig-005-20231101   gcc  
x86_64                randconfig-006-20231101   gcc  
x86_64                randconfig-011-20231101   gcc  
x86_64                randconfig-012-20231101   gcc  
x86_64                randconfig-013-20231101   gcc  
x86_64                randconfig-014-20231101   gcc  
x86_64                randconfig-015-20231101   gcc  
x86_64                randconfig-016-20231101   gcc  
x86_64                randconfig-071-20231101   gcc  
x86_64                randconfig-072-20231101   gcc  
x86_64                randconfig-073-20231101   gcc  
x86_64                randconfig-074-20231101   gcc  
x86_64                randconfig-075-20231101   gcc  
x86_64                randconfig-076-20231101   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
