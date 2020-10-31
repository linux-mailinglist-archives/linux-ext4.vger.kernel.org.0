Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3548F2A1A69
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Oct 2020 21:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgJaUFk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Oct 2020 16:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgJaUFk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Oct 2020 16:05:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F86BC0617A6
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h4so1128898pjk.0
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dUCi+lA+wJ6GzeQ2Cypz60R7V9wle+fxXsZkBVAioAw=;
        b=WLHrawIrUz5YQVj9rC7Bxrm3H1mPrPVylFslQx9r+EL1AdzXIx1BcjNjX9X/4Lo+J8
         UFswsUzVFh7A2hN31b2jCETYtML6wsRgT+wt+UzWK86j+T3mKkigf221ihYWOt2xYnyp
         l9I8nOkvDoNPDk+if+aBLTkIeOvoAdXiKcLpy+rEaDQEMzNApluolsLOSHJM3sTQJQ16
         KeWSPmVvZDJOutKRdM00CmmnzRgzA6k6oCLbPbHg7gssyX24dVEBG65gwLcL9lDzXMGM
         O75lEf4Zpugid6C6YSFGH2Dwayh1JuRiOchQkcUbyhOkcbldsbReYu26qRYNFsCFSlSB
         r7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dUCi+lA+wJ6GzeQ2Cypz60R7V9wle+fxXsZkBVAioAw=;
        b=liFFhNsiATp08yz+uDFUWZSdUrk6ekfppm4FMzZU6QAKlhney+h1sj2PyKap7sTOdk
         y8A6ZJ42J5aWEk1lwxRr58+jNFyD3A1ggbxoSzgK72pOPoxQLBbfpCt2WCARIMvLsurf
         vKlw3FH1cpyjnhs5o5B53IUwg+ESI7INmfMsFFfg5KMMPdfFlzF6Ruq4rj8wsjBZX5t/
         fdlGAGjs37xnlLCXSO/V/1lh1o5zbCWZME5meU9xNR2KbNKaBDwxzDD4i03zaYvwXmOd
         cz6vzMgySxK0DyUH55fmbtcnm4a63QNZuKGZjZjPyR2UehVbYWyYe1KrHpXd0Q8s4/7X
         3YZw==
X-Gm-Message-State: AOAM531apZ8R0oZv1iFrJ1Nm9Uo9uTZaQ3DrpXlPZJVh/S3XuHIYwJas
        0Nf25vk9FjFTlXaf3s+DuMPVfop/PyU=
X-Google-Smtp-Source: ABdhPJxNvPUlwvqwD4fTVfJolcAHPSN7rTDtWYUBu/hMTlEReuL1yDf4akf+fzwxsZ5u2HbnmClxPg==
X-Received: by 2002:a17:90a:7024:: with SMTP id f33mr9652086pjk.114.1604174739190;
        Sat, 31 Oct 2020 13:05:39 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm17177102pjq.3.2020.10.31.13.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:05:38 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 00/10] Ext4 fast commit fixes
Date:   Sat, 31 Oct 2020 13:05:08 -0700
Message-Id: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4: fast commit fixes

This patch series adds several documentation and code-only (no on disk
format changes) fixes for the fast commit code. I verified that there
were no regressions introduced by this patch series in xfstests auto
and log groups in fast_commit and 4k configurations. Thanks Jan for
suggesting most of the fixes.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Harshad Shirwadkar (10):
  ext4: describe fast_commit feature flags
  ext4: mark fc ineligible if inode gets evictied due to mem pressure
  ext4: pass handle to ext4_fc_track_* functions
  ext4: clean up the JBD2 API that initializes fast commits
  jbd2: fix fast commit journalling APIs
  ext4: dedpulicate the code to wait on inode that's being committed
  ext4: misc fast commit fixes
  ext4: fix inode dirty check in case of fast commits
  ext4: disable fast commit with data journalling
  ext4: issue fsdev cache flush before starting fast commit

 Documentation/filesystems/ext4/journal.rst |   6 +
 Documentation/filesystems/ext4/super.rst   |   7 ++
 fs/ext4/ext4.h                             |  22 ++--
 fs/ext4/ext4_jbd2.h                        |   6 +-
 fs/ext4/extents.c                          |  11 +-
 fs/ext4/fast_commit.c                      | 138 ++++++++++-----------
 fs/ext4/fast_commit.h                      |   3 +-
 fs/ext4/file.c                             |   2 -
 fs/ext4/inode.c                            |  14 +--
 fs/ext4/namei.c                            |  50 ++++----
 fs/ext4/super.c                            |   5 +-
 fs/jbd2/commit.c                           |  11 +-
 fs/jbd2/journal.c                          |  94 ++++++++------
 fs/jbd2/recovery.c                         |   2 +-
 include/linux/jbd2.h                       |  13 +-
 include/trace/events/ext4.h                |  10 +-
 16 files changed, 220 insertions(+), 174 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

