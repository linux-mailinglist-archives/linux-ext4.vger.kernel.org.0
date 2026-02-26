Return-Path: <linux-ext4+bounces-14037-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACsLOMweoGmzfgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14037-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:22:04 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD751A42C8
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6592310109D
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1793A1E6C;
	Thu, 26 Feb 2026 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="aSqJaR3T"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29F2F7478;
	Thu, 26 Feb 2026 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101101; cv=pass; b=MXCU6QVeJp9epjAz83KC72lXviRK7PNDXh12iocgf5c/QMaElPaDcgpI7TgSC8QpDrbhv+02YtDZYVzNYre01Wu+1UY/DVj/SWXCaUNg6my3Eg2ZoIs9UFR5xbuh0MgrNhkG7p9/w77ihBnYwdca/MXtgEYGDn74qAzdcObVo60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101101; c=relaxed/simple;
	bh=Tpdnlt6D+PmOM1x/D2Ik/xsWYfMB+lrYAnLHNiRCDUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7bXzHdyUwORTlDIn2RXzORR2MQ/zCwewaBZLua8yYe6fJpNGp1h0e5cFsNfbOwOq8069q9cH8f3JqvEGstxg+fdqsu4pHnHGtv+arzEzzGwO7zgOhUIKf6HbJ33PYRRNH4ligFz0IboCxW7y7n+mnawafwBG94dNix/ki2cRjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=aSqJaR3T; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1772101087; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ts2Sv0y3YzHfk5iSTn87oBLnz3RRq30f8WqvFBWdAB9UD/05U28jVHJ90WKkVd0B4VqzGxJwds9nTxWXSBcs0us2uk5+Bpt3nTDyYPkZ/5uhMZer+4KIpwEKJoq0Pbv7Jr17Y40HD1f+FrA0z/mroXQG+bOVKfKdGfN+SKhZxIg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772101087; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zTPVi78IQtJM26qrgfteYcHS2lMMhOxy0IYfQx5hbYQ=; 
	b=ZJ62HPUWWkUTxCZzHAinp9hYcPMMntgT5O0to9XqbBicBa9qoebD8pN9KXIDgj2R+XQyzv4KU3LilITV0DY9bZwmfMQYlwdKMEHByDk83eD9Nv0VHC4BdEhQ+lbG+/HX+0vFnAldUEJXmHzc9mvFXivrq7q+H06goDCWlm8R7II=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772101087;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zTPVi78IQtJM26qrgfteYcHS2lMMhOxy0IYfQx5hbYQ=;
	b=aSqJaR3TvhUXd5I1Je2WpZYLbNcTxeM85QW4Ewgf/dG9audABDkVzPnf0Fq6XxjU
	XblCPc7rFbGJFyhKTzhySHwrrEmPuaFdcMVMUBA9SHWEk//kuNdrH+ANy1yAT338ZA2
	AaL6kGBqasgekya2XpqIXcLJ67Q59tg49q6l1Tc8=
Received: by mx.zohomail.com with SMTPS id 1772101084249909.7428168439543;
	Thu, 26 Feb 2026 02:18:04 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: linux-ext4@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org
Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	Li Chen <me@linux.beauty>
Subject: [RFC PATCH 3/4] ext4: fast_commit: write TLVs into DAX ByteLog
Date: Thu, 26 Feb 2026 18:17:31 +0800
Message-ID: <20260226101736.2271952-4-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226101736.2271952-1-me@linux.beauty>
References: <20260226101736.2271952-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.beauty];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14037-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.beauty:mid,linux.beauty:dkim,linux.beauty:email]
X-Rspamd-Queue-Id: 5AD751A42C8
X-Rspamd-Action: no action

When dax_fc_bytelog is enabled, write fast commit TLVs directly into the
DAX-mapped ByteLog ring.
Keep traditional TLV writes confined to the reserved FC block and emit an
anchor TLV to describe the ByteLog window.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/fast_commit.c         | 124 +++++++++++++++++++++++++++++++++-
 fs/ext4/fast_commit.h         |  13 ++++
 fs/ext4/fast_commit_bytelog.c |  20 ++++++
 fs/ext4/fast_commit_bytelog.h |   5 ++
 4 files changed, 159 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 64c0c4ba58b0..2f7b7ea29df2 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -723,6 +723,12 @@ static u8 *ext4_fc_reserve_space(struct super_block *sb, int len, u32 *crc)
 	 * leaving enough space for a PAD tlv.
 	 */
 	remaining = bsize - EXT4_FC_TAG_BASE_LEN - off;
