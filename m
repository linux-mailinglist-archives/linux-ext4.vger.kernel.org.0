Return-Path: <linux-ext4+bounces-13102-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNt9FuVacGm8XgAAu9opvQ
	(envelope-from <linux-ext4+bounces-13102-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 05:49:41 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 025DB5133A
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 05:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02F3742ACD8
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48213A9D94;
	Tue, 20 Jan 2026 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="ENOfEjcl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2442421F18;
	Tue, 20 Jan 2026 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908412; cv=pass; b=KdlGffrwc6n8EEQjGYKq+q14d1yqkbvoXe+myof7DdCswoBIPas3d0OU6ko84OKVTajDVjnLReJTLgKvX9PEazqZpFRfANC0ADGauLSgaj3yNaWlbTQxWIAqQsBjNxEyoi2IEs/4xra9TWOid/IeWrydek4hXOZYYi2nQp7T/ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908412; c=relaxed/simple;
	bh=j+xbzsW8E7HKnOl7TmDog3wuym8ZnFUzBnD8axE+DEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpnVdqFBBO9+L7Um0bCMMM5iu3OC1CMZK9g5ZMWLw0OBx8QJP0uJEBVh/En+X4B0HTpdjyVo0l32Qpr68xT0nVjFJUmwGDDlAy/Mdxyj8UxuZa+CWEwMeyQ0RDcyuXzAxDQhupCXZnsyAIWEaJuXzuPaYFaeQdpKRebS9h4wlXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=ENOfEjcl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1768908371; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YoTH07+J5AJP5rp2Kzi+/XSxUazsuzvEYo8wbmfql7hON4aEQOxsobb86HcsVWIDQKovsGsg0MIuFwltejX/p/mVDGHfwgkL3VCKrODQOcWFjL07ZmzpTnh7hcisPL3m/m9QjzoWnfx4EIevMUBowWC+4J9Mh0w4INoDnCpBG9o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768908371; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=U3QmliIwtd6Bek9mVkljEH4RMQXds+yszAsJswSwJ1Q=; 
	b=Oi/ISsuwAnwb7ggG45he03Jc0BDnU6XOGlT3sKuh4jBsi6ahi4Hu9f89gV7sWLdN9IF3INuae5D2R2l0a72WK/rG0Xns7xGn2avvcO3ONww8lMRKFZno7pMd32uPh3pIKFZSxa9pgNKQeaCe6UsdviK4TmgGmrnQiYpZ79nCLPU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768908371;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=U3QmliIwtd6Bek9mVkljEH4RMQXds+yszAsJswSwJ1Q=;
	b=ENOfEjcl/MoWCqF+mJNKEMFUti1UUWpED2sFBPnYjI/rhQsrlAiwfOwckl3JaTo1
	1HtLShwt4E/oHAW/R6B2SkAgPIc/nP1bdi+XqyKs1FUrLEBMyVbsGem/XAYzPr2SRC7
	iw5xtS26KwtEJkUQywtiWCDKIlkTmIwCuCXYQ2EA=
Received: by mx.zohomail.com with SMTPS id 17689083688141.5664256632151137;
	Tue, 20 Jan 2026 03:26:08 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Zhang Yi <yi.zhang@huaweicloud.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [RFC v4 4/7] ext4: fast commit: avoid self-deadlock in inode snapshotting
Date: Tue, 20 Jan 2026 19:25:33 +0800
Message-ID: <20260120112538.132774-5-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120112538.132774-1-me@linux.beauty>
References: <20260120112538.132774-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13102-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux.beauty];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:email,linux.beauty:dkim,linux.beauty:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 025DB5133A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ext4_fc_snapshot_inodes() used igrab()/iput() to pin inodes while building
commit-time snapshots. With ext4_fc_del() waiting for
EXT4_STATE_FC_COMMITTING, iput() can trigger
ext4_clear_inode()->ext4_fc_del() in the commit thread and deadlock waiting
for the fast commit to finish.

Avoid taking extra references. Collect inode pointers under s_fc_lock and
rely on EXT4_STATE_FC_COMMITTING to pin inodes until ext4_fc_cleanup()
clears the bit.

