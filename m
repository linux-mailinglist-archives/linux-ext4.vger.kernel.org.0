Return-Path: <linux-ext4+bounces-8963-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3936B02C53
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 20:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91209A40A9C
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911CE28AB07;
	Sat, 12 Jul 2025 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ozDp+laF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C676F073
	for <linux-ext4@vger.kernel.org>; Sat, 12 Jul 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752343998; cv=none; b=CxmLLIfCCzWUag6XfrxTE+etg990fJsOsTiyXGFS/feSJNT/f0GH4zONb1WMCVWWhEkXC6Q8p0gwAyAfDNS+YRYtwgsRDgD0A6JoXJ6wV4Qqp9kizAwnRZiEn32IPVtZGtuG3zUlg+xuqBND0M/aHFJkWvr/k9hS5IOGeNGJZiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752343998; c=relaxed/simple;
	bh=j4KJ5r7hwF/WsOoFrmY/3Jk+I6CtHmJb2qbSRM/cRlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqbLNC+PaPmtT3bkb98bTtMgV8Nqk7ywgRUeBd3inNNTBB3WlqdPrdmbce+qeycjubG2Ro4sPOSwFp0oDhGh5Y9GJcITD/RYh2ft7hl2rKPKFwr4BJglwnRpnQIfUVO7/YdYBDNRdLQDcC6gpTphxxb5AjcUGvGyPajgau16ayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ozDp+laF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-142.bstnma.fios.verizon.net [173.48.112.142])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56CICwNJ029950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752343980; bh=1zG/6l54IFMCXEjHWCcDdXQK7iJCTe15KdvaHvs5Wkg=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=ozDp+laFEOF9XsQ5YX6kbDc/7yzkAZUTcIYnaXy7Ryc6bLkpFAtEE3h/vpZAYn9Kj
	 ZMNRZ10iSNVC3b3U1BPV06/iFeGPtREn50fMLUwKOvJyp8/wBUFEdTVjMHe9dGcNsz
	 7+1M58FtsFVfU6vKwUP2Bw73YrX6nyqNHf+q+tzml7GvvUKVjbiwH/Psc/1oymVFq2
	 DIsvjwVKlhPkI846pKWBaZMM4q+XJcw2fifVAdIjydLp7/zxlD8kXhXYa1wkKp9f5G
	 YWnHtffLJAgy21H16b/IkskhAyfEY78P03ZQciF4XgpuD7Puv00e8hl9CeXASKY5P2
	 V3dGdc1Z3zkTA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C2BB72E00D5; Sat, 12 Jul 2025 14:12:58 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: linux-hardening@vger.kernel.org, ethan@ethancedwards.com,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/3] ext4: replace strcmp with direct comparison for '.' and '..'
Date: Sat, 12 Jul 2025 14:12:47 -0400
Message-ID: <20250712181249.434530-1-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a discussion over a proposed patch, "ext4: replace strcpy() with
'.' assignment"[1], I had asserted that directory entries in ext4 were
not NUL terminated, and hence it was safe to replace strcpy() with a
direct assignment.  As it turns out, this was incorrect.  It's true
for all all directory entries *except* for '.' and '..' where the
kernel was using strcmp() and where e2fsck actually checks and offers
to fix things if '.'  and '..' are not NUL terminated.

[1] https://lore.kernel.org/r/202505191316.JJMnPobO-lkp@intel.com

We can't change this without breaking old kernel versions, but in the
spirit of "be liberal in what you receive", use direct comparison of
de->name_len and de->name[0,1] instead of strcmp().  This has the side
benefit of reducing the compiled text size by 96 bytes on x86_64.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/namei.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a178ac229489..b82f5841c65a 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3082,7 +3082,8 @@ bool ext4_empty_dir(struct inode *inode)
 	de = (struct ext4_dir_entry_2 *) bh->b_data;
 	if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data, bh->b_size,
 				 0) ||
-	    le32_to_cpu(de->inode) != inode->i_ino || strcmp(".", de->name)) {
+	    le32_to_cpu(de->inode) != inode->i_ino || de->name_len != 1 ||
+	    de->name[0] != '.') {
 		ext4_warning_inode(inode, "directory missing '.'");
 		brelse(bh);
 		return false;
@@ -3091,7 +3092,8 @@ bool ext4_empty_dir(struct inode *inode)
 	de = ext4_next_entry(de, sb->s_blocksize);
 	if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data, bh->b_size,
 				 offset) ||
-	    le32_to_cpu(de->inode) == 0 || strcmp("..", de->name)) {
+	    le32_to_cpu(de->inode) == 0 || de->name_len != 2 ||
+	    de->name[0] != '.' || de->name[1] != '.') {
 		ext4_warning_inode(inode, "directory missing '..'");
 		brelse(bh);
 		return false;
@@ -3532,7 +3534,7 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 		if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data,
 					 bh->b_size, 0) ||
 		    le32_to_cpu(de->inode) != inode->i_ino ||
-		    strcmp(".", de->name)) {
+		    de->name_len != 1 || de->name[0] != '.') {
 			EXT4_ERROR_INODE(inode, "directory missing '.'");
 			brelse(bh);
 			*retval = -EFSCORRUPTED;
@@ -3543,7 +3545,8 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 		de = ext4_next_entry(de, inode->i_sb->s_blocksize);
 		if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data,
 					 bh->b_size, offset) ||
-		    le32_to_cpu(de->inode) == 0 || strcmp("..", de->name)) {
+		    le32_to_cpu(de->inode) == 0 || de->name_len != 2 ||
+		    de->name[0] != '.' || de->name[1] != '.') {
 			EXT4_ERROR_INODE(inode, "directory missing '..'");
 			brelse(bh);
 			*retval = -EFSCORRUPTED;
-- 
2.47.2


