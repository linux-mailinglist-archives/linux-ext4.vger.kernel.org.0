Return-Path: <linux-ext4+bounces-7246-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D7A88914
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161F718894BC
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A0289362;
	Mon, 14 Apr 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU5bIdin"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FDF288C84
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649690; cv=none; b=RQdhIojO9AQ/KviRXxvfQTod8urWP76hEKU2Oxom+y2zaBTGLeB3RglQI5fGgyRuLH1v8DDJuaj1r5lYiKgPwbYBLqh6Bwb31eOAHcWsQFaX9Tx3koZpT6XiQGNqy5rWi/6WBlDzecP26DDvC2cCYEXR2c1B5A+TIo9Rzj3IX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649690; c=relaxed/simple;
	bh=eqj8OJfYWCfvDEgtLvwu9xLAZDY/nzYzf1/W/ESKM9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5zHj5hkh02Z/z2NtNBrMnCG2chdBavqIeieNNrlVp479DbEcwRLRz6dAVo266IAcSuEbjZwXxROcpXsDA7HaiQND+6JRuL2z7SuSMY4r7nG40C0eS8SWLZ9a1STYS69PaIlQloaoVa+Ups0HxIP83/8laoK6zmxwXS5NML2wzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JU5bIdin; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af52a624283so3760844a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649688; x=1745254488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBlBfltYobYwmlcUzMnuR6oAJU+71mO56obs5dnWrmE=;
        b=JU5bIdinSFkhv8DFp9a+l5/RfP1A0fUDRnQYsr2NAGd8Sv8TdqW47mAXEdYSaJewbE
         bunXXrKy2uemu84PIKfPmuay3VQS35TPzpw1t+e7sWRQdl9n0BuPNpgJ8iD+gJEfC6uX
         H6s7M2k/SLfjwlCuMC2/LyiWUmxX8fAXMK2MvwicILY51sYYjZ0fvNcXRFtEUU2TFS2j
         I+o7C6UlXDN9cETM0nXmOWYYSJn1AJrWTARfJUsIDRENOz0ahtiUgsMnYRUNWxKFsUtH
         dbzB8sZyxDtdmBAVXAv64nfDg1J953btddZwv1Asvtker/fz3ILTFnvjqA6Ha82j8lB4
         DpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649688; x=1745254488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBlBfltYobYwmlcUzMnuR6oAJU+71mO56obs5dnWrmE=;
        b=HG0tGspO4zq/uLkU4TW2vlWUL6uUpnxxlLhJYIoAWxAms+GUZuE4P4SA6vOiH5a97B
         jof0xKcnUPJvlBpchlmbHBxblrxYeEJ/e4t84rBjxse4YG9qmaiF+fwmX4TkkVSIAx5f
         w8PcopvFtdiW2cN008ajMR4Y+eRiyLV8BM7PygTTrOLAwU4yah6w6eeJi1QHfvyesPaa
         Rgk8M1SX63uLAmFBD8/Ob4NcAmn0MsTDF2+QqhKTrtv+F28RlVesX/0Y6l6H36tkHnvo
         9yrmfPQ93KacNrv5AncLiec8xRrU2mdrYhW2Ugid6OixBNnKg0raNv6dHpyxOlMB4Qkm
         4V9g==
X-Gm-Message-State: AOJu0Yxx1JUP4xZqkkFRr+2Ift11q98obBLkZP5pArF9xo9VjPppHtwO
	VFwoq/LDW7vxlpT2e+kJL+f+JT+DKpZtaBMYpj3B54MN+w5WuRP9IoAMVUa3nY4=
X-Gm-Gg: ASbGncvmnM/SbiEKlqiwcxZKQ/Qvrxs40fmM5pdOvjacvFwjqa5VUX2qpYKnWdpWsjq
	tDmozdUHQISro6zWHlyibSNPMqL0G0kAHTZxUTOBvMgdiB8EjQFFKq2R0r9AeQ2j8epTvzxetQo
	WTaEcosgQumiJoFdAAm+/GsnntLpqk8ma5oYEKn3uI9rL1/eA7I4k9tVyRfeTtjqyXl5IjpzgaG
	s63de4DyqIsUEg9Iwmh8nFVv+QXAEAhjZK4fmpvBh9PSqZHAptAFirqL4TcALYhUOmChWkP0Zfh
	kl19xuBRBf7NjYvnc53XFcUuxyjSLjXw6+J8iGMbRYDzkeG2x9Uz4dow9vV6TsmqyY8E+ftJqUN
	6Qzc9NwE0O4C0+lq2prn53SqJNNPIp6JRwQ==
