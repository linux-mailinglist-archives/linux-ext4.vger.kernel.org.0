Return-Path: <linux-ext4+bounces-12093-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D53DC94BCB
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Nov 2025 07:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AF99345216
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Nov 2025 06:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B275C221290;
	Sun, 30 Nov 2025 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdVl8seI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B8125A9
	for <linux-ext4@vger.kernel.org>; Sun, 30 Nov 2025 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764485869; cv=none; b=Z62f/+x4u+QDcqAmWYFxq8ExsU4m9YjWM0yUGgJE7NMe+L1wtY2ScVn2KU247SA50MoKm9YLbhSfckHlNeup7mmyALYIjduxtafX1U3GYae9CeqUHTXmJawYJGqdASQ8uGZWORfx9ksUOZCVAW/vyCfkVStDeQkpNVnoh05cK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764485869; c=relaxed/simple;
	bh=o/tEB3kcvHCIVHOCfdn19+higoJLk3rg3BD/dGwif7Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fxNz7iCHvT4o7lQZlnKpI9cgJhBbIZvfOEtG0TEvgRgBC4rTERKtfJJiSqEuxq7tORDj5EuM3HA6cFkmz1/bh5++TL98QLwklMrN5Ey1ywXN+B/m4WSBtieGX/m5YPUyZIPl9gFXYbJkFvmb5dwJPzfx872Pig/T3yCtrBtZhP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdVl8seI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764485867; x=1796021867;
  h=date:from:to:cc:subject:message-id;
  bh=o/tEB3kcvHCIVHOCfdn19+higoJLk3rg3BD/dGwif7Q=;
  b=IdVl8seIK4nzx/6LFaD6pLihn+sWMrJBVFF3woBu5ueEe2NGmjzL42pl
   tk8MwcF/UJiOzrrltqKeGtvvV5PSMEChemE09DE96tb27jwD+QlSCl7Ar
   GgkTC3MuFnMLGFyZ1tnaFzRL+W9Is1IX/RkwgX60qw2rmHffar5UYlSGq
   YnR2qK1rj9lfPHxJkKS8HMiz/+FNpwN2C+ukSRXo9V2s3Qjz/pqFfc82n
   nVqRJKMtRQzqG0eY/bmwE6xHroyxjeQ8mVkicG4/YLfEp8TpWD1Qm86zU
   n5P6TMsWnPfLGRMt8/49Ldl0WfW+OFBNRviySv8z0jv5IHgKcxJ6MqqHb
   g==;
X-CSE-ConnectionGUID: ZcDd171kRMGwSmQhH5MPdw==
X-CSE-MsgGUID: n4hnbp1TSUOIdR5hzi9Lcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11628"; a="66405828"
X-IronPort-AV: E=Sophos;i="6.20,238,1758610800"; 
   d="scan'208";a="66405828"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 22:57:47 -0800
X-CSE-ConnectionGUID: 29R807qzSyCbYHRMaeZWJg==
X-CSE-MsgGUID: bZfSrW1NR7eQYmNRO56LLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,238,1758610800"; 
   d="scan'208";a="224484938"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Nov 2025 22:57:46 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vPbNP-000000007p1-35W5;
	Sun, 30 Nov 2025 06:57:43 +0000
Date: Sun, 30 Nov 2025 14:57:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 1e366d0888665fb29ade62a44bbbceaa67ba4de4
Message-ID: <202511301421.vVDUrPQ4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 1e366d0888665fb29ade62a44bbbceaa67ba4de4  ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1

elapsed time: 1596m

configs tested: 106
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20251129    gcc-8.5.0
arc                   randconfig-002-20251129    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20251129    clang-20
arm                   randconfig-002-20251129    gcc-10.5.0
arm                   randconfig-003-20251129    gcc-13.4.0
arm                   randconfig-004-20251129    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                          randconfig-001    gcc-8.5.0
arm64                          randconfig-002    gcc-14.3.0
arm64                          randconfig-003    clang-22
arm64                          randconfig-004    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                           randconfig-001    gcc-10.5.0
csky                           randconfig-002    gcc-10.5.0
hexagon                           allnoconfig    clang-22
hexagon                        randconfig-001    clang-17
hexagon               randconfig-001-20251130    clang-22
hexagon                        randconfig-002    clang-22
hexagon               randconfig-002-20251130    clang-22
i386                              allnoconfig    gcc-14
i386                 buildonly-randconfig-001    gcc-14
i386        buildonly-randconfig-001-20251130    gcc-14
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20251130    gcc-14
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20251130    gcc-14
i386                 buildonly-randconfig-004    gcc-14
i386        buildonly-randconfig-004-20251130    gcc-14
i386                 buildonly-randconfig-005    gcc-14
i386        buildonly-randconfig-005-20251130    gcc-14
i386                 buildonly-randconfig-006    gcc-14
i386        buildonly-randconfig-006-20251130    clang-20
i386                                defconfig    clang-20
i386                           randconfig-014    clang-20
loongarch                         allnoconfig    clang-22
loongarch                      randconfig-001    clang-18
loongarch             randconfig-001-20251130    gcc-15.1.0
loongarch                      randconfig-002    gcc-13.4.0
loongarch             randconfig-002-20251130    clang-18
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20251130    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20251130    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251129    gcc-10.5.0
parisc                randconfig-002-20251129    gcc-13.4.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251129    gcc-8.5.0
powerpc               randconfig-002-20251129    clang-22
powerpc64             randconfig-001-20251129    gcc-8.5.0
powerpc64             randconfig-002-20251129    gcc-13.4.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                          randconfig-001    gcc-8.5.0
riscv                          randconfig-002    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                           randconfig-001    gcc-11.5.0
s390                  randconfig-001-20251130    clang-22
s390                           randconfig-002    clang-22
s390                  randconfig-002-20251130    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                             randconfig-001    gcc-15.1.0
sh                    randconfig-001-20251130    gcc-14.3.0
sh                             randconfig-002    gcc-14.3.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251130    gcc-14.3.0
sparc                 randconfig-002-20251130    gcc-8.5.0
sparc64                             defconfig    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20251130    gcc-14
x86_64      buildonly-randconfig-002-20251130    clang-20
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20251130    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251130    clang-20
x86_64                randconfig-002-20251130    gcc-14
x86_64                randconfig-003-20251130    gcc-14
x86_64                randconfig-004-20251130    gcc-14
x86_64                randconfig-005-20251130    gcc-14
x86_64                randconfig-006-20251130    clang-20
x86_64                randconfig-073-20251130    gcc-14
x86_64                randconfig-074-20251130    gcc-14
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

