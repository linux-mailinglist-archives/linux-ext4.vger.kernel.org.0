Return-Path: <linux-ext4+bounces-14035-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMXdF08eoGmzfgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14035-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:19:59 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFD71A4275
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5BD230AE0AF
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567463A4F26;
	Thu, 26 Feb 2026 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="n+kFwvFs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2BD2C17A0;
	Thu, 26 Feb 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101087; cv=pass; b=SswM+x0aFY3dMPdYzAj0T/MfI34Ty5Smje8UQ+UAK+EsOgCMcRdFwgaPcboV8qlcaKU/ij7o93HkQOZWPScfWv0WrpRLjqWDKjKVTRui2dIgMeRSaOIwsgq6/aRCwCCis10XIE/xYVAx60bIWwJ2pETYsPQKYmWN401TjZZvgHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101087; c=relaxed/simple;
	bh=UEQmXGAxIvlp56ExLyUU2lC9fus+XZbPdPdKRCzb06w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajXozlfhvunR9tS2WsPGvp3890jjJDAsWYmih/8jXnNn33zZDqb6D9y1RtRNgqe+7FBodfzhHlh1XkL/jGzveWSQ1SDFQi3geZcdkWlWBsItAdLrYdzrLLhZJfrdKlUUN+oiqPvD+2UyVPQnyYXg2edG8Jwowioa1t1sWLV+zQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=n+kFwvFs; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1772101078; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PMaWo+xgy6qXLJlx0oy4W3aouq7PuEac9nAzy/tFAFz/V8OMwZCVohnPzzB0aaoHlpSDeswDQs27mcyLAutyWMF4PU8bTQC5UBYOUJhhR/JiyrYwZu0YPu4feuFC2VmjWNho4JOhvwpmtYXAF/na7ZeHQKELqIHQCzhW21OQsSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772101078; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XA/KQLnF9AaqoWm40JxaGmtWbCeOCAlyOUa1aSgza4w=; 
	b=dQ3oARwr3J4SAy2xNOojNGjJBmRfM48WEPG5VCy2x7pw1zJhdt0N+L5kcrPK4hHvOXEtak3m62lspnNNePz6vHutz8RxmR2bWcNNweNI6TzIR5aUMsNJJSohD+DTlEkGmaZmyQ9nFc/PFYaH5ufsQmLOLxIgim2OfLtC0fM0aRg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772101078;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XA/KQLnF9AaqoWm40JxaGmtWbCeOCAlyOUa1aSgza4w=;
	b=n+kFwvFsFinuex0jhx328QssJLo0BGzi7BUNkwfPARjx30J3h8G/j1xvjWFMFmXG
	enn6v64xqV+LMzuB7Ap1Hn/xUhyaqmgf2PT5su62BuV3VQXyAgnjOxkHGQ7BvDTepnb
	CNIfo6HCe622gS1aFzMvFVD/UCmgYH6KkhhIjB3I=
Received: by mx.zohomail.com with SMTPS id 1772101076978703.0884008912927;
	Thu, 26 Feb 2026 02:17:56 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: linux-ext4@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org
Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	Li Chen <me@linux.beauty>
Subject: [RFC PATCH 1/4] ext4: introduce DAX fast commit ByteLog backend
Date: Thu, 26 Feb 2026 18:17:29 +0800
Message-ID: <20260226101736.2271952-2-me@linux.beauty>
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
	TAGGED_FROM(0.00)[bounces-14035-lists,linux-ext4=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.beauty:mid,linux.beauty:dkim,linux.beauty:email]
X-Rspamd-Queue-Id: BBFD71A4275
X-Rspamd-Action: no action

Add a ByteLog backend that can append fast commit records directly into a
DAX-mapped fast commit area, avoiding bufferhead based writes.
The backend provides a simple record format with CRC32C and helpers for
batching and persisting records.

Signed-off-by: Li Chen <me@linux.beauty>
---
 MAINTAINERS                   |   1 +
 fs/ext4/Makefile              |   2 +-
 fs/ext4/ext4.h                |   9 +-
 fs/ext4/fast_commit_bytelog.c | 780 ++++++++++++++++++++++++++++++++++
 fs/ext4/fast_commit_bytelog.h | 147 +++++++
 5 files changed, 937 insertions(+), 2 deletions(-)
 create mode 100644 fs/ext4/fast_commit_bytelog.c
 create mode 100644 fs/ext4/fast_commit_bytelog.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 71f76fddebbf..5a26b99aac63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9627,6 +9627,7 @@ Q:	http://patchwork.ozlabs.org/project/linux-ext4/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 F:	Documentation/filesystems/ext4/
 F:	fs/ext4/
+F:	fs/ext4/fast_commit_bytelog*
 F:	include/trace/events/ext4.h
 F:	include/uapi/linux/ext4.h
 
diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 72206a292676..3df51f100536 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -10,7 +10,7 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
 		indirect.o inline.o inode.o ioctl.o mballoc.o migrate.o \
 		mmp.o move_extent.o namei.o page-io.o readpage.o resize.o \
 		super.o symlink.o sysfs.o xattr.o xattr_hurd.o xattr_trusted.o \
