Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FC56B36B3
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 07:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCJGhn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 01:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCJGhm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 01:37:42 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F78104AD9;
        Thu,  9 Mar 2023 22:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=82dh6mqBJTjL8r8etk1pUy6ZfWEO+DU4FS//Oz9zDqo=; b=Zh/558dzdUiqlfyyI5pAu05/Az
        iOKX8liSwu870ZrGDgL8RBTTfSf/bWI3CU4CHaizQQXlbbtpbpsB9MNwtgr6OIqVUaZH5zm+ibLoc
        7yCNlB2Y6Y8/kkHJyItkLUp2XtTvrcocIMMJ9kl0tGPUla0MicfuxTc144LryZH6GRWZ1yajC0Uv/
        yfXw0Hs7b+lHWyQiMSX96YDfFCtTqzvtW2UOnIVxyVDiW+adRwgX6arYVVkX/zt3m97Ka5/H/rrpO
        e5wRVCJpMYopPHaBUh44FdX4fGbPyOLqFA8NmE3EcA86RuVkt8lxD7uQIkWi87R6xb+YN67I8X8jI
        29XTIuEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paWNd-00FE7K-2m;
        Fri, 10 Mar 2023 06:37:29 +0000
Date:   Fri, 10 Mar 2023 06:37:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <20230310063729.GO3390869@ZenIV>
References: <20230310060734.8780-1-frank.li@vivo.com>
 <ZArLbO1ckmcXwQf0@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZArLbO1ckmcXwQf0@sol.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 09, 2023 at 10:17:16PM -0800, Eric Biggers wrote:
> On Fri, Mar 10, 2023 at 02:07:34PM +0800, Yangtao Li wrote:
> > Just for better readability, no code logic change.
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >  fs/ext4/inode.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index d251d705c276..d121cde74522 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -2218,8 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
> >  {
> >  	struct inode *inode = mpd->inode;
> >  	int err;
> > -	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
> > -							>> inode->i_blkbits;
> > +	ext4_lblk_t blocks = DIV_ROUND_UP(i_size_read(inode), i_blocksize(inode));
> >  
> 
> Please don't do this.  This makes the code compile down to a division, which is
> far less efficient.  I've verified this by checking the assembly generated.

Which compiler is doing that?
