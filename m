Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2168A183473
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgCLPTx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:19:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgCLPTx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jTtkA6L+SiXgREMbT5DWvlEWtwYiBuKU/g77nbQFcmU=; b=iI4LxZCTKpJ4/q5TlxKt0kMP4D
        tBDOCcH8vyhWHwEaLdVXYN7ZKQFaXac9yYVAddeQ/xmKsG7dkOHfLHqM60393DRHvnKius7gY/wGm
        L5in1JLbG6fcwbuOnLTaKp1XTYMQFpomPp4kmyWri1gARdh5SH06WWGxbIpQPPECpCSIfgTi1dK8K
        qn0AqOXelGbSjcX0Nlk6dpG+zWo+hShLzg27Csl3HKtlYps3LLklLR5aLu+dk8H6ArqeDO12gFAxQ
        ODzjROHlqSdvM9RtDlpif8T/JvnvLXH70Cc3JvsFLwXfH8ZvfkjRyPFcFsDrrupjSaFuQ1f+KEuDk
        5GDyC1WQ==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPcm-0006Wm-GF; Thu, 12 Mar 2020 15:19:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 04/21] block: move sysfs methods shared by disks and partitions to genhd.c
Date:   Thu, 12 Mar 2020 16:19:22 +0100
Message-Id: <20200312151939.645254-5-hch@lst.de>
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

Move the sysfs _show methods that are used both on the full disk and
partition nodes to genhd.c instead of hiding them in the partitioning
code.  Also move the declaration for these methods to block/blk.h so
that we don't expose them to drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h               | 11 ++++++
 block/genhd.c             | 80 ++++++++++++++++++++++++++++++++++++++-
 block/partition-generic.c | 76 +------------------------------------
 include/linux/genhd.h     | 14 -------
 4 files changed, 91 insertions(+), 90 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 0b8884353f6b..c91c49bbec8d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -214,6 +214,17 @@ static inline void elevator_exit(struct request_queue *q,
 
 struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
 
+ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
+		char *buf);
+ssize_t part_stat_show(struct device *dev, struct device_attribute *attr,
+		char *buf);
+ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
+		char *buf);
+ssize_t part_fail_show(struct device *dev, struct device_attribute *attr,
+		char *buf);
+ssize_t part_fail_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count);
+
 #ifdef CONFIG_FAIL_IO_TIMEOUT
 int blk_should_fake_timeout(struct request_queue *);
 ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
diff --git a/block/genhd.c b/block/genhd.c
index 18435524e51c..afcd8c9e502c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/ctype.h>
 #include <linux/fs.h>
 #include <linux/genhd.h>
 #include <linux/kdev_t.h>
@@ -1176,6 +1177,60 @@ static ssize_t disk_ro_show(struct device *dev,
 	return sprintf(buf, "%d\n", get_disk_ro(disk) ? 1 : 0);
 }
 
+ssize_t part_size_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
+{
+	struct hd_struct *p = dev_to_part(dev);
+
+	return sprintf(buf, "%llu\n",
+		(unsigned long long)part_nr_sects_read(p));
+}
+
+ssize_t part_stat_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
+{
+	struct hd_struct *p = dev_to_part(dev);
+	struct request_queue *q = part_to_disk(p)->queue;
+	unsigned int inflight;
+
+	inflight = part_in_flight(q, p);
+	return sprintf(buf,
+		"%8lu %8lu %8llu %8u "
+		"%8lu %8lu %8llu %8u "
+		"%8u %8u %8u "
+		"%8lu %8lu %8llu %8u "
+		"%8lu %8u"
+		"\n",
+		part_stat_read(p, ios[STAT_READ]),
+		part_stat_read(p, merges[STAT_READ]),
+		(unsigned long long)part_stat_read(p, sectors[STAT_READ]),
+		(unsigned int)part_stat_read_msecs(p, STAT_READ),
+		part_stat_read(p, ios[STAT_WRITE]),
+		part_stat_read(p, merges[STAT_WRITE]),
+		(unsigned long long)part_stat_read(p, sectors[STAT_WRITE]),
+		(unsigned int)part_stat_read_msecs(p, STAT_WRITE),
+		inflight,
+		jiffies_to_msecs(part_stat_read(p, io_ticks)),
+		jiffies_to_msecs(part_stat_read(p, time_in_queue)),
+		part_stat_read(p, ios[STAT_DISCARD]),
+		part_stat_read(p, merges[STAT_DISCARD]),
+		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
+		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),
+		part_stat_read(p, ios[STAT_FLUSH]),
+		(unsigned int)part_stat_read_msecs(p, STAT_FLUSH));
+}
+
+ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct hd_struct *p = dev_to_part(dev);
+	struct request_queue *q = part_to_disk(p)->queue;
+	unsigned int inflight[2];
+
+	part_in_flight_rw(q, p, inflight);
+	return sprintf(buf, "%8u %8u\n", inflight[0], inflight[1]);
+}
+
 static ssize_t disk_capability_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -1214,10 +1269,33 @@ static DEVICE_ATTR(capability, 0444, disk_capability_show, NULL);
 static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
 static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
 static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
+
 #ifdef CONFIG_FAIL_MAKE_REQUEST