-		xattr_user.o fast_commit.o orphan.o
+		xattr_user.o fast_commit.o fast_commit_bytelog.o orphan.o
 
 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 293f698b7042..1b0746bf4869 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -999,6 +999,7 @@ do {										\
 
 #include "extents_status.h"
 #include "fast_commit.h"
+#include "fast_commit_bytelog.h"
 
 /*
  * Lock subclasses for i_data_sem in the ext4_inode_info structure.
@@ -1282,6 +1283,8 @@ struct ext4_inode_info {
 						    * scanning in mballoc
 						    */
 #define EXT4_MOUNT2_ABORT		0x00000100 /* Abort filesystem */
+#define EXT4_MOUNT2_DAX_FC_BYTELOG	0x00000200 /* Use DAX ByteLog FC backend */
+#define EXT4_MOUNT2_DAX_FC_BYTELOG_FORCE 0x00000400 /* Ignore feature bit */
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
@@ -1797,6 +1800,7 @@ struct ext4_sb_info {
 	int s_fc_debug_max_replay;
 #endif
 	struct ext4_fc_replay_state s_fc_replay_state;
+	struct ext4_fc_bytelog s_fc_bytelog;
 };
 
 static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
@@ -2125,6 +2129,7 @@ static inline bool ext4_inode_orphan_tracked(struct inode *inode)
 #define EXT4_FEATURE_INCOMPAT_INLINE_DATA	0x8000 /* data in inode */
 #define EXT4_FEATURE_INCOMPAT_ENCRYPT		0x10000
 #define EXT4_FEATURE_INCOMPAT_CASEFOLD		0x20000
+#define EXT4_FEATURE_INCOMPAT_DAX_FC_BYTELOG	0x40000
 
 extern void ext4_update_dynamic_rev(struct super_block *sb);
 
@@ -2224,6 +2229,7 @@ EXT4_FEATURE_INCOMPAT_FUNCS(largedir,		LARGEDIR)
 EXT4_FEATURE_INCOMPAT_FUNCS(inline_data,	INLINE_DATA)
 EXT4_FEATURE_INCOMPAT_FUNCS(encrypt,		ENCRYPT)
 EXT4_FEATURE_INCOMPAT_FUNCS(casefold,		CASEFOLD)
+EXT4_FEATURE_INCOMPAT_FUNCS(dax_fc_bytelog,	DAX_FC_BYTELOG)
 
 #define EXT2_FEATURE_COMPAT_SUPP	EXT4_FEATURE_COMPAT_EXT_ATTR
 #define EXT2_FEATURE_INCOMPAT_SUPP	(EXT4_FEATURE_INCOMPAT_FILETYPE| \
@@ -2254,7 +2260,8 @@ EXT4_FEATURE_INCOMPAT_FUNCS(casefold,		CASEFOLD)
 					 EXT4_FEATURE_INCOMPAT_ENCRYPT | \
 					 EXT4_FEATURE_INCOMPAT_CASEFOLD | \
 					 EXT4_FEATURE_INCOMPAT_CSUM_SEED | \
-					 EXT4_FEATURE_INCOMPAT_LARGEDIR)
+					 EXT4_FEATURE_INCOMPAT_LARGEDIR | \
+					 EXT4_FEATURE_INCOMPAT_DAX_FC_BYTELOG)
 #define EXT4_FEATURE_RO_COMPAT_SUPP	(EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT4_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT4_FEATURE_RO_COMPAT_GDT_CSUM| \
