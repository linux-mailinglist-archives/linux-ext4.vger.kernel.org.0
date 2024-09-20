Return-Path: <linux-ext4+bounces-4236-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C3B97D675
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2024 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AD11F26614
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2024 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A924917839C;
	Fri, 20 Sep 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Duodx4pq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B213B2B0
	for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726840138; cv=none; b=cnSVzV5riaomBCPyBRWiuqFh2LOkAsyjUGUnvrYTfkCHmf1OYG1J59W5M8wzAmgguLDLaNEgAlWavgveCIjkkLlZt060vHGjxqOEKax5rg/uyexdhd1NVZTnPBkBLtRUhPwUF1WcBM7cOaMdLortpREAh43As3zvZKsd116TJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726840138; c=relaxed/simple;
	bh=LX4LvFiew3B+aiQ45Kvro0oAGMj5GuYp7c7uNwVsf6g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GJC+/X9lZjC+R749uIlam9O/fDm66bc602Hj+4b60rGfv1bqreoMGAj0Av892j/NLDgCXQi/QrNS3gaHVwVgZ8NM9K5sIEc4mQ8extXtral3INx85Wr+IlmjwZDd8aVAGaFRFvmtXXN2aWVPbFUF0l8jyTvRjhtbMDfc8gXc4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Duodx4pq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726840136; x=1758376136;
  h=date:from:to:cc:subject:message-id;
  bh=LX4LvFiew3B+aiQ45Kvro0oAGMj5GuYp7c7uNwVsf6g=;
  b=Duodx4pqt/+tRuUZpJDLxH3JJpppqfwEoJF1U3+wJ01syUKEHScOrup9
   /FvNUiITauW6CVuNAqE6Xlk7DyTcVsF4oo5Ys6hZMZx9cxjLWyEmIPk8K
   wE/x40fhVJcEkLa0zmMsJ2QvXShu8obL/oBuzobNKygFyKcaDLYsSOSZE
   sMD5txvzYl5FhS2oCaEMYyxgBwc4Oi4oBWknI/neUEooyhGCRv6RcfS8J
   4Rj3o8VL7f4oIJQOnqldYw7tCIMaVksyivZZjo3My2bo9FTNWdrMLaGFS
   yJ1bZCoVmOWLgmpl+/dsUdAekM8xiQKv0/sQ+tKUR5x+2pNWdNzfdlUsE
   Q==;
X-CSE-ConnectionGUID: LTkphMfOS6a/yoJWaq57/A==
X-CSE-MsgGUID: EgBqIZFNQbaJFWKnJSI/FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="43365886"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="43365886"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 06:48:55 -0700
X-CSE-ConnectionGUID: ZzVPPJPSQKKfVDR0OcbCOw==
X-CSE-MsgGUID: IhKb9ssBRpOYiMvVRBXMkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70176587"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Sep 2024 06:48:54 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sre0B-000EVB-1v;
	Fri, 20 Sep 2024 13:48:51 +0000
Date: Fri, 20 Sep 2024 21:48:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 206ea5df8d5287325a2e20b1f0f1bbda2e53ade0
Message-ID: <202409202103.pR7cTi61-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 206ea5df8d5287325a2e20b1f0f1bbda2e53ade0  Merge branch 'dev' into test

elapsed time: 1634m

configs tested: 139
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                        nsimosci_defconfig    gcc-14.1.0
arc                   randconfig-001-20240920    clang-20
arc                   randconfig-002-20240920    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                       imx_v6_v7_defconfig    gcc-14.1.0
arm                       multi_v4t_defconfig    gcc-14.1.0
arm                   randconfig-001-20240920    clang-20
arm                   randconfig-002-20240920    clang-20
arm                   randconfig-003-20240920    clang-20
arm                   randconfig-004-20240920    clang-20
arm                             rpc_defconfig    gcc-14.1.0
arm                           sama7_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240920    clang-20
arm64                 randconfig-002-20240920    clang-20
arm64                 randconfig-003-20240920    clang-20
arm64                 randconfig-004-20240920    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240920    clang-20
csky                  randconfig-002-20240920    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240920    clang-20
hexagon               randconfig-002-20240920    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20240920    gcc-12
i386        buildonly-randconfig-002-20240920    gcc-12
i386        buildonly-randconfig-003-20240920    gcc-12
i386        buildonly-randconfig-004-20240920    gcc-12
i386        buildonly-randconfig-005-20240920    gcc-12
i386        buildonly-randconfig-006-20240920    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240920    gcc-12
i386                  randconfig-002-20240920    gcc-12
i386                  randconfig-003-20240920    gcc-12
i386                  randconfig-004-20240920    gcc-12
i386                  randconfig-005-20240920    gcc-12
i386                  randconfig-006-20240920    gcc-12
i386                  randconfig-011-20240920    gcc-12
i386                  randconfig-012-20240920    gcc-12
i386                  randconfig-013-20240920    gcc-12
i386                  randconfig-014-20240920    gcc-12
i386                  randconfig-015-20240920    gcc-12
i386                  randconfig-016-20240920    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240920    clang-20
loongarch             randconfig-002-20240920    clang-20
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                  cavium_octeon_defconfig    gcc-14.1.0
mips                           ci20_defconfig    gcc-14.1.0
mips                           ip27_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240920    clang-20
nios2                 randconfig-002-20240920    clang-20
openrisc                          allnoconfig    clang-20
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-20
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    gcc-14.1.0
parisc                randconfig-001-20240920    clang-20
parisc                randconfig-002-20240920    clang-20
parisc64                            defconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc               randconfig-002-20240920    clang-20
powerpc64             randconfig-001-20240920    clang-20
powerpc64             randconfig-002-20240920    clang-20
powerpc64             randconfig-003-20240920    clang-20
riscv                             allnoconfig    clang-20
riscv                               defconfig    gcc-12
riscv                               defconfig    gcc-14.1.0
riscv                 randconfig-001-20240920    clang-20
riscv                 randconfig-002-20240920    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240920    clang-20
s390                  randconfig-002-20240920    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20240920    clang-20
sh                    randconfig-002-20240920    clang-20
sh                   rts7751r2dplus_defconfig    gcc-14.1.0
sh                          sdk7780_defconfig    gcc-14.1.0
sh                             sh03_defconfig    gcc-14.1.0
sh                        sh7763rdp_defconfig    gcc-14.1.0
sh                             shx3_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240920    clang-20
sparc64               randconfig-002-20240920    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240920    clang-20
um                    randconfig-002-20240920    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240920    clang-20
xtensa                randconfig-002-20240920    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

