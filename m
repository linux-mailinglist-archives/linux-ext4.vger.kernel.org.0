Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71ECC141D1
	for <lists+linux-ext4@lfdr.de>; Sun,  5 May 2019 20:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfEESVO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 May 2019 14:21:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59471 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbfEESVN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 May 2019 14:21:13 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x45IL3rr003131
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 May 2019 14:21:04 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CE279420024; Sun,  5 May 2019 14:21:03 -0400 (EDT)
Date:   Sun, 5 May 2019 14:21:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2fsck: Check and fix tails of all bitmaps
Message-ID: <20190505182103.GB10038@mit.edu>
References: <20190328164218.19265-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328164218.19265-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 28, 2019 at 05:42:18PM +0100, Jan Kara wrote:
> Currently, e2fsck effectively checks only tail of the last inode and
> block bitmap in the filesystem. Thus if some previous bitmap has unset
> bits it goes unnoticed. Mostly these tail bits in the bitmap are ignored
> however if blocks_per_group are smaller than 8*blocksize, mballoc code
> in the kernel can get confused when the tail bits are unset and return
> bogus free extent.

This patch isn't quite right; there are two different kinds of "bitmap
tails".  The one which e2fsck currently validates is the one only
happens at the last inode and block bitmap, and happens when the
number of blocks or inodes is not a multiple of the 8*blocksize.

The second is the ones when number of blocks/inodes per block group is
less than 8*blocksize, and you're quite right that we weren't
correctly testing for this.

The patch adds a test for the second, but the test added in this patch
to read_bitmaps() *only* tests for the second, and not the first.  But
it removes the tests for set bits for the first type of bitmap tails,
so we would no longer be testing for this kind of file system
corruption.

I noticed this by inspecting the code, but it was also picked up by
the regression tests, such as f_end-bitmap.  There were also a large
number of regression test failures that were *added* by this commit,
since some of the images for the existing tests had tails at the end
of inode bitmaps.  So it's pretty obvious that "make -j16 check"
wasn't run after making this change.  :-/

Tests failed: f_bitmaps f_dup2 f_dup3 f_dup f_end-bitmap f_illbbitmap f_illibitmap f_illitable_flexbg f_lpf f_overfsblks f_super_bad_csum j_corrupt_ext_jnl_sb_csum j_ext_long_trans j_long_trans j_long_trans_mcsum_32bit j_long_trans_mcsum_64bit j_recover_csum2_32bit j_recover_csum2_64bit j_short_trans_64bit j_short_trans j_short_trans_mcsum_64bit j_short_trans_old_csum j_short_trans_open_recover j_short_trans_recover j_short_trans_recover_mcsum_64bit t_replay_and_set

I'm also going to propose that we go about this slightly differently.
The check to see if the bitmaps have invalid tail bits doesn't take
that much extra time.  So instead of having a set of flags which
*request* that we do the check, let's unconditionally do the check,
but instead of returning an error if there is a problem, we'll reserve
two flags, and set them if read_bitmaps() detects a tail bitmap
problem while reading the block or inode problem.

This simplifies the logic in e2fsck, since we don't have to retry the
call to ext2fs_read_bitmaps() without the tail check if it fails.
Instead, we just have to check the two new flag bits after calling
ext2fs_read_bitmaps().

And we'll have to keep check_block_bitmaps() and check_inode_bitmaps()
to test the first kind of tail bitmaps.

					- Ted
