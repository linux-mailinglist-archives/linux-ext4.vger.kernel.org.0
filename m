Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474F518349A
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgCLPUU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:20:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCLPUS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ibg05CQ5tiJEO71EHNM7qiKpWzOqG0p9hI3kojCryss=; b=OsJTpGR1mGHXY3QaZkDo200zcA
        OMkwXCqDe5LBEi7zLa5xdD5lVb9DsU2Mdk1ZVRKgeZIQW/JNlj80J8X+hKtGOStxlX8FTKKmvgHHN
        x+19PY9Q7aMkQRQThleVT6r0TJ/21C1VfUoxR61Q80H5MghaMV4exJisvMYk7xI+knYQvG7Ju90nS
        XooM8KgIpahQP9Vnj2zva3ta/NPQqIXSpWnPA+SVl4RVlGhk9reI9nz77IkRLq3s8nGwH1B3AI4yX
        NKtjNeQ98X81sPeWTlvBNEMjS9XY173NVQCQjm5jZcc4DCaT33Ag0xLMUbC9eYk8qaFqbUyvdjRfE
        QNZOkgQg==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPdB-0007tL-E4; Thu, 12 Mar 2020 15:20:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 12/21] block: declare all partition detection routines in check.h
Date:   Thu, 12 Mar 2020 16:19:30 +0100
Message-Id: <20200312151939.645254-13-hch@lst.de>
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

There is no good reason to include one header per partition type in
core.c.  Instead move the prototypes for the detection routins to
check.h, and remove all now empty headers in block/partitions/.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/acorn.c   |  1 -
 block/partitions/acorn.h   | 15 ---------------
 block/partitions/aix.c     |  1 -
 block/partitions/aix.h     |  2 --
 block/partitions/amiga.c   |  1 -
 block/partitions/amiga.h   |  7 -------
 block/partitions/atari.h   |  1 -
 block/partitions/check.c   | 16 ----------------
 block/partitions/check.h   | 22 ++++++++++++++++++++++
 block/partitions/cmdline.c |  1 -
 block/partitions/cmdline.h |  3 ---
 block/partitions/efi.h     |  3 ---
 block/partitions/ibm.c     |  1 -
 block/partitions/ibm.h     |  2 --
 block/partitions/karma.h   |  3 ---
 block/partitions/ldm.h     |  2 --
 block/partitions/mac.h     |  1 -
 block/partitions/msdos.c   |  1 -
 block/partitions/msdos.h   |  1 -
 block/partitions/osf.h     |  1 -
 block/partitions/sgi.h     |  1 -
 block/partitions/sun.h     |  1 -
 block/partitions/sysv68.c  |  1 -
 block/partitions/sysv68.h  |  2 --
 block/partitions/ultrix.c  |  1 -
 block/partitions/ultrix.h  |  6 ------
 26 files changed, 22 insertions(+), 75 deletions(-)
 delete mode 100644 block/partitions/acorn.h
 delete mode 100644 block/partitions/aix.h
 delete mode 100644 block/partitions/amiga.h
 delete mode 100644 block/partitions/cmdline.h
 delete mode 100644 block/partitions/ibm.h
 delete mode 100644 block/partitions/sysv68.h
 delete mode 100644 block/partitions/ultrix.h

diff --git a/block/partitions/acorn.c b/block/partitions/acorn.c
index 7587700fad4a..c64c57b958bf 100644
--- a/block/partitions/acorn.c
+++ b/block/partitions/acorn.c
@@ -11,7 +11,6 @@
 #include <linux/adfs_fs.h>
 
 #include "check.h"
-#include "acorn.h"
 
 /*
  * Partition types. (Oh for reusability)
diff --git a/block/partitions/acorn.h b/block/partitions/acorn.h
deleted file mode 100644
index 67b06601ca4c..000000000000
--- a/block/partitions/acorn.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * linux/fs/partitions/acorn.h
- *
- * Copyright (C) 1996-2001 Russell King.
- *
- *  I _hate_ this partitioning mess - why can't we have one defined
- *  format, and everyone stick to it?
- */
-
-int adfspart_check_CUMANA(struct parsed_partitions *state);
-int adfspart_check_ADFS(struct parsed_partitions *state);
-int adfspart_check_ICS(struct parsed_partitions *state);
-int adfspart_check_POWERTEC(struct parsed_partitions *state);
-int adfspart_check_EESOX(struct parsed_partitions *state);
diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 903f3ed175d0..c7b4fd1a4a97 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -6,7 +6,6 @@
  */
 
 #include "check.h"
