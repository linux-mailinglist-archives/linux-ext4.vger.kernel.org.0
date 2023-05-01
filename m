Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235E06F2FF0
	for <lists+linux-ext4@lfdr.de>; Mon,  1 May 2023 11:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjEAJoX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 May 2023 05:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAJoW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 May 2023 05:44:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA0E1B6
        for <linux-ext4@vger.kernel.org>; Mon,  1 May 2023 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682934261; x=1714470261;
  h=date:from:to:cc:subject:message-id;
  bh=g5gYPHpgcrnXC9t0Fr+mYivMYGNLns7cyVbanPjighw=;
  b=cirpohgX+GjWP3tNEnKPybAwuugQvhn5nwwpAuU2CyQJ0Q16P+KeAXCD
   QJqFJepECU7/2AqJ43eOZS9unYJeOrJ630utyFCbXk5EEeFOAJqjcpfQf
   gxZhn+jgYhfEleCtllMq0ysRUu00v3vYiSzrbZVzVOpRp2PKR8HSMJYCC
   xgdQf/iVg6FKmN89xnLoldIfgapDkmbm7scoRZr3ec3YWV1v+K7B55pYz
   8pOkdVa6vuNOiTlCEcUdFXzZHxug25uWLWJyX7Om2m1z4zpdRqp+j9Ylk
   qC+adNt+YtCGDJm+oAAq6+JTSwCEVzNNJjjbaZ7k8YGLbYjOn7OWDtOnj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10696"; a="350190186"
X-IronPort-AV: E=Sophos;i="5.99,239,1677571200"; 
   d="scan'208";a="350190186"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 02:44:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10696"; a="689831902"
X-IronPort-AV: E=Sophos;i="5.99,239,1677571200"; 
   d="scan'208";a="689831902"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 May 2023 02:44:03 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptQ4g-0000O9-0o;
        Mon, 01 May 2023 09:44:02 +0000
Date:   Mon, 01 May 2023 17:43:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [tytso-ext4:tt/next] BUILD SUCCESS
 22cd9a40a012c5fe29fe46fe45f48f0c9299899a
Message-ID: <20230501094337.SWteH%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tt/next
branch HEAD: 22cd9a40a012c5fe29fe46fe45f48f0c9299899a  ext4: fix invalid free tracking in ext4_xattr_move_to_block()

elapsed time: 724m

configs tested: 131
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230501   gcc  
alpha                randconfig-r021-20230430   gcc  
alpha                randconfig-r024-20230430   gcc  
alpha                randconfig-r024-20230501   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230430   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230430   gcc  
arc                  randconfig-r043-20230430   gcc  
arc                  randconfig-r043-20230501   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230501   gcc  
arm          buildonly-randconfig-r006-20230430   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230501   gcc  
arm                  randconfig-r046-20230430   gcc  
arm                  randconfig-r046-20230501   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230430   clang
arm64                randconfig-r015-20230501   clang
csky         buildonly-randconfig-r001-20230501   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230501   gcc  
csky                 randconfig-r002-20230430   gcc  
csky                 randconfig-r036-20230430   gcc  
hexagon      buildonly-randconfig-r002-20230430   clang
hexagon              randconfig-r003-20230501   clang
hexagon              randconfig-r016-20230501   clang
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r041-20230501   clang
hexagon              randconfig-r045-20230430   clang
hexagon              randconfig-r045-20230501   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230501   gcc  
i386                 randconfig-a002-20230501   gcc  
i386                 randconfig-a003-20230501   gcc  
i386                 randconfig-a004-20230501   gcc  
i386                 randconfig-a005-20230501   gcc  
i386                 randconfig-a006-20230501   gcc  
i386                 randconfig-a011-20230501   clang
i386                 randconfig-a012-20230501   clang
i386                 randconfig-a013-20230501   clang
i386                 randconfig-a014-20230501   clang
i386                 randconfig-a015-20230501   clang
i386                 randconfig-a016-20230501   clang
i386                 randconfig-r032-20230501   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r016-20230430   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230501   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r006-20230501   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230430   gcc  
microblaze           randconfig-r003-20230430   gcc  
microblaze           randconfig-r034-20230430   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r036-20230501   clang
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230501   gcc  
nios2                randconfig-r031-20230430   gcc  
openrisc     buildonly-randconfig-r004-20230430   gcc  
openrisc     buildonly-randconfig-r005-20230430   gcc  
openrisc             randconfig-r005-20230501   gcc  
openrisc             randconfig-r014-20230501   gcc  
openrisc             randconfig-r033-20230430   gcc  
openrisc             randconfig-r035-20230430   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230501   gcc  
parisc               randconfig-r025-20230430   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r012-20230430   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230430   gcc  
riscv                randconfig-r022-20230430   clang
riscv                randconfig-r042-20230430   clang
riscv                randconfig-r042-20230501   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230501   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230501   gcc  
s390                 randconfig-r023-20230501   clang
s390                 randconfig-r032-20230430   gcc  
s390                 randconfig-r044-20230430   clang
s390                 randconfig-r044-20230501   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r021-20230501   gcc  
sparc        buildonly-randconfig-r003-20230501   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230430   gcc  
sparc                randconfig-r023-20230430   gcc  
sparc64              randconfig-r013-20230430   gcc  
sparc64              randconfig-r031-20230501   gcc  
sparc64              randconfig-r035-20230501   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230501   gcc  
x86_64               randconfig-a002-20230501   gcc  
x86_64               randconfig-a003-20230501   gcc  
x86_64               randconfig-a004-20230501   gcc  
x86_64               randconfig-a005-20230501   gcc  
x86_64               randconfig-a006-20230501   gcc  
x86_64               randconfig-a011-20230501   clang
x86_64               randconfig-a012-20230501   clang
x86_64               randconfig-a013-20230501   clang
x86_64               randconfig-a014-20230501   clang
x86_64               randconfig-a015-20230501   clang
x86_64               randconfig-a016-20230501   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230430   gcc  
xtensa               randconfig-r033-20230501   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
