Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F1C78FFFD
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 17:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjIAPe4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Sep 2023 11:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242249AbjIAPe4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Sep 2023 11:34:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A5410CF
        for <linux-ext4@vger.kernel.org>; Fri,  1 Sep 2023 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693582493; x=1725118493;
  h=date:from:to:cc:subject:message-id;
  bh=G9wm++DjIg6p/5y0Lc3lgyHD3xnpF5yKuPn9McJLxFI=;
  b=B4teoUqJOZnKx9EqfLKoQ9TDzsxchWtw6Mjt1m0hDLKKf1MKrc00kPqp
   kbn0fztCbYf8/gxMwwzVIJbjdxTaq3v+Wvu6RQ7grNfT/af54wdXpmuI+
   WVbTgsapZn9uaqVyIHXhA9LKRs/IBVLzwp7dg4HcI3og/DSbXorNR+g49
   xCR+DJzOde3yG8Eh0aqzaTioOzjBppYGKPh0Uw8hGfs08HthwgsZxUY6r
   gApbiQmPJtOG2tVBAR48PxZq9G0RhTQXSLcQccwMwPM8f8Ztw7hmxkwF6
   8/SdiiuQjuzqsjwe0i7mYfAncqBAME5Ltojs/6d7nxUcDsD/8xjAcWorA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440216104"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="440216104"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 08:34:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739968413"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="739968413"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2023 08:34:44 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qc6AU-0001PV-1b;
        Fri, 01 Sep 2023 15:34:42 +0000
Date:   Fri, 01 Sep 2023 23:33:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:ext4_merge_resolution] BUILD SUCCESS
 e677865a661c1801ae701235727bca8e357984e1
Message-ID: <202309012348.cfjDsdQj-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git ext4_merge_resolution
branch HEAD: e677865a661c1801ae701235727bca8e357984e1  Merge branch 'dev' into test

elapsed time: 1339m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230901   gcc  
alpha                randconfig-r016-20230901   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230901   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230901   clang
arm                  randconfig-r026-20230901   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230901   clang
arm64                randconfig-r031-20230901   clang
arm64                randconfig-r036-20230901   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon               randconfig-001-20230901   clang
hexagon               randconfig-002-20230901   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230901   clang
i386         buildonly-randconfig-002-20230901   clang
i386         buildonly-randconfig-003-20230901   clang
i386         buildonly-randconfig-004-20230901   clang
i386         buildonly-randconfig-005-20230901   clang
i386         buildonly-randconfig-006-20230901   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230901   clang
i386                  randconfig-002-20230901   clang
i386                  randconfig-003-20230901   clang
i386                  randconfig-004-20230901   clang
i386                  randconfig-005-20230901   clang
i386                  randconfig-006-20230901   clang
i386                  randconfig-011-20230901   gcc  
i386                  randconfig-012-20230901   gcc  
i386                  randconfig-013-20230901   gcc  
i386                  randconfig-014-20230901   gcc  
i386                  randconfig-015-20230901   gcc  
i386                  randconfig-016-20230901   gcc  
i386                 randconfig-r014-20230901   gcc  
i386                 randconfig-r021-20230901   gcc  
i386                 randconfig-r032-20230901   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230901   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230901   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r003-20230901   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230901   gcc  
parisc               randconfig-r012-20230901   gcc  
parisc               randconfig-r013-20230901   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r005-20230901   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230901   clang
riscv                randconfig-r006-20230901   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230901   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r033-20230901   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230901   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r025-20230901   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r015-20230901   clang
um                   randconfig-r022-20230901   clang
um                   randconfig-r034-20230901   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230901   clang
x86_64       buildonly-randconfig-002-20230901   clang
x86_64       buildonly-randconfig-003-20230901   clang
x86_64       buildonly-randconfig-004-20230901   clang
x86_64       buildonly-randconfig-005-20230901   clang
x86_64       buildonly-randconfig-006-20230901   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230901   gcc  
x86_64                randconfig-002-20230901   gcc  
x86_64                randconfig-003-20230901   gcc  
x86_64                randconfig-004-20230901   gcc  
x86_64                randconfig-005-20230901   gcc  
x86_64                randconfig-006-20230901   gcc  
x86_64                randconfig-011-20230901   clang
x86_64                randconfig-012-20230901   clang
x86_64                randconfig-013-20230901   clang
x86_64                randconfig-014-20230901   clang
x86_64                randconfig-015-20230901   clang
x86_64                randconfig-016-20230901   clang
x86_64                randconfig-071-20230901   clang
x86_64                randconfig-072-20230901   clang
x86_64                randconfig-073-20230901   clang
x86_64                randconfig-074-20230901   clang
x86_64                randconfig-075-20230901   clang
x86_64                randconfig-076-20230901   clang
x86_64               randconfig-r024-20230901   gcc  
x86_64               randconfig-r035-20230901   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
