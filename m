Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755D015EF34
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2020 18:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbgBNRqW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Feb 2020 12:46:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389347AbgBNQC0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 14 Feb 2020 11:02:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BE1206CC;
        Fri, 14 Feb 2020 16:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696146;
        bh=MkrSzaUpyiXGWZsDILQOUpHYbqHimewf164Sb99xzcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ab8ZJ8WrZ5zWSksCifvpH7fuJ2WhEcRvv16/soVuXlnKKlWgc1tpHoyBFFs231e41
         gt+OzOlKvAw+HvjIqb1qfrM7cHKX2re+xosQjDiqjZoqxUB82+ii96V6nPC1BUDlns
         inEQfBlHUj6ghDlsq1O4IddpbConUognLMxocZeI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 026/459] ext4: fix ext4_dax_read/write inode locking sequence for IOCB_NOWAIT
Date:   Fri, 14 Feb 2020 10:54:36 -0500
Message-Id: <20200214160149.11681-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ritesh Harjani <riteshh@linux.ibm.com>

[ Upstream commit f629afe3369e9885fd6e9cc7a4f514b6a65cf9e9 ]

Apparently our current rwsem code doesn't like doing the trylock, then
lock for real scheme.  So change our dax read/write methods to just do the
trylock for the RWF_NOWAIT case.
This seems to fix AIM7 regression in some scalable filesystems upto ~25%
in some cases. Claimed in commit 942491c9e6d6 ("xfs: fix AIM7 regression")

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Link: https://lore.kernel.org/r/20191212055557.11151-2-riteshh@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8d2bbcc2d8133..fd7ce3573a00a 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -40,9 +40,10 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
 
-	if (!inode_trylock_shared(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
 			return -EAGAIN;
+	} else {
 		inode_lock_shared(inode);
 	}
 	/*
@@ -190,9 +191,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
 
-	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
 			return -EAGAIN;
+	} else {
 		inode_lock(inode);
 	}
 	ret = ext4_write_checks(iocb, from);
-- 
2.20.1

