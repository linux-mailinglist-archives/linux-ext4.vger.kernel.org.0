Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23E740B90
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjF1Ic3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 04:32:29 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:37900 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjF1I3t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 04:29:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 204B26126D
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 04:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BAEC433C0;
        Wed, 28 Jun 2023 04:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687927928;
        bh=jwatz+rto1S/6MwsHg3Gwt8EWKIb1yJNk+UPEFu98Lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RotoMZoZ/Y6lALRDWf6kxWyAChVze3qa1cXVwEZ025gQAh4/ojQN8feWMFtEzLxC2
         BWzC+jCkJtV7CEaXd3fJW/WYFi9+FAM0bVvUnz7rF7cwT9mmumyNrYxdv95y0rghL3
         t2whU90fDxvGmXcfzuQrdMUzxmeCB3fe2Bm+ZNXm74ZKtE5f2D5p1tFZnqPePQAZcv
         nXtaaMqA94aI+HUC8r52GIRpCadJCNz9ZbW9oy5+ORgEnhwgINBtHyYiPjWEAXEo4V
         z/X1Qqc8CBKsDkoCAS/PwJo5WrvunYtX42C5eOWw++AYk66C2hUUhDi3CUfY/X5E/U
         XjXJjhRFJ7cbA==
Date:   Tue, 27 Jun 2023 21:52:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     linux-ext4@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: Question regarding the use of CRC32c for checksumming
Message-ID: <20230628045206.GA1908@sol.localdomain>
References: <CAKbZUD01uR5kfP4=SSfQ111jKsfKi8ojfDZs5CStLD_h5qb5GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKbZUD01uR5kfP4=SSfQ111jKsfKi8ojfDZs5CStLD_h5qb5GQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Pedro,

On Mon, Jun 26, 2023 at 09:17:10PM +0100, Pedro Falcato wrote:
> Hi,
> 
> (+CC the original author, Darrick)
> I've been investigating (in the context of my EFI ext4 driver) why all
> ext4 checksums appear inverted. After making sure my CRC32c
> implementation was correct and up-to-par with other ones, I looked at
> the fs/ext4 checksumming code, which took me to the implementation of
> ext4_chksum in ext4.h (excuse the gmail whitespace damage):
> 
> >static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
> >       const void *address, unsigned int length)
> >{
> > struct {
> > struct shash_desc shash;
> > char ctx[4];
> > } desc;
> 
> Open coding the crc32c crypto driver's internal state, seemingly to save a call?
> >
> > BUG_ON(crypto_shash_descsize(sbi->s_chksum_driver)!=sizeof(desc.ctx));
> >
> > desc.shash.tfm = sbi->s_chksum_driver;
> > *(u32 *)desc.ctx = crc;
> 
> ...we set the starting CRC
> >
> > BUG_ON(crypto_shash_update(&desc.shash, address, length));
> 
> then call update, which keeps the current internal state in ctx[4]
> >
> > return *(u32 *)desc.ctx;
> 
> and then we never call ->final() (nor ->finup()), which for crc32c would do:
> > put_unaligned_le32(~ctx->crc, out);
> 
> and as such get me the properly "inverted" crc32c I would expect.
> FreeBSD never found this issue as their calculate_crc32c seems borked
> too, and never inverts the result.
> 
> Is my assessment correct? Was ->final() never called on purpose, or is
> it an accident? Or is this merely a CRC32c variation I'm unaware of?
> 
> I'd like to make sure I get all the context on this, before sending
> any kind of documentation patch :)
> 
> Thanks,
> Pedro

As far as I can tell, you are correct that ext4's CRC32C is just a raw CRC.  It
doesn't do the bitwise inversion at either the beginning or end.

IMO, this is a mistake.  In the design of CRCs, doing these inversions is
recommended to strengthen the CRC slightly.

However, it's also a common "mistake" to leave them out, and not too important,
especially if many of the messages checksummed are fixed-length structures.

Yes, if ext4 had used the kernel crypto API "properly", with crypto_shash_init()
+ crypto_shash_update() + crypto_shash_final(), it would have gotten the
inversion at the beginning and end.  (Note, this is true for "crc32c" but not
"crc32".  The crypto API isn't consistent about its CRC conventions.)

But I'd also think of ext4's direct use of crypto_shash_update() as less of ext4
taking a shortcut or hack, and more of ext4 just having to work around the
kernel crypto API being very clunky and inefficient for use cases like this...

- Eric
