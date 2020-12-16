Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FDD2DBE8F
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 11:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgLPKWz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 05:22:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:51134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgLPKWz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 05:22:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 404C0AC91;
        Wed, 16 Dec 2020 10:22:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4ACE51E135E; Wed, 16 Dec 2020 11:22:13 +0100 (CET)
Date:   Wed, 16 Dec 2020 11:22:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] mke2fs.8: Improve valid block size documentation
Message-ID: <20201216102213.GC21258@quack2.suse.cz>
References: <20201013133848.23287-1-jack@suse.cz>
 <43B157BB-33E4-4D82-8A09-0E1BCACC55D9@dilger.ca>
 <20201015092731.GC7037@quack2.suse.cz>
 <X9kFc9S/JnHBWXsY@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9kFc9S/JnHBWXsY@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 15-12-20 13:50:27, Theodore Y. Ts'o wrote:
> On Thu, Oct 15, 2020 at 11:27:31AM +0200, Jan Kara wrote:
> > On Wed 14-10-20 18:56:13, Andreas Dilger wrote:
> > > On Oct 13, 2020, at 7:38 AM, Jan Kara <jack@suse.cz> wrote:
> > > > 
> > > > Explain which valid block sizes mke2fs supports in more detail.
> > > > 
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > 
> > > Should this mention that the default block size is 4096 bytes for most
> > > filesystems?
> > 
> > That would be to the "heuristic" parts. Yes, I agree, I'll add that.
> > 
> > > It might mention e.g. ppc64 or aarch64 can use 64KB page size, but this
> > > is definitely an improvement already.
> > 
> > Yeah, I can add that to the "page size" part. But with these archs there's
> > a catch that page size can be configured in the kernel config so the
> > formulation will need to be a bit more careful. But I'll add something.
> > 
> > > Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> > 
> > Thanks! I'll send v2.
> 
> Did you ever send a v2 of this patch?  I can't seem to find it in my
> archives or in patchwork.

I think I did but probably it got lost somewhere. Anyway, I've resent it
now. Thanks for noticing!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
