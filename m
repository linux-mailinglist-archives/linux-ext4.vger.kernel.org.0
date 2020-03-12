Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EB31834CB
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgCLPUl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:20:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgCLPUj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jg5Ikjka+2a5oT8ZR/+QyqBsLnDSjPYKLVigMGA6FAo=; b=Za8E3LC12qGkc4+Mjqnns8zSqi
        SW9tLFxOJ6wyopYr+Y60TxuT0TbFDa9NrucHKKlAXz5Kp6Q2D0Y8sM1xHi5X+/Drua2dd4rcZTTPU
        6XvznsB2SalaqWsiLx719Kf6ZuxBRCuiH3OoiZk5j7PIsd9OjW5RvmMHaGJDIxlhgRJ+7ajWo1Vm0
        BjpGeh6cETNEya3036xQq6FnsXBgQrITJBNWoh+TGHQ1eBbZ7hiTgXU5MK90aw6zMo4nlpfJvYL5M
        dXbtDLjWvzBDHerJjbJEzwNjckuq677L0Ea5arHfubFB8hyQvwIN8RhHVp3ON+527VW9U5FVweetz
        yosO9Nsw==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPdW-00081c-Nk; Thu, 12 Mar 2020 15:20:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 20/21] block: move the various x86 Unix label formats out of genhd.h
Date:   Thu, 12 Mar 2020 16:19:38 +0100
Message-Id: <20200312151939.645254-21-hch@lst.de>
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

All these are just used in block/partitions/msdos.c, so move them out of the
genhd.h driver included by every driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/msdos.c | 125 ++++++++++++++++++++++++++++++++++
 include/linux/genhd.h    | 143 ---------------------------------------
 2 files changed, 125 insertions(+), 143 deletions(-)

diff --git a/block/partitions/msdos.c b/block/partitions/msdos.c
index e44e2f0a02cc..8f2fcc080264 100644
--- a/block/partitions/msdos.c
+++ b/block/partitions/msdos.c
@@ -18,6 +18,12 @@
  *  Check partition table on IDE disks for common CHS translations
  *
  *  Re-organised Feb 1998 Russell King
+ *
+ *  BSD disklabel support by Yossi Gottlieb <yogo@math.tau.ac.il>
+ *  updated by Marc Espie <Marc.Espie@openbsd.org>
+ *
+ *  Unixware slices support by Andrzej Krzysztofowicz <ankry@mif.pg.gda.pl>
+ *  and Krzysztof G. Baranowski <kgb@knm.org.pl>
  */
 #include <linux/msdos_fs.h>
 #include <linux/msdos_partition.h>
@@ -215,6 +221,30 @@ static void parse_extended(struct parsed_partitions *state,
 	put_dev_sector(sect);
 }
 
+#define SOLARIS_X86_NUMSLICE	16
+#define SOLARIS_X86_VTOC_SANE	(0x600DDEEEUL)
+
+struct solaris_x86_slice {
+	__le16 s_tag;		/* ID tag of partition */
+	__le16 s_flag;		/* permission flags */
+	__le32 s_start;		/* start sector no of partition */
+	__le32 s_size;		/* # of blocks in partition */
+};
+
+struct solaris_x86_vtoc {
+	unsigned int v_bootinfo[3];	/* info needed by mboot */
+	__le32 v_sanity;		/* to verify vtoc sanity */
+	__le32 v_version;		/* layout version */
+	char	v_volume[8];		/* volume name */
+	__le16	v_sectorsz;		/* sector size in bytes */
+	__le16	v_nparts;		/* number of partitions */
+	unsigned int v_reserved[10];	/* free space */
+	struct solaris_x86_slice
+		v_slice[SOLARIS_X86_NUMSLICE]; /* slice headers */
+	unsigned int timestamp[SOLARIS_X86_NUMSLICE]; /* timestamp */
+	char	v_asciilabel[128];	/* for compatibility */
+};
+
 /* james@bpgc.com: Solaris has a nasty indicator: 0x82 which also
    indicates linux swap.  Be careful before believing this is Solaris. */
 
@@ -270,6 +300,54 @@ static void parse_solaris_x86(struct parsed_partitions *state,
 #endif
 }
 
