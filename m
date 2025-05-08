Return-Path: <linux-ext4+bounces-7775-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CA3AB01F2
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 20:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B2F1BA7A3B
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 18:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48628286D52;
	Thu,  8 May 2025 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFNse3V9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB9286D40
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727179; cv=none; b=Umwrj5riyjpMHdILNrYkmANQOlHZa++LxqzY3AwmGMYEXowY6CyPCRztbb0U9W0csC0tK6pm5rBqW4C3hbrps2MAC57AHVRz3UW5wk6/FZxk764NmNCdO8CqMUmG4mV600JZg2gyCkcb+cC12AJuPy2w9b+juUpTHcNRXf+lPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727179; c=relaxed/simple;
	bh=iaKZh34dqAf/iJCU/8vqAQyADLdr7vSyN18P90kqMOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6gyNtzTB4qZLmQqIV+G9XTDTrzfdwFdTohl06nDQ2nxlyaFTEVrmYrSl/lO5HjM0+NMR8YftV3FnRJiDhCsaf9RiFh/l67DWznWknxMQrWD0UNVOjZtRDqv+e1hVJtmv3GuZkyZ0HJZltDS+v5Xjyqhq6oju0HD5L1zkFPJdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFNse3V9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227b828de00so14068185ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 08 May 2025 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746727176; x=1747331976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2VrrzhdHZB2eILkScO2krV2YHpCCjmqI0kTB/bqnlA=;
        b=BFNse3V9jr8V8Qp0lKKb9+IiUbGflcqhEKRCBpI8GQISBR0fkzjvsjma+HsQhJGpbB
         dX5+RheHSFQazpuiMsK11+SbT+uCyfMzjC54oruAQK6BTmll5iAp7HKv5nGXnhfB/ho+
         0ZXg7DVYCfqD+E2NttrPzwmxKxQnaeAx/dB1IHe3tfbgaK025cEEHyGnCoc+U0ipm1cA
         q8w1S1wWleiWvSqPHhAe6meNWrohLRxh8ddK9SYjhHtjq9uvEBC/lpbtm6wVsPtu4Ziz
         uTwX2ij0ktiWt3q33uA3I75OablhmYsKJcWx460TQuvZ+QXMDjFhqzePuEGFlEN0TQ1q
         0rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727176; x=1747331976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2VrrzhdHZB2eILkScO2krV2YHpCCjmqI0kTB/bqnlA=;
        b=IuITPkOgka9CTh7iw1xMHCGyVPzkqb8TFZ5gilSNlbC7M5qrCoVfugldnhnsKCMh/q
         M+ES/euHCdyTqG1UaaKUY+8/y9KRYpX8xOF8f3QE+9dOAC6mMryr2qhFOi4jUA16lWpR
         3mlneRF1Gd9BJRJsOgL/wV6+2uLFCu8NjmkSxP2Qpz3bLsG3y9GaU5Oza9fKG3WBLzYC
         JDQJGnEOXrR3Y4tV9UaQRh2w/DHJ/7ATeYC7mMKFeZap1+DvDtS4aRjMQI6aCyJmX1iQ
         dWZ3syrQgmMK30/7of8ttS7uLi4MrY3BLSrTPlOgAjUDLXiF54zkiaQ95Yoa3rFXozmM
         l7zg==
X-Gm-Message-State: AOJu0YzJxw+ffg0e3NX0+2RzqHVqpgP5FtVxlj1RGWm5ONe+5DezI1H8
	THoyDLfpLppkKq8irtBLFEqxvQDM5oCNvxS4t7YCUmNuvftZ4kUqhrS6JxCDCPw=
X-Gm-Gg: ASbGnct8Oixu/J7KdLTBhLZNqLT2olBg14zWRaxjLBQ8PCAnPbF8+T8eYYrEKYkZG1K
	Tul/M/k4lLpWK4TXk3pLQAsXGHubqxJhy0ixCDpVGdm6QYuL9V4f53TPVLGtDt2WYD/29HQmCGx
	GgvbghVtyskFeUow5/Tc00wKN2srnCtMKAN7DpfKiYFH59Y/cKJSnmHrwSJU52rQhrsxnM1FTa6
	UHzsZOjz32o4IVRuqiCY/ZnG8lWcQk6JmFl8ElppHO63kgLtMxPfBCQSjA/s0i8KC0z4CFZU1Qp
	AMFiPohpU9ab53Iwtm4MCnd+cQ6ycXP8fi1JG/qNr+elxcqqptATLW2hJY1c7nhDoOpg+i4QtbG
	aoWc6XZ4yW1TWYm0ucjcQBbxO+L1b4uIvy16L
X-Google-Smtp-Source: AGHT+IGED7PmwUnJIj1Ecwo4Ov2DGAeEQHMP6eo73j521u/YvmQGTZSoFVw/QJW1R81jnKophjCTcA==
X-Received: by 2002:a17:903:194b:b0:223:fb3a:8647 with SMTP id d9443c01a7336-22fc918fe99mr3815015ad.41.1746727176044;
        Thu, 08 May 2025 10:59:36 -0700 (PDT)
Received: from harshads.c.googlers.com.com (156.242.82.34.bc.googleusercontent.com. [34.82.242.156])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22fc828939asm2153535ad.164.2025.05.08.10.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:59:35 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 7/9] ext4: temporarily elevate commit thread priority
Date: Thu,  8 May 2025 17:59:06 +0000
Message-ID: <20250508175908.1004880-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
In-Reply-To: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
References: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
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
index 0cb34a06e..3987c5bf2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2296,10 +2296,12 @@ static inline int ext4_emergency_state(struct super_block *sb)
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
index 06dda3932..5f6a8ec24 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1216,6 +1216,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	int subtid = atomic_read(&sbi->s_fc_subtid);
 	int status = EXT4_FC_STATUS_OK, fc_bufs_before = 0;
 	ktime_t start_time, commit_time;
+	int old_ioprio, journal_ioprio;
 
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
 		return jbd2_complete_transaction(journal, commit_tid);
@@ -1223,6 +1224,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	trace_ext4_fc_commit_start(sb, commit_tid);
 
 	start_time = ktime_get();
+	old_ioprio = get_current_ioprio();
 
 restart_fc:
 	ret = jbd2_fc_begin_commit(journal, commit_tid);
@@ -1253,6 +1255,15 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
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
@@ -1267,6 +1278,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	}
 	atomic_inc(&sbi->s_fc_subtid);
 	ret = jbd2_fc_end_commit(journal);
+	set_task_ioprio(current, old_ioprio);
 	/*
 	 * weight the commit time higher than the average time so we
 	 * don't react too strongly to vast changes in the commit time
@@ -1276,6 +1288,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	return ret;
 
 fallback:
+	set_task_ioprio(current, old_ioprio);
 	ret = jbd2_fc_end_commit_fallback(journal);
 	ext4_fc_update_stats(sb, status, 0, 0, commit_tid);
 	return ret;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ed8166fe2..356a96269 100644
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
2.49.0.1045.g170613ef41-goog