X-Google-Smtp-Source: AGHT+IFJ8shZG7kF658iyyj2uRnSQDNqAxg/4UjAW6516E7cY9HGGqBidpTwdYnrQ9dSV2MIPUh0Pg==
X-Received: by 2002:a17:90b:2586:b0:2fa:1d9f:c80 with SMTP id 98e67ed59e1d1-3084f3d384amr133267a91.17.1744649687606;
        Mon, 14 Apr 2025 09:54:47 -0700 (PDT)
Received: from harshads.c.googlers.com.com (121.61.83.34.bc.googleusercontent.com. [34.83.61.121])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm11543107a91.31.2025.04.14.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:54:46 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 6/9] ext4: update code documentation
Date: Mon, 14 Apr 2025 16:54:13 +0000
Message-ID: <20250414165416.1404856-7-harshadshirwadkar@gmail.com>
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

This patch updates code documentation to reflect the commit path changes
made in this series.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 45 +++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 2b12f5031633..43fcdeb2dac0 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -50,19 +50,24 @@
  * that need to be committed during a fast commit in another in memory queue of
  * inodes. During the commit operation, we commit in the following order:
  *
- * [1] Lock inodes for any further data updates by setting COMMITTING state
- * [2] Submit data buffers of all the inodes
- * [3] Wait for [2] to complete
- * [4] Commit all the directory entry updates in the fast commit space
- * [5] Commit all the changed inode structures
- * [6] Write tail tag (this tag ensures the atomicity, please read the following
+ * [1] Lock the journal by calling jbd2_journal_lock_updates. This ensures that
+ *     all the exsiting handles finish and no new handles can start.
+ * [2] Mark all the fast commit eligible inodes as undergoing fast commit
+ *     by setting "EXT4_STATE_FC_COMMITTING" state.
+ * [3] Unlock the journal by calling jbd2_journal_unlock_updates. This allows
+ *     starting of new handles. If new handles try to start an update on
+ *     any of the inodes that are being committed, ext4_fc_track_inode()
+ *     will block until those inodes have finished the fast commit.
+ * [4] Submit data buffers of all the committing inodes.
+ * [5] Wait for [4] to complete.
+ * [6] Commit all the directory entry updates in the fast commit space.
+ * [7] Commit all the changed inodes in the fast commit space and clear
+ *     "EXT4_STATE_FC_COMMITTING" for these inodes.
+ * [8] Write tail tag (this tag ensures the atomicity, please read the following
  *     section for more details).
- * [7] Wait for [4], [5] and [6] to complete.
  *
- * All the inode updates must call ext4_fc_start_update() before starting an
- * update. If such an ongoing update is present, fast commit waits for it to
- * complete. The completion of such an update is marked by
- * ext4_fc_stop_update().
+ * All the inode updates must be enclosed within jbd2_jounrnal_start()
+ * and jbd2_journal_stop() similar to JBD2 journaling.
  *
  * Fast Commit Ineligibility
  * -------------------------
@@ -143,6 +148,13 @@
  * similarly. Thus, by converting a non-idempotent procedure into a series of
  * idempotent outcomes, fast commits ensured idempotence during the replay.
  *
+ * Locking
+ * -------
+ * sbi->s_fc_lock protects the fast commit inodes queue and the fast commit
+ * dentry queue. ei->i_fc_lock protects the fast commit related info in a given
+ * inode. Most of the code avoids acquiring both the locks, but if one must do
+ * that then sbi->s_fc_lock must be acquired before ei->i_fc_lock.
+ *
  * TODOs
  * -----
  *
@@ -157,13 +169,12 @@
  *    fast commit recovery even if that area is invalidated by later full
  *    commits.
  *
- * 1) Fast commit's commit path locks the entire file system during fast
- *    commit. This has significant performance penalty. Instead of that, we
- *    should use ext4_fc_start/stop_update functions to start inode level
- *    updates from ext4_journal_start/stop. Once we do that we can drop file
- *    system locking during commit path.
+ * 1) Handle more ineligible cases.
  *
- * 2) Handle more ineligible cases.
+ * 2) Change ext4_fc_commit() to lookup logical to physical mapping using extent
+ *    status tree. This would get rid of the need to call ext4_fc_track_inode()
+ *    before acquiring i_data_sem. To do that we would need to ensure that
+ *    modified extents from the extent status tree are not evicted from memory.
  */
 
 #include <trace/events/ext4.h>
-- 
2.49.0.604.gff1f9ca942-goog


