Return-Path: <linux-ext4+bounces-3979-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6E1965837
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 09:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8825CB20B77
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E291509A0;
	Fri, 30 Aug 2024 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LzZfPMGx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD999474;
	Fri, 30 Aug 2024 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002250; cv=none; b=FUJ90aPGeNWDT/oHdivQriF/tv3gdH7CLb8o/hunuIqNmOVXW/rT7jc9i/LX5OIWVAYgLKPt0qOkICvbKyXcSbF6tgXrYBp4qP7NqOucO1EWrLT0uMXXL7unxjB8SQSNJnodHNwZl5Mgr58jBRQL4tXbgEm/YQHXqpBj4zfahvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002250; c=relaxed/simple;
	bh=3K+D8fMyMjgEjgzsQsdqG3DrghbUiUYKhUmOe+TpFCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BrGF+qPr+wV6Ek4oHLz9Y2lrEdd5CUeuuDcnYyLAO1E0jasWk71t1YoY5HFY8gzhGJyCTvQTivnHMzvLfEAsLL2kPvsTtC2QCuHjkWOVqczenWhlo72LF4Xc9DXKRweN9tqTY8pqESotPcjf8pJi+obC2EoG3sVTQCtukIj8t1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LzZfPMGx; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725002243; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=z9tmHWTbY/EZjhgw7CLORCHr65K3dDaVhrR+s/Ls9Jk=;
	b=LzZfPMGxd0TBz7gxcLeHYQAhim23NUIitBmUe+7vsFOIvan69sSXV5Tu+aql7s0cMeivwfjxk4f0Tq0n2dDriaHxV3UJAUYICsvwz/rtFBnkRVbxuUq8ulAizMBh1Z+2eOU+lJhSu486RFg7Se3U8xEdXEhED519gdzLq9NW3AI=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WDvwH7j_1725002234)
          by smtp.aliyun-inc.com;
          Fri, 30 Aug 2024 15:17:23 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ext4: Simplify if condition
Date: Fri, 30 Aug 2024 15:17:13 +0800
Message-Id: <20240830071713.40565-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The if condition !A || A && B can be simplified to !A || B.

./fs/ext4/fast_commit.c:362:21-23: WARNING !A || A && B is equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9837
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/ext4/fast_commit.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 326c16a4e51e..53a77172dc9f 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -357,9 +357,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 	}
 	spin_lock(&sbi->s_fc_lock);
 	is_ineligible = ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
-	if (has_transaction &&
-	    (!is_ineligible ||
-	     (is_ineligible && tid_gt(tid, sbi->s_fc_ineligible_tid))))
+	if (has_transaction && (!is_ineligible || tid_gt(tid, sbi->s_fc_ineligible_tid)))
 		sbi->s_fc_ineligible_tid = tid;
 	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	spin_unlock(&sbi->s_fc_lock);
-- 
2.32.0.3.g01195cf9f


