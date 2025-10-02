Return-Path: <linux-ext4+bounces-10559-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B68BB3AD6
	for <lists+linux-ext4@lfdr.de>; Thu, 02 Oct 2025 12:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B593342042E
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Oct 2025 10:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028D130BBB3;
	Thu,  2 Oct 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is5IduLX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0B30B536
	for <linux-ext4@vger.kernel.org>; Thu,  2 Oct 2025 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401724; cv=none; b=pELE+GSSebbYaFSWZWeKYcy8EPFzGOERMrePTA/U3lQ0i4pkyWdezUnWjgWetGCtRKuAh7rmTzILgwNbZwMGQ4R2ZoDlESNvp1/f5Prj9sGnXnjS6tOl4mbOEy+F9wgM5tXnm6g09ZqVUkxMkLli6a4iYMsLNytcIgRipiaS+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401724; c=relaxed/simple;
	bh=r1Iv5PxlSFXBdk6FkJyAuWVSJJAJTI855hgQ2son99M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMf41ICl3B2bkGwD2xR7ku0BqE8glY4f06xr0lnV59z5aB9PmKRtdptEb+2K5yHzaPpuUEqclogUILQGX8DiiE/x3ZGrbGb+RxO+vmtKTotSbvN/9dd6FtbYCc+lXafnSftQV9LwOvkry+Oq9qG+fOX7DHBJyfGxhYFuoKNS+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is5IduLX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33255011eafso1004703a91.1
        for <linux-ext4@vger.kernel.org>; Thu, 02 Oct 2025 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759401721; x=1760006521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m0rfQXn18l2tTAMnF1By1OoocjO9lOTD4YqEsuU82z4=;
        b=Is5IduLXHH6wirBNF6cvQdOZNCPMAzvI8cfI5U3ereQyB2EIcl0dZvHjkctm7Z3pv/
         Let+aZYcCbVDTVm/n3ujca76ejKbVeUAcij2/dj4kGVArQcho6FyDX4FB4jZk2vWPQ9O
         Mks2Eq3FytnEXW/+XqV5AvANrNUR7k/LeshItd+QYvZzfmuNQZb+ziNmkxC1HerLLhw1
         9BMIXYbo8FHBIfb5Wlp4Vu7TnnNojqA57fQ7Mjt6rKBzrK+RN1dtxICPpsYH99miNG95
         q1tzbyO+8Wqd8r+cxcdH1nXeuX5rhgvPYFc87ippM7tWFQcxXGJosxFIbrnZOmOlhW1V
         jNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759401721; x=1760006521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0rfQXn18l2tTAMnF1By1OoocjO9lOTD4YqEsuU82z4=;
        b=KUUfaJr/snCBT5sCr2MPnGfhLyBELMV0u+Lo6OpwWr6w7mNjoA8Elp3cGqImKSO/II
         /FtTffuuYPDrQBR71yFWJdLQlA10kW4tOYpkXwv1SWXgiFpXPEczfvp0oOvqggBTa3S/
         kdhCYwrSON2Ll0ehnHkrdY35rUu6jFxevV2hmTE68YmOkFEcVVurILSUo6Vv8jMQ6JwU
         /7U5ksFX/FefDD887KRbFKk/8Ls1uuV0t88kf3Ky8ndSTZMlnhMl2YUx5pRZY7c1Jf5Y
         qr5A4OmA6bUX/uXPhBFoV4obAw4JVB2e8u9vsSr8abS5YJmBFkVy5WEHQdnFBk6rSzPs
         i8mw==
X-Gm-Message-State: AOJu0Yw13LNLcUa0fZ7bZt1q0n9HpfII4YGX8dq/+yb8s/Su4w7lLrrR
	ryPVY6uEY4BVRTqIXkngJDdRdgpt9xKf0HXu1XQMoPNm7ChiiZHCMnNU
X-Gm-Gg: ASbGnctd2lormjfWRnFA1f3SgHFsb0OevAU+hKuiEzdg7loIusmNzmjxJNGgHZc44ZC
	WIOJ9olTzbgqKN/GI9TqRi/bTpKtyq2yC+WtaKvy5C/bQ7lhWf6u5gh8HdK94e9WH08xkyrLy1m
	Msud5aMIIZzDvVyAk8FxY8X2MNdyWV0xU9gzqUSxkJ3/KHSUn37o91EU0zWPuVBXImFqlVjn2rG
	msWfxGmthDm/NXXY/frd1zKZrmf4j5oP6wF6uH2kzgwJteZH1jdZAlqn6jodz0/YqpVlbEmFkY7
	nn9pBgxLCDiGTAJrFIL9O9gugzDP+8rgFvMt5PlPXC0qBd6ZFjTT2zOKBD4Ib/yxyw2Q9B/Ffix
	QfkfNYQpjTrCWfGDQsr/RgL+P8YKBbrnA8XyFS7X8/IKjUELm6bAofLlxWkVweyEfcvVw607Nx+
	T7UjOdW6uho+Kqtrnr1dKY0toN2reGp5/s3VowlA==
X-Google-Smtp-Source: AGHT+IGQ2AWzZDPz/YAhggZ0WM3ScwDOuQ20HhIL/1AKelC3gwa3qTa+zyPA6jKSa0nR6Ejrp3NNDQ==
X-Received: by 2002:a17:90b:4d0a:b0:330:6f16:c4e0 with SMTP id 98e67ed59e1d1-339a6e94003mr9490535a91.12.1759401721223;
        Thu, 02 Oct 2025 03:42:01 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:5615:a275:dd45:da86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099af3cf6sm1714004a12.13.2025.10.02.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:42:00 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Subject: [PATCH] ext4: reject inline data flag when i_extra_isize is zero
Date: Thu,  2 Oct 2025 16:11:51 +0530
Message-ID: <20251002104151.2392385-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent use-after-free in ext4_search_dir by rejecting inodes that
claim to have inline data but have no extra inode space allocated.

ext4 inline data is stored in the extra inode space beyond the
standard 128-byte inode structure. This requires i_extra_isize to be
non-zero to provide space for the system.data xattr that stores the
inline directory entries or file data.

However, a corrupted filesystem can craft an inode with both:
- i_extra_isize == 0 (no extra space)
- EXT4_INODE_INLINE_DATA flag set (claims to use extra space)

This creates a fundamental inconsistency. When i_extra_isize is zero,
ext4_iget() skips calling ext4_iget_extra_inode(), which means the
inline xattr validation in check_xattrs() never runs. Later, when
ext4_find_inline_entry() attempts to access the inline data, it reads
unvalidated and potentially corrupt xattr structures, leading to
out-of-bounds memory access and use-after-free.

Fix this by validating in ext4_iget() that if an inode has the
EXT4_INODE_INLINE_DATA flag set, i_extra_isize must be non-zero.
This catches the corruption at inode load time before any inline
data operations are attempted.

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..d082fff675ac 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5417,6 +5417,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		if (ei->i_extra_isize == 0) {
+			if (ext4_has_inline_data(inode)) {
+				ext4_error_inode(inode, function, line, 0,
+						 "inline data flag set but i_extra_isize is zero");
+				ret = -EFSCORRUPTED;
+				goto bad_inode;
+			}
 			/* The extra space is currently unused. Use it. */
 			BUILD_BUG_ON(sizeof(struct ext4_inode) & 3);
 			ei->i_extra_isize = sizeof(struct ext4_inode) -
-- 
2.43.0


