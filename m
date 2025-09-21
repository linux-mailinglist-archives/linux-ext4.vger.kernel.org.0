Return-Path: <linux-ext4+bounces-10324-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5033B8D408
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 05:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF3E44254F
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 03:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426CA1A9FAB;
	Sun, 21 Sep 2025 03:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnCBt/Ed"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B6288AD
	for <linux-ext4@vger.kernel.org>; Sun, 21 Sep 2025 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758424748; cv=none; b=ayy/P1C22RWm8oiLZptRAxAID37g1Qc0RYMyuO7nPinfsbFu6D9hVLSxa0ZXNTC7hlsV2j/H/oNl29Aa0dsEpNdiALo2eoAJV/qypNreXUR8gKHcNxceOYk5b+mZlSmXZMbfz1sASbQ84jwnXD4WC4RzKiVaXbCvkZw1erKYOiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758424748; c=relaxed/simple;
	bh=rkyr8El1QG9xfP3bNM8EnCzak+/eGaju9S7oTVE80mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEbeQkLTxMu6bYLuHW1JeGCleckmc4bzOek5h2tmtFEzbwDq/uD+/dTseL43jlHybWIOaRmbuUtu7P2hH9eEGhaXsyf1msChkmE0kC9SFupFJkZStq4TiWxaEvoj+zj6ezw2PcjpRNHB8KfBe53vpvOPW20u0LHi2FJAmLtCzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnCBt/Ed; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-267dff524d1so24222835ad.3
        for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 20:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758424747; x=1759029547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v27yUUCN2XYXf9kcSTCTqOJ6dqxNwwbD3lEPkBSdGvs=;
        b=fnCBt/EdagRg5MK2+9PjAWLINDPMLPzXQKuT8M/pZUlNgRgu5/INI7NvArGs/l511q
         uoO0rH7WCHGXku1AHODaafPvHhmH2tzNfYD5aTRCjV3e8HtkdZbqB9g80pro6D91v1/k
         T5R7olSajY69Vn4yaG92iEPkX8BkWlyFvx0z4nrrG0UwD0v6Jrt90MM+gNGypGV5r+3m
         I+pzhN1RjeNPK2ACUgU/paMEbbkirkI7pHbjia5dod+WR7+EOFbc0ciW1khLiCjsrWlX
         DrS4wIGF+4mhC2EEydHa3ZpN12qC6+dfQga0ssXoYsfbIvmA5udTtGJAW0wgcAVWu9Wt
         ivGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758424747; x=1759029547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v27yUUCN2XYXf9kcSTCTqOJ6dqxNwwbD3lEPkBSdGvs=;
        b=LgqjT3qdZTdsv6AbUK7BXhh1wLD9G/OMhrmIA7ywGfAHAVWIvh8FeJOrpx7NLNwUu/
         0AaSP5wXNHXjltrzz8wAO3MMt9W9rajnIYls1ZpB7dkohKMSgpWustlMzgMuiX954GHw
         Z0ksF4NlK0qpcONiET9LcZj3BE+c1s5WjH4PBuHzZTE/z2K1rrWw1FHvxCSO2M7wxZvF
         YC2eStymeZ49F3jWqfDLrZsX01qSCIacB70MQ3DgC2ZljskWOa15niCfOGSkUGo2t1J1
         2tglR6cH9IjActx/lPmZ50+CAXgP5iOCzFvEE/o3rwILW0kth/2FtR+XbWbGBaysPQAC
         fXFg==
X-Forwarded-Encrypted: i=1; AJvYcCVx9h8k/zcAT2Rk3c7Vhfap4fYXlL08t25N1yM4PaU5i3Sw1Vw6bCtXZgnbzGaeRfrSdjW475adAz7l@vger.kernel.org
X-Gm-Message-State: AOJu0YwpYY+Z//SdTV6uQ2GQzyZUc8cl5ZXXMoVXM+Xtd6vCUTRhlwt0
	DoQOn8ZpY1tma67EiQEtK7Yq6cKHvt/AAn/OjPL7FDLgmXim65Ybfw2GbsxZUsoY
X-Gm-Gg: ASbGncsy8A5diEhutNGYwwTDaMSLD05p6wsF2sJP3K/l6MOZSeaezgFhthU5aGhYjF6
	xNfMEwnl6RFUMCwhFWxh9oTE2u9fBbYV10q7gkCtkVNCy8DR3dipk6tEtzeMbtdQvYaf/15+MDm
	cj+PvXZaDRR6EeJMJGUZTzx9++LZYQYAgdyCcGSd0lPtYVFsORgIuayrBSCncZpJJ/snszmQslQ
	Q8o7pE8kIvJ0WJK73vDLmdoIUgkH8bknWGDQoMVBSSKjFKMVUsNdtz3JEB8QhztT/eFBhaeppAL
	J3OgV8KZqoRjasP87DrUi3n6J0MMFKMZQ+JkVOGsPEJJ2IeZznQsMh/3cQN1QmXbyC01X+Zd5n/
	dHvsZVLyxn7Gn8Q4sZewOgqrQ10SArYZSoZWefyRpDpT5866Fn1uE5eTQ9pWxwg0H0aBHpXgd5/
	Exe10=
X-Google-Smtp-Source: AGHT+IEx6dZmRM34rJ/St32hHEtgLOXTfv9QEALwoT9oGtWB+mIz9nrDQF0rrrNP+N7OHwsQB1rz+Q==
X-Received: by 2002:a17:903:c12:b0:252:a80c:3cc5 with SMTP id d9443c01a7336-269ba48cb1bmr90439615ad.22.1758424746727;
        Sat, 20 Sep 2025 20:19:06 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:9135:55f6:8a14:ad5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698018a9b7sm95826265ad.61.2025.09.20.20.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 20:19:06 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-ext4@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] nsfs: reject file handles with invalid inode number
Date: Sun, 21 Sep 2025 08:48:59 +0530
Message-ID: <20250921031859.833667-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Reject nsfs file handles that claim to have inode number 0, as no
legitimate namespace can have inode 0. This prevents a warning in
nsfs_fh_to_dentry() when open_by_handle_at() is called with malformed
file handles.

The issue occurs when userspace provides a file handle with valid
namespace type and ID but claims the namespace has inode number 0.
The namespace lookup succeeds but triggers VFS_WARN_ON_ONCE() when
comparing the real inode number against the impossible claim of 0.

Since inode 0 is reserved in all filesystems and no namespace can
legitimately have inode 0, we can safely reject such handles early
to prevent reaching the consistency check that triggers the warning.

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..42672cec293c 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -469,7 +469,8 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 
 	if (fh_len < NSFS_FID_SIZE_U32_VER0)
 		return NULL;
-
+	if (fid->ns_inum == 0)
+		return NULL;
 	/* Check that any trailing bytes are zero. */
 	if ((fh_len > NSFS_FID_SIZE_U32_LATEST) &&
 	    memchr_inv((void *)fid + NSFS_FID_SIZE_U32_LATEST, 0,
-- 
2.43.0


