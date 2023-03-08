Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E976C6B0F22
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 17:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCHQqE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Mar 2023 11:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHQqB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Mar 2023 11:46:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693674EC8
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 08:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678293957; x=1709829957;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yS+s69iD1blhXWtSfPcmDP3DVg9I5K7zkSkAwK5PsW4=;
  b=nobNWPLEbFGMmgy6hX8c6GRSJ19P9/MGsqFLJ0dDsyHGNwSg2txZsKkp
   PXZ6bI7QHEm82q5p96NNzN3EzXVGdq/ma53pgv20FN8rCrFjESrsNmDJ/
   vPFWX8vBjNqYxKUwQJe1gTQTZuK8l1ZYzJqZ2oaftcQjtAzZFT9gxaOJs
   lkYjDfoBjphzihN7xdEcZhaUR5Yp5jI6JCxiQHBVNGzqssiI8m/1Mmoz2
   FGuIE7Iho+LtiTaV9iDdGCY33o9kNF4vL2H6vCH9VcbD1+38o1Y61an4a
   sCswfHcVPcCD2kWAkQTSiTkgltwDw9uoa5zY2Vl1Ji0IFYmhR+fa8RBC0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334916264"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="334916264"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 08:45:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="800821776"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="800821776"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2023 08:45:53 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZwvI-0002Gz-1p;
        Wed, 08 Mar 2023 16:45:52 +0000
Date:   Thu, 09 Mar 2023 00:45:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 b2e40d36d351b6bc36b0e1834b415120b60bd97e
Message-ID: <6408bba5.9r6nmgCh8/Tjrf/v%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: b2e40d36d351b6bc36b0e1834b415120b60bd97e  ext4, jbd2: add an optimized bmap for the journal inode

elapsed time: 723m

configs tested: 139
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230306   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230305   gcc  
alpha                randconfig-r031-20230306   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230306   gcc  
arc                  randconfig-r006-20230305   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230305   clang
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230305   clang
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230306   clang
csky                                defconfig   gcc  
csky                 randconfig-r035-20230306   gcc  
hexagon      buildonly-randconfig-r001-20230305   clang
hexagon              randconfig-r011-20230306   clang
hexagon              randconfig-r022-20230305   clang
hexagon              randconfig-r024-20230306   clang
hexagon              randconfig-r034-20230305   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r041-20230306   clang
hexagon              randconfig-r045-20230305   clang
hexagon              randconfig-r045-20230306   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
i386                 randconfig-r025-20230306   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r012-20230305   gcc  
ia64                 randconfig-r023-20230306   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230305   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230305   gcc  
loongarch            randconfig-r032-20230306   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r036-20230306   gcc  
microblaze           randconfig-r005-20230306   gcc  
microblaze           randconfig-r013-20230305   gcc  
microblaze           randconfig-r013-20230306   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r015-20230305   clang
mips                 randconfig-r033-20230306   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230306   gcc  
nios2                randconfig-r004-20230306   gcc  
openrisc     buildonly-randconfig-r005-20230306   gcc  
openrisc     buildonly-randconfig-r006-20230305   gcc  
openrisc             randconfig-r002-20230305   gcc  
openrisc             randconfig-r004-20230305   gcc  
openrisc             randconfig-r014-20230306   gcc  
openrisc             randconfig-r024-20230305   gcc  
parisc       buildonly-randconfig-r003-20230306   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230306   gcc  
parisc               randconfig-r014-20230305   gcc  
parisc               randconfig-r033-20230305   gcc  
parisc               randconfig-r034-20230306   gcc  
parisc               randconfig-r035-20230305   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r021-20230306   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230305   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230305   clang
riscv                randconfig-r021-20230305   gcc  
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230306   clang
s390         buildonly-randconfig-r004-20230306   clang
s390                                defconfig   gcc  
s390                 randconfig-r003-20230305   clang
s390                 randconfig-r016-20230306   clang
s390                 randconfig-r023-20230305   gcc  
s390                 randconfig-r026-20230305   gcc  
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r012-20230306   gcc  
sh                   randconfig-r015-20230306   gcc  
sh                   randconfig-r036-20230305   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r004-20230305   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64               randconfig-r002-20230306   gcc  
x86_64               randconfig-r026-20230306   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
