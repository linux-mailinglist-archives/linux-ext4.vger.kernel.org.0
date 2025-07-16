Return-Path: <linux-ext4+bounces-9019-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AEDB06BAA
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 04:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DB91AA20F7
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jul 2025 02:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853E264A90;
	Wed, 16 Jul 2025 02:28:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950E12E36EF;
	Wed, 16 Jul 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632926; cv=none; b=Tlin247/uXPLzmU1Nz0qG+hfGrAvUQdwwBuGLhZDf4X6uLG8Ho7OGCQlwIX/eGjAokkacXvejGE2T+mKhXnoB7u0Izv8yeR3A7fiUpZeDADXlKYyTn+BTX/JnW54BEtIG7lNXzghGpVs72CIvCVP4OFdSJg+KgeBIH/mfUwJGBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632926; c=relaxed/simple;
	bh=BHCvgNEJRgr3YoualzTryrHfWy6Y60ZR4yPFhKbV4ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdZeKfML+vMw7GC97BlKUJ6XgDMWXO+qt8eqn3yt7jhmcWkDmIk7ItW4byf2boavhPSG3kqFN5SXivAvu7bg0cBiSKrMg/IzPhBQ1jpvkjHTUOXUneq32jw9UhlLdglnrW9bL48s01Di96f9oiRPBdiqdDSCV+6/1Na3CTw7CDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202507161028296392;
        Wed, 16 Jul 2025 10:28:29 +0800
Received: from localhost.localdomain.com (10.94.16.122) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.57; Wed, 16 Jul 2025 10:28:28 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH v2 1/1] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags mask
Date: Wed, 16 Jul 2025 10:28:22 +0800
Message-ID: <20250716022822.2434-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250716022822.2434-1-chuguangqing@inspur.com>
References: <20250715123454.GD74698@mit.edu>
 <20250716022822.2434-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025716102829d70463f581c9a32fa26f6ad2ac3b14ec
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
 fs/ext4/extents.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b43aa82c1b39..411223c10553 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4784,9 +4784,9 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		return -EOPNOTSUPP;
 
 	/* Return error if mode is not supported */
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
-		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_COLLAPSE_RANGE |
-		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_WRITE_ZEROES))
+	if (mode & ~(FALLOC_FL_ALLOCATE_RANGE | FALLOC_FL_KEEP_SIZE |
+		     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
+		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
-- 
2.43.5


