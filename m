Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620DC6D8C1C
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 02:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDFAoj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 20:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDFAoi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 20:44:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6FF199C;
        Wed,  5 Apr 2023 17:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B5E264265;
        Thu,  6 Apr 2023 00:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21089C433D2;
        Thu,  6 Apr 2023 00:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680741876;
        bh=zN0uoPG2wy3vEMLhzgjqbmHAqYYQld3AbN2XunzMIoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bo8p3D+S8WueWIQeyXVhF9VsXJIkX3mi7lCuHYZ7OixWNIVgwe52hWCGQTCpabGiY
         6mT1eHjUq2EedAyyBTpNdvhDNGB7ja0pxmv+2hAT4IOl/D6gtx0cKQGX4OsM8OaIJL
         qJbARzdhdEgqxF6P1iYB779hRD2iIfLqS229fGaWr23fMFpB+goPahUZxXr2Z0B7Lo
         U2dQSQsuy/cHfeInl7U1BHZohgOtSGQJM5WZTpux93iA31XE6NFlO2xoLtnQbmkcjC
         vNwntPVZYgHRIbIIfX+e89u8Evn868NI0UF/wcOyIkteZXz1d3WIzEoABhr37UZz1i
         A4vZrijh7VmiQ==
Date:   Wed, 5 Apr 2023 17:44:34 -0700
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
Message-ID: <20230406004434.GA879@sol.localdomain>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-22-aalbersh@redhat.com>
 <20230404163602.GC109974@frogsfrogsfrogs>
 <20230405160221.he76fb5b45dud6du@aalbersh.remote.csb>
 <20230405163847.GG303486@frogsfrogsfrogs>
 <ZC264FSkDQidOQ4N@gmail.com>
 <20230405222646.GR3223426@dread.disaster.area>
 <ZC38DkQVPZBuZCZN@gmail.com>
 <20230405233753.GU3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405233753.GU3223426@dread.disaster.area>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 06, 2023 at 09:37:53AM +1000, Dave Chinner wrote:
> On Wed, Apr 05, 2023 at 10:54:06PM +0000, Eric Biggers wrote:
> > On Thu, Apr 06, 2023 at 08:26:46AM +1000, Dave Chinner wrote:
> > > > We could certainly think about moving to a design where fs/verity/ asks the
> > > > filesystem to just *read* a Merkle tree block, without adding it to a cache, and
> > > > then fs/verity/ implements the caching itself.  That would require some large
> > > > changes to each filesystem, though, unless we were to double-cache the Merkle
> > > > tree blocks which would be inefficient.
> > > 
> > > No, that's unnecessary.
> > > 
> > > All we need if for fsverity to require filesystems to pass it byte
> > > addressable data buffers that are externally reference counted. The
> > > filesystem can take a page reference before mapping the page and
> > > passing the kaddr to fsverity, then unmap and drop the reference
> > > when the merkle tree walk is done as per Andrey's new drop callout.
> > > 
> > > fsverity doesn't need to care what the buffer is made from, how it
> > > is cached, what it's life cycle is, etc. The caching mechanism and
> > > reference counting is entirely controlled by the filesystem callout
> > > implementations, and fsverity only needs to deal with memory buffers
> > > that are guaranteed to live for the entire walk of the merkle
> > > tree....
> > 
> > Sure.  Just a couple notes:
> > 
> > First, fs/verity/ does still need to be able to tell whether the buffer is newly
> > instantiated or not.
> 
> Boolean flag from the caller.
> 
> > Second, fs/verity/ uses the ahash API to do the hashing.  ahash is a
> > scatterlist-based API.  Virtual addresses can still be used (see sg_set_buf()),
> > but the memory cannot be vmalloc'ed memory, since virt_to_page() needs to work.
> > Does XFS use vmalloc'ed memory for these buffers?
> 
> Not vmalloc'ed, but vmapped. we allocate the pages individually, but
> then call vm_map_page() to present the higher level code with a
> single contiguous memory range if it is a multi-page buffer.
> 
> We do have the backing info held in the buffer, and that's what we
> use for IO. If fsverity needs a page based scatter/gather list
> for hardware offload, it could ask the filesystem to provide it
> for that given buffer...
> 
> > BTW, converting fs/verity/ from ahash to shash is an option; I've really never
> > been a fan of the scatterlist-based crypto APIs!  The disadvantage of doing
> > this, though, would be that it would remove support for all the hardware crypto
> > drivers.
> >
> > That *might* actually be okay, as that approach to crypto acceleration
> > has mostly fallen out of favor, in favor of CPU-based acceleration.  But I do
> > worry about e.g. someone coming out of the woodwork and saying they need to use
> > fsverity on a low-powered ARM board that has a crypto accelerator like CAAM, and
> > they MUST use their crypto accelerator to get acceptable performance.
> 
> True, but we are very unlikely to be using XFS on such small
> systems and I don't think we really care about XFS performance on
> android sized systems, either.
> 

FYI, I've sent an RFC patch that converts fs/verity/ from ahash to shash:
https://lore.kernel.org/r/20230406003714.94580-1-ebiggers@kernel.org

It would be great if we could do that.  But I need to get a better sense for
whether anyone will complain...

- Eric
