Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029812A8DD2
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgKFD7Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgKFD7Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:24 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E9EC0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:23 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id u4so2919864pgr.9
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCWIa7JEgLYXE81QgpGVq/fEhI9GF+vpk8OrMh/gzUo=;
        b=QGc2tFQOM1F9jKWxx64Pd9H8H+RjOePqiQ/cECiVtk79MtlWY4b/1Hs71qGmmXkwxi
         dv7HrW4twy60Tuo0j68t5hCoVwBSSM/2CE9+UrPQX2sZ6r62Mi1dc53w7LtKLeBNJpFL
         sxOp31S49tTyXwOhooF3BCYaFxx6iq+5CvljkF8vXB+D8tnaSY/OrCeDzwsMCyjlllkx
         g81ojwmjRFbCp67rjc0R+IlAO65Y5kPxXhOOlgkZreT6AFHBrjK9rhOjXmFlkTmYKA/c
         LHHQs8ymNSwlR3EYGb7t5D4ew/1Pj2B4L5CByQ8Gi0Ps8SULE0Xok3EFAW40+DC3GzHA
         dU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCWIa7JEgLYXE81QgpGVq/fEhI9GF+vpk8OrMh/gzUo=;
        b=f/5b9Y4NDFHsusc8ATYVHnqXSYQSI77rGidBKG/67ubNB8egQ0MjKW2Q5o8Vxg8Kmu
         WBGCKfbam1SCvvkVrkTmhnasNJzgA6rdYXP9JkSDauJMLJgGDTAM6a5lal43cHgf45Dy
         GsE/3MBxeBzwKhpsf6zvzz0CXHUviu/LqKlUY4oCrReITNk98MSbsXxCuulYHjY1R+ab
         EhSgoZpmq+kQmL+NnqHUx+Uwwe0X07co1xwJM11F4HtS2woNRjD5k1cIaGxJ74abuwRL
         PeBqbjLbqvUoxDfmnCNDiw7kFw/J+B7sc9gLTFO0JnLW6nW+fu2+6MXZLpTZdTXypTyR
         MQ8g==
X-Gm-Message-State: AOAM531kibfMEViK77pvrUGLtlZ8j6v1+VKlp+JM1Ujregk9FXrCWjRB
        sdnEgSZmlJ2KSpaPMQBlnRzcdO6hwZA=
X-Google-Smtp-Source: ABdhPJynPddMM4TaodzwdpGAD9g9RRzSKauAztqLj8IHEsPCDk+ibxVjr1wrBfb48zCcVRDgoVi4Zg==
X-Received: by 2002:a63:b03:: with SMTP id 3mr59039pgl.416.1604635162167;
        Thu, 05 Nov 2020 19:59:22 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:21 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 00/22] ext4 fast commit fixes
Date:   Thu,  5 Nov 2020 19:58:49 -0800
Message-Id: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4: fast commit fixes

This patch series adds several code-only (no on disk format changes)
fixes for the fast commit code. I verified that there were no
regressions introduced by this patch series in xfstests auto and log
groups in fast_commit and 4k configurations.

Changes since V1:

- Broke couple of misc patches into separate patches
- Added a few new fixes:
   - atomic update of mount flags
   - no fast commits on aborted journal
   - Dropped confusing fast commit mount options
- Dropped jbd2_fc_init()

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Harshad Shirwadkar (22):
  ext4: describe fast_commit feature flags
  ext4: mark fc ineligible if inode gets evictied due to mem pressure
  ext4: drop redundant calls ext4_fc_track_range
  ext4: fixup ext4_fc_track_* functions' signature
  jbd2: rename j_maxlen to j_total_len and add jbd2_journal_max_txn_bufs
  ext4: clean up the JBD2 API that initializes fast commits
  jbd2: drop jbd2_fc_init documentation
  jbd2: don't use state lock during commit path
  jbd2: don't pass tid to jbd2_fc_end_commit_fallback()
  jbd2: add todo for a fast commit  performance optimization
  jbd2: don't touch buffer state until it is filled
  jbd2: don't read journal->j_commit_sequence without taking a lock
  ext4: dedpulicate the code to wait on inode that's being committed
  ext4: fix code documentatioon
  ext4: mark buf dirty before submitting fast commit buffer
  ext4: remove unnecessary fast commit calls from ext4_file_mmap
  ext4: fix inode dirty check in case of fast commits
  ext4: disable fast commit with data journalling
  ext4: issue fsdev cache flush before starting fast commit
  ext4: make s_mount_flags modifications atomic
  jbd2: don't start fast commit on aborted journal
  ext4: cleanup fast commit mount options

 Documentation/filesystems/ext4/journal.rst |   6 +
 Documentation/filesystems/ext4/super.rst   |   7 +
 Documentation/filesystems/journalling.rst  |   6 +-
 fs/ext4/ext4.h                             |  66 +++++---
 fs/ext4/extents.c                          |   7 +-
 fs/ext4/fast_commit.c                      | 169 +++++++++++----------
 fs/ext4/fast_commit.h                      |   6 +-
 fs/ext4/file.c                             |   6 +-
 fs/ext4/fsmap.c                            |   2 +-
 fs/ext4/fsync.c                            |   2 +-
 fs/ext4/inode.c                            |  19 +--
 fs/ext4/mballoc.c                          |   4 +-
 fs/ext4/namei.c                            |  61 ++++----
 fs/ext4/super.c                            |  43 +++---
 fs/jbd2/commit.c                           |  11 +-
 fs/jbd2/journal.c                          | 138 +++++++++--------
 fs/jbd2/recovery.c                         |   6 +-
 fs/ocfs2/journal.c                         |   2 +-
 include/linux/jbd2.h                       |  23 ++-
 include/trace/events/ext4.h                |  10 +-
 20 files changed, 328 insertions(+), 266 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

