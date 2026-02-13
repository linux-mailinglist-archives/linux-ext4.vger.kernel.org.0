Return-Path: <linux-ext4+bounces-13694-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMtdJaoVj2lfIQEAu9opvQ
	(envelope-from <linux-ext4+bounces-13694-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Feb 2026 13:14:34 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D95135F94
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Feb 2026 13:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A08B30378A0
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Feb 2026 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA92735770A;
	Fri, 13 Feb 2026 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQdgDxJG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0B34A3A7
	for <linux-ext4@vger.kernel.org>; Fri, 13 Feb 2026 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984870; cv=none; b=V3cRRu/NapwEM3Zm6CUe/W2jiJNgLD9qOnqBr2EruTWbiC0wpl0HsIW1romu96lecRbpmaN5rsz0/RPTCHuLpIjUuLYfGRxtH0Xqr0GMj+BnTBKhCwja12B0kuC+7Qa+oEoyVkUjUbBWjN3V4bVTCbS1Kn6NaWTLO4p3NLr91S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984870; c=relaxed/simple;
	bh=G7DuvBBI94Xe/Rd1r5rRR0ho2KrlAL/v8yl2+Ssuork=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d0MK1qAggM2wzPky/2YBEN2M1Ewq1+x0aDCA5V2XOqh8vhHtGtrnwO7TS1XpICXLjv977bSX43lbY0QN+JA2DpfrsxU2YMjpB77o/ucyZRBzRsTsepOi+SCPCmKXd92yyzWvHbcuIQby9SV6h+VBfzEW0QRh00yMibuv64bxbkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQdgDxJG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770984869; x=1802520869;
  h=date:from:to:cc:subject:message-id;
  bh=G7DuvBBI94Xe/Rd1r5rRR0ho2KrlAL/v8yl2+Ssuork=;
  b=gQdgDxJGj+jFcdGMDCj6TTPcRQ4PTg8gu+Qm5cAhiFZ6SoCYg5DKoJh9
   KD5UksTlh74lLOr9b+BrdZ2ZwiVNhJSTxBT9R/bhLDrvPaevOenJ0nV7E
   ByUf3LEKycO6feixzL9QO9w36Ku/RvDLhP6prLYbLx8crUVM7yLAGaeyJ
   fQgfM7DZqUYthDFOSmZrqGIgqBrgFkh4jbqZVCepuq7ZkP8+IrTxfXNTQ
   Ntns8Y5bJRcg1/hJn9ZvVJ5ZWVLUOa3aycKZurhYV8kMLy21DXHnJsCrq
   TqKbK+Pj4ch6RaGCZmJ2nxu5WnWp7hAbAOxNMiTEmN3PQO6GWkDxMQlUw
   g==;
X-CSE-ConnectionGUID: W9bz2IDURtifaAfXzHpOhw==
X-CSE-MsgGUID: DPLfGQoVQgK8SclkPB+oGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83537575"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="83537575"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 04:14:29 -0800
X-CSE-ConnectionGUID: k0RmPgsETrmDeAIRoo/qbQ==
X-CSE-MsgGUID: INdSoZpCRfq1wc+W9DNWbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="250569950"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Feb 2026 04:14:27 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqs40-00000000vMD-2vWp;
	Fri, 13 Feb 2026 12:14:24 +0000
Date: Fri, 13 Feb 2026 20:13:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test] BUILD SUCCESS
 062bc05db705fb36c63862c1fc5fee79260beb12
Message-ID: <202602132041.QVRtC6cb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-13694-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: E6D95135F94
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
branch HEAD: 062bc05db705fb36c63862c1fc5fee79260beb12  Merge branch 'dev' into test

elapsed time: 1229m

