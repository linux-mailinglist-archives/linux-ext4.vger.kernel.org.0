Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB6172CFE0
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 21:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFLT4L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jun 2023 15:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjFLT4L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jun 2023 15:56:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AD3102
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jun 2023 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686599769; x=1718135769;
  h=date:from:to:cc:subject:message-id;
  bh=m/kvQiHDVE9kKKOFKWNCCkymjNFcACAyhD1KHkdnq+M=;
  b=DDKLu+6UC57s9e2EUJzMdlcTxJgAwpjEmzB6ZK7VIfzau+rPP+eU0s3S
   LW5mO/cLETJZzlCEt/OkMydoqZI3zB2yqczGdIQGlQn7XpcUcHEy7aSkj
   f7Y0pQYdku/0jB79DaQlp8x3GPoTLQi3/bs2BE/lJVlnsuhASMDwXmFw3
   ODtQx7NiKxP9HIUM86bf4WMXkL7cwCUqG7NHemRFSWsFK1VyU/sWuFrjB
   3etZWaejfmsSd2VhEH5rUWxbNEA9kcmRmkpcGJvqq6FHnBONpOxyM0hwF
   qwJkF/2RCFl37Jr4FAxiCS4JBeoymjfbf4PalaVEJtxme+viwEb+We9fW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342834312"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="342834312"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 12:56:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885567616"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885567616"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2023 12:56:05 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8ne0-0000eD-1N;
        Mon, 12 Jun 2023 19:56:04 +0000
Date:   Tue, 13 Jun 2023 03:55:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:origin] BUILD SUCCESS
 dea9d8f7643fab07bf89a1155f1f94f37d096a5e
Message-ID: <202306130352.ihKdO5v0-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git origin
branch HEAD: dea9d8f7643fab07bf89a1155f1f94f37d096a5e  ext4: only check dquot_initialize_needed() when debugging

elapsed time: 971m

configs tested: 121
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230612   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230612   gcc  
arc                  randconfig-r025-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230612   clang
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r003-20230612   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r006-20230612   clang
hexagon              randconfig-r001-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r012-20230612   gcc  
i386                 randconfig-r014-20230612   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r035-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r011-20230612   clang
mips                        vocore2_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r022-20230612   gcc  
openrisc             randconfig-r013-20230612   gcc  
openrisc             randconfig-r024-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                   motionpro_defconfig   gcc  
powerpc              randconfig-r033-20230612   clang
powerpc                     tqm5200_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230612   clang
s390                 randconfig-r016-20230612   gcc  
s390                 randconfig-r026-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                   randconfig-r002-20230612   gcc  
sh                   randconfig-r004-20230612   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64              randconfig-r021-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r002-20230612   clang
x86_64       buildonly-randconfig-r005-20230612   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64               randconfig-r003-20230612   clang
x86_64               randconfig-r036-20230612   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r006-20230612   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
