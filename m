Return-Path: <linux-ext4+bounces-12053-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A2EC90523
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Nov 2025 00:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63B734E0F10
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Nov 2025 23:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6932E313295;
	Thu, 27 Nov 2025 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTECdOHn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420222417F0
	for <linux-ext4@vger.kernel.org>; Thu, 27 Nov 2025 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284698; cv=none; b=qr2xfn5ddkhDeUdfG+a0wGGE3KwxKPEK0AmgqSSSQD2no4IoJtHXnfUHsY4Tkd0QbKB61KoLmL+UY4Npx137Zi0G6UEZurGgCz96LgX9suPWh9NO8eXh1AtCAPN/HwgDDqevalER2jbozp/E76Fo7SFws9CE3phFx93ToKStUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284698; c=relaxed/simple;
	bh=TufQxA+3d7nzC3UOoxIMYp6veaWZ1z+jSkHXDHhpnoQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YO8kcah3JFrMTromfcXEH/NyD1vlUE/UTPqqYhT+rmNGzDaXW66XAIUOfLDkAQa0A67zw9FvAyuvCoO1n98O1cj67k8cRDYi3hTGyRbOBplv34mGNRRC1rNaouHSuV/+FKjoiQJ5XG0fCYKvv11LbXrD93ih9pMODezCkmYzSxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTECdOHn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764284697; x=1795820697;
  h=date:from:to:cc:subject:message-id;
  bh=TufQxA+3d7nzC3UOoxIMYp6veaWZ1z+jSkHXDHhpnoQ=;
  b=BTECdOHnx/JidwwKsuGnGprL2qY46//8WrPSfMjIv6RdmgAUsdgLq8Qp
   bN5VSIOAsAzUaqJIlgdhJVUUOFlRzFNlDdUILrVT3Wk1mRRfPS31yFqy+
   u/6UsMnhC+xyjO7aG4HIZRDVaNw6M4HgvgaAZ8sfk7CYjZ6JcIhVdcbsp
   7oTN91WIdPWq2hgvm+6blLKgrLjuv094h5P8BG2iGSVJwh17NSdSitpqi
   aRfMJuSZKxOTtlPuKOtxDKubuhbSjkXIhE+NkusbIB5Ep1hiTvaasJ3zT
   SzKBFXMnxkJntTGiQUcgX3PjHzfBvdvcoi9GgIQ/5ocMas9bPljk/sR0U
   A==;
X-CSE-ConnectionGUID: yNzzN2nxRlKSFLv14YCrrg==
X-CSE-MsgGUID: cGl4YSMXSHCPvydFZiW82Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="77014517"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="77014517"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 15:04:45 -0800
X-CSE-ConnectionGUID: pLpUB/gdRzSWPiyxIQjdag==
X-CSE-MsgGUID: 2agrwza5RgC+Pmp/eJxVtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="197804746"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Nov 2025 15:04:43 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOl2X-000000005p3-0zKb;
	Thu, 27 Nov 2025 23:04:41 +0000
Date: Fri, 28 Nov 2025 07:03:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 690243606a4fc1ad6b877e0157cce05767ce5be6
Message-ID: <202511280739.qYSuXMwy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 690243606a4fc1ad6b877e0157cce05767ce5be6  ext4: mark inodes without acls in __ext4_iget()

elapsed time: 1466m

