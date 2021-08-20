Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777FB3F34C6
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 21:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhHTTrn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 15:47:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39882 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbhHTTrn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 15:47:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5BFEA2016D;
        Fri, 20 Aug 2021 19:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629488824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcJdzWWUOpfSKODHYIiwRU50kRFxCE7iXLFcAqRW8ec=;
        b=dT+nojjCa5dGOwilnf1vgYeHQhVqYIR+J3GBU+0Yg9pGbBOMkTecPVHncn0M0oSZtjff+9
        YZQ+/MoMV0R99LehzFA2o2TMdLC//DrE6DOK2BZ1PB46xITfKMAiWflFxCtQhTCBm5V1FP
        dnRpnFASNuGrZ4cwVirhoqWx1+AxigA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629488824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcJdzWWUOpfSKODHYIiwRU50kRFxCE7iXLFcAqRW8ec=;
        b=/S8b7MWxfD+0d8ypGaSwavgyCHHYd4tozNxaUxnP6wQSd7A7EyD1+f30CJWWDhsvCoSn4G
        lwBy3J6HYth4y5CQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 4DC55A3B89;
        Fri, 20 Aug 2021 19:47:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 315541E02C5; Fri, 20 Aug 2021 21:47:01 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] quota: Add support to version 0 quota format
Date:   Fri, 20 Aug 2021 21:46:55 +0200
Message-Id: <20210820194656.27799-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210820194656.27799-1-jack@suse.cz>
References: <20210820194656.27799-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6268; h=from:subject; bh=UhE03jWwtF7/2Unh5tfHgBCzzdLaSNZ7G9C22vuq4H4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhIAaurizE8ehds+qrTxuX1OCIKL+zMflZgbZ3qOb5 4X5jnt+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSAGrgAKCRCcnaoHP2RA2UOpB/ 0R/Xv0X5SlivHpzP04CyguXxcAouSF5GNTwExf8YIXndPrhnmm5FMXiqIBQ0xcEe35KuwecTgX+CC+ Skbe7YZyXg3DDsdFukBMtWlbXKaGYXHlKlAQwLbjQ6Rz8u80pSyVwl897sVCOwJIuysXhNiR5aHPJr u7P52jt65bkZcDuICcz+xaTdTLyyRkl8bSQJV/8Sl157Axz/layhPJbdXboVl60Ibbgwg8XFrh3k/H RPMNtx6GU5FgfxJV5KhcymWyimIzBMllTG6Spy7UwAEKc06DGeWF4pF2r46z1HBXRdji0J85eywZ70 h2brdGy9TzFaEczqb3k1fkx0EZgoZz
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Version 0 quota format differs from version 1 by having only 32-bit
counters for inodes and block limits. For many installations this is not
limiting and thus the format is widely used. Also quota tools still
create quota files with this format by default. Add support for this
quota format to e2fsprogs so that we can seamlessly convert quota files
in this format into our internal quota files.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/support/quotaio_v2.c | 85 +++++++++++++++++++++++++++++++++++++---
 lib/support/quotaio_v2.h | 17 +++++++-
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/lib/support/quotaio_v2.c b/lib/support/quotaio_v2.c
index 23717f03f428..a49aa6ac8c2f 100644
--- a/lib/support/quotaio_v2.c
+++ b/lib/support/quotaio_v2.c
@@ -41,6 +41,68 @@ struct quotafile_ops quotafile_ops_2 = {
 	.report		= v2_report,
 };
 
