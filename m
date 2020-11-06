Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6812A8DE5
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgKFD7t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKFD7t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:49 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DCEC0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:49 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 13so106737pfy.4
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QSwbKKvh8Hp0Fdw46Qy4abtOB/tlJi/kJqfeA/AIQ7Y=;
        b=ruZQNp9vOf1SB/g02NNp/1solBr9/kIulEOZe6aX9rmAupZhFrccRm6VdAbRdNEnaX
         JBfDl2E2fzO87Y7gHP5WtxbxL+bxXqJBKykP59GcntnIaXyUCMchEZKft67zkKOqPxk4
         +WidVyFUz+HVzoh90iEpSVVek3edV/O5ETQyiMPD6Ho6CUSShsoaRavb+kRxr7DSZ1tF
         EQz4sgWZY1hwi+h0AREW06kbrwiKWJViqyBZyrGPb2NgVabR3ozAzQf5iCCAMVNenor9
         FM9EHgEiIfsX29XDotQ5Ec+eMSvljLRG7rwBTrp3E57OZ0teYG4BBbcD5iL4GTu2aXKX
         P2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QSwbKKvh8Hp0Fdw46Qy4abtOB/tlJi/kJqfeA/AIQ7Y=;
        b=WlQchZOm94dK33caen0Wp6MOBYa6Q6vLMtqTBJ6ruyYPOqywZQkFj+f8fh0XFkZJ11
         WNDoPeu3Q0e0sw4vlqF+atUx3PRA+iGO05yYB6v4bxdCXYf3rlOPq6AXVJBAMu9hujtf
         3c8cQEjUvefCTd4d66nCD12qMWEhTb7XzFBxlrfWoJ4nG1U+fcXYwc7aRbgtell0s2R1
         jMN6lxWq8OG0dpTMIDeiMAOr5g8cpp0lFPC5wkZOEseWHOdxA3TlvIST8Y2dSG3vNXf/
         syGutPO/wHzrSMK0Khy+Ana74oXx5EXl7JbyBV6B3kRNtH5AkWEmufFF2te72exgR8KU
         O3Hg==
X-Gm-Message-State: AOAM531arXbD8rjwf7BcyZbtHzQgiYFLgWbpwkqISm7q0Dlqlq2m9UW8
        AyID0v4VZGb+3fZFpvYUxv6DQ1ITVew=
X-Google-Smtp-Source: ABdhPJzqI6j0BtwgZ265zJkyjBaR5+yCvUgVC6ona6mbielHQ4QrDBM9eHElLxleaQ7KlHT2Hzdglw==
X-Received: by 2002:a17:90a:5d17:: with SMTP id s23mr260151pji.103.1604635188714;
        Thu, 05 Nov 2020 19:59:48 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:47 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 19/22] ext4: issue fsdev cache flush before starting fast commit
Date:   Thu,  5 Nov 2020 19:59:08 -0800
Message-Id: <20201106035911.1942128-20-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If the journal dev is different from fsdev, issue a cache flush before
committing fast commit blocks to disk.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index fb9b4e9d82b2..ebe5f423f8f2 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1007,6 +1007,13 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	if (ret)
 		return ret;
 
+	/*
+	 * If file system device is different from journal device, issue a cache
+	 * flush before we start writing fast commit blocks.
+	 */
+	if (journal->j_fs_dev != journal->j_dev)
+		blkdev_issue_flush(journal->j_fs_dev, GFP_NOFS);
+
 	blk_start_plug(&plug);
 	if (sbi->s_fc_bytes == 0) {
 		/*
-- 
2.29.1.341.ge80a0c044ae-goog

