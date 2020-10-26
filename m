Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285DB298FAD
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Oct 2020 15:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781851AbgJZOnY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Oct 2020 10:43:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43326 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781849AbgJZOnY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Oct 2020 10:43:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id r10so6173597pgb.10
        for <linux-ext4@vger.kernel.org>; Mon, 26 Oct 2020 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hxHhfkEtzQWL1nwqYRMUHPqHdjjgwI26d8k21gEPl14=;
        b=R2SKN9ByJN/UvDaCHi7cFWwr3OajAeIvPDz1MqNi1MGTsXqG9iLcpBACNEb6UsxMb4
         XA34mGMhLpS62PuxJTBFEFoUsS9Hfxr5ynZSKBkOqnz8dhZXts9hhit7GDBJFrpexgRf
         YpiNBXo5PydaFP7/G7hImkt4GFWXsJ4gxEU0GtZl9RqQeBeq9JER/2yc6+5Lp8MqMsan
         dEgfP3HqXjnuFiiud8gQg4Jjswg742e1Lk7Bx5sGV0PZKRXzEFaTlY6S/i+lUBJrQAIQ
         6zjHWxyA9ZfHtmN3145uvHIp5a+VpovYfRYKeJ9AJdxcVVFFSVUpfpokImsr5EilGNG5
         fQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hxHhfkEtzQWL1nwqYRMUHPqHdjjgwI26d8k21gEPl14=;
        b=eT2KHaDYswygLDVKQPLxCQtZiWNtEQB3JI7ouP3HndiQf0e7anRwOwkBCDQYxSZnS5
         GyDpVrRKXdYhFVtEn9FU3ZXNMOSg83NRTrincyi6dsuCtrzVqgDp6NjM5x/YcwnES2+G
         hTFkUle4TmFfNuQuN2mSSbpI0K0kXCLnvJZ7N/KTOGwxxfIKbifTc1KuXoNHJVKwkapt
         LozmFR2sh1dgSnRYXpSJpihcXqGXx7X0RtMQoech4iS9+TCCFEkUFB+5/C8CQ4x/8sNg
         4grpYAIp4rOpHYKpIOS+qB2wSOfp5G+z7SY1RhP9Qwz5x7m9d1a6dAI1jo6GfVRY5Ezi
         J8qQ==
X-Gm-Message-State: AOAM532fTxhzDX9rKfN4EGnxExLEsnY/+TQMmM7mqwgVi9LXeW3UH7iR
        qrr+f9PS5+wRQGhSV+CYV5m4WS225g==
X-Google-Smtp-Source: ABdhPJwGEwmjm/Sj0fb9uWK2WKXl7ApRm+8yzEDJi6V6FqCRMV3KsGBeSnFUt+PNaeP7GHQMkjw0LA==
X-Received: by 2002:a65:688a:: with SMTP id e10mr16759978pgt.347.1603723403539;
        Mon, 26 Oct 2020 07:43:23 -0700 (PDT)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id v79sm8596712pfc.197.2020.10.26.07.43.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:43:22 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] ext4: do the quotafile name safe check before allocating new string
Date:   Mon, 26 Oct 2020 22:43:17 +0800
Message-Id: <1603723397-14344-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Now we do the quotafile name safe check after allocating the new string
by using kmalloc(), and have to release the string with kfree() if check
fails. Maybe we can check them before allocating memory and directly
return error if check fails to avoid the unnecessary kmalloc()/kfree()
operations.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 fs/ext4/super.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5308f0d5fb5a..83fdde498414 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1861,7 +1861,6 @@ static int set_qf_name(struct super_block *sb, int qtype, substring_t *args)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	char *qname, *old_qname = get_qf_name(sb, sbi, qtype);
-	int ret = -1;
 
 	if (sb_any_quota_loaded(sb) && !old_qname) {
 		ext4_msg(sb, KERN_ERR,
@@ -1874,32 +1873,30 @@ static int set_qf_name(struct super_block *sb, int qtype, substring_t *args)
 			 "ignored when QUOTA feature is enabled");
 		return 1;
 	}
-	qname = match_strdup(args);
-	if (!qname) {
-		ext4_msg(sb, KERN_ERR,
-			"Not enough memory for storing quotafile name");
-		return -1;
-	}
 	if (old_qname) {
-		if (strcmp(old_qname, qname) == 0)
-			ret = 1;
-		else
+		if (strlen(old_qname) != args->to - args->from ||
+		    strncmp(old_qname, args->from, args->to - args->from)) {
 			ext4_msg(sb, KERN_ERR,
 				 "%s quota file already specified",
 				 QTYPE2NAME(qtype));
-		goto errout;
+			return -1;
+		}
+		return 1;
 	}
-	if (strchr(qname, '/')) {
+	if (strnchr(args->from, args->to - args->from, '/')) {
 		ext4_msg(sb, KERN_ERR,
 			"quotafile must be on filesystem root");
-		goto errout;
+		return -1;
+	}
+	qname = match_strdup(args);
+	if (!qname) {
+		ext4_msg(sb, KERN_ERR,
+			"Not enough memory for storing quotafile name");
+		return -1;
 	}
 	rcu_assign_pointer(sbi->s_qf_names[qtype], qname);
 	set_opt(sb, QUOTA);
 	return 1;
-errout:
-	kfree(qname);
-	return ret;
 }
 
 static int clear_qf_name(struct super_block *sb, int qtype)
-- 
2.20.0

