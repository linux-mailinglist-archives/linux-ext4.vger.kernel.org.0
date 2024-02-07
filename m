Return-Path: <linux-ext4+bounces-1149-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1B84D420
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423BE284BCD
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 21:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC34912E1F8;
	Wed,  7 Feb 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOC1LO9p"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C94A127B45;
	Wed,  7 Feb 2024 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341020; cv=none; b=NmL79GO4KpZsfcUZ+98TWvi1Hni0SapRBOyQvcAopXKNF8eUM/VEE63wfrls3eYFZZ5nQZqZyOa6KgKC9Y95LbxyTngygmVyGkx/W1WJ/A8EFCYyHsbzJiGRbi0m/MZdoEg77gNOY8KXzLPGCNoJG9cCM1l0ogPB9qF4dCkvIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341020; c=relaxed/simple;
	bh=Dm7h8orkgyXc4TDkV9GPoF/y1lKbemV5Qfj+IzwZ3UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2bNXHEEVEWleIa776PEdUJ1hLnSto/sJSWwsxMpO2BeGllt3WLXNwLdzibQvXtyYJSVmfaY1k6UkoqYoOh40FQG1Dia20glZfqOL7kkISYhVsTERhIVuYdgOjdBdol7A8nAWT8xHvvPfxiAgwTdp6UHjMjvAUfucubhYdish7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOC1LO9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F359AC433C7;
	Wed,  7 Feb 2024 21:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341020;
	bh=Dm7h8orkgyXc4TDkV9GPoF/y1lKbemV5Qfj+IzwZ3UY=;
	h=From:To:Cc:Subject:Date:From;
	b=bOC1LO9px8aZv1X3fasnCfPj1xWgi7GxC7V0x40pzyPHhxNrGvrqkQlOtq5Z8sh+k
	 hTE8VTh/v0oxkjmTB12gXgp6d9XkkcU/N90vx0A5+SiD8o3hN8B649WvO1fFai09x6
	 aduFhhrwl66umJ/45AysJ/0SeY/MsWvPdc1iKN4dsPPjn8P376S/vT2pLM93c2DW2m
	 FNq1qGFCuDD4d4ykpJKRupw4wkLmtB/3vbPa/aYgyu83/pO/X3wCHXpvM2QVZrghU1
	 lYttNgrSHilX7W27iXk98oNL8COMxf67I/HiKrcdd4E3d9M/oAfNcZJOmI4L6uDbIm
	 QB2s77J0s5Oug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/38] ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
Date: Wed,  7 Feb 2024 16:22:47 -0500
Message-ID: <20240207212337.2351-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 993bf0f4c393b3667830918f9247438a8f6fdb5b ]

Determine if bb_fragments is 0 instead of determining bb_free to eliminate
the risk of dividing by zero when the block bitmap is corrupted.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240104142040.2835097-6-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9a4b73485ded..f74a8f144a66 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -841,7 +841,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int new_order;
 
-	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
+	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_fragments == 0)
 		return;
 
 	new_order = mb_avg_fragment_size_order(sb,
-- 
2.43.0


