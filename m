Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA63FB21B
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Aug 2021 09:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhH3HzE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Aug 2021 03:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbhH3HzE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Aug 2021 03:55:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0E1C061575;
        Mon, 30 Aug 2021 00:54:10 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n18so12587682pgm.12;
        Mon, 30 Aug 2021 00:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ER+kCRg99KYDhBJ08lsNKniWHs69wufwQEO9zrHT00A=;
        b=mGpG3QDLe1ctEL0r/BxPZmMQ/uVPBtcvPCvg+Vf/KRfT2qMiMKsgQ0r4/UvFUNJNyc
         RtE4Yl66sV9ODJN/UNZXTAqg3Oc++D8GrKKl1qOf1OepEkgzFfpbskAQoeIOBIaeZLzV
         2NmG+W2wTwWmqHpjKvslMzf4h180y9a8Bfb9mfWi0hrESWxeCNspekdLcQfiaMv6ORWa
         2xnymlfe1j4t3nM7Iq8K5ZrkGB3F1TrfQVb+tOcZnhRNw3eBo5Uw96uWYzk90hgvAJcp
         wD/lb/RYvjtd/ErMpDxF4dhmGUcrtG1LIAxYooRPT2kDGdkBR0NWaXylZPtgOadK5CIw
         LdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ER+kCRg99KYDhBJ08lsNKniWHs69wufwQEO9zrHT00A=;
        b=tPpe85T3dgBe1rPPCrw82JkLDSHrRX88Qchf5XwDC5Epmd62us7fD5aFqDQB1Rt67V
         5E/aFRBtcgqQINUQJTlrK9biLEbHfT83B+TU1df1DaFomxVS0GIfUm3kZu6QUJFoKXQD
         Dy/3WJbBs2X84Z32l9EB1L80lyQNcDPqQFm4AD03cgirIbR13PEpHDeP1onJz11MWM3N
         mF1bBmTs+fzCaswBcttXu85vrgv1pXTnEpwdeYf0DLiXiHB79wvb3aCCpwA+IgZoL1Sm
         Hl/GI9H7NxEchGQqrD2atGT/dQjt91BhO7KCk//p8cDMt7/KVUvROh6BXjgjeUvFrN1G
         xQ0Q==
X-Gm-Message-State: AOAM530eHYDhqIzIbTEGSurJELaOlHFT5pNgNUkF/0OXpxfqdZ8yZn/d
        JUZj3gOyMYYSBn990dj/Wzk=
X-Google-Smtp-Source: ABdhPJzfAh4i79OUixt2ao7hSfASOl3rzZUy5kHwEblm518dkxqNOAeI7pUNvRVzMb481JLi6yutrQ==
X-Received: by 2002:a63:5c04:: with SMTP id q4mr20301571pgb.127.1630310049868;
        Mon, 30 Aug 2021 00:54:09 -0700 (PDT)
Received: from localhost.localdomain ([162.219.34.245])
        by smtp.gmail.com with ESMTPSA id b17sm16260839pgl.61.2021.08.30.00.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:54:09 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, guoqing.jiang@linux.dev,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH V4 1/5] ext4: remove the 'group' parameter of ext4_trim_extent
Date:   Mon, 30 Aug 2021 15:52:42 +0800
Message-Id: <20210830075246.12516-2-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830075246.12516-1-jianchao.wan9@gmail.com>
References: <20210830075246.12516-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

Get rid of the 'group' parameter of ext4_trim_extent as we can get
it from the 'e4b'.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/mballoc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 089c958aa2c3..09fb0223afaa 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6183,7 +6183,6 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
  * @sb:		super block for the file system
  * @start:	starting block of the free extent in the alloc. group
  * @count:	number of blocks to TRIM
- * @group:	alloc. group we are working with
  * @e4b:	ext4 buddy for the group
  *
  * Trim "count" blocks starting at "start" in the "group". To assure that no
@@ -6191,11 +6190,12 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
  * be called with under the group lock.
  */
 static int ext4_trim_extent(struct super_block *sb, int start, int count,
-			     ext4_group_t group, struct ext4_buddy *e4b)
+			struct ext4_buddy *e4b)
 __releases(bitlock)
 __acquires(bitlock)
 {
 	struct ext4_free_extent ex;
+	ext4_group_t group = e4b->bd_group;
 	int ret = 0;
 
 	trace_ext4_trim_extent(sb, group, start, count);
@@ -6271,8 +6271,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		next = mb_find_next_bit(bitmap, max + 1, start);
 
 		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start,
-					       next - start, group, &e4b);
+			ret = ext4_trim_extent(sb, start, next - start, &e4b);
 			if (ret && ret != -EOPNOTSUPP)
 				break;
 			ret = 0;
-- 
2.17.1

