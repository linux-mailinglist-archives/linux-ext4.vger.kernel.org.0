Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBAE6C89BF
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Mar 2023 01:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCYAxo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Mar 2023 20:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCYAxo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Mar 2023 20:53:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB811672
        for <linux-ext4@vger.kernel.org>; Fri, 24 Mar 2023 17:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679705623; x=1711241623;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mWrKEbgtCbEgdw6o9mat1m88w22Uw67t1bJ9YVuP5Vc=;
  b=j1XeYcDswfDXJa+kYMKg9hQZgtLhyKMAL61J7VmUhDYIcWpVEkIkQH4k
   mj8qdoDNIO9Mz0Jxjb4b6YX+NDa8WfLvBAKYtsRmfJmAJsJqjj9WeO3LZ
   eSBPYylTbuX6n9KXCEz5BqyeQzYjJ9h0cuFpnlT7y8qq0grmOH17mUXTx
   q6bB2kWLgd2C/0JcDBFBcpBkcc9pKmhusISLL3BV0EGuSWnFtgnJtcLYT
   VhrM7tBtuOTzqXy7+RCHylGSxgS65pPoaJHEXcHpGSnm1oHq3wjtLtUhH
   5JRTFMRSeRsGgBdhWG8oMvfKVuU/CVF/bXHAIkVR4n9s4qsLoKmsDv0qz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="341490283"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="341490283"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 17:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="793643176"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="793643176"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Mar 2023 17:53:41 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfsA8-000Fox-19;
        Sat, 25 Mar 2023 00:53:40 +0000
Date:   Sat, 25 Mar 2023 08:53:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 463f2e46bf7cfa718f020a933a6941bd6db1b267
Message-ID: <641e4602.e4hMthWnq/p7eD+K%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 463f2e46bf7cfa718f020a933a6941bd6db1b267  ext4: convert some BUG_ON's in mballoc to use WARN_RATELIMITED instead

Unverified Warning (likely false positive, please contact us if interested):

fs/ext4/balloc.c:114:34-36: WARNING opportunity for max()
fs/ext4/balloc.c:116:30-32: WARNING opportunity for min()

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- sh-randconfig-c043-20230324
    |-- fs-ext4-balloc.c:WARNING-opportunity-for-max()
    `-- fs-ext4-balloc.c:WARNING-opportunity-for-min()

elapsed time: 737m

configs tested: 104
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230322   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230322   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r032-20230322   gcc  
arm                  randconfig-r046-20230322   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230322   clang
arm64                randconfig-r005-20230322   clang
csky                                defconfig   gcc  
csky                 randconfig-r023-20230322   gcc  
hexagon              randconfig-r006-20230322   clang
hexagon              randconfig-r025-20230322   clang
hexagon              randconfig-r031-20230322   clang
hexagon              randconfig-r041-20230322   clang
hexagon              randconfig-r045-20230322   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230322   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r013-20230322   gcc  
m68k                 randconfig-r024-20230322   gcc  
m68k                 randconfig-r026-20230322   gcc  
m68k                 randconfig-r034-20230322   gcc  
microblaze   buildonly-randconfig-r002-20230322   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r021-20230322   gcc  
nios2                randconfig-r033-20230322   gcc  
parisc       buildonly-randconfig-r006-20230322   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230322   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230322   gcc  
powerpc              randconfig-r035-20230322   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230322   clang
riscv                randconfig-r042-20230322   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230322   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r012-20230322   gcc  
sparc        buildonly-randconfig-r001-20230322   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230322   gcc  
sparc64              randconfig-r036-20230322   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r011-20230322   gcc  
xtensa               randconfig-r015-20230322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
