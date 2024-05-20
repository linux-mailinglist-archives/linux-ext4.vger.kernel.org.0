Return-Path: <linux-ext4+bounces-2587-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7D88C98D6
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 07:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08741C20FE1
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 05:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220F218B04;
	Mon, 20 May 2024 05:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT64h3eQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9417991
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716184334; cv=none; b=A/6cxcXeP4NObtfMbdlYoHoL9J82LSMjTDW1Vpvzc5OfESUzSqu4rbcxHRNy0kVeL/nWbMRNIQAKWE6ILfLHmLuJuCnYSz/tUC4wfOB2KYaxx+UPBiLwd1+QCTp+IG4Zas4vO5VDRv+C0afddPD4bphcrZvP5Dvgx2xueuLbUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716184334; c=relaxed/simple;
	bh=yqRZcJ4QySt16+6qjKphuF7uJUSI8KSl3CF4pm4bSiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzezVl3ZEQ8/Ck7Z3L9zo3FzoOLFFxsDMkXBouZCPNlECTst5487nN8akEefkHVcv3FtTQ6okwE24aU7M2XPHymllfDtZbVHmt1xOPUbgPFrJ7H4LRL9Dkg446t6G2F6burO0zHQb/A5DJaFZueTw1P7zgWQ95XFVBleFhtIOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT64h3eQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso2180411b3a.1
        for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 22:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716184332; x=1716789132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LQ8lGx4oThN64uBR0ntJfLBa4nMIwHD0Wtq3LPmiMg=;
        b=VT64h3eQQJtarUXet6TpG+KO4z+ZEG63YzBS+EzAFOY8T0WvgMByj89cDB8Zx29SUR
         RKH+PawtjUNwPQu9eiX16/4Bev9IEeFRDDpdE/kIpR9Kv8ZQ3L9tAMNEJdWCwYDwdO41
         v2BdytV/0Sk8KQJmK0KubwB7To5tZ9IHj+DmR5WQq/RDo2WNIzYBh7N+zh/3bGm93I+e
         Ieg5Z4uCswc5t1nQuDSJEMyYMlHIi/MNy87Y4NHjMSC/7SGG1l9/mCc66BXWZC7KZV0q
         dD/0G0wm39pY73mSNZGBegJ+1ac14PnmZSxTMuki8DXP7FsJOmFDG775goQaGJoPtQfe
         fmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716184332; x=1716789132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LQ8lGx4oThN64uBR0ntJfLBa4nMIwHD0Wtq3LPmiMg=;
        b=mTzSbBJMJO9v/ZaY8qaHoGWHE25r+mt2Nvlg3aWDFrHJ/cZYE8g5dyEciS32enBTDH
         2Re2GJfiZv6qsIVvZhne16tQVTylPQR40Ahf1azBP9c4x7kUI74FecADExwpCfWIp6aU
         cbX2NCdArQ0+IuirG7Cw+rWOBNmpAIlYQYKqrSw1lZIpBIes5StQuFi0CtVZ7pwFxA/V
         4nqgbkPlPbLeflTn0EsXXjYiyDrdbT9TWIWyM+XrGOrl/kzy9d8pKqgv+vbVbJ7k5Iov
         VU0vvuhGncNnjJKnCYjBbMPjJI7vvFST1KDHc2DRmx5i6KFyz/bdw94VTW+qI5ShRno2
         Miig==
X-Gm-Message-State: AOJu0YwtMKlGf42T3ambWXpqEt8pzKnDDaT/6w+E/DJbzm0bRYP2174G
	jyuLzaq11fDva66zecf5ulGOIQbroVXCWpaCN61c1vIaFcSYTbt4tz0nHg1o
X-Google-Smtp-Source: AGHT+IE2RyS+uaHRR0l46jxG4keJWQukKHMLguwfEWSg6C30Rkb3+llMFAGvPJLpv1w+hXWVK6kBQA==
X-Received: by 2002:a05:6a00:398d:b0:6ea:dfc1:b86 with SMTP id d2e1a72fcca58-6f69fc15becmr7041103b3a.12.1716184332185;
        Sun, 19 May 2024 22:52:12 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-659f66bf18csm6769297a12.46.2024.05.19.22.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 22:52:11 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 06/10] ext4: update code documentation
Date: Mon, 20 May 2024 05:51:49 +0000
Message-ID: <20240520055153.136091-7-harshadshirwadkar@gmail.com>
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

This patch updates code documentation to reflect the commit path changes
made in this series.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index ecbbcaf78598..b81b0292aa59 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -49,14 +49,21 @@
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
  * All the inode updates must call ext4_fc_start_update() before starting an
  * update. If such an ongoing update is present, fast commit waits for it to
@@ -142,6 +149,13 @@
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
@@ -156,13 +170,12 @@
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
2.45.0.rc1.225.g2a3ae87e7f-goog


