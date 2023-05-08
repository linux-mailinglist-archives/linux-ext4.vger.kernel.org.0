Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032F46FB3FF
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 17:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjEHPmp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 11:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbjEHPml (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 11:42:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2398A43
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 08:42:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ecb137af7eso5298375e87.2
        for <linux-ext4@vger.kernel.org>; Mon, 08 May 2023 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683560557; x=1686152557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FU6EHWNA/ZJjytuM5E9VAI+4DmX405CfGxj58LK4Eyo=;
        b=EAldLblQYvS+wVyknUHJoDFxAGwtiAf0rwgsoVXZytTk1LG0uIztmgbjlbGVWime5l
         ypalVaHtZ7PFNh6PDYY75A6zdQOnDrapGt6o7L4Hz2XZw9tkCctQe1+4N25aF6UrkgGQ
         Ohx7z0uZyJEmWBc1SQyYIY2abLBL1ov42NkeADA2OciImVZ1NUZw7LmWdFTESjuyjQqS
         FBdTpPhqgDueUqfQXWjxaIze6+4zOlvRsDt4xvdDPZeZ5cLQ/GKG/yLbygwOslZpkXoO
         cEy3wnkZxB7WxdTsgbrW4zOKm9gSSONVrGaf2xN4scBfQ5CRoIZKkQ8Q7lDPA/24T4KT
         1gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560557; x=1686152557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FU6EHWNA/ZJjytuM5E9VAI+4DmX405CfGxj58LK4Eyo=;
        b=ChxLoRH1n3RExFKc+lN5KtW4Pk8qy5+jCncYT1fWq9cfIAQlWdz0H2CdxfUcTsHClF
         JCizlnl5kLOmjGTrVsrlOj+nX4aOCkwD+TeyGHIJPG98L+pxfmoRJRuPB+y+x5SGOuYn
         BuVNhMUvoCkXuXz+NlFEn/Vlir0a6pKU1Al9rQtmJ+zizOBcEIjaG6Iuan1hHX7RyUN2
         +Jq7zbt2/4HLtKDvHl7Q6XMokzRRYED0SZMVsYFYo0dKnafXTsw8Z6esLhZgaxQNp/yz
         DJPcK+y2+lJ2Y3My0kFTpex0MYfC+5POaBsizJZFjM8SI/DUmvMsroiSL13i7yW71qy3
         +NIg==
X-Gm-Message-State: AC+VfDywLZ46lUwDUttYpRhNT50zhD457HNnlEPU+A8OfgOpgaq/yOZq
        EfUSF+wZYjPu9eCHcAb9HcaN3Jm7lhZk4W2M6cQ4Gw==
X-Google-Smtp-Source: ACHHUZ4T7CTNraB+2LfhWsXpwhtPcNZgJHd9kL8CeDGEh5+f+CM7xQc4U3YoRg0WNDZ1pT4H20tdog==
X-Received: by 2002:a2e:84c8:0:b0:2aa:4550:916c with SMTP id q8-20020a2e84c8000000b002aa4550916cmr2781982ljh.53.1683560557480;
        Mon, 08 May 2023 08:42:37 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id a21-20020a2e9815000000b002ad9b741959sm17720ljj.76.2023.05.08.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:42:36 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joneslee@google.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v2 2/5] ext4: fsmap: Check fmh_iflags value directly on the user copied data
Date:   Mon,  8 May 2023 15:42:27 +0000
Message-ID: <20230508154230.159654-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230508154230.159654-1-tudor.ambarus@linaro.org>
References: <20230508154230.159654-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

struct ext4_fsmap_head is the ext4 internal fsmap representation of
struct fsmap_head. As the code was, the fmh_iflags validation was done
on the fmh_iflags value of the internal fsmap representation. Since
xhead.fmh_iflags is initialized with head.fmh_iflags and not changed
afterwards, do the validation of fmh_iflags directly on fsmap_head data,
it spares some superfluous initializations in case the user provides a
wrong value for fmh_iflags.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/fsmap.c | 2 --
 fs/ext4/ioctl.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index cdf9bfe10137..7765293bfa5d 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -635,8 +635,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	int i;
 	int error = 0;
 
-	if (head->fmh_iflags & ~FMH_IF_VALID)
-		return -EINVAL;
 	if (!ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[0]) ||
 	    !ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[1]))
 		return -EINVAL;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 6d5210b94ac2..a585d96567b5 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -873,6 +873,8 @@ static int ext4_ioc_getfsmap(struct super_block *sb,
 
 	if (copy_from_user(&head, arg, sizeof(struct fsmap_head)))
 		return -EFAULT;
+	if (head.fmh_iflags & ~FMH_IF_VALID)
+		return -EINVAL;
 	if (memchr_inv(head.fmh_reserved, 0, sizeof(head.fmh_reserved)) ||
 	    memchr_inv(head.fmh_keys[0].fmr_reserved, 0,
 		       sizeof(head.fmh_keys[0].fmr_reserved)) ||
-- 
2.40.1.521.gf1e218fcd8-goog

