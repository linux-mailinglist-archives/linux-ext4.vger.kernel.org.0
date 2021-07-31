Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D413DC37A
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Jul 2021 07:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbhGaFNs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Jul 2021 01:13:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53237 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236108AbhGaFNs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Jul 2021 01:13:48 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16V5DcK8029327
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Jul 2021 01:13:38 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 03F3C15C37C0; Sat, 31 Jul 2021 01:13:37 -0400 (EDT)
Date:   Sat, 31 Jul 2021 01:13:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Denis <denis@voxelsoft.com>
Cc:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: bug with large_dir in 5.12.17
Message-ID: <YQTcAfR3JX8BYj/f@mit.edu>
References: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
 <5FE9762B-6C6B-4A44-AC99-22192B76C060@gmail.com>
 <7f781a3cd7114db0842dc3f291cd3f6cd826917f.camel@voxelsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f781a3cd7114db0842dc3f291cd3f6cd826917f.camel@voxelsoft.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 30, 2021 at 02:15:12AM +0100, Denis wrote:
> 
> My emails to the list have been silently dropped and postmaster does
> not respond.

I'm not sure why your e-mails are getting dropped by vger.kernel.org.
I will note that voxelsoft.com appears to be on the a barracuda spam
blacklist:

https://mxtoolbox.com/SuperTool.aspx?action=blacklist%3avoxelsoft.com&run=toolpage

> http://voxelsoft.com/2021/ext4_large_dir_corruption.html

I've looked your analysis, and while I appreciate your goals:

   * a naïve approach would be to reinstate the missing goto, but
       1. such approach is likely to contribute to another mistake in the future
       2. goto considered harmful
   * instead refactor the outer scope to handle both restart conditions
     (goto agnostic)

I've looked at your proposed fix, and I think a simpler fix might be:

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5fd56f616cf0..f3bbcd4efb56 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2517,7 +2517,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 				goto journal_error;
 			err = ext4_handle_dirty_dx_node(handle, dir,
 							frame->bh);
-			if (err)
+			if (restart || err)
 				goto journal_error;
 		} else {
 			struct dx_root *dxroot;


It is similarly "goto agnostic" in that it doesn't actually add (or
remove) any gotos.

I don't think your proposed fix improves the maintainability or
understandability for the code, so my bias would be to go for the
simpler fix.

If we were going to clean up the code, the main issues that I'd want
to address are:

*) Goto statements aren't necessarilyy evil; using "goto errout" is
   pretty common idiom, and I don't have a problem with that.
   Occasionally having a "goto again" when we need to retry some
   operation can actually be the cleanest way to code something.  But
   the combination of the two --- when "goto cleanup" and "goto
   journal_error" is used for both purposes --- is super confusing,
   and that is caused the bug in the first place.

So for example, this diff increase the goto count by one, but the code
is much more readable, because each goto and goto label do exactly one
thing:

 fs/ext4/namei.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5fd56f616cf0..58fca88d7459 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2398,14 +2398,15 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 {
 	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame;
 	struct dx_entry *entries, *at;
-	struct buffer_head *bh;
+	struct buffer_head *bh = NULL;
 	struct super_block *sb = dir->i_sb;
 	struct ext4_dir_entry_2 *de;
-	int restart;
 	int err;
 
-again:
-	restart = 0;
+	frames[0].bh = NULL;
+recalc_htree_path:
+	brelse(bh);
+	dx_release(frames);
 	frame = dx_probe(fname, dir, NULL, frames);
 	if (IS_ERR(frame))
 		return PTR_ERR(frame);
@@ -2436,7 +2437,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 		ext4_lblk_t newblock;
 		int levels = frame - frames + 1;
 		unsigned int icount;
-		int add_level = 1;
+		int add_level = 1, restart = 0;
 		struct dx_entry *entries2;
 		struct dx_node *node2;
 		struct buffer_head *bh2;
@@ -2508,9 +2509,9 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			dxtrace(dx_show_index("node",
 			       ((struct dx_node *) bh2->b_data)->entries));
 			err = ext4_handle_dirty_dx_node(handle, dir, bh2);
+			brelse (bh2);
 			if (err)
 				goto journal_error;
-			brelse (bh2);
 			err = ext4_handle_dirty_dx_node(handle, dir,
 						   (frame - 1)->bh);
 			if (err)
@@ -2519,6 +2520,8 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 							frame->bh);
 			if (err)
 				goto journal_error;
+			if (restart)
+				goto recalc_htree_path;
 		} else {
 			struct dx_root *dxroot;
 			memcpy((char *) entries2, (char *) entries,
@@ -2538,8 +2541,9 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 				goto journal_error;
 			err = ext4_handle_dirty_dx_node(handle, dir, bh2);
 			brelse(bh2);
-			restart = 1;
-			goto journal_error;
+			if (err)
+				goto journal_error;
+			goto recalc_htree_path;
 		}
 	}
 	de = do_split(handle, dir, &bh, frame, &fname->hinfo);
@@ -2555,11 +2559,6 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 cleanup:
 	brelse(bh);
 	dx_release(frames);
-	/* @restart is true means htree-path has been changed, we need to
-	 * repeat dx_probe() to find out valid htree-path
-	 */
-	if (restart && err == 0)
-		goto again;
 	return err;
 }
 

*) The ext4_dx_add_entry() function is just too big.  It was
   borderline unwieldy before we added the large_dir feature, and that
   large_dir feature just tip it over the line.  We probably should to
   refactor separate functions for "do_split_index()" and
   "add_htree_level()".

*) The control avariables "add_level" and "restart" are an additional
   cause of complexity.  It may be that refactoring some of the
   separate functions, and simply forcing that the hree path get
   recalculated if an index node is split or the tree depth increases,
   would allow us to get rid of these two variables.

Denis, Artem, what do you think?

					- Ted
					
