Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923D5183481
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgCLPUB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:20:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCLPUB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nMf50sgfLwVjYdrUPhFsVYfUmDVjSEtmpa2peQeLs7o=; b=MStCRRHbPBUfKvrM/34YyaLVdK
        hkI4JvNFydNsQphFep5Gs5sgGf8q/5rc6sqjkeClkQ80ODWKLsCqw6yYjsDWYHY5e3lZir1Ju2Vqe
        IDv65B358Jt+JxVmapUeQWVfGvevpbsD2xAtIT5CyO0ORrdpS0ry9Pb0f5daODnsBt0coEvgHI7Dt
        7j3RSUj640IjXi3wjwaR271WOABCxQRibhEKDDXRNcWDCsr5Am02r8kJxS7ev/Fq56l5ohiXG6SFA
        XbEyGMSROYsEq7RRsTl80fmkmVJYFj1dzwQGr6b8BYXeQT9D/Ec5MJupWUwFvpW+ImMQXKwQy4EZf
        Fdh6y5yg==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPcu-0006ao-Ar; Thu, 12 Mar 2020 15:20:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 07/21] scsi: move scsicam_bios_param to the end of scsicam.c
Date:   Thu, 12 Mar 2020 16:19:25 +0100
Message-Id: <20200312151939.645254-8-hch@lst.de>
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

This avoids the need for a forward declaration and generally keeps the
file in the lower level first, high level last order.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsicam.c | 120 ++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 61 deletions(-)

diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index 91a9530a4dcb..248ab23d2e69 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -21,10 +21,6 @@
 
 #include <scsi/scsicam.h>
 
-
-static int setsize(unsigned long capacity, unsigned int *cyls, unsigned int *hds,
-		   unsigned int *secs);
-
 /**
  * scsi_bios_ptable - Read PC partition table out of first sector of device.
  * @dev: from this device
@@ -50,63 +46,6 @@ unsigned char *scsi_bios_ptable(struct block_device *dev)
 }
 EXPORT_SYMBOL(scsi_bios_ptable);
 
-/**
- * scsicam_bios_param - Determine geometry of a disk in cylinders/heads/sectors.
- * @bdev: which device
- * @capacity: size of the disk in sectors
- * @ip: return value: ip[0]=heads, ip[1]=sectors, ip[2]=cylinders
- *
- * Description : determine the BIOS mapping/geometry used for a drive in a
- *      SCSI-CAM system, storing the results in ip as required
- *      by the HDIO_GETGEO ioctl().
- *
- * Returns : -1 on failure, 0 on success.
- */
-
-int scsicam_bios_param(struct block_device *bdev, sector_t capacity, int *ip)
-{
-	unsigned char *p;
-	u64 capacity64 = capacity;	/* Suppress gcc warning */
-	int ret;
-
-	p = scsi_bios_ptable(bdev);
-	if (!p)
-		return -1;
-
-	/* try to infer mapping from partition table */
-	ret = scsi_partsize(p, (unsigned long)capacity, (unsigned int *)ip + 2,
-			       (unsigned int *)ip + 0, (unsigned int *)ip + 1);
-	kfree(p);
-
-	if (ret == -1 && capacity64 < (1ULL << 32)) {
-		/* pick some standard mapping with at most 1024 cylinders,
-		   and at most 62 sectors per track - this works up to
-		   7905 MB */
-		ret = setsize((unsigned long)capacity, (unsigned int *)ip + 2,
-		       (unsigned int *)ip + 0, (unsigned int *)ip + 1);
-	}
-
-	/* if something went wrong, then apparently we have to return
-	   a geometry with more than 1024 cylinders */
-	if (ret || ip[0] > 255 || ip[1] > 63) {
-		if ((capacity >> 11) > 65534) {
-			ip[0] = 255;
-			ip[1] = 63;
-		} else {
-			ip[0] = 64;
-			ip[1] = 32;
-		}
-
-		if (capacity > 65535*63*255)
-			ip[2] = 65535;
-		else
-			ip[2] = (unsigned long)capacity / (ip[0] * ip[1]);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(scsicam_bios_param);
-
 /**
  * scsi_partsize - Parse cylinders/heads/sectors from PC partition table
  * @buf: partition table, see scsi_bios_ptable()
@@ -256,3 +195,62 @@ static int setsize(unsigned long capacity, unsigned int *cyls, unsigned int *hds
 	*hds = (unsigned int) heads;
 	return (rv);
 }
+
+/**
+ * scsicam_bios_param - Determine geometry of a disk in cylinders/heads/sectors.
+ * @bdev: which device
+ * @capacity: size of the disk in sectors
+ * @ip: return value: ip[0]=heads, ip[1]=sectors, ip[2]=cylinders
+ *
+ * Description : determine the BIOS mapping/geometry used for a drive in a
+ *      SCSI-CAM system, storing the results in ip as required
+ *      by the HDIO_GETGEO ioctl().
+ *
+ * Returns : -1 on failure, 0 on success.
+ */
+int scsicam_bios_param(struct block_device *bdev, sector_t capacity, int *ip)
+{
+	unsigned char *p;
+	u64 capacity64 = capacity;	/* Suppress gcc warning */
+	int ret;
+
+	p = scsi_bios_ptable(bdev);
+	if (!p)
+		return -1;
+
+	/* try to infer mapping from partition table */
+	ret = scsi_partsize(p, (unsigned long)capacity, (unsigned int *)ip + 2,
+			       (unsigned int *)ip + 0, (unsigned int *)ip + 1);
+	kfree(p);
+
+	if (ret == -1 && capacity64 < (1ULL << 32)) {
+		/*
+		 * Pick some standard mapping with at most 1024 cylinders, and
+		 * at most 62 sectors per track - this works up to 7905 MB.
+		 */
+		ret = setsize((unsigned long)capacity, (unsigned int *)ip + 2,
+		       (unsigned int *)ip + 0, (unsigned int *)ip + 1);
+	}
+
+	/*
+	 * If something went wrong, then apparently we have to return a geometry
+	 * with more than 1024 cylinders.
+	 */
+	if (ret || ip[0] > 255 || ip[1] > 63) {
+		if ((capacity >> 11) > 65534) {
+			ip[0] = 255;
+			ip[1] = 63;
+		} else {
+			ip[0] = 64;
+			ip[1] = 32;
+		}
+
+		if (capacity > 65535*63*255)
+			ip[2] = 65535;
+		else
+			ip[2] = (unsigned long)capacity / (ip[0] * ip[1]);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(scsicam_bios_param);
-- 
2.24.1

