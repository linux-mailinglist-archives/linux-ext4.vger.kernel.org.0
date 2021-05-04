Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6B037308E
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 21:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhEDTPS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 15:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231604AbhEDTPR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 4 May 2021 15:15:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F25D61182;
        Tue,  4 May 2021 19:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620155662;
        bh=Zx2+hqA4KARRPapMlAyMsETfmj3AIod9FQAHTa1u81Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hL390PQriLNTnlMrUH+I0KZaX1NUSGEkZpdtQJDDWX5jgSpDjmzSsZq2p5SEyBeaU
         pfCqcNzxmp5rIg2BtkxqSccruvtPg5+KdWKXGKxMHBiR4nqmPqqhJ+W5L/v+G2R/ft
         S8qunqLBEbSmkFXlDa9Slv8VU1fSqlhVYfgRGHhFxXGKx511YGYjGsu+F6dZipD9qS
         q7JrDh/kvJp0Kz7feZgIhclGCAxfxph6jzYPoWOshVZ8wflexMIk6AelhVUx/MykTX
         Er17AU/dxJi9Wo1UFJa1RTjo7U3Iu1JrHlOZbWL9wJgco1oy9AwmC9msIu6NsJlWLR
         jgFkDU+rtF31Q==
Date:   Tue, 4 May 2021 12:14:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned
 accesses
Message-ID: <YJGdDHLcYuRajhsb@gmail.com>
References: <20210504031024.3888676-1-tytso@mit.edu>
 <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
 <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
 <YJFQ20rLK16rise2@mit.edu>
 <YJF6W7WHZBcVZexU@gmail.com>
 <CAD+ocby+01k9kx3-gEY_z+Ub9GFxi=AwxRS4Ax5-HUFDrVkT0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocby+01k9kx3-gEY_z+Ub9GFxi=AwxRS4Ax5-HUFDrVkT0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 04, 2021 at 10:55:44AM -0700, harshad shirwadkar wrote:
> > However, wouldn't it be easier to just add __attribute__((packed)) to the
> > definition of struct journal_block_tag_t?
> While we know that journal_block_tag_t can be unaligned, our code
> should still ensure that we are reading this struct in an
> alignment-safe way (like Ted's patch does). IIUC, using
> __attribute__((packed)) might result in us keeping the door open for
> unaligned accesses in future. If someone tries to read 4 bytes
> starting at &journal_block_tag_t->t_flags, with attribute packed,
> UBSAN won't complain but this may still cause issues on some
> architectures.

I don't understand your concern here.  Accesses to a packed struct are assumed
to be unaligned -- that's why I suggested it.  The packed attribute is pretty
widely used to implement unaligned accesses in C (as an alternative to memcpy()
or explicit byte-by-byte accesses, both of which also work, though the latter
seems to run into an UBSAN bug in this case).

- Eric
