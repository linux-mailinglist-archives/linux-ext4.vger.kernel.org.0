Return-Path: <linux-ext4+bounces-3767-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F229955AC0
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCC12820E0
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0EDEEB9;
	Sun, 18 Aug 2024 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9ybEmgz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E98F49
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953866; cv=none; b=uEueYAJnTgFQ0+jY2tA2Fc4fhIHiGnOASka1SIemFa3C0MSoP3CVJ6koMUXP34rghP7GRbfiv/FpuycGpeQFug9K7spfd3xFpuGDcyKWL0ByHZ/d7aCIPE6faR+r8iYpAYfT6xceQfr+MCAmWLusZ0Wx7tb1UX2geBgRrbRrE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953866; c=relaxed/simple;
	bh=zh0eKsR9VbmELRlmOLOIAPazlwMZw9HWOHNKQdNQvHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icEr9vh0zIiupBHMks7rFr8ZJDMIePBmTqweUBrnmpTYb3BtrXFPADYPdafa3p58KSHV48KBmUExAmFg+vYKQYVw/wJNnG18BTM8pAWFTSF3LLo61m4gtWCcGIkN4FQ7dRgiq2NOwywOpdUveAGbQ630g9TmPiMu6iEKrydv1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9ybEmgz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so2305697a12.1
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723953863; x=1724558663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2boymDsqSdzTfAxaI8ixBpygJywPoivqa4eiwO8Mt0=;
        b=F9ybEmgzqtVhEmg8nyzB8/5XnEGZ6avfTTzjQrmK0yMHPG/PbriwbrSt5+L2uu4n2x
         72ZfdzFt8ehj+k97l7JdclSeOv9GXdqYKtljgPwRfnGeSxPSeMnP0eJeIVI+jjGjItby
         MX3Awm/lx9rORANPkaNgN6cKKAeBAuTDnZoAlH4AC/TZkYsWQCKds6Td/5PkueH5tcTv
         rulih2xLW5qFfE0RoTZwt7SuIefippPKvUBZezyiLmSAcwe1QXcIG10KVOsCBi/O7KDS
         u48DjKlF9Lio8qLJRuZ/v49/XtaQj1WW6DFtX+qugoblNbU8ufrMTcgaYB3l4r5SlP8e
         FhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723953863; x=1724558663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2boymDsqSdzTfAxaI8ixBpygJywPoivqa4eiwO8Mt0=;
        b=dWorRi14myapPdvFmL3F+hb9yRoFc8ot3u6kEwQatUg+ZPtaCyxBOWpJoGzpyLihg/
         QPZWCXt93DjR2bRuWA2rFvq6ua7xqeiS/h1RNCA4KhAJpCOOdC4jb7vDV3XfOxFk5xGT
         dtTACaXMlbCdlIab0BfBN4RAhs1yC8q+BBS2QDO3DTML2N0EQ3K4lbPggiJb2p5WgtBn
         qKoBSNN7wrvJ0Du0CqI2s4ALmiag2K8rXCheKCRjYA66V7GimgZEnUPKerJWT2/UhLSe
         TRqs59vp4P+drX9jkGVkn9IDaFqriTWkrCLyazcw+9g9AiEX+WgiVUI9emKcQDRQdpIx
         uMZA==
X-Gm-Message-State: AOJu0YzlAiLycMepgoCyzVEcQFrdMMYMEzlXj3Rb2AyMIniglMWVeT7L
	fPYBZD/VI18+1dvTAg3X3vkbJ6kKK0Zs2Z88dyPlPVua0Y7ySEL6gX3hdA165rA=
X-Google-Smtp-Source: AGHT+IEGJPW3i4NleDO+Sara0xd3ANn2PbV0ZwTTEgN7l3exPOjxtFCiQpETnO20HE0k/XMcS7lJFA==
X-Received: by 2002:a05:6a21:3984:b0:1c3:a63a:cf01 with SMTP id adf61e73a8af0-1c904f6d775mr7434708637.8.1723953863103;
        Sat, 17 Aug 2024 21:04:23 -0700 (PDT)
Received: from harshads.c.googlers.com.com (27.179.83.34.bc.googleusercontent.com. [34.83.179.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375649sm45138235ad.124.2024.08.17.21.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:04:22 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 8/9] ext4: make fast commit ineligible on ext4_reserve_inode_write failure
Date: Sun, 18 Aug 2024 04:03:55 +0000
Message-ID: <20240818040356.241684-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/inode.c             | 29 ++++++++++++++++++-----------
 include/trace/events/ext4.h |  7 +++++--
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 2fc43b1e2..7525450f1 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2282,6 +2282,7 @@ static const char * const fc_ineligible_reasons[] = {
 	[EXT4_FC_REASON_FALLOC_RANGE] = "Falloc range op",
 	[EXT4_FC_REASON_INODE_JOURNAL_DATA] = "Data journalling",
 	[EXT4_FC_REASON_ENCRYPTED_FILENAME] = "Encrypted filename",
+	[EXT4_FC_REASON_INODE_RSV_WRITE_FAIL] = "Inode reserve write failure"
 };
 
 int ext4_fc_info_show(struct seq_file *seq, void *v)
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 2fadb2c47..f7f85c3dd 100644
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
index c82eba178..5a187902b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5798,20 +5798,27 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
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
index cc5e9b7b2..8bab4febd 100644
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
@@ -2809,7 +2811,7 @@ TRACE_EVENT(ext4_fc_stats,
 	),
 
 	TP_printk("dev %d,%d fc ineligible reasons:\n"
-		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u"
+		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u"
 		  "num_commits:%lu, ineligible: %lu, numblks: %lu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
@@ -2822,6 +2824,7 @@ TRACE_EVENT(ext4_fc_stats,
 		  FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
 		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
 		  FC_REASON_NAME_STAT(EXT4_FC_REASON_ENCRYPTED_FILENAME),
+		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_RSV_WRITE_FAIL),
 		  __entry->fc_commits, __entry->fc_ineligible_commits,
 		  __entry->fc_numblks)
 );
-- 
2.46.0.184.g6999bdac58-goog


