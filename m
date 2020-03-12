Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20AF1834C4
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgCLPUm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:20:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgCLPUm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=n13Q6DLqRjyLux3UpI7BbD9kN5e1dnMfZqd8xPQBgkw=; b=IQWvaI4+Bct4NMigql+B/eJSEK
        aX53IxEH4gx6dsMqP2L52p4RIMRj1Pm2qVOv46QF/aKxlfRM2g+fcdxDMP5oy1nfQowK/tzRPgshF
        ufbPU74k0+E1fKbnd4D+Xv/4DyPSIsMCMv2PwyBu3FBczKhhbpi7TiGy+qWhpxy7JTnJS3jHI1+z1
        m8u4nTBjpWpvlWFtjQp5fvF4oMzfDm5giiTJrXF/7zxMg1v2+PNUB9+kPJKg8pkLsTQIDKS6mwyE+
        y99kneMSa/GQJ7BtSBGp303nV278ST23bvJKrs/stswHGTAPbC8DDEbiDBesF/aR1HS8MQRz7reX7
        Ml/xQ+wQ==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPdZ-00083n-9a; Thu, 12 Mar 2020 15:20:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 21/21] block: merge partition-generic.c and check.c
Date:   Thu, 12 Mar 2020 16:19:39 +0100
Message-Id: <20200312151939.645254-22-hch@lst.de>
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

Merge block/partition-generic.c and block/partitions/check.c into
a single block/partitions/core.c as the content is closely related
and both files are tiny.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Makefile                                |   3 +-
 block/partitions/Makefile                     |   3 +-
 block/partitions/check.c                      | 179 ------------------
 block/partitions/check.h                      |   5 -
 .../core.c}                                   | 178 +++++++++++++++--
 5 files changed, 166 insertions(+), 202 deletions(-)
 delete mode 100644 block/partitions/check.c
 rename block/{partition-generic.c => partitions/core.c} (77%)

diff --git a/block/Makefile b/block/Makefile
index 1a43750f4b01..206b96e9387f 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -8,8 +8,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-exec.o blk-merge.o blk-softirq.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
-			genhd.o partition-generic.o ioprio.o \
-			badblocks.o partitions/ blk-rq-qos.o
+			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
diff --git a/block/partitions/Makefile b/block/partitions/Makefile
index 2f276b677c81..a7f05cdb02a8 100644
--- a/block/partitions/Makefile
+++ b/block/partitions/Makefile
@@ -3,8 +3,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-$(CONFIG_BLOCK) := check.o
-
+obj-$(CONFIG_BLOCK) += core.o
 obj-$(CONFIG_ACORN_PARTITION) += acorn.o
 obj-$(CONFIG_AMIGA_PARTITION) += amiga.o
 obj-$(CONFIG_ATARI_PARTITION) += atari.o
