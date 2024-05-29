Return-Path: <linux-ext4+bounces-2689-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499848D29DF
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4271F26DB9
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ADB15AD9E;
	Wed, 29 May 2024 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIyuYvX2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6F15A87D
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945650; cv=none; b=eJGX9/sczvbxrvlgQNG853nFu1UrWGnb+i5GoYgnlue77ZjXjHSQzIgVaWXC4qZ5N+ISRtAqHWKmxQSq4LBPqymwjEivKAe2cy6DKa6ROJXe5+Xd4JAfx/05L4PsMWU1AuetQViVan433RwNigDGXfRB2lUnpdtR1Iuxy2LY9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945650; c=relaxed/simple;
	bh=z0oHd50cwVGs4WfCJPtlgbmzObP05NYNcKZjoGZlkLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDhXCQEWWd25VJcvNx2CfVfyIH+TAoty+84nBLK8FcO75XkyDZ8SZQLK/mrN35FhmhTjXCVq0/xKulSRFTGnzHLxIo8ZoLFnlce2DJ5VwyF+98MHeUhlyKB4CWgX5O7CrcX+eRxLPX7ImiGKdE9KznacKKZuMLqx7ka02AYcnQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIyuYvX2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2bf5797973fso1308917a91.3
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 18:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716945648; x=1717550448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVHN4sweglGqgyFV6V/7lREgp9t6tVbynbVY+ZIXHO0=;
        b=OIyuYvX2upcxDnY14RefEGSLHeDTmjCH8KjAp0RF5c7WBb7Cm8noz5EKAzAWpT/l5X
         vKo+se2KvdRwnm9gyifCWQDriKJptejZb0pmsPt/+NN8kLtGpnByzdrznHgMOkaIlzCi
         txfmNcAYn3eXweMo2O8wx9bGYDOgYlxDp7Qec7IgBng3jsN1SBYYqWBjTp3ZLk7AtSZ9
         t/kaWeElAo7BAgbkL9n0g+piNkjZAeyZtgkD56nQl3psAsoSo3AGx0oyCVtaHrWjwCOJ
         UC9Cr+uJ9o8Q/Qc6Y4SpFISIBX9FcLr73D+gq5Q+NmFb1fm6pLgEU7ksg/OjtUZ2lPTV
         01IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945648; x=1717550448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVHN4sweglGqgyFV6V/7lREgp9t6tVbynbVY+ZIXHO0=;
        b=OdyjPlxhsS+snM+cXE/83gdp1DoCUEnRDVRMkjW+vw17id5BjwI8HS26FWCjmltStj
         bpP1P31oXy9yHJUdKKpGDvOY/vutOGODoq9wjXOBx86nzabkY0pcqaBDRcczVNiopsQ3
         1liWfuGoIFqo6B25NACQ8JdW/aHif6HDKEhuThEppzwaM7z0H650r+Gtc7+r3LDAnCLw
         MnLQ6QAL8CPv2rEYvXkUq58KRxqkSG1nScIVX6a8IsUC1cW7KGrXbfoltHq3loOhEhUm
         YmIyuGwYyCAM132cKoQ5tnNUK3x4egcBtf4ACqIpvUjo44OT099G8sEx7z94wxDO9PGT
         KflA==
X-Gm-Message-State: AOJu0YxS2byL7tMtiroSBv5bQIJ2tGVOWift85tnLIZtHEsZ8f5xIZ63
	d2/1BOzk9PTDxMEkozRquj0x0ZXbdZPwBhqxYMErK2EVCBdzwBQFLKm8xDil
X-Google-Smtp-Source: AGHT+IEV9m5qmBzbsKzxZkFF5JvUA8cNwe1oi7o9cOLQd4Jt/MG75gHkaLcUyqEBquga8Bf85ogXqw==
X-Received: by 2002:a17:90b:80e:b0:2bf:ae7d:4894 with SMTP id 98e67ed59e1d1-2bfae7d4bf1mr8434553a91.19.1716945648002;
        Tue, 28 May 2024 18:20:48 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm10139388a91.53.2024.05.28.18.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:20:47 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 07/10] ext4: add nolock mode to ext4_map_blocks()
