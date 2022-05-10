Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDB952242D
	for <lists+linux-ext4@lfdr.de>; Tue, 10 May 2022 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbiEJSg3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 May 2022 14:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349106AbiEJSgW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 May 2022 14:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AFB50457;
        Tue, 10 May 2022 11:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B140160DF0;
        Tue, 10 May 2022 18:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED18EC385C2;
        Tue, 10 May 2022 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652207780;
        bh=vRlYcyDSWfWyjRka3YqXUxpx72aKcmWvtuE3ZI2eW6g=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=MON3fzAY2osPB5/7TsU9q2CAFh85n4s47bWXdjZLNFYG1cQipKrQIbIntmMwipCOq
         /YQ9ZLwTAt/gl8wM7I+3YgAUDaKR/2I9ivA2T52gxKQvZIMUoVtf1cvLEXrREC5mWc
         TNpvGRatKPEkZjJYU2jW1rcwA4IaPDAn2hvqCUiA2QDYJhXgoTbejhwK9Xb4tnT3AU
         L/mkCdPoBIoMhubjZf00mklLmheFqAh3mnu7klZReHuhvGg0T7QkzgU2TWEsEKKjJ4
         91qB7cuOJkOpmXidodXVT0J0gS66E9+Ixzj/fEh1BbdMsvkQoL7r6zCb0WJY35xrZi
         +LUs/UnH0+TNA==
Date:   Tue, 10 May 2022 11:36:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [xfstests PATCH] ext4/053: fix the rejected mount option testing
Message-ID: <Ynqwotv9lQvt3TV3@sol.localdomain>
References: <20220430192130.131842-1-ebiggers@kernel.org>
 <Ynmmy+bWp0Q1/747@sol.localdomain>
 <20220510094308.mhzvcgq5wrat5qao@fedora>
 <20220510154359.xfhmumcmb4o37qdy@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510154359.xfhmumcmb4o37qdy@zlang-mailbox>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 10, 2022 at 11:43:59PM +0800, Zorro Lang wrote:
> On Tue, May 10, 2022 at 11:43:08AM +0200, Lukas Czerner wrote:
> > On Mon, May 09, 2022 at 04:42:03PM -0700, Eric Biggers wrote:
> > > On Sat, Apr 30, 2022 at 12:21:30PM -0700, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > 'not_mnt OPTIONS' seems to have been intended to test that the
> > > > filesystem cannot be mounted at all with the given OPTIONS, meaning that
> > > > the mount fails as opposed to the options being ignored.  However, this
> > > > doesn't actually work, as shown by the fact that the test case 'not_mnt
> > > > test_dummy_encryption=v3' is passing in the !CONFIG_FS_ENCRYPTION case.
> > > > Actually ext4 ignores this mount option when !CONFIG_FS_ENCRYPTION.
> > > > (The ext4 behavior might be changed, but that is besides the point.)
> > > > 
> > > > The problem is that the do_mnt() helper function is being misused in a
> > > > context where a mount failure is expected, and it does some additional
> > > > remount tests that don't make sense in that context.  So if the mount
> > > > unexpectedly succeeds, then one of these later tests can still "fail",
> > > > causing the unexpected success to be shadowed by a later failure, which
> > > > causes the overall test case to pass since it expects a failure.
> > > > 
> > > > Fix this by reworking not_mnt() and not_remount_noumount() to use
> > > > simple_mount() in cases where they are expecting a failure.  Also fix
> > > > up some of the naming and calling conventions to be less confusing.
> > > > Finally, make sure to test that remounting fails too, not just mounting.
> > > > 
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > ---
> > > >  tests/ext4/053 | 148 ++++++++++++++++++++++++++-----------------------
> > > >  1 file changed, 78 insertions(+), 70 deletions(-)
> > > 
> > > Lukas, any thoughts on this patch?  You're the author of this test.
> > > 
> > > - Eric
> > 
> > Haven't tested it myself but the change looks fine, thanks.
> 
> Thanks for you help to review this patch. There's an new failure[1] after we
> merged this patch:
>   "SHOULD FAIL remounting ext2 "commit=7" (remount unexpectedly succeeded) FAILED"
> 
> As this test generally passed, so before I give "Oops" to others, I hope to
> check with you that if this's an expected failure we need to fix in kernel
> or in this case itself?
> 

This appears to be a kernel bug, so to fix it I've sent the patch
"ext4: reject the 'commit' option on ext2 filesystems"
(https://lore.kernel.org/r/20220510183232.172615-1-ebiggers@kernel.org).

I didn't notice this earlier because it's not reproducible with
CONFIG_EXT2_FS=y.  But it is reproducible with CONFIG_EXT2_FS=n and
CONFIG_EXT4_USE_FOR_EXT2=y.

- Eric
