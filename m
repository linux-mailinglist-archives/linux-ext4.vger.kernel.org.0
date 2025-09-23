Return-Path: <linux-ext4+bounces-10362-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3FBB94443
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 07:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54333480EAD
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 05:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B37C26E16F;
	Tue, 23 Sep 2025 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELAJ9YQF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CC378F20
	for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 05:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603732; cv=none; b=ELVwmy3Bnr/Xc5fIt92y9JpEKfcgepzM0v1axcF9KkrG9Va8lit7/83D07kqvQVLhPXd/1qhu+13UUnzQ+cVXJ71cVpiYk7UYy+qxn1PW9YeN7VvY2ESUapEAJP6KEoA0UlD2Qx6G12tvg/Q85jVvcNoOyQtvjFfiunz34YpvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603732; c=relaxed/simple;
	bh=vfvHFHivXpm2GLoydUt958HZdWhXkPb1nbk7pJWOtcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M10BXsg+RcfTxiJuRgji7n5Iv+N2erlqXUxHbibMYBjyU8wEzNwbxk1huoYVzyoEzmCKdamfIpoTvhrcmfePHGFpOire1BpxgPfF6Mg+u3namqzUys7f5of5zQ/mVrQsVSoKOUimFBwxL6B3KEPTPkWZC2AGRca3Kuv8kWscbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELAJ9YQF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b55197907d1so2636038a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 22:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758603730; x=1759208530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ijvaMyHz28Wr8WMJfd+NS9yUCply/npKuLTTiTKdsaw=;
        b=ELAJ9YQFQnfGDr+nsg0+c+DTd2QKWv607oJy+3ga9JMNHSdEmvYJLM0tJT2Qrw9vCh
         4hViNxuoC+LCiUDKbQdfLEvTDdu33BRooD7+xJGJg1Dw8RP2uqdy6wm7BLIQioq4/NFA
         GK2QTMWcDsOcOD8iRfrnBJf6W3C9Kp6HxF7uIQLFEpp6GXh50R032hu8bGoBb8l0+6SS
         OGfZKvdWga9u62eDve+kHkZDdza/bBkWKWS8Ch1wyFRc6QuDFGTtZQLCOrVuOeNY8TXn
         nyUTevnCN8kK1UHRjZTWV9WoSYkq6i2BWjpvbxSqT3VraaKXPAdUIwmabjLxtDta9mZZ
         zPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758603730; x=1759208530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijvaMyHz28Wr8WMJfd+NS9yUCply/npKuLTTiTKdsaw=;
        b=emWyD/Mch3ObdiCDzsSa9Vr8pnN16RVwN0Ved/zchKpI57fMUHDp54bK/xWBtK6U/c
         AoTJbbxXXa1OeYWK0OAriSFRA30a/QBQfy1lQ3ekPwl48CTiIZCFAijZK9TaDEtUVfRn
         c7qtB9PVCdvodEGUENEIvkDf6nJZWhzbwRg7oyCx4NfAieOakaBD9eoL1Waz6Lo87ypl
         FNubfVEHT/832eNKokYbETIdFeydvVVDsIIBsPHcDrbZ0H/Z9KVh9ImTCm5yDkf8jn93
         OfLqACY/sqZaNNBQIdO/ztDBltnQSC295ygADDWFU8RGymckkyeod6Uibzu30hsMOF35
         dLEA==
X-Gm-Message-State: AOJu0YzaDTAIe2ypy7qXQMQeTEQeT7OoPLq1zXhiQElJXp4Jdf61HNJK
	jdxslxkmkIh1rKlhKTTzDUaeBy3Il/tg9F/JpzLIENppLJ4DGX7/zbft
X-Gm-Gg: ASbGncuJPDB9PHJQYGq/mQ6TQMDsAYefUHoHT/83eQNA9c5IYkbrNXYu140ep9Oylla
	+FN/lQ8UrNBG7tmHcj+dqWASpm+x+nHCzi47pHKnkmNrwfYfTF2gr8iN+qXlefmIBfVIquffMDZ
	2czJ5FQFhnG56pQYikt1wsF9t2epdl5rOHCWXwn6Ik3Vk4gATDfPh+MnSN2NIDGnGgmvENzPlVN
	hJrvYU2NzBMkeZ/CZtnoSmPh1GHUTMSAZAvx/f55q3d+IVj4qclZHA8oDvbWqFXcA6eWwfJ969s
	hvXf+WDthnsbUZp5UeK+v8x1yUI6h7HpWbvOC1+xs7e6d1/OXEadjESRlbWmBjt2Ys1VDgqabsj
	cGy/wNtjDxsebEoTBNUNsrYOs2QGiF2GYAgSVh04XkHNwmCjY6zxDa+Wr95OkoVRB0cno0r69uf
	iiaQebXRbHhaiYcg==
X-Google-Smtp-Source: AGHT+IHOhPABf3Rr+hi67v7au+4lS24Va9ve3+NZkk5kHyaUUBFrqMr5EAbsQhsBZIXsyn76OjknOA==
X-Received: by 2002:a17:90a:d407:b0:32e:7270:94aa with SMTP id 98e67ed59e1d1-332a95c6dbamr1609347a91.19.1758603729747;
        Mon, 22 Sep 2025 22:02:09 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:e2e5:573d:ece2:1f90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb7c3bbsm14372716b3a.7.2025.09.22.22.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 22:02:09 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Cc: linux-ext4@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] ext4: skip inode expansion on  readonly filesystems
Date: Tue, 23 Sep 2025 10:32:02 +0530
Message-ID: <20250923050202.1078052-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


Fix WARNING in ext4_xattr_block_set() during orphan cleanup on readonly
filesystems when debug_want_extra_isize mount option is used.
The issue occurs when ext4_try_to_expand_extra_isize() attempts to modify
inodes on readonly filesystems during orphan cleanup, leading to warnings
when encountering invalid xattr entries. Add a readonly check to skip
expansion in this case.

Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..ff51a4567c4f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6345,7 +6345,8 @@ static int __ext4_expand_extra_isize(struct inode *inode,
 	unsigned int inode_size = EXT4_INODE_SIZE(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	int error;
-
+	if (sb_rdonly(inode->i_sb))
+		return 0;
 	/* this was checked at iget time, but double check for good measure */
 	if ((EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize > inode_size) ||
 	    (ei->i_extra_isize & 3)) {
@@ -6403,6 +6404,8 @@ static int ext4_try_to_expand_extra_isize(struct inode *inode,
 					  struct ext4_iloc iloc,
 					  handle_t *handle)
 {
+	if (sb_rdonly(inode->i_sb))
+		return 0;
 	int no_expand;
 	int error;
 
-- 
2.43.0


