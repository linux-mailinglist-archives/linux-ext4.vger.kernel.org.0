Return-Path: <linux-ext4+bounces-3493-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 723B193E6D4
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAA21F24D0F
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB9F823CE;
	Sun, 28 Jul 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkwpf//1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA5823CB;
	Sun, 28 Jul 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181640; cv=none; b=AMlxbjRiyGe4iM2Nq7dFF55H6uE27plYjuTGTOoAxaBL73F1N3NSHjhDrkM7Q5CblFa3NpM70Sf9G0ZBa5voTV3P4Ell5m9j8Nxhnl9k7qubRmaA7/thVn3jyToYHnPVbK2p557WgWgI9Qp2Hi4a8jtOZEheacH1jJcGiQ9lgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181640; c=relaxed/simple;
	bh=wnMIX6/ttRi9yvH+rlT1zSd6jkPM8ZHLvNo069UvVtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AipQhm7BlsamNOQkwy/v8d1ZSFcaTMXllhSKUbcNKaIi0vAO3MiD8olJ2cfJjy9DC4RpTBdACfWNX6MJ0bslcIDd59uC76sGcbWxRilaFWxttjsY0ytoGJ/UyUGFTyD36g9YQl8tyFMK/1uJXxFudc72PxvzPp8K+FODwz2351Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkwpf//1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AB2C32782;
	Sun, 28 Jul 2024 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181640;
	bh=wnMIX6/ttRi9yvH+rlT1zSd6jkPM8ZHLvNo069UvVtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkwpf//1pW+XFNNbQ0IDkBE1XUqADK+RyOJyZeivFhQ+2xHu2U2YT9f32uEDW4ONP
	 KUpHCQHxZqqeKllVVuTaTTQp9FK2+OJVCkCQmyF92XFKgWjrVDs3JUiBxvOuoQBW/m
	 0ofYiZBnb94D/mtLHPs/clCv1fClX+cAKfFEAhMtQwSoj10OpyOR4Qe2kSqsmav8R/
	 lZt6FFfRSF1mEr23jwuj/RmrFS9ddqU5lHPUwE/6l8qLkpCuZ3Yrdi5o+qPrmZ/SbW
	 VS5KfJJhsJl1kkAadI6bfTMIWo0VLwHefkS6IZ3ic62SFdqH+Wl8nWtiF939PZBmoO
	 4Enf9vPJrzc5Q==
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
Subject: [PATCH AUTOSEL 6.6 18/20] jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
Date: Sun, 28 Jul 2024 11:45:16 -0400
Message-ID: <20240728154605.2048490-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154605.2048490-1-sashal@kernel.org>
References: <20240728154605.2048490-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 19c69229ac6ec..dfffe79c50bcf 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -399,6 +399,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
+			free_buffer_head(new_bh);
 			return -ENOMEM;
 		}
 		spin_lock(&jh_in->b_state_lock);
-- 
2.43.0


