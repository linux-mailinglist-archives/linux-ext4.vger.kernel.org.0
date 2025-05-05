Return-Path: <linux-ext4+bounces-7692-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1D7AAA98A
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 03:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B7C5A2A85
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 01:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396D13628EE;
	Mon,  5 May 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOGxJaUO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAA27E1C9;
	Mon,  5 May 2025 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485021; cv=none; b=MUgcYSAQfrgbGM7EU9uxwqdZ7XPu2/EWPnC1nqceXR29bruAwqhxXWf2/X4ArkQ49kTJje+T1f0IdCu+DGksUnpzbzeuRRANpHuup3+Wwz2HPoiEailZjsyi24ZUDamgixhyIHMhFA/tMSzOWBZSV520gUsidWP4U+EkLj7/iok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485021; c=relaxed/simple;
	bh=tEVxtUjgU9X6SNIFS64nms3QrNZHyfQin2c79+iXotA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UaReljzY4hsuwwQ89YOeMgmNKywHaR3cD/h99wqiU23HEp/sFpeBEkpw+Qv+BNeYSSUKnCuREL3wMdxy98MQsDW/6mFFq0bKLU1tyxAHTTlwGYj2Z5T6NiYxd5jOQZfqJYl+l6VYWxFx9YEz9tAxXXHXHBasYz59ow4O1m+Oj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOGxJaUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99709C4CEED;
	Mon,  5 May 2025 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485020;
	bh=tEVxtUjgU9X6SNIFS64nms3QrNZHyfQin2c79+iXotA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOGxJaUOFDTXKb2hL/uAO9ZPJzPas4nzW4LK2IpK4zHtu8YuiY8z8VjZYDt6SVGlG
	 AQnzPuNek7lciWYHJDQEl8yzuCLL+ifmhPXSF2kBHh/xKds6oo5iad2+j4hsDfY6tw
	 +WQ917nbefmHHGLVuPA7J+z08D3aJbvaJUVuhU15RgHmVjxi3uRg3wA5q4uCKvaXQU
	 0iVJsrKeFVrmeQjCTo6vUJj4j5ygMCDJCBBEV3Uo1b8tWHVqekp2hmULmZ9miyIte5
	 4J/NNUzScIblLDJLrB1nMPpqD2kfH8izCfu89edNalR0p9YQz0+nwjNooHR39elBlU
	 nqP7TwIurGSjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 127/486] ext4: do not convert the unwritten extents if data writeback fails
Date: Mon,  5 May 2025 18:33:23 -0400
Message-Id: <20250505223922.2682012-127-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit e856f93e0fb249955f7d5efb18fe20500a9ccc6d ]

When dioread_nolock is turned on (the default), it will convert unwritten
extents to written at ext4_end_io_end(), even if the data writeback fails.

It leads to the possibility that stale data may be exposed when the
physical block corresponding to the file data is read-only (i.e., writes
return -EIO, but reads are normal).

Therefore a new ext4_io_end->flags EXT4_IO_END_FAILED is added, which
indicates that some bio write-back failed in the current ext4_io_end.
When this flag is set, the unwritten to written conversion is no longer
performed. Users can read the data normally until the caches are dropped,
after that, the failed extents can only be read to all 0.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250122110533.4116662-3-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h    |  3 ++-
 fs/ext4/page-io.c | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bbffb76d9a904..75df7eeee50d8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -278,7 +278,8 @@ struct ext4_system_blocks {
 /*
  * Flags for ext4_io_end->flags
  */
-#define	EXT4_IO_END_UNWRITTEN	0x0001
+#define EXT4_IO_END_UNWRITTEN	0x0001
+#define EXT4_IO_END_FAILED	0x0002
 
 struct ext4_io_end_vec {
 	struct list_head list;		/* list of io_end_vec */
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index b7b9261fec3b5..cb023922c93c8 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -181,14 +181,25 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 		   "list->prev 0x%p\n",
 		   io_end, inode->i_ino, io_end->list.next, io_end->list.prev);
 
-	io_end->handle = NULL;	/* Following call will use up the handle */
-	ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
+	/*
+	 * Do not convert the unwritten extents if data writeback fails,
+	 * or stale data may be exposed.
+	 */
+	io_end->handle = NULL;  /* Following call will use up the handle */
+	if (unlikely(io_end->flag & EXT4_IO_END_FAILED)) {
+		ret = -EIO;
+		if (handle)
+			jbd2_journal_free_reserved(handle);
+	} else {
+		ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
+	}
 	if (ret < 0 && !ext4_forced_shutdown(inode->i_sb)) {
 		ext4_msg(inode->i_sb, KERN_EMERG,
 			 "failed to convert unwritten extents to written "
 			 "extents -- potential data loss!  "
 			 "(inode %lu, error %d)", inode->i_ino, ret);
 	}
+
 	ext4_clear_io_unwritten_flag(io_end);
 	ext4_release_io_end(io_end);
 	return ret;
@@ -344,6 +355,7 @@ static void ext4_end_bio(struct bio *bio)
 			     bio->bi_status, inode->i_ino,
 			     (unsigned long long)
 			     bi_sector >> (inode->i_blkbits - 9));
+		io_end->flag |= EXT4_IO_END_FAILED;
 		mapping_set_error(inode->i_mapping,
 				blk_status_to_errno(bio->bi_status));
 	}
-- 
2.39.5


