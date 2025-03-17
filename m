Return-Path: <linux-ext4+bounces-6841-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B1DA65422
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Mar 2025 15:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F8F172AAC
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Mar 2025 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3C2441AA;
	Mon, 17 Mar 2025 14:45:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F31B18E20
	for <linux-ext4@vger.kernel.org>; Mon, 17 Mar 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222742; cv=none; b=nVi35L2Os2l4D8NFPtRLxhlJnn6lv5D9/W/K0xAqxwhiAWS4kxx384jCAObyk7xg4n1UZWKaHL1uWNSgtiIUNnk0ER2K2egB87TFhi8toWqDlo8KHEGBeXhakq+95yNJNXApblP8bR3/5+DSmFUZrClvLO5XHdJMcSVbMUwjd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222742; c=relaxed/simple;
	bh=KrnPp5lEgSUJMaJjg0dx4k5OYctkpyMbO+Xz15alWuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzxhM79w5MsnP+RtSr7bwc9Pcz4ai/Pih9e2S6OVnKFFQRRLEspm6Dk0JWzo3VEaWlYfHUuH5MhNUtZqm7w8YhbRj2sfcIIHjL7N5qFZa6qxSAij1uy83LD0OmauEuuhxlc60CMOdh46KZvmWyxziafHOL3tr6mPm7UqcfZCfRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52HEjVVG016680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 10:45:31 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 520E42E010B; Mon, 17 Mar 2025 10:45:31 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] e2fsck: fix logic bug when there are no references to an EA inode
Date: Mon, 17 Mar 2025 10:45:26 -0400
Message-ID: <20250317144526.990271-1-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a boolean logic error which, among other things, could cause
an attempt to modify an inode in e2fsck -n mode:

e2fsck 1.47.2 (1-Jan-2025)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
ext2fs_write_inode: Attempt to write to filesystem opened read-only while writing inode 14 in pass4
e2fsck: aborted

Fixes: 849a9e6e133a ("e2fsck: add more checks for ea inode consistency")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/pass4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/e2fsck/pass4.c b/e2fsck/pass4.c
index cf0cf7c47..cee3be64b 100644
--- a/e2fsck/pass4.c
+++ b/e2fsck/pass4.c
@@ -120,7 +120,7 @@ static void check_ea_inode(e2fsck_t ctx, ext2_ino_t i, ext2_ino_t *last_ino,
 		 * will get attached to lost+found so clear EA_INODE_FL.
 		 * Otherwise this is likely a spuriously set flag so clear it.
 		 */
-		if (*link_counted == 0 ||
+		if (*link_counted == 0 &&
 		    fix_problem(ctx, PR_4_EA_INODE_SPURIOUS_FLAG, &pctx)) {
 			/* Clear EA_INODE_FL (likely a normal file) */
 			inode->i_flags &= ~EXT4_EA_INODE_FL;
-- 
2.47.2


