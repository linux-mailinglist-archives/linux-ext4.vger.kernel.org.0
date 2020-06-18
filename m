Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680091FF6A5
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbgFRP2b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbgFRP2a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57500C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh7so2560977plb.11
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2UsC5lTr0bcNjJV62I2fFugZZTe4YJl132Inff6C7sk=;
        b=upqz7xGNsBpdK7ys1JR6aPxrq72nw/AQGv5lbUSHhoWNGPnjifhBOSxqSNb72DQMQ6
         q4NyPjxzn0dZ/j2dx+Iao6Er2ZKzWco64JoPTUDyuSS+dv2X4g4hz61mUDDsPW316WuM
         rW28A4Gi2KbRqmL5yBflVZtab22+zQWQ9o4SRlTYu/XjhiUrk8XW9eyXvnF+4kEhbRP1
         OHN2zXGUL/JquonIJKIAPAP4C2x02b7+7oIX8KRB1gOmQEg+zfMfncNNB+mSNfJLDA0F
         6+WO8zRdzQ0tQk6pnM9xpg0TikYLJyBBOpSuKiPFH/4CUp/t3hnj5FvRm3LE90j7lqOm
         EWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2UsC5lTr0bcNjJV62I2fFugZZTe4YJl132Inff6C7sk=;
        b=LdrsXsrUvFMii18ZjY3YPMyqOHtNihpYd+WRN2jpasgYcgHhjAzCAlJo2RY4a6IoI1
         M9CLIFxj80hjxGYLOBc8cr+TQInQ54dgyK85VPE6FdMHxR8CWHJK7CDWABQaKhKjrjvV
         gqjacnHlVZ3dgFyNBjn069mFVCHSiLy2yu90r1CUh3sYHhyUA4gYlGI9WAqwl+unvbRp
         dOd80JOl2aBWhNmPrHZo+9tIGgLPediEj+lR8Xls+LA5l45G+RnkfAWEU9sWE+JHcpIP
         DIzT3f5ckOmG7RINvWpwOiuRKry8Ba+g7ngMNKfwisMwjCDoqn8ireSq7tzzEwHBgqQV
         vprw==
X-Gm-Message-State: AOAM533Cxx8gKCYe4WpxqiLyHwhK+bRn3rcSZmVgDbegNch1JZgpkZ2l
        WWura/+WJLlBvl7Mba8kCxHkvCWx0so=
X-Google-Smtp-Source: ABdhPJzyI0i1KsjHQZr8yfGY5okTnnPQBpPc0bz2QPXO5JSJ5QSEWUwBLNkb7/dhsXuQuuttmp99ew==
X-Received: by 2002:a17:90a:bf07:: with SMTP id c7mr4815468pjs.233.1592494109643;
        Thu, 18 Jun 2020 08:28:29 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:29 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 07/51] e2fsck: clear icache when using multi-thread fsck
Date:   Fri, 19 Jun 2020 00:27:10 +0900
Message-Id: <1592494074-28991-8-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

icache of fs will be rebuilt when needed, so after copying
fs, icache can be inited to NULL.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index b212cdde..22597b12 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2102,6 +2102,13 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 		dest->inode_map->fs = dest;
 	if (dest->block_map)
 		dest->block_map->fs = dest;
+
+	/* icache will be rebuilt if needed, so do not copy from @src */
+	if (src->icache) {
+		ext2fs_free_inode_cache(src->icache);
+		src->icache = NULL;
+	}
+	dest->icache = NULL;
 	return 0;
 }
 
@@ -2116,6 +2123,13 @@ static void e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 		dest->inode_map->fs = dest;
 	if (dest->block_map)
 		dest->block_map->fs = dest;
+
+	/* icache will be rebuilt if needed, so do not copy from @src */
+	if (src->icache) {
+		ext2fs_free_inode_cache(src->icache);
+		src->icache = NULL;
+	}
+	dest->icache = NULL;
 }
 
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
-- 
2.25.4

