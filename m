Return-Path: <linux-ext4+bounces-8763-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BEBAF096C
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 05:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EE91C2066B
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 03:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8441DF97F;
	Wed,  2 Jul 2025 03:51:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E591A4F0A
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 03:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751428263; cv=none; b=pCYG+aKE4bcgx78x0LIpVCLfxJ7mTE9+6I+fGNcmstbRMYk1ejpbDPvckOUhZKH8ZPeHaMz2T0rUmNGBvzSPX4CwLgGGIzMmqwk6woL9oA/hq7X5s/ercO1ZbiYU5o4sjmpUtUB0tTsJCQtBsShc1tLU4vLwP9ZdLtqZOtb4UAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751428263; c=relaxed/simple;
	bh=XW/LGxXKcwsfIV9H6okqsLgM4kmzK8nr+I8oG+pXG74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgzIvUqos3/h1OoV+XEaNT27SfUze/GLJdRwv3wepRhGhm/vWzE8alqjs/Zp4bWptE++nopuMIRJ3C1WWukQ/YSg5legl7M58D38tDA53+AKRUaoYPuZyWJMFFhuaM5SiSeB58/zH4k2NjYe+kbhwjX5PASUDx4N0G4lW4mkKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-121.bstnma.fios.verizon.net [108.26.156.121])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5623ooM9025204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 23:50:51 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E11852E00D5; Tue, 01 Jul 2025 23:50:49 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] fuse2fs: fix normal (non-kernel) permissions checking
Date: Tue,  1 Jul 2025 23:50:43 -0400
Message-ID: <20250702035044.47373-1-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9f69dfc4e275 ("fuse2fs: implement O_APPEND correctly") defined
a new flag, A_OK, to add support for testing whether the file is valid
for append operations.  This is relevant for the check_iflags_access()
function, but when are later testing operations mask against the inode
permissions, this new flag gets in the way and causes non-root users
attempting to create new inodes in a directory to fail.  Fix this by
masking off A_OK before doing these tests.

Fixes: 9f69dfc4e275 ("fuse2fs: implement O_APPEND correctly")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/fuse2fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index bb75d9421..d209bc790 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -687,6 +687,9 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 		return -EACCES;
 	}
 
+	/* Remove the O_APPEND flag before testing permissions */
+	mask &= ~A_OK;
+
 	/* allow owner, if perms match */
 	if (inode_uid(inode) == ctxt->uid) {
 		if ((mask & (perms >> 6)) == mask)
-- 
2.47.2


