Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFDF2BB2FB
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 19:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgKTS22 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 13:28:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730363AbgKTS21 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Nov 2020 13:28:27 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B1422253;
        Fri, 20 Nov 2020 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896906;
        bh=Y8vpVMcmlTUsUOP9pEeod738ijyLLvAD8dEkm6gpY9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o4jMdMY5wxuevhdDh/Pewtd62/r9me5BKkoC4mBouzkIUJoCD3fV8iJkwRya0aYt8
         lvqvL8YecxiHY3O88WlmE1BxoiwlGh13FCeq8B9PO/xhgTmXpHtaJqhsN0IqCfXpsh
         uKIE5ujdotOV6voOtZQko2xAX5jAMxOf7r4TbzYk=
Date:   Fri, 20 Nov 2020 12:28:32 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 031/141] ext4: Fix fall-through warnings for Clang
Message-ID: <03497331f088a938d7a728e7a689bd7953139429.1605896059.git.gustavoars@kernel.org>
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
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6633b20224d5..ca04389fc718 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4877,6 +4877,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 			       "requested data journaling mode");
 			goto failed_mount_wq;
 		}
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

