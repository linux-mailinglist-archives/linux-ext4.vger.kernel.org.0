Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA2E746384
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jul 2023 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjGCTsz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jul 2023 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGCTsy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Jul 2023 15:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD73E5F
        for <linux-ext4@vger.kernel.org>; Mon,  3 Jul 2023 12:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C19961022
        for <linux-ext4@vger.kernel.org>; Mon,  3 Jul 2023 19:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A307DC433C7;
        Mon,  3 Jul 2023 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688413732;
        bh=mQK57MYARnGfMLHbFPXu1UYpc/m5RIH3DDEC7ujywEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGD+NcwEUocrYGI6kpAG76OVw8NmlrJZg7LCT5ycRSGXZjkyfhCYuiy6YpJKzN0+m
         dxcAk9MIA7AQS2Fr1ha/N9eztLEDm+nirgbxeA1/emw7WJrllJaHoe/X9/vRi43SwU
         Sh/FPotB/QE3xVwnIVvfZCHz6H2OObggqbQSep5HrCKbEVFt3Hv7SA8hqAqYSlY5PX
         Y7UFaKcYRP9SDedC2NZCnWMNbLbtnhWGCvlaaXxwIr/nixtOiGjsLCh3sWnfqFjhhZ
         lMts+uPRnOEqahMZbIAAbqI2NL53/17sB2ylicavijCFwac6DPHOVB7zhkZ60+BVxu
         FfUtXdbCiI0jw==
Date:   Mon, 3 Jul 2023 12:48:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: Question regarding the use of CRC32c for checksumming
Message-ID: <20230703194850.GF1194@sol.localdomain>
References: <CAKbZUD01uR5kfP4=SSfQ111jKsfKi8ojfDZs5CStLD_h5qb5GQ@mail.gmail.com>
 <20230628045206.GA1908@sol.localdomain>
 <20230628185832.GK11467@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628185832.GK11467@frogsfrogsfrogs>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 28, 2023 at 11:58:32AM -0700, Darrick J. Wong wrote:
> > As far as I can tell, you are correct that ext4's CRC32C is just a raw CRC.  It
> > doesn't do the bitwise inversion at either the beginning or end.
> 
> Yep.  
> 
> > IMO, this is a mistake.  In the design of CRCs, doing these inversions is
> > recommended to strengthen the CRC slightly.
> 
> Yep.  I wondered about that too back in the day (see below).
> 
> > However, it's also a common "mistake" to leave them out, and not too important,
> > especially if many of the messages checksummed are fixed-length structures.
> > 
> > Yes, if ext4 had used the kernel crypto API "properly", with crypto_shash_init()
> > + crypto_shash_update() + crypto_shash_final(), it would have gotten the
> > inversion at the beginning and end.  (Note, this is true for "crc32c" but not
> > "crc32".  The crypto API isn't consistent about its CRC conventions.)
> 
> 15 years ago when Ted and I first started talking about adding checksums
> to metadata blocks, we looked at what other parts of the kernel did, and
> stumbled upon lib/libcrc32c.c:
> 
> u32 crc32c(u32 crc, const void *address, unsigned int length)
> {
>         SHASH_DESC_ON_STACK(shash, tfm);
>         u32 ret, *ctx = (u32 *)shash_desc_ctx(shash);
>         int err;
> 
>         shash->tfm = tfm;
>         *ctx = crc;
> 
>         err = crypto_shash_update(shash, address, length);
>         BUG_ON(err);
> 
>         ret = *ctx;
>         barrier_data(ctx);
>         return ret;
> }
> EXPORT_SYMBOL(crc32c);
> 
> This looked like a handy crc32c library function that we could use to
> avoid dealing with the crypto api.  I noticed way back then that it
> didn't invert the outcome, but Ted and I decided it wasn't a big deal.
> btrfs and XFS both used this library function in the same way.
> 
> Eventually someone else (Andreas, maybe?) piped up to suggest that
> ext4/jbd2 should load the crc32{,c} driver dynamically to avoid a hard
> dependency on crc32 if the user is only running old filesystems, so we
> did end up using the crypto api directly.  Unfortunately, ext4 can't
> call the shash finalizer to invert the crc because that'll break the
> ondisk format.
> 
> > But I'd also think of ext4's direct use of crypto_shash_update() as less of ext4
> > taking a shortcut or hack, and more of ext4 just having to work around the
> > kernel crypto API being very clunky and inefficient for use cases like this...
> 
> At the time I thought that libcrc32c.c was a convenient shim for anyone
> who didn't want to deal with the clunky crypto api.  It would have
> really helped me to have had documentation of the preconditions (start
> with ~0) and postconditions (invert the return value of the last call)
> to nudge me into using this function correctly, because expecting
> callers also to be really smart about crc32c as an alternative to
> written guidelines is ... idiotic^WLKML.
> 
> An example of how to do a buffer would have helped:
> 
> static inline u32 crc32c_buffer(const void *address, unsigned int length)
> {
> 	return ~crc32c(~0U, address, length);
> }

IMO the best API for CRC's is like zlib's where you pass in 0 to start the CRC
and it does both the pre and post inversions for you.  Note, "updates" still
work as expected, since two inversions cancel each other out.

Unfortunately, many but not all of the CRC APIs in Linux decided to go with the
other convention, which is to leave the inversions entirely to the caller.

I think the kernel should also make the architecture-specific CRC
implementations accessible directly via a library API, similar to what's done
for Blake2s and ChaCha20.  There should be no need to go through shash at all...

> 
> This misuse could be fixed, but you'd have to burn an incompat flag to
> do it.  I'm less smart about crc32* than I was back in 2008, so I also
> don't have the skills to figure out if the correction is worth the cost.
> 
> --D

No, it's not worth changing the ext4 on-disk format for this.

- Eric
