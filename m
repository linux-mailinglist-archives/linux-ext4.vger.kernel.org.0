Return-Path: <linux-ext4+bounces-13047-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C376D3B41F
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 18:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A61E30DF919
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3743C2F1FED;
	Mon, 19 Jan 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Utgycw27"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA299205E26
	for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841462; cv=none; b=a/fIspPoufChaxyPV4h+zxT8czYwYnYo4hr6ovCKVNy6yTlxJw1abnZ1jxVci2lbJAYO5RXh5JYNgu7PYNNEsJdKk45qYL+e/rzwrb7OTaX5aWzD9tJq8dQdEdvy88GImeIWcBfB191Vk156McFXlZOo+y7rU28xiayphJ54tHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841462; c=relaxed/simple;
	bh=qU0P4ncqQeL/agBlTBbgqN5hodZyocLFZJCoDt3CoBg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Hcaip1fpQWQBTW+8fvbwWVPhzViFoYVgLDRG0rt/GEbKvbPW0gkTvCUjKuC1/H55/95BKiVA8JJRUAMJ2cgFvymrM3p+d6/iXVBGp6QIyNOiUzziozZyGSPD6he+z3NZSJ72MVBzWbpj2aPBtg36MZySyHgc5EltTrrtWXXM25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Utgycw27; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768841460; x=1800377460;
  h=date:from:to:cc:subject:message-id;
  bh=qU0P4ncqQeL/agBlTBbgqN5hodZyocLFZJCoDt3CoBg=;
  b=Utgycw27lNGXKXp/SFqgJkdzplJSFhA6x+NJGa/12giHqwkcTqAlWqKm
   rkJNYTHmnmGCESTJBokVQ9ZkInoI9iIcn9OPrsW+3wn1hxbttHlpqI0iB
   4ANkxd/Hx3WltHf14MXljcncRKKiKsbklv7EP5sxvsgY4+kyVlj5HEzZz
   9thAoFKBvnZu4q6KcEUH6XiJp8n4PjZHK3IsSsMx3AtXqtaBY+685tpmR
   sYqam8DUBYc/MvrYKpUcTpN/CMsNjd4jZFmOAZqANbsXO4Z/nW5QcuN6f
   WCX97YH/uLhz/8kbDWqIp9M3YCI0eGqfMAXDbY3zf+X/H+60ONyPpXX89
   w==;
X-CSE-ConnectionGUID: nQuvt++YRBKjdgjO749xXA==
X-CSE-MsgGUID: We2bqueqSZOkGCywsza4Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69786751"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="69786751"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 08:50:59 -0800
X-CSE-ConnectionGUID: +8yWSrVpRnS02X2/Ff3QcA==
X-CSE-MsgGUID: rWD3SFN8T8agtfL8kTRGvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="210755700"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 19 Jan 2026 08:50:57 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhsSt-00000000O4j-2NhN;
	Mon, 19 Jan 2026 16:50:55 +0000
Date: Tue, 20 Jan 2026 00:50:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: [tytso-ext4:dev] BUILD SUCCESS WITH WARNING
 a4ffc45fdcdc4e94a8acf7dd3342cf1d1a2cdabf
Message-ID: <202601200044.jIdYijxk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
branch HEAD: a4ffc45fdcdc4e94a8acf7dd3342cf1d1a2cdabf  ext4: mark group extend fast-commit ineligible

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202601190552.ZJeAkmLt-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202601190600.xYVh1uKf-lkp@intel.com
    https://lore.kernel.org/oe-kbuild/202601192148.Lwa0CTlR-lkp@intel.com

    fs/ext4/extents-test.c:323:19: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
    fs/ext4/extents-test.c:324:5: warning: format specifies type 'long' but the argument has type '__ptrdiff_t' (aka 'int') [-Wformat]

Unverified Warning (likely false positive, kindly check if interested):

    fs/ext4/extents-test.c:518:1: sparse: sparse: bad integer constant expression
    fs/ext4/extents-test.c:894:1: sparse: sparse: bad integer constant expression

Warning ids grouped by kconfigs:

