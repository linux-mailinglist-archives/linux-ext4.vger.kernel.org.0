Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46E4116488
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Dec 2019 01:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLIAn6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Dec 2019 19:43:58 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37117 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726422AbfLIAn6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Dec 2019 19:43:58 -0500
Received: from callcc.thunk.org (ec2-52-55-121-20.compute-1.amazonaws.com [52.55.121.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xB90hnDT008236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Dec 2019 19:43:53 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AD32B421A48; Sun,  8 Dec 2019 19:43:47 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: optimize __ext4_check_dir_entry()
Date:   Sun,  8 Dec 2019 19:43:46 -0500
Message-Id: <20191209004346.38526-1-tytso@mit.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191202170213.4761-3-jack@suse.cz>
References: <20191202170213.4761-3-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Make __ext4_check_dir_entry() a bit easier to understand, and reduce
the object size of the function by over 11%.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

As a follow-up to "ext4: check for directory entries too close to block end"

 fs/ext4/dir.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 6305d5ec25af..9f00fc0bf21d 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -72,6 +72,7 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 	const char *error_msg = NULL;
 	const int rlen = ext4_rec_len_from_disk(de->rec_len,
 						dir->i_sb->s_blocksize);
+	const int next_offset = ((char *) de - buf) + rlen;
 
 	if (unlikely(rlen < EXT4_DIR_REC_LEN(1)))
 		error_msg = "rec_len is smaller than minimal";
@@ -79,13 +80,11 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 		error_msg = "rec_len % 4 != 0";
 	else if (unlikely(rlen < EXT4_DIR_REC_LEN(de->name_len)))
 		error_msg = "rec_len is too small for name_len";
-	else if (unlikely(((char *) de - buf) + rlen > size))
+	else if (unlikely(next_offset > size))
 		error_msg = "directory entry overrun";
-	else if (unlikely(((char *) de - buf) + rlen >
-			  size - EXT4_DIR_REC_LEN(1) &&
-			  ((char *) de - buf) + rlen != size)) {
+	else if (unlikely(next_offset > size - EXT4_DIR_REC_LEN(1) &&
+			  next_offset != size))
 		error_msg = "directory entry too close to block end";
-	}
 	else if (unlikely(le32_to_cpu(de->inode) >
 			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))
 		error_msg = "inode out of bounds";
-- 
2.23.0