diff --git a/fs/ext4/fast_commit_bytelog.c b/fs/ext4/fast_commit_bytelog.c
new file mode 100644
index 000000000000..64ba3edddbcb
--- /dev/null
+++ b/fs/ext4/fast_commit_bytelog.c
@@ -0,0 +1,780 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "ext4.h"
+#include "fast_commit_bytelog.h"
+
+#include <linux/crc32c.h>
+#include <linux/dax.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/libnvdimm.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include <asm/barrier.h>
+
+#define EXT4_FC_BYTELOG_META_BLOCKS	1
+
+static void ext4_fc_bytelog_reset_batch(struct ext4_fc_bytelog *log);
+static int ext4_fc_bytelog_flush_batch(struct super_block *sb, u32 tid);
+
+#define EXT4_FC_CRC32C_POLY	0x82f63b78
+#define EXT4_FC_CRC32C_SHIFT_BITS	(sizeof(size_t) * 8)
+
+static u32 ext4_fc_crc32c_shift_mats[EXT4_FC_CRC32C_SHIFT_BITS][32];
+static bool ext4_fc_crc32c_shift_mats_ready;
+
+static u32 ext4_fc_gf2_matrix_times(const u32 *mat, u32 vec)
+{
+	u32 sum = 0;
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		if (vec & 1)
+			sum ^= mat[i];
+		vec >>= 1;
+	}
+
+	return sum;
+}
+
+static void ext4_fc_gf2_matrix_square(u32 *square, const u32 *mat)
+{
+	int i;
+
+	for (i = 0; i < 32; i++)
+		square[i] = ext4_fc_gf2_matrix_times(mat, mat[i]);
+}
+
+static void ext4_fc_crc32c_shift_mats_init_once(void)
+{
+	static DEFINE_MUTEX(lock);
+	u32 even[32], odd[32], one_byte[32];
+	u32 row = 1;
+	int i;
+
+	if (READ_ONCE(ext4_fc_crc32c_shift_mats_ready))
+		return;
+
+	mutex_lock(&lock);
+	if (ext4_fc_crc32c_shift_mats_ready)
+		goto out;
+
+	/*
+	 * Build the GF(2) matrix operator for shifting by one byte of zeros,
+	 * then square it repeatedly to get powers of two.
+	 */
+	odd[0] = EXT4_FC_CRC32C_POLY;
+	for (i = 1; i < 32; i++) {
+		odd[i] = row;
+		row <<= 1;
+	}
+	ext4_fc_gf2_matrix_square(even, odd);	/* 2 zero bits */
+	ext4_fc_gf2_matrix_square(odd, even);	/* 4 zero bits */
+	ext4_fc_gf2_matrix_square(one_byte, odd); /* 8 zero bits */
+
+	memcpy(ext4_fc_crc32c_shift_mats[0], one_byte, sizeof(one_byte));
+	for (i = 1; i < EXT4_FC_CRC32C_SHIFT_BITS; i++)
+		ext4_fc_gf2_matrix_square(ext4_fc_crc32c_shift_mats[i],
+					  ext4_fc_crc32c_shift_mats[i - 1]);
+
+	WRITE_ONCE(ext4_fc_crc32c_shift_mats_ready, true);
+out:
+	mutex_unlock(&lock);
+}
+
+static u32 ext4_fc_crc32c_shift_zeros(u32 crc, size_t len)
+{
+	size_t shift = len;
+	int bit = 0;
+
+	while (shift) {
+		if (shift & 1)
+			crc = ext4_fc_gf2_matrix_times(ext4_fc_crc32c_shift_mats[bit], crc);
+		shift >>= 1;
+		bit++;
+	}
+
+	return crc;
+}
+
+u32 ext4_fc_bytelog_crc32(const void *buf, size_t len)
+{
+	return crc32c(~0, buf, len);
+}
+
+bool ext4_fc_bytelog_mapped(struct ext4_sb_info *sbi)
+{
+	return READ_ONCE(sbi->s_fc_bytelog.mapped);
+}
+
+bool ext4_fc_bytelog_active(struct ext4_sb_info *sbi)
+{
+	struct ext4_fc_bytelog *log = &sbi->s_fc_bytelog;
+
+	return log->mapped && log->enabled;
+}
+
+size_t ext4_fc_bytelog_record_size(size_t payload_len)
+{
+	size_t len = sizeof(struct ext4_fc_bytelog_hdr) + payload_len;
+
+	return ALIGN(len, EXT4_FC_BYTELOG_ALIGN);
+}
+
+void ext4_fc_bytelog_prep_hdr(struct ext4_fc_bytelog_hdr *hdr, u16 tag,
+			      u16 flags, u32 tid, u64 seq, u32 payload_len)
+{
+	memset(hdr, 0, sizeof(*hdr));
+
+	hdr->magic = cpu_to_le32(EXT4_FC_BYTELOG_MAGIC);
+	hdr->version = cpu_to_le16(EXT4_FC_BYTELOG_VERSION);
+	hdr->hdr_len = cpu_to_le16(sizeof(*hdr));
+	hdr->tid = cpu_to_le32(tid);
+	hdr->tag = cpu_to_le16(tag);
+	hdr->flags = cpu_to_le16(flags & ~EXT4_FC_BYTELOG_COMMITTED);
+	hdr->payload_len = cpu_to_le32(payload_len);
+	hdr->record_len = cpu_to_le32(ext4_fc_bytelog_record_size(payload_len));
+	hdr->seq = cpu_to_le64(seq);
+}
+
+void ext4_fc_bytelog_finalize_hdr_crc(struct ext4_fc_bytelog_hdr *hdr,
+				      u32 payload_crc)
+{
+	struct ext4_fc_bytelog_hdr tmp;
+	u32 crc;
+
+	hdr->payload_crc = cpu_to_le32(payload_crc);
+	hdr->header_crc = 0;
+
+	tmp = *hdr;
+	tmp.header_crc = 0;
+	crc = ext4_fc_bytelog_crc32(&tmp, sizeof(tmp));
+	hdr->header_crc = cpu_to_le32(crc);
+}
+
+static bool ext4_fc_bytelog_record_sane(const struct ext4_fc_bytelog_hdr *hdr,
+					size_t remaining)
+{
+	u32 record_len = le32_to_cpu(hdr->record_len);
+	u32 payload_len = le32_to_cpu(hdr->payload_len);
+	u16 hdr_len = le16_to_cpu(hdr->hdr_len);
+
+	if (le32_to_cpu(hdr->magic) != EXT4_FC_BYTELOG_MAGIC)
+		return false;
+	if (le16_to_cpu(hdr->version) != EXT4_FC_BYTELOG_VERSION)
+		return false;
+	if (hdr_len != sizeof(*hdr))
+		return false;
+	if (!record_len || record_len > remaining)
+		return false;
+	if (!IS_ALIGNED(record_len, EXT4_FC_BYTELOG_ALIGN))
+		return false;
+	if (record_len < hdr_len)
+		return false;
+	if (payload_len > record_len - hdr_len)
+		return false;
+
+	return true;
+}
+
+int ext4_fc_bytelog_validate_hdr(const struct ext4_fc_bytelog_hdr *hdr,
+				 size_t remaining, const void *payload)
+{
+	struct ext4_fc_bytelog_hdr tmp;
+	u32 payload_len = le32_to_cpu(hdr->payload_len);
+	u32 crc;
+
+	if (!ext4_fc_bytelog_record_sane(hdr, remaining))
+		return -EINVAL;
+
+	tmp = *hdr;
+	tmp.header_crc = 0;
+	crc = ext4_fc_bytelog_crc32(&tmp, sizeof(tmp));
+	if (crc != le32_to_cpu(hdr->header_crc))
+		return -EFSBADCRC;
+
+	if (!payload_len)
+		return 0;
+	if (!payload)
+		return -EINVAL;
+
+	crc = ext4_fc_bytelog_crc32(payload, payload_len);
+	if (crc != le32_to_cpu(hdr->payload_crc))
+		return -EFSBADCRC;
+
+	return 0;
+}
+
+void ext4_fc_bytelog_mark_committed(struct ext4_fc_bytelog_hdr *hdr)
+{
+	u16 flags = le16_to_cpu(hdr->flags);
+	struct ext4_fc_bytelog_hdr tmp;
+	u32 crc;
+
+	flags |= EXT4_FC_BYTELOG_COMMITTED;
+	hdr->flags = cpu_to_le16(flags);
+
+	tmp = *hdr;
+	tmp.header_crc = 0;
+	crc = ext4_fc_bytelog_crc32(&tmp, sizeof(tmp));
+	hdr->header_crc = cpu_to_le32(crc);
+}
+
+void ext4_fc_bytelog_flush_persist(void *addr, size_t len)
+{
+	u8 *p = addr;
+	size_t off = 0;
+
+	if (!len)
+		return;
+
+	/*
+	 * Large flushes can be very bursty. Chunk the flush so other tasks
+	 * can make progress between chunks.
+	 */
+	if (len <= 65536) {
+		arch_wb_cache_pmem(p, len);
+		return;
+	}
+
+	while (off < len) {
+		size_t n = min(len - off, (size_t)65536);
+
+		arch_wb_cache_pmem(p + off, n);
+		off += n;
+		cond_resched();
+	}
+}
+
+void ext4_fc_bytelog_persist_barrier(void)
+{
+	pmem_wmb();
+}
+
+static int ext4_fc_bytelog_map_ring(struct super_block *sb,
+				    journal_t *journal,
+				    struct ext4_fc_bytelog *log)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	unsigned long long first, anchor;
+	unsigned long fc_blocks;
+	unsigned long ring_blocks;
+	u64 start_bytes, ring_bytes, start_offset;
+	pgoff_t start_pgoff;
+	unsigned long ring_pages;
+	void *addr = NULL;
+	int ret;
+	int blkbits = sb->s_blocksize_bits;
+
+	if (!journal->j_inode)
+		return -EOPNOTSUPP;
+
+	if (journal->j_fc_last <= journal->j_fc_first + 1)
+		return -ENOSPC;
+
+	fc_blocks = journal->j_fc_last - journal->j_fc_first;
+	ring_blocks = fc_blocks - 1;
+	if (ring_blocks <= EXT4_FC_BYTELOG_META_BLOCKS)
+		return -ENOSPC;
+
+	ret = jbd2_journal_bmap(journal, journal->j_fc_first, &first);
+	if (ret)
+		return ret;
+
+	ret = jbd2_journal_bmap(journal, journal->j_fc_last - 1, &anchor);
+	if (ret)
+		return ret;
+
+	start_bytes = (u64)first << blkbits;
+	ring_bytes = (u64)ring_blocks << blkbits;
+	if (!ring_bytes)
+		return -ENOSPC;
+	if (ring_bytes & (PAGE_SIZE - 1))
+		return -EOPNOTSUPP;
+	if (start_bytes > U64_MAX - sbi->s_dax_part_off)
+		return -ERANGE;
+
+	start_offset = start_bytes + sbi->s_dax_part_off;
+	if (!IS_ALIGNED(start_offset, PAGE_SIZE))
+		return -EINVAL;
+
+	start_pgoff = start_offset >> PAGE_SHIFT;
+	ring_pages = ring_bytes >> PAGE_SHIFT;
+	if (!ring_pages || ring_pages > LONG_MAX)
+		return -E2BIG;
+
+#if IS_ENABLED(CONFIG_DAX)
+	{
+		long mapped;
+		int dax_id = dax_read_lock();
+
+		mapped = dax_direct_access(sbi->s_daxdev, start_pgoff,
+					   ring_pages, DAX_ACCESS, &addr,
+					   NULL);
+		dax_read_unlock(dax_id);
+		if (mapped < 0)
+			return mapped;
+		if (mapped < ring_pages)
+			return -ENXIO;
+	}
+#else
+	return -EOPNOTSUPP;
+#endif
+
+	log->kaddr = addr;
+	log->size_bytes = ring_bytes;
+	log->base_off = (u64)EXT4_FC_BYTELOG_META_BLOCKS << blkbits;
+	log->persist_off = log->base_off;
+	log->blocks = ring_blocks;
+	log->blocksize = sb->s_blocksize;
+	log->start_pblk = first;
+	log->anchor_pblk = anchor;
+
+	return 0;
+}
+
+int ext4_fc_bytelog_init(struct super_block *sb, journal_t *journal)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_bytelog *log = &sbi->s_fc_bytelog;
+	bool have_feature = ext4_has_feature_dax_fc_bytelog(sb);
+	bool requested = test_opt2(sb, DAX_FC_BYTELOG);
+	bool force = test_opt2(sb, DAX_FC_BYTELOG_FORCE);
+	bool need_map = have_feature || requested || force;
+	u32 batch_max;
+	int ret;
+
+	if (!need_map) {
+		log->enabled = false;
+		log->last_error = -EOPNOTSUPP;
+		return 0;
+	}
+
+	ext4_fc_crc32c_shift_mats_init_once();
+
+	if (log->mapped)
+		goto enable;
+
+	batch_max = log->batch_max;
+	memset(log, 0, sizeof(*log));
+	log->batch_max = batch_max ? batch_max :
+		EXT4_FC_BYTELOG_BATCH_MAX_DEFAULT;
+	log->last_error = -EOPNOTSUPP;
+
+	if (!journal || !test_opt2(sb, JOURNAL_FAST_COMMIT)) {
+		if (requested)
+			ext4_msg(sb, KERN_INFO,
+				 "dax_fc_bytelog requires fast commits enabled");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * ext4_fc_bytelog_init() is called once before jbd2_journal_load() so
+	 * that existing ByteLog records can be replayed.  On a fresh
+	 * filesystem, the JBD2 fast-commit feature may not be enabled on the
+	 * journal yet, so there is no fast-commit area to map at this stage.
+	 *
+	 * If the on-disk feature bit is set, lack of journal fast-commit
+	 * support indicates an inconsistent filesystem and must be fatal.
+	 * Otherwise, defer mapping until the post-journal-load init path.
+	 */
+	if (!jbd2_has_feature_fast_commit(journal)) {
+		if (have_feature) {
+			ext4_msg(sb, KERN_ERR,
+				 "dax_fc_bytelog requires JBD2 fast commits enabled");
+			return -EINVAL;
+		}
+
+		log->enabled = false;
+		log->last_error = -EOPNOTSUPP;
+		return 0;
+	}
+
+	/*
+	 * When dax_fc_bytelog=on is specified without the incompat feature
+	 * bit, refuse to enable ByteLog.  dax_fc_bytelog=force overrides this
+	 * check and is intended only for testing.
+	 */
+	if (!have_feature && requested && !force) {
+		ext4_msg(sb, KERN_INFO,
+			 "dax_fc_bytelog=on requires INCOMPAT_DAX_FC_BYTELOG");
+		return -EOPNOTSUPP;
+	}
+	if (!have_feature && force)
+		ext4_warning(sb,
+			     "forcing dax_fc_bytelog without INCOMPAT_DAX_FC_BYTELOG; older kernels cannot safely mount this filesystem");
+
+	if (test_opt2(sb, DAX_NEVER)) {
+		ext4_msg(sb, KERN_INFO,
+			 "dax_fc_bytelog requires DAX, but dax=never is set");
+		return -EOPNOTSUPP;
+	}
+	if (!sbi->s_daxdev) {
+		ext4_msg(sb, KERN_INFO,
+			 "dax_fc_bytelog requires a dax-capable filesystem device");
+		return -EOPNOTSUPP;
+	}
+	if (sb->s_blocksize != PAGE_SIZE) {
+		ext4_msg(sb, KERN_INFO,
+			 "dax_fc_bytelog requires blocksize == PAGE_SIZE");
+		return -EOPNOTSUPP;
+	}
+
+	ret = ext4_fc_bytelog_map_ring(sb, journal, log);
+	if (ret) {
+		log->last_error = ret;
+		ext4_msg(sb, KERN_INFO,
+			 "dax_fc_bytelog disabled: unable to map fast-commit ring (err=%d)",
+			 ret);
+		ext4_debug("ByteLog mapping unavailable (err=%d)\n", ret);
+		return ret;
+	}
+
+	log->head = log->base_off;
+	log->tail = log->base_off;
+	log->seq = 0;
+	log->ring_crc = ~0;
+	log->dirty = false;
+	log->persist_off = log->base_off;
+	ext4_fc_bytelog_reset_batch(log);
+	log->mapped = true;
+	log->last_error = 0;
+enable:
+	log->enabled = requested || force;
+	return 0;
+}
+
+void ext4_fc_bytelog_release(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	memset(&sbi->s_fc_bytelog, 0, sizeof(sbi->s_fc_bytelog));
+}
+
+void ext4_fc_bytelog_reset(struct super_block *sb, bool full)
+{
+	struct ext4_fc_bytelog *log = &EXT4_SB(sb)->s_fc_bytelog;
+
+	if (!log->mapped)
+		return;
+	if (!full)
+		return;
+
+	log->head = log->base_off;
+	log->tail = log->base_off;
+	log->seq = 0;
+	log->ring_crc = ~0;
+	log->dirty = false;
+	log->persist_off = log->base_off;
+	ext4_fc_bytelog_reset_batch(log);
+}
+
+void ext4_fc_bytelog_begin_commit(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_bytelog *log = &sbi->s_fc_bytelog;
+
+	if (!log->mapped || !log->enabled)
+		return;
+
+	log->head = log->base_off;
+	log->tail = log->base_off;
+	log->seq = 0;
+	log->ring_crc = ~0;
+	log->dirty = false;
+	log->persist_off = log->base_off;
+	ext4_fc_bytelog_reset_batch(log);
+}
+
+int ext4_fc_bytelog_end_commit(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_bytelog *log = &sbi->s_fc_bytelog;
+	journal_t *journal = sbi->s_journal;
+	u8 *base;
+	u64 cursor, end;
+	u32 tid;
+	int ret;
+
+	if (!log->mapped || !log->enabled)
+		return 0;
+
+	if (!journal || !journal->j_running_transaction)
+		return -EINVAL;
+	tid = journal->j_running_transaction->t_tid;
+
+	ret = ext4_fc_bytelog_flush_batch(sb, tid);
+	if (ret) {
+		log->last_error = ret;
+		return ret;
+	}
+
+	if (!log->dirty)
+		return 0;
+
+	base = log->kaddr;
+	if (!base)
+		return -EOPNOTSUPP;
+
+	cursor = log->persist_off;
+	end = log->head;
+	if (end <= cursor)
+		return 0;
+
+	ext4_fc_bytelog_flush_persist(base + cursor, end - cursor);
+	ext4_fc_bytelog_persist_barrier();
+
+	log->persist_off = end;
+	log->dirty = false;
+	return 0;
+}
+
+static inline bool ext4_fc_bytelog_has_space(struct ext4_fc_bytelog *log,
+					     size_t len)
+{
+	if (log->head < log->base_off)
+		return false;
+	if (len > log->size_bytes - log->base_off)
+		return false;
+	return log->head + len <= log->size_bytes;
+}
+
+static void ext4_fc_bytelog_reset_batch(struct ext4_fc_bytelog *log)
+{
+	log->batch_first_tag = 0;
+	log->batch_len = 0;
+	log->batch_tlvs = 0;
+	log->batch_payload_crc = ~0U;
+}
+
+static int ext4_fc_bytelog_commit_record(struct super_block *sb, u32 tid, u16 tag,
+					 size_t payload_len, u32 payload_crc)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_bytelog *log = &sbi->s_fc_bytelog;
+	struct ext4_fc_bytelog_hdr hdr;
+	size_t total_len, off;
+	u32 ring_crc;
+	u8 *dst;
+	u8 *payload;
+	u64 seq;
+	bool mats_ready;
+
+	total_len = ext4_fc_bytelog_record_size(payload_len);
+	if (!ext4_fc_bytelog_has_space(log, total_len))
+		return -ENOSPC;
+
+	seq = log->seq;
+	ring_crc = log->ring_crc;
+
+	mats_ready = READ_ONCE(ext4_fc_crc32c_shift_mats_ready);
+	ext4_fc_bytelog_prep_hdr(&hdr, tag, 0, tid, seq, payload_len);
+	dst = (u8 *)log->kaddr + log->head;
+	off = sizeof(hdr);
+	payload = dst + off;
+
+	if (payload_len) {
+		if (likely(mats_ready)) {
+			ring_crc = ext4_fc_crc32c_shift_zeros(ring_crc ^ ~0U, payload_len);
+			ring_crc ^= payload_crc;
+		} else {
+			ring_crc = crc32c(ring_crc, payload, payload_len);
+		}
+		off += payload_len;
+	} else {
+		payload_crc = ext4_fc_bytelog_crc32(NULL, 0);
+	}
+
+	if (off < total_len) {
+		size_t pad = total_len - off;
+
+		memset(dst + off, 0, pad);
+	}
+
+	hdr.flags = cpu_to_le16(le16_to_cpu(hdr.flags) | EXT4_FC_BYTELOG_COMMITTED);
+	ext4_fc_bytelog_finalize_hdr_crc(&hdr, payload_crc);
+	memcpy(dst, &hdr, sizeof(hdr));
+
+	log->head += total_len;
+	log->seq++;
+	log->dirty = true;
+	log->ring_crc = ring_crc;
+
+	return 0;
+}
+
+static size_t ext4_fc_bytelog_copy_vecs(u8 *dst,
+					struct ext4_fc_bytelog_vec *vecs,
+					int nvec, u32 *crc)
+{
+	size_t off = 0;
+	u32 crc_val = crc ? *crc : 0;
+	int i;
+
+	for (i = 0; i < nvec; i++) {
+		const u8 *src = vecs[i].base;
+		size_t len = vecs[i].len;
+
+		if (!len)
+			continue;
+
+		while (i + 1 < nvec && vecs[i + 1].len &&
+		       vecs[i + 1].base == src + len) {
+			len += vecs[i + 1].len;
+			i++;
+		}
+
+		if (crc)
+			crc_val = crc32c(crc_val, src, len);
+		memcpy(dst + off, src, len);
+		off += len;
+	}
+
+	if (crc)
+		*crc = crc_val;
+	return off;
+}
+
+static int ext4_fc_bytelog_append_vec_direct(struct super_block *sb, u32 tid, u16 tag,
+					     struct ext4_fc_bytelog_vec *vecs,
+					     int nvec, size_t payload_len)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_bytelog *log = &sbi->s_fc_bytelog;
+	size_t total_len;
+	u32 payload_crc = ~0U;
+	u8 *dst;
+
+	total_len = ext4_fc_bytelog_record_size(payload_len);
+	if (!ext4_fc_bytelog_has_space(log, total_len))
+		return -ENOSPC;
+
+	dst = (u8 *)log->kaddr + log->head + sizeof(struct ext4_fc_bytelog_hdr);
+	ext4_fc_bytelog_copy_vecs(dst, vecs, nvec, &payload_crc);
+	return ext4_fc_bytelog_commit_record(sb, tid, tag, payload_len,
+					     payload_crc);
+}
+
+static int ext4_fc_bytelog_flush_batch(struct super_block *sb, u32 tid)
+{
+	struct ext4_fc_bytelog *log = &EXT4_SB(sb)->s_fc_bytelog;
+	u32 payload_crc = ~0U;
+	u16 tag;
+	int ret;
+
+	if (!log->batch_len)
+		return 0;
+
+	tag = log->batch_first_tag;
+	if (log->batch_tlvs > 1)
+		tag = EXT4_FC_BYTELOG_TAG_BATCH;
+
+	if (!log->kaddr)
+		return -EOPNOTSUPP;
+
+	payload_crc = log->batch_payload_crc;
+	ret = ext4_fc_bytelog_commit_record(sb, tid, tag, log->batch_len,
+					    payload_crc);
+	ext4_fc_bytelog_reset_batch(log);
+	return ret;
+}
+
+int ext4_fc_bytelog_append_vec(struct super_block *sb, u16 tag,
+			       struct ext4_fc_bytelog_vec *vecs, int nvec)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_bytelog *log = &sbi->s_fc_bytelog;
+	struct journal_s *journal = sbi->s_journal;
+	size_t payload_len = 0;
+	u32 batch_max = log->batch_max;
+	u32 tid;
+	int i;
+	u8 *base;
+	u8 *dst;
+
+	if (!ext4_fc_bytelog_active(sbi))
+		return -EOPNOTSUPP;
+
+	if (!journal || !journal->j_running_transaction)
+		return -EINVAL;
+	tid = journal->j_running_transaction->t_tid;
+
+	for (i = 0; i < nvec; i++)
+		payload_len += vecs[i].len;
+
+	base = log->kaddr;
+	if (!base)
+		return -EOPNOTSUPP;
+
+	if (!batch_max) {
+		int ret;
+
+		ret = ext4_fc_bytelog_flush_batch(sb, tid);
+		if (ret)
+			return ret;
+		return ext4_fc_bytelog_append_vec_direct(sb, tid, tag, vecs,
+							 nvec, payload_len);
+	}
+
+	if (payload_len > batch_max) {
+		int ret;
+
+		ret = ext4_fc_bytelog_flush_batch(sb, tid);
+		if (ret)
+			return ret;
+		return ext4_fc_bytelog_append_vec_direct(sb, tid, tag, vecs,
+							 nvec, payload_len);
+	}
+
+	if (log->batch_len && log->batch_len + payload_len > batch_max) {
+		int ret;
+
+		ret = ext4_fc_bytelog_flush_batch(sb, tid);
+		if (ret)
+			return ret;
+	}
+
+	if (!log->batch_len)
+		log->batch_first_tag = tag;
+
+	if (!ext4_fc_bytelog_has_space(log,
+				       ext4_fc_bytelog_record_size(log->batch_len +
+								   payload_len))) {
+		int ret;
+
+		ret = ext4_fc_bytelog_flush_batch(sb, tid);
+		if (ret)
+			return ret;
+		log->batch_first_tag = tag;
+	}
+
+	if (!ext4_fc_bytelog_has_space(log,
+				       ext4_fc_bytelog_record_size(log->batch_len +
+								   payload_len)))
+		return -ENOSPC;
+
+	dst = base + log->head + sizeof(struct ext4_fc_bytelog_hdr) +
+	      log->batch_len;
+	log->batch_len += ext4_fc_bytelog_copy_vecs(dst, vecs, nvec, &log->batch_payload_crc);
+	log->batch_tlvs++;
+	log->dirty = true;
+	return 0;
+}
+
+void ext4_fc_bytelog_build_anchor(struct super_block *sb,
+				  struct ext4_fc_bytelog_anchor *anchor,
+				  u32 tid)
+{
+	struct ext4_fc_bytelog *log = &EXT4_SB(sb)->s_fc_bytelog;
+
+	memset(anchor, 0, sizeof(*anchor));
+	anchor->tid = tid;
+	anchor->head = log->head;
+	anchor->tail = log->tail;
+	anchor->seq = log->seq;
+	anchor->crc = log->ring_crc;
+}
diff --git a/fs/ext4/fast_commit_bytelog.h b/fs/ext4/fast_commit_bytelog.h
new file mode 100644
index 000000000000..d52754890222
--- /dev/null
+++ b/fs/ext4/fast_commit_bytelog.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EXT4_FAST_COMMIT_BYTELOG_H
+#define _EXT4_FAST_COMMIT_BYTELOG_H
+
+#include <linux/bitops.h>
+#include <linux/byteorder/generic.h>
+#include <linux/types.h>
+
+struct super_block;
+struct journal_s;
+struct ext4_sb_info;
+
+#define EXT4_FC_BYTELOG_MAGIC			0x4c424346 /* "FCBL" */
+#define EXT4_FC_BYTELOG_VERSION			1
+#define EXT4_FC_BYTELOG_ALIGN			64
+#define EXT4_FC_BYTELOG_BATCH_MAX_DEFAULT	4096
+
+/*
+ * Record header @tag for a batched TLV payload stream.
+ *
+ * In this case the payload is a stream of standard fast-commit TLVs
+ * (struct ext4_fc_tl + value).
+ */
+#define EXT4_FC_BYTELOG_TAG_BATCH		0xffff
+
+/* Record flag bits */
+#define EXT4_FC_BYTELOG_COMMITTED		BIT(0)
+
+/**
+ * struct ext4_fc_bytelog_hdr - On-media header for a ByteLog record
+ * @magic:	Magic identifying the record
+ * @version:	On-disk header format version
+ * @hdr_len:	Length of this header in bytes
+ * @tid:	JBD2 transaction identifier
+ * @tag:	Ext4 fast-commit tag (or EXT4_FC_BYTELOG_TAG_BATCH)
+ * @flags:	Record flags (EXT4_FC_BYTELOG_*)
+ * @payload_len:Length of payload bytes following the header
+ * @payload_crc:CRC32C of the payload
+ * @record_len:	Entire record length including header, payload and padding
+ * @header_crc:	CRC32C of the header with @header_crc zeroed
+ * @seq:	Monotonic sequence number assigned by the ByteLog writer
+ * @reserved:	Future fields, currently zeroed
+ *
+ * The structure is padded to 64 bytes to keep each record 64B aligned.
+ */
+struct ext4_fc_bytelog_hdr {
+	__le32	magic;
+	__le16	version;
+	__le16	hdr_len;
+	__le32	tid;
+	__le16	tag;
+	__le16	flags;
+	__le32	payload_len;
+	__le32	payload_crc;
+	__le32	record_len;
+	__le32	header_crc;
+	__le64	seq;
+	__le64	reserved[3];
+} __packed;
+
+struct ext4_fc_bytelog_anchor {
+	u32		tid;
+	u64		head;
+	u64		tail;
+	u64		seq;
+	u32		crc;
+};
+
+struct ext4_fc_bytelog {
+	void		*kaddr;
+	u64		size_bytes;
+	u64		base_off;
+	u64		persist_off;
+	u32		blocksize;
+	u32		blocks;
+	u64		start_pblk;
+	u64		anchor_pblk;
+	u64		head;
+	u64		tail;
+	u64		seq;
+	u32		ring_crc;
+
+	u32		batch_max;
+	u16		batch_first_tag;
+	u32		batch_len;
+	u32		batch_tlvs;
+	u32		batch_payload_crc;
+
+	bool		mapped;
+	bool		enabled;
+	bool		dirty;
+	int		last_error;
+};
+
+struct ext4_fc_bytelog_vec {
+	const void	*base;
+	size_t		len;
+};
+
+int ext4_fc_bytelog_init(struct super_block *sb, struct journal_s *journal);
+void ext4_fc_bytelog_release(struct super_block *sb);
+void ext4_fc_bytelog_reset(struct super_block *sb, bool full);
+void ext4_fc_bytelog_begin_commit(struct super_block *sb);
+int ext4_fc_bytelog_end_commit(struct super_block *sb);
+bool ext4_fc_bytelog_active(struct ext4_sb_info *sbi);
+bool ext4_fc_bytelog_mapped(struct ext4_sb_info *sbi);
+int ext4_fc_bytelog_append_vec(struct super_block *sb, u16 tag,
+			       struct ext4_fc_bytelog_vec *vecs, int nvec);
+void ext4_fc_bytelog_build_anchor(struct super_block *sb,
+				  struct ext4_fc_bytelog_anchor *anchor,
+				  u32 tid);
+
+static inline bool ext4_fc_bytelog_record_committed(const struct ext4_fc_bytelog_hdr *hdr)
+{
+	return !!(le16_to_cpu(hdr->flags) & EXT4_FC_BYTELOG_COMMITTED);
+}
+
+static inline u32 ext4_fc_bytelog_record_len(const struct ext4_fc_bytelog_hdr *hdr)
+{
+	return le32_to_cpu(hdr->record_len);
+}
+
+static inline u32 ext4_fc_bytelog_payload_len(const struct ext4_fc_bytelog_hdr *hdr)
+{
+	return le32_to_cpu(hdr->payload_len);
+}
+
+static inline u64 ext4_fc_bytelog_seq(const struct ext4_fc_bytelog_hdr *hdr)
+{
+	return le64_to_cpu(hdr->seq);
+}
+
+size_t ext4_fc_bytelog_record_size(size_t payload_len);
+void ext4_fc_bytelog_prep_hdr(struct ext4_fc_bytelog_hdr *hdr, u16 tag,
+			      u16 flags, u32 tid, u64 seq, u32 payload_len);
+void ext4_fc_bytelog_finalize_hdr_crc(struct ext4_fc_bytelog_hdr *hdr,
+				      u32 payload_crc);
+int ext4_fc_bytelog_validate_hdr(const struct ext4_fc_bytelog_hdr *hdr,
+				 size_t remaining, const void *payload);
+void ext4_fc_bytelog_mark_committed(struct ext4_fc_bytelog_hdr *hdr);
+
+void ext4_fc_bytelog_flush_persist(void *addr, size_t len);
+void ext4_fc_bytelog_persist_barrier(void);
+
+u32 ext4_fc_bytelog_crc32(const void *buf, size_t len);
+
+#endif /* _EXT4_FAST_COMMIT_BYTELOG_H */
-- 
2.52.0


