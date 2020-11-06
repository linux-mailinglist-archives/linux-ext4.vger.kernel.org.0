Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561D82A8DE1
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKFD7o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKFD7o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:44 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E89C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:44 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 1so59525ple.2
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o1hNTWuZXMab/Dt1l/MXT88sMTPz21/OUhYLzdfGl2o=;
        b=nYSaqO0s6iTf0gyDGxLQCZj5/WxOoPnK6uDaGZ8Z0Ijdh3T8iFlBNbfr8R4E2ZBjTq
         r5bG0U3t3nHpbC0E2XHP0H1l3QGuuqW74fnLqKqKlwL8OuF6gY98B7k3i5C3HgEWqWqa
         DDTFDRZiL4YOi/cqZAtDRIblk8TMZkyGfsowQa0iNGwSRfeMvwHKn96pZPrtZCMzTYlS
         W45Znig+1Non1zJ52o9cjkuoHxOhUBL3fOOhpOHJ/yiv5Cn4S3DtJJa3r0pNImGb7/Dq
         JX2vPNH4R/cS+H10VxUFRO9pyYKsAsce1/xrpX0dsKp2Sdyq2VJZ+bOgoRAQnpMSEFMG
         YBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1hNTWuZXMab/Dt1l/MXT88sMTPz21/OUhYLzdfGl2o=;
        b=MFDUwe7Bbq7/yfPDbXRo0QmPrCOCwTVt1p+Fse0rIrvQH4C5nQ/y6bjZkxh0ZkCwr4
         BYhAwYgratFcc97+pNOklS3RiZtumweyPe9RcbJR3eA/inhIb96QzCiVNW6TlF7Uwt5I
         Qi+emf4POMKVukJYIjoIWjTdjyeipr8ZujehwgHdyEy9bQjjXYivyOTaLoIxprf92DWV
         mXSVPIDa+v+87Z9b373yavq1jisUQGEIYpTX+d9sYQIj9HZQTKB3IP4FVscPqGvUEx7p
         1gg1iLeipA3sGCuQzIKZ3s4JL2ekiyHFNJb7BhaMcb3GqPsEXtVU2WUdNlRfiy1pqKq2
         Zgnw==
X-Gm-Message-State: AOAM533QlYtLtET0WaCKmzxFqtpAbrC48Y6hSZZXNT9mPtkjUpwPCufp
        GpJp6SEHl1Aa+gmWqSaP+UZptMznucY=
X-Google-Smtp-Source: ABdhPJySxTWUIY8nrNpypTu6tJu76tDGIDiqdUfUYk/9PerDduhH5xR8QyA54XhrOT1VwoYbhFpF2Q==
X-Received: by 2002:a17:902:934b:b029:d4:e4c7:26f5 with SMTP id g11-20020a170902934bb02900d4e4c726f5mr205689plp.60.1604635183336;
        Thu, 05 Nov 2020 19:59:43 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:42 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 15/22] ext4: mark buf dirty before submitting fast commit buffer
Date:   Thu,  5 Nov 2020 19:59:04 -0800
Message-Id: <20201106035911.1942128-16-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Mark the fast commit buffer as dirty before submission.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 639b2a308c7b..05e6e76a7663 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -546,7 +546,7 @@ static void ext4_fc_submit_bh(struct super_block *sb)
 	if (test_opt(sb, BARRIER))
 		write_flags |= REQ_FUA | REQ_PREFLUSH;
 	lock_buffer(bh);
-	clear_buffer_dirty(bh);
+	set_buffer_dirty(bh);
 	set_buffer_uptodate(bh);
 	bh->b_end_io = ext4_end_buffer_io_sync;
 	submit_bh(REQ_OP_WRITE, write_flags, bh);
-- 
2.29.1.341.ge80a0c044ae-goog

