Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00E11834B3
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgCLPUf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:20:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgCLPUe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lipt5ckcwfM9yooa50sRpcuCHDMWIQlUUAEJOZwYAhk=; b=YXMbAtj3RXevD60KRkT84V64xD
        bTotOaTlqziCMs1bSDp6gJTqndxqVG8DUhWCg4wRD5GhT2kXtp/joLao4BPxoYZUBhF/X1E2WxtCt
        rTOcHBs3SamkqrqfgP/beBy+/I3izacgCCyb88mEVy/tiTBSKTVZwpBVHs/ENpRrCHKkzzJwSSz8W
        9OCX61nNsTz7lyMvRkLek9pGVjwe502z/m9amJvCjGku+pEfwAYs8V1OQ8Uw4XRS3cDRDQxKBj9T6
        KVjVKdg6FfTjYzSJtY+BluptE1CgaV2NZTWpe2rsdD3ACv8cMKuITF6W2m2cL4mrhpK795h7ZZXP5
        ijsepTNA==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPdR-0007ze-9v; Thu, 12 Mar 2020 15:20:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 18/21] block: move the *_PARTITION enum out of genhd.h
Date:   Thu, 12 Mar 2020 16:19:36 +0100
Message-Id: <20200312151939.645254-19-hch@lst.de>
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

The enum containing the *_PARTITION symbolic names is only relevant
for the partition parser.  More specifically most values are MSDOS
partition table system indicators and thus should go straight into
msdos.c.  One value is only used by the sun partition parser, and the
sun and sgi partition parsers use the same value as the x86 Linux
RAID indicator to also indicate RAID autodetection.  Duplicate them
in sun.c and sgi.c given that the different partition types use
entirely different values otherwise.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/sgi.c          |  4 ++++
 block/partitions/sun.c          |  5 +++++
 include/linux/genhd.h           | 30 ------------------------------
 include/linux/msdos_partition.h | 31 +++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/block/partitions/sgi.c b/block/partitions/sgi.c
index 927cf501603e..4273f1bb0515 100644
--- a/block/partitions/sgi.c
+++ b/block/partitions/sgi.c
@@ -9,6 +9,10 @@
 
 #define SGI_LABEL_MAGIC 0x0be5a941
 
+enum {
+	LINUX_RAID_PARTITION = 0xfd,	/* autodetect RAID partition */
+};
+
 struct sgi_disklabel {
 	__be32 magic_mushroom;		/* Big fat spliff... */
 	__be16 root_part_num;		/* Root partition number */
diff --git a/block/partitions/sun.c b/block/partitions/sun.c
index 28b44100f2b1..47dc53eccf77 100644
--- a/block/partitions/sun.c
+++ b/block/partitions/sun.c
@@ -13,6 +13,11 @@
 #define SUN_LABEL_MAGIC          0xDABE
 #define SUN_VTOC_SANITY          0x600DDEEE
 
+enum {
+	SUN_WHOLE_DISK = 5,
+	LINUX_RAID_PARTITION = 0xfd,	/* autodetect RAID partition */
+};
+
 int sun_partition(struct parsed_partitions *state)
 {
 	int i;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 81f21a7ad6f9..df809e91ad99 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -30,36 +30,6 @@ extern struct device_type part_type;
 extern struct kobject *block_depr;
 extern struct class block_class;
 
-enum {
-/* These three have identical behaviour; use the second one if DOS FDISK gets
-   confused about extended/logical partitions starting past cylinder 1023. */
-	DOS_EXTENDED_PARTITION = 5,
-	LINUX_EXTENDED_PARTITION = 0x85,
-	WIN98_EXTENDED_PARTITION = 0x0f,
-
-	SUN_WHOLE_DISK = DOS_EXTENDED_PARTITION,
-
-	LINUX_SWAP_PARTITION = 0x82,
-	LINUX_DATA_PARTITION = 0x83,
-	LINUX_LVM_PARTITION = 0x8e,
-	LINUX_RAID_PARTITION = 0xfd,	/* autodetect RAID partition */
-
-	SOLARIS_X86_PARTITION =	LINUX_SWAP_PARTITION,
-	NEW_SOLARIS_X86_PARTITION = 0xbf,
-
-	DM6_AUX1PARTITION = 0x51,	/* no DDO:  use xlated geom */
-	DM6_AUX3PARTITION = 0x53,	/* no DDO:  use xlated geom */
-	DM6_PARTITION =	0x54,		/* has DDO: use xlated geom & offset */
-	EZD_PARTITION =	0x55,		/* EZ-DRIVE */
-
-	FREEBSD_PARTITION = 0xa5,	/* FreeBSD Partition ID */
-	OPENBSD_PARTITION = 0xa6,	/* OpenBSD Partition ID */
-	NETBSD_PARTITION = 0xa9,	/* NetBSD Partition ID */
-	BSDI_PARTITION = 0xb7,		/* BSDI Partition ID */
-	MINIX_PARTITION = 0x81,		/* Minix Partition ID */
-	UNIXWARE_PARTITION = 0x63,	/* Same as GNU_HURD and SCO Unix */
-};
-
 #define DISK_MAX_PARTS			256
 #define DISK_NAME_LEN			32
 
diff --git a/include/linux/msdos_partition.h b/include/linux/msdos_partition.h
index a8e2c1b4bc66..e151af072cd1 100644
--- a/include/linux/msdos_partition.h
+++ b/include/linux/msdos_partition.h
@@ -17,4 +17,35 @@ struct msdos_partition {
 	__le32 nr_sects;	/* nr of sectors in partition */
 } __packed;
 
+enum msdos_sys_ind {
+	/*
+	 * These three have identical behaviour; use the second one if DOS FDISK
+	 * gets confused about extended/logical partitions starting past
+	 * cylinder 1023.
+	 */
+	DOS_EXTENDED_PARTITION = 5,
+	LINUX_EXTENDED_PARTITION = 0x85,
+	WIN98_EXTENDED_PARTITION = 0x0f,
+
+	LINUX_SWAP_PARTITION = 0x82,
+	LINUX_DATA_PARTITION = 0x83,
+	LINUX_LVM_PARTITION = 0x8e,
+	LINUX_RAID_PARTITION = 0xfd,	/* autodetect RAID partition */
+
+	SOLARIS_X86_PARTITION =	LINUX_SWAP_PARTITION,
+	NEW_SOLARIS_X86_PARTITION = 0xbf,
+
+	DM6_AUX1PARTITION = 0x51,	/* no DDO:  use xlated geom */
+	DM6_AUX3PARTITION = 0x53,	/* no DDO:  use xlated geom */
+	DM6_PARTITION =	0x54,		/* has DDO: use xlated geom & offset */
+	EZD_PARTITION =	0x55,		/* EZ-DRIVE */
+
+	FREEBSD_PARTITION = 0xa5,	/* FreeBSD Partition ID */
+	OPENBSD_PARTITION = 0xa6,	/* OpenBSD Partition ID */
+	NETBSD_PARTITION = 0xa9,	/* NetBSD Partition ID */
+	BSDI_PARTITION = 0xb7,		/* BSDI Partition ID */
+	MINIX_PARTITION = 0x81,		/* Minix Partition ID */
+	UNIXWARE_PARTITION = 0x63,	/* Same as GNU_HURD and SCO Unix */
+};
+
 #endif /* LINUX_MSDOS_PARTITION_H */
-- 
2.24.1

