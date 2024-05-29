Return-Path: <linux-ext4+bounces-2691-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79068D29E2
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01EFB209EC
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA04B15ADA8;
	Wed, 29 May 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXNkQt7l"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50E2B9A9
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945651; cv=none; b=bEBlP98tyb1zCV42bNOFxkuKmAowzHMrXafmyLD2h2+f3wzaXpK9P9bhKbgla2VTFq5cIjUzS9M7N9oTQ1eoeqRvAKqv8ztqL+9BRe8nxiWyC4P0OehHOdj5ZCYGihZTf4yVrE/Iwh1w0RqcYUSyPE5t5T4YAVx8PWtLF16R8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945651; c=relaxed/simple;
	bh=xh2TQYl+ZvamQoGDbFVmHEXtnnu9utvOxnTPrySxZ8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXGxBD9Wx1HWVEYYri7xWymD09qu2Dv1VfSz+LXHJsq+hdyZgZnXNLSPFtlwLzqRo/VNclWZhsbWmstuALrFJyePUrdjYV99gioYaLTVivaTnpPReImpAtJBAYJioXOIAerxYfmSsiGn3D/oPKOvpfA8bm3hSBnNQYASFNcBzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXNkQt7l; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2bf59381a11so1333121a91.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 18:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716945649; x=1717550449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQK6pvOzGFoN+zAtNDhFm96sqdDQj9t0TKCt5gMtB/M=;
        b=mXNkQt7l0565LC8wVVBm3GSPyCV8qEPgklDKNOv8TQRe2OBCebEzCq7gRZ3gsM0c5d
         9Hl0iHi3k6SeNtmuQdGEWJrHJNj5ZaEf5mCit5/OXSzkiBRNyRyUzlnt88m1nvHuDWtq
         Q6rIO2n97WPH1H5sXwKcDcSE1ozyHooumNhdkURknu3d6FFmOFDxJmlrJbFuTcIEiHUq
         6tdXnkuFx4l/04Djzokzw6lv+Avf9qsgB7FP/fJDwtV1wbJyEpHTNh2c1YFgYLwNh3Qb
         kyIi8mByTYvA2NMPTiwonDfzceVtwSm6yFl51kY50rsfXWUCydGUv1Be337bc+k/2KKp
         p9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945649; x=1717550449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQK6pvOzGFoN+zAtNDhFm96sqdDQj9t0TKCt5gMtB/M=;
        b=D8zJCsEoHCFqOteNwV3o+j/o4BtjbjT4ocpXIZFy6PAXmbq0Clrt3JWK+AfVrTV/eq
         Vufd+icNBT55PdbWbfq6D8Le8R4JqecZxsyj6++0EsP+P5D+NIGlF17jD6FsOfyhe+1D
         4jSKz4odCMO98z4AHF/5h/wUKSqCSBh1mcafTqd5E5CdXANYkg1BKzZDYYB/k07ba4CQ
         bEhpH8M2hndMAxHBseD3ph6DlSUFltOX5tGlHpsHCPgWLaAfSDM9Rg1u+et/XsIGKjhF
         uW13tI7fKY1U4FwMwAcg3pEH+ZFj6IopGjeSglBnt2fFAZQ5KqohQDNItEy105wWBNrj
         fPTQ==
X-Gm-Message-State: AOJu0YwuQUE+UGuUaIZKCxer9flFGbK6bhvMh7QvOqdQp3biZG7nVKpE
	L3cLqfP3eq9vCOq6UCPnb9EblNEs9AR6FLTZ8I0745ZmCFVQ+dHBdxzd/tw9
X-Google-Smtp-Source: AGHT+IFqTeKMoaliqHpkPPpDvA55l2n0oow3vYOM4/KE8lKBk2jD4sdeAEZrFR54nYxYiKfD4SrXjQ==
X-Received: by 2002:a17:90a:1fc9:b0:2bd:f45e:6105 with SMTP id 98e67ed59e1d1-2bf5ee1be4cmr12821325a91.22.1716945648869;
        Tue, 28 May 2024 18:20:48 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm10139388a91.53.2024.05.28.18.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:20:48 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 09/10] ext4: temporarily elevate commit thread priority
Date: Wed, 29 May 2024 01:20:02 +0000
Message-ID: <20240529012003.4006535-10-harshadshirwadkar@gmail.com>
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
index 35c89bee452c..55a13d3ff681 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1205,6 +1205,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	int subtid = atomic_read(&sbi->s_fc_subtid);
 	int status = EXT4_FC_STATUS_OK, fc_bufs_before = 0;
 	ktime_t start_time, commit_time;
+	int old_ioprio, journal_ioprio;
 
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
 		return jbd2_complete_transaction(journal, commit_tid);
@@ -1212,6 +1213,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	trace_ext4_fc_commit_start(sb, commit_tid);
 
 	start_time = ktime_get();
+	old_ioprio = get_current_ioprio();
 
 restart_fc:
 	ret = jbd2_fc_begin_commit(journal, commit_tid);
@@ -1242,6 +1244,15 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
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
2.45.1.288.g0e0cd299f1-goog


