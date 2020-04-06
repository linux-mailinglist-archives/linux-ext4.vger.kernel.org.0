Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 890361A01B1
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 01:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDFX1t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Apr 2020 19:27:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22140 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDFX1t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Apr 2020 19:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586215680; x=1617751680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6B0KRksz6wzCzwe9Wvyr0N38QBFJ/8WLPl6ULPGYDk=;
  b=dUfRmFnmdJHHjJwhGyxaqi2aEdwg+D5VrvDC0h0MgGLXR887C79pmdaZ
   zVOV0i1Gv5Gsv+6PiURBx858uUwkyimz9Tq/koTV6iu9F5dFu9kBEgqzn
   vvlnmVs5lE2H7d+9JEvNKAUhgy9JZstcUUr1BhEgVJs+34RivKqKztDLs
   g5/f3a84hw3HS3lENLHyy0wcrNUqB+xheWtMtPacenJlHqN0BDdU1/wZa
   lMzto6I3uMSEGoEvIxDqcFCeU2bX+t9CxCgqcjdrn68gd3MT7rxYFBhNh
   CgVDMOTQ/Pl5MHLZX3MlmWaWPTnVpg3iyb7S5n0EQanQeYgiMXGIgOxct
   w==;
IronPort-SDR: YwEI1Qmk3S5atj5l+tNety5elpsFVSLdGoKFMku2mk4Zij/AalgAG7SJLMvT0CUEKrSEzkuQMu
 lxqTG6WWtA9I77TGes83KxMqd7oFOFhtwqj1Zl8ud9uG0wwpbga88xUOJ2JxdUH7S35Bw+3HwH
 HpLWsYUTg5IwNkgd3oBBrI83LahIEC744zaKy1zIObldfJByjROlWsGCp2971xS+wc1TxzXgMl
 XzX16LHVWF8X58SEYuyBZ9ee4ZuKmoCJgCeK//puJakKHu0mD/NFjtPkPgPpk59+u0BPCr7jMX
 KRQ=
X-IronPort-AV: E=Sophos;i="5.72,352,1580745600"; 
   d="scan'208";a="237046206"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2020 07:28:00 +0800
IronPort-SDR: lryLi9YkBAUlRe+UlgWj4GyH6rlS/EZyItLjoy6Ia58ZVW845066NJ6PX8+zPrwlBrGuU3tYZ4
 iDu/O/zQ2hSZhPJmuBk9nnSQyC3XHttRqnKu0mZEC/et4v77So7HEEISQWnZxh2H+ybuMicK9Z
 7l5L+rti4ck/30PrD1qGfgS9bnsbshwahpKMOcVnVAPHYhAdKTAgL21tdjkrXhhRHeu8jnwx7Y
 TOKrppcFYDv8VXGFd8Z2ZKABj2mEjYyYV5O+QKQkEIlpsVJaSjAGz7B5CsF9/pwwk4Ph2zUzVF
 8FIDgXujSJvad3zsphXJNYGd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 16:18:31 -0700
IronPort-SDR: zsfvPgAH22D/zOLZDxRMJwvf8+xDVfhFSOxiSJSBmwM9FWha7GKPUG600Dbc+zesHMzjb25f1y
 4oQX5vSjvjNM3NxrOrAfSWIMOIYauztAaSu468MUHwJvXcd+18Qu1SuYUnYDaOEaU5FFjczICX
 aqQmHZNYBxPHy6fbEMkKEQprAKl70RBrMxaTbTmbQ4cSaImtqj3AjX+4gRTnMWNqhAmzofftHe
 msnMKMXLUXeh8VqwYXJdyhSCQs1nUPzS7raBAIOSNz0+IYTceb24//JFOoBsxhMGO6IEnLEH2o
 dME=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Apr 2020 16:27:48 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     hch@lst.de, martin.petersen@oracle.com
Cc:     darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, chaitanya.kulkarni@wdc.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        ktkhai@virtuozzo.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH V2 4/4] ext4: Notify block device about alloc-assigned blk
Date:   Mon,  6 Apr 2020 15:21:48 -0700
Message-Id: <20200406222148.28365-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200406222148.28365-1-chaitanya.kulkarni@wdc.com>
References: <20200406222148.28365-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

Call sb_issue_allocate() after extent range was allocated on user
request. Hopeful, this helps block device to maintain its internals in
the best way, if this is appliable.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/ext4/ext4.h    |  2 ++
 fs/ext4/extents.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 61b37a052052..0d0fa9904147 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -622,6 +622,8 @@ enum {
 	 * allows jbd2 to avoid submitting data before commit. */
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
 
+#define EXT4_GET_BLOCKS_SUBMIT_ALLOC		0x0800
+
 /*
  * The bit position of these flags must not overlap with any of the
  * EXT4_GET_BLOCKS_*.  They are used by ext4_find_extent(),
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 954013d6076b..37a60e190349 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4449,6 +4449,14 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		ar.len = allocated;
 
 got_allocated_blocks:
+	if ((flags & EXT4_GET_BLOCKS_SUBMIT_ALLOC) &&
+			inode->i_fop->fallocate) {
+		err = sb_issue_allocate(inode->i_sb, newblock,
+				EXT4_C2B(sbi, allocated_clusters), GFP_NOFS);
+		if (err)
+			goto free_on_err;
+	}
+
 	/* try to insert new extent into found leaf and return */
 	ext4_ext_store_pblock(&newex, newblock + offset);
 	newex.ee_len = cpu_to_le16(ar.len);
@@ -4466,6 +4474,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		err = ext4_ext_insert_extent(handle, inode, &path,
 					     &newex, flags);
 
+free_on_err:
 	if (err && free_on_err) {
 		int fb_flags = flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE ?
 			EXT4_FREE_BLOCKS_NO_QUOT_UPDATE : 0;
@@ -4733,7 +4742,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			goto out_mutex;
 	}
 
-	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
+	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT |
+		EXT4_GET_BLOCKS_SUBMIT_ALLOC;
 	if (mode & FALLOC_FL_KEEP_SIZE)
 		flags |= EXT4_GET_BLOCKS_KEEP_SIZE;
 
-- 
2.22.0

