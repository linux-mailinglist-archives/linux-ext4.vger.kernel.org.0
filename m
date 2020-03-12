Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4119183492
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgCLPUN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:20:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCLPUM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1ZxVTXMDr5gCY0KKkp2UB36oIS8dpEgj94AXN0L4XQk=; b=KLviFORX7j9O5zw9ibvuTKpmes
        GZbWiV/qX38jWGDvbtdOqnXdaLkv+xAi+mRwJimex6HIbVqpaeWb359WBKrlR1KXzjZ1eovmDnHbc
        EIkCrUuAF/Cq7TGvMv2YoTk5sFoXG9vG/ZX5LHiuDoZNXr1irS9U08dYLGhEjtlUyFTCJfCLoP4O9
        0O6HAa2iE9z4xIh20oKB8cz6fjVFUqtViosVMHmbk0vCQg5U918VuOdXyOEhsf59mMrggILrGdESW
        fMMedSrcf08hR263Lrz9ljZ0PyiqJvgMrNYkV5RKTdME/ywoj9jdDgqO8FA9OPNzjgtWUOTqd4/uK
        OzLhU3GQ==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPd6-0007rt-1r; Thu, 12 Mar 2020 15:20:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 10/21] block: cleanup how md_autodetect_dev is called
Date:   Thu, 12 Mar 2020 16:19:28 +0100
Message-Id: <20200312151939.645254-11-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312151939.645254-1-hch@lst.de>
References: <20200312151939.645254-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a new include/linux/raid/detect.h header to declare the
md_autodetect_dev prototype which can be shared between md and
the partition code.  Then use IS_BUILTIN to call it instead of the
ifdef magic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partition-generic.c   | 11 ++++-------
 drivers/md/md.c             |  1 +
 include/linux/raid/detect.h |  3 +++
 3 files changed, 8 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/raid/detect.h

diff --git a/block/partition-generic.c b/block/partition-generic.c
index abab0109b69c..febfb8e96abb 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -18,14 +18,11 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/blktrace_api.h>
+#include <linux/raid/detect.h>
 #include "blk.h"
 
 #include "partitions/check.h"
 
-#ifdef CONFIG_BLK_DEV_MD
-extern void md_autodetect_dev(dev_t dev);
-#endif
- 
 static ssize_t part_partition_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -407,10 +404,10 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 		return true;
 	}
 
-#ifdef CONFIG_BLK_DEV_MD
-	if (state->parts[p].flags & ADDPART_FLAG_RAID)
+	if (IS_BUILTIN(CONFIG_BLK_DEV_MD) &&
+	    (state->parts[p].flags & ADDPART_FLAG_RAID))
 		md_autodetect_dev(part_to_dev(part)->devt);
-#endif
+
 	return true;
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 11759f9e328e..dbbec0583e9d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -58,6 +58,7 @@
 #include <linux/delay.h>
 #include <linux/raid/md_p.h>
 #include <linux/raid/md_u.h>
+#include <linux/raid/detect.h>
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 
diff --git a/include/linux/raid/detect.h b/include/linux/raid/detect.h
new file mode 100644
index 000000000000..37dd3f40cd31
--- /dev/null
+++ b/include/linux/raid/detect.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+void md_autodetect_dev(dev_t dev);
-- 
2.24.1

