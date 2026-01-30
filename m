Return-Path: <linux-ext4+bounces-13432-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKK7AdkffGmgKgIAu9opvQ
	(envelope-from <linux-ext4+bounces-13432-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 04:04:57 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 789ACB6B11
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 04:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2EA8303EBB7
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 02:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8564C330B0E;
	Fri, 30 Jan 2026 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="YCizOgPA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D02857CD;
	Fri, 30 Jan 2026 02:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741657; cv=pass; b=nSqlKSgER0G9MaELxeEF2V6LDY+b70Tr8CtpqXvRb6IO5jnOgT25JJUb9pmP+1S80a97n81gdx5ZpIxyVGg7MqMfHt89vTPpYgIj7puVGS0Pi2AoG7GIhNwlEvm5r8JeeJsq0U4GrQbx8EZ3UTLQiyGHS8B6QcsuExGrTushPN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741657; c=relaxed/simple;
	bh=a5dN0Xu8DJxd3sNMaQXDz2ZIZSc5MBE29j8IhPW7vho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ls9OuFz6Ew/IM7sjtjRwjN1K6ZbHGqBp2hqpe+oXLavEgNeOXVxGDwdgLmfrKP2sWDiaU8wxEy6k1Ah0v9F49CZnYwZyO0tXrmriq0dy1eEQv2IQexliFu7tyZp0/RHA2mDGSS1lwhF6QUIZWVBHIR2AKY9NLnO1MQwwzSxlvbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=YCizOgPA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1769741642; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TlODcD7nNHdKFKM69eTMgnXy+RYcsSiBVgZ4j0JTqErAzjuWjvwiAUxjOiuuzDcm8qWW8sZreZYCBi+pobceMUINW7LYbOdVwfRRfS8upA4NWfEJPa9ItjXsmyYnm2ansB44PHsxpgDXdTejWGSAZMJWIdPjA8ftcb3PUd+VlM0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769741642; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ebI4xhDb6SkWVwcy5gJUx4SwgAuJlbz3kPPE7oXcNoc=; 
	b=TOrjtXRkmlCc6iOnaoUynk2zJyIn1+Cj+akFQJKeOKTTB5pdJwloyoY+yw0aB24Nbbqmoi7fUums7p7ROrN8+gjxWIzBtTQirQv3nZEqvj4xd/K5bPLpz++iLNks42aHOuSIZNfxZFQZuFDh2hBfNH1pSIkZ18SbVB1j5V1+i6E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769741641;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ebI4xhDb6SkWVwcy5gJUx4SwgAuJlbz3kPPE7oXcNoc=;
	b=YCizOgPARcpHbSxIYUck4K4nT9t5sztcD4PmIsABjTjfY9aJOvP6ImyJfNZlOEJF
	YML2Xzg8m6iur7FAJXxbEV6r8CbFNrgBI6es83XL3ZUK0QicAoE60dsBPVJ+6oR4kDE
	HiCJWQnNMO/SO+XFn7AEscLaNdYN1O0HBm7qx1G8=
Received: by mx.zohomail.com with SMTPS id 1769741638174199.07500266504655;
	Thu, 29 Jan 2026 18:53:58 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Li Chen <me@linux.beauty>
Subject: [PATCH v2] ext4: publish jinode after initialization
Date: Fri, 30 Jan 2026 10:53:38 +0800
Message-ID: <20260130025339.51519-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[linux.beauty:email,linux.beauty:dkim,linux.beauty:mid];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13432-lists,linux-ext4=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.beauty:s=zmail];
	DMARC_NA(0.00)[linux.beauty];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.330];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.beauty:email,linux.beauty:dkim,linux.beauty:mid]
X-Rspamd-Queue-Id: 789ACB6B11
X-Rspamd-Action: add header
X-Spam: Yes

ext4_inode_attach_jinode() publishes ei->jinode to concurrent users.
It used to set ei->jinode before jbd2_journal_init_jbd_inode(),
allowing a reader to observe a non-NULL jinode with i_vfs_inode
still unset.

