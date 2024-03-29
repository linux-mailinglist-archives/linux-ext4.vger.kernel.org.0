Return-Path: <linux-ext4+bounces-1786-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B67B891DAD
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 15:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDF31C27A19
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD629CBE6;
	Fri, 29 Mar 2024 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLEC5pl6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC48C29CBD2;
	Fri, 29 Mar 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716408; cv=none; b=AzB2CuVP+nBa7IA4EusYTnWekrC7G3k/YPmmWVlmeHkMObdZw0OvBuR9P/jfy5omgqi6r98N11g2vSVlxAGSHC8OnL/HbjXPzG4xMYYI1QBnetvh9c5Qk1ua7K/V2WG8Kowd5a0gtk/QeFBFHjUZN/ValiDud+vyqYXWSJYkyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716408; c=relaxed/simple;
	bh=OVFOLNUfRMFKkfdHpepmIgIvyckMUzJJ6xb0ntogztM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VViP5V9Ha/2sWBu/cnbMwrvqW8o8XDJtWLZVXz/Tp10L3SjROSNj0LvCjKxxRiDMtUVKRANhU9oMVKswKAM5vFyRYjRdNn6R4UK/IakXWu1OfqkAB4wnbtPoiHcjJPp3hy+zzzOcZgU1tn0O7aumMgloBkfQdqAVrzMZXj0QayU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLEC5pl6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E1CC433F1;
	Fri, 29 Mar 2024 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716407;
	bh=OVFOLNUfRMFKkfdHpepmIgIvyckMUzJJ6xb0ntogztM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLEC5pl6DHeMVkkOenxgzaSUYnFv5BQ2jiTV2WvHqjAYtuGtAzSpFIa2x3bfEtaiy
	 HctWULbPQkdv2JlJfHrl74Zd6MaW+2jqaWab9yinWUsG/Z+YfhtRZp0azxpevgjFEH
	 ohNhmFTyfxW08M7ArtRl/Ate5tuNmkracm88I+98XvW7L5Bxz/DkmqmZsfvOw6ZUPM
	 cqR/IOzjsUg6DcUwL18FTn9+RK1Ri6O0Rxp1qMeAzXAzaamaILJuOwkzjJadtSxVOi
	 p//ySpWgSWYwxdnm8kWqtCLviV9eywfQg3QYiwib6OHErIruhg8uNAm0+5H8F1+3XU
	 /Y2WPCzBvXNiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 23/52] ext4: forbid commit inconsistent quota data when errors=remount-ro
Date: Fri, 29 Mar 2024 08:45:17 -0400
Message-ID: <20240329124605.3091273-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit d8b945fa475f13d787df00c26a6dc45a3e2e1d1d ]

There's issue as follows When do IO fault injection test:
Quota error (device dm-3): find_block_dqentry: Quota for id 101 referenced but not present
Quota error (device dm-3): qtree_read_dquot: Can't read quota structure for id 101
Quota error (device dm-3): do_check_range: Getting block 2021161007 out of range 1-186
Quota error (device dm-3): qtree_read_dquot: Can't read quota structure for id 661

Now, ext4_write_dquot()/ext4_acquire_dquot()/ext4_release_dquot() may commit
inconsistent quota data even if process failed. This may lead to filesystem
corruption.
To ensure filesystem consistent when errors=remount-ro there is need to call
ext4_handle_error() to abort journal.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240119062908.3598806-1-yebin10@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 601e097e17207..274542d869d0c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6751,6 +6751,10 @@ static int ext4_write_dquot(struct dquot *dquot)
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 	ret = dquot_commit(dquot);
+	if (ret < 0)
+		ext4_error_err(dquot->dq_sb, -ret,
+			       "Failed to commit dquot type %d",
+			       dquot->dq_id.type);
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
@@ -6767,6 +6771,10 @@ static int ext4_acquire_dquot(struct dquot *dquot)
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 	ret = dquot_acquire(dquot);
+	if (ret < 0)
+		ext4_error_err(dquot->dq_sb, -ret,
+			      "Failed to acquire dquot type %d",
+			      dquot->dq_id.type);
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
@@ -6786,6 +6794,10 @@ static int ext4_release_dquot(struct dquot *dquot)
 		return PTR_ERR(handle);
 	}
 	ret = dquot_release(dquot);
+	if (ret < 0)
+		ext4_error_err(dquot->dq_sb, -ret,
+			       "Failed to release dquot type %d",
+			       dquot->dq_id.type);
 	err = ext4_journal_stop(handle);
 	if (!ret)
 		ret = err;
-- 
2.43.0


