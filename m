Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E556B36C8
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 07:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCJGoB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 01:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCJGoA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 01:44:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78DC5FA54;
        Thu,  9 Mar 2023 22:43:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FE45B82185;
        Fri, 10 Mar 2023 06:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089B5C433D2;
        Fri, 10 Mar 2023 06:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678430637;
        bh=V9cDCdVUuPtL95TrXMZzrdLTBlDGE9P+vRsZ0ybsPfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjRXQXoBu0fwFSAmdz2yxBkFP6rcayRetU55YfqxEG/QIS5fOd371eO0niKuChNm/
         kL/qic4MrA0yNuOAei3TiBYFFlZD/CpVhhRBTdvqBUijH356j0gjIc7Ed4NaPS4Cg7
         Bc0g07xv3by8pcMzxDKv+2uwdMS0FHjWiKW41y6PbNp0QkapRfcr3XxqiLiHbwrHyv
         50J1q4s+4dXeQCvvcvhEyzFq8gg7P21wa+HW+o6iuU3z5HwaUZOzRuxwMDwf9XzdA6
         gG56Dyn6MzRqZfeu9PORG2TZMaRguUdtmHfpi18I9AwQ/PHsuETU77O2iVwrl/Yin6
         LOjpG3auf64EA==
Date:   Thu, 9 Mar 2023 22:43:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Yangtao Li <frank.li@vivo.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <ZArRq/25a5Gt+YMB@sol.localdomain>
References: <20230310060734.8780-1-frank.li@vivo.com>
 <ZArLbO1ckmcXwQf0@sol.localdomain>
 <20230310063729.GO3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310063729.GO3390869@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 10, 2023 at 06:37:29AM +0000, Al Viro wrote:
> On Thu, Mar 09, 2023 at 10:17:16PM -0800, Eric Biggers wrote:
> > On Fri, Mar 10, 2023 at 02:07:34PM +0800, Yangtao Li wrote:
> > > Just for better readability, no code logic change.
> > > 
> > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > ---
> > >  fs/ext4/inode.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index d251d705c276..d121cde74522 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -2218,8 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
> > >  {
> > >  	struct inode *inode = mpd->inode;
> > >  	int err;
> > > -	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
> > > -							>> inode->i_blkbits;
> > > +	ext4_lblk_t blocks = DIV_ROUND_UP(i_size_read(inode), i_blocksize(inode));
> > >  
> > 
> > Please don't do this.  This makes the code compile down to a division, which is
> > far less efficient.  I've verified this by checking the assembly generated.
> 
> Which compiler is doing that?

$ gcc --version
gcc (GCC) 12.2.1 20230201

i_blocksize(inode) is not a constant, so this should not be particularly
surprising.  One might hope that a / (1 << b) would be optimized into a >> b,
but that doesn't seem to happen.

- Eric
