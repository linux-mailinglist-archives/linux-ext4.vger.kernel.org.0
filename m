Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920F64D1D43
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 17:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348096AbiCHQeg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 11:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348355AbiCHQeg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 11:34:36 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD1833890
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 08:33:34 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d17so8935736pfv.6
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 08:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpC+N942dBZAKC3/heRWkj/K6HDErrVFATGcvUmL/+8=;
        b=IsLHQU5Fq9G+wOWE+bkZPo8kOQ7sb69joqSmLDb5Od4TmH3seNtZQStkdFf/w7FvzL
         S3GD0pk8aNsCCTivsRuzqixr/2nVufWBFPzjEN0vhJH3oY02v3hL1ogut50KeI5ILYAv
         Wy42z/CFjADS6sx5qVwGPkklkhvCb+0NHYHAJxeBs8bu6jslFgu/zjDmR5kuwDPYP1IP
         gJknpsVUFTA6eO2IEUcMgAZXBdC18eW9hjtGfnf9ywHRUrhgwZf41oPlp8zN7xdjwiCN
         usP/xklyezv14uiPGg6Xlqs2wNMuqBOgdMf50oM7In1CeXMhoSyEDpILipjD9QpAV5XA
         FfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpC+N942dBZAKC3/heRWkj/K6HDErrVFATGcvUmL/+8=;
        b=2IW+WsvpCITCIfrLIXlPGqtdEoD9JH0Ini5ISrFaRNv91GYl7Lipjmx24PlFqRg6Eg
         10WdGMYNHXOifJIo3f72Z/TiKfayK5rMiepa/NnV94ycQCpLnrilp9/kgeG94AHJyJ+5
         qtPI1EdLshS443g1MDmSI3LeYNV+ZqdSUCLJkCZYHBiErTmOxk4zxiZDNTrnAXWTlSRQ
         s6hxgZ8xyaP1L/i0LAyV275tF7kakO87RSid1qCfPtB3xm12RDJaZA4ph+mvSAOLruta
         4VH3G+N5x/i5fSgoYEQU3pPwsC200bwOEXJ3lIcpqKGee7BGWgnOz/zvBYc2MNg1ujWf
         Y0rg==
X-Gm-Message-State: AOAM532x9YCA0mVm74/DFD8H/5Fg9Gn13e64KQffXM7L5mNenY9uIXWm
        P39Fl8wqb+BYpV6xVgy1QclDKcV+7unBZk6t
X-Google-Smtp-Source: ABdhPJzQlhkAkm3Z0BwkWmFcVXGqfwAZMVce0GUU7Vm7Q0bZVlSjz5DJHimGpSFzb6E3rVDi+aZiIw==
X-Received: by 2002:a62:e918:0:b0:4f6:fa31:ba09 with SMTP id j24-20020a62e918000000b004f6fa31ba09mr12156434pfh.6.1646757213644;
        Tue, 08 Mar 2022 08:33:33 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id m8-20020a17090a158800b001bf2cec0377sm4517720pja.3.2022.03.08.08.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:33:32 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 0/5] ext4: improve commit path performance for fast commit
Date:   Tue,  8 Mar 2022 08:33:14 -0800
Message-Id: <20220308163319.1183625-1-harshads@google.com>
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

This is the V2 of the patch series after handling Jan's comments on
the first version.

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
  ext4: for committing inode, make ext4_fc_track_inode wait
  ext4: rework fast commit commit path
  ext4: drop i_fc_updates from inode fc info
  ext4: update code documentation

 fs/ext4/ext4.h        |  12 +--
 fs/ext4/ext4_jbd2.c   |  12 +++
 fs/ext4/ext4_jbd2.h   |  13 +--
 fs/ext4/fast_commit.c | 227 ++++++++++++++++++++----------------------
 fs/ext4/inode.c       |   3 +-
 fs/ext4/super.c       |   2 +-
 fs/jbd2/journal.c     |   2 -
 7 files changed, 130 insertions(+), 141 deletions(-)

-- 
2.35.1.616.g0bdcbb4464-goog

