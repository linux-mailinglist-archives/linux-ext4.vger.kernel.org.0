Return-Path: <linux-ext4+bounces-10787-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB021BCFCCF
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Oct 2025 22:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EE7189A795
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Oct 2025 21:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3370527E7DF;
	Sat, 11 Oct 2025 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7Dh5VZk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC52524D1
	for <linux-ext4@vger.kernel.org>; Sat, 11 Oct 2025 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760216376; cv=none; b=PpcADEudi3gQnjoN9u35WbPXd3guembrc2WM3V1DtcGn6Re/4EXyg6P6YQ4sTNK7wnL9ocwM5xBouQ0Si4c9irFzPSmAo9PwjUyi47n/TQF5c1Qb4EYOn2LAzmw+x2JvHp1r/uPA8iHPFbD46hNV/Z7S8siFxVmb/8C8gpD33Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760216376; c=relaxed/simple;
	bh=M4qoMGpOkCTdeGo07vH5TJY5l+cFq8FqZ4N0+bF3600=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VDRsxjH7Np+NTFOyi1Y5SF6NwUgE9pvh0QSTon8QbQhduYXaOK4KybtLEuXwxvkO5lqRxiFbh0C2rtSeNQnh4T39tMOJ7cIb2/Cuki83tu7amwr5N93vnldI72tjJ9D1L2phj0sSnyXVoSKqnZkjWbyHPhIX4tyRJrwnFgjgEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7Dh5VZk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760216375; x=1791752375;
  h=date:from:to:cc:subject:message-id;
  bh=M4qoMGpOkCTdeGo07vH5TJY5l+cFq8FqZ4N0+bF3600=;
  b=f7Dh5VZkfZKh1FN9avqVU5BC18K3f5w+DflhqroC6/X/9WD04Sl97u6n
   Z/1uwcpBoQm8qPyMBEbnb/9OjvXrPpN84yRQcLI1vKAG+C4wbflXdw47p
   14yWXclk9VOZD8xDvLFbqEuXoJF09ZFsIHRCovqE8gzHEfVXdjN0Mdpsw
   MDq1jEuqkzAhfI6niRmN8U3XHQgOr16AJQ/IJxgSmVdrMbDBTIRr2ZqRX
   zsBRkiuEY6QcM4LWqkotejsP00fVKCTRF0Pklx93M7dBwSxcwbFdORsDd
   h5NWz4mzW9zfmxYCLJBUg5lsZTEoBCsu/69nNais6GcwHnh4gYLOWdbpb
   A==;
X-CSE-ConnectionGUID: rKYX3xS5TfOPF1Ig/XLDkw==
X-CSE-MsgGUID: 7XmzbSBzQ5asM+FnFQpppQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11579"; a="49959026"
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="49959026"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 13:59:34 -0700
X-CSE-ConnectionGUID: 73ZG+xg5SuGSJJIcbK38pA==
X-CSE-MsgGUID: T6ga7uz6TA6yPYfsucx47w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="181672865"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Oct 2025 13:59:33 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7ggd-0003zP-0f;
	Sat, 11 Oct 2025 20:59:31 +0000
Date: Sun, 12 Oct 2025 04:58:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 971843c511c3c2f6eda96c6b03442913bfee6148
Message-ID: <202510120446.wl9Re2r4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 971843c511c3c2f6eda96c6b03442913bfee6148  ext4: free orphan info with kvfree

elapsed time: 1449m

