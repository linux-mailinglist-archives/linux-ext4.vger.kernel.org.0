Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96EF4AC0B3
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 15:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbiBGOHQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 09:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345274AbiBGNkm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 08:40:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CE0C043189;
        Mon,  7 Feb 2022 05:40:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e3so10897665wra.0;
        Mon, 07 Feb 2022 05:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjxTRl/c4nrLxVy+a0+jLX2ZtSQhFhV7DHi5h4ELxr4=;
        b=E+DyHE87RmaOz/LO2EGtRzJ7qReSsX8GI2mSUXxCy4Jb9z8abBB9IjlvhYdkQvxS+d
         R8Sx1RmFrP21229QcZMtsm6EnCbvzpvQ/858oNxuiJxJu0W7LSB/cEhYpk9aT3nMcYWp
         Tqd4zsXOmbtwCbQw+9jJiDJ8mIGtW+1QDwtv29bkCbYPPC9fkqVqtA3MUNZn+OR/rcdu
         bhpBbP24HBiKTqH9nIBcYp9NoGtYXHgqiGso2mxnR9/MIrGUktDn2Si4E1Kfnf3sBbVp
         EVOm61pTbrlOGKDYe9W1xJy9g/tr8ACXWYnALNw2MqAF1oVdfM3lx0f/9FiI96wlgbAe
         UW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjxTRl/c4nrLxVy+a0+jLX2ZtSQhFhV7DHi5h4ELxr4=;
        b=wEQSSkhnC0Ek5Fi79F8i4jfkQccHBPQ52/PM07yt1VkadW8RefytzMi8jbV8NNlxoi
         HNxf+P33U96Zb0gZLyPnKtn3ynVQ0Ztkx4q6BVgg7lVIkRRklTFVs1okxcjv3TBxxQPp
         daswirRuJtwg5OCRHiAjDkHq5sZR6R/TqTMEcQoGb3qyBBcH+NDihNGV4zVvSpEHwrLq
         0voGOYLyKR1RHeFoXS97wVETlhB5k7czO04aLc2N6DREY70DhY3mwQt7kfjv0PRcZQ3k
         DqaXxueUQjU+atTTBJEdCYUCFglc1fjind0yKq7Br5+4bvHWXNIXpvC2WOf6FmIHG9X5
         RI5Q==
X-Gm-Message-State: AOAM531RHYbhf9P/FgYCQRlczdyjtTcLWca/s+/UqgHgPqJgHzo6IHq5
        G/RsPPEgI9+M1li02TQRgmc=
X-Google-Smtp-Source: ABdhPJxsup6qGXdvRsBdbwgeWEnB972cXcL5N67PKOnqUSoTorSOUP3oaLQaaGmhbM1OvqMP/UFcBQ==
X-Received: by 2002:a5d:4528:: with SMTP id j8mr2904210wra.544.1644241240818;
        Mon, 07 Feb 2022 05:40:40 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 24sm1478380wmf.48.2022.02.07.05.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 05:40:40 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jan Kara <jack@suse.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>, linux-ext4@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ext2: remove unused pointer bdi
Date:   Mon,  7 Feb 2022 13:40:39 +0000
Message-Id: <20220207134039.337197-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The call to bdi_congested has been removed and so the bdi pointer
is no longer required. Remove it.

Fixes: 9bbab3a63d49 ("mm/fs: remove bdi_congested() and wb_congested() and related functions")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ext2/ialloc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index d632764da240..998dd2ac8008 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -170,9 +170,6 @@ static void ext2_preread_inode(struct inode *inode)
 	unsigned long offset;
 	unsigned long block;
 	struct ext2_group_desc * gdp;
-	struct backing_dev_info *bdi;
-
-	bdi = inode_to_bdi(inode);
 
 	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
 	gdp = ext2_get_group_desc(inode->i_sb, block_group, NULL);
-- 
2.34.1

