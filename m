Return-Path: <linux-ext4+bounces-8173-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B0FAC0CAD
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 15:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43FB188BC34
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962128BA9A;
	Thu, 22 May 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTYaxTAW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36523C384
	for <linux-ext4@vger.kernel.org>; Thu, 22 May 2025 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920351; cv=none; b=RhlObY4O3A3Tw2ZxJEI9mR1ZbvqjbUh7hZGlP/paS2lDUZko8aywiqen5ean+CRQr9qRZVxy1ePFC9ilWOOAb+HGL15gN6u60knWT79yV49NR/GXl+ktnRfK9bSU95FYuQkUOXDA1sdsXiUP1ElbZqaXZ1Gy2bAIK8FT6Gqbtk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920351; c=relaxed/simple;
	bh=93/nAbTCiy7JQjQFtZJWZHbOCN1FZtzNgnN5l8es9z0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Qh9AeFwOKDpot/0O5VPW4IXiFGh/nOEozHwUOC3JDqckuGutFE+FWOllyZgnGUx6mP/vgPKRyDhA9X2KSahkT8blZZjnd4ye82vwB1EgCUxA7e2XBh2pHV+QluganHlgRFdBRhR3o/h8OoGBO2lK0LJo3qvO4x5xCOi8BZrC/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTYaxTAW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747920349; x=1779456349;
  h=date:from:to:cc:subject:message-id;
  bh=93/nAbTCiy7JQjQFtZJWZHbOCN1FZtzNgnN5l8es9z0=;
  b=mTYaxTAWM9zkVgSouaZqhEvZT2eLMRA65VJOa8EXfC4Ln3Y0/C7sysCa
   mLyt+IuJ+Izs9ggik7v5IDdIar5s2LJKmv7OwKWGGc5n79wz070q5evPD
   iNXHmpwHJ6HPuJtn6cSs7FRffUsuTAi390g93AmoXjYrm7xYH1mhxcwQh
   7nwfrUox4W350hadexSCdFL3el4eDig+50JQQoUAZ/BGi8LCaFSvm8y6q
   iQPkNkFU6ERZeXkNFrqhmyI8WQNLKsEGlf2E72WndzqXZrZv3memvhazk
   aI07hXgpG5KKXpHOjuqMtJwMem9iPp61TmB7oE64MgyVKLdeLvXCnrPc9
   A==;
X-CSE-ConnectionGUID: N0ab+GvlTWOQ/ISqle9y8A==
X-CSE-MsgGUID: n0cWuGGBSVCLByeGSoojyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49064412"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="49064412"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 06:25:49 -0700
X-CSE-ConnectionGUID: IH583mXKQ2mY4FvIXnRxaA==
X-CSE-MsgGUID: UOVVk5BKR6+7GaljQXSNPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="141105696"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 22 May 2025 06:25:48 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI5vd-000PNA-2p;
	Thu, 22 May 2025 13:25:45 +0000
Date: Thu, 22 May 2025 21:25:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 7acd1b315cdcc03b11a3aa1f9c9c85d99ddb4f0e
Message-ID: <202505222134.CppZLhXV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 7acd1b315cdcc03b11a3aa1f9c9c85d99ddb4f0e  ext4: Add a WARN_ON_ONCE for querying LAST_IN_LEAF instead

elapsed time: 1455m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250521    gcc-10.5.0
arc                   randconfig-002-20250521    gcc-12.4.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                       multi_v4t_defconfig    clang-16
arm                   randconfig-001-20250521    clang-21
arm                   randconfig-002-20250521    clang-21
arm                   randconfig-003-20250521    clang-16
arm                   randconfig-004-20250521    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250521    gcc-6.5.0
arm64                 randconfig-002-20250521    gcc-6.5.0
arm64                 randconfig-003-20250521    gcc-8.5.0
arm64                 randconfig-004-20250521    gcc-8.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250522    gcc-15.1.0
csky                  randconfig-002-20250522    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250522    clang-17
hexagon               randconfig-002-20250522    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250521    clang-20
i386        buildonly-randconfig-002-20250521    clang-20
i386        buildonly-randconfig-003-20250521    gcc-12
i386        buildonly-randconfig-004-20250521    clang-20
i386        buildonly-randconfig-005-20250521    gcc-12
i386        buildonly-randconfig-006-20250521    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250522    gcc-15.1.0
loongarch             randconfig-002-20250522    gcc-15.1.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250522    gcc-9.3.0
nios2                 randconfig-002-20250522    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250522    gcc-6.5.0
parisc                randconfig-002-20250522    gcc-12.4.0
parisc64                         alldefconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                       ebony_defconfig    clang-21
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc                   motionpro_defconfig    clang-21
powerpc               randconfig-001-20250522    gcc-9.3.0
powerpc               randconfig-002-20250522    clang-21
powerpc               randconfig-003-20250522    gcc-7.5.0
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250522    clang-21
powerpc64             randconfig-002-20250522    gcc-10.5.0
powerpc64             randconfig-003-20250522    gcc-7.5.0
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250522    gcc-9.3.0
riscv                 randconfig-002-20250522    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250522    clang-19
s390                  randconfig-002-20250522    clang-18
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                    randconfig-001-20250522    gcc-13.3.0
sh                    randconfig-002-20250522    gcc-13.3.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250522    gcc-14.2.0
sparc                 randconfig-002-20250522    gcc-6.5.0
sparc64               randconfig-001-20250522    gcc-14.2.0
sparc64               randconfig-002-20250522    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250522    gcc-12
um                    randconfig-002-20250522    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250521    clang-20
x86_64      buildonly-randconfig-002-20250521    clang-20
x86_64      buildonly-randconfig-003-20250521    gcc-12
x86_64      buildonly-randconfig-004-20250521    gcc-12
x86_64      buildonly-randconfig-005-20250521    clang-20
x86_64      buildonly-randconfig-006-20250521    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250522    gcc-14.2.0
xtensa                randconfig-002-20250522    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

