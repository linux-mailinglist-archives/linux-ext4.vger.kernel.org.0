Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89B43BE4B7
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jul 2021 10:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhGGIx7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jul 2021 04:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231185AbhGGIx7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jul 2021 04:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625647879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMFtDanoPxhkbNjaRefzC60eneF0bzMBqD5ZhIuYm0g=;
        b=WMradx9/rcfbt3of4MQM/WcSrC1njh1dEx+F7UkJb/e9naMI0PClKqcDrLzMbm12NskeZ9
        jQCYv46H7ppOK6J5ACloZpPjljsXul8d1fnzJK5A4Gp+KnCZn4f91Krn9QUyCeJ8BLjRMp
        SJu+rNMMWvxOXA0yI74w3+IPtVqvZ8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596--YbjbC1QOJqrrEkW5rzPFQ-1; Wed, 07 Jul 2021 04:51:17 -0400
X-MC-Unique: -YbjbC1QOJqrrEkW5rzPFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 055B318BFE6C;
        Wed,  7 Jul 2021 08:51:17 +0000 (UTC)
Received: from work (unknown [10.40.193.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D326560C05;
        Wed,  7 Jul 2021 08:51:12 +0000 (UTC)
Date:   Wed, 7 Jul 2021 10:51:09 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Dusty Mabe <dustymabe@redhat.com>
Subject: Re: [PATCH] e2fsck: fix last mount/write time when e2fsck is forced
Message-ID: <20210707085109.j5akliabeq23eair@work>
References: <20210614132725.10339-1-lczerner@redhat.com>
 <YOS7qJ2P2lIwjazY@mit.edu>
 <YOTstDfNtRKs3bGK@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOTstDfNtRKs3bGK@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 06, 2021 at 07:52:20PM -0400, Theodore Ts'o wrote:
> On Tue, Jul 06, 2021 at 04:23:04PM -0400, Theodore Ts'o wrote:
> > On Mon, Jun 14, 2021 at 03:27:25PM +0200, Lukas Czerner wrote:
> > > With commit c52d930f e2fsck is no longer able to fix bad last
> > > mount/write time by default because it is conditioned on s_checkinterval
> > > not being zero, which it is by default.
> > > 
> > > One place where it matters is when other e2fsprogs tools require to run
> > > full file system check before a certain operation. If the last mount
> > > time is for any reason in future, it will not allow it to run even if
> > > full e2fsck is ran.
> > > 
> > > Fix it by checking the last mount/write time when the e2fsck is forced,
> > > except for the case where we know the system clock is broken.
> > > 
> > > Fixes: c52d930f ("e2fsck: don't check for future superblock times if checkinterval == 0")
> > > Reported-by: Dusty Mabe <dustymabe@redhat.com>
> > > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > 
> > Applied, thanks.
> 
> It turns out this patch was buggy, and this became clear once the
> regression tests were run and a large number of tests (299 out of 372)
> broke.
> 
> The problem is that last part of the condition... e.g.:
> 
> 	(fs->super->s_[mw]time > (__u32) ctx->now)
> 
> is the test to see if the last mount/write time is in the future.  The
> original patch would force the "fix" unconditionally which would cause
> these messages to be printed whenever a file system check was forced:
> 
> +Superblock last mount time is in the future.
> +       (by less than a day, probably due to the hardware clock being incorrectly set)
> +Superblock last write time is in the future.
> +       (by less than a day, probably due to the hardware clock being incorrectly set)
> 
> I've attached the corrected patch below.

Oops sorry about that. My custom test with date changes must have bitten
here and I ran the 'make check' with outdated binaries, my bad.

The reworked version looks and works fine.

Thanks!
-Lukas

> 
> 					- Ted
> 
> From 2c69c94217b6db083d601d4fd62d6ab6c1628fee Mon Sep 17 00:00:00 2001
> From: Lukas Czerner <lczerner@redhat.com>
> Date: Mon, 14 Jun 2021 15:27:25 +0200
> Subject: [PATCH] e2fsck: fix last mount/write time when e2fsck is forced
> 
> With commit c52d930f e2fsck is no longer able to fix bad last
> mount/write time by default because it is conditioned on s_checkinterval
> not being zero, which it is by default.
> 
> One place where it matters is when other e2fsprogs tools require to run
> full file system check before a certain operation. If the last mount
> time is for any reason in future, it will not allow it to run even if
> full e2fsck is ran.
> 
> Fix it by checking the last mount/write time when the e2fsck is forced,
> except for the case where we know the system clock is broken.
> 
> [ Reworked the conditionals so error messages claiming that the last
>   write/mount time were corrupted wouldn't be always printed when the
>   e2fsck was run with the -f option, thus causing 299 out of 372
>   regression tests to fail.  -- TYT ]
> 
> Fixes: c52d930f ("e2fsck: don't check for future superblock times if checkinterval == 0")
> Reported-by: Dusty Mabe <dustymabe@redhat.com>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  e2fsck/super.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/e2fsck/super.c b/e2fsck/super.c
> index e1c3f935..31e2ffb2 100644
> --- a/e2fsck/super.c
> +++ b/e2fsck/super.c
> @@ -1038,9 +1038,9 @@ void check_super_block(e2fsck_t ctx)
>  	 * Check to see if the superblock last mount time or last
>  	 * write time is in the future.
>  	 */
> -	if (!broken_system_clock && fs->super->s_checkinterval &&
> -	    !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
> -	    fs->super->s_mtime > (__u32) ctx->now) {
> +	if (((ctx->options & E2F_OPT_FORCE) || fs->super->s_checkinterval) &&
> +	    !broken_system_clock && !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
> +	    (fs->super->s_mtime > (__u32) ctx->now)) {
>  		pctx.num = fs->super->s_mtime;
>  		problem = PR_0_FUTURE_SB_LAST_MOUNT;
>  		if (fs->super->s_mtime <= (__u32) ctx->now + ctx->time_fudge)
> @@ -1050,9 +1050,9 @@ void check_super_block(e2fsck_t ctx)
>  			fs->flags |= EXT2_FLAG_DIRTY;
>  		}
>  	}
> -	if (!broken_system_clock && fs->super->s_checkinterval &&
> -	    !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
> -	    fs->super->s_wtime > (__u32) ctx->now) {
> +	if (((ctx->options & E2F_OPT_FORCE) || fs->super->s_checkinterval) &&
> +	    !broken_system_clock && !(ctx->flags & E2F_FLAG_TIME_INSANE) &&
> +	    (fs->super->s_wtime > (__u32) ctx->now)) {
>  		pctx.num = fs->super->s_wtime;
>  		problem = PR_0_FUTURE_SB_LAST_WRITE;
>  		if (fs->super->s_wtime <= (__u32) ctx->now + ctx->time_fudge)
> -- 
> 2.31.0
> 