configs tested: 219
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260213    clang-22
arc                   randconfig-002-20260213    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         axm55xx_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    gcc-15.2.0
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20260213    clang-22
arm                   randconfig-002-20260213    clang-22
arm                   randconfig-003-20260213    clang-22
arm                   randconfig-004-20260213    clang-22
arm                         s3c6400_defconfig    clang-22
arm                         socfpga_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    clang-22
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260213    clang-20
arm64                 randconfig-002-20260213    clang-20
arm64                 randconfig-003-20260213    clang-20
arm64                 randconfig-004-20260213    clang-20
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260213    clang-20
csky                  randconfig-002-20260213    clang-20
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260213    clang-20
i386        buildonly-randconfig-002-20260213    clang-20
i386        buildonly-randconfig-003-20260213    clang-20
i386        buildonly-randconfig-004-20260213    clang-20
i386        buildonly-randconfig-005-20260213    clang-20
i386        buildonly-randconfig-006-20260213    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260213    gcc-14
i386                  randconfig-002-20260213    gcc-14
i386                  randconfig-003-20260213    gcc-14
i386                  randconfig-004-20260213    gcc-14
i386                  randconfig-005-20260213    gcc-14
i386                  randconfig-006-20260213    gcc-14
i386                  randconfig-007-20260213    gcc-14
i386                  randconfig-011-20260213    gcc-14
i386                  randconfig-012-20260213    gcc-14
i386                  randconfig-013-20260213    gcc-14
i386                  randconfig-014-20260213    gcc-14
i386                  randconfig-015-20260213    gcc-14
i386                  randconfig-016-20260213    gcc-14
i386                  randconfig-017-20260213    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                            mac_defconfig    gcc-15.2.0
m68k                        stmark2_defconfig    gcc-15.2.0
m68k                          sun3x_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    clang-22
mips                 decstation_r4k_defconfig    gcc-15.2.0
mips                     loongson2k_defconfig    gcc-15.2.0
mips                          malta_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260213    clang-20
parisc                randconfig-002-20260213    clang-20
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      chrp32_defconfig    clang-22
powerpc                       holly_defconfig    clang-22
powerpc                       holly_defconfig    gcc-15.2.0
powerpc                      pcm030_defconfig    gcc-15.2.0
powerpc                     rainier_defconfig    clang-22
powerpc               randconfig-001-20260213    clang-20
powerpc               randconfig-002-20260213    clang-20
powerpc                     taishan_defconfig    clang-22
powerpc                        warp_defconfig    gcc-15.2.0
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20260213    clang-20
powerpc64             randconfig-002-20260213    clang-20
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260213    gcc-11.5.0
riscv                 randconfig-002-20260213    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260213    gcc-11.5.0
s390                  randconfig-002-20260213    gcc-11.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         ap325rxa_defconfig    clang-22
sh                        apsh4ad0a_defconfig    clang-22
sh                                  defconfig    gcc-14
sh                               j2_defconfig    clang-22
sh                    randconfig-001-20260213    gcc-11.5.0
sh                    randconfig-002-20260213    gcc-11.5.0
sh                           se7750_defconfig    clang-22
sh                           se7750_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260213    gcc-12.5.0
sparc                 randconfig-002-20260213    gcc-12.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260213    gcc-12.5.0
sparc64               randconfig-002-20260213    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260213    gcc-12.5.0
um                    randconfig-002-20260213    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260213    gcc-14
x86_64      buildonly-randconfig-002-20260213    gcc-14
x86_64      buildonly-randconfig-003-20260213    gcc-14
x86_64      buildonly-randconfig-004-20260213    gcc-14
x86_64      buildonly-randconfig-005-20260213    gcc-14
x86_64      buildonly-randconfig-006-20260213    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260213    gcc-14
x86_64                randconfig-002-20260213    gcc-14
x86_64                randconfig-003-20260213    gcc-14
x86_64                randconfig-004-20260213    gcc-14
x86_64                randconfig-005-20260213    gcc-14
x86_64                randconfig-006-20260213    gcc-14
x86_64                randconfig-011-20260213    gcc-12
x86_64                randconfig-012-20260213    gcc-12
x86_64                randconfig-013-20260213    gcc-12
x86_64                randconfig-014-20260213    gcc-12
x86_64                randconfig-015-20260213    gcc-12
x86_64                randconfig-016-20260213    gcc-12
x86_64                randconfig-071-20260213    clang-20
x86_64                randconfig-072-20260213    clang-20
x86_64                randconfig-073-20260213    clang-20
x86_64                randconfig-074-20260213    clang-20
x86_64                randconfig-075-20260213    clang-20
x86_64                randconfig-076-20260213    clang-20
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
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260213    gcc-12.5.0
xtensa                randconfig-002-20260213    gcc-12.5.0
xtensa                         virt_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

