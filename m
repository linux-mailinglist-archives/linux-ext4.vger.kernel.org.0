Return-Path: <linux-ext4+bounces-2592-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0A58C98DB
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 07:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D971281EAF
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 05:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB411B947;
	Mon, 20 May 2024 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM79g1Rt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD318C3B
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716184336; cv=none; b=RYn4HQIxT21yZD/+EEraYefXqFOgcIbflqadRZEpaD/WVQgYzMMrCL/xaMjZ6JhvJKpkFkTwZcHaMeD/TSK/w1h4Zi+Sy9lsd3WT4LWHIfsrXEC6aURbnQKGI60NfZTKfY+l81lAscr9HVDmm/V3y2fDKPHbZKxb4EksGLc0X0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716184336; c=relaxed/simple;
	bh=+Uq9b7TIqg5KrW4Rrdyp/ut5h2nnns/CcgN8yVdLKMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFViSwtX97HKu6SRwboVU/RpX2gLlucCkJI8Zm2d/N5Znks4i+QwRfU9mUapUjW866i2L2TF1pII6aQxTOIZjmS/NU/ejiJdshTlig4QViF64K6g8KVgXHMo0mYS0mwQTN3AJM3ZFNWabQyInl2OibkX2+wOjuRXK/TjxAI4DOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM79g1Rt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f2ecea41deso54497425ad.1
        for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716184334; x=1716789134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxP9Gm2vSKqlyPVkpSXOmtFn7rLqu7QS/t6rkQVI5TU=;
        b=kM79g1Rtr+vpDoxt1uFebZlu7sUBsxTvskbEZtbwLAwj5WFQ661umTOWToYc2zUxpG
         FRsw4oW77m5o80FwnOfSifZHN5dev4KZDXUC4IgPT6VtPaE2GlnORL8lu1KM2tZI640L
         tjBdcw0EBYz8lMsDi/KVHen29tazxoTlOTV2cXFgTGe18Z3VA4MAnyUeNVKoHr5CCQM1
         eM4roHPgWZ7srVAugfphGCdpZ+ttLk7eI2hZSznLIwGHL3zsB49COr5ffX/YdYCErYwg
         jENuM8Sk6yQ3zJLExrllDvrgKv/rOwpcaeQ37+FLV5jCxZZhkcqryxwLXm/rcrvUG/wK
         wz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716184334; x=1716789134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxP9Gm2vSKqlyPVkpSXOmtFn7rLqu7QS/t6rkQVI5TU=;
        b=bqGd/zV7Opjuy7AudFugOe6ewX7zCerV8k3VfC5D7Ig6AKlcR3aLt9P6XSG5cbBU74
         qzgJ680PG1IeEH56Z9PiCbUymTAlzIX5okuc2fRLExP6T1Q+V5sn0VzWXG5ZxqwymwTm
         0KyyZjwvsQAf2Pcn9O0555NY+HgBGtCVfci1LC+N0hJXZ3JZDEj7WsDouSWw6m/Is9X5
         FvsKGRa8/xZGZVEsUsp5fOa4RJ1yjWgTFxrr5J/kYWJbG2gN53sVH4fCNJeb2p0jATLc
         wKTOaxlPhH4bwiR/9jlrvdI6xxS5QYlliH99BjLEcuaOV3JHffvtPC8B4LU3piYOxTFC
         oWhQ==
X-Gm-Message-State: AOJu0YxJ8v3TgOMq/yHeV2RmPyjlc2stxzbhnfHT8XIHzFUszBuMUFJ5
	hGicZsxmXNPCMTnro45BRsP2PQi5jyIIwOpkjrFTIQiIVigj3xqZ08ZXJrDR
X-Google-Smtp-Source: AGHT+IEJP2IiMwSd6iqbrm6J8y6TGLyEHvS3gIzUZ2M7RbvnC8hd+ibJ2W1952b3VHg2Be/ZDDGmig==
X-Received: by 2002:a05:6a00:1a8f:b0:6ec:f097:1987 with SMTP id d2e1a72fcca58-6f4e03840e4mr32667589b3a.31.1716184334239;
        Sun, 19 May 2024 22:52:14 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-659f66bf18csm6769297a12.46.2024.05.19.22.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 22:52:13 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 10/10] ext4: make fast commit ineligible on ext4_reserve_inode_write failure
