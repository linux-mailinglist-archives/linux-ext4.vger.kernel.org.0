Return-Path: <linux-ext4+bounces-10459-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D4ABA5F5C
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 14:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898737A5E3A
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7270B2DF6EA;
	Sat, 27 Sep 2025 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6dPmxqj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B419EEC2
	for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758977695; cv=none; b=SkcClT5Q0fydnt2VJzYdaTmFaZoFWYxKMthSf01eFn6DlMrNO6c2ws3AD/AYbmYCWAmL4QA0YVxwD9AbLDra1n/tKz7Q4cljvXDfhQ+o+bRzzXyri4/lbGrNMf/GbGCOhohH86eqtcU+qaLMqt3Tqy15XRH0djILt0mxhZgmkJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758977695; c=relaxed/simple;
	bh=uLd8kVT6fvFKSj85NqzQtQwl/i+jylPGF0eBwg4fLeQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PIE4PJSQj1hrFg7qoW6QJkbKeKUjOExJCWc5Y8zAVtqQX3qJtPNN7RJX+Nw05x7iwYzQU7p/4auVJ8zjpNB6gy5cpyWhz8YwBVWLIBnuWol79c1qZNAnZYeBMHE+Dj+K0zXLg7VUVjbPzrZvGfST3IpnO9LBVSKZQVDKpSgJZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6dPmxqj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758977693; x=1790513693;
  h=date:from:to:cc:subject:message-id;
  bh=uLd8kVT6fvFKSj85NqzQtQwl/i+jylPGF0eBwg4fLeQ=;
  b=V6dPmxqjYN8+XZIsu0DvxBw6LTMXG986Pd0rqx/xAmSg74rupPjutKjx
   uqySamjfHI/Jh+NCmP+iAMrugbRVsGs67c4rj2zvxH+yj/7xqtsNRPMKr
   wO9/YME9K0PPrlYBXRHMsCSbytF12LxiIqvtiJ7av8tlV26VpncenfDor
   VyzZhkIYvthhYqPQE+q7PR8dm448OsujLlGmeCRSiI5zdalqWa2AYG9Au
   f5q0mWXQM812dQcCplglJbvsMapcDZwJr5a5PngK0sOv8/fLxv/n6MwqX
   K8zfKtvCO+jv+TRkRi2jg/5IF966Zq83MxMxxVCjNlI5dTEmgI3uBFdNu
   Q==;
X-CSE-ConnectionGUID: 77sB2HZqQvyatlaXGGuR9g==
X-CSE-MsgGUID: WO0zaj2tSKeQXuLtQLCetQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="64921525"
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="64921525"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 05:54:52 -0700
X-CSE-ConnectionGUID: QPvrfqtsQky4AlTGD6jBsQ==
X-CSE-MsgGUID: 8PdDbEw0ShGOLr6b2d3iYQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 27 Sep 2025 05:54:51 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2URr-00073x-12;
	Sat, 27 Sep 2025 12:54:47 +0000
Date: Sat, 27 Sep 2025 20:54:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 acf943e9768ec9d9be80982ca0ebc4bfd6b7631e
Message-ID: <202509272004.pSlg3X5A-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: acf943e9768ec9d9be80982ca0ebc4bfd6b7631e  ext4: fix checks for orphan inodes

elapsed time: 1446m