diff --git a/block/partitions/check.c b/block/partitions/check.c
deleted file mode 100644
index 944c478b6f0b..000000000000
--- a/block/partitions/check.c
+++ /dev/null
@@ -1,179 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  fs/partitions/check.c
- *
- *  Code extracted from drivers/block/genhd.c
- *  Copyright (C) 1991-1998  Linus Torvalds
- *  Re-organised Feb 1998 Russell King
- *
- *  We now have independent partition support from the
- *  block drivers, which allows all the partition code to
- *  be grouped in one location, and it to be mostly self
- *  contained.
- *
- *  Added needed MAJORS for new pairs, {hdi,hdj}, {hdk,hdl}
- */
-
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/ctype.h>
-#include <linux/genhd.h>
-
-#include "check.h"
-
-static int (*check_part[])(struct parsed_partitions *) = {
-	/*
-	 * Probe partition formats with tables at disk address 0
-	 * that also have an ADFS boot block at 0xdc0.
-	 */
-#ifdef CONFIG_ACORN_PARTITION_ICS
-	adfspart_check_ICS,
-#endif
-#ifdef CONFIG_ACORN_PARTITION_POWERTEC
-	adfspart_check_POWERTEC,
-#endif
-#ifdef CONFIG_ACORN_PARTITION_EESOX
-	adfspart_check_EESOX,
-#endif
-
-	/*
-	 * Now move on to formats that only have partition info at
-	 * disk address 0xdc0.  Since these may also have stale
-	 * PC/BIOS partition tables, they need to come before
-	 * the msdos entry.
-	 */
-#ifdef CONFIG_ACORN_PARTITION_CUMANA
-	adfspart_check_CUMANA,
-#endif
-#ifdef CONFIG_ACORN_PARTITION_ADFS
-	adfspart_check_ADFS,
-#endif
-
-#ifdef CONFIG_CMDLINE_PARTITION
-	cmdline_partition,
-#endif
-#ifdef CONFIG_EFI_PARTITION
-	efi_partition,		/* this must come before msdos */
-#endif
-#ifdef CONFIG_SGI_PARTITION
-	sgi_partition,
-#endif
-#ifdef CONFIG_LDM_PARTITION
-	ldm_partition,		/* this must come before msdos */
-#endif
-#ifdef CONFIG_MSDOS_PARTITION
-	msdos_partition,
-#endif
-#ifdef CONFIG_OSF_PARTITION
-	osf_partition,
-#endif
-#ifdef CONFIG_SUN_PARTITION
-	sun_partition,
-#endif
-#ifdef CONFIG_AMIGA_PARTITION
-	amiga_partition,
-#endif
-#ifdef CONFIG_ATARI_PARTITION
-	atari_partition,
-#endif
-#ifdef CONFIG_MAC_PARTITION
-	mac_partition,
-#endif
-#ifdef CONFIG_ULTRIX_PARTITION
-	ultrix_partition,
-#endif
-#ifdef CONFIG_IBM_PARTITION
-	ibm_partition,
-#endif
-#ifdef CONFIG_KARMA_PARTITION
-	karma_partition,
-#endif
-#ifdef CONFIG_SYSV68_PARTITION
-	sysv68_partition,
-#endif
-	NULL
-};
-
-static struct parsed_partitions *allocate_partitions(struct gendisk *hd)
-{
-	struct parsed_partitions *state;
-	int nr;
-
-	state = kzalloc(sizeof(*state), GFP_KERNEL);
-	if (!state)
-		return NULL;
-
-	nr = disk_max_parts(hd);
-	state->parts = vzalloc(array_size(nr, sizeof(state->parts[0])));
-	if (!state->parts) {
-		kfree(state);
-		return NULL;
-	}
-
-	state->limit = nr;
-
-	return state;
-}
-
-void free_partitions(struct parsed_partitions *state)
-{
-	vfree(state->parts);
-	kfree(state);
-}
-
-struct parsed_partitions *
-check_partition(struct gendisk *hd, struct block_device *bdev)
-{
-	struct parsed_partitions *state;
-	int i, res, err;
-
-	state = allocate_partitions(hd);
-	if (!state)
-		return NULL;
-	state->pp_buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!state->pp_buf) {
-		free_partitions(state);
-		return NULL;
-	}
-	state->pp_buf[0] = '\0';
-
-	state->bdev = bdev;
-	disk_name(hd, 0, state->name);
-	snprintf(state->pp_buf, PAGE_SIZE, " %s:", state->name);
-	if (isdigit(state->name[strlen(state->name)-1]))
-		sprintf(state->name, "p");
-
-	i = res = err = 0;
-	while (!res && check_part[i]) {
-		memset(state->parts, 0, state->limit * sizeof(state->parts[0]));
-		res = check_part[i++](state);
-		if (res < 0) {
-			/* We have hit an I/O error which we don't report now.
-		 	* But record it, and let the others do their job.
-		 	*/
-			err = res;
-			res = 0;
-		}
-
-	}
-	if (res > 0) {
-		printk(KERN_INFO "%s", state->pp_buf);
-
-		free_page((unsigned long)state->pp_buf);
-		return state;
-	}
-	if (state->access_beyond_eod)
-		err = -ENOSPC;
-	if (err)
-	/* The partition is unrecognized. So report I/O errors if there were any */
-		res = err;
-	if (res) {
-		strlcat(state->pp_buf,
-			" unable to read partition table\n", PAGE_SIZE);
-		printk(KERN_INFO "%s", state->pp_buf);
-	}
-
-	free_page((unsigned long)state->pp_buf);
-	free_partitions(state);
-	return ERR_PTR(res);
-}
diff --git a/block/partitions/check.h b/block/partitions/check.h
index 23e7adb79617..f845355489ec 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -23,11 +23,6 @@ struct parsed_partitions {
 	char *pp_buf;
 };
 
-void free_partitions(struct parsed_partitions *state);
-
-struct parsed_partitions *
-check_partition(struct gendisk *, struct block_device *);
-
 typedef struct {
 	struct page *v;
 } Sector;
diff --git a/block/partition-generic.c b/block/partitions/core.c
similarity index 77%
rename from block/partition-generic.c
rename to block/partitions/core.c
index febfb8e96abb..682fe445c3ab 100644
--- a/block/partition-generic.c
+++ b/block/partitions/core.c
@@ -1,27 +1,177 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Code extracted from drivers/block/genhd.c
- *  Copyright (C) 1991-1998  Linus Torvalds
- *  Re-organised Feb 1998 Russell King
- *
- *  We now have independent partition support from the
- *  block drivers, which allows all the partition code to
- *  be grouped in one location, and it to be mostly self
- *  contained.
+ * Copyright (C) 1991-1998  Linus Torvalds
+ * Re-organised Feb 1998 Russell King
  */
-
-#include <linux/init.h>
-#include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
-#include <linux/kmod.h>
 #include <linux/ctype.h>
 #include <linux/genhd.h>
+#include <linux/vmalloc.h>
 #include <linux/blktrace_api.h>
 #include <linux/raid/detect.h>
