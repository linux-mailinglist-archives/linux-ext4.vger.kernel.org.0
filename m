Return-Path: <linux-ext4+bounces-13100-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KElCN9QcGlvXQAAu9opvQ
	(envelope-from <linux-ext4+bounces-13100-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 05:06:55 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC62850CB2
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 05:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C20E607263
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6B3D669E;
	Tue, 20 Jan 2026 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Vngf29Az"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678763DA7E0;
	Tue, 20 Jan 2026 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908392; cv=pass; b=OHk/YWZ8ETlPhpiaufCwprVA4q5tTblCx+bwAoYed4Jj9L3HYjuT6cOrXi5y/nqoUQy+fqglEKYVt1ClVrQpB5/LIkuNJb9FPcZOBFtCZuOyKVnSod7Ul08EdWMbRRFVOSN5qlWuq8AE58kiyG+jlDqCWDjeGREv+JDiZ+5xzBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908392; c=relaxed/simple;
	bh=+vj3eC7w8HstmJ2wIqkBqSlDqhfIY4teVzWTxaJPezs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9UNeS5bIUmYCA6rAoOFm3rRWDIkTTVjq3GCIoWYWvqHKFfbQDY0hoJg9+ULKpy0mvCipgIjFR4mhjNSgVxfT7yRbRDZt9dn1n+GCr2Q8IlvabDpnwMf/bBPFZPLCsVaJR/SPh6YjE17osx3Am+LMrYSXJvpHPlwkYevrPZ7ujI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Vngf29Az; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1768908364; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mj8Hsu2GN8exqbo2RtPFvNh7SN8VVCXnzLolSypwD7wtVs3lyPaNWSpx+Y93cPhMiyDtjRI9Y+unBgdCiXEuMw+0BL7Gvs2XosxEALOZaU2Jow/ombl/mKRwdhQBUP65RF7Eq8bRj1+8e6AR5wHqCeI4JTCpErjiPXzblu1Wsd0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768908364; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yKejCATUyZqrS6ujYrAGRZE1yOygBj9zrFryy9vTZig=; 
	b=ODgEUfROJzour4MgszzDraBbSZB4mH3T3eVf6AKy8pq10y4/zFzrV2ozAYor7TPmueYWp80b0n58Eb04ggzg9h+1KLGIoj2KuPreo775xCqNIo+sKRLCwy5dSnKIS8ZMZYXLKUZnI+Y1bA3Z2FSlsYOTsHIt77Uk5rA49rW0lwk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768908364;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yKejCATUyZqrS6ujYrAGRZE1yOygBj9zrFryy9vTZig=;
	b=Vngf29AztLQso0JJOjN0PPPqUchx8DjCLQV02SYTZ7fC0xCFzusrb5xN44Rq48Rb
	oxMqLMGoJzx704zGvg9QfVdsnThX0/0u9xEHBNzPxUWRqibEOYhzIL4w2yboxZcgy0p
	nts9RslxCme1F9q8/N+zcGugcm+vuv4stPPlMFA4=
Received: by mx.zohomail.com with SMTPS id 1768908362400491.0950849878243;
	Tue, 20 Jan 2026 03:26:02 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Zhang Yi <yi.zhang@huaweicloud.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [RFC v4 2/7] ext4: lockdep: handle i_data_sem subclassing for special inodes
Date: Tue, 20 Jan 2026 19:25:31 +0800
Message-ID: <20260120112538.132774-3-me@linux.beauty>
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
	TAGGED_FROM(0.00)[bounces-13100-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BC62850CB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fast commit can hold s_fc_lock while writing journal blocks. Mapping the
journal inode can take its i_data_sem. Normal inode update paths can take a
data inode i_data_sem and then s_fc_lock, which makes lockdep report a
circular dependency.

lockdep treats all i_data_sem instances as one lock class and cannot
distinguish the journal inode i_data_sem from a regular inode i_data_sem.
The journal inode is not tracked by fast commit and no FC waiters ever
depend on it, so this is not a real ABBA deadlock. Assign the journal inode
a dedicated i_data_sem lockdep subclass to avoid the false positive.

Inode cache objects can be recycled, so also reset i_data_sem to
I_DATA_SEM_NORMAL when allocating an ext4 inode. Otherwise a new inode may
inherit an old subclass (journal/quota/ea) and trigger lockdep warnings.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/ext4.h  | 4 +++-
 fs/ext4/super.c | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bd30c24d4f94..2e1681057196 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1025,12 +1025,14 @@ do {										\
  *			  than the first
  *  I_DATA_SEM_QUOTA  - Used for quota inodes only
  *  I_DATA_SEM_EA     - Used for ea_inodes only
+ *  I_DATA_SEM_JOURNAL - Used for journal inode only
  */
 enum {
 	I_DATA_SEM_NORMAL = 0,
 	I_DATA_SEM_OTHER,
 	I_DATA_SEM_QUOTA,
-	I_DATA_SEM_EA
+	I_DATA_SEM_EA,
+	I_DATA_SEM_JOURNAL
 };
 
 struct ext4_fc_inode_snap;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 79762c3e0dff..4f5f0c21d436 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1423,6 +1423,9 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	spin_lock_init(&ei->i_fc_lock);
+#ifdef CONFIG_LOCKDEP
+	lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_NORMAL);
+#endif
 	return &ei->vfs_inode;
 }
 
@@ -5863,6 +5866,11 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 		return ERR_PTR(-EFSCORRUPTED);
 	}
 
+#ifdef CONFIG_LOCKDEP
+	lockdep_set_subclass(&EXT4_I(journal_inode)->i_data_sem,
+			     I_DATA_SEM_JOURNAL);
+#endif
+
 	ext4_debug("Journal inode found at %p: %lld bytes\n",
 		  journal_inode, journal_inode->i_size);
 	return journal_inode;
-- 
2.52.0

