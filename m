Return-Path: <linux-ext4+bounces-7247-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DB2A88913
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00BD1736B9
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E54288C84;
	Mon, 14 Apr 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bra9Q9Yq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728B289353
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649691; cv=none; b=oN3njU+VzeKPO3JFGjQia1DLauTMmwqzvqg87en1Aj+VDlEP3/0kHeYmn5+NBWjJ1uFbs6N0NodtnFFXB9w/HLl7Sqri+hSKYyqusHFuolN6+amFoSsvcr/S5bevlrRWYb1EYctaRAi50jtqeJmyD9h7k9rLmhks9v45aOuo6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649691; c=relaxed/simple;
	bh=C/Xu2MDQpUQ6AYR9j/Z/j1tW9Q2hJU/kvTD9TizcGfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNPLLYxkvUjWkktiS/5D4uJ6bJ5Y6Uz3s2HZ8Lv7AHbriZ9peiNF/uamm1ck9XiKLxcKeMwmVZV5C/CMXOfw2JelCce7jx9xvId9Mv/WAx/Zfpq05N5r30cPbdboqzWs0I+Bq1vMGBnDrA+AwEbnkrE4OjRCc7LbFAOcvlHB9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bra9Q9Yq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30572effb26so4112607a91.0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649688; x=1745254488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4WVfGnGsYB00aKUsjY8yDWXg+QGHLXqSlgfYicGi5I=;
        b=Bra9Q9YqnJx0bYl8kO4cntQaACHiY9pKpz+nPOwKChiPr4G1ovmU8rQbB7tBtslQ+r
         gEwbudguf/rJrsas/12rMbHt6iVw3BKWzYq/CwBWeMe5IREbtgvbMCj0y1NU/sEvLEHY
         /Nnk8WZciRvzMMGrhYGaFBBbXw5WncSkbqM7TIA9lt3s4W0px/VTDfduuXNGF0MNHOHD
         ayL0g47BEg4kZlLEN82jsMdjU9SypxBMsHiiYYj33UD2WpSDAydofiRBW/6COhdJiyIt
         8c5C+LA3+Vk2jBuO2JyeDw1EAs7/LNWI+gShZBZBCGqcie6QO3jNg8OzOYCRo8KjPGpG
         7RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649688; x=1745254488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4WVfGnGsYB00aKUsjY8yDWXg+QGHLXqSlgfYicGi5I=;
        b=V4OiKAuFtN5l5dxY5owfWKn72IZ77WZ/5eFtc91B1erUG2XvV2Oup9Y9ljNKRhJoIX
         Mw0qLKY89KzQcCJ0tL0nXqAuAvlb2J7TCe8+b/FMpuGIwhNJki9Ssv6uj22jukbBWGNW
         +2wz+CBK6i43UgM5MwxJ58EUH2j1risVePrOQPNpe1M0lA26uCADx9idz3t8iksg6m+Y
         P4N2EWT0H95IbxSywZ6pYS/DqqKu/bcU57zO4YxMKy1p3IvT2UD0QAX8huslPR1M08YW
         j0vXBl7gCySYwgtUgv+jUPcjbLkxKkxrKlteKTvNinR2CXIUkcZU7g1SGH9kAv7M6d9j
         R41w==
X-Gm-Message-State: AOJu0Yw780h6weKKExVo4hlWjOuG9nqqzO+M9VuWJWkp4Pg1Euq5i4Bb
	gxYhbRLm5d2YitNGCBLqJzZtLWdCRVBgZaRugKXW5Fye5j0KEmh+rsDzeR9Naqk=
X-Gm-Gg: ASbGncsFxfm5apnE4SxTIuOpuYTT7990I84XE2RHM10ggJu8qYcUFIs4CoJF1V9ZNfO
	HNLB9dpGOKuHoyKTythUhtw9ntEz/LF/YyjEvd/vxuFRGtcw+iyHPJROmkLyTHULj+hXoZkzOnk
	FIrbRZvyaQVwvdxYzwFfE8uxBBTVlNeDKXQTxsJkaalb2HrrXFDQDj/Fbp5GJgMpSCcTclolyTd
	j/SbBhQbabIaTWiXpjUSO7PsIHL9z2jgrVxE/uQo5jp8iiJ6PAtmEEoi1qdqaCRYkCqPm575DL2
	93puo91XZtwg+RdarEuFGot1JGLV17nukK6AOfOwH98HNE1pxCVIlUWsavyqkmpXD161QjT2UV3
	0v1fOsIApprEeFLAhtPX6nQYyQx+37Gnqpg==