configs tested: 184
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251127    gcc-15.1.0
arc                   randconfig-001-20251128    gcc-8.5.0
arc                   randconfig-002-20251127    gcc-8.5.0
arc                   randconfig-002-20251128    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20251127    clang-22
arm                   randconfig-001-20251128    gcc-8.5.0
arm                   randconfig-002-20251127    clang-22
arm                   randconfig-002-20251128    gcc-8.5.0
arm                   randconfig-003-20251127    clang-22
arm                   randconfig-003-20251128    gcc-8.5.0
arm                   randconfig-004-20251127    gcc-10.5.0
arm                   randconfig-004-20251128    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251128    gcc-15.1.0
arm64                 randconfig-002-20251128    gcc-15.1.0
arm64                 randconfig-003-20251128    gcc-15.1.0
arm64                 randconfig-004-20251128    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251128    gcc-15.1.0
csky                  randconfig-002-20251128    gcc-15.1.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251127    clang-22
hexagon               randconfig-001-20251128    clang-22
hexagon               randconfig-002-20251127    clang-18
hexagon               randconfig-002-20251128    clang-22
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386        buildonly-randconfig-001-20251128    gcc-13
i386        buildonly-randconfig-002-20251128    gcc-13
i386        buildonly-randconfig-003-20251128    gcc-13
i386        buildonly-randconfig-004-20251128    gcc-13
i386        buildonly-randconfig-005-20251128    gcc-13
i386        buildonly-randconfig-006-20251128    gcc-13
i386                                defconfig    gcc-15.1.0
i386                  randconfig-011-20251128    gcc-14
i386                  randconfig-012-20251128    gcc-14
i386                  randconfig-013-20251128    gcc-14
i386                  randconfig-014-20251128    gcc-14
i386                  randconfig-015-20251128    gcc-14
i386                  randconfig-016-20251128    gcc-14
i386                  randconfig-017-20251128    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251127    clang-22
loongarch             randconfig-001-20251128    clang-22
loongarch             randconfig-002-20251127    gcc-15.1.0
loongarch             randconfig-002-20251128    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                      loongson1_defconfig    clang-18
mips                          rb532_defconfig    clang-18
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251127    gcc-8.5.0
nios2                 randconfig-001-20251128    clang-22
nios2                 randconfig-002-20251127    gcc-11.5.0
nios2                 randconfig-002-20251128    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251127    gcc-8.5.0
parisc                randconfig-001-20251128    clang-22
parisc                randconfig-002-20251127    gcc-15.1.0
parisc                randconfig-002-20251128    clang-22
parisc64                            defconfig    clang-19
powerpc                    adder875_defconfig    clang-18
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      arches_defconfig    clang-18
powerpc                      pcm030_defconfig    clang-18
powerpc               randconfig-001-20251127    clang-22
powerpc               randconfig-001-20251128    clang-22
powerpc               randconfig-002-20251127    gcc-13.4.0
powerpc               randconfig-002-20251128    clang-22
powerpc                         wii_defconfig    clang-18
powerpc64             randconfig-001-20251127    clang-20
powerpc64             randconfig-001-20251128    clang-22
powerpc64             randconfig-002-20251127    gcc-14.3.0
powerpc64             randconfig-002-20251128    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251127    gcc-12.5.0
riscv                 randconfig-001-20251128    gcc-15.1.0
riscv                 randconfig-002-20251127    clang-22
riscv                 randconfig-002-20251128    gcc-15.1.0
s390                             alldefconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251127    gcc-11.5.0
s390                  randconfig-001-20251128    gcc-15.1.0
s390                  randconfig-002-20251127    clang-22
s390                  randconfig-002-20251128    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251127    gcc-15.1.0
sh                    randconfig-001-20251128    gcc-15.1.0
sh                    randconfig-002-20251127    gcc-12.5.0
sh                    randconfig-002-20251128    gcc-15.1.0
sh                          sdk7780_defconfig    clang-18
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251128    clang-22
sparc                 randconfig-002-20251128    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251128    clang-22
sparc64               randconfig-002-20251128    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251128    clang-22
um                    randconfig-002-20251128    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20251128    clang-20
x86_64      buildonly-randconfig-002-20251128    clang-20
x86_64      buildonly-randconfig-003-20251128    clang-20
x86_64      buildonly-randconfig-004-20251128    clang-20
x86_64      buildonly-randconfig-005-20251128    clang-20
x86_64      buildonly-randconfig-006-20251128    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251128    gcc-14
x86_64                randconfig-002-20251128    gcc-14
x86_64                randconfig-003-20251128    gcc-14
x86_64                randconfig-004-20251128    gcc-14
x86_64                randconfig-005-20251128    gcc-14
x86_64                randconfig-006-20251128    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251128    clang-22
xtensa                randconfig-002-20251128    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

