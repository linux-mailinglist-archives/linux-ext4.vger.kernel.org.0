Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533AA6BEAB3
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 15:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCQOGP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 10:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCQOGO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 10:06:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB605E067
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679061972; x=1710597972;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iJUIKjpU2T5EtwkO95HMTlQ8/FWXb92Jw19ht4iP3Xg=;
  b=XQOx2v2mktbDLqAUR+HRHBPSEsUy6v62k163esL62OjCbcfKBJM16qUK
   47s2LB9Y39SLeif9RKWL4o7wKnaQoed25InCbTd87y0U48gV4WGf5E7Zq
   zOGsZMlmfLRWZ1eSjFaULfHlKobb7tYB1f/nK50sWy9uWiXMQABukYIyN
   1bV5QZMb7sFzUQGcRjxjyTNotixhfsdzMmfSOd2XhUpbiBk0hh7kgyyCF
   QkNUgxL9xaGpvSRt/w96tctvahghbyR2/xjS7oGB3vU+rP+96jurDJ4aa
   jtuT2bjM+2H44ozWr8+2KjNzvejSj9WACqsAjSu1Z5ibupNOVnXLtUCMb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="326626092"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="326626092"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 07:06:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="673562319"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="673562319"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2023 07:06:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdAif-0009OX-1H;
        Fri, 17 Mar 2023 14:06:09 +0000
Date:   Fri, 17 Mar 2023 22:05:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 da8c7d2105be0c0028cfad712da9e17adf9a26eb
Message-ID: <641473c6.gOi/ftJCrxiLsVdF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: da8c7d2105be0c0028cfad712da9e17adf9a26eb  ext4: convert some BUG_ON's in mballoc to use WARN_RATELIMITED instead

Unverified Warning (likely false positive, please contact us if interested):

