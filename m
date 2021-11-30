Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57826462CE9
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Nov 2021 07:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbhK3GoA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Nov 2021 01:44:00 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14996 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhK3Gn7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Nov 2021 01:43:59 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J3CFz4kM9zZdQt;
        Tue, 30 Nov 2021 14:37:59 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:40:39 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:40:39 +0800
Message-ID: <3a0cbb4e-6ea3-356a-433d-3a7a6466b018@huawei.com>
Date:   Tue, 30 Nov 2021 14:40:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH] setup_tdb : fix memory leak
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100026.china.huawei.com (7.185.36.103) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In setup_tdb(), need free tdb_dir before return,
otherwise it will cause memory leak.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
  e2fsck/dirinfo.c | 13 +++++++++----
  1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
index 49d624c5..a2b36d8e 100644
--- a/e2fsck/dirinfo.c
+++ b/e2fsck/dirinfo.c
@@ -49,7 +49,7 @@ static void setup_tdb(e2fsck_t ctx, ext2_ino_t num_dirs)
  	ext2_ino_t		threshold;
  	errcode_t		retval;
  	mode_t			save_umask;
-	char			*tdb_dir, uuid[40];
+	char			*tdb_dir = NULL, uuid[40];
  	int			fd, enable;

  	profile_get_string(ctx->profile, "scratch_files", "directory", 0, 0,
@@ -61,11 +61,11 @@ static void setup_tdb(e2fsck_t ctx, ext2_ino_t num_dirs)

  	if (!enable || !tdb_dir || access(tdb_dir, W_OK) ||
  	    (threshold && num_dirs <= threshold))
-		return;
+		goto error;

  	retval = ext2fs_get_mem(strlen(tdb_dir) + 64, &db->tdb_fn);
  	if (retval)
-		return;
+		goto error;

  	uuid_unparse(ctx->fs->super->s_uuid, uuid);
  	sprintf(db->tdb_fn, "%s/%s-dirinfo-XXXXXX", tdb_dir, uuid);
@@ -74,7 +74,7 @@ static void setup_tdb(e2fsck_t ctx, ext2_ino_t num_dirs)
  	umask(save_umask);
  	if (fd < 0) {
  		db->tdb = NULL;
-		return;
+		goto error;
  	}

  	if (num_dirs < 99991)
@@ -83,6 +83,11 @@ static void setup_tdb(e2fsck_t ctx, ext2_ino_t num_dirs)
  	db->tdb = tdb_open(db->tdb_fn, num_dirs, TDB_NOLOCK | TDB_NOSYNC,
  			   O_RDWR | O_CREAT | O_TRUNC, 0600);
  	close(fd);
+
+error:
+	if(tdb_dir) {
+		free(tdb_dir);
+	}
  }
  #endif

-- 
2.23.0


