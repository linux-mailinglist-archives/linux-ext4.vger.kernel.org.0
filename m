Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA1B6EFDF0
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Apr 2023 01:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbjDZXQc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 19:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjDZXQb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 19:16:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7833A9F
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 16:16:28 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33QNGGfR022410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 19:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682550979; bh=jPPNqKK/iEVCbAHYz5NaOt8zh8lOVVOfpxL1J3t+Tyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lK+GSX9W2dxse2HyFd8Jo6d+QKzGF9OlBj1oecrFz4S6AZ5ZGvYj0U29jK2r3rSvf
         y2TN2zWRzzB2lTP1HSeQnY0jMt0kqpisBLhDZNrhy817BlFlks+7Zv0bBXcO3PCQXm
         xqIeN3l6gl+qQOdokjB/nVcwI01CDenCOl1Y3LMD6O8NfoCc9wls0F1EUSqVI9GWFE
         XmnNqWZwPVUy1buWspkA61VQgO6+YC/Fzbo/22mPe1Im0l95a/gqOA/GE+Xb7jUohS
         vikK1LusV/6HXx2EHBKcO5zbLmR7/9McSFlyM8CGcXs8L/X9Tsj+dYps1DLFoz76jh
         97TRZyhe2Wegw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 9B5FD8C01FA; Wed, 26 Apr 2023 19:16:16 -0400 (EDT)
Date:   Wed, 26 Apr 2023 19:16:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
Message-ID: <ZEmwwJ9c3ube00Ug@mit.edu>
References: <20230425041838.GA150312@mit.edu>
 <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
 <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com>
 <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com>
 <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com>
 <CAKwvOdn3Unm94UCiXygWTM_KyhATNsy68b_CFbqBDFXshd+34Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn3Unm94UCiXygWTM_KyhATNsy68b_CFbqBDFXshd+34Q@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 26, 2023 at 03:07:48PM -0700, Nick Desaulniers wrote:
> Is this what you had in mind?
> ```
> $ cat linus.c
> #define NULL ((void*)0)
> 
> void * _Nonnull foo (void) {
>     return &foo;
> }
> 
> void bar (void) {
>     if (foo() == NULL) // maybe should warn that foo() returns _Nonnull?
>         bar();
> }
>
> $ clang linus.c -fsyntax-only
> linus.c:8:15: warning: comparison of _Nonnull function call 'foo'
> equal to a null pointer is always false

Ideally, the warning should also fire in this case:

    if (!foo()) {
    	bar();
    }

And of course, what if the code does this:

    p = foo();
    if (p) {
    	quux();
    }

Would these also be considered implicit comparisons to a NULL pointer?

	    	       	       	  - Ted