Also set EXT4_STATE_FC_COMMITTING for create-only inodes referenced
from the dentry update queue, and wake up waiters when ext4_fc_cleanup()
clears the bit.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/fast_commit.c | 47 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 809170d46167..966211a3342a 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1210,13 +1210,12 @@ static int ext4_fc_snapshot_inodes(journal_t *journal)
 
 	alloc_ctx = ext4_fc_lock(sb);
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		inodes[i] = igrab(&iter->vfs_inode);
-		if (inodes[i])
-			i++;
+		inodes[i++] = &iter->vfs_inode;
 	}
 
 	list_for_each_entry(fc_dentry, &sbi->s_fc_dentry_q[FC_Q_MAIN], fcd_list) {
 		struct ext4_inode_info *ei;
+		struct inode *inode;
 
 		if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT)
 			continue;
@@ -1226,12 +1225,20 @@ static int ext4_fc_snapshot_inodes(journal_t *journal)
 		/* See the comment in ext4_fc_commit_dentry_updates(). */
 		ei = list_first_entry(&fc_dentry->fcd_dilist,
 				      struct ext4_inode_info, i_fc_dilist);
+		inode = &ei->vfs_inode;
 		if (!list_empty(&ei->i_fc_list))
 			continue;
 
-		inodes[i] = igrab(&ei->vfs_inode);
-		if (inodes[i])
-			i++;
+		/*
+		 * Create-only inodes may only be referenced via fcd_dilist and
+		 * not appear on s_fc_q[MAIN]. They may hit the last iput while
+		 * we are snapshotting, but inode eviction calls ext4_fc_del(),
+		 * which waits for FC_COMMITTING to clear. Mark them FC_COMMITTING
+		 * so the inode stays pinned and the snapshot stays valid until
+		 * ext4_fc_cleanup().
+		 */
+		ext4_set_inode_state(inode, EXT4_STATE_FC_COMMITTING);
+		inodes[i++] = inode;
 	}
 	ext4_fc_unlock(sb, alloc_ctx);
 
@@ -1241,10 +1248,6 @@ static int ext4_fc_snapshot_inodes(journal_t *journal)
 			break;
 	}
 
-	for (nr_inodes = 0; nr_inodes < i; nr_inodes++) {
-		if (inodes[nr_inodes])
-			iput(inodes[nr_inodes]);
-	}
 	kvfree(inodes);
 	return ret;
 }
@@ -1312,8 +1315,9 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	jbd2_journal_lock_updates(journal);
 	/*
 	 * The journal is now locked. No more handles can start and all the
-	 * previous handles are now drained. We now mark the inodes on the
-	 * commit queue as being committed.
+	 * previous handles are now drained. Snapshotting happens in this
+	 * window so log writing can consume only stable snapshots without
+	 * doing logical-to-physical mapping.
 	 */
 	alloc_ctx = ext4_fc_lock(sb);
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
@@ -1565,6 +1569,25 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 					      struct ext4_inode_info,
 					      i_fc_dilist);
 			ext4_fc_free_inode_snap(&ei->vfs_inode);
+			spin_lock(&ei->i_fc_lock);
+			ext4_clear_inode_state(&ei->vfs_inode,
+					       EXT4_STATE_FC_REQUEUE);
+			ext4_clear_inode_state(&ei->vfs_inode,
+					       EXT4_STATE_FC_COMMITTING);
+			spin_unlock(&ei->i_fc_lock);
+			/*
+			 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
+			 * visible before we send the wakeup. Pairs with implicit
+			 * barrier in prepare_to_wait() in ext4_fc_del().
+			 */
+			smp_mb();
+#if (BITS_PER_LONG < 64)
+			wake_up_bit(&ei->i_state_flags,
+				    EXT4_STATE_FC_COMMITTING);
+#else
+			wake_up_bit(&ei->i_flags,
+				    EXT4_STATE_FC_COMMITTING);
+#endif
 		}
 		list_del_init(&fc_dentry->fcd_dilist);
 
-- 
2.52.0

