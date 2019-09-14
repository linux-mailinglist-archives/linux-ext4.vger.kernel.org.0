Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC1B2C3A
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2019 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfINQ1v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 12:27:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58952 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727143AbfINQ1v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 12:27:51 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8EGRJv0011964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Sep 2019 12:27:20 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 65FD842049E; Sat, 14 Sep 2019 12:27:19 -0400 (EDT)
Date:   Sat, 14 Sep 2019 12:27:19 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190914162719.GA19710@mit.edu>
References: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <20190914092509.GA1138@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914092509.GA1138@darwi-home-pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 14, 2019 at 11:25:09AM +0200, Ahmed S. Darwish wrote:
> Unfortunately, it only made the early fast init faster, but didn't fix
> the normal crng init blockage :-(

Yeah, I see why; the original goal was to do the fast init so that
using /dev/urandom, even before we were fully initialized, wouldn't be
deadly.  But then we still wanted 128 bits of estimated entropy the
old fashioned way before we declare the CRNG initialized.

There are a bunch of things that I think I want to do long-term, such
as make CONFIG_RANDOM_TRUST_CPU the default, trying to get random
entropy from the bootloader, etc.  But none of this is something we
should do in a hurry, especially this close before 5.4 drops.  So I
think I want to fix things this way, which is a bit a of a hack, but I
think it's better than simply reverting commit b03755ad6f33.

Ahmed, Linus, what do you think?

				- Ted

From f1a111bff3b996258410e51a3760fc39bbd7058f Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 14 Sep 2019 12:21:39 -0400
Subject: [PATCH] ext4: don't plug in __ext4_get_inode_loc if the CRNG is not
 initialized

Unfortuantely commit b03755ad6f33 ("ext4: make __ext4_get_inode_loc
plug") is so effective that on some systems, where RDRAND is not
trusted, and the GNOME display manager is using getrandom(2) to get
randomness for MIT Magic Cookie (which isn't really secure so using
getrandom(2) is a bit of waste) in early boot on an Arch system is
causing the boot to hang.

Since this is causing problems, although arguably this is userspace's
fault, let's not do it if the CRNG is not yet initialized.  This is
better than trying to tweak the random number generator right before
5.4 is released (I'm afraid we'll accidentally make it _too_ weak),
and it's also better than simply completely reverting b03755ad6f33.

We're effectively reverting it while the RNG is not yet initialized,
to slow down the boot and make it less efficient, just to work around
broken init setups.

Fixes: b03755ad6f33 ("ext4: make __ext4_get_inode_loc plug")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4e271b509af1..41ad93f11b6d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4534,6 +4534,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 	struct buffer_head	*bh;
 	struct super_block	*sb = inode->i_sb;
 	ext4_fsblk_t		block;
+	int			be_inefficient = !rng_is_initialized();
 	struct blk_plug		plug;
 	int			inodes_per_block, inode_offset;
 
@@ -4541,7 +4542,6 @@ static int __ext4_get_inode_loc(struct inode *inode,
 	if (inode->i_ino < EXT4_ROOT_INO ||
 	    inode->i_ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
 		return -EFSCORRUPTED;
-
 	iloc->block_group = (inode->i_ino - 1) / EXT4_INODES_PER_GROUP(sb);
 	gdp = ext4_get_group_desc(sb, iloc->block_group, NULL);
 	if (!gdp)
@@ -4623,7 +4623,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		 * If we need to do any I/O, try to pre-readahead extra
 		 * blocks from the inode table.
 		 */
-		blk_start_plug(&plug);
+		if (likely(!be_inefficient))
+			blk_start_plug(&plug);
 		if (EXT4_SB(sb)->s_inode_readahead_blks) {
 			ext4_fsblk_t b, end, table;
 			unsigned num;
@@ -4654,7 +4655,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		get_bh(bh);
 		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
-		blk_finish_plug(&plug);
+		if (likely(!be_inefficient))
+			blk_finish_plug(&plug);
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
 			EXT4_ERROR_INODE_BLOCK(inode, block,
-- 
2.23.0