+/*
+ * Copy dquot from disk to memory
+ */
+static void v2r0_disk2memdqblk(struct dquot *dquot, void *dp)
+{
+	struct util_dqblk *m = &dquot->dq_dqb;
+	struct v2r0_disk_dqblk *d = dp, empty;
+
+	dquot->dq_id = ext2fs_le32_to_cpu(d->dqb_id);
+	m->dqb_ihardlimit = ext2fs_le32_to_cpu(d->dqb_ihardlimit);
+	m->dqb_isoftlimit = ext2fs_le32_to_cpu(d->dqb_isoftlimit);
+	m->dqb_bhardlimit = ext2fs_le32_to_cpu(d->dqb_bhardlimit);
+	m->dqb_bsoftlimit = ext2fs_le32_to_cpu(d->dqb_bsoftlimit);
+	m->dqb_curinodes = ext2fs_le32_to_cpu(d->dqb_curinodes);
+	m->dqb_curspace = ext2fs_le64_to_cpu(d->dqb_curspace);
+	m->dqb_itime = ext2fs_le64_to_cpu(d->dqb_itime);
+	m->dqb_btime = ext2fs_le64_to_cpu(d->dqb_btime);
+
+	memset(&empty, 0, sizeof(struct v2r0_disk_dqblk));
+	empty.dqb_itime = ext2fs_cpu_to_le64(1);
+	if (!memcmp(&empty, dp, sizeof(struct v2r0_disk_dqblk)))
+		m->dqb_itime = 0;
+}
+
+/*
+ * Copy dquot from memory to disk
+ */
+static void v2r0_mem2diskdqblk(void *dp, struct dquot *dquot)
+{
+	struct util_dqblk *m = &dquot->dq_dqb;
+	struct v2r0_disk_dqblk *d = dp;
+
+	d->dqb_ihardlimit = ext2fs_cpu_to_le32(m->dqb_ihardlimit);
+	d->dqb_isoftlimit = ext2fs_cpu_to_le32(m->dqb_isoftlimit);
+	d->dqb_bhardlimit = ext2fs_cpu_to_le32(m->dqb_bhardlimit);
+	d->dqb_bsoftlimit = ext2fs_cpu_to_le32(m->dqb_bsoftlimit);
+	d->dqb_curinodes = ext2fs_cpu_to_le32(m->dqb_curinodes);
+	d->dqb_curspace = ext2fs_cpu_to_le64(m->dqb_curspace);
+	d->dqb_itime = ext2fs_cpu_to_le64(m->dqb_itime);
+	d->dqb_btime = ext2fs_cpu_to_le64(m->dqb_btime);
+	d->dqb_id = ext2fs_cpu_to_le32(dquot->dq_id);
+	if (qtree_entry_unused(&dquot->dq_h->qh_info.u.v2_mdqi.dqi_qtree, dp))
+		d->dqb_itime = ext2fs_cpu_to_le64(1);
+}
+
+static int v2r0_is_id(void *dp, struct dquot *dquot)
+{
+	struct v2r0_disk_dqblk *d = dp;
+	struct qtree_mem_dqinfo *info =
+			&dquot->dq_h->qh_info.u.v2_mdqi.dqi_qtree;
+
+	if (qtree_entry_unused(info, dp))
+		return 0;
+	return ext2fs_le32_to_cpu(d->dqb_id) == dquot->dq_id;
+}
+
+static struct qtree_fmt_operations v2r0_fmt_ops = {
+	.mem2disk_dqblk = v2r0_mem2diskdqblk,
+	.disk2mem_dqblk = v2r0_disk2memdqblk,
+	.is_id = v2r0_is_id,
+};
+
 /*
  * Copy dquot from disk to memory
  */
@@ -164,7 +226,8 @@ static int v2_check_file(struct quota_handle *h, int type, int fmt)
 		log_err("Your quota file is stored in wrong endianity");
 		return 0;
 	}
-	if (V2_VERSION != ext2fs_le32_to_cpu(dqh.dqh_version))
+	if (V2_VERSION_R0 != ext2fs_le32_to_cpu(dqh.dqh_version) &&
+	    V2_VERSION_R1 != ext2fs_le32_to_cpu(dqh.dqh_version))
 		return 0;
 	return 1;
 }
