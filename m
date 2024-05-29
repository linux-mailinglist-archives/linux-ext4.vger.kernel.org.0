Return-Path: <linux-ext4+bounces-2692-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD98D29E1
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB2F286EB4
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C96A15ADAC;
	Wed, 29 May 2024 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix4iOjgN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C615AD90
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945651; cv=none; b=mtFBP89jV/K9dFTbj9iFwhYyk7s0QmWjXTGKX44tEDQSUZIqw/aIGoce/WsMKsfjHTE1epG0NN9OgbW1Jhlqd8vSzHTqPw/4qjhZlaocc9oqlgZI/ZKBCDlgwZMG8dLgBs+lFTfnx+C2aoHgnANXPOBTfR3MPE8jf96h19kxrdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945651; c=relaxed/simple;
	bh=bwGBMgQbowWGAFfW/cK1IFyBxqCMtPKEyEzNT093x5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gsm1mUICdzDNHwgO2mZwAN036VMKQT0f0Sfb2BvsatyJhrmQWrx+Hi5A+CXE8Q14PPp12M5uZktfOwHxI3qFtylyFcol7B2YsiMgcwP2hdGWQ/Zi5ryxNYSUoHaPzadOAQq5qwYhaYoAbQMj5FTwN/MlSxo8UyVEoDgacfkOiRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix4iOjgN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6818e31e5baso1289591a12.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 18:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716945649; x=1717550449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+/x2/YkXI59JKMsbGunwKDNHOeQj6UDhHq+onbOIj0=;
        b=Ix4iOjgN6sCDIjWNQXaLKDGHPxwvBh85AYUjYP7YMYA8iv7SXOyACsmTXdXeFJNV9N
         5tl5xfekxnJuN5nvwyZ9erSbTQeVLndYIe4Z50aFTuqY6xh6vkY4QuOt1dnERnO2syvW
         BMQf5hVw7vnsZpMYsIz2cw26ehoPaE6MtBAzYJOkwZSRmr4DxyHFGubmIjbrnkP3YL01
         XRqiMXo8IaIEIsV+hDjF90QvRdh0f4L83LXRFK9H2aJbdw/18OjiuX9fuMGjArjt+2tO
         tQ+IGSWjYs8ZapkqcFuiWcnzRgBbKWnKe9QsZdqFN9r7Jb1ZeE3inRwPASjY11/MXsR8
         1wiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945649; x=1717550449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+/x2/YkXI59JKMsbGunwKDNHOeQj6UDhHq+onbOIj0=;
        b=jHaD8Um7nPFCo5CrkWIAAfunMKGL4YpTjSmXuQVCJyMMtUiAfWnrJIrvbxo0TkJHpu
         RU4V76lJPuF+cdE52/yBGsyBv/Wvp6zbt6mRncDDB5NwY6Yu6Y07Nz2/KdwF0yJYRKRS
         4w2bVJ7Z37QStdqaLwQ+Qqyri3SwjhWyrXKipn4Ee746Z8IP8vM76XFeXQDgPmFcYqeF
         clF1nBlPN84u2hQq9Li83l8wtUpZUeQpMavZVQ+tSPuyQE7TwsDVEmWNfYq7kHb5Z5sl
         9p7iYn5ginJuxeLhrWRHSBnEiy1FGOxI3hjBq7lfwEXlWmdePqWqeA9aotsVHVTyLk7e
         6ZsQ==
X-Gm-Message-State: AOJu0YwMdjlYYEcs8+hUwjL1QVNoCVExNP+kwi7fpdysADPNW2Jsj8wg
	BKvwCSGlprURD8RANAB/0Rzy4O5elT8RTIXlKLd2zmqw0Wr8Zymzq7V6/q0S
X-Google-Smtp-Source: AGHT+IF/w5w/yzTa/hb/VnaeYIJK7Y0Z4jS4rioe5FyRPhEIW9xdJKxuQoJGR8YTSI5+9GbT5t0B6w==
X-Received: by 2002:a05:6a21:2d05:b0:1b0:260e:fe71 with SMTP id adf61e73a8af0-1b212e7fba7mr16600370637.60.1716945649374;
        Tue, 28 May 2024 18:20:49 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm10139388a91.53.2024.05.28.18.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:20:49 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 10/10] ext4: make fast commit ineligible on ext4_reserve_inode_write failure
Date: Wed, 29 May 2024 01:20:03 +0000
Message-ID: <20240529012003.4006535-11-harshadshirwadkar@gmail.com>
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
index 55a13d3ff681..e7cac190527c 100644
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
index f00408017c7a..8fd6e5637542 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5729,20 +5729,27 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
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
2.45.1.288.g0e0cd299f1-goog


