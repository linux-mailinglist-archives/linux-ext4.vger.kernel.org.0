Return-Path: <linux-ext4+bounces-6947-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C4EA6C7FB
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 07:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37C2460A51
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 06:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DBC80604;
	Sat, 22 Mar 2025 06:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuokGe+7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52759AD2D
	for <linux-ext4@vger.kernel.org>; Sat, 22 Mar 2025 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742626317; cv=none; b=C8bLvm32K3KPzjCOl3JSgPy5+BYHQ6YJ+At+x1PuQzVpE8GPgRm6IozrTq2Y9TH8oLQ2uaDzIlCGqOrGZih7gIn4Z2uHIZmsn2qI+9D+BmLdipqgAQDV6ieRkDcA9pui70VJa3KxvQCOX7hXNB0UuQ35PqBFes4aV8nF2TNgSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742626317; c=relaxed/simple;
	bh=Qwjldl2pHwpOSupi0kzxDucPCVFiHHgL0qftXOgCo00=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oTokm6NgGm22QaHD2aUaRSQ193FI3A1Pr6icY67iiXD3lvaVM3wiCpyuSvcTfU8jWl2RcKxD7SxGedZvGrfPbpzTOt6woNwanw7gr3JNnwSr+kbgaTBU89gVRk2Lr5qi0F0wxT9K46iZPKR1VeuFnDqzCm0Va++RFoOC63EL+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuokGe+7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742626316; x=1774162316;
  h=date:from:to:cc:subject:message-id;
  bh=Qwjldl2pHwpOSupi0kzxDucPCVFiHHgL0qftXOgCo00=;
  b=iuokGe+79NwNFPo7Ps/vXwxjoIrJyQwpdcXx5JD5NuUxNbb5y1AjjmdQ
   qjDOdMEMqOCJdpVOFVVIsgSO5P1Ou6txJkSfWo8N3efExoPwxPuAuFRGV
   //vgTLcMDF/YRroZtpjU9GT6sYePc54inJel8Cc5g0jdlw3fnzee7uNou
   a78k3GljKGO+5Fgezk0e3sJEO8brzPLjEOWRT8ffEJ8F1eoD22E30WxDp
   IPG10i+tR0lqZnLrjLrgdwCcpwGb6LWCAtz8uHF47w1+DynPG1uaN/hvG
   JfLojtzHK8CKD6NN87JfDEP7+djUALdL5m/nv3MdSFA8fqe0mUV6AZqXD
   A==;
X-CSE-ConnectionGUID: gk7QsIkoTr2rLqvOmKU1GQ==
X-CSE-MsgGUID: vfhGjrVcQt+LVoWpusliNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="55277156"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="55277156"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 23:51:55 -0700
X-CSE-ConnectionGUID: YJY2EThFQBGl7uAHiUje4w==
X-CSE-MsgGUID: 71ivo26bR+SfJxgk/aYOWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="123540151"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 21 Mar 2025 23:51:54 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvshz-0001zv-2K;
	Sat, 22 Mar 2025 06:51:51 +0000
Date: Sat, 22 Mar 2025 14:51:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS
 d5e206778e96e8667d3bde695ad372c296dc9353
Message-ID: <202503221432.ajLybkGJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: d5e206778e96e8667d3bde695ad372c296dc9353  ext4: fix OOB read when checking dotdot dir

elapsed time: 1446m

configs tested: 113
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250321    gcc-13.3.0
arc                   randconfig-002-20250321    gcc-11.5.0
arc                           tb10x_defconfig    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250321    clang-19
arm                   randconfig-002-20250321    gcc-9.3.0
arm                   randconfig-003-20250321    gcc-5.5.0
arm                   randconfig-004-20250321    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250321    gcc-5.5.0
arm64                 randconfig-002-20250321    gcc-5.5.0
arm64                 randconfig-003-20250321    clang-20
arm64                 randconfig-004-20250321    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250321    gcc-13.3.0
csky                  randconfig-002-20250321    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250321    clang-21
hexagon               randconfig-002-20250321    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250321    clang-20
i386        buildonly-randconfig-002-20250321    clang-20
i386        buildonly-randconfig-003-20250321    clang-20
i386        buildonly-randconfig-004-20250321    clang-20
i386        buildonly-randconfig-005-20250321    clang-20
i386        buildonly-randconfig-006-20250321    clang-20
i386                                defconfig    clang-20
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250321    gcc-14.2.0
loongarch             randconfig-002-20250321    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250321    gcc-13.3.0
nios2                 randconfig-002-20250321    gcc-7.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250321    gcc-8.5.0
parisc                randconfig-002-20250321    gcc-6.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250321    clang-21
powerpc               randconfig-002-20250321    gcc-7.5.0
powerpc               randconfig-003-20250321    gcc-7.5.0
powerpc                     redwood_defconfig    clang-21
powerpc64             randconfig-001-20250321    gcc-5.5.0
powerpc64             randconfig-002-20250321    clang-16
powerpc64             randconfig-003-20250321    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250321    clang-21
riscv                 randconfig-002-20250321    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250321    clang-16
s390                  randconfig-002-20250321    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250321    gcc-7.5.0
sh                    randconfig-002-20250321    gcc-7.5.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250321    gcc-12.4.0
sparc                 randconfig-002-20250321    gcc-6.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250321    gcc-10.5.0
sparc64               randconfig-002-20250321    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250321    gcc-12
um                    randconfig-002-20250321    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250321    clang-20
x86_64      buildonly-randconfig-002-20250321    clang-20
x86_64      buildonly-randconfig-003-20250321    gcc-12
x86_64      buildonly-randconfig-004-20250321    clang-20
x86_64      buildonly-randconfig-005-20250321    clang-20
x86_64      buildonly-randconfig-006-20250321    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250321    gcc-6.5.0
xtensa                randconfig-002-20250321    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

