Return-Path: <linux-ext4+bounces-12521-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3332BCDE540
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Dec 2025 06:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E969300B80D
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Dec 2025 05:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48041DD877;
	Fri, 26 Dec 2025 05:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="G/hKDSVg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA23A1E92;
	Fri, 26 Dec 2025 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766725360; cv=pass; b=YIk7p0V9F6G8epFnWDqBdEpbSPnTqqWgGEaGYcW7MxsjlP92c8yV0lM+1tBTymR6QXT/OiUX7ggnpPDkqXZ9CT9vnnl8iNKyOCb3Q00S2XKzeWWWYIYvxTT8EiAuoPc9EliYswI2QXMM5t+wrBJn4c2C06d6XFUDBRmKv4ffhes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766725360; c=relaxed/simple;
	bh=yCznxMTkqi3qZm+nW2rL30mF727CoYfCBgqYAHRXTKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfQGq1zKu4m9a7zrAQRJEd8t7GR/9B9gXcukbHCyZbldfBv70dYcuY6UZM7nEAWGK8YFddmazZUxOPV10FXezMLcEwWpKJYxwNI5kjLEOruKiQDY7v19tKkXs5XVu/fA4UvfgK8Vc5Z82brvgQbMuWm8UMrcs7TmM3OFfcb6oiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=G/hKDSVg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1766725351; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GwsU0A2k+XgnMhb5kVZ/4khKGfe7YgNKxnKYkK4eFWnFhxNSGYTE/kUp3DHm02afSMnGEtvnk5mYVwb48kr3Xz/eCkgD6UUQMKNU0BEMpjMSmKmB0dOnzd8UR3HpOi3YCElrs8uWv7i+a/nw5j3vBjdSPMhFV1BbsKfQ+1JWTvw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766725351; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ljr2y9wPyQAtR7GqZRtXx1ATldfEYrgDSiKxNJV9mpE=; 
	b=XBwWz2bdAXv/1DMF1xceyoUx2Q7bERSY2aWM9XySnmabpVsal4betCa9K5byRITnIheroZdAJJC60Rx6dn2TbRXKw2kCGQdQEIFHSgRMTxLoUveLAuAOfs7Si79LrqEcFvNHW4s9TLMf+Mh4kezmo8DkqUwd77HFV47FuWIpzF4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766725351;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ljr2y9wPyQAtR7GqZRtXx1ATldfEYrgDSiKxNJV9mpE=;
	b=G/hKDSVgOiDXuSI2eztNbjwOruL8BUf8r5nO7GCiKEl56dNZ5V+uJVQrZnYrI80v
	sWOR17dc5Na1cUUvxGV6e/RWIotYhDAIwAiw8bwvZY6onXE+p9YtREYorW1PbKO1Kdl
	n+M+faOyEBBOam+YFN/wsUZvmdS0FwQnP6zRQS/U=
Received: by mx.zohomail.com with SMTPS id 1766725348148408.1575736439132;
	Thu, 25 Dec 2025 21:02:28 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Li Chen <me@linux.beauty>
Subject: [PATCH] ext4: publish jinode after initialization
Date: Fri, 26 Dec 2025 13:02:20 +0800
Message-ID: <20251226050220.138194-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

ext4_inode_attach_jinode() publishes ei->jinode to concurrent users.
It assigned ei->jinode before calling jbd2_journal_init_jbd_inode().

This allows another thread to observe a non-NULL jinode with i_vfs_inode
still unset. The fast commit flush path can then pass this jinode to
jbd2_wait_inode_data(), which dereferences i_vfs_inode->i_mapping and may
crash.

