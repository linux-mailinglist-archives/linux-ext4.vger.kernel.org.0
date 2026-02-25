Return-Path: <linux-ext4+bounces-14004-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP0aNJyynmlxWwQAu9opvQ
	(envelope-from <linux-ext4+bounces-14004-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 09:28:12 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5A194305
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 09:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08E013039ED3
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 08:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A469311955;
	Wed, 25 Feb 2026 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="a0fAUhfF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE72BAF7;
	Wed, 25 Feb 2026 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772008005; cv=pass; b=B1CFSRbelULG3zh5ueBNCVSjTT6cixPfnScwE4vxDv52Z7mIzGZqVY2DOrOwgAhkI3ZuzccnIYgGkpvJUXUwS2zfqmgrDv3uCSwKCf4KmxaH3r7ODl01C29BTrCo2DI3zhmTrLXCGlIuaB43MnaWqSyPMyCMMCf9Jd7r35EyH5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772008005; c=relaxed/simple;
	bh=3Zs+4Z6kGJCt8+r1ClqjQ8R3MVkw7Gky1DWt97cA9Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Khphl0ZSgzVKlW67CREniRAVcJ/doewCNbG9tqUDuQNt3wkCafbOKGcKUXt/qfkzpoDUQ1woj3EXY1VHqxsKZH/xSJapfu85yECTgUvGY1/wymEG31IsA+ZIEMNeOEQkvmWk/AY+7UnHbg5R984cSLEkr9lewahcBInKIIN8jBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=a0fAUhfF; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1772007996; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OLWnJT/O9KCYP9NzPc8FI+xA+cbzvkroSi1SDaeZNDD8L7canxIoPAhcM3BksmQmIXGs9j6OIZ1LNir+o6ZyWMjdvzfwPB72N/SvDNLU2rIPT71sGp0BqMemhQ3+dYexqvq0sxXfVZm5yVkk0FDQhngAZ07Op68w59QTn+/2uxs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772007996; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KUnDOdVYhZNrQ8tAKZ27H6u3rYsiJ++SEPKPom+E9dM=; 
	b=K7X3xQAsm6+1uq15cakWRxorijtsuMzFTKIEOgdLP0vyCwgvg8dmO9gVnbPmxZVEZH7yMuJUjRC9GpYoKAR27fvclmcUu4sBk0w6+z+u5+aDL1UHQ09LQ5L8ChkqLTdg9RmvOlqgj0f/goERWidSVfi2YjxuGkXFhWwtmCLR58g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772007996;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KUnDOdVYhZNrQ8tAKZ27H6u3rYsiJ++SEPKPom+E9dM=;
	b=a0fAUhfFWxo0SSfHhv4Hsi9jhWqn1Qsi9NvcKhscotFKvELao0cqI5n2OIBoOEx6
	1F4gF4zHCQP8/n3bG7TVDVH3ETqB+lkMUvzxan+Ah9ZgvB1y1xhZJYEY5+rvORgQEDE
	aqLb62wUJGPxbZfMkPUG9a0Npna18ThPYa/N/L9w=
Received: by mx.zohomail.com with SMTPS id 1772007993367826.5514012116394;
	Wed, 25 Feb 2026 00:26:33 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Li Chen <me@linux.beauty>
Subject: [PATCH v3] ext4: publish jinode after initialization
Date: Wed, 25 Feb 2026 16:26:16 +0800
Message-ID: <20260225082617.147957-1-me@linux.beauty>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14004-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.beauty:mid,linux.beauty:dkim,linux.beauty:email]
X-Rspamd-Queue-Id: 6BC5A194305
X-Rspamd-Action: no action

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
Changes since v2 (as suggested by Jan Kara:
- Drop READ_ONCE() changes in ext4_jbd2_inode_add_*() and ext4_clear_inode().
- Inline READ_ONCE(ei->jinode) in ext4_fc_flush_data().

 fs/ext4/fast_commit.c |  4 ++--
 fs/ext4/inode.c       | 15 +++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f575751f1cae..6e949c21842d 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -975,13 +975,13 @@ static int ext4_fc_flush_data(journal_t *journal)
 	int ret = 0;
 
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		ret = jbd2_submit_inode_data(journal, ei->jinode);
+		ret = jbd2_submit_inode_data(journal, READ_ONCE(ei->jinode));
 		if (ret)
 			return ret;
 	}
 
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		ret = jbd2_wait_inode_data(journal, ei->jinode);
+		ret = jbd2_wait_inode_data(journal, READ_ONCE(ei->jinode));
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
-- 
2.52.0

