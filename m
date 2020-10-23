Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EB429755E
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462367AbgJWQ4r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 12:56:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461853AbgJWQ4q (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 23 Oct 2020 12:56:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB4E7AC82;
        Fri, 23 Oct 2020 16:56:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8964D1E1348; Fri, 23 Oct 2020 18:56:44 +0200 (CEST)
Date:   Fri, 23 Oct 2020 18:56:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tianxianting <tian.xianting@h3c.com>
Cc:     Jan Kara <jack@suse.cz>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: remove the null check of bio_vec page
Message-ID: <20201023165644.GG9119@quack2.suse.cz>
References: <20201020082201.34257-1-tian.xianting@h3c.com>
 <20201021102503.GC19726@quack2.suse.cz>
 <113ad7d2cbfd43a9972ad37df66e5542@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113ad7d2cbfd43a9972ad37df66e5542@h3c.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 23-10-20 16:38:16, Tianxianting wrote:
> Thanks Jan
> Can be the patch applied?

Ted Tso is the ext4 maintainer so he should eventually pick up and apply
the patch. But since there's merge window currently open, I guess he's busy
shuffling patches to send to Linus. I'd expect he'll get to your patch in a
week or two.

								Honza

> 
> -----Original Message-----
> From: Jan Kara [mailto:jack@suse.cz] 
> Sent: Wednesday, October 21, 2020 6:25 PM
> To: tianxianting (RD) <tian.xianting@h3c.com>
> Cc: tytso@mit.edu; adilger.kernel@dilger.ca; jack@suse.cz; linux-ext4@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ext4: remove the null check of bio_vec page
> 
> On Tue 20-10-20 16:22:01, Xianting Tian wrote:
> > bv_page can't be NULL in a valid bio_vec, so we can remove the NULL 
> > check, as we did in other places when calling 
> > bio_for_each_segment_all() to go through all bio_vec of a bio.
> > 
> > Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> 
> Thanks for the patch. It looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
> > ---
> >  fs/ext4/page-io.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c index 
> > defd2e10d..cb135a944 100644
> > --- a/fs/ext4/page-io.c
> > +++ b/fs/ext4/page-io.c
> > @@ -111,9 +111,6 @@ static void ext4_finish_bio(struct bio *bio)
> >  		unsigned under_io = 0;
> >  		unsigned long flags;
> >  
> > -		if (!page)
> > -			continue;
> > -
> >  		if (fscrypt_is_bounce_page(page)) {
> >  			bounce_page = page;
> >  			page = fscrypt_pagecache_page(bounce_page);
> > --
> > 2.17.1
> > 
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