Below is the crash I observe:
```
BUG: unable to handle page fault for address: 000000010beb47f4
PGD 110e51067 P4D 110e51067 PUD 0
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 1 UID: 0 PID: 4850 Comm: fc_fsync_bench_ Not tainted 6.18.0-00764-g795a690c06a5 #1 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
RIP: 0010:xas_find_marked+0x3d/0x2e0
Code: e0 03 48 83 f8 02 0f 84 f0 01 00 00 48 8b 47 08 48 89 c3 48 39 c6 0f 82 fd 01 00 00 48 85 c9 74 3d 48 83 f9 03 77 63 4c 8b 0f <49> 8b 71 08 48 c7 47 18 00 00 00 00 48 89 f1 83 e1 03 48 83 f9 02
RSP: 0018:ffffbbee806e7bf0 EFLAGS: 00010246
RAX: 000000000010beb4 RBX: 000000000010beb4 RCX: 0000000000000003
RDX: 0000000000000001 RSI: 0000002000300000 RDI: ffffbbee806e7c10
RBP: 0000000000000001 R08: 0000002000300000 R09: 000000010beb47ec
R10: ffff9ea494590090 R11: 0000000000000000 R12: 0000002000300000
R13: ffffbbee806e7c90 R14: ffff9ea494513788 R15: ffffbbee806e7c88
FS:  00007fc2f9e3e6c0(0000) GS:ffff9ea6b1444000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010beb47f4 CR3: 0000000119ac5000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 filemap_get_folios_tag+0x87/0x2a0
 __filemap_fdatawait_range+0x5f/0xd0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __schedule+0x3e7/0x10c0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? preempt_count_sub+0x5f/0x80
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? cap_safe_nice+0x37/0x70
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? preempt_count_sub+0x5f/0x80
 ? srso_alias_return_thunk+0x5/0xfbef5
 filemap_fdatawait_range_keep_errors+0x12/0x40
 ext4_fc_commit+0x697/0x8b0
 ? ext4_file_write_iter+0x64b/0x950
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? preempt_count_sub+0x5f/0x80
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? vfs_write+0x356/0x480
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? preempt_count_sub+0x5f/0x80
 ext4_sync_file+0xf7/0x370
 do_fsync+0x3b/0x80
 ? syscall_trace_enter+0x108/0x1d0
 __x64_sys_fdatasync+0x16/0x20
 do_syscall_64+0x62/0x2c0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
...
```

To fix this issue, initialize the jbd2_inode first and only then publish
the pointer with smp_store_release(). Use smp_load_acquire() at the read
sites to pair with the release and ensure the initialized fields are visible.

On x86 (TSO), the crash should primarily be due to the logical early publish
window (another CPU can run between the store and initialization). x86
also relies on compiler ordering; the acquire/release helpers include
the necessary compiler barriers while keeping the fast-path cheap.

On weakly-ordered architectures (e.g. arm64/ppc), plain "init; store ptr"
is not sufficient: without release/acquire, a reader may observe the
pointer while still missing prior initialization stores. The explicit
pairing makes this publish/consume relationship correct under LKMM.

