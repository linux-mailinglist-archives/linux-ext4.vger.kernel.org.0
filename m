Return-Path: <linux-ext4+bounces-2582-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF838C98D1
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 07:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2706D1F21742
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 05:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F72C171A4;
	Mon, 20 May 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY/l6/yt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799E7492
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716184332; cv=none; b=dc3XkMC2ZdppE3F6EQvNQbzZukuIQesrTqmFrn9q9f1aqkmPqh/Zv++OLnd8sVMKVSnNnl8K0qnI4N6crWeh8NQJgeYhJvtBnClZd2pgxkefkzaIQW5o8msONHEiPpztwITsUHiNLj9jk1mq8hVMRMUICMerDa9rj9eV99vbNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716184332; c=relaxed/simple;
	bh=JCFBvay7bydKk7vYfZinhntpkdgeAbK4JRHLCocrCjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERZEgy7c17rUUWdbZ+DDr/jDzq1ui42/QdndEbZ5y0nJF+7vOSeU+NhI1pe8J5hyZfymrSsbYNv3KgG69kCrO8+rownrD66S+sNftHjKEsIF9cJ1tgnTKeBL2LGTgomh/mHCFRvmSnuKW1FttMbrlQeE2SUihUtUzzE0cVTeYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY/l6/yt; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b5348be826so41021eaf.0
        for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 22:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716184329; x=1716789129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WpqZcIE7qMS7zONbRDz/FnlxW/UmXTHI5seeFBz/H4A=;
        b=LY/l6/ytP85VtjmciL+UYjlAnsc7jnbUJA1vHJ7IXrn6Zxaop37vpjoZOb7xy+6N5d
         uQG381y1+HM33LXpaNTSi5kniDoGNTMCKh/R9tLeMWq1nRcd722rKHY41Y9VkhT3bSC/
         kDuOzXUC6IYSSzFhG4OhF+H6NSerkwxz6DedmHzYWelMn1dMkHj/zs4Xn+AJIHqaW7D9
         6CRaWhfHSTxv3qi21uo4BHpsARRiAvbZfqrAX8E6SHAuU7srPQCm+/qH2rRwKtIU2qEM
         kQzcds1aAoB4yo2O1bKFdYy9N3c8folczguCt/ZbtiDopVWsYR5sCXpEoDbqYcbQX9Tk
         zoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716184329; x=1716789129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpqZcIE7qMS7zONbRDz/FnlxW/UmXTHI5seeFBz/H4A=;
        b=vI4Db3ZoP/BlEAqdSoOnPC5snWVt/umkXwQKZCgS0Ir/kdEp+QAWgGUKm//ZD4yU5c
         1jES2Kha/LzAxXP8ynZP3Mk7AK+4fWfxJwbPUTM8qCF86XCiFzSC0dwZQzJqsTnWBqNw
         0h2xmGGllJ2l6b7QYXsYMNDBniER4Bsj8dPSal+9LujJEwTyIniPmCZZU1iBpEr+3/l/
         FoJi/nJLxRcHePq3xaFrAg6rYXKc5Btc2v7Q8kYhHj1tTbs+ejRJXpni4gnpfYBVQHZF
         SxTUNzlvwOBreFV4VyN0wrfaU4fPAM66ZJmRj6OkQJyN4SFyuR3CeulmoeOXlX+tvwZO
         bOfA==
X-Gm-Message-State: AOJu0YzXeR/lFl9YHk4hNDvTtBLP+U9iiGU0rq2Ros5qhWuQPcqUc2IZ
	HI+t5knPhhGXvB+4h4bv2+Cu2pEv37IlHBg7FuEGU4F0ER4nsNuV5ECqw0uP
X-Google-Smtp-Source: AGHT+IFWG9NoWX7SDXjTSkr+tzAE4mWJJLxXiGcTYi3B2BLCatVgBIa7smh6g9vzpTvE/TITQetrNQ==
X-Received: by 2002:a05:6358:63a8:b0:186:c06f:437a with SMTP id e5c5f4694b2df-193bd007addmr2835205655d.28.1716184329156;
        Sun, 19 May 2024 22:52:09 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-659f66bf18csm6769297a12.46.2024.05.19.22.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 22:52:08 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 00/10] Ext4 fast commit performance patch series
Date: Mon, 20 May 2024 05:51:43 +0000
Message-ID: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the V5 of the patch series. This patch series supersedes the patch
series "ext4: remove journal barrier during fast commit" sent in July 2022[1].
Except following three patches all the other patches are newly introduced in
this series.

* ext4: convert i_fc_lock to spinlock
* ext4: for committing inode, make ext4_fc_track_inode wait
* ext4: drop i_fc_updates from inode fc info

This patchset does not introduce any on-disk format and / or user visible API
change. This patchset reworks fast commit commit path improve overall
performance of the commit path. Following optimizations have been added in this
series:

* Avoid having to lock the journal throughout the fast commit.
* Remove tracking of open handles per inode.
* Avoid issuing cache flushes when fast commits are contained within a single
  FUA writes and there is no data that needs flushing.
* Temporarily lift committing thread's priority to match that of the journal
  thread to reduce scheduling delays.

With the changes introduced in this patch series, now the commit path for fast
commits is as follows:

1. Lock the journal by calling jbd2_journal_lock_updates_no_rsv(). This ensures
   that all the exsiting handles finish and no new handles can start.
2. Mark all the fast commit eligible inodes as undergoing fast commit
   by setting "EXT4_STATE_FC_COMMITTING" state.
3. Unlock the journal by calling jbd2_journal_unlock_updates. This allows
   starting of new handles. If new handles try to start an update on any of the
   inodes that are being committed, ext4_fc_track_inode() will block until
   those inodes have finished the fast commit.
4. Submit data buffers of all the committing inodes.
5. Wait for [4] to complete.
6. Commit all the directory entry updates in the fast commit space.
7. Commit all the changed inodes in the fast commit space and clear
   "EXT4_STATE_FC_COMMITTING" for all the inodes.
8. Write tail tag to ensure atomicity of commits.

(The above flow has been documented in the code as well)

I verified that the patch series introduces no regressions in "log" groups when
"fast_commit" feature is enabled.

Also, we have a paper on fast commits in USENIX ATC 2024 this year which should
become available on the website[2] in a few months.

[1] https://lwn.net/Articles/902022/
[2] https://www.usenix.org/conference/atc24

Harshad Shirwadkar (10):
  ext4: convert i_fc_lock to spinlock
  ext4: for committing inode, make ext4_fc_track_inode wait
  ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
  ext4: rework fast commit commit path
  ext4: drop i_fc_updates from inode fc info
  ext4: update code documentation
  ext4: add nolock mode to ext4_map_blocks()
  ext4: introduce selective flushing in fast commit
  ext4: temporarily elevate commit thread priority
  ext4: make fast commit ineligible on ext4_reserve_inode_write failure

 fs/ext4/ext4.h              |  29 ++--
 fs/ext4/ext4_jbd2.h         |  20 +--
 fs/ext4/fast_commit.c       | 279 ++++++++++++++++++++----------------
 fs/ext4/fast_commit.h       |   1 +
 fs/ext4/inline.c            |   3 +
 fs/ext4/inode.c             |  53 ++++---
 fs/ext4/super.c             |   7 +-
 fs/jbd2/journal.c           |   2 -
 fs/jbd2/transaction.c       |  41 ++++--
 include/linux/jbd2.h        |   1 +
 include/trace/events/ext4.h |   7 +-
 11 files changed, 265 insertions(+), 178 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


