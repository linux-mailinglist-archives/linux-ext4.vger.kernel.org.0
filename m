Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528426DB497
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Apr 2023 21:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjDGT4s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Apr 2023 15:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjDGT4r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Apr 2023 15:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA2EAD38;
        Fri,  7 Apr 2023 12:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 584E565316;
        Fri,  7 Apr 2023 19:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E35C433D2;
        Fri,  7 Apr 2023 19:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680897397;
        bh=/3ooAeWJ2heTTSe1+fowce2OJCbJkwMvCSSAiGy5dOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clCdqAdSzIuv2Nh0psGWcWmbbwrVRtKcUMCziwd5jIFOLppq8+hvEMy6JY4RJLPMp
         x59uWAeV4ig4ih4U7jNLyVsnpfqrD7RpPe3yfp1MP72D2FoXdLnTk3xUAdXqNiTo76
         7873hQHGayV2JBek9f5U/Qb89gRu184TbrlBQn0ysEteLtxdwRM5mb1J34RmFP0nuB
         8OYIQ3NfXnHpi+fJ2/tbB2xh0PRWi+ynfmrw1NaYWHy7dBecQ4XC5MBSI2cP1pxqcR
         lMdFOAY4ytF24DuMMy3hoLnO4nDVkkibtBGuHd2D5IXcvpFkh35CRNw0rf+xT87I1L
         SBA+hcx/gQt+g==
Date:   Fri, 7 Apr 2023 19:56:36 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrey Albershteyn <aalbersh@redhat.com>, dchinner@redhat.com,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 21/23] xfs: handle merkle tree block size != fs
 blocksize != PAGE_SIZE
Message-ID: <ZDB1dPVjon4Qthok@gmail.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
 <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
 <20230405163847.GG303486@frogsfrogsfrogs>
 <ZC264FSkDQidOQ4N@gmail.com>
 <20230405222646.GR3223426@dread.disaster.area>
 <ZC38DkQVPZBuZCZN@gmail.com>
 <20230405233753.GU3223426@dread.disaster.area>
 <20230406004434.GA879@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406004434.GA879@sol.localdomain>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 05:44:36PM -0700, Eric Biggers wrote:
> > Not vmalloc'ed, but vmapped. we allocate the pages individually, but
> > then call vm_map_page() to present the higher level code with a
> > single contiguous memory range if it is a multi-page buffer.
> > 
> > We do have the backing info held in the buffer, and that's what we
> > use for IO. If fsverity needs a page based scatter/gather list
> > for hardware offload, it could ask the filesystem to provide it
> > for that given buffer...
> > 
> > > BTW, converting fs/verity/ from ahash to shash is an option; I've really never
> > > been a fan of the scatterlist-based crypto APIs!  The disadvantage of doing
> > > this, though, would be that it would remove support for all the hardware crypto
> > > drivers.
> > >
> > > That *might* actually be okay, as that approach to crypto acceleration
> > > has mostly fallen out of favor, in favor of CPU-based acceleration.  But I do
> > > worry about e.g. someone coming out of the woodwork and saying they need to use
> > > fsverity on a low-powered ARM board that has a crypto accelerator like CAAM, and
> > > they MUST use their crypto accelerator to get acceptable performance.
> > 
> > True, but we are very unlikely to be using XFS on such small
> > systems and I don't think we really care about XFS performance on
> > android sized systems, either.
> > 
> 
> FYI, I've sent an RFC patch that converts fs/verity/ from ahash to shash:
> https://lore.kernel.org/r/20230406003714.94580-1-ebiggers@kernel.org
> 
> It would be great if we could do that.  But I need to get a better sense for
> whether anyone will complain...

FWIW, dm-verity went in the other direction.  It started with shash, and then in
2017 it was switched to ahash by https://git.kernel.org/linus/d1ac3ff008fb9a48
("dm verity: switch to using asynchronous hash crypto API").

I think that was part of my motivation for using ahash in fsverity from the
beginning.

Still, it does seem that ahash is more trouble than it's worth these days...

- Eric
