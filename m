Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072221FF6C0
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbgFRP3U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgFRP3S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CD0C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d8so2562632plo.12
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zXDFhC2anvWhs84d4TWDmHEFqzkGFri33k4iQWrCYO0=;
        b=UMcDY/MWVLQCMhftHpGZoJJQFHZS+SmxAV6FTdc3l0uvlolvx+Xb90zVhpF5uNdOHH
         IjkjGu/7FcPXHtbknQmWbgjxEt36u46iOZoLY6cPkgAddiRuMMaR5EZp17kGaNIvmfE9
         IhbxVNxz0IjMNHseRp8fN1X0el+YBQd4JsfacWrzCp683M4P4E4iHL9N/bg/vBo1u+dK
         74sDr5fg6GOziXxKIfRvJ9IeLUcZrToXKznn1AaydFX3PEx07CvIQ966G1diK2mWWX7U
         HIYrwUPzNnIBc8pFbfhzW89ceEwSW2kcIFPMyRD+Hv2m1FJBgTS0XA1miTGc/Ca/mgpn
         Ou0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zXDFhC2anvWhs84d4TWDmHEFqzkGFri33k4iQWrCYO0=;
        b=pIVyjFJwOCMNkwNrdVFLLVhQejnf7lGC4y62J2pJvpKeZrC+KoBZcvVeMWiE5z8yQK
         zs4hxk53Acq0I09wAwrfA9hmE9XKqECoPw8uJEg0quZbs2Q4+aeaVnU57oEjZo1WfjJe
         3XAA0L16uc5gWUj6jO/S+bSFLs2c93dJzfsAQmQOSTEm/lA5eKecVpD4zDkPvV71lT0i
         ryjDintBVlWyYh4REsdErKcDlnD0kbMvGCmqtfg8OWvYEcTBi1JbfIQNdIv1nTPCT+o8
         B0i6bd69UQWkQPBMggxBmXwCLsX275+Y3/H/mAjqrrXvsgNYSfjFREmtXb7ZRK5uwdLp
         gcKw==
X-Gm-Message-State: AOAM532fP5fjRsdxrQctY9Fx3vI04dH2ioXLspDygL1iOGiEtn6/dFdh
        ++N3KO3gRwselF4Qe++ekOthGswvkSI=
X-Google-Smtp-Source: ABdhPJxaVfc+hq0qyoFVxmXhkM/rL8jS7YlIKA0mY0AkuxcdfovJB0BUnAO44dHQd0GZ7Kre1De0Sg==
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr4960228pjq.228.1592494157079;
        Thu, 18 Jun 2020 08:29:17 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:16 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 27/51] LU-8465 e2fsck: merge fs flags when threads finish
Date:   Fri, 19 Jun 2020 00:27:30 +0900
Message-Id: <1592494074-28991-28-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
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
index efab125d..68b7ae26 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2273,6 +2273,7 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	ext2fs_block_bitmap block_map;
 	ext2_badblocks_list badblocks;
 	ext2_dblist dblist;
+	int flags;
 
 	dest_io = dest->io;
 	dest_image_io = dest->image_io;
@@ -2280,6 +2281,7 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	block_map = dest->block_map;
 	badblocks = dest->badblocks;
 	dblist = dest->dblist;
+	flags = dest->flags;
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	dest->io = dest_io;
 	dest->image_io = dest_image_io;
@@ -2287,6 +2289,9 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
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
2.25.4