fs/ext4/balloc.c:153 ext4_num_overhead_clusters() error: uninitialized symbol 'block_cluster'.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- ia64-randconfig-m031-20230312
    `-- fs-ext4-balloc.c-ext4_num_overhead_clusters()-error:uninitialized-symbol-block_cluster-.

elapsed time: 726m

configs tested: 196
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230313   gcc  
alpha        buildonly-randconfig-r002-20230313   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230312   gcc  
alpha                randconfig-r021-20230312   gcc  
alpha                randconfig-r024-20230312   gcc  
alpha                randconfig-r034-20230313   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230312   gcc  
arc          buildonly-randconfig-r005-20230313   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230312   gcc  
arc                  randconfig-r006-20230313   gcc  
arc                  randconfig-r014-20230312   gcc  
arc                  randconfig-r026-20230315   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230312   clang
arm          buildonly-randconfig-r004-20230313   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230312   gcc  
arm                  randconfig-r006-20230313   clang
arm                  randconfig-r013-20230313   gcc  
arm                  randconfig-r014-20230313   gcc  
arm                  randconfig-r016-20230313   gcc  
arm                  randconfig-r021-20230313   gcc  
arm                  randconfig-r021-20230315   gcc  
arm                  randconfig-r025-20230313   gcc  
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230312   clang
arm64                randconfig-r006-20230312   clang
arm64                randconfig-r011-20230312   gcc  
csky         buildonly-randconfig-r005-20230313   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230312   gcc  
csky                 randconfig-r011-20230313   gcc  
csky                 randconfig-r012-20230313   gcc  
csky                 randconfig-r015-20230312   gcc  
csky                 randconfig-r032-20230312   gcc  
hexagon      buildonly-randconfig-r006-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                 randconfig-a003-20230313   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                 randconfig-a005-20230313   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                 randconfig-a011-20230313   clang
i386                 randconfig-a012-20230313   clang
i386                 randconfig-a013-20230313   clang
i386                 randconfig-a014-20230313   clang
i386                 randconfig-a015-20230313   clang
i386                 randconfig-a016-20230313   clang
i386                          randconfig-c001   gcc  
i386                 randconfig-r004-20230313   gcc  
i386                 randconfig-r005-20230313   gcc  
i386                 randconfig-r012-20230313   clang
i386                 randconfig-r032-20230313   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230313   gcc  
ia64         buildonly-randconfig-r003-20230313   gcc  
ia64         buildonly-randconfig-r005-20230312   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230313   gcc  
ia64                 randconfig-r033-20230312   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230312   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230313   gcc  
loongarch            randconfig-r002-20230312   gcc  
loongarch            randconfig-r002-20230313   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r006-20230313   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230313   gcc  
m68k                 randconfig-r002-20230313   gcc  
m68k                 randconfig-r005-20230312   gcc  
m68k                 randconfig-r011-20230312   gcc  
m68k                 randconfig-r014-20230313   gcc  
m68k                 randconfig-r015-20230313   gcc  
m68k                 randconfig-r016-20230312   gcc  
m68k                 randconfig-r023-20230315   gcc  
m68k                 randconfig-r031-20230313   gcc  
microblaze           randconfig-r001-20230312   gcc  
microblaze           randconfig-r001-20230313   gcc  
microblaze           randconfig-r006-20230312   gcc  
microblaze           randconfig-r012-20230312   gcc  
microblaze           randconfig-r013-20230312   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230312   gcc  
mips                 randconfig-r004-20230312   gcc  
mips                 randconfig-r011-20230313   gcc  
mips                 randconfig-r014-20230313   gcc  
mips                 randconfig-r031-20230312   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230312   gcc  
nios2                randconfig-r012-20230312   gcc  
nios2                randconfig-r013-20230312   gcc  
nios2                randconfig-r025-20230312   gcc  
openrisc             randconfig-r003-20230312   gcc  
openrisc             randconfig-r011-20230313   gcc  
openrisc             randconfig-r022-20230315   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230312   gcc  
parisc               randconfig-r005-20230313   gcc  
parisc               randconfig-r013-20230312   gcc  
parisc               randconfig-r015-20230313   gcc  
parisc               randconfig-r036-20230312   gcc  
parisc               randconfig-r036-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r003-20230313   gcc  
powerpc              randconfig-r004-20230313   gcc  
powerpc              randconfig-r015-20230312   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230312   gcc  
riscv                randconfig-r015-20230312   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230313   gcc  
s390                 randconfig-r024-20230315   clang
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230312   gcc  
sh                   randconfig-r014-20230312   gcc  
sh                   randconfig-r015-20230312   gcc  
sh                   randconfig-r016-20230313   gcc  
sparc        buildonly-randconfig-r002-20230312   gcc  
sparc        buildonly-randconfig-r003-20230313   gcc  
sparc        buildonly-randconfig-r004-20230313   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230313   gcc  
sparc                randconfig-r012-20230312   gcc  
sparc                randconfig-r023-20230312   gcc  
sparc                randconfig-r025-20230315   gcc  
sparc                randconfig-r035-20230313   gcc  
sparc64      buildonly-randconfig-r001-20230312   gcc  
sparc64      buildonly-randconfig-r002-20230313   gcc  
sparc64      buildonly-randconfig-r003-20230312   gcc  
sparc64              randconfig-r002-20230312   gcc  
sparc64              randconfig-r004-20230312   gcc  
sparc64              randconfig-r004-20230313   gcc  
sparc64              randconfig-r035-20230312   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64               randconfig-a002-20230313   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64               randconfig-a004-20230313   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64               randconfig-a006-20230313   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64               randconfig-a012-20230313   clang
x86_64               randconfig-a013-20230313   clang
x86_64               randconfig-a014-20230313   clang
x86_64               randconfig-a015-20230313   clang
x86_64               randconfig-a016-20230313   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r006-20230313   gcc  
x86_64               randconfig-r033-20230313   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230312   gcc  
xtensa               randconfig-r001-20230313   gcc  
xtensa               randconfig-r002-20230312   gcc  
xtensa               randconfig-r003-20230312   gcc  
xtensa               randconfig-r016-20230312   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
