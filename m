Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291892BB500
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 20:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgKTTQY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 14:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgKTTQW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 14:16:22 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACAEC0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:22 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m9so8121934pgb.4
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xY1CG2+GPkGd3C1xQXa64REjnTkKoaMtaJNKB1F9SdI=;
        b=ngrfatKWWBK3F65TLnIt+Ei0pexQ8FqA6sz7FBPsgbeZ2RmuLhZ26TLJ23hyy972Vc
         fYliwosU/wY4H7adSwXqwd0owFmKkD+T3aKYDwWAdqyFr18EVFpWa5jmnf/7VSMzqc7w
         K7ngGagG1xkGiHLnKkbenA41rjFWNKewjGIiDGtPxN+18fikATPTK2gJ0jCk9nBYybra
         LNsOWofFsmZFwiijG7OTV1x4mZPh4OqP4WqMfM+ynjUQO5y1+8BFe4Oax0HX10crgh5z
         YUuJxEoZ6eK5fm3oy7vnJJUNJNbjZHj8NnmxIFvMirjTwXo0IM458BMGeiIoJcp85psu
         p+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xY1CG2+GPkGd3C1xQXa64REjnTkKoaMtaJNKB1F9SdI=;
        b=R1vlxOgYDjw2IfH43DzMp9ONIOKWRlbI8ODzdF5r6hKCOLJHJV4CHZBFIriDnHPU3Z
         BNKlcodc0QYF0SnHo8UlPvC3TfcVQJKlFy4+4Ob2C3Lka+NeLG06RafIMlgpmnwt0jl0
         vTX5WLptDAco2RNtA+wESscMYc1QIhN3z/JJvHPo9Ia7pdJoDLIh01Xe27N4JfPRo1Q9
         S9Vv/zJ7qPJXSfbYQAKMSRjAdMFzenUfs3IQok0uPHGGkPvBPeqfxWLJ7La9xBZiJ6da
         ZnoNC1zpwJPUGZh3XzzyVJkBBMEE/byg4ASnNIWuEusaTN6GebQ4xLQGEUHVLTj6ZTNg
         4MIA==
X-Gm-Message-State: AOAM530tQnGrOW80n/AsgyNBILdn2IldtqIlriUzskkIZCJ3NSlI6u8X
        fu3uuAO1ug7ttjgkwtDYNIgIJOry2Io=
X-Google-Smtp-Source: ABdhPJxHUkWCYTecAaivsPCEgqfm5mUbpcERmz7rewrdUPKPsWeSzj8/KwepQug4ELX5K3FQlIPCyQ==
X-Received: by 2002:a62:7e81:0:b029:197:c3e2:4ad9 with SMTP id z123-20020a627e810000b0290197c3e24ad9mr7763657pfc.35.1605899781228;
        Fri, 20 Nov 2020 11:16:21 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o9sm4370480pjr.2.2020.11.20.11.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:16:20 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 00/15] Fast commits support for e2fsprogs
Date:   Fri, 20 Nov 2020 11:15:51 -0800
Message-Id: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch series adds fast commits support in e2fsprogs. This
includes fast commit recovery support in e2fsck and fast commit
configuration support in mke2fs and tune2fs. Along with that this
patch series also makes e2fsck/recovery.c identical with
jbd2/recovery.c in kernel. In addition, this patch imports and makes
fast_commit.h (the file that contains on-disk formats for fast
commits) byte identical with the kernel.

The recovery logic for fast commits follows the same steps as that of
the recovery logic in kernel. The general guidining principle for the
fast commit replay is that the individual tags found in fast commit
area store the result of the operation as their paylod instead of
storing the procedure itself. The recovery logic enforces this result
onto the filesystem thereby making the fast commit replay
idempotent. Unlike kernel, there's no atomic oepration support in
e2fsprogs yet. So, it's possible that we may crash while we are in the
middle of replaying of a fast commit tag. The only way to recover from
that situation would be to run fsck. That's why we mark the file
system as unclean before the fast commit replay and make it clean at
the end.

This series adds new regression test that performs fast commit
replay. I ensured that all the regressions tests pass.

Verified that all the tests pass:
367 tests succeeded     0 tests failed

New fast commit recovery test:
j_recover_fast_commit: ok

The patch series invalidates the initial version of the patch series
which was sent back in Mar 2020. Since then the fast commit code in
kernel has evolved a lot (including the on-disk format change). So,
this patch series is based on the new fast commit kernel code (which
is available in upstream kernel now). This patch series is a complete
revamp of the original series.

Github: https://github.com/harshadjs/e2fsprogs/tree/fast-commit-v2

