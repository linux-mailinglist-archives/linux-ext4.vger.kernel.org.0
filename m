Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6FE6B36CC
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 07:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCJGqV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 01:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCJGqU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 01:46:20 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EBBF2F95;
        Thu,  9 Mar 2023 22:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6nD4ENr0yx/grZ/Gav7MWrDttNQwr547SPhPRTOJ7qo=; b=JtSUCQu+zsZOFKWMffwYKo3O+E
        AOxsg0xcCaqjwGctFoXwyrYVAeYX0N6jiAwzO/uKR8YU/Vs3/dbPGCQ3H+3qNBaPNRTi3V2u0L8CV
        FpPwdrUBXIpoD/4d4UgHpJVt+5Bvo5YsOD2w6paIYmdt/5Pm52vdUBXEnlXNUXdQKMPI+55c5Rt1/
        dDYja/SvkT2W5f4W4i6mwoe7ZNimLnSPLdExVRzDJC8aTPa/1epPUtwDkX0ND0JvXmMzOi5qgLAJv
        zaxGCiyMuP8Wbi1Rl2q3EZsSVhSNp3sYkArT6AahGLU/yJ3HGVS6Uw7DU5aSJ/TTq0eLhqqN85yv6
        5YQEXvew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paWW4-00FECh-1f;
        Fri, 10 Mar 2023 06:46:12 +0000
Date:   Fri, 10 Mar 2023 06:46:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <20230310064612.GQ3390869@ZenIV>
References: <20230310060734.8780-1-frank.li@vivo.com>
 <ZArLbO1ckmcXwQf0@sol.localdomain>
 <20230310063729.GO3390869@ZenIV>
 <ZArRq/25a5Gt+YMB@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZArRq/25a5Gt+YMB@sol.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 09, 2023 at 10:43:55PM -0800, Eric Biggers wrote:
> On Fri, Mar 10, 2023 at 06:37:29AM +0000, Al Viro wrote:
> > On Thu, Mar 09, 2023 at 10:17:16PM -0800, Eric Biggers wrote:
> > > On Fri, Mar 10, 2023 at 02:07:34PM +0800, Yangtao Li wrote:
> > > > Just for better readability, no code logic change.
> > > > 
> > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > ---
> > > >  fs/ext4/inode.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > index d251d705c276..d121cde74522 100644
> > > > --- a/fs/ext4/inode.c
> > > > +++ b/fs/ext4/inode.c
> > > > @@ -2218,8 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
> > > >  {
> > > >  	struct inode *inode = mpd->inode;
> > > >  	int err;
> > > > -	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
> > > > -							>> inode->i_blkbits;
> > > > +	ext4_lblk_t blocks = DIV_ROUND_UP(i_size_read(inode), i_blocksize(inode));
> > > >  
> > > 
> > > Please don't do this.  This makes the code compile down to a division, which is
> > > far less efficient.  I've verified this by checking the assembly generated.
> > 
> > Which compiler is doing that?
> 
> $ gcc --version
> gcc (GCC) 12.2.1 20230201
> 
> i_blocksize(inode) is not a constant, so this should not be particularly
> surprising.  One might hope that a / (1 << b) would be optimized into a >> b,
> but that doesn't seem to happen.

It really ought to be a / (1u << b), though...
