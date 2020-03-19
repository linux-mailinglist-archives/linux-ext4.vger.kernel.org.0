Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E4418C3C4
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Mar 2020 00:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgCSXew (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 19:34:52 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55045 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgCSXew (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Mar 2020 19:34:52 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so1685650pjb.4
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 16:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZwxt5ikBCR89i4QWvRtfT/9HouBXC1EOO4rjbC85ag=;
        b=fEUyqucvJUrYSyqc1gRpidqzE1Tfl+TZHiFeML3Wpl4BlcO2HeXdNMNkPnCdfH2mTO
         tVcQyMIKYKRRJ8B7wk9E6cohnNc/vkcV+zHHtGlTuKWbp6tItsBeJ29DPffU9fmhHcTe
         qwFEWIdzVXBSQrLsL5xqx5GjdjNXOqTVYL9tTh/oVfu7/FYzw9xsrzJd5o6wG+qOU69O
         J0NQRybMNBGPC8VpC59TEp/Zok0eyjhGouOx8EphddOec/02Yz2igWhTdjD2hyh0LjJ2
         Tk/Qjy6qEEFyPgNC8RPwCwTryCDrsJBll1b4QltHhzJERLiw0V4bqlLHbg954Td4ipYO
         Op8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yZwxt5ikBCR89i4QWvRtfT/9HouBXC1EOO4rjbC85ag=;
        b=EtqDJ5xyLpn7Iu7pkyi4dDhDZhcFd7m1MICHn6B3GAxSyf7KHUeFscDqiA2V2DTIqB
         R5neDDLj4wTdXrapH3JYG6wRltJSwNpNJ5WnhYELZ/703L6y3U+Yic1JRp2/jm5OC9Ot
         rA76O8JktPW2DSsGzpjgMndjq5aRzgXySwDhtQmO4ocGyE6seNIfHhjIPNbiXE7xQKv0
         hT1w5rsTNb128eAk0ox6L2gI4a3OVfeur5xcMh8vDiUIP56f96KTFjZxNr+tsYtMnwH5
         9CYEanAxxhSH/rjWFgcxIdRqwm8I+BA2JqZFvlLhRyUBYScpgNalpNItHPs+3npueoSU
         9K9w==
X-Gm-Message-State: ANhLgQ18bohPkPv/A3adgxfJUooutCVeVRE42e7YR4pR0q4f4qbTAil0
        vcappRmiqiF8KyMZJ2tYCntx6sc7
X-Google-Smtp-Source: ADFU+vswx1/6JPKPvcV6kJgcd5GmyI7fj+1jcuxtioQMLaZBsTpjgzUv2+2JbTLTZ5zVnJSKW+/5BQ==
X-Received: by 2002:a17:902:b60f:: with SMTP id b15mr6127462pls.14.1584660890982;
        Thu, 19 Mar 2020 16:34:50 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id j17sm204353pga.18.2020.03.19.16.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 16:34:50 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 0/7] e2fsck: fast commit recovery path e2fsck changes
Date:   Thu, 19 Mar 2020 16:34:26 -0700
Message-Id: <20200319233433.117144-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch series adds e2fsck recovery path changes for fast commits.
Fast commit blocks are laid out in the reserved journal area. Each
block in fast commit region, corresponds to one inode. It contains
a header, a copy of the inode and any of the following tags or no
tags at all.

* EXT4_FC_TAG_ADD_DENTRY: add dentry to a directory
* EXT4_FC_TAG_DEL_DENTRY: remove dentry from a directory
* EXT4_FC_TAG_CREAT_DENTRY: new inode with corresponding dentry
* EXT4_FC_TAG_ADD_RANGE: add extent to inode
* EXT4_FC_TAG_DEL_RANGE: remove logical range from inode

High level new journal replay looks like this.

- For all fast commit blocks, invoke j_fc_replay() handler to handle
  blocks in SCAN phase.
  - In this phase, ext4 replay handler verifies that fast commit
    header is not malformed. If there's an error, it stops replay
    by marking error in replay state.
- Replay phase
  - In replay phase, for every fast commit block, fast commit tags
    are handled in following order.
    - Directory entry updates (Add / Remove / Create)
    - Data updates for inode in question.

Verified that all the tests pass:
367 tests succeeded     0 tests failed

New fast commit recovery test:
j_recover_fast_commit: : ok

Github: https://github.com/harshadjs/e2fsprogs/tree/fast-commit-submit

Harshad Shirwadkar(8):
 ext2fs: add fast_commit test
 e2fsck/jbd2: fast commit recovery changes
 e2fsck: main replay handler
 e2fsck/jbd2: add fast commit feature in jbd2
 ext2fs: make ext2fs_calculate_summary_stats() visible
 e2fsck: allow rewriting extents of a file
 e2fsck: make recovery.c identical with kernel
 e2fsck: fast commit recovery path e2fsck changes

 e2fsck/e2fsck.h                      |  26 ++
 e2fsck/extents.c                     | 160 +++++++-----
 e2fsck/jfs_user.h                    |   9 +
 e2fsck/journal.c                     | 489 ++++++++++++++++++++++++++++++++++-
 e2fsck/recovery.c                    | 113 +++++---
 lib/ext2fs/ext2_fs.h                 |  46 ++++
 lib/ext2fs/ext2fs.h                  |   1 +
 lib/ext2fs/initialize.c              |  58 +++++
 lib/ext2fs/jfs_compat.h              |   9 +
 lib/ext2fs/kernel-jbd.h              |   7 +-
 misc/tune2fs.c                       |  57 ----
 resize/resize2fs.c                   |   6 +-
 tests/j_recover_fast_commit/commands |   5 +
 tests/j_recover_fast_commit/expect   |  23 ++
 tests/j_recover_fast_commit/image.gz | Bin 0 -> 87787 bytes
 tests/j_recover_fast_commit/name     |   1 +
 tests/j_recover_fast_commit/script   |  25 ++
 17 files changed, 875 insertions(+), 160 deletions(-)

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
-- 
2.25.1.696.g5e7596f4ac-goog

