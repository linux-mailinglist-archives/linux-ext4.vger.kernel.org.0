Return-Path: <linux-ext4+bounces-3766-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA90955ABF
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C452E1F21575
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF27ADF44;
	Sun, 18 Aug 2024 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niSWnRKY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF831D53F
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953865; cv=none; b=N7PK00h2qwmgzi574wNi09O9UARSMWEkB/HBJ5ALpqnzZpcdaXeoFwz6QshJhPJcCd6ib2A6zcfVuPvYGKtWHZNqIZobbgscISh/3OsiAYNndYcVkknVj6U+JQZyXRki2vyFSC6hkMi93/xt7tzBnulwCdK10RSBndGTol85/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953865; c=relaxed/simple;
	bh=OfcyM5BUqk+/OpDM/QFpNDso7UHULRTEoT1r+Dxuy6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbKh9JwyVlGLrZsIlTf2AYnNu/biqhBNYsIrBDqfuGQzAafyxHjgarbo+lBJ2WXfa9T+d4i5nFNiWZl8YD+TjyFtFKhjvPA5c/Qyt2gTif7wL6O8av40lNVT5Jz1ehAoGEtd/uPJVvTMY74lZM09t2yWqrcWAZaaSg5/ys9P8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niSWnRKY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-202089e57d8so11516915ad.0
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723953862; x=1724558662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/VR52+ujfglkTTT6y31UeaaSeY0D0R+4tbBAN+k2wU=;
        b=niSWnRKYSna7NmmvlyL+/k2dGRqHFUN/8V2t5CyU+phOHrMA8E6gceO2aXPX6OBGAW
         0PZkUfMVatCxK54Q0zUMDJ68MkmaHj1hiT6KJ2HWl0pMHkyNytpJceNTv9P8CzgRC13/
         jJKtG8zn+0EG6ZxAY4H7lPqy1/kOUHCgC8F4BgW0IaiW9nSfBX5xitFJ+5z0GoolDVkh
         ozSMzZNpLLS6iF8VLL4WIVI2ikEmWVEFdjEmLji3tZD5x60bfzsRhjMWDsGIru2YxAZ+
         1Bhc9poJkYHpmQhicH7ttYqdZ5ZbhfNYwt1JTm/EOGnS95id379vM/i+SUhyHvAfp789
         KKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723953862; x=1724558662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/VR52+ujfglkTTT6y31UeaaSeY0D0R+4tbBAN+k2wU=;
        b=PEAtZsxzBqa3zDAjh6datES1aS8DjEiFMu0VvxmCyXLdNSygbX1jFn63FryQlJvxVA
         r1MIkCQ/hIdi6/LbFPzAUxroODDPdFWHrEmp+fRn9rcVRTGh0Rbh6L+gbOfEOdMj2cKM
         gf1O3PXl2NPfsA91uCgv/IrNfYvXhCpOdY6OlV51U4tqEUIcC5fEaJvumG4BS/gtqfUw
         /79frtNakxJsDNo/6MFRKPt3a022nGa76BvGOlj8tkekjmhg0kvwZ4U/OJZ7+dZoFaER
         GQyUxm+zMk1X3HjrGAbsLlMUVx/trxJP3ZfSyBFhvMYCCuSj4lvB+CbOlpLRUwuTVlKE
         rVqA==
X-Gm-Message-State: AOJu0Yzu7wp5zYpmk5OkltR0p/Hz/UpebpVocUnIJhClsEnkyHGrSDqY
	j69a+cPsP/KIBBA+CXXOuCoQu3GEJMSSBVREulJwjEBdwZK3TBWNs7OW2YoSicQ=
X-Google-Smtp-Source: AGHT+IFWPyD2cbbrNTni4r0xZqVETvzliAualzWMYBVMv8d58iPbBjGuYrvVA7IPTNjyFMYHU/SiuA==
X-Received: by 2002:a17:902:dacc:b0:1fb:7654:4a40 with SMTP id d9443c01a7336-202061eb422mr103814665ad.14.1723953862241;
        Sat, 17 Aug 2024 21:04:22 -0700 (PDT)
Received: from harshads.c.googlers.com.com (27.179.83.34.bc.googleusercontent.com. [34.83.179.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375649sm45138235ad.124.2024.08.17.21.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:04:21 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 7/9] ext4: temporarily elevate commit thread priority
Date: Sun, 18 Aug 2024 04:03:54 +0000
Message-ID: <20240818040356.241684-9-harshadshirwadkar@gmail.com>
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
index 03734c523..4ecb63f95 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2279,10 +2279,12 @@ static inline int ext4_forced_shutdown(struct super_block *sb)
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
index 71cf8dc8a..2fc43b1e2 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1196,6 +1196,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	int subtid = atomic_read(&sbi->s_fc_subtid);
 	int status = EXT4_FC_STATUS_OK, fc_bufs_before = 0;
 	ktime_t start_time, commit_time;
+	int old_ioprio, journal_ioprio;
 
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
 		return jbd2_complete_transaction(journal, commit_tid);
@@ -1203,6 +1204,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	trace_ext4_fc_commit_start(sb, commit_tid);
 
 	start_time = ktime_get();
+	old_ioprio = get_current_ioprio();
 
 restart_fc:
 	ret = jbd2_fc_begin_commit(journal, commit_tid);
@@ -1233,6 +1235,15 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
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
@@ -1247,6 +1258,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	}
 	atomic_inc(&sbi->s_fc_subtid);
 	ret = jbd2_fc_end_commit(journal);
+	set_task_ioprio(current, old_ioprio);
 	/*
 	 * weight the commit time higher than the average time so we
 	 * don't react too strongly to vast changes in the commit time
@@ -1256,6 +1268,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	return ret;
 
 fallback:
+	set_task_ioprio(current, old_ioprio);
 	ret = jbd2_fc_end_commit_fallback(journal);
 	ext4_fc_update_stats(sb, status, 0, 0, commit_tid);
 	return ret;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d37944839..4f38a34b0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1817,7 +1817,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	{}
 };
 
-#define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 
 #define MOPT_SET	0x0001
 #define MOPT_CLEAR	0x0002
@@ -5179,7 +5178,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	/* Set defaults for the variables that will be set during parsing */
 	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
-		ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
+		ctx->journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
 
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
 	sbi->s_sectors_written_start =
@@ -6437,7 +6436,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 			ctx->journal_ioprio =
 				sbi->s_journal->j_task->io_context->ioprio;
 		else
-			ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
+			ctx->journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
 
 	}
 
-- 
2.46.0.184.g6999bdac58-goog


