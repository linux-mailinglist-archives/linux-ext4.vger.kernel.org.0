Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25C76FCE09
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 20:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjEISyF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 14:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEISyE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 14:54:04 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1B83C15
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 11:53:59 -0700 (PDT)
Received: from letrec.thunk.org (vancouverconventioncentre.com [72.28.92.215] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 349Irg9g026634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 14:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683658426; bh=KZxEablCgEx3gfZJr0RJObjL9zAKTAvOj4M64WHGy50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=T0Ymu5peezw+ttc+oZOtm7QdJfWjzldInNAKBP4QuKy7qNWUaBdSywgqWIwiPk6Xw
         fwaWO6w3M13oXTClaJXn8lxIi5AfNQ1vkJ0zcPd5+qh9hRpJyTM44xq/hRD4+9OAGP
         LNQO+0cSPK9re2Tg0Tb2L4h075MUiHsgoKFv3di7rvnDBckTAUP8KPipUzZN5Uoy0/
         f11TpWDjH465j49mXYPUJAK6I4Mr1lSv83FNpcyQVEhRRq7UZBK4LgqGF7rXQhxVvJ
         gSbxYXVgdGZ13lDlRHAL4dx1YLAtf0rm23+93KXsf4qM7FM2pY1oXU5ASGCS4KynMi
         GA4a2O8xR4liw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 2E99D8C03CB; Tue,  9 May 2023 14:53:41 -0400 (EDT)
Date:   Tue, 9 May 2023 14:53:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, linux-mm@kvack.org
Subject: Re: [PATCH] ext4: remove superfluous check that pointer is not NULL
Message-ID: <ZFqWtcmRwxhyem4p@mit.edu>
References: <20230508151337.79304-1-tudor.ambarus@linaro.org>
 <ZFkf/oJnCLZSWgYr@mit.edu>
 <ZFll93wsEUZIV/aI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFll93wsEUZIV/aI@casper.infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 08, 2023 at 10:13:27PM +0100, Matthew Wilcox wrote:
> > 
> > I was looking at this just a few weeks ago, and I couldn't find any
> > actual *documentation* that it was safe to call vfree(NIILL) or
> > kvfree(NULL).  The problem is there are a lot of architecture-specific
> > functions, and unlike with kfree() there is no top-level "if (ptr ==
> > NULL) return;" in the top-level vfree() and kvfree().
> 
> There doesn't need to be in kvfree().  is_vmalloc_addr() returns 'false'
> for NULL, so it calls kfree(), which as you note has an explicit check
> for ZERO_OR_NULL_PTR().  is_vmalloc_addr() also returns false for the
> ZERO pointer, fwiw.
> 
> I agree that this should be explicitly documented as allowed, since it's
> not reasonable to expect users to dig through these functions to verify
> that such a change is safe.

I seem to recall at one point looking at kvfree_rcu (at least the one
argument variant), and I *thought* it would unconditionally allocate
memory so it could be put on a linked list to be freed after an RCU
grace period had elapsed.  But I tried tracing through the huge
numbers of cpp macros and other layers of #ifdef's and other
abstractions, and in my conference-induced sleep depreviation, it
caused my head to spin, and I gave up trying to trace it down so I had
100% confidence.

So if someone could document *all* of the k[v]free_* variants whether
it is safe/optimal to pass NULL to them, that would be great, thanks.

						- Ted
