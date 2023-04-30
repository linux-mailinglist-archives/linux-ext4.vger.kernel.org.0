Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5756F284E
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjD3Jc1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjD3Jc1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 05:32:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF24310C9
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682847145; x=1714383145;
  h=date:from:to:cc:subject:message-id;
  bh=T+2mlDB/PJijqvtCmaTjuEchJaGALTph30E006maRtc=;
  b=PZD+amQL8xLMwavqEcPMCACN3NnrnHnKBm+Pkw0HA/J4selpfal9BlG4
   I9bBz5nhoHFYwUTdZK4iZQZw5dvn8xOTzmda9OHIsMcd0p4dTZhuCUAP2
   8ojVyRLcizx44sP2qXIS9eLEHa4SI0iHMSt2WvIV4JNVbG4OOAIbTPyr9
   qaRNPrkh9PXGlaUtKEqqP/olPDQvlGAn3yn8yt4CkISyUiTTysA3nqi2z
   y4MMPs3WwVs5Rm7GBtlQBIiGHFm0I53W3rlpcRpJHEdHjHITF7hW5J/Gy
   Q7P6rj9WNkxJX9NbitL0NqGh0aF9RXXwCFEEo0GkCK6hZeCz3p+rDxp04
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="328354833"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="328354833"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2023 02:32:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="784915913"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="784915913"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2023 02:32:24 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pt3Pr-0001bl-0T;
        Sun, 30 Apr 2023 09:32:23 +0000
Date:   Sun, 30 Apr 2023 17:31:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 493cc71f24795ab9afc311649f5d2c23f652fb1e
Message-ID: <20230430093126.dmnzY%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 493cc71f24795ab9afc311649f5d2c23f652fb1e  ext4: DO NOT MERGE: replace BUG_ON with an ext4_warning

elapsed time: 762m

configs tested: 101
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230430   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230430   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230430   gcc  
arc                  randconfig-r043-20230430   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230430   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230430   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230430   gcc  
csky                 randconfig-r031-20230430   gcc  
csky                 randconfig-r035-20230430   gcc  
hexagon              randconfig-r016-20230430   clang
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r045-20230430   clang
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
ia64                 randconfig-r011-20230430   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230430   gcc  
microblaze           randconfig-r006-20230430   gcc  
microblaze           randconfig-r013-20230430   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230430   gcc  
mips                 randconfig-r024-20230430   gcc  
mips                 randconfig-r032-20230430   clang
mips                 randconfig-r034-20230430   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230430   gcc  
nios2                randconfig-r026-20230430   gcc  
openrisc     buildonly-randconfig-r004-20230430   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230430   gcc  
riscv                randconfig-r042-20230430   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r033-20230430   gcc  
s390                 randconfig-r044-20230430   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r025-20230430   gcc  
sh                   randconfig-r036-20230430   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230430   gcc  
sparc64      buildonly-randconfig-r003-20230430   gcc  
sparc64              randconfig-r005-20230430   gcc  
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
xtensa       buildonly-randconfig-r005-20230430   gcc  
xtensa               randconfig-r015-20230430   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
