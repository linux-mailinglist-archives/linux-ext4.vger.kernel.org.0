Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CAF129ED9
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLXIO7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:14:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41499 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfLXIO7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so10059228pgk.8
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vT/H2GT+4+mIdFL7QfSAdePsv3MvpFz/apSOv7h5sJk=;
        b=T4ZU7v6QEt1i4rgwtWvOpaVw2cOxT73BkNgRBOCOFYEPejT6709qA1qm6h/4bjFaWM
         lem0X0dV6KIslhJgd0/Wk/qqBt5Tuni3phTWy2MhxoV3yQBHAMYwM36AqqbY9+7LbCIB
         f0a1ukg3PTkbuLGA0bdf1EAl7yX6iZg3veW5FxVKMzFaSWnLTNKTMXiaDPR0qgXj0zEe
         AQ0Vg3bQEYKddgmEHj9sZzZKEs4VvX1L3p2+yc3O+rnL5tTGcZ/ZcQscX15X5R5oGYgX
         SaHpHp2gEOS+AeIgMLX4HfPXuzl4x+m01WMkmEfPGlQ0nvOiKeBlGndNgKf+lWbr6+w/
         sFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vT/H2GT+4+mIdFL7QfSAdePsv3MvpFz/apSOv7h5sJk=;
        b=QsYu5E8TaFiLfRmXLOTVL/8+fy6z/2lFAyQSxIrLERaFXgZ32Br01uVL+m2aUJ4Nf7
         +lpC5gohrXc0NsERyhJEXn/gvfgUIFlbz8qIYHYQ1R64nixTkfkDxQheeEj5nvKJAfGW
         xbfj1pa/DhDcpXdiToNOQetpjL1/mIk8OOiwas0cE0sfltgKTyFf23QAL1NGQGpf0l/V
         qUl41miXYtmUczOGvalSdTTQiX8iyLJ+tduEjqolvAje0vw1ZzK6ZaFZFYDpkpEKDVTn
         8h2dYxYh6e9esDZDjDauZQNv5cLOaOUlZb4q+FXjqCdJYFD2aT+3tK9Ykz2jDFNbA46R
         /Bsg==
X-Gm-Message-State: APjAAAVQbHJlyJa+l8IvtG8M33uf5Uv/UDrZCjrTjy0DAFPGWKRVmx/e
        EPXP6JJUyh4s3nPD2h2srDlo61GT
X-Google-Smtp-Source: APXvYqxQJPsBBgvAG+jxI6nSiHzY3kX156SvHhiZwIPLJ1mUtWhkNqFWRT/iYNJFo31Bm2tJNb3FQQ==
X-Received: by 2002:a63:ff5c:: with SMTP id s28mr35295976pgk.196.1577175297720;
        Tue, 24 Dec 2019 00:14:57 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:57 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 12/20] ext4: add fast commit on-disk format structs and helpers
Date:   Tue, 24 Dec 2019 00:13:16 -0800
Message-Id: <20191224081324.95807-12-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add structs representing on-disk format of the commit header and
tlvs in the commit header. Also, add helpers to arrange data
in on-disk fast commit format.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4_jbd2.c | 163 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h |  45 ++++++++++++
 2 files changed, 208 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 9e060ba927c1..9e34aa560ea1 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -4,6 +4,7 @@
  */
 
 #include "ext4_jbd2.h"
+#include "ext4_extents.h"
 
 #include <trace/events/ext4.h>
 
@@ -604,6 +605,168 @@ void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
 	trace_ext4_fc_track_range(inode, start, end, ret);
 }
 