@@ -174,13 +237,25 @@ static int v2_check_file(struct quota_handle *h, int type, int fmt)
  */
 static int v2_init_io(struct quota_handle *h)
 {
+	struct v2_disk_dqheader dqh;
 	struct v2_disk_dqinfo ddqinfo;
 	struct v2_mem_dqinfo *info;
 	__u64 filesize;
+	int version;
 
-	h->qh_info.u.v2_mdqi.dqi_qtree.dqi_entry_size =
-		sizeof(struct v2r1_disk_dqblk);
-	h->qh_info.u.v2_mdqi.dqi_qtree.dqi_ops = &v2r1_fmt_ops;
+	if (!v2_read_header(h, &dqh))
+		return -1;
+	version = ext2fs_le32_to_cpu(dqh.dqh_version);
+
+	if (version == V2_VERSION_R0) {
+		h->qh_info.u.v2_mdqi.dqi_qtree.dqi_entry_size =
+			sizeof(struct v2r0_disk_dqblk);
+		h->qh_info.u.v2_mdqi.dqi_qtree.dqi_ops = &v2r0_fmt_ops;
+	} else {
+		h->qh_info.u.v2_mdqi.dqi_qtree.dqi_entry_size =
+			sizeof(struct v2r1_disk_dqblk);
+		h->qh_info.u.v2_mdqi.dqi_qtree.dqi_ops = &v2r1_fmt_ops;
+	}
 
 	/* Read information about quotafile */
 	if (h->e2fs_read(&h->qh_qf, V2_DQINFOOFF, &ddqinfo,
@@ -231,7 +306,7 @@ static int v2_new_io(struct quota_handle *h)
 
 	/* Write basic quota header */
 	ddqheader.dqh_magic = ext2fs_cpu_to_le32(file_magics[h->qh_type]);
-	ddqheader.dqh_version = ext2fs_cpu_to_le32(V2_VERSION);
+	ddqheader.dqh_version = ext2fs_cpu_to_le32(V2_VERSION_R1);
 	if (h->e2fs_write(&h->qh_qf, 0, &ddqheader, sizeof(ddqheader)) !=
 			sizeof(ddqheader))
 		return -1;
diff --git a/lib/support/quotaio_v2.h b/lib/support/quotaio_v2.h
index de2db2785cb0..35054cafaa23 100644
--- a/lib/support/quotaio_v2.h
+++ b/lib/support/quotaio_v2.h
@@ -13,7 +13,8 @@
 /* Offset of info header in file */
 #define V2_DQINFOOFF		sizeof(struct v2_disk_dqheader)
 /* Supported version of quota-tree format */
-#define V2_VERSION 1
+#define V2_VERSION_R1 1
+#define V2_VERSION_R0 0
 
 struct v2_disk_dqheader {
 	__le32 dqh_magic;	/* Magic number identifying file */
@@ -36,6 +37,20 @@ struct v2_disk_dqinfo {
 					 * free entry */
 } __attribute__ ((packed));
 
+struct v2r0_disk_dqblk {
+	__le32 dqb_id;	/* id this quota applies to */
+	__le32 dqb_ihardlimit;	/* absolute limit on allocated inodes */
+	__le32 dqb_isoftlimit;	/* preferred inode limit */
+	__le32 dqb_curinodes;	/* current # allocated inodes */
+	__le32 dqb_bhardlimit;	/* absolute limit on disk space
+					 * (in QUOTABLOCK_SIZE) */
+	__le32 dqb_bsoftlimit;	/* preferred limit on disk space
+					 * (in QUOTABLOCK_SIZE) */
+	__le64 dqb_curspace;	/* current space occupied (in bytes) */
+	__le64 dqb_btime;	/* time limit for excessive disk use */
+	__le64 dqb_itime;	/* time limit for excessive inode use */
+} __attribute__ ((packed));
+
 struct v2r1_disk_dqblk {
 	__le32 dqb_id;	/* id this quota applies to */
 	__le32 dqb_pad;
-- 
2.26.2