+ssize_t part_fail_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
+{
+	struct hd_struct *p = dev_to_part(dev);
+
+	return sprintf(buf, "%d\n", p->make_it_fail);
+}
+
+ssize_t part_fail_store(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct hd_struct *p = dev_to_part(dev);
+	int i;
+
+	if (count > 0 && sscanf(buf, "%d", &i) > 0)
+		p->make_it_fail = (i == 0) ? 0 : 1;
+
+	return count;
+}
+
 static struct device_attribute dev_attr_fail =
 	__ATTR(make-it-fail, 0644, part_fail_show, part_fail_store);
-#endif
+#endif /* CONFIG_FAIL_MAKE_REQUEST */
+
 #ifdef CONFIG_FAIL_IO_TIMEOUT
 static struct device_attribute dev_attr_fail_timeout =
 	__ATTR(io-timeout-fail, 0644, part_timeout_show, part_timeout_store);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 6f48aa406aaf..cc1133bf0119 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -18,6 +18,7 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/blktrace_api.h>
+#include "blk.h"
 
 #include "partitions/check.h"
 
@@ -41,13 +42,6 @@ static ssize_t part_start_show(struct device *dev,
 	return sprintf(buf, "%llu\n",(unsigned long long)p->start_sect);
 }
 
-ssize_t part_size_show(struct device *dev,
-		       struct device_attribute *attr, char *buf)
-{
-	struct hd_struct *p = dev_to_part(dev);
-	return sprintf(buf, "%llu\n",(unsigned long long)part_nr_sects_read(p));
-}
-
 static ssize_t part_ro_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -69,74 +63,6 @@ static ssize_t part_discard_alignment_show(struct device *dev,
 	return sprintf(buf, "%u\n", p->discard_alignment);
 }
 
-ssize_t part_stat_show(struct device *dev,
-		       struct device_attribute *attr, char *buf)
-{
-	struct hd_struct *p = dev_to_part(dev);
-	struct request_queue *q = part_to_disk(p)->queue;
-	unsigned int inflight;
-
-	inflight = part_in_flight(q, p);
-	return sprintf(buf,
-		"%8lu %8lu %8llu %8u "
-		"%8lu %8lu %8llu %8u "
-		"%8u %8u %8u "
-		"%8lu %8lu %8llu %8u "
-		"%8lu %8u"
-		"\n",
-		part_stat_read(p, ios[STAT_READ]),
-		part_stat_read(p, merges[STAT_READ]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_READ]),
-		(unsigned int)part_stat_read_msecs(p, STAT_READ),
-		part_stat_read(p, ios[STAT_WRITE]),
-		part_stat_read(p, merges[STAT_WRITE]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_WRITE]),
-		(unsigned int)part_stat_read_msecs(p, STAT_WRITE),
-		inflight,
-		jiffies_to_msecs(part_stat_read(p, io_ticks)),
-		jiffies_to_msecs(part_stat_read(p, time_in_queue)),
-		part_stat_read(p, ios[STAT_DISCARD]),
-		part_stat_read(p, merges[STAT_DISCARD]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
-		(unsigned int)part_stat_read_msecs(p, STAT_DISCARD),
-		part_stat_read(p, ios[STAT_FLUSH]),
-		(unsigned int)part_stat_read_msecs(p, STAT_FLUSH));
-}
-
-ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
-			   char *buf)
-{
-	struct hd_struct *p = dev_to_part(dev);
-	struct request_queue *q = part_to_disk(p)->queue;
-	unsigned int inflight[2];
-
-	part_in_flight_rw(q, p, inflight);
-	return sprintf(buf, "%8u %8u\n", inflight[0], inflight[1]);
-}
-
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-ssize_t part_fail_show(struct device *dev,
-		       struct device_attribute *attr, char *buf)
-{
-	struct hd_struct *p = dev_to_part(dev);
-
-	return sprintf(buf, "%d\n", p->make_it_fail);
-}
-
-ssize_t part_fail_store(struct device *dev,
-			struct device_attribute *attr,
-			const char *buf, size_t count)
-{
-	struct hd_struct *p = dev_to_part(dev);
-	int i;
-
-	if (count > 0 && sscanf(buf, "%d", &i) > 0)
-		p->make_it_fail = (i == 0) ? 0 : 1;
-
-	return count;
-}
-#endif
-
 static DEVICE_ATTR(partition, 0444, part_partition_show, NULL);
 static DEVICE_ATTR(start, 0444, part_start_show, NULL);
 static DEVICE_ATTR(size, 0444, part_size_show, NULL);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6fbe58538ad6..49f1836e7b81 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -657,20 +657,6 @@ extern void blk_register_region(dev_t devt, unsigned long range,
 			void *data);
 extern void blk_unregister_region(dev_t devt, unsigned long range);
 
-extern ssize_t part_size_show(struct device *dev,
-			      struct device_attribute *attr, char *buf);
-extern ssize_t part_stat_show(struct device *dev,
-			      struct device_attribute *attr, char *buf);
-extern ssize_t part_inflight_show(struct device *dev,
-			      struct device_attribute *attr, char *buf);
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-extern ssize_t part_fail_show(struct device *dev,
-			      struct device_attribute *attr, char *buf);
-extern ssize_t part_fail_store(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count);
-#endif /* CONFIG_FAIL_MAKE_REQUEST */
-
 #define alloc_disk_node(minors, node_id)				\
 ({									\
 	static struct lock_class_key __key;				\
-- 
2.24.1

