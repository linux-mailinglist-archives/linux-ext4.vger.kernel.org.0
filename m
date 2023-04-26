Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBF56EFDEA
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Apr 2023 01:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbjDZXMw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 19:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjDZXMv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 19:12:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989E30DA
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 16:12:45 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33QNC4rL018996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 19:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682550727; bh=a28AE7O4X83WWFRQ6/mRv8wwHivs9drRMGuAgV2hNZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kY28SrgCLZILV53+lsfg5h5l4QnFMhzMkUbS0hwj0iZDGfLlswNTyZ2M31mmjDvJw
         ifLN2AaAgKQKDA43ZILHlq2+tJl/xEC/dGageHbtWrvOC8KfQvO+IxJngJPeudtbD+
         Hx86xFyGSUkznglbZHZWlImznZY2MWZ2L2PZ2gxLUMsnOb/h0Wm0c5JacwJcwM8yE9
         YZRpbkgG6hL56MW2lj0/xLKMntGZ74EvoK0mNviWl6fPbfpJ40lteUNViJ+bp41OA5
         hmTCRvNC32iQoOIpTENMRjv9qooe7XZIzYMDmh5dG43++p8qTwj3zryE1WoDQs3uUe
         +nX8+YLtZSWaA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id CC6718C01FA; Wed, 26 Apr 2023 19:12:03 -0400 (EDT)
Date:   Wed, 26 Apr 2023 19:12:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
Message-ID: <ZEmvw4x+M+4kgENG@mit.edu>
References: <20230425041838.GA150312@mit.edu>
 <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <ZEl3QmF1PYXKaBTz@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEl3QmF1PYXKaBTz@casper.infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 26, 2023 at 08:10:58PM +0100, Matthew Wilcox wrote:
> 
> This feels like something smatch could catch.  Adding Dan.
> 
> Unfortunately, I don't know that we have any buildbots that run smatch,
> and most developers don't, so it'll always be an after-the-fact patch
> to fix it rather than "anybody using W=1" or "anybody using C=1" will
> catch it before it gets anywhere near a maintainer.

Well, if we can ask Mark Brown to run smatch on linux-next, we can
catch most of these things quickly; in fact, this would have been
*only* caught on linux-next, since in this case, we got caught out by
a change in a function signature happening in one tree, and a new use
of that function in another tree.

Is this something that we could teach sparse to catch?

   		       	  	      	     	- Ted
