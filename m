Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54EB1A1EF0
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgDHKpr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:45:47 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40202 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDHKpr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:45:47 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so996833pjb.5
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=POJHMabIZ8KwFcNcEOZj0UEMAUO9xdB4xE8m54J3PJI=;
        b=ODGvkFuw6cIEZexXpiNE6uZEiemBwLLHgyQGiYQgJh4g46KGo5OVMxMvhxFw+BcXku
         kEC2TI8TKirPooP98RBMzvQm3xHkguffeYTiTiEIcoR8cVUBWJcd5iGWmGdi4CGQ9Iq5
         kdnxDe71b25uTtdmK956Yc8Vh+EMjUAXsasCsM16BgAiC1qhddj27qSI/CwvAv8gzufH
         6i5JmCsevJ+HhXnRUSsgEetdJvRy81mlZGZwyagEJzS1ayP6K3FSXTPaFZtcXj3J2XC+
         FqDMxK7WPfF1dXobnqJFZRDMQ/iUpkJDa3wlsm7hyjM2R6iVsppnRwg07vZ9ApqUb0D5
         S6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=POJHMabIZ8KwFcNcEOZj0UEMAUO9xdB4xE8m54J3PJI=;
        b=n6xNn8my6pJ8RSrFw8ixZ9Z35025Zbz5lT+q7QUR4F5L/MUqogCVYsenNHb4Ks4EuC
         WNNjD3W9FhV13tdImXdkcfUKfqK8rolKBBbrcU4vVMoVsoYga+L4kS50bhNB3su8yl6e
         4yYPPLuZXSqWg3iO5ZaomJ9/nQng+iysBS23SaMQR1cQhBl41xXORmc4dK6wHCsHpTlt
         rWi6ocGG8oqif+w0i/faRWWlilqC4LoL3JHvv4LMNhbYPf7y/UsPGtYi7eaPugYYJcYD
         cma93tb5SjfEn61GN+cvXCYXexwRvDygVNZDWkao6G8fP3bIYMP4YenNeJy65Heur8Eb
         g5PA==
X-Gm-Message-State: AGi0PuZq0q0liXJ71xk23+laaguOnCDBhsxHpfNGr8KZG56iYb6FKJaU
        X/F+scrsc3e7eBYwHXvBb36eb1iFrbM=
X-Google-Smtp-Source: APiQypKL9eQHc9iHG9UFkQaZALDlLcjbKVgncxylsICEs142NMxfPAodQtUBtQNQ9YCfC1FSRQRbFg==
X-Received: by 2002:a17:902:b941:: with SMTP id h1mr6472785pls.329.1586342745820;
        Wed, 08 Apr 2020 03:45:45 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:45:45 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 06/46] e2fsck: clear icache when using multi-thread fsck
Date:   Wed,  8 Apr 2020 19:44:34 +0900
Message-Id: <1586342714-12536-7-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index baf720ce..599c69aa 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2120,6 +2120,13 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
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
 
@@ -2134,6 +2141,13 @@ static void e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
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
2.25.2

