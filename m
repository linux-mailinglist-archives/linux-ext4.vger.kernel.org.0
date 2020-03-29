Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51AAC196F81
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 20:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgC2SxC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Mar 2020 14:53:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54427 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgC2SxC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Mar 2020 14:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585507982; x=1617043982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7xjZ4ybzqxyWK9So333xAFrjlAItuxwbE8b11D3IFrs=;
  b=Dhi7fqQvg91WMqDuETyw0yjj1OxV2GlLDEiE/OepDBHNgRpATbwLp82q
   +YYrMWxpnxKpaqM6CstRVZAhyN0cEPgyvFpcpc9n3UhDEa8n+9Ud3Uy6q
   bnF54w1VnBX5gYGC0AK7MElq2etkRdhOPt0qPt4WT3MDNY3zSLWoc2GCe
   WdscZIGw7dllc9Tu+ibAOepyIKLHp5urTsNUy0psCcDL1eJ4Wv3/52Dcq
   1wJ3tbPFrgc0HTk5LvJmd7qClr97NzPjvQ+ql/PtTOAbWlOdPNG+RJddk
   zxVZKzxZnY+4cv5z84DNzY52RuiPBiT2a+Fndgc+ImtFi5lkjuMWbgGn/
   w==;
IronPort-SDR: CGQITVfFFfGZyjREfd26gucQDsiOuYnH0m8ez2Q76fUSgwnTdd57GwVyEng9R/rvEkfI0Pqubq
 +ffnzzj3opAh/L3H1xkC/aQOD4aPydluS4f31QkkkE35pf3UQ2sA6yCkHTLg8HB6Be7Zlg8l7E
 vfQFYSLYJe1v6mT+rgn0r4VPiRyfp6bFktu5GSuF9lCqKyRVH5xdyUp9RXVUtoSEzY7KAgVAVI
 /53FVgkenp1ULvI+vWvDu1AtMN7u+n0q7PcfFR+e4aSYp+1uWwPycWrGlF8+05y+hINoYueduX
 QLo=
X-IronPort-AV: E=Sophos;i="5.72,321,1580745600"; 
   d="scan'208";a="138193360"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 02:53:02 +0800
IronPort-SDR: kuVuWaKBkJ2G1wl9KIoimWDcDa2olOJDohiCUBeSa3jW2UOrW2taud3iO9dPqFgzeXJRi/a5XW
 WO6aIZelyY79xj1iWo3s7+yCZ1sjgqAn1YFRqVXkhl9VT3/277sjklfDM2Of0oVKhnknknsQMM
 QZU8sVT1QP2T5y85YMZBRjP3jRyN7c4Xf4UAkSg5Vlr9XcI9qjpcF2MfDuCPuk/bzvogZtVUwQ
 8ZynwNXT1fZ0pFx8DVDzP75JOz3ZKAZ2k0jE5fCnm9mtjNhZRNXIGuPZPGM3ca2agiHMkef/aA
 JmUcq82YpYa7rTQHfvmTOqeG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 11:43:58 -0700
IronPort-SDR: E3m3KbjMyaFI7NwTXdRzGZtBDUkAvASK7NAF5SGeBaMPUlkpkAmwqVbwIF7Ud7o4fd/ZNLnGod
 jrZFxg5TjlS2X71SVA0WSONLm0IX13FZaGVZs8zo8P4/eH/MTisJgeJYy1RvwCIsGdlLo/ElU8
 mIc4lWhMOk0ZdJTLYIg5cTX7dQO4FpRR9IfVcZhFDpm23mtRP5um4s/pg2DC2j77BJ91IU3IOL
 h/9vYci4YZuKRPm0dZlkszuYjJ9zqkRnFGkO2bB38aEGet/1T/oPCNaROsiZeBU0E1MLUVDDSJ
 mlQ=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2020 11:53:01 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     hch@lst.de, martin.petersen@oracle.com
Cc:     darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, chaitanya.kulkarni@wdc.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH 4/4] ext4: Notify block device about alloc-assigned blk
Date:   Sun, 29 Mar 2020 10:47:14 -0700
Message-Id: <20200329174714.32416-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

From: Kirill Tkhai <ktkhai@virtuozzo.com>

Call sb_issue_assign_range() after extent range was allocated on user
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
index 954013d6076b..598b700c4d4c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4449,6 +4449,14 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		ar.len = allocated;
 
 got_allocated_blocks:
+	if ((flags & EXT4_GET_BLOCKS_SUBMIT_ALLOC) &&
+			inode->i_fop->fallocate) {
+		err = sb_issue_assign_range(inode->i_sb, newblock,
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

