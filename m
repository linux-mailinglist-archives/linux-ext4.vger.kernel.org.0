Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB791A70FE
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Apr 2020 04:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404103AbgDNC2v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Apr 2020 22:28:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46436 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728787AbgDNC2u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Apr 2020 22:28:50 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03E2SlQs007239
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Apr 2020 22:28:47 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E2ABD42013D; Mon, 13 Apr 2020 22:28:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: fix BUG_ON in fs/ext4/page_io.c:ext4_release_io_end()
Date:   Mon, 13 Apr 2020 22:28:42 -0400
Message-Id: <20200414022842.272657-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The function ext4_release_io_end() can be called by
ext4_put_io_end_defer() with the EXT4_IO_UNWRITTEN flag set and
io_end->size is 0.  In that case, it's safe to release the io_end
structure, since if io_end->size is zero, there is no unwritten region
to release.

This can be reproduced using generic/300, although not very reliably,
and almost never using a freshly rebooted kernel.

Google-Bug-Id: 15054006
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 fs/ext4/page-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index de6fe969f773..15125e5b4827 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -153,7 +153,7 @@ static void ext4_release_io_end(ext4_io_end_t *io_end)
 	struct bio *bio, *next_bio;
 
 	BUG_ON(!list_empty(&io_end->list));
-	BUG_ON(io_end->flag & EXT4_IO_END_UNWRITTEN);
+	BUG_ON((io_end->flag & EXT4_IO_END_UNWRITTEN) && io_end->size);
 	WARN_ON(io_end->handle);
 
 	for (bio = io_end->bio; bio; bio = next_bio) {
-- 
2.24.1