+
+/*
+ * Adds tag, length and value at memory pointed to by dst. Returns
+ * true if tlv was added. Returns false if there's not enough space.
+ * If successful also updates *dst to point to the end of this tlv.
+ */
+static bool fc_try_add_tlv(u8 **dst, u8 *end, u16 tag, u16 len, u8 *val)
+{
+	struct ext4_fc_tl tl;
+
+	if (*dst + sizeof(tl) + len >= end)
+		return false;
+
+	tl.fc_tag = cpu_to_le16(tag);
+	tl.fc_len = cpu_to_le16(len);
+	memcpy(*dst, &tl, sizeof(tl));
+	memcpy(*dst + sizeof(tl), val, len);
+
+	*dst = *dst + sizeof(tl) + len;
+	return true;
+}
+
+/* Same as above, but tries to add dentry tlv. */
+static bool fc_try_add_dentry_info_tlv(u8 **dst, u8 *end, u16 tag,
+				       int parent_ino, int ino, int dlen,
+				       const unsigned char *dname)
+{
+	struct ext4_fc_dentry_info fcd;
+	struct ext4_fc_tl tl;
+
+
+	if (*dst + sizeof(tl) + sizeof(fcd) + dlen >= end)
+		return false;
+
+	fcd.fc_parent_ino = cpu_to_le32(parent_ino);
+	fcd.fc_ino = cpu_to_le32(ino);
+	tl.fc_tag = cpu_to_le16(tag);
+	tl.fc_len = cpu_to_le16(sizeof(fcd) + dlen);
+	memcpy(*dst, &tl, sizeof(tl));
+	*dst += sizeof(tl);
+	memcpy(*dst, &fcd, sizeof(fcd));
+	*dst += sizeof(fcd);
+	memcpy(*dst, dname, dlen);
+	*dst += dlen;
+
+	return true;
+}
+
+/* Get length of a particular tlv */
+static int fc_tag_len(struct ext4_fc_tl *tl)
+{
+	return le16_to_cpu(tl->fc_len);
+}
+
+/* Get a pointer to "value" of a tlv */
+static u8 *fc_tag_val(struct ext4_fc_tl *tl)
+{
+	return (u8 *)tl + sizeof(*tl);
+}
+
+/*
+ * Writes fast commit header and inode structure at memory
+ * pointed to by start. Returns 0 on success, error on failure.
+ * If successful, *last is upadated to point to the end of
+ * inode that was copied.
+ */
+static int fc_write_hdr(struct inode *inode, u8 *start, u8 *end,
+			u8 **last)
+{
+	struct ext4_fc_commit_hdr *fc_hdr = (struct ext4_fc_commit_hdr *)start;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	int inode_len = EXT4_GOOD_OLD_INODE_SIZE;
+	struct ext4_iloc iloc;
+	u8 *cur = start;
+	int ret;
+
+	if (ext4_is_inode_fc_ineligible(inode))
+		return -ECANCELED;
+
+	ret = ext4_get_inode_loc(inode, &iloc);
+	if (ret)
+		return ret;
+
+	fc_hdr->fc_magic = cpu_to_le32(EXT4_FC_MAGIC);
+	fc_hdr->fc_ino = cpu_to_le32(inode->i_ino);
+	fc_hdr->fc_features = 0;
+	fc_hdr->fc_csum = 0;
+
+	cur = (u8 *)(fc_hdr + 1);
+	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE)
+		inode_len += ei->i_extra_isize;
+	if (cur + inode_len >= end)
+		return -ECANCELED;
+
+	memcpy(cur, ext4_raw_inode(&iloc), inode_len);
+	cur += inode_len;
+	*last = cur;
+
+	return 0;
+}
+
+/*
+ * Writes data tags (EXT4_FC_TAG_ADD_RANGE / EXT4_FC_TAG_DEL_RANGE)
+ * at memory pointed to by start. Returns number of TLVs that were
+ * added if successfully. Returns errors otherwise.
+ */
+static int fc_write_data(struct inode *inode, u8 *start, u8 *end,
+			 u8 **last)
+{
+	ext4_lblk_t old_blk_size, cur_lblk_off, new_blk_size;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_map_blocks map;
+	struct ext4_extent extent;
+	struct ext4_fc_lrange lrange;
+	u8 *cur = start;
+	int num_tlvs = 0;
+	int ret;
+
+	write_lock(&ei->i_fc_lock);
+	old_blk_size = ei->i_fc_lblk_start;
+	new_blk_size = ei->i_fc_lblk_end;
+	ei->i_fc_lblk_start = ei->i_fc_lblk_end;
+	write_unlock(&ei->i_fc_lock);
+
+	cur_lblk_off = old_blk_size;
+	jbd_debug(1, "%s: will try writing %ld to %ld for inode %ld\n",
+		  __func__, cur_lblk_off, new_blk_size, inode->i_ino);
+	while (cur_lblk_off <= new_blk_size) {
+		map.m_lblk = cur_lblk_off;
+		map.m_len = new_blk_size - cur_lblk_off + 1;
+		ret = ext4_map_blocks(NULL, inode, &map, 0);
+		if (ret < 0)
+			return ret;
+		if (map.m_len == 0)
+			return -ECANCELED;
+		if (map.m_flags & EXT4_MAP_UNWRITTEN)
+			return -ECANCELED;
+
+		cur_lblk_off += map.m_len;
+		if (ret == 0) {
+			lrange.fc_lblk = cpu_to_le32(map.m_lblk);
+			lrange.fc_len = cpu_to_le32(map.m_len);
+			if (!fc_try_add_tlv(&cur, end, EXT4_FC_TAG_DEL_RANGE,
+				sizeof(lrange), (u8 *)&lrange))
+				return -ENOSPC;
+
+		} else {
+			extent.ee_block = cpu_to_le32(map.m_lblk);
+			extent.ee_len = cpu_to_le16(map.m_len);
+			ext4_ext_store_pblock(&extent, map.m_pblk);
+			ext4_ext_mark_initialized(&extent);
+			if (!fc_try_add_tlv(&cur, end, EXT4_FC_TAG_ADD_RANGE,
+				sizeof(struct ext4_extent), (u8 *)&extent))
+				return -ENOSPC;
+		}
+		num_tlvs++;
+	}
+	*last = cur;
+
+	return num_tlvs;
+}
+
 void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
 {
 	if (!ext4_should_fast_commit(sb))
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 60f484377c2e..d3a951d2e58d 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -470,7 +470,52 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 	return 1;
 }
 
