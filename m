Return-Path: <linux-ext4+bounces-6864-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEABA66840
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 05:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82307A5F9D
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224D9145B24;
	Tue, 18 Mar 2025 04:24:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5D3FC3
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 04:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271840; cv=none; b=ONiHAKOlTpQsQvwh9GbQeWEZ01Gnb5VU4jsNbW9/FTMk05wgQahou3OAenDgZtAFPgX0H3vplHtqv1NLhTWNpntOQZzFQOvbY1BXcReZdP81DA5G1aDk3mwXdcgm1o+obVshgfKep+7d8YpE6cmLP4c/8dYUDy3bv0jzjdS5P0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271840; c=relaxed/simple;
	bh=+6gsmP82bIw5LQ+KCxxmDPQmyKoHIVV8zYYGPnLXnlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLQIoj9lkksNg/H+FxDTaZS9sHRCCnsNw/vkso1Gn333b9dq7aN7XHU/395XlmPfVLVAeCVHrQPBpiska1WueNH5X6fi+vXUVUHGrMio6CMKX9VACSh0/Omg7gdBWtYVj1o9Ep+6BA2IJ203cLpdLHEJ/07fuUF62Zjg/GjEROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I4Nosg022050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 00:23:50 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DE5E62E010B; Tue, 18 Mar 2025 00:23:49 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH] ext4: don't over-report free space or inodes in statvfs
Date: Tue, 18 Mar 2025 00:23:47 -0400
Message-ID: <20250318042347.1028443-1-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes an analogus bug that was fixed in xfs in commit
4b8d867ca6e2 ("xfs: don't over-report free space or inodes in
statvfs") where statfs can report misleading / incorrect information
where project quota is enabled, and the free space is less than the
remaining quota.

This commit will resolve a test failure in generic/762 which tests for
this bug.

Cc: stable@kernel.org
Fixes: 689c958cbe6b ("ext4: add project quota support")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4768770715ca..8cafcd3e9f5f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6820,22 +6820,29 @@ static int ext4_statfs_project(struct super_block *sb,
 			     dquot->dq_dqb.dqb_bhardlimit);
 	limit >>= sb->s_blocksize_bits;
 
-	if (limit && buf->f_blocks > limit) {
+	if (limit) {
+		uint64_t	remaining = 0;
+
 		curblock = (dquot->dq_dqb.dqb_curspace +
 			    dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
-		buf->f_blocks = limit;
-		buf->f_bfree = buf->f_bavail =
-			(buf->f_blocks > curblock) ?
-			 (buf->f_blocks - curblock) : 0;
+		if (limit > curblock)
+			remaining = limit - curblock;
+
+		buf->f_blocks = min(buf->f_blocks, limit);
+		buf->f_bfree = min(buf->f_bfree, remaining);
+		buf->f_bavail = min(buf->f_bavail, remaining);
 	}
 
 	limit = min_not_zero(dquot->dq_dqb.dqb_isoftlimit,
 			     dquot->dq_dqb.dqb_ihardlimit);
-	if (limit && buf->f_files > limit) {
-		buf->f_files = limit;
-		buf->f_ffree =
-			(buf->f_files > dquot->dq_dqb.dqb_curinodes) ?
-			 (buf->f_files - dquot->dq_dqb.dqb_curinodes) : 0;
+	if (limit) {
+		uint64_t	remaining = 0;
+
+		if (limit > dquot->dq_dqb.dqb_curinodes)
+			remaining = limit - dquot->dq_dqb.dqb_curinodes;
+
+		buf->f_files = min(buf->f_files, limit);
+		buf->f_ffree = min(buf->f_ffree, remaining);
 	}
 
 	spin_unlock(&dquot->dq_dqb_lock);
-- 
2.47.2