recent_errors
|-- i386-allyesconfig
|   `-- fs-ext4-extents-test.c:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-int
|-- microblaze-randconfig-r123-20260119
|   `-- fs-ext4-extents-test.c:sparse:sparse:bad-integer-constant-expression
|-- openrisc-randconfig-r113-20260119
|   `-- fs-ext4-extents-test.c:sparse:sparse:bad-integer-constant-expression
|-- openrisc-randconfig-r121-20260119
|   `-- fs-ext4-extents-test.c:sparse:sparse:bad-integer-constant-expression
|-- powerpc-randconfig-002-20260119
|   `-- fs-ext4-extents-test.c:warning:format-specifies-type-long-but-the-argument-has-type-__ptrdiff_t-(aka-int-)
`-- s390-randconfig-r132-20260119
    `-- fs-ext4-extents-test.c:sparse:sparse:bad-integer-constant-expression

elapsed time: 727m

configs tested: 244
configs skipped: 2

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260119    gcc-11.5.0
arc                   randconfig-001-20260119    gcc-14.3.0
arc                   randconfig-002-20260119    gcc-14.3.0
arc                   randconfig-002-20260119    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                     am200epdkit_defconfig    gcc-14
arm                       aspeed_g5_defconfig    gcc-15.2.0
arm                         bcm2835_defconfig    clang-16
arm                         bcm2835_defconfig    gcc-15.2.0
arm                        clps711x_defconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    gcc-15.2.0
arm                          gemini_defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                      jornada720_defconfig    clang-22
arm                            mps2_defconfig    gcc-15.2.0
arm                        multi_v5_defconfig    clang-22
arm                           omap1_defconfig    gcc-14
arm                   randconfig-001-20260119    clang-22
arm                   randconfig-001-20260119    gcc-14.3.0
arm                   randconfig-002-20260119    clang-22
arm                   randconfig-002-20260119    gcc-14.3.0
arm                   randconfig-003-20260119    clang-22
arm                   randconfig-003-20260119    gcc-14.3.0
arm                   randconfig-004-20260119    gcc-14.3.0
arm                             rpc_defconfig    clang-22
arm                           sama5_defconfig    gcc-15.2.0
arm                          sp7021_defconfig    clang-16
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           tegra_defconfig    gcc-15.2.0
arm                           u8500_defconfig    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260119    clang-19
arm64                 randconfig-002-20260119    clang-19
arm64                 randconfig-003-20260119    clang-19
arm64                 randconfig-004-20260119    clang-19
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    clang-22
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260119    clang-19
csky                  randconfig-002-20260119    clang-19
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260119    clang-18
hexagon               randconfig-002-20260119    clang-18
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260119    clang-20
i386        buildonly-randconfig-002-20260119    clang-20
i386        buildonly-randconfig-003-20260119    clang-20
i386        buildonly-randconfig-004-20260119    clang-20
i386        buildonly-randconfig-005-20260119    clang-20
i386        buildonly-randconfig-006-20260119    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260119    gcc-13
i386                  randconfig-002-20260119    gcc-13
i386                  randconfig-003-20260119    gcc-13
i386                  randconfig-004-20260119    gcc-13
i386                  randconfig-005-20260119    gcc-13
i386                  randconfig-006-20260119    gcc-13
i386                  randconfig-007-20260119    gcc-13
i386                  randconfig-011-20260119    gcc-14
i386                  randconfig-012-20260119    gcc-14
i386                  randconfig-013-20260119    gcc-14
i386                  randconfig-014-20260119    gcc-14
i386                  randconfig-015-20260119    gcc-14
i386                  randconfig-016-20260119    gcc-14
i386                  randconfig-017-20260119    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson64_defconfig    clang-16
loongarch             randconfig-001-20260119    clang-18
loongarch             randconfig-002-20260119    clang-18
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                          multi_defconfig    clang-22
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                           ip22_defconfig    clang-16
mips                       lemote2f_defconfig    clang-16
mips                  maltasmvp_eva_defconfig    gcc-15.2.0
mips                          rb532_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260119    clang-18
nios2                 randconfig-002-20260119    clang-18
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260119    clang-22
parisc                randconfig-001-20260119    gcc-12.5.0
parisc                randconfig-002-20260119    clang-22
parisc                randconfig-002-20260119    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                       eiger_defconfig    clang-16
powerpc                      ep88xc_defconfig    gcc-15.2.0
powerpc                  iss476-smp_defconfig    clang-22
powerpc                   microwatt_defconfig    gcc-15.2.0
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                  mpc885_ads_defconfig    clang-22
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc                      pasemi_defconfig    clang-22
powerpc                      ppc6xx_defconfig    gcc-14
powerpc                     rainier_defconfig    clang-22
powerpc               randconfig-001-20260119    clang-22
powerpc               randconfig-001-20260119    gcc-15.2.0
powerpc               randconfig-002-20260119    clang-22
powerpc                    sam440ep_defconfig    gcc-14
powerpc                  storcenter_defconfig    clang-16
powerpc64             randconfig-001-20260119    clang-22
powerpc64             randconfig-002-20260119    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260119    gcc-15.2.0
riscv                 randconfig-002-20260119    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-14
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260119    gcc-15.2.0
s390                  randconfig-002-20260119    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                            migor_defconfig    gcc-15.2.0
sh                    randconfig-001-20260119    gcc-15.2.0
sh                    randconfig-002-20260119    gcc-15.2.0
sh                           se7712_defconfig    gcc-15.2.0
sh                           se7724_defconfig    gcc-14
sh                        sh7763rdp_defconfig    gcc-15.2.0
sh                   sh7770_generic_defconfig    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260119    gcc-11.5.0
sparc                 randconfig-001-20260119    gcc-14.3.0
sparc                 randconfig-002-20260119    gcc-14.3.0
sparc                 randconfig-002-20260119    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260119    gcc-14.3.0
sparc64               randconfig-002-20260119    clang-20
sparc64               randconfig-002-20260119    gcc-14.3.0
um                               alldefconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260119    clang-17
um                    randconfig-001-20260119    gcc-14.3.0
um                    randconfig-002-20260119    gcc-14
um                    randconfig-002-20260119    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260119    gcc-14
x86_64      buildonly-randconfig-002-20260119    gcc-14
x86_64      buildonly-randconfig-003-20260119    gcc-14
x86_64      buildonly-randconfig-004-20260119    gcc-14
x86_64      buildonly-randconfig-005-20260119    gcc-14
x86_64      buildonly-randconfig-006-20260119    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260119    gcc-14
x86_64                randconfig-002-20260119    clang-20
x86_64                randconfig-002-20260119    gcc-14
x86_64                randconfig-003-20260119    gcc-14
x86_64                randconfig-004-20260119    gcc-12
x86_64                randconfig-004-20260119    gcc-14
x86_64                randconfig-005-20260119    gcc-12
x86_64                randconfig-005-20260119    gcc-14
x86_64                randconfig-006-20260119    clang-20
x86_64                randconfig-006-20260119    gcc-14
x86_64                randconfig-011-20260119    clang-20
x86_64                randconfig-012-20260119    clang-20
x86_64                randconfig-012-20260119    gcc-14
x86_64                randconfig-013-20260119    clang-20
x86_64                randconfig-013-20260119    gcc-14
x86_64                randconfig-014-20260119    clang-20
x86_64                randconfig-015-20260119    clang-20
x86_64                randconfig-015-20260119    gcc-14
x86_64                randconfig-016-20260119    clang-20
x86_64                randconfig-071-20260119    clang-20
x86_64                randconfig-072-20260119    clang-20
x86_64                randconfig-073-20260119    clang-20
x86_64                randconfig-074-20260119    clang-20
x86_64                randconfig-075-20260119    clang-20
x86_64                randconfig-076-20260119    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                  audio_kc705_defconfig    clang-22
xtensa                randconfig-001-20260119    gcc-12.5.0
xtensa                randconfig-001-20260119    gcc-14.3.0
xtensa                randconfig-002-20260119    gcc-12.5.0
xtensa                randconfig-002-20260119    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

