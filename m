Return-Path: <linux-ext4+bounces-3498-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBBC93E736
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 18:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FF01F25CAE
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FC615B111;
	Sun, 28 Jul 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsefMZX9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673E15ADB3;
	Sun, 28 Jul 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181832; cv=none; b=Np9FnnoJY5rsxTHQALkIEqBQMoqWanrwO0Q9Yyt+tcy/Nh9rI5Oq90qQFnm4D4P0McuTppcSoRyCc9OsVSgAZYRBAXsfoCHdTjUvUdULABt+TfG9ryos70sLzOiQQsircAeQESWg0us7XQ3bhHFHge6i+ajVSbXMRoZlgzYSWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181832; c=relaxed/simple;
	bh=Zti9cPJZ9ZYMtBT26KZ9NNRqv4hIsCmIQqRhCjV77H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI6IdNgHzH2M0boZkY/foqp9B30aSlhwigrLz4l6YWE75N/DSGomPa81LwwaFw+4iLJXEiMq7TOAIMj/t9HCwkq0nDlfeKtu50wESGRSNA9R+gVynZU7PunBvPyEfKo9NXmfKxcJGo5kY8dMExs+IZHlR9nz74PdCXlD2d4syyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsefMZX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56A7C4AF0A;
	Sun, 28 Jul 2024 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181832;
	bh=Zti9cPJZ9ZYMtBT26KZ9NNRqv4hIsCmIQqRhCjV77H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsefMZX9JPEjnR7k78n+uBLqnnTApj8Y4gfSOT2zD7VxEIzkmYo+UEKgFecRHau0v
	 l/8Jr777AukdBse5mMfsf1BWEboYk4VRI8EgelNACZNSjjB/Aaz6Z9MsI+3nR1MkJE
	 78om/Fy84We1FIRTuXVfG97HFffMigfgLPZ/LjsqiEjBXWGV+arXZLD9BjXIeZM9ib
	 FHEkWZqVfB5gs6t6xIQqBg+VZPHULAsm/3HrkB4LwqPPz5yN0HzVzshi9mupqlAm6l
	 7a+COdda+CUmevhbej/mxhM/JIkjjhXP7DdIoQ+0PHE8oXfHuEI9TgtY9SglBO97ql
	 qIyGToqpUTQTA==
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
Subject: [PATCH AUTOSEL 5.10 5/7] jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
Date: Sun, 28 Jul 2024 11:49:59 -0400
Message-ID: <20240728155014.2050414-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728155014.2050414-1-sashal@kernel.org>
References: <20240728155014.2050414-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index effd837b8c1ff..77d2de0218406 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -412,6 +412,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
+			free_buffer_head(new_bh);
 			return -ENOMEM;
 		}
 		spin_lock(&jh_in->b_state_lock);
-- 
2.43.0


