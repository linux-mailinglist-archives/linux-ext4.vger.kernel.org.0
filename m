Return-Path: <linux-ext4+bounces-1164-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031B184D542
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 23:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F3F3B255E9
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29071144B47;
	Wed,  7 Feb 2024 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdVJjjMp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD45136671;
	Wed,  7 Feb 2024 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341255; cv=none; b=t1qG6w9muJDMvgLB/Jqvldt338vAVVIVJIYkpqdmuWX79fJWR7MG77oeEdVYb2bk9R88gw9BrTbXNRRMFeLULOGmCWXtNb9fWEX1KsGs3PjOpwEX7Va2J7O9dlJNkHW2EEO2Yn78cWVP8ZI2/GT/+UvYM6oCuh3BIlAdNH2SWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341255; c=relaxed/simple;
	bh=DJj16UOh/ZU0Pen103T6t6YkL9KgqLHU3MxZql0PaNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=he1mfTj1Vv5IOvqsrRnOQvZEr5iXvF9vt0sgFAhya0GXo0k1F86zdIWdwVzQJy+CTKSNCNDCrf4kD+JdDfpLRvZIJ8Y8tJkl46SvWw2WtAoYmB0AcPDwc5XDlX2AJSZ675tB3SSc7Mz2iQpXdF+7Gecp9HksQcUbOFfkma3cau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdVJjjMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68644C433C7;
	Wed,  7 Feb 2024 21:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341255;
	bh=DJj16UOh/ZU0Pen103T6t6YkL9KgqLHU3MxZql0PaNo=;
	h=From:To:Cc:Subject:Date:From;
	b=HdVJjjMpQ+czmPXJHfPDl+Mpiy0lrnBvtIjdKJ6J6ClzHmBbjcc+rHm5bTYFIshnR
	 T1vQ6sDRK4ZULG1dkkrhluItkz78k+LFIFRaHJquTSYbdeWx8wdfKYLq6lPxxAjsa6
	 TSAejc9stI6ymbkHQIn91ksEkcE0B+dBlQDKOXZoHlsj3zIld/TvNpj1O9BAyvFX71
	 MRTnXbmwDB7p/zfo0C9LvXC4kc7KvVtPcUCr0OQnUUYtBHNyfAJ3Q1xL6rXwSfNAF7
	 ADmeAnuvyNuAJK4xwM8TEadUHBMv8nCXp7lY35xoWLCXZIJaeY5j4IBYwqs9ZhUp7r
	 5ejiMB9ZbyjYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/7] ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
Date: Wed,  7 Feb 2024 16:27:25 -0500
Message-ID: <20240207212732.4627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 4530b3660d396a646aad91a787b6ab37cf604b53 ]

Determine if the group block bitmap is corrupted before using ac_b_ex in
ext4_mb_try_best_found() to avoid allocating blocks from a group with a
corrupted block bitmap in the following concurrency and making the
situation worse.

ext4_mb_regular_allocator
  ext4_lock_group(sb, group)
  ext4_mb_good_group
   // check if the group bbitmap is corrupted
  ext4_mb_complex_scan_group
   // Scan group gets ac_b_ex but doesn't use it
  ext4_unlock_group(sb, group)
                           ext4_mark_group_bitmap_corrupted(group)
                           // The block bitmap was corrupted during
                           // the group unlock gap.
  ext4_mb_try_best_found
    ext4_lock_group(ac->ac_sb, group)
    ext4_mb_use_best_found
      mb_mark_used
      // Allocating blocks in block bitmap corrupted group

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240104142040.2835097-7-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9e5aa625ab30..c1af95898aa4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1802,6 +1802,9 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		return err;
 
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
 
 	if (max > 0) {
@@ -1809,6 +1812,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
-- 
2.43.0


