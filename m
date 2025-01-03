Return-Path: <linux-ext4+bounces-5874-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4985A00A28
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 15:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830713A33E9
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E751FA27F;
	Fri,  3 Jan 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WISCV/cc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D61FA8C4;
	Fri,  3 Jan 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912853; cv=none; b=QqFhB6sNVgY+dIE7jztvcNMOyM6KXfpeO5EhvhRh6+QEMA0H4Z9EunoKYvrmvZxSOLtt7GtGlwe+patYBi57rpOkNwX1v5pIj8OmwLyeNrzrgbHIqCtUJLkhmDLHiYjuzdFTeGYLkm0NyAW4NQN/vug+tQrj9VdMxOtWqC8QoBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912853; c=relaxed/simple;
	bh=GbLwsqH9oUwRL6Pc2UA4biiNgkL/8XPEtV8L2Ev4WTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hU3U0iT0hBbWeCmKjfYZKVJs/sr2oowuK5ZPu7IPbxtiVF8N+RfhhXFyIWWGiOWTdIVPJ1PrmpekMzziE+h7/cEcKUXH3IgIMf3xYaGYgBR7webFmWHxRbXbfdfGB5Ib/eUeBs29vQ0jLUwbVN9lWtrqq1kHj2grLu0wl97U7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=WISCV/cc; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id TiD9tWQAL3p3ETiDCt9iGm; Fri, 03 Jan 2025 14:59:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1735912779;
	bh=JYztFWXJrN5YfEs1iqnXX1n2zFtvY1sqwquOiNLljTI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WISCV/ccmDOTY2wYyiZfd6wHsVKyp2B57INkdZh2mHTywY5DG8+YzKAlvcYgmToPd
	 E80DZycaWZPA3cTIXb+QKSRb8ZDF+g7M0kDkyaPqJ+G2SJfz/tUHjgbL1ldiC+8rw7
	 u5QpPcLSHwsL3C67WvoNSYxIuQZhf49IPPDVG9PgNMns66zoWufAmHNpVjoiKDHNY5
	 7YXNWzJhdvKk3jKDhPsWAE8b9znNFBChkxvsvMUwrLkNZKLL0jG96HauEjVRKdWL/c
	 jRoqY66J9ViS2yQ+8QbP4ce9TdWd5VZcwspyR3FHUAAhFPxKZY6BVlw4OOpixT6KhE
	 J6oBw6H94rWvw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 03 Jan 2025 14:59:39 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Alex Tomas <alex@clusterfs.com>,
	Eric Sandeen <sandeen@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 1/3] ext4: Fix an error handling path in ext4_mb_init_cache()
Date: Fri,  3 Jan 2025 14:59:16 +0100
Message-ID: <3921e725586edaca611fd3de388f917e959dc85d.1735912719.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'bhs' is an un-initialized pointer.
If 'groups_per_page' == 1, 'bh' is assigned its address.

Then, in the for loop below, if we early exit, either because
"group >= ngroups" or if ext4_get_group_info() fails, then it is still left
un-initialized.

It can then be used.
NULL tests could fail and lead to unexpected behavior. Also, should the
error handling path be called, brelse() would be passed a potentially
invalid value.

Better safe than sorry, just make sure it is correctly initialized to NULL.

Fixes: c9de560ded61 ("ext4: Add multi block allocator for ext4")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

The scenario looks possible, but I don't know if it can really happen...
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b25a27c86696..ff9a124f439b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1285,7 +1285,7 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
 	ext4_group_t first_group, group;
 	int first_block;
 	struct super_block *sb;
-	struct buffer_head *bhs;
+	struct buffer_head *bhs = NULL;
 	struct buffer_head **bh = NULL;
 	struct inode *inode;
 	char *data;
-- 
2.47.1