configs tested: 245
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250926    gcc-8.5.0
arc                   randconfig-001-20250927    gcc-10.5.0
arc                   randconfig-002-20250926    gcc-9.5.0
arc                   randconfig-002-20250927    gcc-10.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                            dove_defconfig    clang-22
arm                         nhk8815_defconfig    clang-22
arm                          pxa910_defconfig    clang-22
arm                   randconfig-001-20250926    clang-22
arm                   randconfig-001-20250927    gcc-10.5.0
arm                   randconfig-002-20250926    clang-17
arm                   randconfig-002-20250927    gcc-10.5.0
arm                   randconfig-003-20250926    clang-22
arm                   randconfig-003-20250927    gcc-10.5.0
arm                   randconfig-004-20250926    clang-22
arm                   randconfig-004-20250927    gcc-10.5.0
arm                       spear13xx_defconfig    gcc-15.1.0
arm64                            alldefconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250926    gcc-8.5.0
arm64                 randconfig-001-20250927    gcc-10.5.0
arm64                 randconfig-002-20250926    gcc-12.5.0
arm64                 randconfig-002-20250927    gcc-10.5.0
arm64                 randconfig-003-20250926    gcc-9.5.0
arm64                 randconfig-003-20250927    gcc-10.5.0
arm64                 randconfig-004-20250926    clang-22
arm64                 randconfig-004-20250927    gcc-10.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250926    gcc-15.1.0
csky                  randconfig-001-20250927    clang-22
csky                  randconfig-002-20250926    gcc-14.3.0
csky                  randconfig-002-20250927    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250926    clang-22
hexagon               randconfig-001-20250927    clang-22
hexagon               randconfig-002-20250926    clang-22
hexagon               randconfig-002-20250927    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250926    clang-20
i386        buildonly-randconfig-001-20250927    clang-20
i386        buildonly-randconfig-002-20250926    clang-20
i386        buildonly-randconfig-002-20250927    clang-20
i386        buildonly-randconfig-003-20250926    clang-20
i386        buildonly-randconfig-003-20250927    clang-20
i386        buildonly-randconfig-004-20250926    clang-20
i386        buildonly-randconfig-004-20250927    clang-20
i386        buildonly-randconfig-005-20250926    clang-20
i386        buildonly-randconfig-005-20250927    clang-20
i386        buildonly-randconfig-006-20250926    clang-20
i386        buildonly-randconfig-006-20250927    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250927    gcc-14
i386                  randconfig-002-20250927    gcc-14
i386                  randconfig-003-20250927    gcc-14
i386                  randconfig-004-20250927    gcc-14
i386                  randconfig-005-20250927    gcc-14
i386                  randconfig-006-20250927    gcc-14
i386                  randconfig-007-20250927    gcc-14
i386                  randconfig-011-20250927    clang-20
i386                  randconfig-012-20250927    clang-20
i386                  randconfig-013-20250927    clang-20
i386                  randconfig-014-20250927    clang-20
i386                  randconfig-015-20250927    clang-20
i386                  randconfig-016-20250927    clang-20
i386                  randconfig-017-20250927    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250926    gcc-15.1.0
loongarch             randconfig-001-20250927    clang-22
loongarch             randconfig-002-20250926    clang-22
loongarch             randconfig-002-20250927    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          multi_defconfig    clang-22
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-22
mips                          rb532_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250926    gcc-11.5.0
nios2                 randconfig-001-20250927    clang-22
nios2                 randconfig-002-20250926    gcc-8.5.0
nios2                 randconfig-002-20250927    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250926    gcc-10.5.0
parisc                randconfig-001-20250927    clang-22
parisc                randconfig-002-20250926    gcc-10.5.0
parisc                randconfig-002-20250927    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250926    clang-22
powerpc               randconfig-001-20250927    clang-22
powerpc               randconfig-002-20250926    clang-18
powerpc               randconfig-002-20250927    clang-22
powerpc               randconfig-003-20250926    clang-22
powerpc               randconfig-003-20250927    clang-22
powerpc64             randconfig-001-20250926    clang-22
powerpc64             randconfig-001-20250927    clang-22
powerpc64             randconfig-002-20250926    clang-16
powerpc64             randconfig-002-20250927    clang-22
powerpc64             randconfig-003-20250926    gcc-15.1.0
powerpc64             randconfig-003-20250927    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250926    clang-22
riscv                 randconfig-001-20250927    gcc-11.5.0
riscv                 randconfig-002-20250926    clang-22
riscv                 randconfig-002-20250927    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250926    clang-22
s390                  randconfig-001-20250927    gcc-11.5.0
s390                  randconfig-002-20250926    gcc-8.5.0
s390                  randconfig-002-20250927    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250926    gcc-12.5.0
sh                    randconfig-001-20250927    gcc-11.5.0
sh                    randconfig-002-20250926    gcc-15.1.0
sh                    randconfig-002-20250927    gcc-11.5.0
sh                           se7343_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250926    gcc-14.3.0
sparc                 randconfig-001-20250927    gcc-11.5.0
sparc                 randconfig-002-20250926    gcc-15.1.0
sparc                 randconfig-002-20250927    gcc-11.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250926    gcc-12.5.0
sparc64               randconfig-001-20250927    gcc-11.5.0
sparc64               randconfig-002-20250926    clang-22
sparc64               randconfig-002-20250927    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250926    clang-22
um                    randconfig-001-20250927    gcc-11.5.0
um                    randconfig-002-20250926    clang-22
um                    randconfig-002-20250927    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250926    clang-20
x86_64      buildonly-randconfig-001-20250927    gcc-14
x86_64      buildonly-randconfig-002-20250926    clang-20
x86_64      buildonly-randconfig-002-20250927    gcc-14
x86_64      buildonly-randconfig-003-20250926    gcc-14
x86_64      buildonly-randconfig-003-20250927    gcc-14
x86_64      buildonly-randconfig-004-20250926    gcc-14
x86_64      buildonly-randconfig-004-20250927    gcc-14
x86_64      buildonly-randconfig-005-20250926    gcc-14
x86_64      buildonly-randconfig-005-20250927    gcc-14
x86_64      buildonly-randconfig-006-20250926    gcc-14
x86_64      buildonly-randconfig-006-20250927    gcc-14
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250927    clang-20
x86_64                randconfig-002-20250927    clang-20
x86_64                randconfig-003-20250927    clang-20
x86_64                randconfig-004-20250927    clang-20
x86_64                randconfig-005-20250927    clang-20
x86_64                randconfig-006-20250927    clang-20
x86_64                randconfig-007-20250927    clang-20
x86_64                randconfig-008-20250927    clang-20
x86_64                randconfig-071-20250927    gcc-14
x86_64                randconfig-072-20250927    gcc-14
x86_64                randconfig-073-20250927    gcc-14
x86_64                randconfig-074-20250927    gcc-14
x86_64                randconfig-075-20250927    gcc-14
x86_64                randconfig-076-20250927    gcc-14
x86_64                randconfig-077-20250927    gcc-14
x86_64                randconfig-078-20250927    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250926    gcc-14.3.0
xtensa                randconfig-001-20250927    gcc-11.5.0
xtensa                randconfig-002-20250926    gcc-8.5.0
xtensa                randconfig-002-20250927    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

