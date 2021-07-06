Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FC63BDFE4
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jul 2021 01:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGFXzE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 19:55:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53576 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229986AbhGFXzE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 19:55:04 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 166NqLNq009283
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jul 2021 19:52:21 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 13BFF15C3CC6; Tue,  6 Jul 2021 19:52:21 -0400 (EDT)
Date:   Tue, 6 Jul 2021 19:52:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Dusty Mabe <dustymabe@redhat.com>
Subject: Re: [PATCH] e2fsck: fix last mount/write time when e2fsck is forced
Message-ID: <YOTstDfNtRKs3bGK@mit.edu>
References: <20210614132725.10339-1-lczerner@redhat.com>
 <YOS7qJ2P2lIwjazY@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOS7qJ2P2lIwjazY@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 06, 2021 at 04:23:04PM -0400, Theodore Ts'o wrote:
> On Mon, Jun 14, 2021 at 03:27:25PM +0200, Lukas Czerner wrote:
> > With commit c52d930f e2fsck is no longer able to fix bad last
> > mount/write time by default because it is conditioned on s_checkinterval
> > not being zero, which it is by default.
> > 
> > One place where it matters is when other e2fsprogs tools require to run
> > full file system check before a certain operation. If the last mount
> > time is for any reason in future, it will not allow it to run even if
> > full e2fsck is ran.
> > 
> > Fix it by checking the last mount/write time when the e2fsck is forced,
> > except for the case where we know the system clock is broken.
> > 
> > Fixes: c52d930f ("e2fsck: don't check for future superblock times if checkinterval == 0")
> > Reported-by: Dusty Mabe <dustymabe@redhat.com>
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> 
> Applied, thanks.

It turns out this patch was buggy, and this became clear once the
regression tests were run and a large number of tests (299 out of 372)
broke.

The problem is that last part of the condition... e.g.:

	(fs->super->s_[mw]time > (__u32) ctx->now)

is the test to see if the last mount/write time is in the future.  The
original patch would force the "fix" unconditionally which would cause
these messages to be printed whenever a file system check was forced:

+Superblock last mount time is in the future.
+       (by less than a day, probably due to the hardware clock being incorrectly set)
+Superblock last write time is in the future.
+       (by less than a day, probably due to the hardware clock being incorrectly set)

I've attached the corrected patch below.

					- Ted

From 2c69c94217b6db083d601d4fd62d6ab6c1628fee Mon Sep 17 00:00:00 2001
From: Lukas Czerner <lczerner@redhat.com>
Date: Mon, 14 Jun 2021 15:27:25 +0200
Subject: [PATCH] e2fsck: fix last mount/write time when e2fsck is forced

With commit c52d930f e2fsck is no longer able to fix bad last
mount/write time by default because it is conditioned on s_checkinterval
not being zero, which it is by default.

One place where it matters is when other e2fsprogs tools require to run
full file system check before a certain operation. If the last mount
time is for any reason in future, it will not allow it to run even if
full e2fsck is ran.

Fix it by checking the last mount/write time when the e2fsck is forced,
except for the case where we know the system clock is broken.

[ Reworked the conditionals so error messages claiming that the last
  write/mount time were corrupted wouldn't be always printed when the
  e2fsck was run with the -f option, thus causing 299 out of 372
  regression tests to fail.  -- TYT ]

Fixes: c52d930f ("e2fsck: don't check for future superblock times if checkinterval == 0")
Reported-by: Dusty Mabe <dustymabe@redhat.com>
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/e2fsck/super.c b/e2fsck/super.c
index e1c3f935..31e2ffb2 100644
--- a/e2fsck/super.c
+++ b/e2fsck/super.c
@@ -1038,9 +1038,9 @@ void check_super_block(e2fsck_t ctx)
 	 * Check to see if the superblock last mount time or last
 	 * write time is in the future.
 	 */
-	if (!broken_system_clock && fs->super->s_checkinterval &&
-	    !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
-	    fs->super->s_mtime > (__u32) ctx->now) {
+	if (((ctx->options & E2F_OPT_FORCE) || fs->super->s_checkinterval) &&
+	    !broken_system_clock && !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
+	    (fs->super->s_mtime > (__u32) ctx->now)) {
 		pctx.num = fs->super->s_mtime;
 		problem = PR_0_FUTURE_SB_LAST_MOUNT;
 		if (fs->super->s_mtime <= (__u32) ctx->now + ctx->time_fudge)
@@ -1050,9 +1050,9 @@ void check_super_block(e2fsck_t ctx)
 			fs->flags |= EXT2_FLAG_DIRTY;
 		}
 	}
-	if (!broken_system_clock && fs->super->s_checkinterval &&
-	    !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
-	    fs->super->s_wtime > (__u32) ctx->now) {
+	if (((ctx->options & E2F_OPT_FORCE) || fs->super->s_checkinterval) &&
+	    !broken_system_clock && !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
+	    (fs->super->s_wtime > (__u32) ctx->now)) {
 		pctx.num = fs->super->s_wtime;
 		problem = PR_0_FUTURE_SB_LAST_WRITE;
 		if (fs->super->s_wtime <= (__u32) ctx->now + ctx->time_fudge)
-- 
2.31.0

