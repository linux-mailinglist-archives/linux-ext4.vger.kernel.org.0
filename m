Return-Path: <linux-ext4+bounces-10882-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FCCBDC56E
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 05:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6261925D25
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 03:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73F29B79A;
	Wed, 15 Oct 2025 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LJv22Fqd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0930218AA0
	for <linux-ext4@vger.kernel.org>; Wed, 15 Oct 2025 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760498897; cv=none; b=pA5L4NQj4mR6B+A2Qpn1rcpcsniMBiNaC4cQRAygyN1L/0xeylBaWe/MlfvKeQ1qswqEPUUgEdbWXYRCZrMoqefJp/ucxRmOxzjVFDgroitGZ87lTKrmr8dCOHMEbMQeK8yrBZOy0trSB9aQF4SmUj3WuYdUeIaPX8nW9sf4PGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760498897; c=relaxed/simple;
	bh=qH9EBqbfeSqqcPyfWFX24676N86ZkdD2YciNFP2TwWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O45WFv+tty+mNUpNEP5iHAqn9ScmeAcv4IUsx4ZFW+cFeVc997q2S2HJtXd0GOHDiEPjH3djXhIKelX8F2aolWW88XHq+pJqRFGbov+bCV5aEjK3uaxh6iHqcJdfmqTftAPy3H/3IIAKNkY7HQ0WDDaeZQqpbTe8VW92yEFRRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LJv22Fqd; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-184.bstnma.fios.verizon.net [173.48.113.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59F3SBdM006355
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 23:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760498892; bh=imxYGjKfN6hBHRxVh0v6B9uYgdXS9ORTOJugxIL1QM8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LJv22FqdDckl7BFBLtyC3VemBj8wxClznisgRRavXKTK2LA5YCBd/MKj6jAbT+q9r
	 K3gWo0bqyX00i25qnJkwxZbUduBzb3P+jWb1pHCDYW3CobDhnxhKt/wKZDFWZGWIqE
	 dxyM9gHjSDMpAmh4CpK+QtpFSHOdP7LS4JGfnt4v5KoQfMgFPEbewMZa74nK/1nDBu
	 kiLxdkNIDO58e5kHsOKIW4HJ4+0x3eyu7r7GLHr1JJbIJDHltpISpsmrwhUfhjoBVC
	 CEKsZFROYTC/MDEyThTbOdUa2YUZ7iakfSBHkYIs6ImND2GJfBqK+01tK6T+5+gSJ4
	 ef4rmuaemKv/A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E5B9C2E00D9; Tue, 14 Oct 2025 23:28:10 -0400 (EDT)
Date: Tue, 14 Oct 2025 23:28:10 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 bug fixes for 6.18-rc2
Message-ID: <20251015032810.GA780453@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit acf943e9768ec9d9be80982ca0ebc4bfd6b7631e:

  ext4: fix checks for orphan inodes (2025-09-26 08:36:08 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git ext4_for_linus-6.18-rc2

for you to fetch changes up to c065b6046b3493a878c2ceb810aed845431badb4:

  Use CONFIG_EXT4_FS instead of CONFIG_EXT3_FS in all of the defconfigs (2025-10-13 21:50:40 -0400)

----------------------------------------------------------------
Ext4 bug fixes for 6.18-rc2, including

 * Fix regression caused by removing CONFIG_EXT3_FS when testing some
   very old defconfigs
 * Avoid a BUG_ON when opening a file on a maliciously corrupted file system
 * Avoid mm warnings when freeing a very large orphan file metadata
 * Avoid a theoretical races between metadata wrtteback and checkpoints.
   (It's very hard to hit in practice, since the race requires that the
   writeback take a very long time.)

----------------------------------------------------------------
Deepanshu Kartikey (1):
      ext4: detect invalid INLINE_DATA + EXTENTS flag combination

Jan Kara (1):
      ext4: free orphan info with kvfree

Theodore Ts'o (1):
      Use CONFIG_EXT4_FS instead of CONFIG_EXT3_FS in all of the defconfigs

Zeno Endemann (1):
      ext4, doc: fix and improve directory hash tree description

Zhang Yi (2):
      jbd2: ensure that all ongoing I/O complete before freeing blocks
      ext4: wait for ongoing I/O to complete before freeing blocks

 Documentation/filesystems/ext4/directory.rst | 63 +++++++++++++++++++++++++++++-----------------------------
 arch/arc/configs/axs101_defconfig            |  2 +-
 arch/arc/configs/axs103_defconfig            |  2 +-
 arch/arc/configs/axs103_smp_defconfig        |  2 +-
 arch/arc/configs/hsdk_defconfig              |  2 +-
 arch/arc/configs/vdk_hs38_defconfig          |  2 +-
 arch/arc/configs/vdk_hs38_smp_defconfig      |  2 +-
 arch/arm/configs/axm55xx_defconfig           |  2 +-
 arch/arm/configs/bcm2835_defconfig           |  4 ++--
 arch/arm/configs/davinci_all_defconfig       |  2 +-
 arch/arm/configs/dove_defconfig              |  4 ++--
 arch/arm/configs/ep93xx_defconfig            |  4 ++--
 arch/arm/configs/imx_v6_v7_defconfig         |  6 +++---
 arch/arm/configs/ixp4xx_defconfig            |  4 ++--
 arch/arm/configs/mmp2_defconfig              |  2 +-
 arch/arm/configs/moxart_defconfig            |  2 +-
 arch/arm/configs/multi_v5_defconfig          |  2 +-
 arch/arm/configs/mv78xx0_defconfig           |  4 ++--
 arch/arm/configs/mvebu_v5_defconfig          |  2 +-
 arch/arm/configs/nhk8815_defconfig           |  2 +-
 arch/arm/configs/omap1_defconfig             |  2 +-
 arch/arm/configs/omap2plus_defconfig         |  2 +-
 arch/arm/configs/orion5x_defconfig           |  4 ++--
 arch/arm/configs/pxa_defconfig               |  6 +++---
 arch/arm/configs/qcom_defconfig              |  2 +-
 arch/arm/configs/rpc_defconfig               |  2 +-
 arch/arm/configs/s3c6400_defconfig           |  6 +++---
 arch/arm/configs/sama7_defconfig             |  2 +-
 arch/arm/configs/socfpga_defconfig           |  2 +-
 arch/arm/configs/spear13xx_defconfig         |  4 ++--
 arch/arm/configs/spear3xx_defconfig          |  4 ++--
 arch/arm/configs/spear6xx_defconfig          |  4 ++--
 arch/arm/configs/spitz_defconfig             |  4 ++--
 arch/arm/configs/stm32_defconfig             |  2 +-
 arch/arm/configs/tegra_defconfig             |  6 +++---
 arch/arm/configs/u8500_defconfig             |  2 +-
 arch/arm/configs/vexpress_defconfig          |  2 +-
 arch/hexagon/configs/comet_defconfig         |  6 +++---
 arch/loongarch/configs/loongson3_defconfig   |  6 +++---
 arch/m68k/configs/stmark2_defconfig          |  6 +++---
 arch/microblaze/configs/mmu_defconfig        |  2 +-
 arch/mips/configs/bigsur_defconfig           |  6 +++---
 arch/mips/configs/cobalt_defconfig           |  6 +++---
 arch/mips/configs/decstation_64_defconfig    |  6 +++---
 arch/mips/configs/decstation_defconfig       |  6 +++---
 arch/mips/configs/decstation_r4k_defconfig   |  6 +++---
 arch/mips/configs/fuloong2e_defconfig        |  2 +-
 arch/mips/configs/ip22_defconfig             |  6 +++---
 arch/mips/configs/ip27_defconfig             |  6 +++---
 arch/mips/configs/ip28_defconfig             |  6 +++---
 arch/mips/configs/ip30_defconfig             |  6 +++---
 arch/mips/configs/ip32_defconfig             |  6 +++---
 arch/mips/configs/jazz_defconfig             |  2 +-
 arch/mips/configs/lemote2f_defconfig         |  6 +++---
 arch/mips/configs/loongson1b_defconfig       |  6 +++---
 arch/mips/configs/loongson1c_defconfig       |  6 +++---
 arch/mips/configs/loongson2k_defconfig       |  6 +++---
 arch/mips/configs/loongson3_defconfig        |  6 +++---
 arch/mips/configs/malta_defconfig            |  2 +-
 arch/mips/configs/malta_kvm_defconfig        |  2 +-
 arch/mips/configs/malta_qemu_32r6_defconfig  |  2 +-
 arch/mips/configs/maltaaprp_defconfig        |  2 +-
 arch/mips/configs/maltasmvp_defconfig        |  6 +++---
 arch/mips/configs/maltasmvp_eva_defconfig    |  2 +-
 arch/mips/configs/maltaup_defconfig          |  2 +-
 arch/mips/configs/maltaup_xpa_defconfig      |  2 +-
 arch/mips/configs/mtx1_defconfig             |  6 +++---
 arch/mips/configs/rm200_defconfig            |  2 +-
 arch/openrisc/configs/or1klitex_defconfig    |  2 +-
 arch/openrisc/configs/virt_defconfig         |  4 ++--
 arch/parisc/configs/generic-32bit_defconfig  |  4 ++--
 arch/parisc/configs/generic-64bit_defconfig  |  4 ++--
 arch/sh/configs/ap325rxa_defconfig           |  6 +++---
 arch/sh/configs/apsh4a3a_defconfig           |  2 +-
 arch/sh/configs/apsh4ad0a_defconfig          |  2 +-
 arch/sh/configs/ecovec24_defconfig           |  6 +++---
 arch/sh/configs/edosk7760_defconfig          |  2 +-
 arch/sh/configs/espt_defconfig               |  2 +-
 arch/sh/configs/landisk_defconfig            |  2 +-
 arch/sh/configs/lboxre2_defconfig            |  2 +-
 arch/sh/configs/magicpanelr2_defconfig       |  4 ++--
 arch/sh/configs/r7780mp_defconfig            |  2 +-
 arch/sh/configs/r7785rp_defconfig            |  2 +-
 arch/sh/configs/rsk7264_defconfig            |  2 +-
 arch/sh/configs/rsk7269_defconfig            |  2 +-
 arch/sh/configs/sdk7780_defconfig            |  4 ++--
 arch/sh/configs/sdk7786_defconfig            |  2 +-
 arch/sh/configs/se7343_defconfig             |  2 +-
 arch/sh/configs/se7712_defconfig             |  2 +-
 arch/sh/configs/se7721_defconfig             |  2 +-
 arch/sh/configs/se7722_defconfig             |  2 +-
 arch/sh/configs/se7724_defconfig             |  6 +++---
 arch/sh/configs/sh03_defconfig               |  4 ++--
 arch/sh/configs/sh2007_defconfig             |  2 +-
 arch/sh/configs/sh7757lcr_defconfig          |  2 +-
 arch/sh/configs/sh7763rdp_defconfig          |  2 +-
 arch/sh/configs/sh7785lcr_32bit_defconfig    |  2 +-
 arch/sh/configs/sh7785lcr_defconfig          |  2 +-
 arch/sh/configs/shx3_defconfig               |  2 +-
 arch/sh/configs/titan_defconfig              |  4 ++--
 arch/sh/configs/ul2_defconfig                |  2 +-
 arch/sh/configs/urquell_defconfig            |  2 +-
 arch/sparc/configs/sparc64_defconfig         |  6 +++---
 arch/xtensa/configs/audio_kc705_defconfig    |  2 +-
 arch/xtensa/configs/cadence_csp_defconfig    |  2 +-
 arch/xtensa/configs/generic_kc705_defconfig  |  2 +-
 arch/xtensa/configs/nommu_kc705_defconfig    |  2 +-
 arch/xtensa/configs/smp_lx200_defconfig      |  2 +-
 arch/xtensa/configs/virt_defconfig           |  2 +-
 arch/xtensa/configs/xip_kc705_defconfig      |  2 +-
 fs/ext4/ext4_jbd2.c                          | 11 ++++++++--
 fs/ext4/inode.c                              |  8 ++++++++
 fs/ext4/orphan.c                             |  4 ++--
 fs/jbd2/transaction.c                        | 13 ++++++++----
 114 files changed, 242 insertions(+), 221 deletions(-)

