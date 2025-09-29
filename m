Return-Path: <linux-ext4+bounces-10491-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C21BA9D33
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4AB97A47A6
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEF130C111;
	Mon, 29 Sep 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV8DM57G"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E230B511
	for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160599; cv=none; b=frpzr3Nf4YOSTmn7YgxlxgA1YQMSA2ayPnRxwGWlgCGEbTuHY/wTpMtKdPtfYRR/h5/orlljY+Wm8PvmWlJkYyVA16doOcFshC2AxW4dy2uj0T6GkWQLEZOaOVz+O9dsG5oA0Xy8nqwx5mbgbb3NtzhSAIS/MNP0EsoV7TDrgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160599; c=relaxed/simple;
	bh=XXdR2qmKllkIUiFxVyiinwoSt8lzNPgpEvMfu1KvICs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUdJ7YnLP+I+CPZCiNixmMCBw1SDI3H7BSMSXu6vYzK/fHXnpQJTjOFIXlyJtOeAeF1avdod7HAJn/ALcClwLxj3k5CmDhyYScC5beHAVsSQyx0EkbD4/CG0vNI1iKCZjjXQQrSmcirOWO1j17mKuVWbiDgilbzwqDbSKbrRlLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CV8DM57G; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5515eaefceso4673068a12.2
        for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759160597; x=1759765397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPiBItbq+0cpdCmjLbGa83sTferT/K96z+KmXZmPzso=;
        b=CV8DM57GIrwk1bMIU/alsPOdRF9UWNvJSN+qbYc8hRjYiSJdK8EioGgwraMplKIaZg
         27R+F4tVEIXLtSJL09UwGmG1x3EIA0EbqMWBQ8LlycH1zIyNRaKH+Zlp9F6hKm6qaM1t
         S2iR49UpT8gloSzZqF48zdOn0Wpm3Y4U+1ldn0GgAtNZDzUrxPLxqno7wYRtSc9tTt3s
         RIGldMfnqQ+UJYvGMj5iJRvfowF5kVKgypdTQeb9MOvBjowxPYSfZ6rF+FmrQC5DC1GH
         +j5k11N73m/d13z4xxZLtJn2gDoQzl8s+QQcn9NfNvVtpHeCWKUa/Uw73iPRtu3771NB
         4teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759160597; x=1759765397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPiBItbq+0cpdCmjLbGa83sTferT/K96z+KmXZmPzso=;
        b=Y/Dv6bSuP/XTGmQrve1QghkIGMChANKXgCTrQ36D7/EajqKAkbHP12/uRxZgNTxAp9
         8tFfH37a0WTzEG1MaXTxwhcgBvGd6mZnxZNGYOIRzv0bJa955kB6n4QVJPAkpDRpeQnk
         /SEnlqRSGqCBR+Cf5GiIgjP1Oum6GO8aqWHpcb9ddckdaqrhDRFLo72MT8kb9+OKYXOn
         zJQh5cv+g1jrZ1or3mSA+E3xtYoA8ALF1sIXu7sSblMgq1L8pjk8dikhy9tneiTTBX2f
         T++bPH8KWLd9Q8URkm1xxrLFKTZnoLdm0wDsI4vqDS75P+Lp//FZzbhsTRXM8Z5+tk+C
         gdJg==
X-Forwarded-Encrypted: i=1; AJvYcCX21qicHIhN3cJ3phwAELGlxY2WqGXfIoVI45sBSiyzSQgJzZPyz3igoi0Kefe2x5XrZjFHh4yNisVI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1QYBW+Hdvz7P+hs0GPnbk5xtPsDAiRWaC9LzPXMEBtcfJ8UY0
	DCoLHnMVJMybmqz5xfxbQ1n8xMZmtOX3K5SSHz9gR4+uVM1XitOQ5use
X-Gm-Gg: ASbGncvAQf3ODzWxu6a0Nvv02809DyDCbp6axfLie796+JoFV9vr11KBkjwmLwOlUD3
	0/Pjp9Uxe0i0SS4icVn3hez33GMHGBifIX1U7t4Pejj+WkSJDiqpLUbzHoAlz38q00U13Sgnczp
	g38X3rY7yXUm1IKA8H3cGdzFDajAkxBs8lVWLF2/pHvGHmp2JmbawoCfJhxe8wV5UfewaAvSDzR
	gPpusXuVjzQuY/EbfnSdDc5JodcT6kobWfJmFTpIFTttnQ8jmGGSP9juBuzLoHv9L3BqhSTTCkl
	RzD+NdZPWPvJT3nO1rUY4BrhWJ5taeKaLpBJwBqTCmIQ35BGyu+G9nK0kZ6KGKYZsG6W8iS7xPN
	A+ovz8OUfLvTEcvCbb5Ty3Jz/BuhJKwZBuxX+SfO2NudXNdolFTRnFwfQYLsbiZC1d83Aayc5Ch
	cidKc=
X-Google-Smtp-Source: AGHT+IHnMsHOcovJMUJ6Qi4QLSkrybBhjKZgB1d/wSx8HcW6ykkQWUwWVtAywMlDiFpugHNyMA91Cw==
X-Received: by 2002:a17:903:2307:b0:26c:5c03:6781 with SMTP id d9443c01a7336-27ed49b8036mr191769995ad.11.1759160596670;
        Mon, 29 Sep 2025 08:43:16 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:2b82:239a:7350:ef6b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66f3820sm132726145ad.33.2025.09.29.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:43:16 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: yi.zhang@huaweicloud.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH v2] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Date: Mon, 29 Sep 2025 21:13:08 +0530
Message-ID: <20250929154308.360315-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a BUG_ON in ext4_es_cache_extent() when opening a verity
file on a corrupted ext4 filesystem mounted without a journal.

The issue is that the filesystem has an inode with both the INLINE_DATA
and EXTENTS flags set:

    EXT4-fs error (device loop0): ext4_cache_extents:545: inode #15:
    comm syz.0.17: corrupted extent tree: lblk 0 < prev 66

Investigation revealed that the inode has both flags set:
    DEBUG: inode 15 - flag=1, i_inline_off=164, has_inline=1, extents_flag=1

This is an invalid combination since an inode should have either:
- INLINE_DATA: data stored directly in the inode
- EXTENTS: data stored in extent-mapped blocks

Having both flags causes ext4_has_inline_data() to return true, skipping
extent tree validation in __ext4_iget(). The unvalidated out-of-order
extents then trigger a BUG_ON in ext4_es_cache_extent() due to integer
underflow when calculating hole sizes.

Fix this by detecting this invalid flag combination early in ext4_iget()
and rejecting the corrupted inode.

Reported-and-tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
Suggested-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
- Instead of adding validation in ext4_find_extent(), detect the invalid
  INLINE_DATA + EXTENTS flag combination in ext4_iget() as suggested by
  Zhang Yi to avoid redundant checks in the extent lookup path

 fs/ext4/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..71fa3faa1475 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5445,6 +5445,15 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	ret = 0;
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+		ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, __func__, __LINE__, 0,
+			"inode has both inline data and extents flags");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
+
 	if (ei->i_file_acl &&
 	    !ext4_inode_block_valid(inode, ei->i_file_acl, 1)) {
 		ext4_error_inode(inode, function, line, 0,
-- 
2.43.0