Harshad Shirwadkar (15):
  ext2fs: move calculate_summary_stats to ext2fs lib
  ext2fs, e2fsck: add kernel endian-ness conversion macros
  e2fsck: port fc changes from kernel's recovery.c to e2fsck
  mke2fs, dumpe2fs: make fast commit blocks configurable
  mke2fs, tune2fs: update man page with fast commit info
  ext2fs: add new APIs needed for fast commits
  e2fsck: add function to rewrite extent tree
  e2fsck: add fast commit setup code
  e2fsck: add fast commit scan pass
  e2fsck: add fast commit replay skeleton
  e2fsck: add fc replay for link, unlink, creat tags
  e2fsck: add replay for add_range, del_range, and inode tags
  debugfs: add fast commit support to logdump
  tests: add fast commit recovery tests
  ext4: fix tests to account for new dumpe2fs output

 debugfs/journal.c                       |  10 +-
 debugfs/logdump.c                       | 122 ++++-
 e2fsck/e2fsck.h                         |  32 ++
 e2fsck/extents.c                        | 168 +++---
 e2fsck/journal.c                        | 656 +++++++++++++++++++++++-
 e2fsck/recovery.c                       | 232 ++++++---
 e2fsck/unix.c                           |   8 +-
 lib/e2p/e2p.h                           |   1 +
 lib/e2p/ljs.c                           |  16 +-
 lib/ext2fs/bitops.h                     |   8 +
 lib/ext2fs/ext2_fs.h                    |   1 +
 lib/ext2fs/ext2fs.h                     |  33 +-
 lib/ext2fs/extent.c                     |  56 ++
 lib/ext2fs/fast_commit.h                | 201 ++++++++
 lib/ext2fs/initialize.c                 |  94 ++++
 lib/ext2fs/jfs_compat.h                 |  19 +-
 lib/ext2fs/kernel-jbd.h                 |  19 +-
 lib/ext2fs/mkjournal.c                  |  99 ++--
 lib/ext2fs/unlink.c                     |   6 +-
 misc/dumpe2fs.c                         |  10 +-
 misc/mke2fs.8.in                        |  21 +
 misc/mke2fs.c                           |  24 +-
 misc/tune2fs.8.in                       |  25 +
 misc/tune2fs.c                          |  67 +--
 misc/util.c                             |  63 ++-
 misc/util.h                             |   4 +-
 resize/resize2fs.c                      |   6 +-
 tests/d_corrupt_journal_nr_users/expect |   6 +-
 tests/f_jnl_errno/expect.0              |   6 +-
 tests/f_opt_extent/expect               |   2 +-
 tests/i_bitmaps/expect                  |   8 +-
 tests/j_ext_dumpe2fs/expect             |   6 +-
 tests/j_recover_fast_commit/commands    |   4 +
 tests/j_recover_fast_commit/expect      |  23 +
 tests/j_recover_fast_commit/image.gz    | Bin 0 -> 3595 bytes
 tests/j_recover_fast_commit/script      |  26 +
 tests/m_bigjournal/expect.1             |   6 +-
 tests/m_extent_journal/expect.1         |   6 +-
 tests/m_resize_inode_meta_bg/expect.1   |   6 +-
 tests/m_rootdir/expect                  |   6 +-
 tests/r_32to64bit/expect                |   6 +-
 tests/r_32to64bit_meta/expect           |   4 +-
 tests/r_32to64bit_move_itable/expect    |   8 +-
 tests/r_64to32bit/expect                |   6 +-
 tests/r_64to32bit_meta/expect           |   4 +-
 tests/r_move_itable_nostride/expect     |   6 +-
 tests/r_move_itable_realloc/expect      |   6 +-
 tests/t_disable_mcsum/expect            |   4 +-
 tests/t_disable_mcsum_noinitbg/expect   |   6 +-
 tests/t_disable_mcsum_yesinitbg/expect  |   4 +-
 tests/t_enable_mcsum/expect             |   6 +-
 tests/t_enable_mcsum_ext3/expect        |  10 +-
 tests/t_enable_mcsum_initbg/expect      |   6 +-
 53 files changed, 1829 insertions(+), 353 deletions(-)
 create mode 100644 lib/ext2fs/fast_commit.h
 create mode 100644 tests/j_recover_fast_commit/commands
 create mode 100644 tests/j_recover_fast_commit/expect
 create mode 100644 tests/j_recover_fast_commit/image.gz
 create mode 100755 tests/j_recover_fast_commit/script

-- 
2.29.2.454.gaff20da3a2-goog

