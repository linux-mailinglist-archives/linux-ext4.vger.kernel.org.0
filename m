Return-Path: <linux-ext4+bounces-787-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE782B904
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jan 2024 02:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD961F2436A
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jan 2024 01:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7E4A17;
	Fri, 12 Jan 2024 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5YUhv/g"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507744A10
	for <linux-ext4@vger.kernel.org>; Fri, 12 Jan 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705022057; x=1736558057;
  h=date:from:to:cc:subject:message-id;
  bh=kMcXPKydtgJhQQziDi+/ruKVLYK29svAv5TgrREzqGw=;
  b=i5YUhv/gCgAnAzSVnt15p+poE3q7NxvKmb90G7PL/1Cdnz/1T+Zx193v
   71tCKo6xrPBY4VSe/gkyS9j/1/UIRzrB+qs6uec1ijw4ABlnTowirkXxW
   /xuVm76C+izs6RSz0hMTtDBcdsC3GquRjsR3tdYXp2imSUZHuWWQLIS4p
   sR4Z46bpAfBX+6JKDKKZHwxYTb1wdWkuNekoPR+ijMfzl3WFQsr1f7obI
   D6DBxA2TlKA/e5mOogh7SyJxFu1LowfPxDIfw8VmKtQPQ4cL8SkLIp0CV
   YekfVXc52ixfIAwQxXyptfNGyr/4zUGDChVkj8kUTJ2nc5TfS8zpYIh0y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="12411485"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="12411485"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 17:14:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="24529455"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 11 Jan 2024 17:14:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO67g-0008us-0q;
	Fri, 12 Jan 2024 01:14:12 +0000
Date: Fri, 12 Jan 2024 09:13:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 68da4c44b994aea797eb9821acb3a4a36015293e
Message-ID: <202401120919.d5lq5zKK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 68da4c44b994aea797eb9821acb3a4a36015293e  ext4: fix inconsistent between segment fstrim and full fstrim

elapsed time: 1746m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240112   gcc  
arc                   randconfig-002-20240112   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                            qcom_defconfig   gcc  
arm                   randconfig-001-20240112   clang
arm                   randconfig-002-20240112   clang
arm                   randconfig-003-20240112   clang
arm                   randconfig-004-20240112   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240112   clang
arm64                 randconfig-002-20240112   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240111   gcc  
i386         buildonly-randconfig-002-20240111   gcc  
i386         buildonly-randconfig-003-20240111   gcc  
i386         buildonly-randconfig-004-20240111   gcc  
i386         buildonly-randconfig-005-20240111   gcc  
i386         buildonly-randconfig-006-20240111   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240111   gcc  
i386                  randconfig-002-20240111   gcc  
i386                  randconfig-003-20240111   gcc  
i386                  randconfig-004-20240111   gcc  
i386                  randconfig-005-20240111   gcc  
i386                  randconfig-006-20240111   gcc  
i386                  randconfig-011-20240111   clang
i386                  randconfig-012-20240111   clang
i386                  randconfig-013-20240111   clang
i386                  randconfig-014-20240111   clang
i386                  randconfig-015-20240111   clang
i386                  randconfig-016-20240111   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                           gcw0_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                     kmeter1_defconfig   clang
powerpc                 linkstation_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240112   clang
x86_64       buildonly-randconfig-002-20240112   clang
x86_64       buildonly-randconfig-003-20240112   clang
x86_64       buildonly-randconfig-004-20240112   clang
x86_64       buildonly-randconfig-005-20240112   clang
x86_64       buildonly-randconfig-006-20240112   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