configs tested: 245
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251011    clang-22
arc                   randconfig-001-20251011    gcc-9.5.0
arc                   randconfig-002-20251011    clang-22
arc                   randconfig-002-20251011    gcc-9.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                        clps711x_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                       imx_v6_v7_defconfig    gcc-15.1.0
arm                          moxart_defconfig    gcc-15.1.0
arm                       netwinder_defconfig    gcc-15.1.0
arm                   randconfig-001-20251011    clang-22
arm                   randconfig-002-20251011    clang-22
arm                   randconfig-002-20251011    gcc-12.5.0
arm                   randconfig-003-20251011    clang-22
arm                   randconfig-004-20251011    clang-22
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251011    clang-22
arm64                 randconfig-001-20251011    gcc-10.5.0
arm64                 randconfig-002-20251011    clang-22
arm64                 randconfig-002-20251011    gcc-12.5.0
arm64                 randconfig-003-20251011    clang-22
arm64                 randconfig-004-20251011    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251011    gcc-13.4.0
csky                  randconfig-001-20251011    gcc-8.5.0
csky                  randconfig-002-20251011    gcc-13.4.0
csky                  randconfig-002-20251011    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251011    clang-18
hexagon               randconfig-001-20251011    gcc-8.5.0
hexagon               randconfig-002-20251011    clang-22
hexagon               randconfig-002-20251011    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251011    clang-20
i386        buildonly-randconfig-001-20251011    gcc-13
i386        buildonly-randconfig-002-20251011    clang-20
i386        buildonly-randconfig-003-20251011    clang-20
i386        buildonly-randconfig-003-20251011    gcc-14
i386        buildonly-randconfig-004-20251011    clang-20
i386        buildonly-randconfig-004-20251011    gcc-14
i386        buildonly-randconfig-005-20251011    clang-20
i386        buildonly-randconfig-006-20251011    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251011    gcc-14
i386                  randconfig-002-20251011    gcc-14
i386                  randconfig-003-20251011    gcc-14
i386                  randconfig-004-20251011    gcc-14
i386                  randconfig-005-20251011    gcc-14
i386                  randconfig-006-20251011    gcc-14
i386                  randconfig-007-20251011    gcc-14
i386                  randconfig-011-20251011    clang-20
i386                  randconfig-012-20251011    clang-20
i386                  randconfig-013-20251011    clang-20
i386                  randconfig-014-20251011    clang-20
i386                  randconfig-015-20251011    clang-20
i386                  randconfig-016-20251011    clang-20
i386                  randconfig-017-20251011    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251011    clang-18
loongarch             randconfig-001-20251011    gcc-8.5.0
loongarch             randconfig-002-20251011    gcc-12.5.0
loongarch             randconfig-002-20251011    gcc-8.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                            gpr_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251011    gcc-8.5.0
nios2                 randconfig-002-20251011    gcc-8.5.0
nios2                 randconfig-002-20251011    gcc-9.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           alldefconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251011    gcc-8.5.0
parisc                randconfig-002-20251011    gcc-14.3.0
parisc                randconfig-002-20251011    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251011    clang-22
powerpc               randconfig-001-20251011    gcc-8.5.0
powerpc               randconfig-002-20251011    gcc-8.5.0
powerpc               randconfig-003-20251011    clang-22
powerpc               randconfig-003-20251011    gcc-8.5.0
powerpc64             randconfig-001-20251011    clang-22
powerpc64             randconfig-001-20251011    gcc-8.5.0
powerpc64             randconfig-002-20251011    gcc-8.5.0
powerpc64             randconfig-003-20251011    clang-22
powerpc64             randconfig-003-20251011    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251011    clang-18
riscv                 randconfig-001-20251011    clang-22
riscv                 randconfig-002-20251011    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251011    clang-22
s390                  randconfig-001-20251011    gcc-9.5.0
s390                  randconfig-002-20251011    clang-22
s390                  randconfig-002-20251011    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.1.0
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20251011    clang-22
sh                    randconfig-001-20251011    gcc-15.1.0
sh                    randconfig-002-20251011    clang-22
sh                    randconfig-002-20251011    gcc-11.5.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251011    clang-22
sparc                 randconfig-001-20251011    gcc-15.1.0
sparc                 randconfig-002-20251011    clang-22
sparc                 randconfig-002-20251011    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251011    clang-22
sparc64               randconfig-002-20251011    clang-22
sparc64               randconfig-002-20251011    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251011    clang-17
um                    randconfig-001-20251011    clang-22
um                    randconfig-002-20251011    clang-19
um                    randconfig-002-20251011    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251011    clang-20
x86_64      buildonly-randconfig-002-20251011    clang-20
x86_64      buildonly-randconfig-003-20251011    clang-20
x86_64      buildonly-randconfig-004-20251011    clang-20
x86_64      buildonly-randconfig-004-20251011    gcc-14
x86_64      buildonly-randconfig-005-20251011    clang-20
x86_64      buildonly-randconfig-005-20251011    gcc-14
x86_64      buildonly-randconfig-006-20251011    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251011    gcc-14
x86_64                randconfig-002-20251011    gcc-14
x86_64                randconfig-003-20251011    gcc-14
x86_64                randconfig-004-20251011    gcc-14
x86_64                randconfig-005-20251011    gcc-14
x86_64                randconfig-006-20251011    gcc-14
x86_64                randconfig-007-20251011    gcc-14
x86_64                randconfig-008-20251011    gcc-14
x86_64                randconfig-071-20251011    clang-20
x86_64                randconfig-072-20251011    clang-20
x86_64                randconfig-073-20251011    clang-20
x86_64                randconfig-074-20251011    clang-20
x86_64                randconfig-075-20251011    clang-20
x86_64                randconfig-076-20251011    clang-20
x86_64                randconfig-077-20251011    clang-20
x86_64                randconfig-078-20251011    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251011    clang-22
xtensa                randconfig-001-20251011    gcc-8.5.0
xtensa                randconfig-002-20251011    clang-22
xtensa                randconfig-002-20251011    gcc-8.5.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

