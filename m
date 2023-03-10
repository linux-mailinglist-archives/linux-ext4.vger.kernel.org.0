Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1FC6B36C4
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 07:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCJGnX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 01:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCJGnV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 01:43:21 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1EA5D262;
        Thu,  9 Mar 2023 22:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W3BRkIY6g9HQ9/MOc7ImY4uBDK8aiz27YDmXGLLIyDE=; b=XB7Jt1RjFQM/wIVvA1TqdQTaPD
        BJc7e/jG0kqf2Rsm0Mv/W0L2NXG9Ntc6m40wcC5Vaj9EV+6iZzptU2kX/NKcUKXw85j6WmAkLqN8n
        YEUbOOGT63BU6pyYYtS2VgToHwymu+7cEY24bXOG8a2F0Sgb/Rq9vcmxbeBfnKpdxcYV+ZdQzsLD+
        KCv9HfVhhBb0JGuPi/GcIXAItu80EBqMRfzOM7a+T6Og1WF6Q2+5JmT/HshV8skyTIp4TLHF/9Max
        RRhfuj18pxvlzcCan4VfUV/nfr0LgsEf0UC1lC14CMDJ/5dnrs13eznPQUBOv/WaA1Y3UEzWpTZ4X
        siK4zbfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paWTA-00FEBB-1r;
        Fri, 10 Mar 2023 06:43:12 +0000
Date:   Fri, 10 Mar 2023 06:43:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Message-ID: <20230310064312.GP3390869@ZenIV>
References: <20230310060734.8780-1-frank.li@vivo.com>
 <ZArLbO1ckmcXwQf0@sol.localdomain>
 <20230310063729.GO3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310063729.GO3390869@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

While we are at it, replace
        return (1 << node->i_blkbits);
with
        return (1u << node->i_blkbits);

and see if that changes the things.
