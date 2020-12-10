Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7E62D50F2
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 03:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgLJChp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Dec 2020 21:37:45 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33545 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726642AbgLJChi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Dec 2020 21:37:38 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BA2acN3009793
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Dec 2020 21:36:39 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A77F1420136; Wed,  9 Dec 2020 21:36:38 -0500 (EST)
Date:   Wed, 9 Dec 2020 21:36:38 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+345b75652b1d24227443@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: UBSAN: shift-out-of-bounds in ext4_fill_super
Message-ID: <20201210023638.GP52960@mit.edu>
References: <00000000000048a9de05b603126a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000048a9de05b603126a@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 08, 2020 at 11:33:11PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    15ac8fdb Add linux-next specific files for 20201207
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1125c923500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3696b8138207d24d
> dashboard link: https://syzkaller.appspot.com/bug?extid=345b75652b1d24227443
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151bf86b500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139212cb500000

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git e360ba58d067a30a4e3e7d55ebdd919885a058d6

From 3d3bc303a8a8f7123cf486f49fa9060116fa1465 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 9 Dec 2020 15:59:11 -0500
Subject: [PATCH] ext4: check for invalid block size early when mounting a file
 system

Check for valid block size directly by validating s_log_block_size; we
were doing this in two places.  First, by calculating blocksize via
BLOCK_SIZE << s_log_block_size, and then checking that the blocksize
was valid.  And then secondly, by checking s_log_block_size directly.

The first check is not reliable, and can trigger an UBSAN warning if
s_log_block_size on a maliciously corrupted superblock is greater than
22.  This is harmless, since the second test will correctly reject the
maliciously fuzzed file system, but to make syzbot shut up, and
because the two checks are duplicative in any case, delete the
blocksize check, and move the s_log_block_size earlier in
ext4_fill_super().

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: syzbot+345b75652b1d24227443@syzkaller.appspotmail.com
---
 fs/ext4/super.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f86220a8df50..4a16bbf0432c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4202,18 +4202,25 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	 */
 	sbi->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
 
-	blocksize = BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);
-
-	if (blocksize == PAGE_SIZE)
-		set_opt(sb, DIOREAD_NOLOCK);
-
-	if (blocksize < EXT4_MIN_BLOCK_SIZE ||
-	    blocksize > EXT4_MAX_BLOCK_SIZE) {
+	if (le32_to_cpu(es->s_log_block_size) >
+	    (EXT4_MAX_BLOCK_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
 		ext4_msg(sb, KERN_ERR,
-		       "Unsupported filesystem blocksize %d (%d log_block_size)",
-			 blocksize, le32_to_cpu(es->s_log_block_size));
+			 "Invalid log block size: %u",
+			 le32_to_cpu(es->s_log_block_size));
 		goto failed_mount;
 	}
+	if (le32_to_cpu(es->s_log_cluster_size) >
+	    (EXT4_MAX_CLUSTER_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Invalid log cluster size: %u",
+			 le32_to_cpu(es->s_log_cluster_size));
+		goto failed_mount;
+	}
+
+	blocksize = EXT4_MIN_BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);
+
+	if (blocksize == PAGE_SIZE)
+		set_opt(sb, DIOREAD_NOLOCK);
 
 	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV) {
 		sbi->s_inode_size = EXT4_GOOD_OLD_INODE_SIZE;
@@ -4432,21 +4439,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (!ext4_feature_set_ok(sb, (sb_rdonly(sb))))
 		goto failed_mount;
 
-	if (le32_to_cpu(es->s_log_block_size) >
-	    (EXT4_MAX_BLOCK_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
-		ext4_msg(sb, KERN_ERR,
-			 "Invalid log block size: %u",
-			 le32_to_cpu(es->s_log_block_size));
-		goto failed_mount;
-	}
-	if (le32_to_cpu(es->s_log_cluster_size) >
-	    (EXT4_MAX_CLUSTER_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
-		ext4_msg(sb, KERN_ERR,
-			 "Invalid log cluster size: %u",
-			 le32_to_cpu(es->s_log_cluster_size));
-		goto failed_mount;
-	}
-
 	if (le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) > (blocksize / 4)) {
 		ext4_msg(sb, KERN_ERR,
 			 "Number of reserved GDT blocks insanely large: %d",
-- 
2.28.0

