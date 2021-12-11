Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2934470F9A
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Dec 2021 01:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhLKAyv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Dec 2021 19:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbhLKAyv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Dec 2021 19:54:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC7FC061714
        for <linux-ext4@vger.kernel.org>; Fri, 10 Dec 2021 16:51:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9572FB82A0F
        for <linux-ext4@vger.kernel.org>; Sat, 11 Dec 2021 00:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31135C00446;
        Sat, 11 Dec 2021 00:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639183872;
        bh=6zx3xYMU93C0BIOTUplB86oBncrQo4o0yQM0aT7gTeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asmWqcNzQ+ftAkr26WshU25EiMfWgt+Q9FY6aEOJqu/Ajp17fC2LYWZxGoLE6dTlN
         BGsdEDG6OpvA7cdUqHNQ2VtdgeyxywchqISTNj9wtfn+zzoPz8LUpmo9hqC/eMv4YG
         8nQa7bhYJFN3PxgJVtTBDGlz4hQcj17pnV18yntf4QZ1x43vfUgnZKSt9HvratDO9D
         kUDBDsjG382EiEy/MKi8yGxOhnAYUFFhJMsX1k/PnJ6BwwRzYVlkJfC6k9YIKqRXHn
         CTbN0ZlfFAZMCMEgCSd2A8d34z48sYiJOiY17+fEWfdW3aO4tkR4gCulbDQj+LSr6+
         4C2pPUlDrgblw==
Date:   Fri, 10 Dec 2021 16:51:11 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] e2fsck: map PROMPT_* values to prompt messages
Message-ID: <20211211005111.GC69182@magnolia>
References: <20211208075112.85649-1-adilger@dilger.ca>
 <20211208164238.GA69182@magnolia>
 <07CD099E-959E-4F85-B7B6-72F025E64545@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07CD099E-959E-4F85-B7B6-72F025E64545@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 09, 2021 at 02:55:26PM -0700, Andreas Dilger wrote:
> On Dec 8, 2021, at 9:42 AM, Darrick J. Wong <djwong@kernel.org> wrote:
> > 
> > On Wed, Dec 08, 2021 at 12:51:12AM -0700, Andreas Dilger wrote:
> >> It isn't totally clear when searching the code for PROMPT_*
> >> constants from problem codes where these messages come from.
> >> Similarly, there isn't a direct mapping from the prompt string
> >> to the constant.
> >> 
> >> Add comments that make this mapping more clear.
> >> 
> >> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> >> ---
> >> e2fsck/problem.c | 46 +++++++++++++++++++++++-----------------------
> >> 1 file changed, 23 insertions(+), 23 deletions(-)
> >> 
> >> diff --git a/e2fsck/problem.c b/e2fsck/problem.c
> >> index 757b5d56..2d02468c 100644
> >> --- a/e2fsck/problem.c
> >> +++ b/e2fsck/problem.c
> >> @@ -50,29 +50,29 @@
> >>  * to fix a problem.
> >>  */
> >> static const char *prompt[] = {
> >> -	N_("(no prompt)"),	/* 0 */
> >> -	N_("Fix"),		/* 1 */
> >> -	N_("Clear"),		/* 2 */
> >> -	N_("Relocate"),		/* 3 */
> >> -	N_("Allocate"),		/* 4 */
> >> -	N_("Expand"),		/* 5 */
> >> -	N_("Connect to /lost+found"), /* 6 */
> >> -	N_("Create"),		/* 7 */
> >> -	N_("Salvage"),		/* 8 */
> >> -	N_("Truncate"),		/* 9 */
> >> -	N_("Clear inode"),	/* 10 */
> >> -	N_("Abort"),		/* 11 */
> >> -	N_("Split"),		/* 12 */
> >> -	N_("Continue"),		/* 13 */
> >> -	N_("Clone multiply-claimed blocks"), /* 14 */
> >> -	N_("Delete file"),	/* 15 */
> >> -	N_("Suppress messages"),/* 16 */
> >> -	N_("Unlink"),		/* 17 */
> >> -	N_("Clear HTree index"),/* 18 */
> >> -	N_("Recreate"),		/* 19 */
> >> -	N_("Optimize"),		/* 20 */
> >> -	N_("Clear flag"),	/* 21 */
> >> -	"",			/* 22 */
> >> +	N_("(no prompt)"),			/* PROMPT_NONE		=  0 */
> > 
> > Why not make it even clearer and mismerge proof:
> > 
> > static const char *prompt[] = {
> > 	[0]		= N_("(no prompt")),	/* null value test */
> > 	[PROMPT_FIX]	= N_("Fix"),		/* 1 */
> > 	[PROMPT_CLEAR]	= N_("Clear"),		/* 2 */
> > 	...
> > };
> 
> I thought about that too, but then I thought the "[index] = foo" designated
> initializer is GNU or at least C99-specific, and I wondered if that was
> going to cause portability problems for some ancient system that e2fsprogs
> is building on...  I figured adding comments is relatively safe, and these
> values change so rarely that more complexity in the patch was not a win.

<shrug> Yeah, I thought it was safe enough to use -std=gnu90 features,
but I guess it's really up to Ted to decide if he'd prefer a structural
fix or not.  Evidently this syntax is /still/ being argued in the C++
committees, which ... yay. :(

--D

> Cheers, Andreas
> 
> 
> 
> 
> 


