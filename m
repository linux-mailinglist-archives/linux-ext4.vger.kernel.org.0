Return-Path: <linux-ext4+bounces-8966-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E01BB02FD9
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Jul 2025 10:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCDA1A6062A
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Jul 2025 08:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE81E1C3F;
	Sun, 13 Jul 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSx/i609"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E38EC5
	for <linux-ext4@vger.kernel.org>; Sun, 13 Jul 2025 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394941; cv=none; b=dqwSO2xDvVcSPMciKY2Ds6pTN42iTj7H+SZuTQGjocI6GA6ljXM/2FCbivX7ac/o4PN048C+EFmO/iNi57lproyNcrbkZNvSKQSMAuIMboPpJOCPM7ixJGJgICYhsFRzzpe674SlYZoosM9LP292iQzfA5n5zhyDKBUo//ZfCAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394941; c=relaxed/simple;
	bh=5fcZRiR5wXitgQowfb2eiRzMpT/Rvtu/+8zzm1WzGLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FKXVfo566V66hdAQlyg3dGkpVt0ZHq5lg+W2hyO2vFtlP4I77sRsSESGvsMW8K5DytMGZehObrcDLuXQAgvobWBVQI8ON/0FJ5smsr0Pr0MSBrJyyrCqEYctJqt/dDIcVVfPMNUgZjDHry37FWo9z7SZ4Z81wl8hadXUtVcSYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSx/i609; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752394940; x=1783930940;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5fcZRiR5wXitgQowfb2eiRzMpT/Rvtu/+8zzm1WzGLQ=;
  b=TSx/i6099Q/Bu+Gkkh89Wev05lgAzy+hoD8XAZv6qCHGYVaPvsqGMNiG
   ubbWDYM7Xm/4pfFb0aU/rj1/LkIuu/vbEtQJ/mtAFQD5Rvebg7Xpv/y35
   OyIFOLHqlh5qQR/vM7y2RR2wGMpzi1szO7CFQaLtKKE3ZVCAUTF6LMz5t
   6ILv7MQQfCnirBMQfeUBuWTTTmfdNBJ2qL0JaugdD6p7jRkX8rqUpaUGN
   gh2EcAPDm7H4cOL3sox/q8SgV8U5prtbL1cJJLeEqBYv2wKG1AUZYLOoE
   rq3gVqqbm2WXWKA8LupJGqLAq6v7Ip4kDfctsKjxD5FH3ppvcSNaYnN8I
   g==;
X-CSE-ConnectionGUID: Bx1f1NbrSA2+vUx70jgS/A==
X-CSE-MsgGUID: 2SpDiT2MT4S1DeXcRxiVew==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54775797"
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="54775797"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 01:22:19 -0700
X-CSE-ConnectionGUID: iESITSRdSZmcX5ywNd/Jdg==
X-CSE-MsgGUID: aO4prj3kTU+bIW0bT2MaMw==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="157192073"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 13 Jul 2025 01:22:19 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaryR-000800-2R;
	Sun, 13 Jul 2025 08:22:15 +0000
Date: Sun, 13 Jul 2025 16:21:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:pu] BUILD REGRESSION
 a3404072989e188560fb86c1116ef76bcb8a5c4d
Message-ID: <202507131605.nqFzIW0Y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git=
 pu
branch HEAD: a3404072989e188560fb86c1116ef76bcb8a5c4d  Merge branch 'yz/fol=
io-credits' into pu

Unverified Error/Warning (likely false positive, kindly check if interested=
):

    fs/ext4/inode.c:5212:11: error: call to '__compiletime_assert_652' decl=
