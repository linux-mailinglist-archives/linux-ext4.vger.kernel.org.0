Return-Path: <linux-ext4+bounces-3495-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B8E93E701
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AED1C217C1
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CAB14831D;
	Sun, 28 Jul 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFNN3cho"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DF1482F6;
	Sun, 28 Jul 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181742; cv=none; b=nhV0CFTpWtsGYj1oADhi2wei9yLfraVqHEmuwnwAaEeVG3+JnPvq5/NEPyupLmY5egENN2FMr61dZJ0xrrN20HIZ7O5n+ac4LMxBLkAa+ysOhDZHc3KGPNf4CyadpvsQ7JMzUuI0VBf8X8YpBeqOKFwoFbw+j90Lepx3xa8gBfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181742; c=relaxed/simple;
	bh=1vJZegVQx77gidBVmFuFXXcj4GkCyzwfbENYHzWWvCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/l0793eIlXeDyHWKdC0M6YtEXMgDuywxTMFpchMciTAFXPipfpdJ1L8KtCusApK4YxwzPnt07PXLDil6glspX6wWZBaN8Ic1XbMVFwAVwGsHxKy7IGwWHm7q0BYqBOqFRpbal3Uw2fIp4k90zthNiatv7ok1WS9oYoRVjxYLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFNN3cho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BC8C116B1;
	Sun, 28 Jul 2024 15:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181742;
	bh=1vJZegVQx77gidBVmFuFXXcj4GkCyzwfbENYHzWWvCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFNN3choH46QV0R1cqgFvD/ybKkIa7kF8F/KvhpV7tBEAZc2nZqJy8J62kkSfgtOd
	 KLq7eIt/m0UPkauqkco6C/wVj9XN6s6cK+B+RTRe5cNTvva9Oc0AiSyjIPO1RoDd/y
	 7Xi9Ik+Mbp5Wa7yyO0P4R6xNVvhSR87L05I1wGdzy1sE/weKbtk+EaV1hRMigCodpG
	 wb9b6vSdYS7NApznzvpR9h5qSQTCuhQNEiIsTcWb+02Y67Ulc0HmgaT5tv2I23C4Ec
	 HAu6nT2TndILzZS+GAChbU8FR/Yhbw7EmcVJQQI4g9Se7OfLr8LFyhNhKA/4faTt5T
	 Fqi6HlN/G84tA==
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
Subject: [PATCH AUTOSEL 6.1 15/17] jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
Date: Sun, 28 Jul 2024 11:47:25 -0400
Message-ID: <20240728154805.2049226-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154805.2049226-1-sashal@kernel.org>
References: <20240728154805.2049226-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 3df45e4699f10..96785246d11a4 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -409,6 +409,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
+			free_buffer_head(new_bh);
 			return -ENOMEM;
 		}
 		spin_lock(&jh_in->b_state_lock);
-- 
2.43.0


