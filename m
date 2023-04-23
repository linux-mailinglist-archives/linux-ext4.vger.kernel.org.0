Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08D36EBDF5
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Apr 2023 10:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjDWIZs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 04:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWIZr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 04:25:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4404C198B
        for <linux-ext4@vger.kernel.org>; Sun, 23 Apr 2023 01:25:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f1950f569eso12186405e9.2
        for <linux-ext4@vger.kernel.org>; Sun, 23 Apr 2023 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682238344; x=1684830344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4x4Kv1RaCy6lG2iFUrXPjjtV4EerznzunSsPqh8ZCU8=;
        b=AwubQXzV6VxxvXjqLenmufrlUar8bgbYQ/8OTGLayii6dxyHxZ4XbGOdoiq547wxJb
         MfA3RvGCaFubb8HAi5EThqjVslJT7GWI8HV7rvhuHe4Gj1oARE/1fNPXA/Zcr8CnkAJx
         jcRA1VyhUjJwP5Lrj3iIssCHp0AEpmXuymB9wWdbwXHB/vL7+HYFpXC0v6tphpno57rm
         m+RgFhMDeKH3u34D26/IOg+nAAVPx+lukfH7rywO9O8N4Nhw6kfhkFGmcGYQhfnEGSnS
         vf4oGBdcJ9ULQwBChT8EDrRK++AwITWUIPrUXK3LzqFg9Hwf44WuTL6un3dbGhN+5jqb
         nEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682238344; x=1684830344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4x4Kv1RaCy6lG2iFUrXPjjtV4EerznzunSsPqh8ZCU8=;
        b=eu9iCjfCmFi3VU0jB5VjetCTqgT0okVFFf26EZjlXmLmGEyA+j9XAyjlUo1Io6Qu+P
         Qt6fTQnbmtoGQGYm8DZpaYJD/gj7sjL901MWOq4aZdrG2UQ+1GRFvM6hfheXWAwLQLFS
         VBimlsctiyGCak9GGTcqDWVgHufL3Nz/M3cA38U6JIQG8H0Y6gdaBj2t6s2tV+BPCJh7
         J4FJKngfnHsKFg8aB92ZvxUqe7MLrDOGeNSilVaDCkFOSntwMKm6LqnDgukUC8rd+pQ6
         N+e++VNguqTESmpOJbJ9jVSsrRRAG1wksLEdWc/PER3ixBsyv0GDbhsHqiylW4qZauC9
         WVgw==
X-Gm-Message-State: AAQBX9eDeKR8XovjWtCpeGeDPDaBgHg/bdAMYc37r9VJvcAClNx0kRnW
        0KTQYp/tKDXNVwyS4JjIAQTby7iSN05dVA==
X-Google-Smtp-Source: AKy350bk6JXNhZAgZ0rjomynlM8n39s3Dx0PkSm8Fdc7RNm+qenvOSJAQRH1c6Uudhmv5577cv2VoQ==
X-Received: by 2002:a05:6000:1819:b0:300:2067:f5d8 with SMTP id m25-20020a056000181900b003002067f5d8mr7571030wrh.65.1682238344184;
        Sun, 23 Apr 2023 01:25:44 -0700 (PDT)
Received: from localhost.localdomain ([213.177.197.108])
        by smtp.gmail.com with ESMTPSA id i40-20020a05600c4b2800b003ee6aa4e6a9sm12389153wmp.5.2023.04.23.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 01:25:43 -0700 (PDT)
From:   =?UTF-8?q?Oscar=20Megia=20L=C3=B3pez?= <megia.oscar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     =?UTF-8?q?Oscar=20Megia=20L=C3=B3pez?= <megia.oscar@gmail.com>
Subject: [PATCH 1/1] e2fsck: Add percent to files and blocks feature
Date:   Sun, 23 Apr 2023 10:23:49 +0200
Message-Id: <20230423082349.53474-2-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230423082349.53474-1-megia.oscar@gmail.com>
References: <20230423082349.53474-1-megia.oscar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I need percentages to see how disk is occupied.
Used and maximum are good, but humans work better with percentages.

When my linux boots,
I haven't enough time to remember numbers and calculate.

My PC is very fast. I can only see the message for one or two seconds.

If also I would see percentages for me would be perfect.

I think that this feature is going to be good for everyone.

Signed-off-by: Oscar Megia López <megia.oscar@gmail.com>
---
 e2fsck/unix.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index e5b672a2..b820ca8d 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -350,6 +350,8 @@ static void check_if_skip(e2fsck_t ctx)
 	int defer_check_on_battery;
 	int broken_system_clock;
 	time_t lastcheck;
+	char percent_files[9];
+	char percent_blocks[9];
 
 	if (ctx->flags & E2F_FLAG_PROBLEMS_FIXED)
 		return;
@@ -442,14 +444,33 @@ static void check_if_skip(e2fsck_t ctx)
 		ext2fs_mark_super_dirty(fs);
 	}
 
+	/* Calculate percentages */
+	if (fs->super->s_inodes_count > 0) {
+		snprintf(percent_files, sizeof(percent_files), " (%u%%) ",
+		((fs->super->s_inodes_count - fs->super->s_free_inodes_count) * 100) /
+		fs->super->s_inodes_count);
+	} else {
+		snprintf(percent_files, sizeof(percent_files), " ");
+	}
+
+	if (ext2fs_blocks_count(fs->super) > 0) {
+		snprintf(percent_blocks, sizeof(percent_blocks), " (%llu%%) ",
+		(unsigned long long) ((ext2fs_blocks_count(fs->super) -
+		ext2fs_free_blocks_count(fs->super)) * 100) / ext2fs_blocks_count(fs->super));
+	} else {
+		snprintf(percent_blocks, sizeof(percent_blocks), " ");
+	}
+
 	/* Print the summary message when we're skipping a full check */
-	log_out(ctx, _("%s: clean, %u/%u files, %llu/%llu blocks"),
+	log_out(ctx, _("%s: clean, %u/%u%sfiles, %llu/%llu%sblocks"),
 		ctx->device_name,
 		fs->super->s_inodes_count - fs->super->s_free_inodes_count,
 		fs->super->s_inodes_count,
+		percent_files,
 		(unsigned long long) ext2fs_blocks_count(fs->super) -
 		ext2fs_free_blocks_count(fs->super),
-		(unsigned long long) ext2fs_blocks_count(fs->super));
+		(unsigned long long) ext2fs_blocks_count(fs->super),
+		percent_blocks);
 	next_check = 100000;
 	if (fs->super->s_max_mnt_count > 0) {
 		next_check = fs->super->s_max_mnt_count - fs->super->s_mnt_count;
-- 
2.40.0

