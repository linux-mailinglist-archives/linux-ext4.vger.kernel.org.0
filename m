Return-Path: <linux-ext4+bounces-12111-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC1C992A2
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 22:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDB784E2145
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 21:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1602127B34D;
	Mon,  1 Dec 2025 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KENSntoO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C32773D9
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764624280; cv=none; b=H2+MLnmkDMcr5NbBjUEvH/D2QW+GBewgct9Jgt2uImw/s+CizTME9iHTwQDiUJzDzbc+M6VqFwO6WSV6bg0GGDDtXaEv3fOR5yjt1NocevtM3pCeBoL/qv2oInznWjH52u4IC+O/AlbfJTAUPFPJXg5qmVf37di3v6x9G/nydwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764624280; c=relaxed/simple;
	bh=2C6mHWw/PUMi48RRknGDZvul8GB+veOXInnvu7koXEQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fZfq50td8BSpsCUN1kzorfDHpUFrzfTJieZK2ZKS8r56qbCAil9aKy8GjEKttwXcWqGRVbs8b8SN3N6U+zXH3lpaSnmIiEKGg1qCmz63EZyw6UFLe9L0PfjJGjQ8I3HYR3kZllHEqOlNYvTjQWIW7mabgbun70z0F0glZSISMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KENSntoO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764624278; x=1796160278;
  h=date:from:to:cc:subject:message-id;
  bh=2C6mHWw/PUMi48RRknGDZvul8GB+veOXInnvu7koXEQ=;
  b=KENSntoO7hCUnLDbbeTqkrshymteWRBR+RZhcSKuX8MOnoV9sFDLk6Mz
   ue744WX69DIY8r7TneEN5g0UPWgcFHZuShpQ3KuV9zlNl2Jrr0InBazto
   UXT+75YebpSnUhKSvUQC999Z6MV99X9SSg+kwORull+FQY9vGWtp+Irjq
   4cdjlaYpGS1y+JVdx3MA8OoqO18lGuqQuz2qWlUF7K5PATPoVn6Lx+OSm
   lASaSy/MUP5NpNSd9+BkYNBdYCRTsVa1+5Pu3iGLlvyIiPgusNymfLR4W
   PaMBZSH977hSvZ8raXxulCEoLdkOWItXGqnNqnuPtOdN+AEm+ALg0Yt5Z
   A==;
X-CSE-ConnectionGUID: Le+6jxNJS463k3Liz7ranQ==
X-CSE-MsgGUID: eCJ5jMJqQ6u4WypFg2joOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="70436158"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="70436158"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 13:24:38 -0800
X-CSE-ConnectionGUID: ofR7oR4lSEi0+wiuvyUr3A==
X-CSE-MsgGUID: kZ1vguJ3SCOvXOQYC//KaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="231492329"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 01 Dec 2025 13:24:37 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vQBNq-0000000099t-1iOZ;
	Mon, 01 Dec 2025 21:24:34 +0000
Date: Tue, 02 Dec 2025 05:23:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 78fd3495ca503125d64c20e8708d23c451e7ff77
Message-ID: <202512020532.9mZ6kWQu-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 78fd3495ca503125d64c20e8708d23c451e7ff77  Merge branch 'fs-next' of ../linux into test

elapsed time: 1107m

configs tested: 167
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251201    gcc-13.4.0
arc                   randconfig-002-20251201    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g4_defconfig    clang-22
arm                                 defconfig    clang-22
arm                   randconfig-001-20251201    clang-22
arm                   randconfig-002-20251201    gcc-8.5.0
arm                   randconfig-003-20251201    clang-20
arm                   randconfig-004-20251201    gcc-15.1.0
arm64                            alldefconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251201    gcc-8.5.0
arm64                 randconfig-002-20251201    clang-22
arm64                 randconfig-003-20251201    clang-18
arm64                 randconfig-004-20251201    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251201    gcc-15.1.0
csky                  randconfig-002-20251201    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251201    clang-22
hexagon               randconfig-002-20251201    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251201    clang-20
i386        buildonly-randconfig-002-20251201    clang-20
i386        buildonly-randconfig-003-20251201    clang-20
i386        buildonly-randconfig-004-20251201    clang-20
i386        buildonly-randconfig-005-20251201    clang-20
i386        buildonly-randconfig-006-20251201    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251201    gcc-14
i386                  randconfig-002-20251201    clang-20
i386                  randconfig-003-20251201    clang-20
i386                  randconfig-004-20251201    clang-20
i386                  randconfig-005-20251201    gcc-14
i386                  randconfig-006-20251201    gcc-14
i386                  randconfig-007-20251201    clang-20
i386                  randconfig-011-20251201    clang-20
i386                  randconfig-012-20251201    gcc-14
i386                  randconfig-013-20251201    clang-20
i386                  randconfig-014-20251201    gcc-14
i386                  randconfig-015-20251201    gcc-14
i386                  randconfig-016-20251201    gcc-14
i386                  randconfig-017-20251201    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251201    gcc-15.1.0
loongarch             randconfig-002-20251201    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    clang-18
mips                           ci20_defconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251201    gcc-8.5.0
nios2                 randconfig-002-20251201    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251201    gcc-13.4.0
parisc                randconfig-002-20251201    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251201    gcc-13.4.0
powerpc               randconfig-002-20251201    gcc-10.5.0
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20251201    gcc-14.3.0
powerpc64             randconfig-002-20251201    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251201    clang-22
riscv                 randconfig-002-20251201    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251201    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251201    gcc-12.5.0
sh                    randconfig-002-20251201    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251201    gcc-8.5.0
sparc                 randconfig-002-20251201    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251201    clang-22
sparc64               randconfig-002-20251201    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251201    gcc-14
um                    randconfig-002-20251201    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251201    clang-20
x86_64      buildonly-randconfig-002-20251201    clang-20
x86_64      buildonly-randconfig-003-20251201    gcc-14
x86_64      buildonly-randconfig-004-20251201    gcc-14
x86_64      buildonly-randconfig-005-20251201    gcc-14
x86_64      buildonly-randconfig-006-20251201    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251201    gcc-14
x86_64                randconfig-002-20251201    clang-20
x86_64                randconfig-003-20251201    clang-20
x86_64                randconfig-004-20251201    clang-20
x86_64                randconfig-005-20251201    clang-20
x86_64                randconfig-006-20251201    clang-20
x86_64                randconfig-011-20251201    clang-20
x86_64                randconfig-012-20251201    gcc-14
x86_64                randconfig-013-20251201    gcc-14
x86_64                randconfig-014-20251201    gcc-14
x86_64                randconfig-015-20251201    clang-20
x86_64                randconfig-016-20251201    clang-20
x86_64                randconfig-071-20251201    gcc-12
x86_64                randconfig-072-20251201    gcc-14
x86_64                randconfig-073-20251201    gcc-14
x86_64                randconfig-074-20251201    gcc-14
x86_64                randconfig-075-20251201    gcc-12
x86_64                randconfig-076-20251201    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251201    gcc-9.5.0
xtensa                randconfig-002-20251201    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

