Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CE13490C3
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Mar 2021 12:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhCYLin (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Mar 2021 07:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230452AbhCYL0J (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 25 Mar 2021 07:26:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 283A961A41;
        Thu, 25 Mar 2021 11:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616671566;
        bh=ZWktURx+diRaZI81AgzD0TpHpviQJZe6bVOZYp5IsKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qi9uGGIjrAd2aF/sSbkfjoZOoRk5PGkbk2tSdv4VQalhFULQEyEFZBmXlMZ2fPauH
         SK1+t2M4G9QzvOdIwVKOWlkCeoH38QfniRnuXzxgFyA0sSqnUOxtKSzXPMFv5GKHNH
         f6Je3WsnxrZIgexTpe6uwaXUDAXQo35EAEcnIo/JLsh4dFQ+xOuFTIqd6QIp5uz2mL
         tVgn4CFQynVyzbqPcImBxovHkL1+Ramho1koTrtLjEulzwvFUrRNpL813a+pkjzDDJ
         FrStkmM5CwqeQBf9TBew0dRd/evBar6cQRHKfuLETQEN1vmzLnnfbkr2x3fR9xq8fk
         mxSm/U6mIh3hw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhaolong Zhang <zhangzl2013@126.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/39] ext4: fix bh ref count on error paths
Date:   Thu, 25 Mar 2021 07:25:24 -0400
Message-Id: <20210325112558.1927423-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112558.1927423-1-sashal@kernel.org>
References: <20210325112558.1927423-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhaolong Zhang <zhangzl2013@126.com>

[ Upstream commit c915fb80eaa6194fa9bd0a4487705cd5b0dda2f1 ]

__ext4_journalled_writepage should drop bhs' ref count on error paths

Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
Link: https://lore.kernel.org/r/1614678151-70481-1-git-send-email-zhangzl2013@126.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0afab6d5c65b..6649fb6cdf9b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1937,13 +1937,13 @@ static int __ext4_journalled_writepage(struct page *page,
 	if (!ret)
 		ret = err;
 
-	if (!ext4_has_inline_data(inode))
-		ext4_walk_page_buffers(NULL, page_bufs, 0, len,
-				       NULL, bput_one);
 	ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 out:
 	unlock_page(page);
 out_no_pagelock:
+	if (!inline_data && page_bufs)
+		ext4_walk_page_buffers(NULL, page_bufs, 0, len,
+				       NULL, bput_one);
 	brelse(inode_bh);
 	return ret;
 }
-- 
2.30.1

