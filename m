Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A778F507695
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 19:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiDSRep (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Apr 2022 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344945AbiDSReo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Apr 2022 13:34:44 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345CF37BE0
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t4so24747503pgc.1
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YU77neVoeVUX6CbHMwnH/vwlwqH6ZWpLU48vXWkIrTA=;
        b=hAmp2s+JA3Dg99bCVTX2+1v3Xw4uBD30KNM+4q1ZoxxGzFJlWhRQgrrd99phjEtdId
         Ox9VIUreTNMarLxeHgm2MZm7VLpztzX+++Vt/q8zE6jK6Pxf49Z/+kvFDCfd3cov2n4F
         Fw4S7s7ejVcvCEzALDnrWVm4Zq3Ias2TTXvrNWLQJg725podh3/q1mcoVhtaMJ/nz069
         32uHEQVh1xnvXpfqQOaUkhb+2Bm7MQBIdB1ObeClYVWXzKAa+iZIDZhYbeE1TktNtQTG
         BHYh5NiVcuR/zbv0ooBanVlRknb9Fe3jlQwr4MdDumrNLkLsSzf+XNhom3O2OeUGURDu
         LJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YU77neVoeVUX6CbHMwnH/vwlwqH6ZWpLU48vXWkIrTA=;
        b=SsxJ1eQ1lg6E+FIPcxQR63obZ+oGUyogpmd+PSyNtOhLymILY4vUwS9Tt0aCVIkUeX
         JHMS1hOmOHnIK7q8Ox16/od89Fwi+g16WleG3cHd79qln4l/G6Ynuu9w1dkd0AViFl5w
         DECg9TmjCQBa7V1N7OQenFEoOOowgipfOzFbZjvtVSn5zI2Gcu7eRH3ZiS0Aug4Yplx3
         7PNnl+3xR00RyT/pmU1Vy3NnVi1EGNuyUiUqNiwIJXxxsYMGhOXthT6/FTnfTV/mnu2k
         xXU/GvzTCfKhG2WmpXH8RE/NrXebr/+Z/p8Za6oLGRDlObNJk3eiBVun1MMnTcantstk
         PHBQ==
X-Gm-Message-State: AOAM531seeatQfivS3cqz4BFX5d35yCBRDodtcXDnI0DGy1MnUkAHZoa
        4JIhjmLZ9ikWIv4Wd1jjl3JkgkFkRTLsmA==
X-Google-Smtp-Source: ABdhPJwV4SbRZfbNDamhChlITwV7eSRit/XbCn5bo7+JGXvBCiohOUAWDHCWHpob9nUX1aAwZiiXuw==
X-Received: by 2002:a63:db4c:0:b0:39d:18bf:7857 with SMTP id x12-20020a63db4c000000b0039d18bf7857mr15778025pgi.413.1650389520250;
        Tue, 19 Apr 2022 10:32:00 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:91ac:bc24:f886:dffc])
        by smtp.googlemail.com with ESMTPSA id q9-20020a638c49000000b00398677b6f25sm17266093pgn.70.2022.04.19.10.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:31:59 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshads@google.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 0/6] ext4: improve commit path performance for fast commit
Date:   Tue, 19 Apr 2022 10:31:37 -0700
Message-Id: <20220419173143.3564144-1-harshads@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4: improve commit path performance for fast commit

This patch series supersedes the patch "ext4: remove journal barrier
during fast commit" sent in Feb 2022.

This patch series reworks the fast commit's commit path to improve
overall performance of the commit path. Following optimizations have
been added in this series:

* Avoid having to lock the journal throughout the fast commit.
* Remove tracking of open handles per inode.

With the changes introduced in this patch series, now the commit path
for fast commits is as follows:

 [1] Lock the journal by calling jbd2_journal_lock_updates. This
     ensures that all the exsiting handles finish and no new handles
     can start.
 [2] Mark all the fast commit eligible inodes as undergoing fast commit
     by setting "EXT4_STATE_FC_COMMITTING" state.
 [3] Unlock the journal by calling jbd2_journal_unlock_updates. This allows
     starting of new handles. If new handles try to start an update on
     any of the inodes that are being committed, ext4_fc_track_inode()
     will block until those inodes have finished the fast commit.
 [4] Submit data buffers of all the committing inodes.
 [5] Wait for [4] to complete.
 [6] Commit all the directory entry updates in the fast commit space.
 [7] Commit all the changed inodes in the fast commit space and clear
     "EXT4_STATE_FC_COMMITTING" for all the inodes.
 [8] Write tail tag to ensure atomicity of commits.

(The above flow has been documented in the code as well)

Instead of calling ext4_fc_track_inode() in ext4_journal_start() as I
originally proposed on the code review of [PATCH V2 2/5] "ext4: ext4:
for committing inode, make ext4_fc_track_inode wait" [1], in this
version I changed the behavior of ext4_reserve_inode_write() to also
call ext4_fc_track_inode(). Let's call this approach 1.

I also evaluated another approach (approach 2) where
ext4_reserve_inode_write() acts just as an assertion to ensure that
inode is on fast commit list and the actual call to
ext4_fc_track_inode() is done by ext4_journal_start(). However, this
results in too many stray ext4_fc_track_inode() calls. Approach 1
reduces the number of stray ext4_fc_track_inode() calls and thus makes
the code more maintainable.

However, approach 1 results in a potential deadlock where the caller
can hang if they grab i_data_sem before calling
ext4_fc_track_inode(). To handle that, I have added explicit calls to
ext4_fc_track_inode() in such places. Eventually, when we migrate to
using extent status tree for logical to physical mapping lookup, we
can get rid of this ordering requirement and also remove these calls
to ext4_fc_track_inode(). But, even after adding these stray calls, the
number of stray calls to ext4_fc_track_inode() were less in approach 1
than in approach 2.

I verified that the patch series introduces no regressions in "quick"
and "log" groups when "fast_commit" feature is enabled.

[1] https://www.spinics.net/lists/linux-ext4/msg82019.html

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Harshad Shirwadkar (6):
  ext4: convert i_fc_lock to spinlock
  ext4: for committing inode, make ext4_fc_track_inode wait
  ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
  ext4: rework fast commit commit path
  ext4: drop i_fc_updates from inode fc info
  ext4: update code documentation

 fs/ext4/ext4.h        |  12 +--
 fs/ext4/fast_commit.c | 240 +++++++++++++++++++++---------------------
 fs/ext4/inline.c      |   3 +
 fs/ext4/inode.c       |  10 +-
 fs/ext4/super.c       |   2 +-
 fs/jbd2/journal.c     |   2 -
 6 files changed, 136 insertions(+), 133 deletions(-)

-- 
2.36.0.rc0.470.gd361397f0d-goog

