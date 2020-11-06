Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45282A8DDC
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKFD7g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKFD7g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:36 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8823AC0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:36 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f38so2943386pgm.2
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eBPI3ZBxhtZbNjIqwtwWd3sK+y4M9+V4X0Z1cP/Nej4=;
        b=SJWQYKtglTh6G16kGhSwZzOt6ycgDQZT+7ezJXe30V66lW+xA6/HvG2tBPcswbY9po
         Mue7DkOlUh4x5HtmI4XYM1Bd63BO3P04Sta/Cbdll3bxu8Xrw/PiiCDEyu6WrVgRFKEF
         1AW1K4MdhY1oeKOfchqSQHQK23D7yn2HUx2p5NfJAOYT1U2QfrNBSsHUp211R6pGiKB0
         FKJfppag5Bd1wZ5e1OWKeVdQOnvaEOjFC4Jq5NqFWprpDzFgJGKCBZ6y2A3QFc3XB/ez
         Ex2HTkc1rJkzTG0su6NTg0qehpPLo7//YEFZ4G9h9eHbnUFRAjdq0fwOWflHbJcZCoPx
         FyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eBPI3ZBxhtZbNjIqwtwWd3sK+y4M9+V4X0Z1cP/Nej4=;
        b=VJmUGej2/u0bCxvdNqZ9/wpMfcPeOg/FD3Zchi8OnvLQu5XrRY11YPtKAwsBYlaBJn
         5tUXZ2HK6VSG4fMTTFz4Hj4+dJARFQYcaXk86iDoH4EuCzYUoy290g3tBJW23vrEUCZo
         M9c1we/X8pwuaoH6rD3I1t3Ut4KLdyS92doswLdu5txa+tSDVPaDYuXIzIYEKayPv5fl
         jPv56TK1HT16jh5BcvTDbnik0H04x0BqbACye2uSU0rqiU6djHA2LQG9wegqXmRTFqAX
         OfEA+A3Iz4al/6u9LGzLmm7ItIIzhVnvxTpPPgMyvlMKO+EGkZvS7nH8uTO8Il68Zq99
         RvLQ==
X-Gm-Message-State: AOAM533i+p6SRXttDK/p4nco6iRPiTchIg7zMV8tp+MM051G32yo4tsh
        8AtiGxuNTj4wtLLXJGaMvHQJL1POTng=
X-Google-Smtp-Source: ABdhPJyngnJlCFaufRngKSkNrCqYzwPnwOskra0uvT4JgPyxbfmyrxgZ/x3WWCRdTrNACOPZIIjVdQ==
X-Received: by 2002:a17:90a:6e4:: with SMTP id k91mr243194pjk.207.1604635175717;
        Thu, 05 Nov 2020 19:59:35 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:34 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 10/22] jbd2: add todo for a fast commit  performance optimization
Date:   Thu,  5 Nov 2020 19:58:59 -0800
Message-Id: <20201106035911.1942128-11-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fast commit performance can be optimized if commit thread doesn't wait
for ongoing fast commits to complete until the transaction enters
T_FLUSH state. Document this optimization.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/commit.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index ec516490cb35..b121d7d434c6 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -450,6 +450,15 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		schedule();
 		write_lock(&journal->j_state_lock);
 		finish_wait(&journal->j_fc_wait, &wait);
+		/*
+		 * TODO: by blocking fast commits here, we are increasing
+		 * fsync() latency slightly. Strictly speaking, we don't need
+		 * to block fast commits until the transaction enters T_FLUSH
+		 * state. So an optimization is possible where we block new fast
+		 * commits here and wait for existing ones to complete
+		 * just before we enter T_FLUSH. That way, the existing fast
+		 * commits and this full commit can proceed parallely.
+		 */
 	}
 	write_unlock(&journal->j_state_lock);
 
-- 
2.29.1.341.ge80a0c044ae-goog