+	if (ext4_fc_bytelog_active(sbi) && len > remaining) {
+		ext4_fc_mark_ineligible(sb,
+					EXT4_FC_REASON_BYTELOG_TLV_OVERFLOW,
+					NULL);
+		return NULL;
+	}
 	if (len <= remaining) {
 		sbi->s_fc_bytes += len;
 		return dst;
@@ -806,6 +812,31 @@ static bool ext4_fc_add_tlv(struct super_block *sb, u16 tag, u16 len, u8 *val,
 	struct ext4_fc_tl tl;
 	u8 *dst;
 
+	if (ext4_fc_bytelog_active(EXT4_SB(sb)) &&
+	    (tag == EXT4_FC_TAG_ADD_RANGE || tag == EXT4_FC_TAG_DEL_RANGE ||
+	     tag == EXT4_FC_TAG_LINK || tag == EXT4_FC_TAG_UNLINK ||
+	     tag == EXT4_FC_TAG_CREAT || tag == EXT4_FC_TAG_INODE)) {
+		struct ext4_fc_bytelog_vec vecs[2];
+		int ret;
+
+		tl.fc_tag = cpu_to_le16(tag);
+		tl.fc_len = cpu_to_le16(len);
+		vecs[0].base = &tl;
+		vecs[0].len = sizeof(tl);
+		vecs[1].base = val;
+		vecs[1].len = len;
+
+		ret = ext4_fc_bytelog_append_vec(sb, tag, vecs,
+						 ARRAY_SIZE(vecs));
+		if (!ret)
+			return true;
+		if (ret == -ENOSPC)
+			ext4_fc_mark_ineligible(sb,
+						EXT4_FC_REASON_BYTELOG_TLV_OVERFLOW,
+						NULL);
+		return false;
+	}
+
 	dst = ext4_fc_reserve_space(sb, EXT4_FC_TAG_BASE_LEN + len, crc);
 	if (!dst)
 		return false;
@@ -819,6 +850,17 @@ static bool ext4_fc_add_tlv(struct super_block *sb, u16 tag, u16 len, u8 *val,
 	return true;
 }
 
+static bool ext4_fc_add_bytelog_anchor_tlv(struct super_block *sb,
+					   struct ext4_fc_bytelog_anchor *anchor,
+					   u32 *crc)
+{
+	struct ext4_fc_bytelog_entry entry;
+
+	ext4_fc_bytelog_anchor_to_disk(&entry, anchor);
+	return ext4_fc_add_tlv(sb, EXT4_FC_TAG_DAX_BYTELOG_ANCHOR,
+			       sizeof(entry), (u8 *)&entry, crc);
+}
+
 /* Same as above, but adds dentry tlv. */
 static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
 				   struct ext4_fc_dentry_update *fc_dentry)
@@ -826,9 +868,40 @@ static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
 	struct ext4_fc_dentry_info fcd;
 	struct ext4_fc_tl tl;
 	int dlen = fc_dentry->fcd_name.name.len;
-	u8 *dst = ext4_fc_reserve_space(sb,
-			EXT4_FC_TAG_BASE_LEN + sizeof(fcd) + dlen, crc);
+	u8 *dst;
+
+	if (ext4_fc_bytelog_active(EXT4_SB(sb)) &&
+	    (fc_dentry->fcd_op == EXT4_FC_TAG_LINK ||
+	     fc_dentry->fcd_op == EXT4_FC_TAG_UNLINK ||
+	     fc_dentry->fcd_op == EXT4_FC_TAG_CREAT)) {
+		struct ext4_fc_bytelog_vec vecs[3];
+		int ret;
+
+		fcd.fc_parent_ino = cpu_to_le32(fc_dentry->fcd_parent);
+		fcd.fc_ino = cpu_to_le32(fc_dentry->fcd_ino);
+		tl.fc_tag = cpu_to_le16(fc_dentry->fcd_op);
+		tl.fc_len = cpu_to_le16(sizeof(fcd) + dlen);
+
+		vecs[0].base = &tl;
+		vecs[0].len = sizeof(tl);
+		vecs[1].base = &fcd;
+		vecs[1].len = sizeof(fcd);
+		vecs[2].base = fc_dentry->fcd_name.name.name;
+		vecs[2].len = dlen;
+
+		ret = ext4_fc_bytelog_append_vec(sb, fc_dentry->fcd_op, vecs,
+						 ARRAY_SIZE(vecs));
+		if (!ret)
+			return true;
+		if (ret == -ENOSPC)
+			ext4_fc_mark_ineligible(sb,
+						EXT4_FC_REASON_BYTELOG_TLV_OVERFLOW,
+						NULL);
+		return false;
+	}
 
+	dst = ext4_fc_reserve_space(sb, EXT4_FC_TAG_BASE_LEN + sizeof(fcd) +
+				    dlen, crc);
 	if (!dst)
 		return false;
 
@@ -872,6 +945,25 @@ static int ext4_fc_write_inode(struct inode *inode, u32 *crc)
 	tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_INODE);
 	tl.fc_len = cpu_to_le16(inode_len + sizeof(fc_inode.fc_ino));
 
