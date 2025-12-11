Return-Path: <linux-ext4+bounces-12291-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A70CB5B50
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 12:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1982E3015E2C
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 11:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4093030BBA3;
	Thu, 11 Dec 2025 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="nqPzH7E4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9A30B53F;
	Thu, 11 Dec 2025 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453943; cv=pass; b=b8a7NpOIr6M2eCqOB+ZTbcGaxpGaNutTYCudJTKIvP4U5SQNyTbnldFhM2D/6psi93LkPFMKbnwYD3le6Nxb43fl/FfXUmKW2t840BVfWLNOXgLVbZCDHxAf1eSZOMdNKh1Ofp3yOZ0TosINh0ylnxx9z/gCBZD9fF/3nChY0ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453943; c=relaxed/simple;
	bh=twfB4plazS4WvJL/P1q8iPRCkN/uIuEiWgcWA3wpIrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guQBTb2dt2MIYN3LLWB0ZhcrNvidLK6nn/RJN7oMm5J3hCS++WJKH9bUxTDvo9BRuWOlCY++D4a5flXmLk8p5As8qmhbbnQ+QDz48uASB8QnA1NIiTiV1tJDAlW1JFwM++9OfaCAtNhyPxOq2zP3ujhs02TlpF+lEzQcqRE4qgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=nqPzH7E4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1765453923; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KP1MwBEaEK4WrfPAbd16O0p6t7VhzE3bzp9rvA8QFFWqxApwPzfaounG7w2fqu6PWx5SS4oxAI6iqOXDz58ttvy1mY9RmHWp44pgF4LV6MuKykEaNSU8Lf0rZC2afIx2H3KZ59dG6XHQOtoxxDAQHck28QZssj31O/5XRizmfIA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765453923; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yaSHHyzU8BiqIAmZkb2Y/Ax90MKyBX6O15rxos4mRPg=; 
	b=h2nY39k7QJVElYEWCzYl47gW0RUNUeRRajfGXpchAkC4peDRdEP3Hgxj8XpFu3svMNA6NZymOpFinEn3WnHLipK8PW3X048WgjK/kwAgjcZnOpALjLnT+6L7tuTKjZ0c2xUsIbdCaJXvBNUwu1Cqajp/WKCHOkKpLcVoK0cR82E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765453923;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yaSHHyzU8BiqIAmZkb2Y/Ax90MKyBX6O15rxos4mRPg=;
	b=nqPzH7E4JxYdy2h7CntwpL5pE/ku1ltMdGUpgNHcrRHdlumJqfpgFykyDEXjwL01
	207K+CgBECXm5dmgxu3J5k3QNp7OE+9CVhMkRpWBVxF+yij/W5WOsCVSigWA9FEO/PG
	8UoMZ3lQp/Uv1Os7Jx6RuUUGpmyY6X+tOTXkn1OM=
Received: by mx.zohomail.com with SMTPS id 1765453920624800.3067390930065;
	Thu, 11 Dec 2025 03:52:00 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [RFC 1/5] ext4: mark inode format migration fast-commit ineligible
Date: Thu, 11 Dec 2025 19:51:38 +0800
Message-ID: <20251211115146.897420-2-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251211115146.897420-1-me@linux.beauty>
References: <20251211115146.897420-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fast commits only log operations that have dedicated replay support.
Inode format migration (indirect<->extent layout changes via
EXT4_IOC_MIGRATE or toggling EXT4_EXTENTS_FL) rewrites the block mapping
representation without going through the fast commit tracking paths.
In practice these migrations are rare and usually followed by further
updates, but mixing them into a fast commit makes the overall semantics
harder to reason about and risks replay gaps if new call sites appear.

Teach ext4 to mark the filesystem fast-commit ineligible when
ext4_ext_migrate() or ext4_ind_migrate() start their journal transactions.
This forces those transactions to fall back to a full commit, ensuring
that the entire inode layout change is captured by the normal journal
rather than partially encoded in fast commit TLVs. This change should
not affect common workloads but makes format migrations safer and easier
to reason about under fast commit.

