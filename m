Return-Path: <linux-ext4+bounces-6461-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 801B4A36F7F
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Feb 2025 17:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D6A16E5F8
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Feb 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806001A5BAF;
	Sat, 15 Feb 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuNArOiO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6702D529
	for <linux-ext4@vger.kernel.org>; Sat, 15 Feb 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739637611; cv=none; b=ZlhWYYRYPLLNvD34R2o/x2kC120nzYqB74Gd/R6bXn2pcTAmmcChNF+OahWteUVCbccF92yisqFsqjXhBGUKnkT8QroRodZTJxBrfLnEmk2Uu2EoJ4l8KcGkdGN0wHp8pwoe7m93TKB5++4v/Yh1oK8OPeR1PMFeDBK93AQMISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739637611; c=relaxed/simple;
	bh=LSk/nzEnuEtQ9KQ2LKqePtPDnDty5vh5Y1ntavZ114c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZHTFnPfirLsuL//Vc7MmenLgWs/QkGCKUk62PHa8qyxU4I+yEvyOpyQSXja2gWJbNrCpoq7BkfzqtosUmCFDe4C4dmTiNvm5f6fMj6rOj8RDcYZ/VjDu8gfSVvIlXgRXggOcxLOQ5xj7dRTEbNFZiIDpUEvYofKsyKta6RtfmL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuNArOiO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739637609; x=1771173609;
  h=date:from:to:cc:subject:message-id;
  bh=LSk/nzEnuEtQ9KQ2LKqePtPDnDty5vh5Y1ntavZ114c=;
  b=PuNArOiOnDDiYN8kZ/Tj6MTXFdku4QzUANt0BbY6PvTmlgypp1KalvSZ
   QFcKPKj7ChuiTfdh19GXgOkNJ5aVuYmnzOZyDZaKW70zvukMdxIx0tyib
   k9lpD6908J0f2TkyxIazlC/fELg4Od/yNQOfgpFxL/tzF6uhAmaXuMJ0D
   1v4BHvA4jK5UNX4593H2phrBUHlaMbXlzrNsyDEMwHDKzz7mNoKQqNqY3
   kPUfttA3MMZjVnMUFD2cT1ECp2GRoATFABHJL97PciiBwoWyxpQWQlQdW
   GdGuSiOuwKpQQUFRaHJ5qLwTRQLWnwpGFyJLLaPiYFba6xIp6ecDTBagq
   Q==;
X-CSE-ConnectionGUID: WcqzcSLnS7+eoPS3DXXhVA==
X-CSE-MsgGUID: b41kMIq6Sna87mQZnAKJFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40295585"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40295585"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 08:40:08 -0800
X-CSE-ConnectionGUID: yR5THfJYTR+iYEVx05iQew==
X-CSE-MsgGUID: D5MnssM/T5GpgRIeO+RIGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="113683272"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Feb 2025 08:40:06 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjLD2-001Azx-1V;
	Sat, 15 Feb 2025 16:40:04 +0000
Date: Sun, 16 Feb 2025 00:39:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 9e28059d56649a7212d5b3f8751ec021154ba3dd
Message-ID: <202502160013.zxYcnH4y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: 9e28059d56649a7212d5b3f8751ec021154ba3dd  ext4: introduce linear search for dentries

elapsed time: 1451m

configs tested: 77
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250215    gcc-13.2.0
arc                  randconfig-002-20250215    gcc-13.2.0
arm                  randconfig-001-20250215    clang-15
arm                  randconfig-002-20250215    clang-17
arm                  randconfig-003-20250215    gcc-14.2.0
arm                  randconfig-004-20250215    gcc-14.2.0
arm64                randconfig-001-20250215    clang-21
arm64                randconfig-002-20250215    gcc-14.2.0
arm64                randconfig-003-20250215    clang-17
arm64                randconfig-004-20250215    gcc-14.2.0
csky                 randconfig-001-20250215    gcc-14.2.0
csky                 randconfig-002-20250215    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250215    clang-21
hexagon              randconfig-002-20250215    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250215    gcc-12
i386       buildonly-randconfig-002-20250215    clang-19
i386       buildonly-randconfig-003-20250215    clang-19
i386       buildonly-randconfig-004-20250215    gcc-12
i386       buildonly-randconfig-005-20250215    clang-19
i386       buildonly-randconfig-006-20250215    clang-19
i386                               defconfig    clang-19
loongarch            randconfig-001-20250215    gcc-14.2.0
loongarch            randconfig-002-20250215    gcc-14.2.0
nios2                randconfig-001-20250215    gcc-14.2.0
nios2                randconfig-002-20250215    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250215    gcc-14.2.0
parisc               randconfig-002-20250215    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250215    gcc-14.2.0
powerpc              randconfig-002-20250215    clang-21
powerpc              randconfig-003-20250215    clang-19
powerpc64            randconfig-001-20250215    gcc-14.2.0
powerpc64            randconfig-002-20250215    clang-21
powerpc64            randconfig-003-20250215    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250215    clang-17
riscv                randconfig-002-20250215    clang-19
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-21
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250215    gcc-14.2.0
s390                 randconfig-002-20250215    gcc-14.2.0
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250215    gcc-14.2.0
sh                   randconfig-002-20250215    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250215    gcc-14.2.0
sparc                randconfig-002-20250215    gcc-14.2.0
sparc64              randconfig-001-20250215    gcc-14.2.0
sparc64              randconfig-002-20250215    gcc-14.2.0
um                              allmodconfig    clang-21
um                               allnoconfig    clang-18
um                              allyesconfig    gcc-12
um                   randconfig-001-20250215    clang-21
um                   randconfig-002-20250215    clang-19
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250215    gcc-12
x86_64     buildonly-randconfig-002-20250215    clang-19
x86_64     buildonly-randconfig-003-20250215    gcc-12
x86_64     buildonly-randconfig-004-20250215    clang-19
x86_64     buildonly-randconfig-005-20250215    clang-19
x86_64     buildonly-randconfig-006-20250215    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250215    gcc-14.2.0
xtensa               randconfig-002-20250215    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