Date: Mon, 20 May 2024 05:51:53 +0000
Message-ID: <20240520055153.136091-11-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
References: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fast commit by default makes every inode on which
ext4_reserve_inode_write() is called. Thus, if that function
fails for some reason, make the next fast commit ineligible.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c       |  1 +
 fs/ext4/fast_commit.h       |  1 +
 fs/ext4/inode.c             | 31 +++++++++++++++++++------------
 include/trace/events/ext4.h |  7 +++++--
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index d354839dbf7e..5ab13cb017a1 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2291,6 +2291,7 @@ static const char * const fc_ineligible_reasons[] = {
 	[EXT4_FC_REASON_FALLOC_RANGE] = "Falloc range op",
 	[EXT4_FC_REASON_INODE_JOURNAL_DATA] = "Data journalling",
 	[EXT4_FC_REASON_ENCRYPTED_FILENAME] = "Encrypted filename",
+	[EXT4_FC_REASON_INODE_RSV_WRITE_FAIL] = "Inode reserve write failure"
 };
 
 int ext4_fc_info_show(struct seq_file *seq, void *v)
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 2fadb2c4780c..f7f85c3dd3af 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -97,6 +97,7 @@ enum {
 	EXT4_FC_REASON_FALLOC_RANGE,
 	EXT4_FC_REASON_INODE_JOURNAL_DATA,
 	EXT4_FC_REASON_ENCRYPTED_FILENAME,
+	EXT4_FC_REASON_INODE_RSV_WRITE_FAIL,
 	EXT4_FC_REASON_MAX
 };
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c6405c45970e..18bab8023a16 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5420,7 +5420,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
 					inode->i_sb->s_blocksize_bits);
 
-			rc = ext4_mark_inode_dirty(handle, inode);
+						rc = ext4_mark_inode_dirty(handle, inode);
 			if (!error)
 				error = rc;
 			down_write(&EXT4_I(inode)->i_data_sem);
@@ -5728,20 +5728,27 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 {
 	int err;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	if (unlikely(ext4_forced_shutdown(inode->i_sb))) {
+		err = -EIO;
+		goto out;
+	}
 
 	err = ext4_get_inode_loc(inode, iloc);
-	if (!err) {
-		BUFFER_TRACE(iloc->bh, "get_write_access");
-		err = ext4_journal_get_write_access(handle, inode->i_sb,
-						    iloc->bh, EXT4_JTR_NONE);
-		if (err) {
-			brelse(iloc->bh);
-			iloc->bh = NULL;
-		}
-		ext4_fc_track_inode(handle, inode);
+	if (err)
+		goto out;
+
+	BUFFER_TRACE(iloc->bh, "get_write_access");
+	err = ext4_journal_get_write_access(handle, inode->i_sb,
+						iloc->bh, EXT4_JTR_NONE);
+	if (err) {
+		brelse(iloc->bh);
+		iloc->bh = NULL;
 	}
+	ext4_fc_track_inode(handle, inode);
+out:
+	if (err)
+		ext4_fc_mark_ineligible(inode->i_sb,
+			EXT4_FC_REASON_INODE_RSV_WRITE_FAIL, handle);
 	ext4_std_error(inode->i_sb, err);
 	return err;
 }
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index a697f4b77162..597845d5c1e8 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -105,6 +105,7 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_RENAME_DIR);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_FALLOC_RANGE);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_JOURNAL_DATA);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_ENCRYPTED_FILENAME);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_RSV_WRITE_FAIL);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
 
 #define show_fc_reason(reason)						\
@@ -118,7 +119,8 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
 		{ EXT4_FC_REASON_RENAME_DIR,	"RENAME_DIR"},		\
 		{ EXT4_FC_REASON_FALLOC_RANGE,	"FALLOC_RANGE"},	\
 		{ EXT4_FC_REASON_INODE_JOURNAL_DATA,	"INODE_JOURNAL_DATA"}, \
-		{ EXT4_FC_REASON_ENCRYPTED_FILENAME,	"ENCRYPTED_FILENAME"})
+		{ EXT4_FC_REASON_ENCRYPTED_FILENAME,	"ENCRYPTED_FILENAME"}, \
+		{ EXT4_FC_REASON_INODE_RSV_WRITE_FAIL,	"INODE_RSV_WRITE_FAIL"})
 
 TRACE_DEFINE_ENUM(CR_POWER2_ALIGNED);
 TRACE_DEFINE_ENUM(CR_GOAL_LEN_FAST);
@@ -2805,7 +2807,7 @@ TRACE_EVENT(ext4_fc_stats,
 	),
 
 	TP_printk("dev %d,%d fc ineligible reasons:\n"
-		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u"
+		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u"
 		  "num_commits:%lu, ineligible: %lu, numblks: %lu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
@@ -2818,6 +2820,7 @@ TRACE_EVENT(ext4_fc_stats,
 		  FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
 		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
 		  FC_REASON_NAME_STAT(EXT4_FC_REASON_ENCRYPTED_FILENAME),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_RSV_WRITE_FAIL),
 		  __entry->fc_commits, __entry->fc_ineligible_commits,
 		  __entry->fc_numblks)
 );
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


