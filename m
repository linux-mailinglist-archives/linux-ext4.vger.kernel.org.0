Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64D130EBD5
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Feb 2021 06:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhBDFYR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Feb 2021 00:24:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38305 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229790AbhBDFYQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Feb 2021 00:24:16 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1145NSHR018005
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 Feb 2021 00:23:28 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0953915C39E2; Thu,  4 Feb 2021 00:23:28 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [PATCH] ext4: fix potential htree index checksum corruption
Date:   Thu,  4 Feb 2021 00:23:21 -0500
Message-Id: <20210204052321.224249-1-tytso@mit.edu>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the case where we need to do an interior node split, and
immediately afterwards, we are unable to allocate a new directory leaf
block due to ENOSPC, the directory index checksum's will not be filled
in correctly (and indeed, will not be correctly journalled).

This looks like a bug that was introduced when we added largedir
support.  The original code doesn't make any sense (and should have
been caught in code review), but it was hidden because most of the
time, the index node checksum will be set by do_split().  But if
do_split bails out due to ENOSPC, then ext4_handle_dirty_dx_node()
won't get called, and so the directory index checksum field will not
get set, leading to:

EXT4-fs error (device sdb): dx_probe:858: inode #6635543: block 4022: comm nfsd: Directory index failed checksum

Google-Bug-Id: 176345532
Fixes: e08ac99fa2a2 ("ext4: add largedir feature")
Cc: Artem Blagodarenko <artem.blagodarenko@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/namei.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a6e28b4b5a95..115762180801 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2411,11 +2411,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 						   (frame - 1)->bh);
 			if (err)
 				goto journal_error;
-			if (restart) {
-				err = ext4_handle_dirty_dx_node(handle, dir,
-							   frame->bh);
+			err = ext4_handle_dirty_dx_node(handle, dir,
+							frame->bh);
+			if (err)
 				goto journal_error;
-			}
 		} else {
 			struct dx_root *dxroot;
 			memcpy((char *) entries2, (char *) entries,
-- 
2.30.0

