Return-Path: <linux-ext4+bounces-6957-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B318A6D0DB
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Mar 2025 20:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E973A74B6
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Mar 2025 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFED4199943;
	Sun, 23 Mar 2025 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6DfS/ti"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5361A01B0
	for <linux-ext4@vger.kernel.org>; Sun, 23 Mar 2025 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742758967; cv=none; b=ohhcCawNg6xjv6TD1Vjb6u5+JkSEZw/7gaGMNwrwd8G/0uMJMUBtvn8oalv0Rh1zagCdmYyfewly3BrZwF4FoDCQQF+Dg3neHsPIU0UvH7ZJgz9LDwhBUrdgKyDBgCyNERiSTZBFGxZsQ+9bXwV128SnKTdxOk3Ykb+1gAnPyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742758967; c=relaxed/simple;
	bh=aLxxJztonVmXOuPxK2ShX0+oEm+nt6tmK8Cd4gC+nbk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kmyVVTrfcVmM56lSYaL/DGr9RDGH8yxfqZdcKiUlVZp/USdjUyBUE4lC4+sQh6WBpskQuZXJMEl8Kw+F1dK+S/Xmml4c06iJtLoUW0sDfIHwm5MK/j+mTPf3R2BzgR0XfLpijESTiZuSlbNS29Ta7o8co7GpyUgJUWdPYcIHUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6DfS/ti; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742758966; x=1774294966;
  h=date:from:to:cc:subject:message-id;
  bh=aLxxJztonVmXOuPxK2ShX0+oEm+nt6tmK8Cd4gC+nbk=;
  b=M6DfS/tijOOS5wb7pO4KyBrfuBK7A1OeuMv7jz7gBqVjy4i/lK/TsKGB
   QmrjCugX2ZrcCjwd4D62ZHEUD2zW2WiT0o/bMN6aXYIuNeqg98PtDUGYn
   iBuQmKmhL4cUdcD0D8quOPKJkh35kF3JlHWei2rcvTpW3a/TcernsiIW5
   TL/ZHLbU8djJSJLwmTEOU2Uyu3wpoWTF5fKKtadu+6ptKs9G80+hjh6lJ
   NJf/Nzo8vPgsDEXQPClYc5jIY1vDTRRoGVHVs4LJHOZR+9sAN6/WT9cz4
   hBNzokffX5TYa8D4FlKKqhwumVQzovsbkLbEHNyWgsoSNDeUyjgjQFbj/
   w==;
X-CSE-ConnectionGUID: RPUTEcBxQGu4Hb2QG1BDzA==
X-CSE-MsgGUID: 6W1nVK0fT2uX1Xf1AR4aGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="46701791"
X-IronPort-AV: E=Sophos;i="6.14,270,1736841600"; 
   d="scan'208";a="46701791"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 12:42:44 -0700
X-CSE-ConnectionGUID: QUoU9xy2SBq1smkoI/kjWw==
X-CSE-MsgGUID: XA2tGQ9sS+aXw4ygM5B0+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,270,1736841600"; 
   d="scan'208";a="123658331"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 23 Mar 2025 12:42:42 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twRDU-0002vs-2b;
	Sun, 23 Mar 2025 19:42:40 +0000
Date: Mon, 24 Mar 2025 03:42:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 2b0979df04e66765c599592d36121a2ab7fb21ad
Message-ID: <202503240327.VDgcAXJd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 2b0979df04e66765c599592d36121a2ab7fb21ad  Merge tag 'next-20250321' of ../linux into test

elapsed time: 1444m

configs tested: 138
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-14.2.0
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250323    gcc-11.5.0
arc                   randconfig-002-20250323    gcc-13.3.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-14
arm                   randconfig-001-20250323    gcc-7.5.0
arm                   randconfig-002-20250323    gcc-9.3.0
arm                   randconfig-003-20250323    clang-15
arm                   randconfig-004-20250323    gcc-5.5.0
arm                           spitz_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250323    clang-21
arm64                 randconfig-002-20250323    gcc-5.5.0
arm64                 randconfig-003-20250323    gcc-9.5.0
arm64                 randconfig-004-20250323    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250323    gcc-13.3.0
csky                  randconfig-002-20250323    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250323    clang-21
hexagon               randconfig-002-20250323    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250323    clang-20
i386        buildonly-randconfig-002-20250323    gcc-12
i386        buildonly-randconfig-003-20250323    clang-20
i386        buildonly-randconfig-004-20250323    clang-20
i386        buildonly-randconfig-005-20250323    gcc-12
i386        buildonly-randconfig-006-20250323    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250323    gcc-14.2.0
loongarch             randconfig-002-20250323    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250323    gcc-13.3.0
nios2                 randconfig-002-20250323    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250323    gcc-10.5.0
parisc                randconfig-002-20250323    gcc-6.5.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                        cell_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250323    gcc-9.3.0
powerpc               randconfig-002-20250323    gcc-7.5.0
powerpc               randconfig-003-20250323    gcc-9.3.0
powerpc64             randconfig-001-20250323    clang-16
powerpc64             randconfig-002-20250323    gcc-9.3.0
powerpc64             randconfig-003-20250323    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250323    gcc-9.3.0
riscv                 randconfig-002-20250323    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250323    gcc-8.5.0
s390                  randconfig-002-20250323    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                         ecovec24_defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250323    gcc-5.5.0
sh                    randconfig-002-20250323    gcc-5.5.0
sh                           se7343_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250323    gcc-14.2.0
sparc                 randconfig-002-20250323    gcc-10.3.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250323    gcc-14.2.0
sparc64               randconfig-002-20250323    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250323    gcc-12
um                    randconfig-002-20250323    clang-17
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250323    clang-20
x86_64      buildonly-randconfig-002-20250323    clang-20
x86_64      buildonly-randconfig-003-20250323    gcc-12
x86_64      buildonly-randconfig-004-20250323    clang-20
x86_64      buildonly-randconfig-005-20250323    clang-20
x86_64      buildonly-randconfig-006-20250323    clang-20
x86_64                              defconfig    gcc-11
xtensa                           alldefconfig    gcc-14.2.0
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250323    gcc-14.2.0
xtensa                randconfig-002-20250323    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

