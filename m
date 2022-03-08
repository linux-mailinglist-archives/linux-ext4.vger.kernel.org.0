Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953144D1527
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 11:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbiCHKwX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 05:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbiCHKwX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 05:52:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A22433B1
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 02:51:27 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso1916121pjb.0
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 02:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMOG2BPj4fOBhtEo1bzOzs3c76jXokca/v61/sHM5fA=;
        b=eB9M3uaj12BKY/d9xGJpVM1b2mBm6qd5b6sDc4vK1tcpT8T5L7dZOU3jW8+OZeA2/w
         aFEJBdU0inHo5EPJgxDC3b+c6beraOld/t6z8i2HcIDcdhZnonnmB6tfKJNKDACWRNeh
         Sp2ynSfygPvgcfUkbMBbFZCJAs0ccNJn8KkPYCmTxNdwzieh4bbIyPejXMxo1uthbgcQ
         b5RqvQnwhEIkTAajkjf7FYnedEVuzIaa2BhOw59Q/GESqJyirgbnHYSiLk1ummQ5N1pc
         vpJPs7zxTj0yZidJzEP4pHjsT0hrnEjqIXQYV/pxlecTv9ym5XU1ZYtfFCeQbtemwdG/
         btKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMOG2BPj4fOBhtEo1bzOzs3c76jXokca/v61/sHM5fA=;
        b=NTHs//0KjMIo+WfOG99ytV4fpOIDjXb03ViXG8vMTJbuSmXOoASt8yPEkjpCyQ1CBr
         Rjbz8Y2fTZu89/BErZG6EftJpYHELm0pXIPYzh4JAroDOBQWw+FC5g8p3wtq8fhdzG6/
         xtRV4UKI8lojYplrwlL0PbdabH3FlDnRkGTG5EzdZPiJPwoTd9/YMV5L7XdNUmEagv7O
         LO7snVshr7eFX1RxKoaQuRphijMbiTEQUik0Pa1PYQbgoIAMTzIchRYbX83D3nGYX87m
         HqrwKOtnu8Hi45nPVXxmwyHOC8vWdyN44CJKLpPOHSZpw8lda1/1aTMi5qlSa0N/r3bm
         E1vg==
X-Gm-Message-State: AOAM532ECFDJeFW8rzxCuKDLwnDL1FQOaTrWkw+LLEQppxKtjGZ6r7bu
        8p8SLvTBpj0nd9mSBaDea3EjL3vzS7wGSgEk
X-Google-Smtp-Source: ABdhPJxp1fFxx9R9RooSinOfGtL2ZvkQ/T/a5BEjMBqLuvRl9RB0f/dAXiJYhOvMh+x3cC4/9QKFmg==
X-Received: by 2002:a17:90a:6c01:b0:1bf:1e67:b532 with SMTP id x1-20020a17090a6c0100b001bf1e67b532mr4017626pjj.138.1646736685985;
        Tue, 08 Mar 2022 02:51:25 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id f6-20020a056a00228600b004f709f5f3c1sm6282040pfe.28.2022.03.08.02.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:51:25 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 0/5] ext4: improve commit path performance for fast commit
Date:   Tue,  8 Mar 2022 02:51:07 -0800
Message-Id: <20220308105112.404498-1-harshads@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
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

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

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

I verified that the patch series introduces no regressions in "quick"
and "log" groups when "fast_commit" feature is enabled.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Harshad Shirwadkar (5):
  ext4: convert i_fc_lock to spinlock
  ext4: drop i_fc_updates from inode fc info
  ext4: for committing inode, make ext4_fc_track_inode wait
  ext4: rework fast commit commit path
  ext4: update code documentation

 fs/ext4/ext4.h        |  12 +--
 fs/ext4/ext4_jbd2.c   |  12 +++
 fs/ext4/ext4_jbd2.h   |  13 +--
 fs/ext4/fast_commit.c | 228 ++++++++++++++++++++----------------------
 fs/ext4/inode.c       |   3 +-
 fs/ext4/super.c       |   2 +-
 fs/jbd2/journal.c     |   2 -
 7 files changed, 134 insertions(+), 138 deletions(-)

-- 
2.35.1.616.g0bdcbb4464-goog

