Return-Path: <linux-ext4+bounces-5873-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B2A00A26
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 15:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF967A1DD2
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6348C1FA257;
	Fri,  3 Jan 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="hFbRRlqQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E021C4A26;
	Fri,  3 Jan 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912848; cv=none; b=h3+5AO7Kd/ypKHBnboR2Zfa5XfI7Mwv5JBYYW6ruTs3rhaNf4ydx/7pTOzGl1z+ThEuLSyH8EVVQ87zNypwkzFu0dRPIn4YQDvkoEFkA1sB5wTIoXMJwJ9n7n9QOhpv/G4scHxpWch/ZPmtSNJ/G5DCIuudZENWzeh5viqZqGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912848; c=relaxed/simple;
	bh=yMFovUPwuzAaHme1qvx29nUi8Ijj4/3N1Wewt5M7ES4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7WmZU/ENQEcNWCydmJBJGTr2nJpDjfZcR7htAntfQIeWWSOkUaA6+zMATRKAb58ghhou/dVmZqjge1a82Tqxd+9xCECjU4tSJ21lFRolehgk0TnRt86L5s7YoFqoXHqyxe3cO7r5y5ZqPufbDr02WQ8F4GqaMRXYbRw3OC01W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hFbRRlqQ; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id TiD9tWQAL3p3ETiEEt9jLI; Fri, 03 Jan 2025 15:00:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1735912842;
	bh=wQNua6tnONCt3wvTRS1eWVRUmXd6PmeTjMxGeHHY0sU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=hFbRRlqQ0Cd3X43/ziKnQOYLA6fFAZSUpj/TyC2iEmOF7+yspLRwFCm3dOUMPgpPe
	 8bdd7Mo0LDY0Fpnk0iKrvD40gsyEkvemY86aeW+AlOPIkYqugaXDCws5k9wvp8x7K5
	 3cGR+aljzgu5eJitx8J7JXZ2Q27xs41ZbJqCamSXVLq9YAGSwi+1wId+fZyrLyL6y9
	 79i6o8+J2RJKOYabU6wqti3j9JrQVHqMskLHnAwzBTt9/5H10dkE+DZxXQiNfGY6vN
	 ymS2rSWihyZsgwuEAKIO0jD3eSJ2RYeusizSgnBP/aFOc2zkmoEvDHGrCJl6exNPjD
	 sCaaLqkR4CPww==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 03 Jan 2025 15:00:42 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 2/3] ext4: Remove some useless assignments in ext4_mb_init_cache()
Date: Fri,  3 Jan 2025 14:59:17 +0100
Message-ID: <44c2226a02f3b4edacc5875c3bbfc2d308664433.1735912719.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <3921e725586edaca611fd3de388f917e959dc85d.1735912719.git.christophe.jaillet@wanadoo.fr>
References: <3921e725586edaca611fd3de388f917e959dc85d.1735912719.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'bh' assigned an address early in the function and is not used before that.
So the initial NULL assignment can be removed.

Also, if folio_test_uptodate() fails, there is no need to set it to NULL.
'bh' being either kzalloc()'ed or assigned &bhs which is already NULL,
bh[i] is known to be already NULL.

This makes the code more consistent with the other tests above that don't
set this value to NULL.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 fs/ext4/mballoc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index ff9a124f439b..e536c0e35ca8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1286,7 +1286,7 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
 	int first_block;
 	struct super_block *sb;
 	struct buffer_head *bhs = NULL;
-	struct buffer_head **bh = NULL;
+	struct buffer_head **bh;
 	struct inode *inode;
 	char *data;
 	char *bitmap;
@@ -1330,10 +1330,9 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
 		 * which may be currently in use by an allocating task.
 		 */
 		if (folio_test_uptodate(folio) &&
-				!EXT4_MB_GRP_NEED_INIT(grinfo)) {
-			bh[i] = NULL;
+				!EXT4_MB_GRP_NEED_INIT(grinfo))
 			continue;
-		}
+
 		bh[i] = ext4_read_block_bitmap_nowait(sb, group, false);
 		if (IS_ERR(bh[i])) {
 			err = PTR_ERR(bh[i]);
-- 
2.47.1


