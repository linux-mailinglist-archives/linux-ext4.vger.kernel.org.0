Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3409C673249
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 08:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjASHTa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Jan 2023 02:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjASHT3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Jan 2023 02:19:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD874ABE8
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 23:19:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 367F861B20
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 07:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552E9C433D2;
        Thu, 19 Jan 2023 07:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674112767;
        bh=93XXio76e/YigwF81sNXKrQdPxG7j/7P2AduQQFXHHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFXK25ZU9aR7r2lddTzUq9OVwZfNcGefvS896KUlHEPCJRYXOp4VrjNjt6nQSCvuT
         k0adC2IzPNxfrAwbA/r69HPAIm9xn/FogTmjRPvibePh5YVNMg+1xgAi6cuTZ2/7Fa
         5IggsVCt77ChIq+NjOkcy/KFj0fcHMq2GjvZ2bjepHpqfHtngzIayhHXUeOz+0jH1w
         9i4epp5l7tGvb0ndc45VjEV7MLg0aAlHqOoFBHu6r1e/orUZnGXAw70iMPnVxZfjhd
         /hW6myWzEYSbkG4bUE5UED8ymT9hnSkU1j/m56z2cCWm2s/ojOGfXmX10yzXs9kcP+
         aiXGR4iQmWQ0w==
Date:   Wed, 18 Jan 2023 23:19:24 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: Detecting default signedness of char in ext4 (despite
 -funsigned-char)
Message-ID: <Y8ju/CuPWA2lTR3W@sol.localdomain>
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca>
 <Y8dtze3ZLGaUi8pi@sol.localdomain>
 <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com>
 <Y8eAJIKikCTJrlcr@sol.localdomain>
 <Y8hUCIVImjqCmEWv@mit.edu>
 <CAHk-=wiGdxWtHRZftcqyPf8WbenyjniesKyZ=o73UyxfK9BL-A@mail.gmail.com>
 <Y8hpZRmHJwdutRr2@mit.edu>
 <3A9E6D2E-F98F-461C-834D-D4E269CC737F@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A9E6D2E-F98F-461C-834D-D4E269CC737F@dilger.ca>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 18, 2023 at 03:20:03PM -0700, Andreas Dilger wrote:
> > In terms of what should we do for next steps, if we only pick signed,
> > then it's possible if there are some edge case users who actually did
> > use non-ASCII characters in the xattr name on PowerPC, ARM, or S/390,
> > they would be broken.  That's simpler, and if we think there are
> > darned few of them, I guess we could do that.
> > 
> > That being said, it's not that much more work to use a flag in the
> > superblock to indicate whether or not we should be explicitly casting
> > *name to either a signed or unsigned char, and then setting that flag
> > automagically to avoid problems on people who started the file system
> > on say, x86 before the signed to unsigned char transition, and who
> > started natively on a PowerPC, ARM, or S/390.
> > 
> > The one bit which makes this a bit more complex is either way, we need
> > to change both the kernel and e2fsprogs, which is why if we do the
> > signed/unsigned xattr hash flag, it's important to set the flag value
> > to be whatever the "default" signeded would be on that architecture
> > pre 6.2-rc1.
> 
> It makes sense to use the existing UNSIGNED/SIGNED flag in the superblock
> for the dir hash also for the xattr hash.  That would give the historical
> value for the xattr hashes prior to the 6.2 unsigned char change, and is
> correct for all filesystems and xattrs *except* non-ASCII xattr names
> created on 6.2+ kernels (which should indeed be relatively few cases).
> 
> e2fsck could do the same, and would again be correct for all xattrs names
> except those created with kernel 6.2+.  It could check both the signed
> and unsigned forms and correct those few that are reversed compared to
> the superblock flag, which should be rare, but isn't much work and avoids
> incorrectly clearing the "corrupted" xattrs.

Reusing the existing SIGNED/UNSIGNED dirhash superblock flag wouldn't work in
the case where a filesystem is created on x86, then flashed to an ARM device.
That's exactly how Android works.  The dirhash is then explicitly SIGNED,
whereas the xattr hash is implicitly unsigned.

Yes, that case has always been broken if there were non-ASCII xattr names in the
filesystem to begin with, before it was flashed to the device.  That doesn't
really happen though.  What *is* plausible is that some random application
running on the device uses non-ASCII xattr names.

So to be safe, a new pair of SIGNED/UNSIGNED superblock flags for the xattr hash
would be needed.  The existing pair would be for the dirhash only.

- Eric