ared with 'error' attribute: min(({ __auto_type __UNIQUE_ID_x_647 =3D (((0 =
? 4 : 6) * 2 - 1)); __auto_type __UNIQUE_ID_y_648 =3D (((16 + __pte_index_s=
ize)-16)); do { __attribute__((__noreturn__)) extern void __compiletime_ass=
ert_649(void) __attribute__((__error__("min""(""((0 ? 4 : 6) * 2 - 1)"", ""=
((16 + __pte_index_size)-16)"") signedness error"))); if (!(!(!(((((typeof(=
__UNIQUE_ID_x_647))(-1)) < ( typeof(__UNIQUE_ID_x_647))1) ? (2 + (__builtin=
_constant_p((long long)(__UNIQUE_ID_x_647) >=3D 0) && ((long long)(__UNIQUE=
_ID_x_647) >=3D 0))) : (1 + 2 * (sizeof(__UNIQUE_ID_x_647) < 4))) & ((((typ=
eof(__UNIQUE_ID_y_648))(-1)) < ( typeof(__UNIQUE_ID_y_648))1) ? (2 + (__bui=
ltin_constant_p((long long)(__UNIQUE_ID_y_648) >=3D 0) && ((long long)(__UN=
IQUE_ID_y_648) >=3D 0))) : (1 + 2 * (sizeof(__UNIQUE_ID_y_648) < 4))))))) _=
_compiletime_assert_649(); } while (0); ((__UNIQUE_ID_x_647) < (__UNIQUE_ID=
_y_648) ? (__UNIQUE_ID_x_647) : (__UNIQUE_ID_y_648)); }), (11 + (inode)->i_=
blkbits - 16)) signedness error

Error/Warning ids grouped by kconfigs:

recent_errors
`-- powerpc-ppc64_defconfig
    `-- fs-ext4-inode.c:error:call-to-__compiletime_assert_NNN-declared-wit=
h-error-attribute:min((-__auto_type-__UNIQUE_ID_x_647-(((:)-))-__auto_type-=
__UNIQUE_ID_y_648-(((-__pte_index_size)-))-do-__attribute_

elapsed time: 724m

configs tested: 125
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250713    gcc-11.5.0
arc                   randconfig-002-20250713    gcc-10.5.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                          ep93xx_defconfig    clang-21
arm                        keystone_defconfig    gcc-15.1.0
arm                   randconfig-001-20250713    clang-21
arm                   randconfig-002-20250713    gcc-10.5.0
arm                   randconfig-003-20250713    clang-21
arm                   randconfig-004-20250713    gcc-11.5.0
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250713    gcc-8.5.0
arm64                 randconfig-002-20250713    gcc-13.4.0
arm64                 randconfig-003-20250713    clang-21
arm64                 randconfig-004-20250713    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250713    gcc-15.1.0
csky                  randconfig-002-20250713    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250713    clang-21
hexagon               randconfig-002-20250713    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250713    clang-20
i386        buildonly-randconfig-002-20250713    clang-20
i386        buildonly-randconfig-003-20250713    gcc-12
i386        buildonly-randconfig-004-20250713    gcc-12
i386        buildonly-randconfig-005-20250713    clang-20
i386        buildonly-randconfig-006-20250713    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250713    clang-21
loongarch             randconfig-002-20250713    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        vocore2_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250713    gcc-11.5.0
nios2                 randconfig-002-20250713    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250713    gcc-8.5.0
parisc                randconfig-002-20250713    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                   motionpro_defconfig    clang-21
powerpc                       ppc64_defconfig    clang-21
powerpc               randconfig-001-20250713    clang-21
powerpc               randconfig-002-20250713    clang-19
powerpc               randconfig-003-20250713    gcc-8.5.0
powerpc64             randconfig-002-20250713    clang-21
powerpc64             randconfig-003-20250713    gcc-13.4.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250713    clang-20
riscv                 randconfig-002-20250713    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250713    clang-21
s390                  randconfig-002-20250713    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250713    gcc-15.1.0
sh                    randconfig-002-20250713    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250713    gcc-8.5.0
sparc                 randconfig-002-20250713    gcc-10.3.0
sparc64               randconfig-001-20250713    gcc-8.5.0
sparc64               randconfig-002-20250713    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                    randconfig-001-20250713    clang-21
um                    randconfig-002-20250713    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250713    clang-20
x86_64      buildonly-randconfig-002-20250713    clang-20
x86_64      buildonly-randconfig-003-20250713    clang-20
x86_64      buildonly-randconfig-004-20250713    clang-20
x86_64      buildonly-randconfig-005-20250713    clang-20
x86_64      buildonly-randconfig-006-20250713    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250713    gcc-11.5.0
xtensa                randconfig-002-20250713    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

