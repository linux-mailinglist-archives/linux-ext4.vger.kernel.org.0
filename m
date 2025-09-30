Return-Path: <linux-ext4+bounces-10501-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C53BAC77F
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 12:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DA53B8EE7
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53AB2F8BF7;
	Tue, 30 Sep 2025 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ5aTDp5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83812F7442
	for <linux-ext4@vger.kernel.org>; Tue, 30 Sep 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227961; cv=none; b=Zf61kHupPwt4k4JFqG64Mz+5ec8qENi72OWpiJgO3JJrqt8GcfBzgyybVz318q+drQzIkf53cg3YNyL2oVFmp6zT3/qUProOEEOewBxaCr390uJOLbigBttrHE585V0WP5QE5bGk0Oy46ODImNHnpO5SLZmFo8UkS8wXuBbOpCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227961; c=relaxed/simple;
	bh=rcjBUVQ/qzqGAPyJDjq415/OqkbFTjgHYuWY7Q7758Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6JfIX44tag2KIB74wBtpjK2vSQBitmWkeWt4lgRqVP/VSnxPZWq5Dp02JxQJuvCzd5b2tbNM/QjYn6CDXRlLLZXkxEQLwTtegClyjgZnx71l4km6BBfAB90uLa1VgA3AqyGGoaKuuMLQY0sN8FDrZfb364dMwdF2I5EHk7Bj1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZ5aTDp5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so86535455ad.2
        for <linux-ext4@vger.kernel.org>; Tue, 30 Sep 2025 03:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759227959; x=1759832759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Usj+zGMFyo0Na2GYD3pfOZ6hylAz1eRVpObNmN/MNOw=;
        b=RZ5aTDp5dw30LT4EpHWwAyQov/KSsHT4SKpkjZGBzmoUjBcMVSlCxqpqpnovhhhF4z
         35nsxBkY91Z3JaQwZBCKlYUaB3o5NgqjKGDZP3ekkbVujMHbjLvAxFmDxQ1CqDOmH5R/
         CUxrk8+4UTmLWZrYTaL7669T1V0fdlOgoBZEJVzLDo8kByJNzhSE7zJrhUnolgGeapWK
         p2QmbWmRHjrZTzoYeFdZIOHmN0bE6+kYgi7DtFLuEuUjDo6cNfecoF5hkBMRUPRTgO01
         O4jUTBm19dVvfMMDJnnB5FgHD1Zj+abIP8vku7h3+VyqxtkQBCzv1OoTTZBQbLrsAicw
         xXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759227959; x=1759832759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Usj+zGMFyo0Na2GYD3pfOZ6hylAz1eRVpObNmN/MNOw=;
        b=UDQ65G9T720rmgBMqqY/Ygq1iR1omIAjQKW0ldcVe2JWuPLw7K0v6/gS6tAmIzBPcy
         uGgDFCFDqwZ0RkAU53XbCE9U2joNPRIpGwqJykKSOSOsz3l4u/wwFZ6djE08RVBfN7lr
         +sAemkhUiSzsA92oFs7bbosj6T96pRDw1TlTRqbzfRNAKTkc+SDX2fUxEXmrP68D6BVB
         38nr6xd8+YVcLs74jzH5BwJK23jxWn30RJielE9sV8ZAluGUq0Uq0Ns4R0lijzZfo7bB
         BuPCPv1luSJBoR0neNm9JhxNZjHRD4Dbs8bPtzq2QS05jmI7zvRo0yfYmJ01dNRPeFs1
         Cr3g==
X-Forwarded-Encrypted: i=1; AJvYcCVNQ1Qbk4LftRKfkQQ6u5AAXDL6ii6+A3H/ddGhYmpuC1uLi7XXoj89rh0AAt7tYev8wOkTj8x0Oi3Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJy86CLk3+wiqeNQJcCLBuHV+Q7cQDWeDjRFC+jQ9mn2X+dAu
	MVLhwvZZz+fPFQedDg7vacN+DPQUzkntp9euSL67n/b4YetB7j84UA+AVizPSzip548=
X-Gm-Gg: ASbGncvw4slFPJWv+KOohpS6lGeyyzg83qY10ecgVA/gWIEzxJsk6fjWLA4sUzoe2JD
	HVryufBn15A8iAR0W8i4If6ReBB6FgyiutYgYdI7OCHqi+nXXi+xEqunf9TYljqzvUFFjzjto8/
	5dXoDz0Q+T9tPs9lvJF8xN/6+X+jpXq393Xb8zl9o43d2MJJv2Ovd8s9jIJDLeHhuDraIzTD67f
	89Eo58yBGlrbCJhyM5pEx3BDJ6OeCmNVF7ojhfJ8XsGyxeXTgihyxo7bmlEsqZ4HwMyXKwHg+5j
	lx0ebaVz5eHa/fhad0PDpAqZzPO63v5GU+dQYwRulaMumXfZ1ffplcA5tfTf23hF2IMrX0dh8RF
	LSQ5OoW6tcnHMtYlJH64T3SLQN6KTmjj41ARapR8nt6H66x0GmZnrH5/I12CYuaw+2xS84/ZIt2
	T6oueJk+T60QzY0kW+IeNNBysoGzWJAgXT2Is=
X-Google-Smtp-Source: AGHT+IHCbQEqQwID9i1SGsV/gT37SzgPwAgKzlUiVjvvwLB/MstniN5W45shljswpD3SsEPFWYW3IA==
X-Received: by 2002:a17:903:46c5:b0:269:87a3:43b8 with SMTP id d9443c01a7336-27ed49c7741mr229629385ad.4.1759227959040;
        Tue, 30 Sep 2025 03:25:59 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:86eb:e17:c717:ec3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bb502sm153429705ad.118.2025.09.30.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:25:58 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: yi.zhang@huaweicloud.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH v3] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Date: Tue, 30 Sep 2025 15:55:49 +0530
Message-ID: <20250930102549.311578-1-kartikey406@gmail.com>
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
Changes in v3:
- Fix code alignment and use existing function/line variables per Zhang Yi
- Keep check after ret = 0 where all inode fields are initialized, as
  i_inline_off gets set during inode initialization after ext4_set_inode_flags()

Changes in v2:
- Instead of adding validation in ext4_find_extent(), detect the invalid
  INLINE_DATA + EXTENTS flag combination in ext4_iget() as suggested by
  Zhang Yi to avoid redundant checks in the extent lookup path
---
 fs/ext4/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..5c97de5775c7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5445,6 +5445,15 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	ret = 0;
+	/* Detect invalid flag combination - can't have both inline data and extents */
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA) &&
+	    ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
+		ext4_error_inode(inode, function, line, 0,
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