Testing:
1. prepare:
    dd if=/dev/zero of=/root/fc.img bs=1M count=0 seek=128
    mkfs.ext4 -O fast_commit -F /root/fc.img
    mkdir -p /mnt/fc && mount -t ext4 -o loop /root/fc.img /mnt/fc
2.  Created a test file and toggled the extents flag to exercise both
    ext4_ind_migrate() and ext4_ext_migrate():
    touch /mnt/fc/migtest
    chattr -e /mnt/fc/migtest
    chattr +e /mnt/fc/migtest
3. Verified fast-commit ineligible statistics:
    tail -n 1 /proc/fs/ext4/loop0/fc_info
    "Inode format migration":       2

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/fast_commit.c       |  1 +
 fs/ext4/fast_commit.h       |  1 +
 fs/ext4/migrate.c           | 12 ++++++++++++
 include/trace/events/ext4.h |  4 +++-
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index fa66b08de999..afb28b3e52bb 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2302,6 +2302,7 @@ static const char * const fc_ineligible_reasons[] = {
 	[EXT4_FC_REASON_FALLOC_RANGE] = "Falloc range op",
 	[EXT4_FC_REASON_INODE_JOURNAL_DATA] = "Data journalling",
 	[EXT4_FC_REASON_ENCRYPTED_FILENAME] = "Encrypted filename",
+	[EXT4_FC_REASON_MIGRATE] = "Inode format migration",
 };
 
 int ext4_fc_info_show(struct seq_file *seq, void *v)
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 3bd534e4dbbf..be3b84a74c32 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -97,6 +97,7 @@ enum {
 	EXT4_FC_REASON_FALLOC_RANGE,
 	EXT4_FC_REASON_INODE_JOURNAL_DATA,
 	EXT4_FC_REASON_ENCRYPTED_FILENAME,
+	EXT4_FC_REASON_MIGRATE,
 	EXT4_FC_REASON_MAX
 };
 
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 1b0dfd963d3f..96ab95167bd6 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -449,6 +449,12 @@ int ext4_ext_migrate(struct inode *inode)
 		retval = PTR_ERR(handle);
 		goto out_unlock;
 	}
+	/*
+	 * This operation rewrites the inode's block mapping layout
+	 * (indirect to extents) and is not tracked in the fast commit
+	 * log, so disable fast commits for this transaction.
+	 */
+	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MIGRATE, handle);
 	goal = (((inode->i_ino - 1) / EXT4_INODES_PER_GROUP(inode->i_sb)) *
 		EXT4_INODES_PER_GROUP(inode->i_sb)) + 1;
 	owner[0] = i_uid_read(inode);
@@ -630,6 +636,12 @@ int ext4_ind_migrate(struct inode *inode)
 		ret = PTR_ERR(handle);
 		goto out_unlock;
 	}
+	/*
+	 * This operation rewrites the inode's block mapping layout
+	 * (extents to indirect blocks) and is not tracked in the fast
+	 * commit log, so disable fast commits for this transaction.
+	 */
+	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MIGRATE, handle);
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ret = ext4_ext_check_inode(inode);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index a374e7ea7e57..8f75d41ae5ef 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -102,6 +102,7 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_RENAME_DIR);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_FALLOC_RANGE);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_JOURNAL_DATA);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_ENCRYPTED_FILENAME);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_MIGRATE);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
 
 #define show_fc_reason(reason)						\
@@ -115,7 +116,8 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
 		{ EXT4_FC_REASON_RENAME_DIR,	"RENAME_DIR"},		\
 		{ EXT4_FC_REASON_FALLOC_RANGE,	"FALLOC_RANGE"},	\
 		{ EXT4_FC_REASON_INODE_JOURNAL_DATA,	"INODE_JOURNAL_DATA"}, \
-		{ EXT4_FC_REASON_ENCRYPTED_FILENAME,	"ENCRYPTED_FILENAME"})
+		{ EXT4_FC_REASON_ENCRYPTED_FILENAME,	"ENCRYPTED_FILENAME"}, \
+		{ EXT4_FC_REASON_MIGRATE,		"MIGRATE"})
 
 TRACE_DEFINE_ENUM(CR_POWER2_ALIGNED);
 TRACE_DEFINE_ENUM(CR_GOAL_LEN_FAST);
-- 
2.51.0


