Return-Path: <linux-ext4+bounces-6458-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC9A356BD
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2025 07:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA493A17F2
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2025 06:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442341DD0E7;
	Fri, 14 Feb 2025 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJhGME7Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406B71DC9BA
	for <linux-ext4@vger.kernel.org>; Fri, 14 Feb 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513367; cv=none; b=pO0XWbuevm/HTgzYUxFXbJ+FDlc/KU+gK9jEmEGAQ5gjldV8utaj04wuc3JIabkNd9eCqZ9qCZ56BaLWlrqhfZEVTKrUlODKNh9r3YCyEQniOQV54QsGgKF73Vd7g3hT2FG6wTg8kASvhpuHZ4ThODR++pDlXn9wxooFx7dqTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513367; c=relaxed/simple;
	bh=SkomkFr4l7Ci/vRPewCp+1wR0897kFkjOc1QPYgbyOc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UPiQKOUV+YEtoKdMLS8MhbZKYpDyopc9rDIJnNJmocysNoxFzLHK27VxH3aco66TfgwpuoPmg/xB0PupnVvvpiatTDbw6kQBBuPSW4dwn33c3z7Uxzk0vLGHM9iFOQpEeWWEjPmrX+4/e8mVmJUsuSJSJi/Jw9Rm+QXCLqNhL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJhGME7Q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513366; x=1771049366;
  h=date:from:to:cc:subject:message-id;
  bh=SkomkFr4l7Ci/vRPewCp+1wR0897kFkjOc1QPYgbyOc=;
  b=BJhGME7QDN+kVJW5ZZZKzPm6rEXM+HYubJYKItqnbMBTgT7ijq/Uxb1D
   7mhaK1dvIvBGCVim89ku4FjuI+0oP+ouWQ1CvS8LsU3wah0Ncei0sSDrj
   6sTW7BZ51w3SWrLtxAhvOtGg3wuU9E8ZGuNRoOUbGowYuH9b3Q7dNlFs0
   /O/UXeFSF3NC23r9wXb8J8+FgtppauSq1xpx0AfEWvXVg+KIVgEiHiM6E
   zcJ24rVaQrqAqG/uFiueLr75f7yBKD1nPfs1bLOOZQqEVbWrmM7xM2ruM
   wMJL2GmV36CZorhkGKgiIfmFvs0ABYDD8cEl25RW0J2TkneZNWPY9KBaC
   A==;
X-CSE-ConnectionGUID: ywRAwU6+SUeKKOQjJ1o/wA==
X-CSE-MsgGUID: p66KloOVSGeBymibJ72Z5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51682315"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51682315"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:09:25 -0800
X-CSE-ConnectionGUID: TLdFKFt4TUquvGHDZdwROg==
X-CSE-MsgGUID: oMEO721pQ5+KqpRckvlcQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="113894025"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Feb 2025 22:09:25 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiot8-00198h-1R;
	Fri, 14 Feb 2025 06:09:22 +0000
Date: Fri, 14 Feb 2025 14:08:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD REGRESSION
 e5a9a1fce162be14c6f1ac325faac48b1a7dea9e
Message-ID: <202502141426.usWMFSdn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: e5a9a1fce162be14c6f1ac325faac48b1a7dea9e  jbd2: Avoid long replay times due to high number or revoke blocks

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202502131631.QY6jPFdz-lkp@intel.com

    fs/ext4/namei.c:1602:13: error: no member named 's_encoding_flags' in 'struct super_block'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-mvebu_v7_defconfig
|   `-- fs-ext4-namei.c:error:no-member-named-s_encoding_flags-in-struct-super_block
|-- i386-defconfig
|   `-- fs-ext4-namei.c:error:no-member-named-s_encoding_flags-in-struct-super_block
|-- riscv-randconfig-001-20250213
|   `-- fs-ext4-namei.c:error:no-member-named-s_encoding_flags-in-struct-super_block
`-- x86_64-buildonly-randconfig-003-20250213
    `-- fs-ext4-namei.c:error:no-member-named-s_encoding_flags-in-struct-super_block

elapsed time: 1445m

configs tested: 118
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                            hsdk_defconfig    gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-13.2.0
arc                   randconfig-001-20250213    gcc-13.2.0
arc                   randconfig-002-20250213    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                        mvebu_v7_defconfig    clang-15
arm                   randconfig-001-20250213    clang-17
arm                   randconfig-002-20250213    clang-15
arm                   randconfig-003-20250213    clang-21
arm                   randconfig-004-20250213    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250213    clang-19
arm64                 randconfig-002-20250213    gcc-14.2.0
arm64                 randconfig-003-20250213    gcc-14.2.0
arm64                 randconfig-004-20250213    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250213    gcc-14.2.0
csky                  randconfig-002-20250213    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250213    clang-21
hexagon               randconfig-002-20250213    clang-18
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250213    gcc-12
i386        buildonly-randconfig-002-20250213    clang-19
i386        buildonly-randconfig-003-20250213    clang-19
i386        buildonly-randconfig-004-20250213    clang-19
i386        buildonly-randconfig-005-20250213    clang-19
i386        buildonly-randconfig-006-20250213    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250213    gcc-14.2.0
loongarch             randconfig-002-20250213    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250213    gcc-14.2.0
nios2                 randconfig-002-20250213    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250213    gcc-14.2.0
parisc                randconfig-002-20250213    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      katmai_defconfig    clang-18
powerpc               randconfig-001-20250213    clang-17
powerpc               randconfig-002-20250213    gcc-14.2.0
powerpc               randconfig-003-20250213    gcc-14.2.0
powerpc64             randconfig-001-20250213    clang-19
powerpc64             randconfig-002-20250213    clang-21
powerpc64             randconfig-003-20250213    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                 randconfig-001-20250213    clang-19
riscv                 randconfig-002-20250213    clang-17
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250213    gcc-14.2.0
s390                  randconfig-002-20250213    clang-21
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250213    gcc-14.2.0
sh                    randconfig-002-20250213    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250213    gcc-14.2.0
sparc                 randconfig-002-20250213    gcc-14.2.0
sparc64               randconfig-001-20250213    gcc-14.2.0
sparc64               randconfig-002-20250213    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250213    clang-19
um                    randconfig-002-20250213    clang-21
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250213    gcc-11
x86_64      buildonly-randconfig-002-20250213    gcc-12
x86_64      buildonly-randconfig-003-20250213    clang-19
x86_64      buildonly-randconfig-004-20250213    gcc-12
x86_64      buildonly-randconfig-005-20250213    gcc-12
x86_64      buildonly-randconfig-006-20250213    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250213    gcc-14.2.0
xtensa                randconfig-002-20250213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

