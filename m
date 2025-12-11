Return-Path: <linux-ext4+bounces-12293-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F62CB5B6B
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 12:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E67E3026ABE
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 11:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044130BF64;
	Thu, 11 Dec 2025 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Xxz+8Hq+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1530130BB9D;
	Thu, 11 Dec 2025 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453966; cv=pass; b=R/MB5VvVybVUA9r0XzbbbShNTNeUX48p1b57u+KZcn1QHpg5z6iMpdVArcBGhUTxmxuS34FHd0ndohK3F2ydiwEmF9EN7htZWzrLohV81E+ttW+9s47pf0/o7UepK8j03EAsFxwAGJn/aueHpo1bJOnc1bHlOYxvpSXcSi1Vp1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453966; c=relaxed/simple;
	bh=BJiEsVsgBvPe1EE9g+BPKGivio01VW7e5T4FilSbmhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZGO+TGNMp8TyrnrT//5Y+XyhOHvlHGTVwPVRekD/h4DZUUs22bkiqvabPpk0Pty/V/8uANaVW96QAvy/h23s63hVBt6fMAjHR++BaTJ1wvsxiH3tcM5TBePq0sCoCaMONVjAZ9c3WU0VOY6whWd1RN8Nhnb3vKZVnmOfnk2p0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Xxz+8Hq+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1765453929; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JiXuc4wIoQbBeRKUf/5k31qEB4lufeQe2cjX5jVyaRW+gixb24Vgd1B3tp2J8vMAXYS/MSlCjz5IrOLdS4wKibMksbHIgiWeNDN6REZOWRTIybvvPNcpk3fgvjnO1Rp5D+kZdyS32J5Vz53/dJckekNzmukPkLBWhuHf5RgWTfA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765453929; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZiAmebCOX2a0l5Lf0sVmmghFrZEljlFpwT9BGvKl8Kw=; 
	b=ZdmDG9JpuaaGmGUMPKYBGBzZtblLQReN1oYtkjmoU4tfT1go6rrX/sjHLANXIc/436l3PeVMAk/sTwpfzGjBwr++cbOL6wpsU2EizhAqYx+HBQU4fle+Iucor5FsszZKsOtEVTxvwA9ZrxAf0Tif4/J8Lo+6b/mng7sD5M6kzHU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765453929;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZiAmebCOX2a0l5Lf0sVmmghFrZEljlFpwT9BGvKl8Kw=;
	b=Xxz+8Hq+zzzUoj/o+k1h2r4fQU1Jm4yDfMcHcXM91zEan14T1tzEAJtfK/yBMqLt
	YQa4XMVAef72HdIIUZ87iaLnwNqxJiZjCdTo541F8kT68fnDWLuESev6oP3KKTWiQLU
	MJQhHCPcLwFKPuTfvhYTMEOGHsqcTpQ7TK8u5a9o=
Received: by mx.zohomail.com with SMTPS id 176545392704675.76481354032035;
	Thu, 11 Dec 2025 03:52:07 -0800 (PST)
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
Subject: [RFC 3/5] ext4: mark move extents fast-commit ineligible
Date: Thu, 11 Dec 2025 19:51:40 +0800
Message-ID: <20251211115146.897420-4-me@linux.beauty>
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
EXT4_IOC_MOVE_EXT swaps extents between regular files and may copy
data, rewriting the affected inodes' block mapping layout without
going through the fast commit tracking paths.
In practice these operations are rare and usually followed by further
updates, but mixing them into a fast commit makes the overall
semantics harder to reason about and risks replay gaps if new call
sites appear.

Teach ext4 to mark the filesystem fast-commit ineligible for the
journal transactions used by move_extent_per_page() when
EXT4_IOC_MOVE_EXT runs.
This forces those transactions to fall back to a full commit,
ensuring that these multi-inode extent swaps are captured by the
normal journal rather than partially encoded in fast commit TLVs.
This change should not affect common workloads but makes online
defragmentation safer and easier to reason about under fast commit.

Testing:
1. prepare:
        dd if=/dev/zero of=/root/fc_move.img bs=1M count=0 seek=256
        mkfs.ext4 -O fast_commit -F /root/fc_move.img
        mkdir -p /mnt/fc_move && mount -t ext4 -o loop \
/root/fc_move.img /mnt/fc_move
2. Created two files, ran EXT4_IOC_MOVE_EXT via e4defrag, and checked
   the ineligible reason statistics:
        fallocate -l 64M /mnt/fc_move/file1
        cp /mnt/fc_move/file1 /mnt/fc_move/file2
        e4defrag /mnt/fc_move/file1
        cat /proc/fs/ext4/loop0/fc_info
   shows "Move extents": > 0 and fc stats ineligible > 0.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/fast_commit.c       | 1 +
 fs/ext4/fast_commit.h       | 1 +
 fs/ext4/move_extent.c       | 1 +
 include/trace/events/ext4.h | 4 +++-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 242b69e5fe13..0ef2154a2b1f 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2304,6 +2304,7 @@ static const char * const fc_ineligible_reasons[] = {
 	[EXT4_FC_REASON_ENCRYPTED_FILENAME] = "Encrypted filename",
 	[EXT4_FC_REASON_MIGRATE] = "Inode format migration",
 	[EXT4_FC_REASON_VERITY] = "fs-verity enable",
+	[EXT4_FC_REASON_MOVE_EXT] = "Move extents",
 };
 
 int ext4_fc_info_show(struct seq_file *seq, void *v)
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 20f65135208f..2f77a37fb101 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -99,6 +99,7 @@ enum {
 	EXT4_FC_REASON_ENCRYPTED_FILENAME,
 	EXT4_FC_REASON_MIGRATE,
 	EXT4_FC_REASON_VERITY,
+	EXT4_FC_REASON_MOVE_EXT,
 	EXT4_FC_REASON_MAX
 };
 
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 4b091c21908f..5a5e91078528 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -287,6 +287,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		*err = PTR_ERR(handle);
 		return 0;
 	}
+	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_MOVE_EXT, handle);
 
 	orig_blk_offset = orig_page_offset * blocks_per_page +
 		data_offset_in_page;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 224ab12ee83f..56e60080e759 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -104,6 +104,7 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_JOURNAL_DATA);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_ENCRYPTED_FILENAME);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_MIGRATE);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_VERITY);
+TRACE_DEFINE_ENUM(EXT4_FC_REASON_MOVE_EXT);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
 
 #define show_fc_reason(reason)						\
@@ -119,7 +120,8 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
 		{ EXT4_FC_REASON_INODE_JOURNAL_DATA,	"INODE_JOURNAL_DATA"}, \
 		{ EXT4_FC_REASON_ENCRYPTED_FILENAME,	"ENCRYPTED_FILENAME"}, \
 		{ EXT4_FC_REASON_MIGRATE,		"MIGRATE"},	\
-		{ EXT4_FC_REASON_VERITY,		"VERITY"})
+		{ EXT4_FC_REASON_VERITY,		"VERITY"},	\
+		{ EXT4_FC_REASON_MOVE_EXT,		"MOVE_EXT"})
 
 TRACE_DEFINE_ENUM(CR_POWER2_ALIGNED);
 TRACE_DEFINE_ENUM(CR_GOAL_LEN_FAST);
-- 
2.51.0


