Return-Path: <linux-ext4+bounces-2591-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88208C98DA
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 07:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D99D28215C
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 05:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08AE1B7F4;
	Mon, 20 May 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdV+caiw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC6182D8
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716184336; cv=none; b=D0ygXOsrWbNdHnYO2zKr/5WSBejQVDPGo2sFUg/MjP1Nskhc3qXpIfIM93RWkyM2bi5I0puVViRMQi9ff7XqccqzfXSUKalhnIwbqXPNAZ5ahKsafm1z2PtOPNa8YRl+OGDECEvgEvOqlBuDDDHtFO+gqGCDMxZ/gDyUv4aOQVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716184336; c=relaxed/simple;
	bh=IKKf6rsddd8oPcHdU19D5t5WyBNUyloZyDAoQwAgv4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1GjfR7tO3qCK6pw/JwERaPeyTu7OWj4TE7hLnZN5b/9P4AHyqhw66kD1+rsJfrEG/xXHWZ5wqNATufkDETdq6MGJEI+Vyx0XIu0euAlfoeyu7WZI8gnCJjqaYhgewnm+TpYxuGoO4WAZ0+gTGNmc+8Q25OR9Xl1xO1+DncUYE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdV+caiw; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b52b0d0dfeso180617eaf.0
        for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716184334; x=1716789134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9FZN5YfUei8CJddqr3CyEAsHlYOvz3SFcjOWRguwOw=;
        b=KdV+caiwVt5tGlvtGURGrHm1uUOX+ue+4i43Atv5RbZUCmNjtrQ4kotaPMunRhmT29
         0MLIZ2RTtYyK03+O2YMyPo0KSvVlu9Mzl5exIfbZQftGDS0LV1eAjFSn63y4ZQ5+yrvY
         i6pFj26HY1T9BzWcU9bDkC1Sus694BbT1YMgUK/qFmBwIcPo1iamwemchOEbYiNceLmo
         OZI6ec9CBDAQeZjGfjQ7V9l2qM/T/aRJC28tyi8FIisw3mfO5cwBx/P/uNnbppAETi7a
         5LlPWE+tcWoW9OOrILGxt+dujGX3l98ZRlJN0NS0DHWW0y3fAtKZH7OfZtCYwPmMXz2G
         SoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716184334; x=1716789134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9FZN5YfUei8CJddqr3CyEAsHlYOvz3SFcjOWRguwOw=;
        b=vglBlUxIj7duswFTZm4XYiN94erV4dTFFBkY8559vlISCS/Kt2aF2ljqXRqCL5nUKH
         s7OMZis/49Eka/nDKPzhAAPTiGh1u0UfirefnA2oIYCkzh7FgzJnzNkfB7D3YhdHCRZg
         VcGufAPEZHoLniZ5RAPaQ2n7j2cW6WEDK6tYtZBYiJAGvlBH6BLBiJUGCaTVan+Hn+3s
         pAM+drt4RC2tt49hbH0NhZcXuJAvTG24zoasWsSqiD0JAAvImkbi+fPA6snYI8Y12Rxf
         rk8fNre1JSNAAXc95gvezjn6kG8uQ0zLAOlnKlPsBUREhaECctnM+vOG2WBWznO7fJHC
         CBOw==
X-Gm-Message-State: AOJu0YwmmZUGbQPh7+Y/vDDNdq12XNPCMu+p9TLw30qgIwcYRq7l4OG1
	ZzcO7b5lax0GnARUUe7Oo6djqbVEe8bs9JdxvOqZxHcSn9VYMW3pMG9PFR0j
X-Google-Smtp-Source: AGHT+IGasoKtwYpqpfTAJtWSMiLk5sW9bmMEfrmpcuL5dFsqSROWiH6mHGrEAisnvSkrOLp44p4zPA==
X-Received: by 2002:a05:6358:109:b0:194:9edb:f7fd with SMTP id e5c5f4694b2df-1949edbfa53mr1187151655d.14.1716184333649;
        Sun, 19 May 2024 22:52:13 -0700 (PDT)
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
Subject: [PATCH 09/10] ext4: temporarily elevate commit thread priority
Date: Mon, 20 May 2024 05:51:52 +0000
Message-ID: <20240520055153.136091-10-harshadshirwadkar@gmail.com>
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

Unlike JBD2 based full commits, there is no dedicated journal thread
for fast commits. Thus to reduce scheduling delays between IO
submission and completion, temporarily elevate the committer thread's
priority to match the configured priority of the JBD2 journal
thread.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  4 +++-
 fs/ext4/fast_commit.c | 13 +++++++++++++
 fs/ext4/super.c       |  5 ++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3721daea2890..d52df8a85271 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2287,10 +2287,12 @@ static inline int ext4_forced_shutdown(struct super_block *sb)
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
  * Minimum number of groups in a flexgroup before we separate out
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 35c89bee452c..d354839dbf7e 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1205,6 +1205,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	int subtid = atomic_read(&sbi->s_fc_subtid);
 	int status = EXT4_FC_STATUS_OK, fc_bufs_before = 0;
 	ktime_t start_time, commit_time;
+	int old_ioprio, journal_ioprio;
 
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
 		return jbd2_complete_transaction(journal, commit_tid);
@@ -1242,6 +1243,16 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
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
+	old_ioprio = get_current_ioprio();
+	set_task_ioprio(current, journal_ioprio);
 	fc_bufs_before = (sbi->s_fc_bytes + bsize - 1) / bsize;
 	ret = ext4_fc_perform_commit(journal);
 	if (ret < 0) {
@@ -1256,6 +1267,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	}
 	atomic_inc(&sbi->s_fc_subtid);
 	ret = jbd2_fc_end_commit(journal);
+	set_task_ioprio(current, old_ioprio);
 	/*
 	 * weight the commit time higher than the average time so we
 	 * don't react too strongly to vast changes in the commit time
@@ -1265,6 +1277,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	return ret;
 
 fallback:
+	set_task_ioprio(current, old_ioprio);
 	ret = jbd2_fc_end_commit_fallback(journal);
 	ext4_fc_update_stats(sb, status, 0, 0, commit_tid);
 	return ret;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 77173ec91e49..18d9d2631559 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1833,7 +1833,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	{}
 };
 
-#define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 
 #define MOPT_SET	0x0001
 #define MOPT_CLEAR	0x0002
@@ -5211,7 +5210,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	/* Set defaults for the variables that will be set during parsing */
 	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
-		ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
+		ctx->journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
 
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
 	sbi->s_sectors_written_start =
@@ -6471,7 +6470,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 			ctx->journal_ioprio =
 				sbi->s_journal->j_task->io_context->ioprio;
 		else
-			ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
+			ctx->journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
 
 	}
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


