Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8241A1F04
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgDHKq3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45047 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgDHKq3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id n13so1717829pgp.11
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v5Qw9EoH4P+/bTsQks+TZOohVb6qCEbjRC01KIIttQE=;
        b=Jhj6WRjX5waZ5B1zNbrOEhzxEFOwxQdaIK0P1Hax361/V83URLo6jA90Xj/3m5im52
         SJ/B0zXGU8wa2VEGv2Gvo2hWfh+DUI9L5d18SK5lZZ0U8EPIwzapqn6XOtW+DKCSWkiM
         n9vyyWdq044TWfIK36Pn2XRu7WpiWKnpZQ4dJw6SYZHc7LMp+GKGNaVyk2OPkeUNcMQo
         eZNWi/HRwCQrTrF08d6D8dgLkK1JIo95r8IHx8HzUHb5hjPInr66qG9bh8R25GfLn4dg
         rQ2YIRl9iiHeThPLVN+AYSNlixyT2FLQJErgPq/owTAEtrNzcxC05BPAD0hd1GxeHCOu
         HP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v5Qw9EoH4P+/bTsQks+TZOohVb6qCEbjRC01KIIttQE=;
        b=jk6SKSKX9VVHDzyHi9Z/7z9QgG7Hm2tNULH2KEHzccsqqnMOsZSBr9KBwEfLPGaJl6
         8oL0x1YKjTNE37otjHSRjI0J8BUEv9IdXtlvM3f+tpTC5AoZmBdiMW3dXupMfeBRecge
         12/UU9Qz8a+t8uvQJ0zNxNzlgcgdseK1WbbfaANO/Nl9uY+229iNU4n6361tmF25BHZB
         Zk7Q8qzmmaenKHNE+iZeJ15t2Xvb0APEWWt+pMUPkNYe7xU3k6cLJHmL9iUph2y2kEnR
         gzVIKF7ZrawqQ7Ej9o2vXl/seRwLQOKh7cXLY67gIOmVOIMOvKvUtOrUg3vNP+A5l4Zu
         MIzA==
X-Gm-Message-State: AGi0PuaXZvrrL9Pi9dQNsMfXhqsN4XSqjhotPk3/aSVdy575xYzFdJQX
        lwjhFH1Vneie2GQJkn4OhpZR+cxeXxs=
X-Google-Smtp-Source: APiQypLSz0RjIiSii7I1uuRkUdnJ8OzWRVEHIVPrZFCRJUdfQnqRED69qiaUcLVqwQ5mILvODrwo7g==
X-Received: by 2002:a62:2e42:: with SMTP id u63mr7222600pfu.69.1586342788497;
        Wed, 08 Apr 2020 03:46:28 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:27 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 26/46] e2fsck: merge fs flags when threads finish
Date:   Wed,  8 Apr 2020 19:44:54 +0900
Message-Id: <1586342714-12536-27-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 78924b24..4bd1f8be 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2291,6 +2291,7 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	ext2fs_block_bitmap block_map;
 	ext2_badblocks_list badblocks;
 	ext2_dblist dblist;
+	int flags;
 
 	dest_io = dest->io;
 	dest_image_io = dest->image_io;
@@ -2298,6 +2299,7 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	block_map = dest->block_map;
 	badblocks = dest->badblocks;
 	dblist = dest->dblist;
+	flags = dest->flags;
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	dest->io = dest_io;
 	dest->image_io = dest_image_io;
@@ -2305,6 +2307,9 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	dest->block_map = block_map;
 	dest->badblocks = badblocks;
 	dest->dblist = dblist;
+	dest->flags = src->flags | flags;
+	if (!(src->flags & EXT2_FLAG_VALID) || !(flags & EXT2_FLAG_VALID))
+		ext2fs_unmark_valid(dest);
 	/*
 	 * PASS1_MERGE_FS_BITMAP might return directly from this function,
 	 * so please do NOT leave any garbage behind after returning.
-- 
2.25.2

