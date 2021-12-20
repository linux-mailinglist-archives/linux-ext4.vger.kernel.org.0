Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7859A47A3D0
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Dec 2021 04:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbhLTDRS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Dec 2021 22:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbhLTDRS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Dec 2021 22:17:18 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6AC061574
        for <linux-ext4@vger.kernel.org>; Sun, 19 Dec 2021 19:17:17 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k64so7473766pfd.11
        for <linux-ext4@vger.kernel.org>; Sun, 19 Dec 2021 19:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryhj1Atbpm23Kl7dVOxUYdYACR+atJDYlgM1Be4nAkQ=;
        b=nFoIrndrMVAezbc1NQRoa1gVxUPtYgHHwYU4a0ACyb364fV6gJc5KBhB+TQAZj+IQf
         h/C9Y663dGC0z+VIzBVuYpN5UbeGwKZ3SjCyXliUBfV/7uUifIzB/CsgQw9mtM7AxN3A
         2dyq8G1cyuZCPzE353uyVOxS60dGxLTsIVyX8nMFNk0bMMzBuzG1YJYyPHrr6ItOeg3v
         0DvhgnciBU4fBRU/e4Hrjt8dp5I81gWzZcqzN18Cf0VMZgxXVx/SRpxTdT1MEyKZwT1E
         WD5BVoUDiHJ30/5IEveWi1a4PLg++Kwojd/FgDvvxSrtXdMOlDJ1TEgApWqMWSzyO9qT
         c7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryhj1Atbpm23Kl7dVOxUYdYACR+atJDYlgM1Be4nAkQ=;
        b=o7vRlQu2F88cNurowD+H8j1OTxRfoePry5rAUppYakU0VwG7ShQABd8+GCAbwYLd8p
         twlhcRwp+dRDHCQxtjyw6gMLYuPjJnSwfT88GI4KfPoAiesrbv2C/OksQG2S+g3fJCyw
         ajJz5P2Bnw/4RlQ7m1tSbo6aJrlxyF2vesc1dyE4nasvsqqDCHdsVN73MaMJkit/mL9Q
         XAJgA1idjTuEyXj05LEiAwcZ1hvSy2KasKS8LjeUaXX8kn0nuYQSzuFzftZOk8EDU6oS
         WICVXlMDPxvNtVEsS/F8x3mK+f/84CnUBg8ppB4PbVj0PT9Uiq04ZZqvdLczv5Ro9Ptj
         vv6g==
X-Gm-Message-State: AOAM5301u5cnRDawZslCrDB0+X6mqoiKb28QrEG2sa+vXoZsj19dhppp
        0O08xuDiS4/JJVAInnffOYT9wFO/WoE=
X-Google-Smtp-Source: ABdhPJynqZATwIvqG7oCP/voIPdt3Y/9b166iENaSsRi8VdqhVfRK0KYnRFqOJeD0wTebMAelkiIMw==
X-Received: by 2002:a62:8443:0:b0:4ba:7251:f087 with SMTP id k64-20020a628443000000b004ba7251f087mr14486829pfd.16.1639970236916;
        Sun, 19 Dec 2021 19:17:16 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:29b6:d340:a7f2:2b64])
        by smtp.googlemail.com with ESMTPSA id kb1sm9102412pjb.56.2021.12.19.19.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 19:17:16 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     yinxin.x@bytedance.com, enwlinux@gmail.com,
        Harshad Shirwadkar <harshads@google.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 0/3] ext4 fast commit API cleanup
Date:   Sun, 19 Dec 2021 19:17:01 -0800
Message-Id: <20211220031704.441727-1-harshads@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4: fast commit API cleanup

This patch series fixes up fast commit APIs. There are NO on-disk
format changes introduced in this series. The main contribution of the
series is that it drops fast commit specific transaction APIs and
makes fast commits work with journal transaction APIs of JBD2
journalling system. With these changes, a fast commit eligible
transaction is simply enclosed in calls to "jbd2_journal_start()" and
"jbd2_journal_stop()". If the update that is being performed is fast
commit ineligible, one must simply call ext4_fc_mark_ineligible()
after starting a transaction using "jbd2_journal_start()". The last
patch in the series simplifies fast commit stats recording by moving
it to a different function.

I verified that the patch series introduces no regressions in "quick"
and "log" groups when "fast_commit" feature is enabled.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Harshad Shirwadkar (3):
  ext4: drop transaction start stop APIs for fast commit
  ext4: drop ineligible txn start stop APIs
  ext4: simplify updating of fast commit stats

 fs/ext4/acl.c         |   2 -
 fs/ext4/ext4.h        |  12 +-
 fs/ext4/extents.c     |   9 +-
 fs/ext4/fast_commit.c | 250 ++++++++++++------------------------------
 fs/ext4/fast_commit.h |  27 ++---
 fs/ext4/file.c        |   4 -
 fs/ext4/inode.c       |   7 +-
 fs/ext4/ioctl.c       |  13 +--
 fs/ext4/super.c       |   1 -
 fs/jbd2/journal.c     |   2 +
 10 files changed, 96 insertions(+), 231 deletions(-)

-- 
2.34.1.173.g76aa8bc2d0-goog

