Return-Path: <linux-ext4+bounces-9022-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5030B06BE2
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 05:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292ED179962
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 03:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547A8276020;
	Wed, 16 Jul 2025 03:04:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E7279351;
	Wed, 16 Jul 2025 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635084; cv=none; b=ozbSlMEbhlkeoc+Gtqnwz/T2OCC3RzXLnno7n/f4OaOZifEEgIihXqBtifMmZKL8fK0XRouIGWJmQL6NVZMRucdzHwscqwfQy3cbCPHnGPu0Rr6OH8+aQTfnziqm5ak2zHYzGEOADtkWg4JbcaaGtXDbhFOReWKkoELfiIEgcF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635084; c=relaxed/simple;
	bh=J3SevpmxE9JwDzhpqVldktGHqwOvIFa50/aobyVf94g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bc7HmmmSatK4C+AM9eOI8QONX0BNR8kG5RrX5t6CryQzu4gmC9XDTiuwUFBMA7g1yq5J6ZKtLkwseCPbUY0hKCzR7WxyPe7K2J1iN8d9MgvOG0JkD5XoBSzJjyCOCr0A8X7eV+oLFI6ufNhkwB7Nv5H7YEepbpdT/IFFV56Erpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202507161104358679;
        Wed, 16 Jul 2025 11:04:35 +0800
Received: from localhost.localdomain.com (10.94.16.122) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 16 Jul 2025 11:04:34 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
	Zhang Yi <yi.zhang@huawei.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH v3] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask
Date: Wed, 16 Jul 2025 11:04:20 +0800
Message-ID: <20250716030420.4528-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250716030420.4528-1-chuguangqing@inspur.com>
References: <f42f9a79-75cf-491e-bf46-5ea036cf6656@huawei.com>
 <20250716030420.4528-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025716110435112a17cce23ef016dd0104abaf7c8c24
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Add FALLOC_FL_ALLOCATE_RANGE to the set of supported fallocate mode flags.
This change improves code clarity and maintains by explicitly showing
this flag in the supported flags mask.

Note that since FALLOC_FL_ALLOCATE_RANGE is defined as 0x00, this addition
has no functional modifications.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 fs/ext4/extents.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b43aa82c1b39..46cbb8697252 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4784,9 +4784,10 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		return -EOPNOTSUPP;
 
 	/* Return error if mode is not supported */
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
-		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_COLLAPSE_RANGE |
-		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_WRITE_ZEROES))
+	if (mode & ~(FALLOC_FL_ALLOCATE_RANGE | FALLOC_FL_KEEP_SIZE |
+		     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
+		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE |
+		     FALLOC_FL_WRITE_ZEROES))
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
-- 
2.43.5


