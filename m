Return-Path: <linux-ext4+bounces-7240-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC7FA8890D
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB453A5913
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB3D288C82;
	Mon, 14 Apr 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go5tR1p9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF9B24728A
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649686; cv=none; b=ngkeIyEgZb1hfMZlICVyQWdlosDCa+hYM6hNi7Ns8Q/t5oqwqrbFW5KsIxs+QAxrEHczfNa308I31MeVXLUIRuuhpNqZYxNn22lhc7o8lq0LTA/GhOJ+LCcGCcoyyQCxan7OQ2wfDWgrujgGpzeNymg+1pTLg+nrH6F2SwrHAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649686; c=relaxed/simple;
	bh=UCX8mEkg4RG3sdF/33JjS8PQ8TtAg39byvLsENDQ5xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8IMEasPGIYbYKhZig9pI/olNQeh5f0kxjlqCDv5WayvWB9CcDNkKJhW2xNSpXmA5SUTEmjwWHsVpibXLyrQ3k8dhol9vHqTqLGFkREdRoga1Wv4u5k28pZ6dgjs0n5LsujwADkLqmJ7n5XcKc8KFyihLAiU/FNBKOxC67Pb8Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go5tR1p9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fd89d036so55609445ad.1
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649683; x=1745254483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8rXiehGCT09EjGEuXsiQa44/2MmUPmeTYdWZDLUkdXo=;
        b=Go5tR1p9XCaCmPsqDljsjANw+gwmf2qCkgdr4GRISMYxNoRqjRMC4WsCQB/SH8vUSt
         bgai5u6MJ67N0Zc/AAxEguuevgDzafQJS27w8/1kqDQ6DFNQhKzrbz/hPHLcr5k6kJK1
         qytDttXRLnrTXFguwoJKVcAiJpRGsrBRQEMk8NF33/gklydCkky5MUBPyDg/p86yt1U7
         WkS4I+ucHpydtIsD0z9m0Qs1KgLjFTEYOM/Jjt6iwx0j5a1NfhlUvnzRDdRApgJ1jchb
         BmPouVycsYJSZvpaaSabTC/I+Nx0Ql1prkjzpkTDboWaJObWlagFtH4l1zXM7gkw+RjP
         sraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649683; x=1745254483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rXiehGCT09EjGEuXsiQa44/2MmUPmeTYdWZDLUkdXo=;
        b=N+oV5MtbMSlB99YdmxMCJjP/QzJe4/JTGk3Gv82OYzZYSpnpxDC3jcwSJquWWuM0Ws
         aJueRLHwEpI3FULpftVapheT777g1PC610sz1uhGrkArxlScpwOnFx9uAEM/kXxIKlxP
         j2H5Y3DB9yd3bqgpnjFbxxKFWcSSs5ZmpLljDr0ySs5kIcqbhSt0wXSVskxVrlG2/h//
         FAYh7+YrsR/aOp4yo73agu2p0hphk0mRejaFilygIoR/+tvQcLcebOurj5Mf8FvuRk/R
         mMjOQncMhtSB78sQDu0sMCf4CEZAFJQ92i8oYoDPdnCL8+V4kv3GXeJ34dgMNc7dwjpe
         KiXg==
X-Gm-Message-State: AOJu0YyJycsoybnUDripnriGBiu47ZGn6zKgK6i9jyg+O8tWv5pUwZJf
	ebfb8Z7rDh7ZFBV+VP+MGgSuAkPKu3aUMH1moWnLxeU/9RiQffbqxTj953kN
X-Gm-Gg: ASbGncvPDC02BBD1VtAloa3tmtX0FP3TfCOZzqbRmAq7/1yGY1fHM2geAo6+IzB9pSz
	R5h6uWJlnitdvrZNBQ/9AEGjSFLWfU5bTgXhaX3F+lNnaKbLUCnwvXNNldNliMQKMxqzrTxoJmT
	DHjFQ+dibhiGzOvFWtbwxXnaCZ9KL2MSTihvMJGm/D/6nv4gS5M+8BRGLuGq+lTbWFDrJx8Qa2F
	tZiuSgnb83Ci3YrHemB1j15JOkwFppZFXvYp7ee2Qh0qPVwPXS6QPp5gOrVRNhBd01GZPmD/ABr
	WLhKJIRRVDR0KEpyQy+oLq5RkWyLLUu+EIZxagZTd3Nsx300drr/l6Hc8XjeF0Sc2q71rAQ28ty
	31/aqmRIuSLsjUGADPCM+dN6pzFJlzfgLPQ==
X-Google-Smtp-Source: AGHT+IGgtnk/QafBwOdPk0QoOYlq2JkkrHZ4hYZFxutNLZCehzYBYksFNmBKmXWEEEPMip2VEUz6VA==
X-Received: by 2002:a17:902:c945:b0:21f:4c8b:c514 with SMTP id d9443c01a7336-22bea5027ecmr164408755ad.45.1744649683404;
        Mon, 14 Apr 2025 09:54:43 -0700 (PDT)
Received: from harshads.c.googlers.com.com (121.61.83.34.bc.googleusercontent.com. [34.83.61.121])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm11543107a91.31.2025.04.14.09.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:54:42 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 0/9] Ext4 Fast Commit Performance Patchset
Date: Mon, 14 Apr 2025 16:54:07 +0000
Message-ID: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V8 Cover Letter
---------------

This is the V8 of the patch series. This patch series contains fixes to
review comments by Jan Kara (<jack@suse.cz>). The main changes are as
follows:

- sbi->s_fc_lock is now a mutex type, and it is not released during
  commit path. This gets rid of a number of soft lockups due to race
  with ext4_fc_del().

- I have dropped "ext4: make fast commit ineligible on
  ext4_reserve_inode_write failure" patch.

- I have split "ext4: hold s_fc_lock while during fast commit" into
  two patches: "ext4: convert s_fc_lock to mutex type" and "ext4: hold
  s_fc_lock while during fast commit" to make reviewing easy.

V7 Cover Letter
---------------

This is the V7 of the patch series. This patch series contains fixes to
review comments by Jan Kara (<jack@suse.cz>). The main changes are as
follows:

- As discussed in V6 review, I have dropped "ext4: add nolock mode to
  ext4_map_blocks()" patch given that we now ensure that i_data_sem is
  always grabbed before ext4_mark_inode_dirty() is called.

- I have also dropped "ext4: introduce selective flushing in fast commit"
  given that correctly implementing that would require more changes, and I
  think they would be best done outside of this series.

- I added "ext4: introduce selective flushing in fast commit" as the last
  patch in the series. While testing log group tests I found a few failures
  which get fixed due to this patch.

V6 Cover Letter
---------------

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

Harshad Shirwadkar (9):
  ext4: convert i_fc_lock to spinlock
  ext4: for committing inode, make ext4_fc_track_inode wait
  ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
  ext4: rework fast commit commit path
  ext4: drop i_fc_updates from inode fc info
  ext4: update code documentation
  ext4: temporarily elevate commit thread priority
  ext4: convert s_fc_lock to mutex type
  ext4: hold s_fc_lock while during fast commit

 fs/ext4/ext4.h        |  18 +--
 fs/ext4/fast_commit.c | 365 ++++++++++++++++++++----------------------
 fs/ext4/inline.c      |   1 +
 fs/ext4/inode.c       |  12 +-
 fs/ext4/super.c       |   9 +-
 fs/jbd2/journal.c     |   2 -
 6 files changed, 201 insertions(+), 206 deletions(-)

-- 
2.49.0.604.gff1f9ca942-goog