+	if (ext4_fc_bytelog_active(EXT4_SB(inode->i_sb))) {
+		struct ext4_fc_bytelog_vec vecs[3];
+
+		vecs[0].base = &tl;
+		vecs[0].len = sizeof(tl);
+		vecs[1].base = &fc_inode.fc_ino;
+		vecs[1].len = sizeof(fc_inode.fc_ino);
+		vecs[2].base = ext4_raw_inode(&iloc);
+		vecs[2].len = inode_len;
+
+		ret = ext4_fc_bytelog_append_vec(inode->i_sb, EXT4_FC_TAG_INODE,
+						 vecs, ARRAY_SIZE(vecs));
+		if (ret == -ENOSPC)
+			ext4_fc_mark_ineligible(inode->i_sb,
+						EXT4_FC_REASON_BYTELOG_TLV_OVERFLOW,
+						NULL);
+		goto err;
+	}
+
 	ret = -ECANCELED;
 	dst = ext4_fc_reserve_space(inode->i_sb,
 		EXT4_FC_TAG_BASE_LEN + inode_len + sizeof(fc_inode.fc_ino), crc);
@@ -1147,6 +1239,8 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	}
 
 	/* Step 6.2: Now write all the dentry updates. */
+	if (ext4_fc_bytelog_active(sbi))
+		ext4_fc_bytelog_begin_commit(sb);
 	ret = ext4_fc_commit_dentry_updates(journal, &crc);
 	if (ret)
 		goto out;
@@ -1164,6 +1258,22 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		if (ret)
 			goto out;
 	}
+
+	if (ext4_fc_bytelog_active(sbi)) {
+		struct ext4_fc_bytelog_anchor anchor;
+
+		ret = ext4_fc_bytelog_end_commit(sb);
+		if (ret)
+			goto out;
+		if (sbi->s_fc_bytelog.seq) {
+			ext4_fc_bytelog_build_anchor(sb, &anchor,
+						     sbi->s_journal->j_running_transaction->t_tid);
+			if (!ext4_fc_add_bytelog_anchor_tlv(sb, &anchor, &crc)) {
+				ret = -ENOSPC;
+				goto out;
+			}
+		}
+	}
 	/* Step 6.4: Finally write tail tag to conclude this fast commit. */
 	ret = ext4_fc_write_tail(sb, crc);
 
@@ -1262,6 +1372,12 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	else
 		journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
 	set_task_ioprio(current, journal_ioprio);
+
+	if (ext4_fc_bytelog_active(sbi)) {
+		journal->j_fc_off = 0;
+		sbi->s_fc_bytes = 0;
+	}
+
 	fc_bufs_before = (sbi->s_fc_bytes + bsize - 1) / bsize;
 	ret = ext4_fc_perform_commit(journal);
 	if (ret < 0) {
@@ -1367,8 +1483,9 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 		ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	}
 
-	if (full)
+	if (full || ext4_fc_bytelog_active(sbi))
 		sbi->s_fc_bytes = 0;
+	ext4_fc_bytelog_reset(sb, full);
 	ext4_fc_unlock(sb, alloc_ctx);
 	trace_ext4_fc_stats(sb);
 }
