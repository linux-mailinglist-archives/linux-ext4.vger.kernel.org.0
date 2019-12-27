Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC4A612B28A
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 09:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfL0IFl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 03:05:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45973 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfL0IFk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Dec 2019 03:05:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so14083032pgk.12
        for <linux-ext4@vger.kernel.org>; Fri, 27 Dec 2019 00:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ueKguZLzy18z12qXeVNc9OiGCJRatlfdVYkk0am1Q9o=;
        b=sbUHdutjOW+gNWIDO8E6PvcjtjstTml02xLxuI5RkpIwNZd3RGyjTZkDZER1s4MP4X
         SukBu+4wPbo2DQunXZZrN/yEYH78LP+1q+gIZG/q89CojrYbqN4FV+qt+P8yHT14bBJM
         N8kRC3TDHtjLpsPSyRQBTIpQ7xQa6AcJ67Cp2BBxMoi3c5pPw74hCksSo7Ysord2gq67
         bDEIBMh1tkQzX285+LfCxlXx1a5A9G4Zu2VhdAbe2+49tvsKfRMJI5QwXYDFnVbBKf7u
         Ly8+wZQ5bJ+mKji7HKZbogQCyAgOqj2uAFSz+NvpzluS5VfHKqhx8rp62FtWUlOfWWij
         lliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ueKguZLzy18z12qXeVNc9OiGCJRatlfdVYkk0am1Q9o=;
        b=I4mzM7oJUxhGzUsowUWURszZxSNvbuzUS+1uY6fx3PidQsUCFPcS11eygL/2WWVNvz
         kFKL6PPPwfo2ZcgQMkZs0Yi0a7UnTkrdm+nzWUYl7BMpu+ziv0CiaZYNzup7Fhd9EvVE
         O09chpBLmiLjdqlr2OuPnnz3RDkRCA0xgIv8bZuwUwbhlKz+4+VEJiMvfgGiYyjWPKoO
         2L8DfK+d/n8VC3Y9cQPWD/AP+ML8FLUphI4IPYCVWtMVzZ7ApqGcwTQ7xZBKBqweqqjA
         AEFkgT98ME4p4CpxW0DAbnEIHrQpwSnYzjxqzhqnHVR+3T40puQC8pYfYPr3RZOtK+sI
         8Ftw==
X-Gm-Message-State: APjAAAUiSGXQHt54wPA9iA6XWmZoQQ5/tB0TnwINQyN/pkEz3/QPj9hg
        gp0Vq1igN6ompJQdWfRmdIc=
X-Google-Smtp-Source: APXvYqxbsrOylJtXq88vFQF7e5m3ZZF0eSDcqIbg6dJ46UDs/DU+bCXmQ38m/hOb8N18IPcJGM1Aeg==
X-Received: by 2002:a63:1807:: with SMTP id y7mr50491656pgl.94.1577433940209;
        Fri, 27 Dec 2019 00:05:40 -0800 (PST)
Received: from hpz4g4.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id 3sm37271702pfi.13.2019.12.27.00.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 00:05:39 -0800 (PST)
From:   Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 3/3] ext4: Prevent ext4_kvmalloc_nofs() from re-entering the filesystem and deadlocking
Date:   Fri, 27 Dec 2019 17:05:23 +0900
Message-Id: <20191227080523.31808-4-naoto.kobayashi4c@gmail.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
References: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Even if __vmalloc() receives GFP_NOFS, this function allocates
data pages and auxiliary structures (e.g. pagetables) with __GFP_FS[1].
To prevent memory reclaim from re-entering the filesystem here and
potentially deadlocking, use memalloc_nofs_save() that gets
__vmalloc() to drop __GFP_FS.

[1] linux-tree/Documentation/core-api/gfp-mask-fs-io.rst

Signed-off-by: Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
---
 fs/ext4/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e8965aa6ecce..7f4c9a43a3f3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -43,6 +43,7 @@
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
 #include <linux/unicode.h>
+#include <linux/sched/mm.h>

 #include <linux/kthread.h>
 #include <linux/freezer.h>
@@ -206,11 +207,13 @@ void ext4_superblock_csum_set(struct super_block *sb)

 void *ext4_kvmalloc_nofs(size_t size)
 {
+	unsigned int nofs_flag;
 	void *ret;

-	ret = kmalloc(size, GFP_NOFS | __GFP_NOWARN);
-	if (!ret)
-		ret = __vmalloc(size, GFP_NOFS, PAGE_KERNEL);
+	/* kvmalloc() does not support GFP_NOFS */
+	nofs_flag = memalloc_nofs_save();
+	ret = kvmalloc(size, GFP_KERNEL);
+	memalloc_nofs_restore(nofs_flag);
 	return ret;
 }

--
2.16.6

