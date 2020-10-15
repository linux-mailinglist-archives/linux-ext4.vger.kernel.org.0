Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296D328EF5C
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 11:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgJOJ1d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 05:27:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:50198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgJOJ1d (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Oct 2020 05:27:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00056AF16;
        Thu, 15 Oct 2020 09:27:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9F7171E1338; Thu, 15 Oct 2020 11:27:31 +0200 (CEST)
Date:   Thu, 15 Oct 2020 11:27:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] mke2fs.8: Improve valid block size documentation
Message-ID: <20201015092731.GC7037@quack2.suse.cz>
References: <20201013133848.23287-1-jack@suse.cz>
 <43B157BB-33E4-4D82-8A09-0E1BCACC55D9@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B157BB-33E4-4D82-8A09-0E1BCACC55D9@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 14-10-20 18:56:13, Andreas Dilger wrote:
> On Oct 13, 2020, at 7:38 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > Explain which valid block sizes mke2fs supports in more detail.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Should this mention that the default block size is 4096 bytes for most
> filesystems?

That would be to the "heuristic" parts. Yes, I agree, I'll add that.

> It might mention e.g. ppc64 or aarch64 can use 64KB page size, but this
> is definitely an improvement already.

Yeah, I can add that to the "page size" part. But with these archs there's
a catch that page size can be configured in the kernel config so the
formulation will need to be a bit more careful. But I'll add something.

> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks! I'll send v2.

								Honza
> 
> > ---
> > misc/mke2fs.8.in | 9 +++++----
> > 1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> > index e6bfc6d6fd2d..0814d216f3a4 100644
> > --- a/misc/mke2fs.8.in
> > +++ b/misc/mke2fs.8.in
> > @@ -207,10 +207,11 @@ manual page for more details.
> > .SH OPTIONS
> > .TP
> > .BI \-b " block-size"
> > -Specify the size of blocks in bytes.  Valid block-size values are 1024,
> > -2048 and 4096 bytes per block.  If omitted,
> > -block-size is heuristically determined by the filesystem size and
> > -the expected usage of the filesystem (see the
> > +Specify the size of blocks in bytes.  Valid block-size values are powers of two
> > +from 1024 up to 65536 (however note that the kernel is able to mount only
> > +filesystems with block-size smaller or equal to the system page size - 4k on
> > +x86 systems). If omitted, block-size is heuristically determined by the
> > +filesystem size and the expected usage of the filesystem (see the
> > .B \-T
> > option).  If
> > .I block-size
> > --
> > 2.16.4
> > 
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
