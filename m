Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0662D642F
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 18:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392984AbgLJR5U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 12:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390050AbgLJR5S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 12:57:18 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F14C0617B0
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:37 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v3so3148097plz.13
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/p7EYKwkpHyoCKW4H8fd1m5bjSRrYBhcANCfnf/1pAU=;
        b=J2yRnQPZgP02Q5W5zJMXKnrZIJEZmLvrSaNetbA5wiRnEcRg6h4uxhfdeZLoMwEcxq
         QS4Xv5Nv/tipcGokVKgfnKwpQaOklyOV43BGreYa+2RGGOHS1bGIsgnm92GIdkxQ1Uen
         WBmXc+vAoic8S9Lo0o/9Ddc2my66cLTFUIAeFaTkraczcAl3QlS839Satlm1xpaSOBQs
         GHW4fPPP22Jj2j09qMBOQh2Ge9nYEGAHp2w55qoEAhUJWUV2rWSpxhC5UU5+E2iq8nLh
         V2N6A1lDEjzWHYjKNI1FfXw8iBaD2H9hzlvuO0BjiV4Jmqc/UJ+l7N6Okef/zSpOU5BC
         cy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/p7EYKwkpHyoCKW4H8fd1m5bjSRrYBhcANCfnf/1pAU=;
        b=TWWnh3m8iyUHC8ZQXNhFnLQcg4uoTx5utL8O0SfdOJmDzhw/SKN2haedEW7as1Qf23
         daHvzSO12WGoWzoUZVl2gmaGoRVRC2MTf95li6L5CWrPwJ44ZKnnL14PRz5eXQH8QTCw
         /GHAaYL9/v/+XDx0CZO40dmtSYKX/Ojjj2QZCBE9+dEHyJT22c74G/govDM7RsDbOa6d
         mNP8uGTh7cWEcjoUzq18HjtaILQoAvGBZCJ7yp8LpVPPWODpBU1T4gxo1qNuaPJ4qt2x
         zZAIkBmRO/gHXWbPKe8kWqkXOyagUFNPhdTNuER0ohKwchSr67aOva0/WW/SyA2zJ78h
         7yRg==
X-Gm-Message-State: AOAM530QKUyFmDAoKcHFJR5Z2e2grv42rxlp5al0b5YUrVcPnDmPREr4
        k2eJxxLV4P2GrlmHMSpl2VJgJhFSu88=
X-Google-Smtp-Source: ABdhPJxUDNR9eWwjRYU+YJ31P5moajkzy17qBGQWr9FUpVYmXEctXV0T3DnGvPDqXGdL2vG83lL0VA==
X-Received: by 2002:a17:902:9a49:b029:da:b3b0:94a1 with SMTP id x9-20020a1709029a49b02900dab3b094a1mr7421395plv.11.1607622996372;
        Thu, 10 Dec 2020 09:56:36 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id u24sm7433517pfm.81.2020.12.10.09.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:56:35 -0800 (PST)
From:   harshadshirwadkar@gmail.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 00/15] Fast commits support for e2fsprogs
Date:   Thu, 10 Dec 2020 09:55:53 -0800
Message-Id: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
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

Github: https://github.com/harshadjs/e2fsprogs/tree/fast-commit-v2

Changes from V1:
---------------

* Cleaned up libext2fs interface - removed max() macro and added new
  APIs instead of modifying existing ones.
* Reorganized the fast commit number of block configuration patches to
  logically separate linext2fs and userspace tool changes.

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
 lib/ext2fs/kernel-jbd.h                 |  19 +-
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
 52 files changed, 1864 insertions(+), 341 deletions(-)
 create mode 100644 lib/ext2fs/fast_commit.h
 create mode 100644 tests/j_recover_fast_commit/commands
 create mode 100644 tests/j_recover_fast_commit/expect
 create mode 100644 tests/j_recover_fast_commit/image.gz
 create mode 100755 tests/j_recover_fast_commit/script

-- 
2.29.2.576.ga3fc446d84-goog

