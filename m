Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE16139E5FB
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 19:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFGR6H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhFGR6E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Jun 2021 13:58:04 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6E4C061766
        for <linux-ext4@vger.kernel.org>; Mon,  7 Jun 2021 10:56:01 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id z15so9394178vsn.13
        for <linux-ext4@vger.kernel.org>; Mon, 07 Jun 2021 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsTudBiopkT0S161YelwgAWGn2Y8C79FsjSzlUseO1g=;
        b=jI6eu1ahiNJ8Mvuowl11WLp1ZLVaIFd9xyRMoTt6UU/+qRxRsJbY9DVUGzZU1CDuJE
         wrlYpd07oAwDDsCqOLYcECvrLSEpWdUIRrLCjV9Du9TWxncMB5Dec1zB9sI2jMVeRlXP
         VgT8r6F4dO1ObbjDMCmmRfWBHLE+7+6nhBwfN1qgp6qqJetRgpnx9SEDr9NxbQi+abYU
         llzO9RevmuONUeN2AoCnwjzBHuBfNp6XqYmt1Q1aBg16Fv9qF5RgAJPRrVhcoT1ptK78
         58n3gkqwpYcxomAFv2797K5OT4J3MaNcHLKZSFXezs2iJ/aO6xLpFpucKrWsZc+yQ/nM
         OuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GsTudBiopkT0S161YelwgAWGn2Y8C79FsjSzlUseO1g=;
        b=VCv/UwI2qe5ELaZnaMc1IsVuUpu0atBEmoUDxW/ZYcTTBQ8R1UT2SxI0Me4Gdmjm8T
         JZA6HBWPgI6bn6djunyy52k2AJ0R8gir0GpDfWAnlS3/DAc9Hf5oI5zG6DlSROEPHCB2
         FooMM31WqrLYznGSJzwQS0kSqwGaEvSS2meq2C9ewvlahJkTV3B0e1n9vK2HaBLOu8oJ
         JzpP5N+jW0AMAkokiedwq2e1d8bHJdvLTPozxiswEfK8MkIgMmu9K+1Uc8SadzX/4uRy
         j567QEoVydwxtaHxvsBUTrndnK3LFprTM8xU5mSCvwP0uAr6nx+63mArIkYORLF8bvZy
         xOmw==
X-Gm-Message-State: AOAM530Z3o4Vx+DxjVHFa/s8uFVR5Mv83I8vbMqzIJECAeRvA4R3Cg3u
        2r60IQb4A20iV/3lTzccXj1yvW0oEyZWdw==
X-Google-Smtp-Source: ABdhPJwpdj03x2h9TCYNKgSWI+81mKcvaZD4Z3glPJEPYB+hpIspSeNWleoog4JL9LXCccjg0Bdl1w==
X-Received: by 2002:a05:6102:dca:: with SMTP id e10mr5247559vst.47.1623088560394;
        Mon, 07 Jun 2021 10:56:00 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id u6sm2489071vku.0.2021.06.07.10.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:55:59 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, dan.carpenter@oracle.com,
        Leah Rumancik <leah.rumancik@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ext4: fix input checking in fs/jbd2/journal.c
Date:   Mon,  7 Jun 2021 17:55:58 +0000
Message-Id: <20210607175558.3343945-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Update

	if (JBD2_JOURNAL_FLUSH_DISCARD & !blk_queue_discard(q))

to use && instead of &. JBD2_JOURNAL_FLUSH_DISCARD is set to 1 so &
technically works but && could be a bit faster and will maintain
correctness in the event the value of JBD2_JOURNAL_FLUSH_DISCARD is
updated.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 521ce41c242c..f0636180b624 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1715,7 +1715,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 	if (!q)
 		return -ENXIO;
 
-	if (JBD2_JOURNAL_FLUSH_DISCARD & !blk_queue_discard(q))
+	if (JBD2_JOURNAL_FLUSH_DISCARD && !blk_queue_discard(q))
 		return -EOPNOTSUPP;
 
 	/*
-- 
2.32.0.rc1.229.g3e70b5a671-goog

