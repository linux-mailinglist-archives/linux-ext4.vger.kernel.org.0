Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC207600CA
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 22:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjGXU56 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjGXU54 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 16:57:56 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBC51704
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 13:57:56 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net [173.48.116.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36OKvLP7032748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 16:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690232246; bh=VrnAa/A2r4LI/rEZJ68r1D+a4gLvUPEsrNotF0DM+RU=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Y73krL66ILxjt3i9efbK44U2rllrST4OmMfVPEq6wvleirGWt7mChjG8K0ng8Q4ZY
         nKghH590EWqcWbLwTN7wvCMuBeK8L2scIZWnCIbEiGdl7UQ87aakpAz5Zpq5UOXL89
         2SDXcRkyRlZ5wWtb+3deMuDJCsb+qSItrAh4jcNqD94CGu0tbKEkZjsKJukJmixFAj
         oaJxauz4gh0pvVFm3vgNBUTPibIpXEjBaJakjh0jz+MXI5qMaAc6/gcJa1ljYESi4G
         xJov1U3PAjbcgTIlMQsxwnyVef2FgWvDk7eoNNR25jiJ62KzyVLEDTk1s0l3pWeP1X
         ns2FfuMzBNpLQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 43A9815C04D9; Mon, 24 Jul 2023 16:57:21 -0400 (EDT)
Date:   Mon, 24 Jul 2023 16:57:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Su Hui <suhui@nfschina.com>, adilger.kernel@dilger.ca,
        nathan@kernel.org, trix@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: mballoc: avoid garbage value from err
Message-ID: <20230724205721.GA2504240@mit.edu>
References: <20230724054538.163319-1-suhui@nfschina.com>
 <CAKwvOdk-fdJr9TcgUnOhCiU0LvD2Qe_c+6YOe-c1k0Ukm+negA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk-fdJr9TcgUnOhCiU0LvD2Qe_c+6YOe-c1k0Ukm+negA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 24, 2023 at 10:19:02AM -0700, Nick Desaulniers wrote:
> >
> > err is uninitialized and will be judged when it enters the
> > loop first time and the condition "!ext4_sb_block_valid()"
> > is true. Although this can't make problems now, it's better
> > to correct it.
> >
> > Signed-off-by: Su Hui <suhui@nfschina.com>
> 
> Hi Su,
> Thanks for the patch!  I see what the warning is getting at;
> 
> If `len <= 0` then `err` is never initialized, then is used at line
> 4178 (that is UB).
> 
> Would you mind sending a v2 with the commit message updated to reflect
> the above points?  I'd be happy to sign-off on that.

Fortunately, as near as I can tell, ext4_mb_mark_bb() should never be
called with len <= 0.  It might be possible to trick ext4 via a
corrupted file system --- I'd have to take a closer look at that, but
fortunately, in the case where len <= 0, bitmap_bh will be NULL, so
regardless of whether err is 0, or some garbage non-zero value,
brelse(NULL) is a no-op.

So while it's good to avoid the clang warning, but the fact that it
might be possible for err to be a "garbage value" shouldn't be causing
any problem.

Cheers,

						- Ted