X-Google-Smtp-Source: AGHT+IGljjmashXkIjmJN2JfjELb69X3Lss+T2CFkOenCSgvN0/wg8Slk6NJLa6iXEjUtTO7khk4pQ==
X-Received: by 2002:a17:90b:4acd:b0:2f6:d266:f462 with SMTP id 98e67ed59e1d1-308237cf8eamr19727361a91.35.1744649688076;
        Mon, 14 Apr 2025 09:54:48 -0700 (PDT)
Received: from harshads.c.googlers.com.com (121.61.83.34.bc.googleusercontent.com. [34.83.61.121])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm11543107a91.31.2025.04.14.09.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:54:47 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 7/9] ext4: temporarily elevate commit thread priority
Date: Mon, 14 Apr 2025 16:54:14 +0000
Message-ID: <20250414165416.1404856-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
In-Reply-To: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
References: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike JBD2 based full commits, there is no dedicated journal thread
for fast commits. Thus to reduce scheduling delays between IO
submission and completion, temporarily elevate the committer thread's
priority to match the configured priority of the JBD2 journal
thread.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h        |  4 +++-
 fs/ext4/fast_commit.c | 13 +++++++++++++
 fs/ext4/super.c       |  5 ++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 68f40fa1b0eb..faba91321aab 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2295,10 +2295,12 @@ static inline int ext4_emergency_state(struct super_block *sb)
 #define EXT4_DEFM_NODELALLOC	0x0800
 
 /*
- * Default journal batch times
+ * Default journal batch times and ioprio.
  */
 #define EXT4_DEF_MIN_BATCH_TIME	0
 #define EXT4_DEF_MAX_BATCH_TIME	15000 /* 15ms */
+#define EXT4_DEF_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
+
 
 /*
  * Default values for superblock update
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 43fcdeb2dac0..3b441452f3cf 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1188,6 +1188,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	int subtid = atomic_read(&sbi->s_fc_subtid);
 	int status = EXT4_FC_STATUS_OK, fc_bufs_before = 0;
 	ktime_t start_time, commit_time;
+	int old_ioprio, journal_ioprio;
 
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
 		return jbd2_complete_transaction(journal, commit_tid);
@@ -1195,6 +1196,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	trace_ext4_fc_commit_start(sb, commit_tid);
 
 	start_time = ktime_get();
+	old_ioprio = get_current_ioprio();
 
 restart_fc:
 	ret = jbd2_fc_begin_commit(journal, commit_tid);
@@ -1225,6 +1227,15 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 		goto fallback;
 	}
 
+	/*
+	 * Now that we know that this thread is going to do a fast commit,
+	 * elevate the priority to match that of the journal thread.
+	 */
+	if (journal->j_task->io_context)
+		journal_ioprio = sbi->s_journal->j_task->io_context->ioprio;
+	else
+		journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
+	set_task_ioprio(current, journal_ioprio);
 	fc_bufs_before = (sbi->s_fc_bytes + bsize - 1) / bsize;
 	ret = ext4_fc_perform_commit(journal);
 	if (ret < 0) {
@@ -1239,6 +1250,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	}
 	atomic_inc(&sbi->s_fc_subtid);
 	ret = jbd2_fc_end_commit(journal);
+	set_task_ioprio(current, old_ioprio);
 	/*
 	 * weight the commit time higher than the average time so we
 	 * don't react too strongly to vast changes in the commit time
@@ -1248,6 +1260,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	return ret;
 
 fallback:
+	set_task_ioprio(current, old_ioprio);
 	ret = jbd2_fc_end_commit_fallback(journal);
 	ext4_fc_update_stats(sb, status, 0, 0, commit_tid);
 	return ret;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2cf92657fdcd..0a4ca1c8e5ce 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1809,7 +1809,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	{}
 };
 
-#define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 
 #define MOPT_SET	0x0001
 #define MOPT_CLEAR	0x0002
@@ -5255,7 +5254,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	/* Set defaults for the variables that will be set during parsing */
 	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
-		ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
+		ctx->journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
 
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
 	sbi->s_sectors_written_start =
@@ -6495,7 +6494,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 			ctx->journal_ioprio =
 				sbi->s_journal->j_task->io_context->ioprio;
 		else
-			ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
+			ctx->journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
 
 	}
 
-- 
2.49.0.604.gff1f9ca942-goog


