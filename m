Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DF22DB40A
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Dec 2020 19:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgLOSvi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Dec 2020 13:51:38 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56928 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731286AbgLOSvR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Dec 2020 13:51:17 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BFIoR2S030757
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 13:50:27 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3BD66420280; Tue, 15 Dec 2020 13:50:27 -0500 (EST)
Date:   Tue, 15 Dec 2020 13:50:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] mke2fs.8: Improve valid block size documentation
Message-ID: <X9kFc9S/JnHBWXsY@mit.edu>
References: <20201013133848.23287-1-jack@suse.cz>
 <43B157BB-33E4-4D82-8A09-0E1BCACC55D9@dilger.ca>
 <20201015092731.GC7037@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015092731.GC7037@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 15, 2020 at 11:27:31AM +0200, Jan Kara wrote:
> On Wed 14-10-20 18:56:13, Andreas Dilger wrote:
> > On Oct 13, 2020, at 7:38 AM, Jan Kara <jack@suse.cz> wrote:
> > > 
> > > Explain which valid block sizes mke2fs supports in more detail.
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > 
> > Should this mention that the default block size is 4096 bytes for most
> > filesystems?
> 
> That would be to the "heuristic" parts. Yes, I agree, I'll add that.
> 
> > It might mention e.g. ppc64 or aarch64 can use 64KB page size, but this
> > is definitely an improvement already.
> 
> Yeah, I can add that to the "page size" part. But with these archs there's
> a catch that page size can be configured in the kernel config so the
> formulation will need to be a bit more careful. But I'll add something.
> 
> > Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> 
> Thanks! I'll send v2.

Did you ever send a v2 of this patch?  I can't seem to find it in my
archives or in patchwork.

Thanks!!

					- Ted
