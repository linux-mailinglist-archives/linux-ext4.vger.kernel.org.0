Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99546348FF5
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Mar 2021 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhCYLax (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Mar 2021 07:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231339AbhCYL3S (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 25 Mar 2021 07:29:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEE0561A2E;
        Thu, 25 Mar 2021 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616671646;
        bh=R3J+mS9FrZQ4KQWHm3TvUV6aAUxe8Vr9GGhVgrdYWiQ=;
        h=From:To:Cc:Subject:Date:From;
        b=V8HfkOgJJflSpCnpWRjReke1bC4N0xIHrPIdYvB4mQj8GBreTk2oq9RP/7Ss9hWYe
         D30wDcLejkMqt1MJZJUVY+QU+fwzBasPbR9CdoRXIH4T79nF9Cx6N8MUPrVVeSgeA9
         /3Xev7w2+oZ3cp+7gBzJ4SNCgF/thYdYn17lqMauLVCaSJ9IxgjnqZdHKkJx1ozvEA
         mfaX92EEWLbcmnI/XzuH3W8Fb1tgM2n8T8xz5WT/WPtNvlkHpEVWp9uX5+tEhx2dgj
         PcpW7nsXnFpR/4IR4FWy1bY89U7IkxnXLWB6Imxlh2D2/zede59iZRay5flyGVxqki
         aEZTQqVnYQPtw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhaolong Zhang <zhangzl2013@126.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/20] ext4: fix bh ref count on error paths
Date:   Thu, 25 Mar 2021 07:27:05 -0400
Message-Id: <20210325112724.1928174-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
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
index 296ffe92e250..2fb8f9c687d7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2072,13 +2072,13 @@ static int __ext4_journalled_writepage(struct page *page,
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