-#include "aix.h"
 
 struct lvm_rec {
 	char lvm_id[4]; /* "_LVM" */
diff --git a/block/partitions/aix.h b/block/partitions/aix.h
deleted file mode 100644
index b4449f0b9f2b..000000000000
--- a/block/partitions/aix.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-extern int aix_partition(struct parsed_partitions *state);
diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 7fecc760b78f..9526491d9aed 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -14,7 +14,6 @@
 #include <linux/affs_hardblocks.h>
 
 #include "check.h"
-#include "amiga.h"
 
 static __inline__ u32
 checksum_block(__be32 *m, int size)
diff --git a/block/partitions/amiga.h b/block/partitions/amiga.h
deleted file mode 100644
index 7e63f4d9d969..000000000000
--- a/block/partitions/amiga.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  fs/partitions/amiga.h
- */
-
-int amiga_partition(struct parsed_partitions *state);
-
diff --git a/block/partitions/atari.h b/block/partitions/atari.h
index 01c2b9457394..678202442fd3 100644
--- a/block/partitions/atari.h
+++ b/block/partitions/atari.h
@@ -34,4 +34,3 @@ struct rootsector
   u16 checksum;			/* checksum for bootable disks */
 } __packed;
 
-int atari_partition(struct parsed_partitions *state);
diff --git a/block/partitions/check.c b/block/partitions/check.c
index 8fe46881ef63..944c478b6f0b 100644
--- a/block/partitions/check.c
+++ b/block/partitions/check.c
@@ -21,22 +21,6 @@
 
 #include "check.h"
 
