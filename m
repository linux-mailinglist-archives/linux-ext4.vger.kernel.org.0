Return-Path: <linux-ext4+bounces-12292-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB15FCB5B62
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 12:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB4B23044693
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9730B53B;
	Thu, 11 Dec 2025 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="qijPJXYj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783530BBAB;
	Thu, 11 Dec 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453954; cv=pass; b=Rmfy9SlDrzm+3hytk4KF+yCpSybOoq/MgGdUjWu/KkYAgN41MusyaQMOGempSgDw+oqS+eACxrE+2KjOTFbVB7+E7/8cbqgv4ADOJyecPq4oZad5MYa+EdgzKxD+MjNX12q00pvYlMVyR/K56Iat5qysdXcJ2eLQmiJbnUcRndg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453954; c=relaxed/simple;
	bh=85XEeevtOSpwM1Boim97Wf6SCbBneHtUAKXqB2mSzEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlF8mh1hL+Fj/jjfesnQQg9VGvVKgzNBPjva3f9JcwG8YhRSl14YZP6o7euLHm3A2C147aIpdFpcBhbhHLTX33pzzO2sW2QGmDjt8GcVitMBhfH4cIEw3aCtmbi5ve8Bqwc0ZFvhcWFHHi3VYlkazM62oi5ywrRjsW7HnOw23N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=qijPJXYj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1765453925; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UkwISEmd0rOCt0DRWQKVcutLA4LF6uiFiL1cUsJEhYO6h/RQTneGgjY4MMTdfxZ7Xn+UhQzPs+8TdvIyHyvfOznVaLFCMYba5FRaQgqH5OlUpoaInvVfxVA+17fRuMzOINNj2T6ayW0V2/PJO7rBvB8DtImScozByGz0phZICd8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765453925; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZYsHAtlu0/Nh/4tTe93G6ofE2omOgTDyMODHn/a3bok=; 
	b=mP0qWVkb9HIvz57mbVSeeoYZhhXkBCPOmpuledJliPtpu9aAj/xqbC8DcWGexTuOjOH2ZfyLZkc5udEOb/uyhVowAFm+VfvGCGEhToJ/TYJbeq60kFXuW3/xwUdRmtOPf6mRGhmdKp7ibd+lgbnQ5W0dvb/1cuzv0UiKP2kzC8Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765453925;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZYsHAtlu0/Nh/4tTe93G6ofE2omOgTDyMODHn/a3bok=;
	b=qijPJXYjd1qq2DPJV/SG6yACjJLRAQx/BWtHPZfLhE6yIlIGG9p0WcVyVVxRxqPU
	HD+v146RQRcP8NaWSOm+tCcPYJNR/xmpplUmXq//TJSWuBAFpH9f8MPrcWJznLRTByM
	XPOhwv/C5KLvMDvNv0wz6e5dhoQS0LJQKh/jhbos=
Received: by mx.zohomail.com with SMTPS id 1765453923455759.6378657352764;
	Thu, 11 Dec 2025 03:52:03 -0800 (PST)
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
Subject: [RFC 2/5] ext4: mark fs-verity enable fast-commit ineligible
Date: Thu, 11 Dec 2025 19:51:39 +0800
Message-ID: <20251211115146.897420-3-me@linux.beauty>
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
Enabling fs-verity builds a Merkle tree and updates inode and orphan
state in ways that are not described by the fast commit replay tags.
In practice these operations are rare and usually followed by further
updates, but mixing them into a fast commit makes the overall
semantics harder to reason about and risks replay gaps if new call
sites appear.

Teach ext4 to mark the filesystem fast-commit ineligible when
ext4_end_enable_verity() starts its journal transaction.
This forces that transaction to fall back to a full commit, ensuring
that the fs-verity enable changes are captured by the normal journal
rather than partially encoded in fast commit TLVs.
This change should not affect common workloads but makes fs-verity
enable safer and easier to reason about under fast commit.

Testing:
1. prepare:
    dd if=/dev/zero of=/root/fc_verity.img bs=1M count=0 seek=128
    mkfs.ext4 -O fast_commit,verity -F /root/fc_verity.img
    mkdir -p /mnt/fc_verity && mount -t ext4 -o loop /root/fc_verity.img /mnt/fc_verity
2. Enabled fs-verity on a file and verified reason accounting:
    echo "data" > /mnt/fc_verity/verityfile
    /root/enable_verity /mnt/fc_verity/verityfile
    sync
    tail -n 1 /proc/fs/ext4/loop0/fc_info
    "fs-verity enable":     1
3. Enabled fs-verity on a second file, fsynced it, and checked that the
   ineligible commit counter is updated too:
    echo "data2" > /mnt/fc_verity/verityfile2
    /root/enable_verity /mnt/fc_verity/verityfile2
    /root/fsync_file /mnt/fc_verity/verityfile2
    sync
    /proc/fs/ext4/loop0/fc_info shows "fs-verity enable" incremented and
    fc stats ineligible increased accordingly.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/fast_commit.c       | 1 +
 fs/ext4/fast_commit.h       | 1 +
 fs/ext4/verity.c            | 2 ++
 include/trace/events/ext4.h | 4 +++-
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index afb28b3e52bb..242b69e5fe13 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2303,6 +2303,7 @@ static const char * const fc_ineligible_reasons[] = {
 	[EXT4_FC_REASON_INODE_JOURNAL_DATA] = "Data journalling",
 	[EXT4_FC_REASON_ENCRYPTED_FILENAME] = "Encrypted filename",
 	[EXT4_FC_REASON_MIGRATE] = "Inode format migration",
+	[EXT4_FC_REASON_VERITY] = "fs-verity enable",
 };
 
 int ext4_fc_info_show(struct seq_file *seq, void *v)
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index be3b84a74c32..20f65135208f 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -98,6 +98,7 @@ enum {
 	EXT4_FC_REASON_INODE_JOURNAL_DATA,
 	EXT4_FC_REASON_ENCRYPTED_FILENAME,
 	EXT4_FC_REASON_MIGRATE,
+	EXT4_FC_REASON_VERITY,
 	EXT4_FC_REASON_MAX
 };
 
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index b0acb0c50313..6115a365d491 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -231,6 +231,8 @@ static int ext4_end_enable_verity(struct file *filp, const void *desc,
 		goto cleanup;
 	}
 
+	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_VERITY, handle);
+
 	err = ext4_orphan_del(handle, inode);
 	if (err)
 		goto stop_and_cleanup;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 8f75d41ae5ef..224ab12ee83f 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -103,6 +103,7 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_FALLOC_RANGE);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_JOURNAL_DATA);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_ENCRYPTED_FILENAME);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_MIGRATE);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_VERITY);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
 
 #define show_fc_reason(reason)						\
@@ -117,7 +118,8 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
 		{ EXT4_FC_REASON_FALLOC_RANGE,	"FALLOC_RANGE"},	\
 		{ EXT4_FC_REASON_INODE_JOURNAL_DATA,	"INODE_JOURNAL_DATA"}, \
 		{ EXT4_FC_REASON_ENCRYPTED_FILENAME,	"ENCRYPTED_FILENAME"}, \
-		{ EXT4_FC_REASON_MIGRATE,		"MIGRATE"})
+		{ EXT4_FC_REASON_MIGRATE,		"MIGRATE"},	\
+		{ EXT4_FC_REASON_VERITY,		"VERITY"})
 
 TRACE_DEFINE_ENUM(CR_POWER2_ALIGNED);
 TRACE_DEFINE_ENUM(CR_GOAL_LEN_FAST);
-- 
2.51.0


