Return-Path: <linux-ext4+bounces-6920-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EBCA68A88
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Mar 2025 12:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869D43AE9F3
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Mar 2025 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74073252903;
	Wed, 19 Mar 2025 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HbAWUbWF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4321E1E11;
	Wed, 19 Mar 2025 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382141; cv=none; b=bG3IlfVRprqH/SIgitlcG/Fzutfirya8T/1jSXkGr+j08G95GGetZO0EvVJjR9XRFcyNVkT7YoxC7wF3vZLSe3NDaLC9W8999Bed7esS7aJNtF9/UElkEqWA19D/FoVmDC88Ve38vVm5U+aH/NdwKDqN0mV37bWvq4n3LQBJK8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382141; c=relaxed/simple;
	bh=CbYmhUb8EkLkPuFdD4oV9ftvFWgqisEueqJwG6XJ48w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GVWHXwOwXetvBuaugUFhVf6HKh/n//zNLOB49FiU8BeNxTDZ+6AiQVLdzt/ffZbuEaXipkI45M9CBuX3RvHyhsKu3RUAjZPDB03RYSFaB9xqJ8xaYkWK5F0dOtOpqntxhFZ90dCfKGv9N9AUMQi9eA1nj3/B+oznUhcI04VxR/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HbAWUbWF; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742382140; x=1773918140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vk5Lc7xy87s792gzIrpXh8NJw4dib0s+g5H7MWmXWv4=;
  b=HbAWUbWF0loFj0VokOa5OKueMKUhqFOGTwQGhtDtfN07IrOn2YVuYGAf
   fpipt0aTS76GyW8nB659ExjsyMQa7oF7XvpaWcuUu+3R4U0pbGtDzeYFq
   Cmalv1RNgXb5m2j8DsBRbnDZoQuwwqZzQZWn1bddXtz+s0hXKujdV+iQ8
   g=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736812800"; 
   d="scan'208";a="504053979"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 11:02:11 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.29.78:33402]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.45.183:2525] with esmtp (Farcaster)
 id c012bdca-5667-43d0-ba27-19c4d02abb87; Wed, 19 Mar 2025 11:02:10 +0000 (UTC)
X-Farcaster-Flow-ID: c012bdca-5667-43d0-ba27-19c4d02abb87
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.146) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 11:02:02 +0000
Received: from email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 11:02:02 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com (dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com [172.19.75.107])
	by email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com (Postfix) with ESMTP id 1EA6141319;
	Wed, 19 Mar 2025 11:02:02 +0000 (UTC)
Received: by dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com (Postfix, from userid 23348560)
	id D04776C12; Wed, 19 Mar 2025 11:02:01 +0000 (UTC)
From: Jakub Acs <acsjakub@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>
CC: <acsjakub@amazon.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
	<adilger.kernel@dilger.ca>, Mahmoud Adam <mngyadam@amazon.com>,
	<stable@vger.kernel.org>, <security@kernel.org>
Subject: [PATCH] ext4: fix OOB read when checking dotdot dir
Date: Wed, 19 Mar 2025 11:01:34 +0000
Message-ID: <20250319110134.10071-1-acsjakub@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Mounting a corrupted filesystem with directory which contains '.' dir
entry with rec_len == block size results in out-of-bounds read (later
on, when the corrupted directory is removed).

ext4_empty_dir() assumes every ext4 directory contains at least '.'
and '..' as directory entries in the first data block. It first loads
the '.' dir entry, performs sanity checks by calling ext4_check_dir_entry()
and then uses its rec_len member to compute the location of '..' dir
entry (in ext4_next_entry). It assumes the '..' dir entry fits into the
same data block.

If the rec_len of '.' is precisely one block (4KB), it slips through the
sanity checks (it is considered the last directory entry in the data
block) and leaves "struct ext4_dir_entry_2 *de" point exactly past the
memory slot allocated to the data block. The following call to
ext4_check_dir_entry() on new value of de then dereferences this pointer
which results in out-of-bounds mem access.

Fix this by extending __ext4_check_dir_entry() to check for '.' dir
entries that reach the end of data block. Make sure to ignore the phony
dir entries for checksum (by checking name_len for non-zero).

Note: This is reported by KASAN as use-after-free in case another
structure was recently freed from the slot past the bound, but it is
really an OOB read.

This issue was found by syzkaller tool.

