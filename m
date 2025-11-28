Return-Path: <linux-ext4+bounces-12058-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E312AC90DB1
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Nov 2025 05:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D2CC34C1BB
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Nov 2025 04:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CCF3A1DB;
	Fri, 28 Nov 2025 04:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7ZK5dQ6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581772F85B
	for <linux-ext4@vger.kernel.org>; Fri, 28 Nov 2025 04:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764305760; cv=none; b=Ih8QGKzRDUQhHAcfT593NYRlUI1jAH53Iy48ATW/GepejlU/mBTVtWJLw7YGnZq2hk52SGDylCj8K/Yc3Zz84bJCciAMqfn4yNRrqXWhiRcMX3ogM+AdkCmyBLOXwGojpEJ0qINqXooUThUAQQGebMY7Ba0Nn7iY4znqy7YeXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764305760; c=relaxed/simple;
	bh=0otHY3B4NgUXT/SFqLpW0jckrqPkDrjOcIU6LDG3dS4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Cce8YbG10SKvMNgLvBaCXsE1e9xkHW7UdY5zrXjjGlY5jaxClm6mosEgPSypUGeixwdR5FDe2cOjMNcgwA7QFgA5KNWdZEXlw43Oe/W0aEfaQJsEOe+QIb98Lop6daWl2e1IlFPEmM23h4bjeJvXN0Ml+UefDaB/Jo4oKbqZIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7ZK5dQ6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764305759; x=1795841759;
  h=date:from:to:cc:subject:message-id;
  bh=0otHY3B4NgUXT/SFqLpW0jckrqPkDrjOcIU6LDG3dS4=;
  b=M7ZK5dQ6hozjV7B+oeKwS8L0fi+TBu0xS56H70D+sNs2vjcg25R051pD
   jtUmviQ95zYwmRG2jlp2ITYVOkkq0Kk9YC3QMP5nny93/ZXfP5PYgy5sq
   6bXqXjBpy00RFAsxy9ilRZwe6o/Oo72ZhQ42XRRRdMDKTl8/1qzVDsY1d
   tYqW8scFydXLxAjvKXUuwmprDYgad9/GeaTVbtiIYdwXidVQrH2y3p5ao
   9x8NPz3g31UCLpbM4U+wVcaewVXUdW4ygYGE/EtxC3aBH9XHPTHag0cd3
   G9HYU7WMcVCB6MYfzjatoHWySoW7IaVWr6oSF8OyARyLVYITdpCO2DCNq
   A==;
X-CSE-ConnectionGUID: 0fH0xnsHR+G/CjM52MWQ2g==
X-CSE-MsgGUID: BtOk9Gq/RvKbrbt9rZ0oiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66053779"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="66053779"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 20:55:58 -0800
X-CSE-ConnectionGUID: rXzJAaTATK2/9ABwBHQDFA==
X-CSE-MsgGUID: hUMCjHofQzGBwmNUk/2/kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="198488151"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 27 Nov 2025 20:55:57 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOqWQ-00000000637-2Klh;
	Fri, 28 Nov 2025 04:55:54 +0000
Date: Fri, 28 Nov 2025 12:55:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 80cf63ab03b2f77cbf1218344e14391096289f4e
Message-ID: <202511281233.h6N4FVqW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 80cf63ab03b2f77cbf1218344e14391096289f4e  fs: Add uoff_t

elapsed time: 1818m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251127    gcc-15.1.0
arc                   randconfig-002-20251127    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251127    clang-22
arm                   randconfig-002-20251127    clang-22
arm                   randconfig-003-20251127    clang-22
arm                   randconfig-004-20251127    gcc-10.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251128    clang-22
arm64                 randconfig-002-20251128    clang-20
arm64                 randconfig-003-20251128    clang-22
arm64                 randconfig-004-20251128    gcc-10.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251128    gcc-15.1.0
csky                  randconfig-002-20251128    gcc-12.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251127    clang-22
hexagon               randconfig-002-20251127    clang-18
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251128    gcc-14
i386        buildonly-randconfig-002-20251128    clang-20
i386        buildonly-randconfig-003-20251128    clang-20
i386        buildonly-randconfig-004-20251128    clang-20
i386        buildonly-randconfig-005-20251128    gcc-13
i386        buildonly-randconfig-006-20251128    clang-20
i386                  randconfig-001-20251128    clang-20
i386                  randconfig-002-20251128    clang-20
i386                  randconfig-003-20251128    clang-20
i386                  randconfig-011-20251128    gcc-12
i386                  randconfig-012-20251128    gcc-14
i386                  randconfig-014-20251128    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251127    gcc-8.5.0
nios2                 randconfig-002-20251127    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251127    gcc-8.5.0
parisc                randconfig-002-20251127    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                    adder875_defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                      pcm030_defconfig    clang-22
powerpc               randconfig-001-20251127    clang-22
powerpc               randconfig-002-20251127    gcc-13.4.0
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251127    clang-20
powerpc64             randconfig-002-20251127    gcc-14.3.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251127    gcc-12.5.0
s390                             alldefconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251127    gcc-11.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          sdk7780_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251127    gcc-13.4.0
sparc                 randconfig-002-20251127    gcc-11.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251127    gcc-15.1.0
sparc64               randconfig-002-20251127    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251127    gcc-14
um                    randconfig-002-20251127    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251128    clang-20
x86_64      buildonly-randconfig-002-20251128    gcc-14
x86_64      buildonly-randconfig-003-20251128    gcc-14
x86_64      buildonly-randconfig-004-20251128    gcc-14
x86_64      buildonly-randconfig-005-20251128    clang-20
x86_64      buildonly-randconfig-006-20251128    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-071-20251128    clang-20
x86_64                randconfig-072-20251128    gcc-14
x86_64                randconfig-073-20251128    clang-20
x86_64                randconfig-074-20251128    gcc-14
x86_64                randconfig-075-20251128    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251127    gcc-11.5.0
xtensa                randconfig-002-20251127    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

