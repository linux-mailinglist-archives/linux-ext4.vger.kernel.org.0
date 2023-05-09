Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86E36FCDE6
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjEISh1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 14:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjEISh1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 14:37:27 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D330FB
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 11:37:24 -0700 (PDT)
Received: from letrec.thunk.org (vancouverconventioncentre.com [72.28.92.215] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 349IaooI014738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 14:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683657413; bh=1j6ji9UCx2/3txxUx40NTRJzfKr+ZjDdH02fnGV2SzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=F75nBwgCQWasmfxBM5M79VeXUwaU57kxXHJ7gi4jqK29koQwBvtapxqhhsX7PfyIW
         ajNTm0tbE2F6edZOGP8euCw7cH91Fmy5G5W+L6UFwKbi2nGQJguqew4OjRrwUILUi+
         9e1Bj9673MElmer/qV5L4MZZn6tgEMNV3zPLWnIXMIpZPix5eIHjKlps60edgxERPT
         V4dGm9yJt9sja/VNoG2GGCKWjLLYhI4yCz3yl8JrKTdYIyfusOGF0Wq5hKDv/vrJ3S
         /WSxaFUjOEEPM23w22Tq7REKBi+pghLsonNF12NxAoexEhNW4Nf4NEdVMghTjPI4EI
         HrNEdqwz+IeXQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 719818C03CB; Tue,  9 May 2023 14:36:49 -0400 (EDT)
Date:   Tue, 9 May 2023 14:36:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     youling257 <youling257@gmail.com>, jack@suse.cz, hch@infradead.org,
        hch@lst.de, linux-ext4@vger.kernel.org, ritesh.list@gmail.com,
        keescook@chromium.org
Subject: Re: [PATCH v4 12/13] ext4: Stop providing .writepage hook
Message-ID: <ZFqSwegsnsqi3vAu@mit.edu>
References: <20221207112722.22220-12-jack@suse.cz>
 <20230508175108.6986-1-youling257@gmail.com>
 <20230509050227.GA1180@quark.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509050227.GA1180@quark.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 08, 2023 at 10:02:27PM -0700, Eric Biggers wrote:
> On Tue, May 09, 2023 at 01:51:08AM +0800, youling257 wrote:
> > I using linux mainline kernel on android. https://github.com/youling257/android-mainline/commits/6.4  https://github.com/youling257/android-mainline/commits/6.3
> > "ext4: Stop providing .writepage hook" cause some android app unable to read storage/emulated/0 files, i need to say android esdfs file system storage/emulated is ext4 data/media bind mount.
> > I want to ask, why android storage/emulated need .writepage hook?
> 
> "esdfs" doesn't exist upstream, so linux-ext4 can't provide support for it.
> 
> Also, it doesn't exist in the Android Common Kernels either, so the Android team
> cannot help you either.

The problem with esdfs is that it's based on the old stackable file
system paradigm which is filled with races and is inherently
unreliable (just for fun, try running fsstress on the upper and lower
file systems of a stackable file system simultaneously, and watch the
kernel crash and burn).  For that reason, some number of us have been
working for a while to eliminate the need for stacking file systems,
such as sdcardfs. esdfs, etc. from the Android kernel.

The other thing I would add is that upstream has been working[1] on
getting rid of writepage function.  So out-of-tree file systems are
going to need to adapt --- or die.

[1] https://lore.kernel.org/all/20221202102644.770505-1-hch@lst.de/

It looks like esdfs is coming from the Chromium kernel?  The latest
Chromium kernel I can find is 5.15 based, and it has esdfs in it.  I'm
sad to see that esdfs hasn't been removed from the Chromium kernel
yet, and replaced with something more stable and reliable, but maybe
we can find someone who is more familiar with the Chromium kernel to
comment.

Cheers,

						- Ted