-#include "blk.h"
+#include "../blk.h"
+#include "check.h"
+
+static int (*check_part[])(struct parsed_partitions *) = {
+	/*
+	 * Probe partition formats with tables at disk address 0
+	 * that also have an ADFS boot block at 0xdc0.
+	 */
+#ifdef CONFIG_ACORN_PARTITION_ICS
+	adfspart_check_ICS,
+#endif
+#ifdef CONFIG_ACORN_PARTITION_POWERTEC
+	adfspart_check_POWERTEC,
+#endif
+#ifdef CONFIG_ACORN_PARTITION_EESOX
+	adfspart_check_EESOX,
+#endif
+
+	/*
+	 * Now move on to formats that only have partition info at
+	 * disk address 0xdc0.  Since these may also have stale
+	 * PC/BIOS partition tables, they need to come before
+	 * the msdos entry.
+	 */
+#ifdef CONFIG_ACORN_PARTITION_CUMANA
+	adfspart_check_CUMANA,
+#endif
+#ifdef CONFIG_ACORN_PARTITION_ADFS
+	adfspart_check_ADFS,
+#endif
+
+#ifdef CONFIG_CMDLINE_PARTITION
+	cmdline_partition,
+#endif
+#ifdef CONFIG_EFI_PARTITION
+	efi_partition,		/* this must come before msdos */
+#endif
+#ifdef CONFIG_SGI_PARTITION
+	sgi_partition,
+#endif
+#ifdef CONFIG_LDM_PARTITION
+	ldm_partition,		/* this must come before msdos */
+#endif
+#ifdef CONFIG_MSDOS_PARTITION
+	msdos_partition,
+#endif
+#ifdef CONFIG_OSF_PARTITION
+	osf_partition,
+#endif
+#ifdef CONFIG_SUN_PARTITION
+	sun_partition,
+#endif
+#ifdef CONFIG_AMIGA_PARTITION
+	amiga_partition,
+#endif
+#ifdef CONFIG_ATARI_PARTITION
+	atari_partition,
+#endif
+#ifdef CONFIG_MAC_PARTITION
+	mac_partition,
+#endif
+#ifdef CONFIG_ULTRIX_PARTITION
+	ultrix_partition,
+#endif
+#ifdef CONFIG_IBM_PARTITION
+	ibm_partition,
+#endif
+#ifdef CONFIG_KARMA_PARTITION
+	karma_partition,
+#endif
+#ifdef CONFIG_SYSV68_PARTITION
+	sysv68_partition,
+#endif
+	NULL
+};
+
+static struct parsed_partitions *allocate_partitions(struct gendisk *hd)
+{
+	struct parsed_partitions *state;
+	int nr;
 
-#include "partitions/check.h"
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+
+	nr = disk_max_parts(hd);
+	state->parts = vzalloc(array_size(nr, sizeof(state->parts[0])));
+	if (!state->parts) {
+		kfree(state);
+		return NULL;
+	}
+
+	state->limit = nr;
+
+	return state;
+}
+
+static void free_partitions(struct parsed_partitions *state)
+{
+	vfree(state->parts);
+	kfree(state);
+}
+
+static struct parsed_partitions *check_partition(struct gendisk *hd,
+		struct block_device *bdev)
+{
+	struct parsed_partitions *state;
+	int i, res, err;
+
+	state = allocate_partitions(hd);
+	if (!state)
+		return NULL;
+	state->pp_buf = (char *)__get_free_page(GFP_KERNEL);
+	if (!state->pp_buf) {
+		free_partitions(state);
+		return NULL;
+	}
+	state->pp_buf[0] = '\0';
+
+	state->bdev = bdev;
+	disk_name(hd, 0, state->name);
+	snprintf(state->pp_buf, PAGE_SIZE, " %s:", state->name);
+	if (isdigit(state->name[strlen(state->name)-1]))
+		sprintf(state->name, "p");
+
+	i = res = err = 0;
+	while (!res && check_part[i]) {
+		memset(state->parts, 0, state->limit * sizeof(state->parts[0]));
+		res = check_part[i++](state);
+		if (res < 0) {
+			/*
+			 * We have hit an I/O error which we don't report now.
+			 * But record it, and let the others do their job.
+			 */
+			err = res;
+			res = 0;
+		}
+
+	}
+	if (res > 0) {
+		printk(KERN_INFO "%s", state->pp_buf);
+
+		free_page((unsigned long)state->pp_buf);
+		return state;
+	}
+	if (state->access_beyond_eod)
+		err = -ENOSPC;
+	/*
+	 * The partition is unrecognized. So report I/O errors if there were any
+	 */
+	if (err)
+		res = err;
+	if (res) {
+		strlcat(state->pp_buf,
+			" unable to read partition table\n", PAGE_SIZE);
+		printk(KERN_INFO "%s", state->pp_buf);
+	}
+
+	free_page((unsigned long)state->pp_buf);
+	free_partitions(state);
+	return ERR_PTR(res);
+}
 
 static ssize_t part_partition_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
-- 
2.24.1

