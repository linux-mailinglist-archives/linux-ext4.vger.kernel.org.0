Return-Path: <linux-ext4+bounces-12496-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E719CD9685
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Dec 2025 14:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7630E30198EE
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Dec 2025 13:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF70833BBD5;
	Tue, 23 Dec 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="IePkfvv2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98A2E0413;
	Tue, 23 Dec 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766495640; cv=pass; b=h/XOA3cm6fuyYCI+h+ew8MSv3UUa4ikjOJauvEQcNauEy2rJQHu1vwjYBEE+w/ySo1yLZVuEAKbdqWTTBaVa9FpY8uATNon//jgS0x2t0PzIewGLvxvt8vqnYaqfeAg2yhUiMJKZ9q9MSuupIjdbKsShuY6nqBXcFHsbabbSD+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766495640; c=relaxed/simple;
	bh=Y1e2QsBeSw5Ng4JxBrvqj8COz9NO1FU+qOk8km7q+KU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMv0C3uwbKBxpL/eQvoYUN3HSx3iGHZSGJN51AaHrkYAsVWKowvbXa/L+OUIz0XxSNabcx2s6i8KqNcJj6tbu2QGa5w1iYiUibvU6LZg8SKgO/qErPFeik6k33lQg5TKOQB0glNgUj779ayZqqmwR/6PO4DkXnygSvKI5Ffaxo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=IePkfvv2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1766495630; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MetmiIZ3D842SjYtXdNRbDe767ozMiPtJM0NL6KGCVpnQNsbry6WHljt46SFr512hucwfJtEjjPr3q97Pb/1sO2Nwg7bFdRnp1jKJogcTNg2LeFdSkGs6NwRfxu+L4Qx2M6hrMZSUjtlN96NXtkkUhxQ4wlTy93WREehR7R8IVw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766495630; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bCmo53LSOHFN9GPFLqYKeAdSZOIhLNP2QIolcPH+gXc=; 
	b=ZgBcNUufcwcRhzyKd1GCB+jZLY1ypydsqs2WjcPKcQgmSt/23+B2nh+LOD0m87qdCe/9x3BJccqMkaPp/3U9i/FTZblvooeg1IVgzf/20aIfg6btHSUMIZDIAXYr8BcgcVpkOb2XixK48Dt8hT2uhBYiraa11SEAKRIISJevVrk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766495630;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bCmo53LSOHFN9GPFLqYKeAdSZOIhLNP2QIolcPH+gXc=;
	b=IePkfvv2RSy2zQJExXu4yq4z3OCIu9noBFgdHVu4VJDQzXF858VYL5B6rPGY38Kd
	ixOgzIWSZcNKNVHXvssOHupcGueIJWxUPW46Dl7fXtHqL0v8mC/16DAoCgZseZ+qjCY
	i2iYhYV/IuKbTOZ2Qese/w0iJmNaC3ptfMG8BwvA=
Received: by mx.zohomail.com with SMTPS id 1766495627451236.0108956232683;
	Tue, 23 Dec 2025 05:13:47 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH] ext4: fast commit: avoid fs_reclaim inversion in perform_commit
Date: Tue, 23 Dec 2025 21:13:42 +0800
Message-ID: <20251223131342.287864-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

lockdep reports a possible deadlock due to lock order inversion:

     CPU0                    CPU1
     ----                    ----
lock(fs_reclaim);
                             lock(&sbi->s_fc_lock);
                             lock(fs_reclaim);
lock(&sbi->s_fc_lock);

ext4_fc_perform_commit() holds s_fc_lock while writing the fast commit
log. Allocations here can enter reclaim and take fs_reclaim, inverting
with ext4_fc_del() which runs under fs_reclaim during inode eviction.
Wrap Step 6 in memalloc_nofs_save()/restore() so reclaim is skipped
while s_fc_lock is held.

Fixes: 6593714d67ba ("ext4: hold s_fc_lock while during fast commit")
Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/fast_commit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3bcdd4619de1..b0c458082997 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1045,6 +1045,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	struct ext4_fc_head head;
 	struct inode *inode;
 	struct blk_plug plug;
+	unsigned int nofs;
 	int ret = 0;
 	u32 crc = 0;
 
@@ -1118,6 +1119,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		blkdev_issue_flush(journal->j_fs_dev);
 
 	blk_start_plug(&plug);
+	nofs = memalloc_nofs_save();
 	/* Step 6: Write fast commit blocks to disk. */
 	if (sbi->s_fc_bytes == 0) {
 		/*
@@ -1158,6 +1160,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 
 out:
 	mutex_unlock(&sbi->s_fc_lock);
+	memalloc_nofs_restore(nofs);
 	blk_finish_plug(&plug);
 	return ret;
 }
-- 
2.52.0