Date: Wed, 29 May 2024 01:20:00 +0000
Message-ID: <20240529012003.4006535-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nolock flag to ext4_map_blocks() which skips grabbing
i_data_sem in ext4_map_blocks. In FC commit path, we first
mark the inode as committing and thereby prevent any mutations
on it. Thus, it should be safe to call ext4_map_blocks()
without i_data_sem in this case. This is a workaround to
the problem mentioned in RFC V4 version cover letter[1] of this
patch series which pointed out that there is in incosistency between
ext4_map_blocks() behavior when EXT4_GET_BLOCKS_CACHED_NOWAIT is
passed. This patch gets rid of the need to call ext4_map_blocks()
with EXT4_GET_BLOCKS_CACHED_NOWAIT and instead call it with
EXT4_GET_BLOCKS_NOLOCK. I verified that generic/311 which failed
in cached_nowait mode passes with nolock mode.

[1] https://lwn.net/Articles/902022/

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  1 +
 fs/ext4/fast_commit.c | 16 ++++++++--------
 fs/ext4/inode.c       | 14 ++++++++++++--
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d802040e94df..196c513f82dd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -720,6 +720,7 @@ enum {
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
 	/* Caller is in the atomic contex, find extent if it has been cached */
 #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
+#define EXT4_GET_BLOCKS_NOLOCK			0x1000
 
 /*
  * The bit position of these flags must not overlap with any of the
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index b81b0292aa59..0b7064f8dfa5 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -559,13 +559,6 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 		!list_empty(&ei->i_fc_list))
 		return;
 
-	/*
-	 * If we come here, we may sleep while waiting for the inode to
-	 * commit. We shouldn't be holding i_data_sem in write mode when we go
-	 * to sleep since the commit path needs to grab the lock while
-	 * committing the inode.
-	 */
-	WARN_ON(lockdep_is_held_type(&ei->i_data_sem, 1));
 
 	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
 #if (BITS_PER_LONG < 64)
@@ -898,7 +891,14 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 	while (cur_lblk_off <= new_blk_size) {
 		map.m_lblk = cur_lblk_off;
 		map.m_len = new_blk_size - cur_lblk_off + 1;
-		ret = ext4_map_blocks(NULL, inode, &map, 0);
+		/*
+		 * Given that this inode is being committed,
+		 * EXT4_STATE_FC_COMMITTING is already set on this inode.
+		 * Which means all the mutations on the inode are paused
+		 * until the commit operation is complete. Thus it is safe
+		 * call ext4_map_blocks() in no lock mode.
+		 */
+		ret = ext4_map_blocks(NULL, inode, &map, EXT4_GET_BLOCKS_NOLOCK);
 		if (ret < 0)
 			return -ECANCELED;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 61ffbdc2fb16..f00408017c7a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -546,7 +546,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * Try to see if we can get the block without requesting a new
 	 * file system block.
 	 */
-	down_read(&EXT4_I(inode)->i_data_sem);
+	if (!(flags & EXT4_GET_BLOCKS_NOLOCK))
+		down_read(&EXT4_I(inode)->i_data_sem);
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
 		retval = ext4_ext_map_blocks(handle, inode, map, 0);
 	} else {
@@ -573,7 +574,15 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 				      map->m_pblk, status);
 	}
-	up_read((&EXT4_I(inode)->i_data_sem));
+	/*
+	 * We should never call ext4_map_blocks() in nolock mode outside
+	 * of fast commit path.
+	 */
+	WARN_ON((flags & EXT4_GET_BLOCKS_NOLOCK) &&
+		!ext4_test_inode_state(inode,
+				       EXT4_STATE_FC_COMMITTING));
+	if (!(flags & EXT4_GET_BLOCKS_NOLOCK))
+		up_read((&EXT4_I(inode)->i_data_sem));
 
 found:
 	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
@@ -614,6 +623,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * the write lock of i_data_sem, and call get_block()
 	 * with create == 1 flag.
 	 */
+	WARN_ON((flags & EXT4_GET_BLOCKS_NOLOCK) != 0);
 	down_write(&EXT4_I(inode)->i_data_sem);
 
 	/*
-- 
2.45.1.288.g0e0cd299f1-goog


