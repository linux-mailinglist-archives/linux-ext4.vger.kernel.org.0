Return-Path: <linux-ext4+bounces-13294-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fxZlDCNadWmSEQEAu9opvQ
	(envelope-from <linux-ext4+bounces-13294-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Jan 2026 00:47:47 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 868207F4A2
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Jan 2026 00:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 166BB300C59F
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 23:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7BB19CD06;
	Sat, 24 Jan 2026 23:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmKGQQEy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EDF1A275
	for <linux-ext4@vger.kernel.org>; Sat, 24 Jan 2026 23:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769298463; cv=none; b=nu8ziA1dbzR1ww8Q1Qqb+PQgKLxW4WuGX1eQUHyWuzB1Yv2RA4Zf0qewK3r36kWLiv8Ze0X8H1BPFoYI2DtsKqgBAGS8SG5QlE/ygmNkq8NUJ+zOXwEmm0Bn8R1iazOiM4fW8rzBcxarRAuP7xeTvjuEBjYPgh1t2tzgHFCeIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769298463; c=relaxed/simple;
	bh=x/JmJSJnLU21eAoyLkkhgbxqI0JSfb3Thu7oqsDvrE4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K9TRMxHXFGcKXd94g+7Wj35TWMiLaUr4Kx5a3HIclPTfKW2q6xwUuomGz8BBtFFvAD2Ax3SSdFKHu47j4y0U1Cry04Z6tmAEUP/OUHvTj0Lva8UiKOZSpca32jQ1e0DWOiWmZEE90/68O2si4m21L+fW+svYNGDkXJkJlRxLBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmKGQQEy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769298461; x=1800834461;
  h=date:from:to:cc:subject:message-id;
  bh=x/JmJSJnLU21eAoyLkkhgbxqI0JSfb3Thu7oqsDvrE4=;
  b=fmKGQQEy8sEAlVlsrf6TIoMtc3JaEG4bjFaR85oIZ1BhKfiA7Zz4Mc37
   O2eEwcDbSTORznkJpYVCSHoulwj/d0o4apCHrUtYcOYp7Qbbe2b8K+Nyt
   0O4PQD/AZFQmUhPs6TcQfxfZ5hBLttF4dHC3Fh2ncRiR/e+HTK8oFYgE8
   wOZ9rJgQDvAeEopqNPdXNsWzlIfxeUhLBlsxdV9gbyTsr16y+BvmRwX3d
   kr0l+xpWnHbHoDxRXGdqdC0yUEuNsoLA6v3qpOGPeyGH0aUZHXpdtt7gU
   rZKaBNkwwbeUszHNIdz16zy7EsvjQfyRfjliiTG7E9M4VLN/Y9JBhAiAx
   Q==;
X-CSE-ConnectionGUID: 37qftrAERfOoUmZyfiOMBA==
X-CSE-MsgGUID: elSh6KCyTgC/SuHPUODC+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="69705755"
X-IronPort-AV: E=Sophos;i="6.21,251,1763452800"; 
   d="scan'208";a="69705755"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 15:47:41 -0800
X-CSE-ConnectionGUID: lKqr6jSWRIeCePV0i8JWYg==
X-CSE-MsgGUID: NbtSKac+SRWUkEqh9WaEBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,251,1763452800"; 
   d="scan'208";a="207237486"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 24 Jan 2026 15:47:39 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjnLt-00000000VcQ-16Bz;
	Sat, 24 Jan 2026 23:47:37 +0000
Date: Sun, 25 Jan 2026 07:47:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 6740d5ebba535938a3e0b46dff0053b63b1de95f
Message-ID: <202601250758.zVjWYsAR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13294-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 868207F4A2
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 6740d5ebba535938a3e0b46dff0053b63b1de95f  Merge branch 'dev' into test

elapsed time: 1304m

configs tested: 274
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    clang-22
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                        nsim_700_defconfig    gcc-15.2.0
arc                   randconfig-001-20260124    clang-18
arc                   randconfig-002-20260124    clang-18
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         at91_dt_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                        keystone_defconfig    clang-22
arm                         lpc18xx_defconfig    clang-22
arm                           omap1_defconfig    clang-22
arm                          pxa168_defconfig    clang-22
arm                   randconfig-001-20260124    clang-18
arm                   randconfig-002-20260124    clang-18
arm                   randconfig-003-20260124    clang-18
arm                   randconfig-004-20260124    clang-18
arm                         s3c6400_defconfig    gcc-15.2.0
arm                        vexpress_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    clang-22
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260124    gcc-15.2.0
arm64                 randconfig-001-20260125    gcc-11.5.0
arm64                 randconfig-002-20260124    gcc-15.2.0
arm64                 randconfig-002-20260125    gcc-11.5.0
arm64                 randconfig-003-20260124    gcc-15.2.0
arm64                 randconfig-003-20260125    gcc-11.5.0
arm64                 randconfig-004-20260124    gcc-15.2.0
arm64                 randconfig-004-20260125    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260124    gcc-15.2.0
csky                  randconfig-001-20260125    gcc-11.5.0
csky                  randconfig-002-20260124    gcc-15.2.0
csky                  randconfig-002-20260125    gcc-11.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260124    gcc-15.2.0
hexagon               randconfig-002-20260124    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260124    gcc-14
i386        buildonly-randconfig-001-20260125    gcc-14
i386        buildonly-randconfig-002-20260124    gcc-14
i386        buildonly-randconfig-002-20260125    gcc-14
i386        buildonly-randconfig-003-20260124    gcc-14
i386        buildonly-randconfig-003-20260125    gcc-14
i386        buildonly-randconfig-004-20260124    gcc-14
i386        buildonly-randconfig-004-20260125    gcc-14
i386        buildonly-randconfig-005-20260124    gcc-14
i386        buildonly-randconfig-005-20260125    gcc-14
i386        buildonly-randconfig-006-20260124    gcc-14
i386        buildonly-randconfig-006-20260125    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260124    gcc-14
i386                  randconfig-002-20260124    gcc-14
i386                  randconfig-003-20260124    gcc-14
i386                  randconfig-004-20260124    gcc-14
i386                  randconfig-005-20260124    gcc-14
i386                  randconfig-006-20260124    gcc-14
i386                  randconfig-007-20260124    gcc-14
i386                  randconfig-011-20260124    clang-20
i386                  randconfig-011-20260125    gcc-14
i386                  randconfig-012-20260124    clang-20
i386                  randconfig-012-20260125    gcc-14
i386                  randconfig-013-20260124    clang-20
i386                  randconfig-013-20260125    gcc-14
i386                  randconfig-014-20260124    clang-20
i386                  randconfig-014-20260125    gcc-14
i386                  randconfig-015-20260124    clang-20
i386                  randconfig-015-20260125    gcc-14
i386                  randconfig-016-20260124    clang-20
i386                  randconfig-016-20260125    gcc-14
i386                  randconfig-017-20260124    clang-20
i386                  randconfig-017-20260125    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    gcc-15.2.0
loongarch             randconfig-001-20260124    gcc-15.2.0
loongarch             randconfig-002-20260124    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ci20_defconfig    clang-22
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                           gcw0_defconfig    clang-22
mips                      pic32mzda_defconfig    clang-22
mips                       rbtx49xx_defconfig    clang-22
mips                           rs90_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
mips                           xway_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260124    gcc-15.2.0
nios2                 randconfig-002-20260124    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260124    gcc-8.5.0
parisc                randconfig-001-20260125    gcc-8.5.0
parisc                randconfig-002-20260124    gcc-8.5.0
parisc                randconfig-002-20260125    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        cell_defconfig    clang-22
powerpc                      cm5200_defconfig    clang-22
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                     mpc5200_defconfig    clang-22
powerpc                 mpc8313_rdb_defconfig    clang-22
powerpc                 mpc8315_rdb_defconfig    clang-22
powerpc                 mpc837x_rdb_defconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20260124    gcc-8.5.0
powerpc               randconfig-001-20260125    gcc-8.5.0
powerpc               randconfig-002-20260124    gcc-8.5.0
powerpc               randconfig-002-20260125    gcc-8.5.0
powerpc                     taishan_defconfig    clang-22
powerpc64             randconfig-001-20260124    gcc-8.5.0
powerpc64             randconfig-001-20260125    gcc-8.5.0
powerpc64             randconfig-002-20260124    gcc-8.5.0
powerpc64             randconfig-002-20260125    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260124    gcc-8.5.0
riscv                 randconfig-001-20260125    clang-22
riscv                 randconfig-002-20260124    gcc-8.5.0
riscv                 randconfig-002-20260125    clang-22
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260124    gcc-8.5.0
s390                  randconfig-001-20260125    clang-22
s390                  randconfig-002-20260124    gcc-8.5.0
s390                  randconfig-002-20260125    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                         apsh4a3a_defconfig    clang-22
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260124    gcc-8.5.0
sh                    randconfig-001-20260125    clang-22
sh                    randconfig-002-20260124    gcc-8.5.0
sh                    randconfig-002-20260125    clang-22
sh                           se7751_defconfig    clang-22
sh                   sh7724_generic_defconfig    clang-22
sh                              ul2_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260124    gcc-13.4.0
sparc                 randconfig-002-20260124    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260124    gcc-13.4.0
sparc64               randconfig-002-20260124    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260124    gcc-13.4.0
um                    randconfig-002-20260124    gcc-13.4.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260124    clang-20
x86_64      buildonly-randconfig-001-20260125    clang-20
x86_64      buildonly-randconfig-002-20260124    clang-20
x86_64      buildonly-randconfig-002-20260125    clang-20
x86_64      buildonly-randconfig-003-20260124    clang-20
x86_64      buildonly-randconfig-003-20260125    clang-20
x86_64      buildonly-randconfig-004-20260124    clang-20
x86_64      buildonly-randconfig-004-20260125    clang-20
x86_64      buildonly-randconfig-005-20260124    clang-20
x86_64      buildonly-randconfig-005-20260125    clang-20
x86_64      buildonly-randconfig-006-20260124    clang-20
x86_64      buildonly-randconfig-006-20260125    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260124    gcc-13
x86_64                randconfig-001-20260125    gcc-14
x86_64                randconfig-002-20260124    gcc-13
x86_64                randconfig-002-20260125    gcc-14
x86_64                randconfig-003-20260124    gcc-13
x86_64                randconfig-003-20260125    gcc-14
x86_64                randconfig-004-20260124    gcc-13
x86_64                randconfig-004-20260125    gcc-14
x86_64                randconfig-005-20260124    gcc-13
x86_64                randconfig-005-20260125    gcc-14
x86_64                randconfig-006-20260124    gcc-13
x86_64                randconfig-006-20260125    gcc-14
x86_64                randconfig-011-20260124    gcc-12
x86_64                randconfig-012-20260124    gcc-12
x86_64                randconfig-013-20260124    gcc-12
x86_64                randconfig-014-20260124    gcc-12
x86_64                randconfig-015-20260124    gcc-12
x86_64                randconfig-016-20260124    gcc-12
x86_64                randconfig-071-20260124    gcc-14
x86_64                randconfig-071-20260125    clang-20
x86_64                randconfig-072-20260124    gcc-14
x86_64                randconfig-072-20260125    clang-20
x86_64                randconfig-073-20260124    gcc-14
x86_64                randconfig-073-20260125    clang-20
x86_64                randconfig-074-20260124    gcc-14
x86_64                randconfig-074-20260125    clang-20
x86_64                randconfig-075-20260124    gcc-14
x86_64                randconfig-075-20260125    clang-20
x86_64                randconfig-076-20260124    gcc-14
x86_64                randconfig-076-20260125    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260124    gcc-13.4.0
xtensa                randconfig-002-20260124    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

