Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6500640B7A0
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Sep 2021 21:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhINTMu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Sep 2021 15:12:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51816 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233055AbhINTMf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Sep 2021 15:12:35 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18EJBASQ024779
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 15:11:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6A4EB15C3424; Tue, 14 Sep 2021 15:11:10 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/3] resize2fs: attempt to keep the # of inodes valid by removing the last bg
Date:   Tue, 14 Sep 2021 15:11:02 -0400
Message-Id: <20210914191104.2283033-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If a the 10GB file system (with the default inode ratio size of 16k)
is resized to 64TB, the number of inodes will become 2**32 --- one
above the maximum allowed number of inodes of 2**32-1.  In
adjust_fs_info(), we already try drop the last block group if there
isn't sufficient space in the last block group to support the metadata
for that block group.  So if dropping the last block group allows the
number of inodes to valid, we should try that as well.  In some cases
this will mean resizing a file system to 64TB will result in it be
resized to a size of 64TB - 128MB, which is close enough for
government work.

Addresses-Google-Bug: 199105099
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 resize/resize2fs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index daaa3d49..770d2d06 100644
--- a/resize/resize2fs.c
+++ b/resize/resize2fs.c
@@ -757,6 +757,15 @@ retry:
 	 */
 	new_inodes =(unsigned long long) fs->super->s_inodes_per_group * fs->group_desc_count;
 	if (new_inodes > ~0U) {
+		new_inodes = (unsigned long long) fs->super->s_inodes_per_group * (fs->group_desc_count - 1);
+		if (new_inodes <= ~0U) {
+			unsigned long long new_blocks =
+		((unsigned long long) fs->super->s_blocks_per_group *
+		 (fs->group_desc_count - 1)) + fs->super->s_first_data_block;
+
+			ext2fs_blocks_count_set(fs->super, new_blocks);
+			goto retry;
+		}
 		fprintf(stderr, _("inodes (%llu) must be less than %u\n"),
 			(unsigned long long) new_inodes, ~0U);
 		return EXT2_ET_TOO_MANY_INODES;
-- 
2.31.0

