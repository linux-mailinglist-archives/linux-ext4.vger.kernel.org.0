Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B312FDE09
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 01:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbhAUAbk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jan 2021 19:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732446AbhATVbh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jan 2021 16:31:37 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3740AC061575
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u4so3041139pjn.4
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0By5KnTzjUw0/0hnFFMnFjGbX48K+iA0XTdwb7koxfE=;
        b=Nec0lXLcGzGSPhs5BWxYkDeXInDJ0KMCLipHC5jWKQnSyIheZDmyZuyGE3Vfswmq1Z
         CC2fQnUtPDkj51umy2ZZ1Ek91GkQZBev5aFtruEH20gXazRfYJNyW0e4ns6U39/fRMtO
         pno9cuz53NFZiBPE4lh0W4oFwqt8E6RrWVibUWZyXHQlytAKjJx0GfAuBIYwPVYAMeo3
         anzPQloIW41vftUIRPctQy0Hg7AOsCV6NisBbri23XUKRiEwqxoPbph5Ee9KT7reQKRD
         xd3Auf+qnEXjuQfLig0oteb2586vIjBGaloOhB3X8EXmVczm79oLg89FXj23SMfTmjAw
         b2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0By5KnTzjUw0/0hnFFMnFjGbX48K+iA0XTdwb7koxfE=;
        b=YpkLrolU3/bhALnRyRPchmzmomKHNa1DzyXa7GuzPA0f7VU9GAK+FH0HQeKFrubLjP
         Dhqtkgz1kDpcpBGKCaoE+5Zv6JCRhgCjXJBitZEPdzCvENbvlhlF3AsymmDA0ncJ5ehE
         uBON3JNWMaYOOCrUGGPlPFPXSzT4G8jluj/dn7n+qmoy3FjNtsKqwxetrStG0XLKBSz3
         8cDU7/h8wUnhqeyK1qz+zYuhdEig7n/jQdB4QCav71bzECOGvtS/8XuRCIvxJioP6p1y
         2xebvVTKyHhL+Hi6KhY7Zbucu53LFXf1/Dl2nABRnhYRYfbZ+wYckhNml8qOaET7dvTy
         zo9Q==
X-Gm-Message-State: AOAM531PkgrQw/9gB7oJN8DOf11sifyv6w4+PBuV+Iq3bydOxWCCjHse
        bfUy4pOltIrEkfpwvMenYJyrPWR7bYE=
X-Google-Smtp-Source: ABdhPJwPeGjtxmAYBhvhthxQD9xCWpz+H2T37gzSYr8kiCyMN3l7PZXiJwHu0VnZFCFGH/8/frnS4w==
X-Received: by 2002:a17:90a:6589:: with SMTP id k9mr7700708pjj.100.1611178006303;
        Wed, 20 Jan 2021 13:26:46 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id w1sm3396758pjt.23.2021.01.20.13.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:26:45 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 00/15] Fast commit changes for e2fsprogs
Date:   Wed, 20 Jan 2021 13:26:26 -0800
Message-Id: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

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

Changes Since V2:
----------------

- Fix compilation error by defining jbd2_journal_get_fc_num_blks (also
  rename it to jbd_get_fc_num_blks) as a preprocessor macro instead of
  inline function which gets compiled out when "-g" is passed

Harshad Shirwadkar (15):
  ext2fs: move calculate_summary_stats to ext2fs lib
  e2fsck: add kernel endian-ness conversion macros
  e2fsck: port fc changes from kernel's recovery.c to e2fsck
  libext2fs: provide APIs to configure fast commit blocks
  e2fsprogs: make userspace tools number of fast commits blocks aware
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
 e2fsck/journal.c                        | 660 +++++++++++++++++++++++-
 e2fsck/recovery.c                       | 232 ++++++---
 e2fsck/unix.c                           |  26 +-
 lib/e2p/e2p.h                           |   1 +
 lib/e2p/ljs.c                           |  16 +-
 lib/ext2fs/ext2_fs.h                    |   1 +
 lib/ext2fs/ext2fs.h                     |  30 ++
 lib/ext2fs/extent.c                     |  63 +++
 lib/ext2fs/fast_commit.h                | 203 ++++++++
 lib/ext2fs/initialize.c                 |  94 ++++
 lib/ext2fs/jfs_compat.h                 |  25 +-
 lib/ext2fs/kernel-jbd.h                 |  16 +-
 lib/ext2fs/mkjournal.c                  |  96 +++-
 lib/ext2fs/unlink.c                     |   6 +-
 misc/dumpe2fs.c                         |  10 +-
 misc/mke2fs.8.in                        |  21 +
 misc/mke2fs.c                           |  26 +-
 misc/tune2fs.8.in                       |  25 +
 misc/tune2fs.c                          |  67 +--
 misc/util.c                             |  61 ++-
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
 52 files changed, 1861 insertions(+), 341 deletions(-)
 create mode 100644 lib/ext2fs/fast_commit.h
 create mode 100644 tests/j_recover_fast_commit/commands
 create mode 100644 tests/j_recover_fast_commit/expect
 create mode 100644 tests/j_recover_fast_commit/image.gz
 create mode 100755 tests/j_recover_fast_commit/script

-- 
2.30.0.284.gd98b1dd5eaa7-goog

