Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADD14671E2
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Dec 2021 07:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378575AbhLCGdN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Dec 2021 01:33:13 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29150 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhLCGdL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Dec 2021 01:33:11 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J52tp6ns9zXdWj;
        Fri,  3 Dec 2021 14:27:46 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:29:47 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:29:46 +0800
Message-ID: <861a4e77-66dc-2c0d-46b9-0af2666a988a@huawei.com>
Date:   Fri, 3 Dec 2021 14:29:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH 4/6] e2fsprogs: call ext2fs_badblocks_list_free() to free list
 in exception branch
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <37c58382-9714-7e99-6c4d-01b78cfdbd26@huawei.com>
In-Reply-To: <37c58382-9714-7e99-6c4d-01b78cfdbd26@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500001.china.huawei.com (7.185.36.227) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the exception branch, not call ext2fs_badblocks_list_free() to
free list, it will cause memory leak.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
  misc/dumpe2fs.c    | 1 +
  resize/resize2fs.c | 4 ++--
  2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index 3f4fc4ed..ef6d1cb8 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -338,6 +338,7 @@ static void list_bad_blocks(ext2_filsys fs, int dump)
      if (retval) {
          com_err("ext2fs_badblocks_list_iterate_begin", retval,
              "%s", _("while printing bad block list"));
+        ext2fs_badblocks_list_free(bb_list);
          return;
      }
      if (dump) {
diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index 73174be0..740cec48 100644
--- a/resize/resize2fs.c
+++ b/resize/resize2fs.c
@@ -1781,11 +1781,11 @@ static errcode_t block_mover(ext2_resize_t rfs)
                      fs->inode_blocks_per_group,
                      &rfs->itable_buf);
          if (retval)
-            return retval;
+            goto errout;
      }
      retval = ext2fs_create_extent_table(&rfs->bmap, 0);
      if (retval)
-        return retval;
+        goto errout;

      /*
       * The first step is to figure out where all of the blocks
-- 
2.23.0
