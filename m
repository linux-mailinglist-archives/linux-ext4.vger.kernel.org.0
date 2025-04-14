Return-Path: <linux-ext4+bounces-7229-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D60D7A875F6
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 05:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097421890173
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 03:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E92C18D65C;
	Mon, 14 Apr 2025 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtBvnxya"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C9AD51
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744599664; cv=none; b=XwnlMKWFeWfwkRBDPRVdEWQdSscsBXceJCcxpgfRuSYe/0YWG1XmYM/9Q23EVVn2kz8PVLEGKPK+tBgxaoPSAgwsmzVIZ7+UmRdwwi/YufTLyBD8jhc1EaYxSFJYDJ2EhFl1pv07xpDY66BynzeA8QA7oO21O4YSQMpn8agnJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744599664; c=relaxed/simple;
	bh=y9tFF5TbnT/KxDnQdg9ujzkDTk9ZkhaqvYc6JUnddzw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=umy8bZIsPOnLXnp34h9i4L1XDmY5fPAk1Rry5fHO0mvxllwb9138L9cnvXks15fnaNGyf0/UQwwjd9sM4bKn7xOddvglxTVooqhE5q9pL9Wx0gDbGjTBI7NQbp0m6+BASTJ58xIPkrr9RgBLbIVemljntnPQfEmLMx2So/gqnl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtBvnxya; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744599663; x=1776135663;
  h=date:from:to:cc:subject:message-id;
  bh=y9tFF5TbnT/KxDnQdg9ujzkDTk9ZkhaqvYc6JUnddzw=;
  b=dtBvnxyafkGgMvdmqR31PJTDX58On2cgwKmGB10nAQ6WD1lc/ftvTKgM
   xk2Gf7uS+433xSbIKpF8OmZ78niQjpMqr/Ib0/UIz79uz5uPJ+H56Ni2H
   00m10+R1Qx2Ek+xz0BXs62b52GzV26pIC4q6P89NLTfLE5RReTFX/tthq
   PLsMNhXfHTpIlIXXJFeLfm78KqeWHuWyyjuwrXt2c8B7P3X1fvz98HvIZ
   a88BgrH0lM7sGsKgOqQR7BfXJKay0IU3jh1MmDbRV9SsBrhjWhIUB1dht
   Yy2vBUaanLgy3teesj0vI8VzNOypCou48r+XYy0KO79HeTvX7gUXGRZRK
   w==;
X-CSE-ConnectionGUID: NO5T2u4oQkeDepxHOxd94g==
X-CSE-MsgGUID: 8OAP1f75R2W9F33ID2Xv5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="56716257"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="56716257"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 20:01:02 -0700
X-CSE-ConnectionGUID: KYyKNyrzTkiJ7dtdgm79kw==
X-CSE-MsgGUID: XNLxB22vSM2PzYOAeyCaow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="129663286"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Apr 2025 20:01:01 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4A4A-000DKu-1X;
	Mon, 14 Apr 2025 03:00:58 +0000
Date: Mon, 14 Apr 2025 11:00:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 94824ac9a8aaf2fb3c54b4bdde842db80ffa555d
Message-ID: <202504141121.K9MdQVDW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 94824ac9a8aaf2fb3c54b4bdde842db80ffa555d  ext4: fix off-by-one error in do_split

elapsed time: 1444m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-14.2.0
arc                   randconfig-001-20250413    gcc-11.5.0
arc                   randconfig-002-20250413    gcc-13.3.0
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                             mxs_defconfig    clang-21
arm                   randconfig-001-20250413    gcc-6.5.0
arm                   randconfig-002-20250413    gcc-6.5.0
arm                   randconfig-003-20250413    clang-21
arm                   randconfig-004-20250413    gcc-6.5.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250413    gcc-7.5.0
arm64                 randconfig-002-20250413    clang-21
arm64                 randconfig-003-20250413    gcc-7.5.0
arm64                 randconfig-004-20250413    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250413    gcc-9.3.0
csky                  randconfig-002-20250413    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250413    clang-21
hexagon               randconfig-002-20250413    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250413    gcc-12
i386        buildonly-randconfig-002-20250413    clang-20
i386        buildonly-randconfig-003-20250413    gcc-12
i386        buildonly-randconfig-004-20250413    gcc-12
i386        buildonly-randconfig-005-20250413    clang-20
i386        buildonly-randconfig-006-20250413    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250413    gcc-14.2.0
loongarch             randconfig-002-20250413    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          rb532_defconfig    clang-18
mips                        vocore2_defconfig    clang-21
mips                           xway_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250413    gcc-9.3.0
nios2                 randconfig-002-20250413    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250413    gcc-10.5.0
parisc                randconfig-002-20250413    gcc-12.4.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                     mpc5200_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250413    clang-21
powerpc               randconfig-002-20250413    gcc-5.5.0
powerpc               randconfig-003-20250413    clang-17
powerpc64             randconfig-001-20250413    gcc-5.5.0
powerpc64             randconfig-002-20250413    gcc-10.5.0
powerpc64             randconfig-003-20250413    gcc-10.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250413    gcc-14.2.0
riscv                 randconfig-002-20250413    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250413    gcc-8.5.0
s390                  randconfig-002-20250413    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250413    gcc-11.5.0
sh                    randconfig-002-20250413    gcc-9.3.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                           se7751_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250413    gcc-6.5.0
sparc                 randconfig-002-20250413    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250413    gcc-14.2.0
sparc64               randconfig-002-20250413    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250413    gcc-11
um                    randconfig-002-20250413    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250413    clang-20
x86_64      buildonly-randconfig-002-20250413    gcc-12
x86_64      buildonly-randconfig-003-20250413    gcc-12
x86_64      buildonly-randconfig-004-20250413    gcc-12
x86_64      buildonly-randconfig-005-20250413    clang-20
x86_64      buildonly-randconfig-006-20250413    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250413    gcc-6.5.0
xtensa                randconfig-002-20250413    gcc-6.5.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