+/* Ext4 fast commit related info */
+
+/* Magic of fast commit header */
+#define EXT4_FC_MAGIC			0xE2540090
+
 #define EXT4_NUM_FC_BLKS		128
+
+struct ext4_fc_commit_hdr {
+	/* Fast commit magic, should be EXT4_FC_MAGIC */
+	__le32 fc_magic;
+	/* Features used by this fast commit block */
+	__u8 fc_features;
+	/* Number of TLVs in this fast commmit block */
+	__le16 fc_num_tlvs;
+	/* Inode number */
+	__le32 fc_ino;
+	/* Csum(hdr+contents) */
+	__le32 fc_csum;
+};
+
+/* Fast commit on disk tag length structure */
+struct ext4_fc_tl {
+	__le16 fc_tag;
+	__le16 fc_len;
+};
+
+/* On disk fast commit tlv value structure for dirent tags:
+ *  - EXT4_FC_TAG_CREATE_DENTRY
+ *  - EXT4_FC_TAG_ADD_DENTRY
+ *  - EXT4_FC_TAG_DEL_DENTRY
+ */
+struct ext4_fc_dentry_info {
+	__le32 fc_parent_ino;
+	__le32 fc_ino;
+	u8 fc_dname[0];
+};
+
+/*
+ * On disk fast commit tlv value structure for tag
+ * EXT4_FC_TAG_HOLE.
+ */
+struct ext4_fc_lrange {
+	__le32 fc_lblk;
+	__le32 fc_len;
+};
+
 void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
 void ext4_init_inode_fc_info(struct inode *inode);
 void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
-- 
2.24.1.735.g03f4e72817-goog

