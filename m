Return-Path: <linux-ext4+bounces-7815-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4FAAB4B15
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 07:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E5916937D
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 05:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E641E5B95;
	Tue, 13 May 2025 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4ZewDle"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11E31E5729
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747114734; cv=none; b=i/M5Q0ZlXP3Smn930liJSWEHE3T/3G0hzHYq10yT4dHfoSuaHg2cpRrozr3SXKE80ycUxDLTh0L0WbelqjhFxFd7d9yQ/w8cPaE7ruowJ91xAonfk9EOCRg+UVdnB/CdsVMAoNPupa89KUQ0DWZa8gUW0ZK+T2iY2BmOtGdigkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747114734; c=relaxed/simple;
	bh=yRTmAPfpy3jnXnN7eOKRZtlgxzAWG2XoYobCZva0fs0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3qEgIYQJhf0lEhhoGvge+88qwtNYaqQeQd56BYCkMwhqCZC6sWPEp+JZtVg5TTOP1p1mUFGkdlNRBGbjD9UNz5mBE6DW43uV3i3DPvPRGkAMxLotI2FxfdWxLok0f9WWKhlMK6eKifEvcdCHlAjRmVlFIFzzYu6ksETV98hBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4ZewDle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6DDC4CEF0
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 05:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747114734;
	bh=yRTmAPfpy3jnXnN7eOKRZtlgxzAWG2XoYobCZva0fs0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t4ZewDleZxjf9w1uSkcM4K2BPAjRDpIij5Gu1aXNIHk1klejXIeaQ7GemGHJQl5da
	 idFD1yhaLdw051If5dBc+FcMpqfwrn7NSJXAJp6pvqPqlA4Dh+CjqgmJlzNneySaq5
	 oa208skqjK+wY0AjvSdFTj7LbHNI1LLGuXQj1FoY25EITElhXjxkxXzSwhT+oTYx7b
	 +hk7n29AyosrCdXooYEeQaQLVuZlXtKdaJGi498dLzy1fbKj8Dvl+lGFjlZPeqn6RF
	 gqtq8OoSqB2I/cpsYyjQfxfY9wJwJXamERFx+gTs78WvVqgqkSlEdIyG6PMwF0QPMh
	 BVZhnlFYwyjhQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-ext4@vger.kernel.org
Subject: [PATCH 3/4] jbd2: remove journal_t argument from jbd2_chksum()
Date: Mon, 12 May 2025 22:38:08 -0700
Message-ID: <20250513053809.699974-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513053809.699974-1-ebiggers@kernel.org>
References: <20250513053809.699974-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Since jbd2_chksum() no longer uses its journal_t argument, remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/jbd2/commit.c     |  6 +++---
 fs/jbd2/journal.c    |  8 ++++----
 fs/jbd2/recovery.c   | 10 +++++-----
 include/linux/jbd2.h |  3 +--
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 1c7c49356878..7203d2d2624d 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -97,11 +97,11 @@ static void jbd2_commit_block_csum_set(journal_t *j, struct buffer_head *bh)
 
 	h = (struct commit_header *)(bh->b_data);
 	h->h_chksum_type = 0;
 	h->h_chksum_size = 0;
 	h->h_chksum[0] = 0;
-	csum = jbd2_chksum(j, j->j_csum_seed, bh->b_data, j->j_blocksize);
+	csum = jbd2_chksum(j->j_csum_seed, bh->b_data, j->j_blocksize);
 	h->h_chksum[0] = cpu_to_be32(csum);
 }
 
 /*
  * Done it all: now submit the commit record.  We should have
@@ -328,12 +328,12 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
 	if (!jbd2_journal_has_csum_v2or3(j))
 		return;
 
 	seq = cpu_to_be32(sequence);
 	addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
-	csum32 = jbd2_chksum(j, j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
-	csum32 = jbd2_chksum(j, csum32, addr, bh->b_size);
+	csum32 = jbd2_chksum(j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
+	csum32 = jbd2_chksum(csum32, addr, bh->b_size);
 	kunmap_local(addr);
 
 	if (jbd2_has_feature_csum3(j))
 		tag3->t_checksum = cpu_to_be32(csum32);
 	else
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index a5ccba25ff47..255fa03031d8 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -120,11 +120,11 @@ static __be32 jbd2_superblock_csum(journal_t *j, journal_superblock_t *sb)
 	__u32 csum;
 	__be32 old_csum;
 
 	old_csum = sb->s_checksum;
 	sb->s_checksum = 0;
-	csum = jbd2_chksum(j, ~0, (char *)sb, sizeof(journal_superblock_t));
+	csum = jbd2_chksum(~0, (char *)sb, sizeof(journal_superblock_t));
 	sb->s_checksum = old_csum;
 
 	return cpu_to_be32(csum);
 }
 
@@ -1000,11 +1000,11 @@ void jbd2_descriptor_block_csum_set(journal_t *j, struct buffer_head *bh)
 		return;
 
 	tail = (struct jbd2_journal_block_tail *)(bh->b_data + j->j_blocksize -
 			sizeof(struct jbd2_journal_block_tail));
 	tail->t_checksum = 0;
-	csum = jbd2_chksum(j, j->j_csum_seed, bh->b_data, j->j_blocksize);
+	csum = jbd2_chksum(j->j_csum_seed, bh->b_data, j->j_blocksize);
 	tail->t_checksum = cpu_to_be32(csum);
 }
 
 /*
  * Return tid of the oldest transaction in the journal and block in the journal
@@ -1490,11 +1490,11 @@ static int journal_load_superblock(journal_t *journal)
 
 	if (be32_to_cpu(sb->s_maxlen) < journal->j_total_len)
 		journal->j_total_len = be32_to_cpu(sb->s_maxlen);
 	/* Precompute checksum seed for all metadata */
 	if (jbd2_journal_has_csum_v2or3(journal))