+/* check against BSD src/sys/sys/disklabel.h for consistency */
+#define BSD_DISKMAGIC	(0x82564557UL)	/* The disk magic number */
+#define BSD_MAXPARTITIONS	16
+#define OPENBSD_MAXPARTITIONS	16
+#define BSD_FS_UNUSED		0 /* disklabel unused partition entry ID */
+struct bsd_disklabel {
+	__le32	d_magic;		/* the magic number */
+	__s16	d_type;			/* drive type */
+	__s16	d_subtype;		/* controller/d_type specific */
+	char	d_typename[16];		/* type name, e.g. "eagle" */
+	char	d_packname[16];		/* pack identifier */
+	__u32	d_secsize;		/* # of bytes per sector */
+	__u32	d_nsectors;		/* # of data sectors per track */
+	__u32	d_ntracks;		/* # of tracks per cylinder */
+	__u32	d_ncylinders;		/* # of data cylinders per unit */
+	__u32	d_secpercyl;		/* # of data sectors per cylinder */
+	__u32	d_secperunit;		/* # of data sectors per unit */
+	__u16	d_sparespertrack;	/* # of spare sectors per track */
+	__u16	d_sparespercyl;		/* # of spare sectors per cylinder */
+	__u32	d_acylinders;		/* # of alt. cylinders per unit */
+	__u16	d_rpm;			/* rotational speed */
+	__u16	d_interleave;		/* hardware sector interleave */
+	__u16	d_trackskew;		/* sector 0 skew, per track */
+	__u16	d_cylskew;		/* sector 0 skew, per cylinder */
+	__u32	d_headswitch;		/* head switch time, usec */
+	__u32	d_trkseek;		/* track-to-track seek, usec */
+	__u32	d_flags;		/* generic flags */
+#define NDDATA 5
+	__u32	d_drivedata[NDDATA];	/* drive-type specific information */
+#define NSPARE 5
+	__u32	d_spare[NSPARE];	/* reserved for future use */
+	__le32	d_magic2;		/* the magic number (again) */
+	__le16	d_checksum;		/* xor of data incl. partitions */
+
+			/* filesystem and partition information: */
+	__le16	d_npartitions;		/* number of partitions in following */
+	__le32	d_bbsize;		/* size of boot area at sn0, bytes */
+	__le32	d_sbsize;		/* max size of fs superblock, bytes */
+	struct	bsd_partition {		/* the partition table */
+		__le32	p_size;		/* number of sectors in partition */
+		__le32	p_offset;	/* starting sector */
+		__le32	p_fsize;	/* filesystem basic fragment size */
+		__u8	p_fstype;	/* filesystem type, see below */
+		__u8	p_frag;		/* filesystem fragments per block */
+		__le16	p_cpg;		/* filesystem cylinders per group */
+	} d_partitions[BSD_MAXPARTITIONS];	/* actually may be more */
+};
+
 #if defined(CONFIG_BSD_DISKLABEL)
 /*
  * Create devices for BSD partitions listed in a disklabel, under a
@@ -354,6 +432,51 @@ static void parse_openbsd(struct parsed_partitions *state,
 #endif
 }
 
+#define UNIXWARE_DISKMAGIC     (0xCA5E600DUL)	/* The disk magic number */
+#define UNIXWARE_DISKMAGIC2    (0x600DDEEEUL)	/* The slice table magic nr */
+#define UNIXWARE_NUMSLICE      16
+#define UNIXWARE_FS_UNUSED     0		/* Unused slice entry ID */
+
+struct unixware_slice {
+	__le16   s_label;	/* label */
+	__le16   s_flags;	/* permission flags */
+	__le32   start_sect;	/* starting sector */
+	__le32   nr_sects;	/* number of sectors in slice */
+};
+
+struct unixware_disklabel {
+	__le32	d_type;			/* drive type */
+	__le32	d_magic;		/* the magic number */
+	__le32	d_version;		/* version number */
+	char	d_serial[12];		/* serial number of the device */
+	__le32	d_ncylinders;		/* # of data cylinders per device */
+	__le32	d_ntracks;		/* # of tracks per cylinder */
+	__le32	d_nsectors;		/* # of data sectors per track */
+	__le32	d_secsize;		/* # of bytes per sector */
+	__le32	d_part_start;		/* # of first sector of this partition*/
+	__le32	d_unknown1[12];		/* ? */
+	__le32	d_alt_tbl;		/* byte offset of alternate table */
+	__le32	d_alt_len;		/* byte length of alternate table */
+	__le32	d_phys_cyl;		/* # of physical cylinders per device */
+	__le32	d_phys_trk;		/* # of physical tracks per cylinder */
+	__le32	d_phys_sec;		/* # of physical sectors per track */
+	__le32	d_phys_bytes;		/* # of physical bytes per sector */
+	__le32	d_unknown2;		/* ? */
+	__le32	d_unknown3;		/* ? */
+	__le32	d_pad[8];		/* pad */
+
+	struct unixware_vtoc {
+		__le32	v_magic;		/* the magic number */
+		__le32	v_version;		/* version number */
+		char	v_name[8];		/* volume name */
+		__le16	v_nslices;		/* # of slices */
+		__le16	v_unknown1;		/* ? */
+		__le32	v_reserved[10];		/* reserved */
+		struct unixware_slice
+			v_slice[UNIXWARE_NUMSLICE];	/* slice headers */
+	} vtoc;
+};  /* 408 */
+
 /*
  * Create devices for Unixware partitions listed in a disklabel, under a
  * dos-like partition. See parse_extended() for more information.
@@ -397,6 +520,8 @@ static void parse_unixware(struct parsed_partitions *state,
 #endif
 }
 
+#define MINIX_NR_SUBPARTITIONS  4
+
 /*
  * Minix 2.0.0/2.0.2 subpartition support.
  * Anand Krishnamurthy <anandk@wiproge.med.ge.com>
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index df809e91ad99..21178f7b379c 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -424,149 +424,6 @@ static inline void set_capacity(struct gendisk *disk, sector_t size)
 	disk->part0.nr_sects = size;
 }
 
-#ifdef CONFIG_SOLARIS_X86_PARTITION
-
-#define SOLARIS_X86_NUMSLICE	16
-#define SOLARIS_X86_VTOC_SANE	(0x600DDEEEUL)
-
-struct solaris_x86_slice {
-	__le16 s_tag;		/* ID tag of partition */
-	__le16 s_flag;		/* permission flags */
-	__le32 s_start;		/* start sector no of partition */
-	__le32 s_size;		/* # of blocks in partition */
-};
-
-struct solaris_x86_vtoc {
-	unsigned int v_bootinfo[3];	/* info needed by mboot (unsupported) */
-	__le32 v_sanity;		/* to verify vtoc sanity */
-	__le32 v_version;		/* layout version */
-	char	v_volume[8];		/* volume name */
-	__le16	v_sectorsz;		/* sector size in bytes */
-	__le16	v_nparts;		/* number of partitions */
-	unsigned int v_reserved[10];	/* free space */
-	struct solaris_x86_slice
-		v_slice[SOLARIS_X86_NUMSLICE]; /* slice headers */
-	unsigned int timestamp[SOLARIS_X86_NUMSLICE]; /* timestamp (unsupported) */
-	char	v_asciilabel[128];	/* for compatibility */
-};
-
-#endif /* CONFIG_SOLARIS_X86_PARTITION */
-
-#ifdef CONFIG_BSD_DISKLABEL
-/*
- * BSD disklabel support by Yossi Gottlieb <yogo@math.tau.ac.il>
- * updated by Marc Espie <Marc.Espie@openbsd.org>
- */
-
-/* check against BSD src/sys/sys/disklabel.h for consistency */
-
-#define BSD_DISKMAGIC	(0x82564557UL)	/* The disk magic number */
-#define BSD_MAXPARTITIONS	16
-#define OPENBSD_MAXPARTITIONS	16
-#define BSD_FS_UNUSED		0	/* disklabel unused partition entry ID */
-struct bsd_disklabel {
-	__le32	d_magic;		/* the magic number */
-	__s16	d_type;			/* drive type */
-	__s16	d_subtype;		/* controller/d_type specific */
-	char	d_typename[16];		/* type name, e.g. "eagle" */
-	char	d_packname[16];			/* pack identifier */ 
-	__u32	d_secsize;		/* # of bytes per sector */
-	__u32	d_nsectors;		/* # of data sectors per track */
-	__u32	d_ntracks;		/* # of tracks per cylinder */
-	__u32	d_ncylinders;		/* # of data cylinders per unit */
-	__u32	d_secpercyl;		/* # of data sectors per cylinder */
-	__u32	d_secperunit;		/* # of data sectors per unit */
-	__u16	d_sparespertrack;	/* # of spare sectors per track */
-	__u16	d_sparespercyl;		/* # of spare sectors per cylinder */
-	__u32	d_acylinders;		/* # of alt. cylinders per unit */
-	__u16	d_rpm;			/* rotational speed */
-	__u16	d_interleave;		/* hardware sector interleave */
-	__u16	d_trackskew;		/* sector 0 skew, per track */
-	__u16	d_cylskew;		/* sector 0 skew, per cylinder */
-	__u32	d_headswitch;		/* head switch time, usec */
-	__u32	d_trkseek;		/* track-to-track seek, usec */
-	__u32	d_flags;		/* generic flags */
-#define NDDATA 5
-	__u32	d_drivedata[NDDATA];	/* drive-type specific information */
-#define NSPARE 5
-	__u32	d_spare[NSPARE];	/* reserved for future use */
-	__le32	d_magic2;		/* the magic number (again) */
-	__le16	d_checksum;		/* xor of data incl. partitions */
-
-			/* filesystem and partition information: */
-	__le16	d_npartitions;		/* number of partitions in following */
-	__le32	d_bbsize;		/* size of boot area at sn0, bytes */
-	__le32	d_sbsize;		/* max size of fs superblock, bytes */
-	struct	bsd_partition {		/* the partition table */
-		__le32	p_size;		/* number of sectors in partition */
-		__le32	p_offset;	/* starting sector */
-		__le32	p_fsize;	/* filesystem basic fragment size */
-		__u8	p_fstype;	/* filesystem type, see below */
-		__u8	p_frag;		/* filesystem fragments per block */
-		__le16	p_cpg;		/* filesystem cylinders per group */
-	} d_partitions[BSD_MAXPARTITIONS];	/* actually may be more */
-};
-
-#endif	/* CONFIG_BSD_DISKLABEL */
-
-#ifdef CONFIG_UNIXWARE_DISKLABEL
-/*
- * Unixware slices support by Andrzej Krzysztofowicz <ankry@mif.pg.gda.pl>
- * and Krzysztof G. Baranowski <kgb@knm.org.pl>
- */
-
-#define UNIXWARE_DISKMAGIC     (0xCA5E600DUL)	/* The disk magic number */
-#define UNIXWARE_DISKMAGIC2    (0x600DDEEEUL)	/* The slice table magic nr */
-#define UNIXWARE_NUMSLICE      16
-#define UNIXWARE_FS_UNUSED     0		/* Unused slice entry ID */
-
-struct unixware_slice {
-	__le16   s_label;	/* label */
-	__le16   s_flags;	/* permission flags */
-	__le32   start_sect;	/* starting sector */
-	__le32   nr_sects;	/* number of sectors in slice */
-};
-
-struct unixware_disklabel {
-	__le32   d_type;               	/* drive type */
-	__le32   d_magic;                /* the magic number */
-	__le32   d_version;              /* version number */
-	char    d_serial[12];           /* serial number of the device */
-	__le32   d_ncylinders;           /* # of data cylinders per device */
-	__le32   d_ntracks;              /* # of tracks per cylinder */
-	__le32   d_nsectors;             /* # of data sectors per track */
-	__le32   d_secsize;              /* # of bytes per sector */
-	__le32   d_part_start;           /* # of first sector of this partition */
-	__le32   d_unknown1[12];         /* ? */
- 	__le32	d_alt_tbl;              /* byte offset of alternate table */
- 	__le32	d_alt_len;              /* byte length of alternate table */
- 	__le32	d_phys_cyl;             /* # of physical cylinders per device */
- 	__le32	d_phys_trk;             /* # of physical tracks per cylinder */
- 	__le32	d_phys_sec;             /* # of physical sectors per track */
- 	__le32	d_phys_bytes;           /* # of physical bytes per sector */
- 	__le32	d_unknown2;             /* ? */
-	__le32   d_unknown3;             /* ? */
-	__le32	d_pad[8];               /* pad */
-
-	struct unixware_vtoc {
-		__le32	v_magic;		/* the magic number */
-		__le32	v_version;		/* version number */
-		char	v_name[8];		/* volume name */
-		__le16	v_nslices;		/* # of slices */
-		__le16	v_unknown1;		/* ? */
-		__le32	v_reserved[10];		/* reserved */
-		struct unixware_slice
-			v_slice[UNIXWARE_NUMSLICE];	/* slice headers */
-	} vtoc;
-
-};  /* 408 */
-
-#endif /* CONFIG_UNIXWARE_DISKLABEL */
-
-#ifdef CONFIG_MINIX_SUBPARTITION
-#   define MINIX_NR_SUBPARTITIONS  4
-#endif /* CONFIG_MINIX_SUBPARTITION */
-
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
 #define ADDPART_FLAG_WHOLEDISK	2
-- 
2.24.1

