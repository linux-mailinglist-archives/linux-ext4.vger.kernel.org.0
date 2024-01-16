Return-Path: <linux-ext4+bounces-799-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1D82E6D0
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 02:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D83F1F23635
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 01:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06CF2030B;
	Tue, 16 Jan 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcD5G+Fk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7E200D4;
	Tue, 16 Jan 2024 01:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F3CC433F1;
	Tue, 16 Jan 2024 01:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367163;
	bh=2uu1Gfey0IadoREjMYuzfcwybdUfsdVQpTWCGZAt6EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcD5G+FkfbfV9rV4R5wSvRtPHQ3/6tAgj0Mz+6gyAi0KNVA2K1Kn1h4pNBSoQVwsg
	 j8RNz93EnpICijA68IUfYSdQb+XkRddvE1E7ZVi6LlYfAzGXwRSEgsySm5HwXaEWPh
	 DU4sQ9CaLOoqZa/wn7kvbvywale1SE6ohIyoWflZ8GspQp6YN0EZWAwGKdjQZbbTiO
	 5sbj7paztVsgTe74Y3qHFftQ3Oa38+Sr2bnh8fZRRMilTYeLU+ZvXTjrDzBvyc80hD
	 B6AfxqGdTz7pkOlqxZBO41zoJnKFsjKW1woHhP36vErqsgvtbztLxJbn5KA3aBwLu2
	 CxTYYkLNZMgwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/19] ext4: treat end of range as exclusive in ext4_zero_range()
Date: Mon, 15 Jan 2024 20:05:06 -0500
Message-ID: <20240116010532.218428-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010532.218428-1-sashal@kernel.org>
References: <20240116010532.218428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit 92573369144f40397e8514440afdf59f24905b40 ]

The call to filemap_write_and_wait_range() assumes the range passed to be
inclusive, so fix the call to make sure we follow that.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/e503107a7c73a2b68dec645c5ad798c437717c45.1698856309.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 4d8496d1a8ac..4c3e2f38349d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4522,7 +4522,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	 * Round up offset. This is not fallocate, we need to zero out
 	 * blocks, so convert interior block aligned part of the range to
 	 * unwritten and possibly manually zero out unaligned parts of the
-	 * range.
+	 * range. Here, start and partial_begin are inclusive, end and
+	 * partial_end are exclusive.
 	 */
 	start = round_up(offset, 1 << blkbits);
 	end = round_down((offset + len), 1 << blkbits);
@@ -4608,7 +4609,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		 * disk in case of crash before zeroing trans is committed.
 		 */
 		if (ext4_should_journal_data(inode)) {
-			ret = filemap_write_and_wait_range(mapping, start, end);
+			ret = filemap_write_and_wait_range(mapping, start,
+							   end - 1);
 			if (ret) {
 				filemap_invalidate_unlock(mapping);
 				goto out_mutex;
-- 
2.43.0