Call Trace:
[   38.594108] BUG: KASAN: slab-use-after-free in __ext4_check_dir_entry+0x67e/0x710
[   38.594649] Read of size 2 at addr ffff88802b41a004 by task syz-executor/5375
[   38.595158]
[   38.595288] CPU: 0 UID: 0 PID: 5375 Comm: syz-executor Not tainted 6.14.0-rc7 #1
[   38.595298] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   38.595304] Call Trace:
[   38.595308]  <TASK>
[   38.595311]  dump_stack_lvl+0xa7/0xd0
[   38.595325]  print_address_description.constprop.0+0x2c/0x3f0
[   38.595339]  ? __ext4_check_dir_entry+0x67e/0x710
[   38.595349]  print_report+0xaa/0x250
[   38.595359]  ? __ext4_check_dir_entry+0x67e/0x710
[   38.595368]  ? kasan_addr_to_slab+0x9/0x90
[   38.595378]  kasan_report+0xab/0xe0
[   38.595389]  ? __ext4_check_dir_entry+0x67e/0x710
[   38.595400]  __ext4_check_dir_entry+0x67e/0x710
[   38.595410]  ext4_empty_dir+0x465/0x990
[   38.595421]  ? __pfx_ext4_empty_dir+0x10/0x10
[   38.595432]  ext4_rmdir.part.0+0x29a/0xd10
[   38.595441]  ? __dquot_initialize+0x2a7/0xbf0
[   38.595455]  ? __pfx_ext4_rmdir.part.0+0x10/0x10
[   38.595464]  ? __pfx___dquot_initialize+0x10/0x10
[   38.595478]  ? down_write+0xdb/0x140
[   38.595487]  ? __pfx_down_write+0x10/0x10
[   38.595497]  ext4_rmdir+0xee/0x140
[   38.595506]  vfs_rmdir+0x209/0x670
[   38.595517]  ? lookup_one_qstr_excl+0x3b/0x190
[   38.595529]  do_rmdir+0x363/0x3c0
[   38.595537]  ? __pfx_do_rmdir+0x10/0x10
[   38.595544]  ? strncpy_from_user+0x1ff/0x2e0
[   38.595561]  __x64_sys_unlinkat+0xf0/0x130
[   38.595570]  do_syscall_64+0x5b/0x180
[   38.595583]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: ac27a0ec112a0 ("[PATCH] ext4: initial copy of files from ext3")
Signed-off-by: Jakub Acs <acsjakub@amazon.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Mahmoud Adam <mngyadam@amazon.com>
Cc: stable@vger.kernel.org
Cc: security@kernel.org
---
If not fixed, this potentially leaks information from kernel data
structures allocated after the data block.

I based the check on the assumption that every ext4 directory has '.'
followed by at least one entry ('..') in the first data block.
(the code in ext4_empty_dir seems to operate on this assumption)

..and it is also supported by claim in
https://www.kernel.org/doc/html/latest/filesystems/ext4/directory.html:
"By ext2 custom, the '.' and '..' entries must appear at the beginning of
this first block"

Please confirm that this is correct and there are no valid ext4
directories that have '.' as the last directory entry. If this
assumption is wrong, I would fix the caller rather than the callee.

Testing:
I booted the kernel in AL2023 EC2 Instance and ran ext4 tests from
git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git:

<setup with loop devices>
./check ext4/*
[..]
ext4/002       [not run] This test requires a valid $SCRATCH_LOGDEV
ext4/004       [not run] dump utility required, skipped this test
ext4/006       [not run] Couldn't find e2fuzz
ext4/029       [not run] This test requires a valid $SCRATCH_LOGDEV
ext4/030       [not run] mount /dev/loop1 with dax failed
ext4/031       [not run] mount /dev/loop1 with dax failed
ext4/047       [not run] mount /dev/loop1 with dax=always failed
ext4/055       [not run] fsgqa user not defined.
ext4/057       [not run] UUID ioctls are not supported by kernel.
Not run: ext4/002 ext4/004 ext4/006 ext4/029 ext4/030 ext4/031 ext4/047
ext4/055 ext4/057
Passed all 69 tests
(please let me know if any of the skipped tests need to be run)

Thanks,
Jakub
---
 fs/ext4/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 02d47a64e8d1..d157a6c0eff6 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -104,6 +104,9 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 	else if (unlikely(le32_to_cpu(de->inode) >
 			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))
 		error_msg = "inode out of bounds";
+	else if (unlikely(de->name_len > 0 && strcmp(".", de->name) == 0 &&
+			  next_offset == size))
+		error_msg = "'.' directory cannot be the last in data block";
 	else
 		return 0;
 
-- 
2.47.1


