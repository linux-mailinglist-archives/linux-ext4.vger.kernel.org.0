Return-Path: <linux-ext4+bounces-14038-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGHkG/odoGmzfgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14038-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:18:34 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D801A4247
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 11:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BC813020A7B
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45593A782E;
	Thu, 26 Feb 2026 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="iVY8uOmi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B83A7834;
	Thu, 26 Feb 2026 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101111; cv=pass; b=fZxu3OoACjfqhp1ZcQCbGM1WMENVWP1nj3D7AdhiUzD4QdpYeTNaWpRKRZHNd0//NPBWeMW+uB6fEUOzkIqXdLX6htUE+QneY56pB8F3IasoFTo2LQBi1pDeh8rSYHsN0LtiHaa1rBTOHcX7vdqOjV08jlds0xov3GDcQsxMPN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101111; c=relaxed/simple;
	bh=LR1A1sVj98yRHfklQsoSfgF7AoPXlGjwhfJsflSC34I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S97yrcFI4ezFlfC/mXv+y+5y1f8BlbRDOLno7mynAqxV4s+agzTYjc+3H5U+b7ro0cNuJbY+YBWY8bLZF7/wx707qf+WMNcMhKQheKR9/vny+my2WyB03ZqH2avpu2OEDDccGScDw5ytcNweiYwz2eqspJk59/ts/548pJNUTMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=iVY8uOmi; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1772101089; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jFVEpSO/i/5PiaHgsJnD9wwCwbu23PJe+Tb/1QI9hve0XJYc77h9v5lQA0GRj0vTQfkIo1EORzKKpo2ccoVNZbxcZMZG5cbTUQrJECySjGQYQgpqacxKQ6R8hQDalRVHIZkTcG6QSq9FFEvnDum9o85RIeAVu42LLFiXVTVMjmc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772101089; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+TO5qO2m+VCH2iEuDsLwTaboZDhB3f74KLvsUyaJqU4=; 
	b=IW0y+wG5bS6M6SQonAZKIOO+0hQISqFnuW6cm1cbTigR604fAONPADLriaj35fdWN0f9VIQjISeCs/c9OrxdK2jjjugroDC2N/WToowMjQLFZboBWHGwQyiK/5gVR3rKXcUvR6iQZnN7IIr0dBkqJvVEgVhq741/pIaX2zEB91w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772101089;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+TO5qO2m+VCH2iEuDsLwTaboZDhB3f74KLvsUyaJqU4=;
	b=iVY8uOmi6jFlIdvngn7gIkFMNX/F5JuAKqVApt6/CijQadlD8u9zfQSyjdSeQV7C
	b5nPRSLAWDxmwGyq742kJ9YD4UbZbk031+Gundb5XHla+mVI6Iy3C/W/ljcxzfaXYkB
	q9A5nl4Cv4/56RU3Xf42QM65dUkptYPK3PV3cv/k=
Received: by mx.zohomail.com with SMTPS id 1772101088242426.3470871388149;
	Thu, 26 Feb 2026 02:18:08 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: linux-ext4@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org
Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	Li Chen <me@linux.beauty>
Subject: [RFC PATCH 4/4] ext4: fast_commit: replay DAX ByteLog records
Date: Thu, 26 Feb 2026 18:17:32 +0800
Message-ID: <20260226101736.2271952-5-me@linux.beauty>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.beauty];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14038-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:mid,linux.beauty:dkim,linux.beauty:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28D801A4247
X-Rspamd-Action: no action

Add replay support for EXT4_FC_TAG_DAX_BYTELOG_ANCHOR.
The anchor TLV describes a ByteLog window in the DAX-mapped fast commit
area, which is validated and then replayed using existing TLV handlers.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/fast_commit.c | 246 ++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/fast_commit.h |   9 ++
 2 files changed, 255 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 2f7b7ea29df2..6370505ecc86 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -12,6 +12,7 @@
 #include "ext4_extents.h"
 #include "mballoc.h"
 
