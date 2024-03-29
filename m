Return-Path: <linux-ext4+bounces-1781-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F73891C33
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 14:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269591F21CFE
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0075147C9F;
	Fri, 29 Mar 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWVUGIPK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD31802AB;
	Fri, 29 Mar 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716092; cv=none; b=ZrPT2/q3KNCvKpZoB8DIV8907d8Wk18iyoiR76NHDIJwRE1vxmFs04U0fcmYLwX/Hx+9fScJIyiT2MJNc9mg7iHxoXJAgg3soC9IDKkHGSuzgMNbvLD7zBSS9op68sAk/Hnv/Ilhq00FAwMH5glF8jlnVRFvB5bDn95AzvLWsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716092; c=relaxed/simple;
	bh=JTtVBTjZRyZo1TDLtUH8GKP/+2mYYK4X37r/4pXMPnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlfitG3Aczm5Nfqg6YInytJEBbcloxaHDQMY5J44Wqz9mqNzE4OPhrVDJm6p+TxUeVLfkdpWClzVxfU4K/J5soZhStVRrPR0ZXhHuycJdnB2qy6kkGWm8z95HvjqjafR2fi5c3s371IhZ3amYjRbJYrVEiT+H3T01fTdbmmUaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWVUGIPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E67DC433F1;
	Fri, 29 Mar 2024 12:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716092;
	bh=JTtVBTjZRyZo1TDLtUH8GKP/+2mYYK4X37r/4pXMPnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWVUGIPKqf9DlF6HbxwxexAG1i5uwGzfuXOACrTNkFfUFolJXsjL2rjHsC4SrwcIH
	 OlIiResLICpX2l4g09+vDZ3K6BbltaTFzr05AGbQPy5GmhW9vlYPcpUItZLoZ9QY9i
	 9Qj8djeo0EIXdOo03lEQ2MumvB/TRbo2SwDPggQrtsGAlTbyfuEVpggGuFEgyrpybe
	 x6isz6wsf7LFHOqMGtYIvo6hm5ZkxVBnID0HMkOX2M89TTn23PPdbFk9pjtr4kRErL
	 YfZqgILny7EFH0AjA2ARJyh06zNFUP/doCzOt+41J4+r25pvDH7EKTtxQ9I8BEEbQM
	 8zR5CmxLbuDSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 50/98] ext4: add a hint for block bitmap corrupt state in mb_groups
Date: Fri, 29 Mar 2024 08:37:21 -0400
Message-ID: <20240329123919.3087149-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 68ee261fb15457ecb17e3683cb4e6a4792ca5b71 ]

If one group is marked as block bitmap corrupted, its free blocks cannot
be used and its free count is also deducted from the global
sbi->s_freeclusters_counter. User might be confused about the absent
free space because we can't query the information about corrupted block
groups except unreliable error messages in syslog. So add a hint to show
block bitmap corrupted groups in mb_groups.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240119061154.1525781-1-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e4f7cf9d89c45..6d0969e15d23d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3059,7 +3059,10 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 	for (i = 0; i <= 13; i++)
 		seq_printf(seq, " %-5u", i <= blocksize_bits + 1 ?
 				sg.info.bb_counters[i] : 0);
-	seq_puts(seq, " ]\n");
+	seq_puts(seq, " ]");
+	if (EXT4_MB_GRP_BBITMAP_CORRUPT(&sg.info))
+		seq_puts(seq, " Block bitmap corrupted!");
+	seq_puts(seq, "\n");
 
 	return 0;
 }
-- 
2.43.0