The fast commit flush path can then pass this jinode to
jbd2_wait_inode_data(), which dereferences i_vfs_inode->i_mapping and
may crash.

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
FS: 00007fc2f9e3e6c0(0000) GS:ffff9ea6b1444000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
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

Fix this by initializing the jbd2_inode first.
Use smp_wmb() and WRITE_ONCE() to publish ei->jinode after
initialization. Readers use READ_ONCE() to fetch the pointer.

Fixes: a361293f5fede ("jbd2: Fix oops in jbd2_journal_file_inode()")
Cc: stable@vger.kernel.org
Signed-off-by: Li Chen <me@linux.beauty>
---

Changes since v1:
- Publish EXT4_I(inode)->jinode with smp_wmb() + WRITE_ONCE(), and fetch it
  with READ_ONCE() (instead of smp_store_release()/smp_load_acquire()), as
  suggeted by Jan.

 fs/ext4/ext4_jbd2.h   | 16 ++++++++++++----
 fs/ext4/fast_commit.c |  7 +++++--
 fs/ext4/inode.c       | 15 +++++++++++----
 fs/ext4/super.c       | 11 +++++++----
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 63d17c5201b5..2d5343441b71 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -336,18 +336,26 @@ static inline int ext4_journal_force_commit(journal_t *journal)
 static inline int ext4_jbd2_inode_add_write(handle_t *handle,
 		struct inode *inode, loff_t start_byte, loff_t length)
 {
-	if (ext4_handle_valid(handle))
+	if (ext4_handle_valid(handle)) {
+		struct jbd2_inode *jinode;
+
+		jinode = READ_ONCE(EXT4_I(inode)->jinode);
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
+		jinode = READ_ONCE(EXT4_I(inode)->jinode);
 		return jbd2_journal_inode_ranged_wait(handle,
-				EXT4_I(inode)->jinode, start_byte, length);
+				jinode, start_byte, length);
+	}
 	return 0;
 }
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f575751f1cae..a80ed2d6df81 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -972,16 +972,19 @@ static int ext4_fc_flush_data(journal_t *journal)
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_inode_info *ei;
+	struct jbd2_inode *jinode;
 	int ret = 0;
 
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		ret = jbd2_submit_inode_data(journal, ei->jinode);
+		jinode = READ_ONCE(ei->jinode);
+		ret = jbd2_submit_inode_data(journal, jinode);
 		if (ret)
 			return ret;
 	}
 
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		ret = jbd2_wait_inode_data(journal, ei->jinode);
+		jinode = READ_ONCE(ei->jinode);
+		ret = jbd2_wait_inode_data(journal, jinode);
 		if (ret)
 			return ret;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index da96db5f2345..d99296d7315f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -128,6 +128,8 @@ void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
 static inline int ext4_begin_ordered_truncate(struct inode *inode,
 					      loff_t new_size)
 {
+	struct jbd2_inode *jinode = READ_ONCE(EXT4_I(inode)->jinode);
+
 	trace_ext4_begin_ordered_truncate(inode, new_size);
 	/*
 	 * If jinode is zero, then we never opened the file for
@@ -135,10 +137,10 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
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
 
@@ -4478,8 +4480,13 @@ int ext4_inode_attach_jinode(struct inode *inode)
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
+		smp_wmb();
+		WRITE_ONCE(ei->jinode, jinode);
 		jinode = NULL;
 	}
 	spin_unlock(&inode->i_lock);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 69eb63dde983..5cf6c2b54bbb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1526,17 +1526,20 @@ static void destroy_inodecache(void)
 
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
+	jinode = READ_ONCE(EXT4_I(inode)->jinode);
+	if (jinode) {
 		jbd2_journal_release_jbd_inode(EXT4_JOURNAL(inode),
-					       EXT4_I(inode)->jinode);
-		jbd2_free_inode(EXT4_I(inode)->jinode);
-		EXT4_I(inode)->jinode = NULL;
+					       jinode);
+		jbd2_free_inode(jinode);
+		WRITE_ONCE(EXT4_I(inode)->jinode, NULL);
 	}
 	fscrypt_put_encryption_info(inode);
 	fsverity_cleanup_inode(inode);
-- 
2.52.0