-		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
+		journal->j_csum_seed = jbd2_chksum(~0, sb->s_uuid,
 						   sizeof(sb->s_uuid));
 	/* After journal features are set, we can compute transaction limits */
 	jbd2_journal_init_transaction_limits(journal);
 
 	if (jbd2_has_feature_fast_commit(journal)) {
@@ -2336,11 +2336,11 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 	/* If enabling v3 checksums, update superblock and precompute seed */
 	if (INCOMPAT_FEATURE_ON(JBD2_FEATURE_INCOMPAT_CSUM_V3)) {
 		sb->s_checksum_type = JBD2_CRC32C_CHKSUM;
 		sb->s_feature_compat &=
 			~cpu_to_be32(JBD2_FEATURE_COMPAT_CHECKSUM);
-		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
+		journal->j_csum_seed = jbd2_chksum(~0, sb->s_uuid,
 						   sizeof(sb->s_uuid));
 	}
 
 	/* If enabling v1 checksums, downgrade superblock */
 	if (COMPAT_FEATURE_ON(JBD2_FEATURE_COMPAT_CHECKSUM))
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index c271a050b7e6..cac8c2cd4a92 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -183,11 +183,11 @@ static int jbd2_descriptor_block_csum_verify(journal_t *j, void *buf)
 
 	tail = (struct jbd2_journal_block_tail *)((char *)buf +
 		j->j_blocksize - sizeof(struct jbd2_journal_block_tail));
 	provided = tail->t_checksum;
 	tail->t_checksum = 0;
-	calculated = jbd2_chksum(j, j->j_csum_seed, buf, j->j_blocksize);
+	calculated = jbd2_chksum(j->j_csum_seed, buf, j->j_blocksize);
 	tail->t_checksum = provided;
 
 	return provided == cpu_to_be32(calculated);
 }
 
@@ -438,11 +438,11 @@ static int jbd2_commit_block_csum_verify(journal_t *j, void *buf)
 		return 1;
 
 	h = buf;
 	provided = h->h_chksum[0];
 	h->h_chksum[0] = 0;
-	calculated = jbd2_chksum(j, j->j_csum_seed, buf, j->j_blocksize);
+	calculated = jbd2_chksum(j->j_csum_seed, buf, j->j_blocksize);
 	h->h_chksum[0] = provided;
 
 	return provided == cpu_to_be32(calculated);
 }
 
@@ -459,11 +459,11 @@ static bool jbd2_commit_block_csum_verify_partial(journal_t *j, void *buf)
 
 	memcpy(tmpbuf, buf, sizeof(struct commit_header));
 	h = tmpbuf;
 	provided = h->h_chksum[0];
 	h->h_chksum[0] = 0;
-	calculated = jbd2_chksum(j, j->j_csum_seed, tmpbuf, j->j_blocksize);
+	calculated = jbd2_chksum(j->j_csum_seed, tmpbuf, j->j_blocksize);
 	kfree(tmpbuf);
 
 	return provided == cpu_to_be32(calculated);
 }
 
@@ -476,12 +476,12 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
 
 	if (!jbd2_journal_has_csum_v2or3(j))
 		return 1;
 
 	seq = cpu_to_be32(sequence);
-	csum32 = jbd2_chksum(j, j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
-	csum32 = jbd2_chksum(j, csum32, buf, j->j_blocksize);
+	csum32 = jbd2_chksum(j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
+	csum32 = jbd2_chksum(csum32, buf, j->j_blocksize);
 
 	if (jbd2_has_feature_csum3(j))
 		return tag3->t_checksum == cpu_to_be32(csum32);
 	else
 		return tag->t_checksum == cpu_to_be16(csum32);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 023e8abdb99a..b04d554e0992 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1764,12 +1764,11 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
 #define BJ_Forget	2	/* Buffer superseded by this transaction */
 #define BJ_Shadow	3	/* Buffer contents being shadowed to the log */
 #define BJ_Reserved	4	/* Buffer is reserved for access by journal */
 #define BJ_Types	5
 
-static inline u32 jbd2_chksum(journal_t *journal, u32 crc,
-			      const void *address, unsigned int length)
+static inline u32 jbd2_chksum(u32 crc, const void *address, unsigned int length)
 {
 	return crc32c(crc, address, length);
 }
 
 /* Return most recent uncommitted transaction */
-- 
2.49.0