Fixes: a361293f5fede ("jbd2: Fix oops in jbd2_journal_file_inode()")
Cc: stable@vger.kernel.org
Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/ext4_jbd2.h   | 18 ++++++++++++++----
 fs/ext4/fast_commit.c |  9 +++++++--
 fs/ext4/inode.c       | 15 +++++++++++----
 fs/ext4/super.c       | 10 +++++++---
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 63d17c5201b5..3bc79b894130 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -336,18 +336,28 @@ static inline int ext4_journal_force_commit(journal_t *journal)
 static inline int ext4_jbd2_inode_add_write(handle_t *handle,
 		struct inode *inode, loff_t start_byte, loff_t length)
 {
-	if (ext4_handle_valid(handle))
+	if (ext4_handle_valid(handle)) {
+		struct jbd2_inode *jinode;
+
+		/* Pairs with smp_store_release() in ext4_inode_attach_jinode(). */
+		jinode = smp_load_acquire(&EXT4_I(inode)->jinode);
 		return jbd2_journal_inode_ranged_write(handle,
-				EXT4_I(inode)->jinode, start_byte, length);
+				jinode, start_byte, length);
+	}
 	return 0;
 }
 
 static inline int ext4_jbd2_inode_add_wait(handle_t *handle,
 		struct inode *inode, loff_t start_byte, loff_t length)
 {
-	if (ext4_handle_valid(handle))
+	if (ext4_handle_valid(handle)) {
+		struct jbd2_inode *jinode;
+
+		/* Pairs with smp_store_release() in ext4_inode_attach_jinode(). */
+		jinode = smp_load_acquire(&EXT4_I(inode)->jinode);
 		return jbd2_journal_inode_ranged_wait(handle,
-				EXT4_I(inode)->jinode, start_byte, length);
+				jinode, start_byte, length);
+	}
 	return 0;
 }
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index a6e79b3f1b48..3f148c048a6f 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1087,16 +1087,21 @@ static int ext4_fc_flush_data(journal_t *journal)
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_inode_info *ei;
+	struct jbd2_inode *jinode;
 	int ret = 0;
 
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		ret = jbd2_submit_inode_data(journal, ei->jinode);
+		/* Pairs with smp_store_release() in ext4_inode_attach_jinode(). */
+		jinode = smp_load_acquire(&ei->jinode);
+		ret = jbd2_submit_inode_data(journal, jinode);
 		if (ret)
 			return ret;
 	}
 
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		ret = jbd2_wait_inode_data(journal, ei->jinode);
+		/* Pairs with smp_store_release() in ext4_inode_attach_jinode(). */
+		jinode = smp_load_acquire(&ei->jinode);
+		ret = jbd2_wait_inode_data(journal, jinode);
 		if (ret)
 			return ret;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 78ea864fa8cd..74b189c10f2b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -126,6 +126,9 @@ void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
 static inline int ext4_begin_ordered_truncate(struct inode *inode,
 					      loff_t new_size)
 {
+	/* Pairs with smp_store_release() in ext4_inode_attach_jinode(). */
+	struct jbd2_inode *jinode = smp_load_acquire(&EXT4_I(inode)->jinode);
+
 	trace_ext4_begin_ordered_truncate(inode, new_size);
 	/*
 	 * If jinode is zero, then we never opened the file for
@@ -133,10 +136,10 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 	 * jbd2_journal_begin_ordered_truncate() since there's no
 	 * outstanding writes we need to flush.
 	 */
-	if (!EXT4_I(inode)->jinode)
+	if (!jinode)
 		return 0;
 	return jbd2_journal_begin_ordered_truncate(EXT4_JOURNAL(inode),
-						   EXT4_I(inode)->jinode,
+						   jinode,
 						   new_size);
 }
 
@@ -4497,8 +4500,12 @@ int ext4_inode_attach_jinode(struct inode *inode)
 			spin_unlock(&inode->i_lock);
 			return -ENOMEM;
 		}
-		ei->jinode = jinode;
-		jbd2_journal_init_jbd_inode(ei->jinode, inode);
+		jbd2_journal_init_jbd_inode(jinode, inode);
+		/*
+		 * Publish ->jinode only after it is fully initialized so that
+		 * readers never observe a partially initialized jbd2_inode.
+		 */
+		smp_store_release(&ei->jinode, jinode);
 		jinode = NULL;
 	}
 	spin_unlock(&inode->i_lock);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 43f1ac6e8559..a3f015129c00 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1513,16 +1513,20 @@ static void destroy_inodecache(void)
 
 void ext4_clear_inode(struct inode *inode)
 {
+	struct jbd2_inode *jinode;
+
 	ext4_fc_del(inode);
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
 	ext4_discard_preallocations(inode);
 	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
 	dquot_drop(inode);
-	if (EXT4_I(inode)->jinode) {
+	/* Pairs with smp_store_release() in ext4_inode_attach_jinode(). */
+	jinode = smp_load_acquire(&EXT4_I(inode)->jinode);
+	if (jinode) {
 		jbd2_journal_release_jbd_inode(EXT4_JOURNAL(inode),
-					       EXT4_I(inode)->jinode);
-		jbd2_free_inode(EXT4_I(inode)->jinode);
+					       jinode);
+		jbd2_free_inode(jinode);
 		EXT4_I(inode)->jinode = NULL;
 	}
 	fscrypt_put_encryption_info(inode);
-- 
2.52.0


