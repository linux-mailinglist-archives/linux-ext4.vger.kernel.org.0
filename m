Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E552741882
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 21:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjF1TAt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 15:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjF1S7V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 14:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8D294B
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 11:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C1D96143F
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 18:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6581AC433C0;
        Wed, 28 Jun 2023 18:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687978714;
        bh=qc1movIO0616oNEo4ZSioGKFcx/B1Mv71Zy9VS0PFfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aOqsL7x0E6liFZErQwN2zoJ1jsJqwPhPorPnK53lM1hRKCs75yVWYWO7X0LR8Nd7b
         qIthAxfuigqpbEM/aWHiokhhT2J8mU0f0MpDeXNEQsNCGtnlf2IvIXRVCnDu5IiKPP
         vuCQPrYaAuKkn0bROzyk2466pU7ZesdFs2Z85ZYys8Co/Ta80bB49vXcMvp9ZKzovP
         l68DxY1ZS1puV8WXojzc/hFfbSRG0+MbvsBcEVn1IuOqAduOQsG4j/FzSjodQTirxX
         hW4IE/34gAnJua6fKjc9z7lrlc+H5z3tkNsHSLe25hwPyQk6lMy5mwH+vDsQ38gxgl
         uVuwutsJ05t+A==
Date:   Wed, 28 Jun 2023 11:58:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: Question regarding the use of CRC32c for checksumming
Message-ID: <20230628185832.GK11467@frogsfrogsfrogs>
References: <CAKbZUD01uR5kfP4=SSfQ111jKsfKi8ojfDZs5CStLD_h5qb5GQ@mail.gmail.com>
 <20230628045206.GA1908@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628045206.GA1908@sol.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 27, 2023 at 09:52:06PM -0700, Eric Biggers wrote:
> Hi Pedro,
> 
> On Mon, Jun 26, 2023 at 09:17:10PM +0100, Pedro Falcato wrote:
> > Hi,
> > 
> > (+CC the original author, Darrick)
> > I've been investigating (in the context of my EFI ext4 driver) why all
> > ext4 checksums appear inverted. After making sure my CRC32c
> > implementation was correct and up-to-par with other ones, I looked at
> > the fs/ext4 checksumming code, which took me to the implementation of
> > ext4_chksum in ext4.h (excuse the gmail whitespace damage):
> > 
> > >static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
> > >       const void *address, unsigned int length)
> > >{
> > > struct {
> > > struct shash_desc shash;
> > > char ctx[4];
> > > } desc;
> > 
> > Open coding the crc32c crypto driver's internal state, seemingly to save a call?
> > >
> > > BUG_ON(crypto_shash_descsize(sbi->s_chksum_driver)!=sizeof(desc.ctx));
> > >
> > > desc.shash.tfm = sbi->s_chksum_driver;
> > > *(u32 *)desc.ctx = crc;
> > 
> > ...we set the starting CRC
> > >
> > > BUG_ON(crypto_shash_update(&desc.shash, address, length));
> > 
> > then call update, which keeps the current internal state in ctx[4]
> > >
> > > return *(u32 *)desc.ctx;
> > 
> > and then we never call ->final() (nor ->finup()), which for crc32c would do:
> > > put_unaligned_le32(~ctx->crc, out);
> > 
> > and as such get me the properly "inverted" crc32c I would expect.
> > FreeBSD never found this issue as their calculate_crc32c seems borked
> > too, and never inverts the result.
> > 
> > Is my assessment correct? Was ->final() never called on purpose, or is
> > it an accident? Or is this merely a CRC32c variation I'm unaware of?
> > 
> > I'd like to make sure I get all the context on this, before sending
> > any kind of documentation patch :)
> > 
> > Thanks,
> > Pedro
> 
> As far as I can tell, you are correct that ext4's CRC32C is just a raw CRC.  It
> doesn't do the bitwise inversion at either the beginning or end.

Yep.  

> IMO, this is a mistake.  In the design of CRCs, doing these inversions is
> recommended to strengthen the CRC slightly.

Yep.  I wondered about that too back in the day (see below).

> However, it's also a common "mistake" to leave them out, and not too important,
> especially if many of the messages checksummed are fixed-length structures.
> 
> Yes, if ext4 had used the kernel crypto API "properly", with crypto_shash_init()
> + crypto_shash_update() + crypto_shash_final(), it would have gotten the
> inversion at the beginning and end.  (Note, this is true for "crc32c" but not
> "crc32".  The crypto API isn't consistent about its CRC conventions.)

15 years ago when Ted and I first started talking about adding checksums
to metadata blocks, we looked at what other parts of the kernel did, and
stumbled upon lib/libcrc32c.c:

u32 crc32c(u32 crc, const void *address, unsigned int length)
{
        SHASH_DESC_ON_STACK(shash, tfm);
        u32 ret, *ctx = (u32 *)shash_desc_ctx(shash);
        int err;

        shash->tfm = tfm;
        *ctx = crc;

        err = crypto_shash_update(shash, address, length);
        BUG_ON(err);

        ret = *ctx;
        barrier_data(ctx);
        return ret;
}
EXPORT_SYMBOL(crc32c);

This looked like a handy crc32c library function that we could use to
avoid dealing with the crypto api.  I noticed way back then that it
didn't invert the outcome, but Ted and I decided it wasn't a big deal.
btrfs and XFS both used this library function in the same way.

Eventually someone else (Andreas, maybe?) piped up to suggest that
ext4/jbd2 should load the crc32{,c} driver dynamically to avoid a hard
dependency on crc32 if the user is only running old filesystems, so we
did end up using the crypto api directly.  Unfortunately, ext4 can't
call the shash finalizer to invert the crc because that'll break the
ondisk format.

> But I'd also think of ext4's direct use of crypto_shash_update() as less of ext4
> taking a shortcut or hack, and more of ext4 just having to work around the
> kernel crypto API being very clunky and inefficient for use cases like this...

At the time I thought that libcrc32c.c was a convenient shim for anyone
who didn't want to deal with the clunky crypto api.  It would have
really helped me to have had documentation of the preconditions (start
with ~0) and postconditions (invert the return value of the last call)
to nudge me into using this function correctly, because expecting
callers also to be really smart about crc32c as an alternative to
written guidelines is ... idiotic^WLKML.

An example of how to do a buffer would have helped:

static inline u32 crc32c_buffer(const void *address, unsigned int length)
{
	return ~crc32c(~0U, address, length);
}

This misuse could be fixed, but you'd have to burn an incompat flag to
do it.  I'm less smart about crc32* than I was back in 2008, so I also
don't have the skills to figure out if the correction is worth the cost.

--D

> - Eric
