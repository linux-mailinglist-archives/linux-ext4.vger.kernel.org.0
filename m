Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578A62BB2F9
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 19:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgKTS2U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 13:28:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730287AbgKTS2T (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Nov 2020 13:28:19 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7B124137;
        Fri, 20 Nov 2020 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896899;
        bh=umCtXJe8ll0gFNyQleab4zJTSuNlW6aLS9t82OOmt0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WhIf7PNH9jh1Q6xEZherV2tHASA7sql89Jw7dkHpWD7jm1qiosaAcONuCLzMUgaTH
         Hd9bFMFvudepy7GlG9t2E5xECricBhtCQ2za62lEvvWFxxswcUKqcH2EBIIOvRDE0N
         3WUm9OisLDP4MPhPDK+28zFEAqDqfc+mXJifbvAs=
Date:   Fri, 20 Nov 2020 12:28:25 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jan Kara <jack@suse.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 030/141] ext2: Fix fall-through warnings for Clang
Message-ID: <73d8ae2d06d639815672ee9ee4550ea4bfa08489.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of just letting the code
fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/ext2/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 11c5c6fe75bb..78c417d3c898 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1256,6 +1256,7 @@ static void __ext2_truncate_blocks(struct inode *inode, loff_t offset)
 				mark_inode_dirty(inode);
 				ext2_free_branches(inode, &nr, &nr+1, 3);
 			}
+			break;
 		case EXT2_TIND_BLOCK:
 			;
 	}
-- 
2.27.0

