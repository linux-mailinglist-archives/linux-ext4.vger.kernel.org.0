Return-Path: <linux-ext4+bounces-9001-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0435EB04E92
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 05:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0043B3663
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 03:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1432D0C80;
	Tue, 15 Jul 2025 03:17:11 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF480B;
	Tue, 15 Jul 2025 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752549431; cv=none; b=dASnZYy3B3+waBYblQd1C5YJ2k7s9XlrZpaTqSraIgTer4dVZQNuhy0dZPwDAqpeNQ8CBS1v8LKC/OiCclAyPeSvHMx4h1XZgAFEQALQaAwOexwzECpi3M23B2gHqLmyM0n4uvuTzBV/zV8afO7JuI8isZNv1CHuR8Q7WObwq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752549431; c=relaxed/simple;
	bh=Q24ePcJlRc/PZAOnP+KxhNlDgKV8yujJ4wRkYwNbbnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoubYpESaKCYPo2pElZ1FGaDeMOk/at0w9UNzKHK21+zrmWD+NGF7/+iFrQVAEKcf2oEu45MkPwwo2sFyLuWCwrUi8KsYUuAC6qc6lkPxgtvGozyegPoeYaxrPii/HfbnTgcd4vuABbBIsoeNSjvsoCApHn/sBNmzp8/YAkKie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202507151116460058;
        Tue, 15 Jul 2025 11:16:46 +0800
Received: from localhost.localdomain.com (10.94.4.253) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 15 Jul 2025 11:16:46 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 1/1] Add FALLOC_FL_ALLOCATE_RANGE to the set of supported fallocate mode flags. This change improves code clarity and maintains by explicitly showing this flag in the supported flags mask.
Date: Tue, 15 Jul 2025 11:15:31 +0800
Message-ID: <20250715031531.1693-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250715031531.1693-1-chuguangqing@inspur.com>
References: <20250715031531.1693-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 202571511164649feef3a06f8a0147123b23b9cccb5ec
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


