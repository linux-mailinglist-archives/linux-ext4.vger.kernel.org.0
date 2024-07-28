Return-Path: <linux-ext4+bounces-3499-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436F493E74D
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 18:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8232280D16
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5067717F4FF;
	Sun, 28 Jul 2024 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcL7KjFg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68091741D1;
	Sun, 28 Jul 2024 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181854; cv=none; b=UdIYb8gqRiWOAogf6N6egueUGHhAM8P1CmgEV6GqZ/18Yg76QatItOiC3fb0/e2Diyf4JfxwBYY722rEt92xmBgbIsv02wWAhSH0QgSWPd3Le2GXOqXrie35Uo7m6kRecA9C+ZPQEMgZfzTl7mRAa2P7SSfouyFexsyrgR6w90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181854; c=relaxed/simple;
	bh=csiKNNnz+0hTuIhAmvUts01AN0PTwITpMea1/VNugAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eF/ij+gxb2gkR4/dp2ZN8o+5d9AALQemMIop0GbrGO6QT+T5G70tkTeA9+X6ClfYmuLRpV9Oo+CyIEW+MaRJEWCcE2cBn50crR2KRaGvMfL41MT3mIJtANdrPKsFx5qNXrgYOX4ss/zT1ELflDZkVihPqEKEzXTjR4sIoh42OgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcL7KjFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D20C4AF0B;
	Sun, 28 Jul 2024 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181854;
	bh=csiKNNnz+0hTuIhAmvUts01AN0PTwITpMea1/VNugAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcL7KjFgu/sSH+7hlxQDKsApQu/Y7VDOiSTpP9ptWzUwWI5ogzMQbx6wIgEvQ+ZUV
	 535t0GBEHDJOSXZAD7I/SrD8XJHLRSSSsc2FT/ksW9XFbMNxjcCYWaLtWGLRu8A4wu
	 bUwGa1RBatuYcphUZqL2fUH9s3PcspvkkkJmr9uryw3nHr9ckmoW+t+OPoolZxGGZg
	 ONt4ouaJ+WIYVfoOkWRWyI/Ku9y2ET8MXsWAZlMwMqzsyL5hw3VFqjIAjMlZgIK/BT
	 IU5c22KBIRU4s3bTiIxptwZ575EjszbBPUMiaakvslkNidv+bCt1P7v+XdT3Tqdhr3
	 mMXfZX5GGpfyg==
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
Subject: [PATCH AUTOSEL 5.4 4/6] jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
Date: Sun, 28 Jul 2024 11:50:36 -0400
Message-ID: <20240728155045.2050587-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728155045.2050587-1-sashal@kernel.org>
References: <20240728155045.2050587-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index 81bd7b29a10b6..cfa21c29f3123 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -408,6 +408,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
+			free_buffer_head(new_bh);
 			return -ENOMEM;
 		}
 		jbd_lock_bh_state(bh_in);
-- 
2.43.0


