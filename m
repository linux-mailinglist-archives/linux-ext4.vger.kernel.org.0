Return-Path: <linux-ext4+bounces-2682-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBE38D29D8
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E65A2854D0
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AE115A841;
	Wed, 29 May 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a45gZIr/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37E2632
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 01:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945637; cv=none; b=DeswJ9a7X6uPs8HV7mPT59+tqu0JjYJvvlcvWwf+voin96cxnNG/exry+mX72rMC754lvzXmzuurM3GthzBPM39FPpN2vJUzx0D+1r2cJCJdyhcJ7FQFkwccvC8n7M1sZlas1j6niyBGPH9Az41+j3VttjsF3UBha/m0xB0rFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945637; c=relaxed/simple;
	bh=J20aVC0w9+BwOU4lnnSRBJwOCwwjn23xuRtD0lZg+0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpJxG/bfq0pQc1TQeyvgDXTVugmT+fEyOYBUhalls/xl0hCOKjEp0xIFCZfZeRPmxTgZKWQKsACIq45ULMehnF7nEdsVslGeOo7Ez+aFGas6yT9xL6exOa45z03MbURRn8mcj69NINW+Qlym/TIrxmGWzVhcdzClgntCZEah8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a45gZIr/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-60585faa69fso295639a12.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 18:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716945635; x=1717550435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AwIBnrmCIBDa1NWPrCHiwTjhMfqdU/b41bTalUVO3tE=;
        b=a45gZIr/SNkzCIFdomIi+iJDR9w6tCYkBZa4ngr5R8ZGsphFyOR9YluvnkUEToVp3J
         JgXmskmlDKuizSfbqQeEFeBwmuXoPRO1xnQ6TX0Fci36sxe24H3p6OMWQNqR1MMxp0zJ
         Lth4TyjMoLUVLpIbgvtz1WFXmnlvobVJF8T4y7uKyPIno/BoBEa8VB841eJlTWTzU+s+
         U6EY514dQlO/Y1TUKxEPicev5tiCRlT82xIdykAg6CikW6xiAZ01n9ZEzNkDDjNrmiD/
         Q0mngbH2TTGHrOqjkpG/JkD1dtGSEgLdIJD7y/jfZPhCibADTwwQ4rnehWz15pv6Zkwh
         Wttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945635; x=1717550435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwIBnrmCIBDa1NWPrCHiwTjhMfqdU/b41bTalUVO3tE=;
        b=skhsQfStEa67Xbn7Z0ObLOKlyab32oVg6EXmhoQCXHVUwD3mHeIa0VuEQUikTyudIT
         d90uoF6dskIOj7tITu7wSazVg5pWg1dKfHfRilO5uObj6jMkvoOdbU9T9meNedpAxoh1
         vXu3MsGIk75jwP6n4d+TWFonP3Y0QAvXAfWjMlMYHYpM+6rZxCQBPmNrGkLBwT4h1tqA
         c8JmH+c530HxNZGEcQUIXFcxlHnT7YoNElxKshbRuFn6DHHGLgUBDzOjCc00o5eGdr+E
         0gBRSIFLQEavCB5qKMG0hjOUOCP2Jh0An1SzNXfQMbkG4ALk9U7IYWoOxQIeNm1kbJmV
         ukGA==
X-Gm-Message-State: AOJu0YzfD4HsnmbLmzBX/0NOPWmA8VhX/qDVki+6qq5kLI8ZZIusfa4J
	qW/RxPG+Uk4bDT7AmThdY1YN2P5bi2Ly5OYsZUY9Z2w+ShLe0mYbMLQ3nIi5
X-Google-Smtp-Source: AGHT+IGL1WtPIzQ3kwp5j3nP9WAL+RfT+hlU7FvhDGNRaGpyeRr4lO2LUbumHu4GftSEXQMKkgSpqA==
X-Received: by 2002:a17:90a:e2cb:b0:2c0:d4d:837 with SMTP id 98e67ed59e1d1-2c02ebdb08amr1020593a91.12.1716945634698;
        Tue, 28 May 2024 18:20:34 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm10139388a91.53.2024.05.28.18.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:20:34 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 00/10] Ext4 fast commit performance patch series
Date: Wed, 29 May 2024 01:19:53 +0000
Message-ID: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the V6 of the patch series. This patch series contains fixes to a
bunch of kernel build warnings reported by Kernel Test Robot
(lkp@intel.com) and Dan Carpenter (dan.carpenter@linaro.org). Thank you!

V5 Cover Letter
---------------

This patch series supersedes the patch series "ext4: remove journal barrier
during fast commit" sent in July 2022[1].  Except following three patches
all the other patches are newly introduced in this series.

* ext4: convert i_fc_lock to spinlock
* ext4: for committing inode, make ext4_fc_track_inode wait
* ext4: drop i_fc_updates from inode fc info

This patchset does not introduce any on-disk format and / or user visible
API change. This patchset reworks fast-commit's commit path improve overall
performance of the commit path. Following optimizations have been added in
this series:

* Avoid having to lock the journal throughout the fast commit.
* Remove tracking of open handles per inode.
* Avoid issuing cache flushes when fast commits are contained within a
  single FUA writes and there is no data that needs flushing.
* Temporarily lift committing thread's priority to match that of the
  journal thread to reduce scheduling delays.

With the changes introduced in this patch series, now the commit path for
fast commits is as follows:

1. Lock the journal by calling jbd2_journal_lock_updates_no_rsv(). This
   ensures that all the exsiting handles finish and no new handles can
   start.
2. Mark all the fast commit eligible inodes as undergoing fast commit by
   setting "EXT4_STATE_FC_COMMITTING" state.
3. Unlock the journal by calling jbd2_journal_unlock_updates. This allows
   starting of new handles. If new handles try to start an update on any of
   the inodes that are being committed, ext4_fc_track_inode() will block
   until those inodes have finished the fast commit.
4. Submit data buffers of all the committing inodes.
5. Wait for [4] to complete.
6. Commit all the directory entry updates in the fast commit space.
7. Commit all the changed inodes in the fast commit space and clear
   "EXT4_STATE_FC_COMMITTING" for all the inodes.
8. Write tail tag to ensure atomicity of commits.

(The above flow has been documented in the code as well)

I verified that the patch series introduces no regressions in "log" groups
when "fast_commit" feature is enabled.

Also, we have a paper on fast commits in USENIX ATC 2024 this year which
should become available on the website[2] in a few months.

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
 fs/ext4/inode.c             |  52 +++++--
 fs/ext4/super.c             |   7 +-
 fs/jbd2/journal.c           |   3 +-
 fs/jbd2/transaction.c       |  41 ++++--
 include/linux/jbd2.h        |   1 +
 include/trace/events/ext4.h |   7 +-
 11 files changed, 266 insertions(+), 177 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


