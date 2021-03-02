Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF22D32AF56
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Mar 2021 04:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhCCARl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Mar 2021 19:17:41 -0500
Received: from m15114.mail.126.com ([220.181.15.114]:41568 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442208AbhCBLVn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Mar 2021 06:21:43 -0500
X-Greylist: delayed 5661 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Mar 2021 06:21:24 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=OPG3GVG7sSDGQxYhC6
        +zVbtEJXQAdC07eA7ZoSNv4No=; b=Qx/XyouHvf6y0/pucxfUJguPL7uEZFS9Wm
        amleEYwiSrEUwrTyWJXf804BMBo04eKHEBzfa8GlTRL6sYCE6ZjKAIGlEszMaspu
        C33nM5XhA0GQ7x5PkFgLrGsXd+MxUsqLi8jV/EfUHdqeai1Qc9iffu1uZ9YP7+c8
        /DhMwygEg=
Received: from pek-lpd-ccm3.wrs.com (unknown [60.247.85.82])
        by smtp7 (Coremail) with SMTP id DsmowACXnW1CCT5gLDO0OQ--.27060S2;
        Tue, 02 Mar 2021 17:45:44 +0800 (CST)
From:   Zhaolong Zhang <zhangzl2013@126.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhaolong Zhang <zhangzl2013@126.com>
Subject: [PATCH] ext4: fix bh ref count on error paths
Date:   Tue,  2 Mar 2021 17:42:31 +0800
Message-Id: <1614678151-70481-1-git-send-email-zhangzl2013@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowACXnW1CCT5gLDO0OQ--.27060S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWrGF1ruF13ZFW5CFyxuFg_yoW3tFX_G3
        4xXF48Gws8Xws7uws8Gw13Xrn2vrW8Krs5uF97ta15tFyjyr98CrnxAFZxZF1UWF4Sgr98
        Gr1xZF1IkF92gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRT5l5UUUUU==
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbitQhJz1pEDFNYdgAAsU
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

__ext4_journalled_writepage should drop bhs' ref count on error paths

Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 650c5acd2f2d..a79a9ea58c56 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1938,13 +1938,13 @@ static int __ext4_journalled_writepage(struct page *page,
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
2.26.1

