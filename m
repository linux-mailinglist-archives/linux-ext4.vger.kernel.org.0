Return-Path: <linux-ext4+bounces-9024-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E300AB06C69
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 05:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29963A70B1
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 03:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE80267387;
	Wed, 16 Jul 2025 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llMSqjl4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559E1D63C2
	for <linux-ext4@vger.kernel.org>; Wed, 16 Jul 2025 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637397; cv=none; b=OVaR6l+07RWVikUj0mvUmiSWNCam/zw+7+sBx0XU9q5UzD+NWzoxWpCvJfOqSbYjpp6vuwYB52O5gw45Cz+1TYooHg0irIOIS5wvFi9ddjQ1p71/D5P3OPR587t4qRjFeMmiSrt+9QlIbfB8UUScGtTd0hof9Q44FwSg724OsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637397; c=relaxed/simple;
	bh=LkpCbYv6wBnjD2+W0C03zf8jK92ZWse78lYI7KzBYpk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ia93HS/cFI5t+H0Y0oC/kDN2Lzz6mgdrnM6Z135J3QpDboN+VwihwPEDHvRrhHPECszuM/Zlub0IbthOYCCnRysymboaCWjqWFCR29vAO0ZiYoNTu+YM3LA4izkYCIrjKCvcMN1UQcfZuv9ZYt4q3DiXL05UALcPvrf9GTV8K9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llMSqjl4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752637395; x=1784173395;
  h=date:from:to:cc:subject:message-id;
  bh=LkpCbYv6wBnjD2+W0C03zf8jK92ZWse78lYI7KzBYpk=;
  b=llMSqjl4/W2lqDbVlgaLF7cPFvpqfY47Ds9LM88DpSZth8LuAGzJ3lXa
   nns82caJnENO6WxGcSwnueQSSiLeg6nGuFYUnYm2QxhZe7UpKwyhT5b/t
   sqy5Luej6YwNDxv4eySZc2N3kagdglOuzn/PzyHGNN6NTRvQ4N93MskQ9
   z6g5VX9OvyC088CpZG2sfL8WfLWAO+hllbA4UbnypNeYH+sxe75cgLzLA
   XIQ6wwGJjW/IuVDhb/3l6xFwSMD6Uxs23mNqOLoKpfOUyhtCefI7A5rWH
   YEEmVqBCJ9WAcKODYYQxc5r0bG5IHgN+XXyvtoHZt8x2FGQxywxR4vRso
   Q==;
X-CSE-ConnectionGUID: lmDntZG/RO2Jr2l9FYFYqw==
X-CSE-MsgGUID: /EaLXjXYTse871rd3ZvsBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="42502498"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="42502498"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 20:43:14 -0700
X-CSE-ConnectionGUID: rRdTkKjxSzO8q8DyAIILCw==
X-CSE-MsgGUID: nBDp5IeCTSidIZYQAs3DXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157939690"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Jul 2025 20:43:13 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubt31-000Bq9-14;
	Wed, 16 Jul 2025 03:43:11 +0000
Date: Wed, 16 Jul 2025 11:43:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:pu] BUILD SUCCESS
 e3045167514456a5eee2dc394893244b7c3b66b0
Message-ID: <202507161148.o6BRjvs7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git pu
branch HEAD: e3045167514456a5eee2dc394893244b7c3b66b0  Merge branch 'bl/scalable-allocations' into pu

elapsed time: 1373m