+#include <linux/crc32c.h>
 #include <linux/lockdep.h>
 /*
  * Ext4 Fast Commits
@@ -2172,10 +2173,228 @@ static bool ext4_fc_value_len_isvalid(struct ext4_sb_info *sbi,
 		return len >= sizeof(struct ext4_fc_tail);
 	case EXT4_FC_TAG_HEAD:
 		return len == sizeof(struct ext4_fc_head);
+	case EXT4_FC_TAG_DAX_BYTELOG_ANCHOR:
+		return len == sizeof(struct ext4_fc_bytelog_entry);
 	}
 	return false;
 }
 
+static void ext4_fc_reset_bytelog_state(struct ext4_fc_bytelog_state *state)
+{
+	state->cursor = 0;
+	state->next_seq = 0;
+	state->ring_crc = ~0U;
+	state->initialized = false;
+}
+
+typedef int (*ext4_fc_bytelog_cb_t)(struct super_block *sb,
+				    struct ext4_fc_tl_mem *tl,
+				    u8 *val, void *data);
+
+static int ext4_fc_bytelog_iterate(struct super_block *sb,
+				   struct ext4_fc_bytelog_state *iter,
+				   const struct ext4_fc_bytelog_anchor *anchor,
+				   ext4_fc_bytelog_cb_t fn, void *data)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_bytelog *log = &sbi->s_fc_bytelog;
+	u8 *base = log->kaddr;
+	u64 cursor, end;
+	int ret;
+
+	if (!log->mapped || !base)
+		return -EOPNOTSUPP;
+	if (anchor->head > log->size_bytes)
+		return -EFSCORRUPTED;
+
+	iter->cursor = anchor->tail;
+	iter->next_seq = 0;
+	iter->ring_crc = ~0U;
+	iter->initialized = true;
+	cursor = iter->cursor;
+	end = anchor->head;
+
+	if (cursor < log->base_off)
+		return -EFSCORRUPTED;
+	if (cursor > end || cursor > log->size_bytes)
+		return -EFSCORRUPTED;
+
+	while (cursor < end) {
+		struct ext4_fc_bytelog_hdr *hdr;
+		size_t remaining;
+		u32 payload_len, record_len;
+		u16 record_tag;
+		u8 *payload;
+		struct ext4_fc_tl_mem tl;
+
+		if (end - cursor > SIZE_MAX)
+			return -E2BIG;
+		remaining = end - cursor;
+		if (cursor > log->size_bytes - sizeof(*hdr))
+			return -EFSCORRUPTED;
+
+		hdr = (struct ext4_fc_bytelog_hdr *)(base + cursor);
+		payload = (u8 *)hdr + sizeof(*hdr);
+		ret = ext4_fc_bytelog_validate_hdr(hdr, remaining, payload);
+		if (ret)
+			return ret;
+		if (!ext4_fc_bytelog_record_committed(hdr))
+			return -EUCLEAN;
+		if (ext4_fc_bytelog_seq(hdr) != iter->next_seq)
+			return -EUCLEAN;
+
+		payload_len = ext4_fc_bytelog_payload_len(hdr);
+		if (payload_len < EXT4_FC_TAG_BASE_LEN)
+			return -EFSCORRUPTED;
+
+		record_tag = le16_to_cpu(hdr->tag);
+		if (record_tag == EXT4_FC_BYTELOG_TAG_BATCH) {
+			u32 pos = 0;
+
+			while (pos < payload_len) {
+				u32 value_len;
+
+				if (payload_len - pos < EXT4_FC_TAG_BASE_LEN)
+					return -EFSCORRUPTED;
+
+				ext4_fc_get_tl(&tl, payload + pos);
+				value_len = tl.fc_len;
+				if (value_len >
+				    payload_len - pos - EXT4_FC_TAG_BASE_LEN)
+					return -EFSCORRUPTED;
+				if (!ext4_fc_value_len_isvalid(sbi, tl.fc_tag,
+							       tl.fc_len))
+					return -EFSCORRUPTED;
+				if (fn) {
+					ret = fn(sb, &tl,
+						 payload + pos +
+						 EXT4_FC_TAG_BASE_LEN,
+						 data);
+					if (ret)
+						return ret;
+				}
+				pos += EXT4_FC_TAG_BASE_LEN + value_len;
+			}
+		} else {
+			u32 value_len;
+
+			ext4_fc_get_tl(&tl, payload);
+			value_len = payload_len - EXT4_FC_TAG_BASE_LEN;
+			if (tl.fc_len != value_len)
+				return -EFSCORRUPTED;
+			if (record_tag != tl.fc_tag)
+				return -EFSCORRUPTED;
+			if (!ext4_fc_value_len_isvalid(sbi, tl.fc_tag, tl.fc_len))
+				return -EFSCORRUPTED;
+			if (fn) {
+				ret = fn(sb, &tl,
+					 payload + EXT4_FC_TAG_BASE_LEN,
+					 data);
+				if (ret)
+					return ret;
+			}
+		}
+
+		iter->ring_crc = crc32c(iter->ring_crc, payload, payload_len);
+		record_len = ext4_fc_bytelog_record_len(hdr);
+		cursor += record_len;
+		iter->next_seq++;
+	}
+
+	if (cursor != end)
+		return -EFSCORRUPTED;
+	iter->cursor = cursor;
+	if (iter->next_seq != anchor->seq)
+		return -EUCLEAN;
+	if (iter->ring_crc != anchor->crc)
+		return -EFSBADCRC;
+	return 0;
+}
+
+static int ext4_fc_bytelog_scan_cb(struct super_block *sb,
+				   struct ext4_fc_tl_mem *tl, u8 *val,
+				   void *data)
+{
+	struct ext4_fc_add_range ext;
+	struct ext4_extent *ex;
+
+	(void)data;
+	switch (tl->fc_tag) {
+	case EXT4_FC_TAG_ADD_RANGE:
+		memcpy(&ext, val, sizeof(ext));
+		ex = (struct ext4_extent *)&ext.fc_ex;
+		return ext4_fc_record_regions(sb, le32_to_cpu(ext.fc_ino),
+					      le32_to_cpu(ex->ee_block),
+					      ext4_ext_pblock(ex),
+					      ext4_ext_get_actual_len(ex), 0);
+	case EXT4_FC_TAG_DEL_RANGE:
+	case EXT4_FC_TAG_LINK:
+	case EXT4_FC_TAG_UNLINK:
+	case EXT4_FC_TAG_CREAT:
+	case EXT4_FC_TAG_INODE:
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ext4_fc_bytelog_replay_cb(struct super_block *sb,
+				     struct ext4_fc_tl_mem *tl, u8 *val,
+				     void *data)
+{
+	(void)data;
+	switch (tl->fc_tag) {
+	case EXT4_FC_TAG_LINK:
+		return ext4_fc_replay_link(sb, tl, val);
+	case EXT4_FC_TAG_UNLINK:
+		return ext4_fc_replay_unlink(sb, tl, val);
+	case EXT4_FC_TAG_ADD_RANGE:
+		return ext4_fc_replay_add_range(sb, tl, val);
+	case EXT4_FC_TAG_CREAT:
+		return ext4_fc_replay_create(sb, tl, val);
+	case EXT4_FC_TAG_DEL_RANGE:
+		return ext4_fc_replay_del_range(sb, tl, val);
+	case EXT4_FC_TAG_INODE:
+		return ext4_fc_replay_inode(sb, tl, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ext4_fc_replay_scan_bytelog(struct super_block *sb,
+				       struct ext4_fc_replay_state *state,
+				       const struct ext4_fc_bytelog_anchor *anchor)
+{
+	int ret;
+
+	ret = ext4_fc_bytelog_iterate(sb, &state->fc_bytelog_scan, anchor,
+				      ext4_fc_bytelog_scan_cb, state);
+	if (ret)
+		return ret;
+	return JBD2_FC_REPLAY_CONTINUE;
+}
+
+static int ext4_fc_replay_apply_bytelog(struct super_block *sb,
+					struct ext4_fc_replay_state *state,
+					const struct ext4_fc_bytelog_anchor *anchor)
+{
+	return ext4_fc_bytelog_iterate(sb, &state->fc_bytelog_replay, anchor,
+				       ext4_fc_bytelog_replay_cb, NULL);
+}
+
+static int ext4_fc_replay_bytelog_anchor(struct super_block *sb,
+					 struct ext4_fc_replay_state *state,
+					 struct ext4_fc_tl_mem *tl, u8 *val)
+{
+	struct ext4_fc_bytelog_entry entry;
+	struct ext4_fc_bytelog_anchor anchor;
+
+	(void)tl;
+	memcpy(&entry, val, sizeof(entry));
+	ext4_fc_bytelog_anchor_from_disk(&anchor, &entry);
+	return ext4_fc_replay_apply_bytelog(sb, state, &anchor);
+}
+
 /*
  * Recovery Scan phase handler
  *
@@ -2206,6 +2425,8 @@ static int ext4_fc_replay_scan(journal_t *journal,
 	struct ext4_fc_tail tail;
 	__u8 *start, *end, *cur, *val;
 	struct ext4_fc_head head;
+	struct ext4_fc_bytelog_entry entry;
+	struct ext4_fc_bytelog_anchor anchor;
 	struct ext4_extent *ex;
 
 	state = &sbi->s_fc_replay_state;
@@ -2220,6 +2441,8 @@ static int ext4_fc_replay_scan(journal_t *journal,
 		state->fc_regions = NULL;
 		state->fc_regions_valid = state->fc_regions_used =
 			state->fc_regions_size = 0;
+		ext4_fc_reset_bytelog_state(&state->fc_bytelog_scan);
+		ext4_fc_reset_bytelog_state(&state->fc_bytelog_replay);
 		/* Check if we can stop early */
 		if (le16_to_cpu(((struct ext4_fc_tl *)start)->fc_tag)
 			!= EXT4_FC_TAG_HEAD)
