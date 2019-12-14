Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E265711F454
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Dec 2019 22:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfLNVsk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Dec 2019 16:48:40 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33237 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726484AbfLNVsk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Dec 2019 16:48:40 -0500
Received: from callcc.thunk.org (ec2-3-216-189-230.compute-1.amazonaws.com [3.216.189.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBELmYj6012773
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Dec 2019 16:48:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CCE8F4207DF; Sat, 14 Dec 2019 16:48:33 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: treat buffers contining write errors as valid in ext4_sb_bread()
Date:   Sat, 14 Dec 2019 16:48:32 -0500
Message-Id: <20191214214832.484173-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In commit 7963e5ac9012 ("ext4: treat buffers with write errors as
containing valid data") we missed changing ext4_sb_bread() to use
ext4_buffer_uptodate().  So fix this oversight.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b205112ca051..68ce15d85779 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -154,7 +154,7 @@ ext4_sb_bread(struct super_block *sb, sector_t block, int op_flags)
 
 	if (bh == NULL)
 		return ERR_PTR(-ENOMEM);
-	if (buffer_uptodate(bh))
+	if (ext4_buffer_uptodate(bh))
 		return bh;
 	ll_rw_block(REQ_OP_READ, REQ_META | op_flags, 1, &bh);
 	wait_on_buffer(bh);
-- 
2.24.1

