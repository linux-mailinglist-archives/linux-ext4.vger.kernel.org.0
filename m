Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8042299BF3
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Oct 2020 00:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410020AbgJZXyX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Oct 2020 19:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410413AbgJZXyW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Oct 2020 19:54:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE5421D7B;
        Mon, 26 Oct 2020 23:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756461;
        bh=3h/KDye+pdvR8YObW/9JDp9+11bVzKGYL211CQdRk7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvoTrD3quKQRMMLAAsMFuoLT91le/oKfCvA0SCtidoip4RKi0YAV08JtZu2o+vymv
         N0jWdzpkIwPN6eSgySoCoLGp8R4EK7bPvzv8fnJ/Urfgw0mYp/0E+wGygFUfkci6lv
         Wvo8FEgyWpv67PE4lu8+mqJsH6u9gufZr90OxSvc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 110/132] ext4: Detect already used quota file early
Date:   Mon, 26 Oct 2020 19:51:42 -0400
Message-Id: <20201026235205.1023962-110-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235205.1023962-1-sashal@kernel.org>
References: <20201026235205.1023962-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit e0770e91424f694b461141cbc99adf6b23006b60 ]

When we try to use file already used as a quota file again (for the same
or different quota type), strange things can happen. At the very least
lockdep annotations may be wrong but also inode flags may be wrongly set
/ reset. When the file is used for two quota types at once we can even
corrupt the file and likely crash the kernel. Catch all these cases by
checking whether passed file is already used as quota file and bail
early in that case.

This fixes occasional generic/219 failure due to lockdep complaint.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20201015110330.28716-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0b38bf29c07e0..04b776501aff8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5999,6 +5999,11 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 	/* Quotafile not on the same filesystem? */
 	if (path->dentry->d_sb != sb)
 		return -EXDEV;
+
+	/* Quota already enabled for this file? */
+	if (IS_NOQUOTA(d_inode(path->dentry)))
+		return -EBUSY;
+
 	/* Journaling quota? */
 	if (EXT4_SB(sb)->s_qf_names[type]) {
 		/* Quotafile not in fs root? */
-- 
2.25.1