@@ -2278,6 +2501,9 @@ static int ext4_fc_replay_scan(journal_t *journal,
 				state->fc_replay_num_tags = state->fc_cur_tag;
 				state->fc_regions_valid =
 					state->fc_regions_used;
+				if (ext4_fc_bytelog_active(sbi) ||
+				    state->fc_bytelog_scan.initialized)
+					ret = JBD2_FC_REPLAY_STOP;
 			} else {
 				ret = state->fc_replay_num_tags ?
 					JBD2_FC_REPLAY_STOP : -EFSBADCRC;
@@ -2299,6 +2525,15 @@ static int ext4_fc_replay_scan(journal_t *journal,
 			state->fc_crc = ext4_chksum(state->fc_crc, cur,
 				EXT4_FC_TAG_BASE_LEN + tl.fc_len);
 			break;
+		case EXT4_FC_TAG_DAX_BYTELOG_ANCHOR:
+			state->fc_cur_tag++;
+			state->fc_crc = ext4_chksum(state->fc_crc, cur,
+						    EXT4_FC_TAG_BASE_LEN +
+						    tl.fc_len);
+			memcpy(&entry, val, sizeof(entry));
+			ext4_fc_bytelog_anchor_from_disk(&anchor, &entry);
+			ret = ext4_fc_replay_scan_bytelog(sb, state, &anchor);
+			break;
 		default:
 			ret = state->fc_replay_num_tags ?
 				JBD2_FC_REPLAY_STOP : -ECANCELED;
@@ -2335,6 +2570,8 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 	if (state->fc_current_pass != pass) {
 		state->fc_current_pass = pass;
 		sbi->s_mount_state |= EXT4_FC_REPLAY;
+		if (pass == PASS_REPLAY)
+			ext4_fc_reset_bytelog_state(&state->fc_bytelog_replay);
 	}
 	if (!sbi->s_fc_replay_state.fc_replay_num_tags) {
 		ext4_debug("Replay stops\n");
@@ -2393,9 +2630,18 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 					     0, tl.fc_len, 0);
 			memcpy(&tail, val, sizeof(tail));
 			WARN_ON(le32_to_cpu(tail.fc_tid) != expected_tid);
+			if ((ext4_fc_bytelog_active(sbi) ||
+			     state->fc_bytelog_scan.initialized) &&
+			    state->fc_replay_num_tags == 0) {
+				ext4_fc_set_bitmaps_and_counters(sb);
+				return JBD2_FC_REPLAY_STOP;
+			}
 			break;
 		case EXT4_FC_TAG_HEAD:
 			break;
+		case EXT4_FC_TAG_DAX_BYTELOG_ANCHOR:
+			ret = ext4_fc_replay_bytelog_anchor(sb, state, &tl, val);
+			break;
 		default:
 			trace_ext4_fc_replay(sb, tl.fc_tag, 0, tl.fc_len, 0);
 			ret = -ECANCELED;
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index fb51e19b9778..224d718150c4 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -153,6 +153,13 @@ struct ext4_fc_alloc_region {
 	int ino, len;
 };
 
+struct ext4_fc_bytelog_state {
+	u64 cursor;
+	u64 next_seq;
+	u32 ring_crc;
+	bool initialized;
+};
+
 /*
  * Fast commit replay state.
  */
@@ -166,6 +173,8 @@ struct ext4_fc_replay_state {
 	int fc_regions_size, fc_regions_used, fc_regions_valid;
 	int *fc_modified_inodes;
 	int fc_modified_inodes_used, fc_modified_inodes_size;
+	struct ext4_fc_bytelog_state fc_bytelog_scan;
+	struct ext4_fc_bytelog_state fc_bytelog_replay;
 };
 
 #define region_last(__region) (((__region)->lblk) + ((__region)->len) - 1)
-- 
2.52.0