configs tested: 243
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-21
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250715    gcc-8.5.0
arc                   randconfig-001-20250716    clang-21
arc                   randconfig-002-20250715    gcc-11.5.0
arc                   randconfig-002-20250716    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         bcm2835_defconfig    clang-21
arm                                 defconfig    clang-19
arm                   randconfig-001-20250715    clang-21
arm                   randconfig-001-20250716    clang-21
arm                   randconfig-002-20250715    gcc-10.5.0
arm                   randconfig-002-20250716    clang-21
arm                   randconfig-003-20250715    clang-21
arm                   randconfig-003-20250716    clang-21
arm                   randconfig-004-20250715    gcc-12.4.0
arm                   randconfig-004-20250716    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250715    clang-16
arm64                 randconfig-001-20250716    clang-21
arm64                 randconfig-002-20250715    gcc-12.3.0
arm64                 randconfig-002-20250716    clang-21
arm64                 randconfig-003-20250715    gcc-8.5.0
arm64                 randconfig-003-20250716    clang-21
arm64                 randconfig-004-20250715    clang-21
arm64                 randconfig-004-20250716    clang-21
csky                              allnoconfig    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250715    gcc-9.3.0
csky                  randconfig-001-20250716    gcc-15.1.0
csky                  randconfig-002-20250715    gcc-12.4.0
csky                  randconfig-002-20250716    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250715    clang-18
hexagon               randconfig-001-20250716    gcc-15.1.0
hexagon               randconfig-002-20250715    clang-21
hexagon               randconfig-002-20250716    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250715    gcc-12
i386        buildonly-randconfig-001-20250716    gcc-12
i386        buildonly-randconfig-002-20250715    gcc-12
i386        buildonly-randconfig-002-20250716    gcc-12
i386        buildonly-randconfig-003-20250715    gcc-12
i386        buildonly-randconfig-003-20250716    gcc-12
i386        buildonly-randconfig-004-20250715    clang-20
i386        buildonly-randconfig-004-20250716    gcc-12
i386        buildonly-randconfig-005-20250715    clang-20
i386        buildonly-randconfig-005-20250716    gcc-12
i386        buildonly-randconfig-006-20250715    clang-20
i386        buildonly-randconfig-006-20250716    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250716    clang-20
i386                  randconfig-002-20250716    clang-20
i386                  randconfig-003-20250716    clang-20
i386                  randconfig-004-20250716    clang-20
i386                  randconfig-005-20250716    clang-20
i386                  randconfig-006-20250716    clang-20
i386                  randconfig-007-20250716    clang-20
i386                  randconfig-011-20250716    gcc-12
i386                  randconfig-012-20250716    gcc-12
i386                  randconfig-013-20250716    gcc-12
i386                  randconfig-014-20250716    gcc-12
i386                  randconfig-015-20250716    gcc-12
i386                  randconfig-016-20250716    gcc-12
i386                  randconfig-017-20250716    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250715    clang-21
loongarch             randconfig-001-20250716    gcc-15.1.0
loongarch             randconfig-002-20250715    gcc-15.1.0
loongarch             randconfig-002-20250716    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-21
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    clang-21
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250715    gcc-11.5.0
nios2                 randconfig-001-20250716    gcc-15.1.0
nios2                 randconfig-002-20250715    gcc-8.5.0
nios2                 randconfig-002-20250716    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250715    gcc-10.5.0
parisc                randconfig-001-20250716    gcc-15.1.0
parisc                randconfig-002-20250715    gcc-9.3.0
parisc                randconfig-002-20250716    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    clang-21
powerpc                   currituck_defconfig    clang-21
powerpc               randconfig-001-20250715    clang-21
powerpc               randconfig-001-20250716    gcc-15.1.0
powerpc               randconfig-002-20250715    clang-21
powerpc               randconfig-002-20250716    gcc-15.1.0
powerpc               randconfig-003-20250715    gcc-8.5.0
powerpc               randconfig-003-20250716    gcc-15.1.0
powerpc                     stx_gp3_defconfig    clang-21
powerpc64             randconfig-001-20250715    clang-21
powerpc64             randconfig-001-20250716    gcc-15.1.0
powerpc64             randconfig-003-20250715    clang-17
powerpc64             randconfig-003-20250716    gcc-15.1.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250715    clang-21
riscv                 randconfig-001-20250716    gcc-9.3.0
riscv                 randconfig-002-20250715    clang-21
riscv                 randconfig-002-20250716    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250715    gcc-8.5.0
s390                  randconfig-001-20250716    gcc-9.3.0
s390                  randconfig-002-20250715    gcc-12.4.0
s390                  randconfig-002-20250716    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    clang-21
sh                    randconfig-001-20250715    gcc-11.5.0
sh                    randconfig-001-20250716    gcc-9.3.0
sh                    randconfig-002-20250715    gcc-15.1.0
sh                    randconfig-002-20250716    gcc-9.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250715    gcc-8.5.0
sparc                 randconfig-001-20250716    gcc-9.3.0
sparc                 randconfig-002-20250715    gcc-8.5.0
sparc                 randconfig-002-20250716    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250715    clang-20
sparc64               randconfig-001-20250716    gcc-9.3.0
sparc64               randconfig-002-20250715    gcc-8.5.0
sparc64               randconfig-002-20250716    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250715    gcc-12
um                    randconfig-001-20250716    gcc-9.3.0
um                    randconfig-002-20250715    gcc-12
um                    randconfig-002-20250716    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250715    clang-20
x86_64      buildonly-randconfig-001-20250716    clang-20
x86_64      buildonly-randconfig-002-20250715    gcc-12
x86_64      buildonly-randconfig-002-20250716    clang-20
x86_64      buildonly-randconfig-003-20250715    gcc-12
x86_64      buildonly-randconfig-003-20250716    clang-20
x86_64      buildonly-randconfig-004-20250715    gcc-11
x86_64      buildonly-randconfig-004-20250716    clang-20
x86_64      buildonly-randconfig-005-20250715    gcc-12
x86_64      buildonly-randconfig-005-20250716    clang-20
x86_64      buildonly-randconfig-006-20250715    gcc-12
x86_64      buildonly-randconfig-006-20250716    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250716    clang-20
x86_64                randconfig-002-20250716    clang-20
x86_64                randconfig-003-20250716    clang-20
x86_64                randconfig-004-20250716    clang-20
x86_64                randconfig-005-20250716    clang-20
x86_64                randconfig-006-20250716    clang-20
x86_64                randconfig-007-20250716    clang-20
x86_64                randconfig-008-20250716    clang-20
x86_64                randconfig-071-20250716    gcc-12
x86_64                randconfig-072-20250716    gcc-12
x86_64                randconfig-073-20250716    gcc-12
x86_64                randconfig-074-20250716    gcc-12
x86_64                randconfig-075-20250716    gcc-12
x86_64                randconfig-076-20250716    gcc-12
x86_64                randconfig-077-20250716    gcc-12
x86_64                randconfig-078-20250716    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250715    gcc-8.5.0
xtensa                randconfig-001-20250716    gcc-9.3.0
xtensa                randconfig-002-20250715    gcc-14.3.0
xtensa                randconfig-002-20250716    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

