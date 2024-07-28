Return-Path: <linux-ext4+bounces-3497-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED53393E723
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 18:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C2B28174D
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0E15624B;
	Sun, 28 Jul 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHW+xovh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81054BD8;
	Sun, 28 Jul 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181795; cv=none; b=by6nQHM9E054Az5jAFy0mJym1Z7UWx4O/KMS9SJCoFJ6pSry3yX4V8UxGpoExltphUB8uLyKUxMLjfhbzS2sv5NonO5MksCWVYjoVIclHssMGJ17X8PskQ5Un49J/jNvJErDfU5eRel6EUVKtWKHg5v9G77R1b5uEUlCh7VNlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181795; c=relaxed/simple;
	bh=/zrf48grdgyhoSaSpWoyd8mKF9d/i+poAeAm95zB7Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxzW5tCQrjwKJKEJ6XPBdJ09RzV2xpTPb6Qs5Hwh6FnQmkANXnVhNeucaXtMLctqq5z9+JWmqlfFh6pT+H7fxVXB/68Dfq+YjxI2LJFZaSx/EGL/XS0v/vKpDvjR9ttAenzXb35RY2gPFjFoMlaLXn5EVDSTchKKJLRQdVtttC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHW+xovh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2DBC116B1;
	Sun, 28 Jul 2024 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181794;
	bh=/zrf48grdgyhoSaSpWoyd8mKF9d/i+poAeAm95zB7Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jHW+xovhA4fdqRj1qNXMcMo7qNyr11LUqWQa98V2rzB+LpmzS+OKJfWjshWCr66Tj
	 IWt6sbzSQNL6bQamq/RnFOVQ0129YU86mxMKgQNc5e/OscD5UN8bi1ka3IxRMa+Wod
	 XzXRAPgM7OshHMbSkTKZTuhH/joz2KWEUNBTlDcKm9JApvP92oQgOM9VuC+t/oTjTD
	 LG4JxJe5Fex14WOaAYcgA3Wc1Ji+vYFrr7rt7VhyMabMaPV5fx5IiwNVWQ3MzRPRKN
	 AtBwkACZcuMNlnw5ORU+kfXNyX8ALvpca0L2Bbjy7LJk6VNR4RVPrfUuH2pUjG3fuY
	 qrZ2tYtqWZMEQ==
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
Subject: [PATCH AUTOSEL 5.15 08/10] jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
Date: Sun, 28 Jul 2024 11:49:06 -0400
Message-ID: <20240728154927.2050160-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154927.2050160-1-sashal@kernel.org>
References: <20240728154927.2050160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index b7af1727a0160..ae59efa9e4469 100644
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


