Return-Path: <linux-ext4+bounces-3500-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51AE93E761
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 18:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025F21C21145
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A36918757A;
	Sun, 28 Jul 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MawS1EWf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E458ABC;
	Sun, 28 Jul 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181871; cv=none; b=FA3pZpyk4z6sclrXSTv4EK5pxvw0FJfnxnEiTkONnPQMukXBdvC3dwgm68eZFTxB3TqM3guPFou3Ya2gAVINdnJSRBJ0Qe5JwcL8zmeZxgakkAt3b729ZvcyTFnTmUjMq/6LKDWTyKC+gHN4BqR4xFNIve9U5khZ9nTHG7CIvH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181871; c=relaxed/simple;
	bh=fG1BWjza7vx+HasoT6uIO9IERm54n4Elly/PXKrtU8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoPsfKkC8khO3VSeYSpSer9xpl2+O9aAkyZ8fC8dRPAF/GrKtcpgjHQW811DQ8ZbCvaQIguzaQkJxSolZ1X9V9xw6qB+faXanyX1hMHk0auuJfp51bXQcss87cXQryaaPXhAqwr+G7Giq4ugn5kpHfyl9+nmAl3GOeO7apn98pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MawS1EWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C128C4AF0B;
	Sun, 28 Jul 2024 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181870;
	bh=fG1BWjza7vx+HasoT6uIO9IERm54n4Elly/PXKrtU8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MawS1EWfp/nq2SSrbGiuaeb6HOo5uW4XwPcBeQRbZ6lLRnJUZTixj4ImaDPNd/B1a
	 +k+NKwCW24HMGaAnY4Tx6ERm3fyRDswQCh+gyVJJ/9Y/PWEI7+59XMtKAr/Ox58/Mz
	 LGXeXDEOUznI295PpJrZ7KeIHiN7rRmuv99ePF/nw1BGNi5XLdPkd3v9SSA1DrWMwO
	 KB6+tu0rXm8XgzSDPnke21pKBd8cN0/3DoG/wAUy8X8xLdUjO+g0MJwoKqnueeXIeI
	 bW5LPuyinTrZCDfIdpyNKAJ+klhoHJ+tj19RLAq5E5npZtS12fx+5IbqlDzdlqe+59
	 dzFFCLGJnudaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/5] jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
Date: Sun, 28 Jul 2024 11:50:58 -0400
Message-ID: <20240728155103.2050728-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728155103.2050728-1-sashal@kernel.org>
References: <20240728155103.2050728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit cc102aa24638b90e04364d64e4f58a1fa91a1976 ]

The new_bh is from alloc_buffer_head, we should call free_buffer_head to
free it in error case.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20240514112438.1269037-2-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/journal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 629928b19e487..08cff80f8c297 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -430,6 +430,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
+			free_buffer_head(new_bh);
 			return -ENOMEM;
 		}
 		jbd_lock_bh_state(bh_in);
-- 
2.43.0