@@ -2315,6 +2432,7 @@ static const char * const fc_ineligible_reasons[] = {
 	[EXT4_FC_REASON_FALLOC_RANGE] = "Falloc range op",
 	[EXT4_FC_REASON_INODE_JOURNAL_DATA] = "Data journalling",
 	[EXT4_FC_REASON_ENCRYPTED_FILENAME] = "Encrypted filename",
+	[EXT4_FC_REASON_BYTELOG_TLV_OVERFLOW] = "ByteLog TLV overflow",
 	[EXT4_FC_REASON_MIGRATE] = "Inode format migration",
 	[EXT4_FC_REASON_VERITY] = "fs-verity enable",
 	[EXT4_FC_REASON_MOVE_EXT] = "Move extents",
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 2f77a37fb101..fb51e19b9778 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -18,6 +18,7 @@
 #define EXT4_FC_TAG_PAD			0x0007
 #define EXT4_FC_TAG_TAIL		0x0008
 #define EXT4_FC_TAG_HEAD		0x0009
+#define EXT4_FC_TAG_DAX_BYTELOG_ANCHOR	0x000a
 
 #define EXT4_FC_SUPPORTED_FEATURES	0x0
 
@@ -70,6 +71,15 @@ struct ext4_fc_tail {
 	__le32 fc_crc;
 };
 
+/* Value structure for tag EXT4_FC_TAG_DAX_BYTELOG_ANCHOR. */
+struct ext4_fc_bytelog_entry {
+	__le32 fc_tid;
+	__le64 fc_head;
+	__le64 fc_tail;
+	__le64 fc_seq;
+	__le32 fc_crc;
+};
+
 /* Tag base length */
 #define EXT4_FC_TAG_BASE_LEN (sizeof(struct ext4_fc_tl))
 
@@ -97,6 +107,7 @@ enum {
 	EXT4_FC_REASON_FALLOC_RANGE,
 	EXT4_FC_REASON_INODE_JOURNAL_DATA,
 	EXT4_FC_REASON_ENCRYPTED_FILENAME,
+	EXT4_FC_REASON_BYTELOG_TLV_OVERFLOW,
 	EXT4_FC_REASON_MIGRATE,
 	EXT4_FC_REASON_VERITY,
 	EXT4_FC_REASON_MOVE_EXT,
@@ -181,6 +192,8 @@ static inline const char *tag2str(__u16 tag)
 		return "TAIL";
 	case EXT4_FC_TAG_HEAD:
 		return "HEAD";
+	case EXT4_FC_TAG_DAX_BYTELOG_ANCHOR:
+		return "BYTELOG_ANCHOR";
 	default:
 		return "ERROR";
 	}
diff --git a/fs/ext4/fast_commit_bytelog.c b/fs/ext4/fast_commit_bytelog.c
index 64ba3edddbcb..77ac1d9ef031 100644
--- a/fs/ext4/fast_commit_bytelog.c
+++ b/fs/ext4/fast_commit_bytelog.c
@@ -455,6 +455,26 @@ void ext4_fc_bytelog_release(struct super_block *sb)
 	memset(&sbi->s_fc_bytelog, 0, sizeof(sbi->s_fc_bytelog));
 }
 
+void ext4_fc_bytelog_anchor_to_disk(struct ext4_fc_bytelog_entry *dst,
+				    const struct ext4_fc_bytelog_anchor *src)
+{
+	dst->fc_tid = cpu_to_le32(src->tid);
+	dst->fc_head = cpu_to_le64(src->head);
+	dst->fc_tail = cpu_to_le64(src->tail);
+	dst->fc_seq = cpu_to_le64(src->seq);
+	dst->fc_crc = cpu_to_le32(src->crc);
+}
+
+void ext4_fc_bytelog_anchor_from_disk(struct ext4_fc_bytelog_anchor *dst,
+				      const struct ext4_fc_bytelog_entry *src)
+{
+	dst->tid = le32_to_cpu(src->fc_tid);
+	dst->head = le64_to_cpu(src->fc_head);
+	dst->tail = le64_to_cpu(src->fc_tail);
+	dst->seq = le64_to_cpu(src->fc_seq);
+	dst->crc = le32_to_cpu(src->fc_crc);
+}
+
 void ext4_fc_bytelog_reset(struct super_block *sb, bool full)
 {
 	struct ext4_fc_bytelog *log = &EXT4_SB(sb)->s_fc_bytelog;
diff --git a/fs/ext4/fast_commit_bytelog.h b/fs/ext4/fast_commit_bytelog.h
index d52754890222..d3e5b734a02e 100644
--- a/fs/ext4/fast_commit_bytelog.h
+++ b/fs/ext4/fast_commit_bytelog.h
@@ -9,6 +9,7 @@
 struct super_block;
 struct journal_s;
 struct ext4_sb_info;
+struct ext4_fc_bytelog_entry;
 
 #define EXT4_FC_BYTELOG_MAGIC			0x4c424346 /* "FCBL" */
 #define EXT4_FC_BYTELOG_VERSION			1
@@ -109,6 +110,10 @@ int ext4_fc_bytelog_append_vec(struct super_block *sb, u16 tag,
 void ext4_fc_bytelog_build_anchor(struct super_block *sb,
 				  struct ext4_fc_bytelog_anchor *anchor,
 				  u32 tid);
+void ext4_fc_bytelog_anchor_to_disk(struct ext4_fc_bytelog_entry *dst,
+				    const struct ext4_fc_bytelog_anchor *src);
+void ext4_fc_bytelog_anchor_from_disk(struct ext4_fc_bytelog_anchor *dst,
+				      const struct ext4_fc_bytelog_entry *src);
 
 static inline bool ext4_fc_bytelog_record_committed(const struct ext4_fc_bytelog_hdr *hdr)
 {
-- 
2.52.0