-#include "acorn.h"
-#include "amiga.h"
-#include "atari.h"
-#include "ldm.h"
-#include "mac.h"
-#include "msdos.h"
-#include "osf.h"
-#include "sgi.h"
-#include "sun.h"
-#include "ibm.h"
-#include "ultrix.h"
-#include "efi.h"
-#include "karma.h"
-#include "sysv68.h"
-#include "cmdline.h"
-
 static int (*check_part[])(struct parsed_partitions *) = {
 	/*
 	 * Probe partition formats with tables at disk address 0
diff --git a/block/partitions/check.h b/block/partitions/check.h
index 19852b494e93..23e7adb79617 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -50,3 +50,25 @@ put_partition(struct parsed_partitions *p, int n, sector_t from, sector_t size)
 		strlcat(p->pp_buf, tmp, PAGE_SIZE);
 	}
 }
+
+/* detection routines go here in alphabetical order: */
+int adfspart_check_ADFS(struct parsed_partitions *state);
+int adfspart_check_CUMANA(struct parsed_partitions *state);
+int adfspart_check_EESOX(struct parsed_partitions *state);
+int adfspart_check_ICS(struct parsed_partitions *state);
+int adfspart_check_POWERTEC(struct parsed_partitions *state);
+int aix_partition(struct parsed_partitions *state);
+int amiga_partition(struct parsed_partitions *state);
+int atari_partition(struct parsed_partitions *state);
+int cmdline_partition(struct parsed_partitions *state);
+int efi_partition(struct parsed_partitions *state);
+int ibm_partition(struct parsed_partitions *);
+int karma_partition(struct parsed_partitions *state);
+int ldm_partition(struct parsed_partitions *state);
+int mac_partition(struct parsed_partitions *state);
+int msdos_partition(struct parsed_partitions *state);
+int osf_partition(struct parsed_partitions *state);
+int sgi_partition(struct parsed_partitions *state);
+int sun_partition(struct parsed_partitions *state);
+int sysv68_partition(struct parsed_partitions *state);
+int ultrix_partition(struct parsed_partitions *state);
diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index f1edd5452249..8f545c36cde4 100644
--- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -18,7 +18,6 @@
 #include <linux/cmdline-parser.h>
 
 #include "check.h"
-#include "cmdline.h"
 
 static char *cmdline;
 static struct cmdline_parts *bdev_parts;
diff --git a/block/partitions/cmdline.h b/block/partitions/cmdline.h
deleted file mode 100644
index e64a31636a1f..000000000000
--- a/block/partitions/cmdline.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-int cmdline_partition(struct parsed_partitions *state);
diff --git a/block/partitions/efi.h b/block/partitions/efi.h
index 3e8576157575..907bac5ce8f7 100644
--- a/block/partitions/efi.h
+++ b/block/partitions/efi.h
@@ -113,7 +113,4 @@ typedef struct _legacy_mbr {
 	__le16 signature;
 } __packed legacy_mbr;
 
-/* Functions */
-extern int efi_partition(struct parsed_partitions *state);
-
 #endif
diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
index a5d480f807f3..073faa6a69b8 100644
--- a/block/partitions/ibm.c
+++ b/block/partitions/ibm.c
@@ -15,7 +15,6 @@
 #include <asm/vtoc.h>
 
 #include "check.h"
-#include "ibm.h"
 
 
 union label_t {
diff --git a/block/partitions/ibm.h b/block/partitions/ibm.h
deleted file mode 100644
index 8bf13febb2b6..000000000000
--- a/block/partitions/ibm.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-int ibm_partition(struct parsed_partitions *);
diff --git a/block/partitions/karma.h b/block/partitions/karma.h
index 48e074d417fb..1b5eec57ee0c 100644
--- a/block/partitions/karma.h
+++ b/block/partitions/karma.h
@@ -4,6 +4,3 @@
  */
 
 #define KARMA_LABEL_MAGIC		0xAB56
-
-int karma_partition(struct parsed_partitions *state);
-
diff --git a/block/partitions/ldm.h b/block/partitions/ldm.h
index 1ca63e97bccc..841580af7f9b 100644
--- a/block/partitions/ldm.h
+++ b/block/partitions/ldm.h
@@ -193,7 +193,5 @@ struct ldmdb {				/* Cache of the database */
 	struct list_head v_part;
 };
 
-int ldm_partition(struct parsed_partitions *state);
-
 #endif /* _FS_PT_LDM_H_ */
 
diff --git a/block/partitions/mac.h b/block/partitions/mac.h
index 453ed2964804..0e41c9da7532 100644
--- a/block/partitions/mac.h
+++ b/block/partitions/mac.h
@@ -42,4 +42,3 @@ struct mac_driver_desc {
     /* ... more stuff */
 };
 
-int mac_partition(struct parsed_partitions *state);
diff --git a/block/partitions/msdos.c b/block/partitions/msdos.c
index 82c44f7df911..c572022f3781 100644
--- a/block/partitions/msdos.c
+++ b/block/partitions/msdos.c
@@ -24,7 +24,6 @@
 #include "check.h"
 #include "msdos.h"
 #include "efi.h"
-#include "aix.h"
 
 /*
  * Many architectures don't like unaligned accesses, while
diff --git a/block/partitions/msdos.h b/block/partitions/msdos.h
index fcacfc486092..123e666bb932 100644
--- a/block/partitions/msdos.h
+++ b/block/partitions/msdos.h
@@ -5,5 +5,4 @@
 
 #define MSDOS_LABEL_MAGIC		0xAA55
 
-int msdos_partition(struct parsed_partitions *state);
 
diff --git a/block/partitions/osf.h b/block/partitions/osf.h
index 4d8088e7ea8c..80a58c382b3f 100644
--- a/block/partitions/osf.h
+++ b/block/partitions/osf.h
@@ -5,4 +5,3 @@
 
 #define DISKLABELMAGIC (0x82564557UL)
 
-int osf_partition(struct parsed_partitions *state);
diff --git a/block/partitions/sgi.h b/block/partitions/sgi.h
index a5b77c3987cf..372cdad19fea 100644
--- a/block/partitions/sgi.h
+++ b/block/partitions/sgi.h
@@ -3,7 +3,6 @@
  *  fs/partitions/sgi.h
  */
 
-extern int sgi_partition(struct parsed_partitions *state);
 
 #define SGI_LABEL_MAGIC 0x0be5a941
 
diff --git a/block/partitions/sun.h b/block/partitions/sun.h
index ae1b9eed3fd7..4c8877a5b52d 100644
--- a/block/partitions/sun.h
+++ b/block/partitions/sun.h
@@ -6,4 +6,3 @@
 #define SUN_LABEL_MAGIC          0xDABE
 #define SUN_VTOC_SANITY          0x600DDEEE
 
-int sun_partition(struct parsed_partitions *state);
diff --git a/block/partitions/sysv68.c b/block/partitions/sysv68.c
index 92e810826b01..6f6257fd4eb4 100644
--- a/block/partitions/sysv68.c
+++ b/block/partitions/sysv68.c
@@ -6,7 +6,6 @@
  */
 
 #include "check.h"
-#include "sysv68.h"
 
 /*
  *	Volume ID structure: on first 256-bytes sector of disk
diff --git a/block/partitions/sysv68.h b/block/partitions/sysv68.h
deleted file mode 100644
index 4fb6b8ec78ae..000000000000
--- a/block/partitions/sysv68.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-extern int sysv68_partition(struct parsed_partitions *state);
diff --git a/block/partitions/ultrix.c b/block/partitions/ultrix.c
index ecd0d7346c3d..4aaa81043ca0 100644
--- a/block/partitions/ultrix.c
+++ b/block/partitions/ultrix.c
@@ -8,7 +8,6 @@
  */
 
 #include "check.h"
-#include "ultrix.h"
 
 int ultrix_partition(struct parsed_partitions *state)
 {
diff --git a/block/partitions/ultrix.h b/block/partitions/ultrix.h
deleted file mode 100644
index 9f676cead222..000000000000
--- a/block/partitions/ultrix.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  fs/partitions/ultrix.h
- */
-
-int ultrix_partition(struct parsed_partitions *state);
-- 
2.24.1

