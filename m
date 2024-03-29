Return-Path: <linux-ext4+bounces-1783-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F8891D0D
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 15:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4A71F22C34
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 14:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F091BB74F;
	Fri, 29 Mar 2024 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxvmlP2C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E211BB07B;
	Fri, 29 Mar 2024 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716276; cv=none; b=lOVCni5NoKbYKWnPOvbMBDevUe3XEUPGZTKNmnCyM8pOznh3+heDYNmGp0bZ53rqugU+YNEHt74cbu1DSh5GglWHhA6VRSKPeKDcs/PCKutVBCJgZ9aydr9iBa/pYVB1V/oBzHSJmuTsr7io81PgSRuhfJm9RZoJ6CVI5tPN09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716276; c=relaxed/simple;
	bh=BbA2PMc0bpZTZ/RPCyzhPPpxAsGBuWCqa2ygXMwC5Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vf6DmFyNE4AoxvFmaCZX8DXR97JRwJBit+dxDcAnNw6R0Uvo7xzpWppNIUJgrRZ4Q3SbkSAAeFB5hKmavLJoNi3Vkl6AAKOZwOHfh+45I5jBcRJalYlFfQNbXB4G/QsCqfjuRfk/74vNG3O188jI+Axovnj+41flqoVlurblPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxvmlP2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63493C433A6;
	Fri, 29 Mar 2024 12:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716276;
	bh=BbA2PMc0bpZTZ/RPCyzhPPpxAsGBuWCqa2ygXMwC5Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PxvmlP2CYndDSgViXrDt6Lk+ZpG+Vgck2FTOJGQHroBr1PS6HHADiyUC2QqCozSur
	 O0KTeP/laYuixshHPnY5ctR5r7DXoKQP1KgF3UxV5xT1RyiTTsKUy6wN+l9RSGGWMM
	 r2V2ebSK/m31rDTXrLH9ZfN2u7O4nxF3mkfS0AYtDBH+YRNEWQnW4q6tO3nJE4+0al
	 pYhC3f4HhsnoL2G36nh1yjyJE2sBe94mK4NNzfuJCM+TRrhBdyEZteel1HXTBWy9J8
	 YntP/f0ewDMVLtw0PZuC3fbVhnKbopv1cBKDqWa3xEFPlEud03U3HBF85zcRVCOen7
	 N60A7K5VSEu6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 35/75] ext4: add a hint for block bitmap corrupt state in mb_groups
Date: Fri, 29 Mar 2024 08:42:16 -0400
Message-ID: <20240329124330.3089520-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index ea5ac2636632b..360d91845311b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3060,7 +3060,10 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
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


