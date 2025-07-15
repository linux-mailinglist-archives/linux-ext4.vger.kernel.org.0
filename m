Return-Path: <linux-ext4+bounces-9007-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3475EB0506A
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 06:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DDE560723
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 04:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3A32D3EC0;
	Tue, 15 Jul 2025 04:39:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26122129E;
	Tue, 15 Jul 2025 04:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752554385; cv=none; b=cl14GIXNaq4d/sspKjgqgv4K3RnVpourYfP6Hoaj7c1ZNZ1XWY1cqFtgpko7/SRiHSrRVAvdZlKRP9uofMWchTF/yN0nJ9newcUtjHqr008cbV36BbkPDpgJZHWvcqjgZ9Qip70RQpS8KL7SjYmVZyOk+zeHYYNi7MdKPtvmjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752554385; c=relaxed/simple;
	bh=Q24ePcJlRc/PZAOnP+KxhNlDgKV8yujJ4wRkYwNbbnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDQQinRenRTl3nz/ogOrtRJTCJ2qC8GzDJKID3F8+WJI2q7tdDLC/n+RJ1T0RmU5f8lNelNfxRRO7Sye/Co4xSexE1wQg7qwjF726elVH7ILbS1MQYtk5PaBgk74puwleiOaX690lccccyksdP4x9/3zOQ377w/EtEZtVvtbFbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202507151239246118;
        Tue, 15 Jul 2025 12:39:24 +0800
Received: from localhost.localdomain.com (10.94.4.253) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 15 Jul 2025 12:39:23 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 1/1] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask
Date: Tue, 15 Jul 2025 12:37:26 +0800
Message-ID: <20250715043808.5808-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250715043808.5808-1-chuguangqing@inspur.com>
References: <20250715031531.1693-1-chuguangqing@inspur.com>
 <20250715043808.5808-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025715123924e3ca70ad28ab49c99074a6eec41f0c9b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Note that since FALLOC_FL_ALLOCATE_RANGE is defined as 0x00, this addition
has no functional modifications.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 fs/ext4/extents.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b43aa82c1b39..f0f9363fd9fd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4784,9 +4784,9 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		return -EOPNOTSUPP;
 
 	/* Return error if mode is not supported */
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
-		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_COLLAPSE_RANGE |
-		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_WRITE_ZEROES))
+	if (mode & ~(FALL_C_FL_ALLOCATE_RANGE | FALLOC_FL_KEEP_SIZE |
+		     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
+		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
-- 
2.43.5


