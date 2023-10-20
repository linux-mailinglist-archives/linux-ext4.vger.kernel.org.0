Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056B17D171F
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Oct 2023 22:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjJTUgm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Oct 2023 16:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJTUgl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Oct 2023 16:36:41 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E093D68
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 13:36:40 -0700 (PDT)
Received: from localhost (88-113-24-34.elisa-laajakaista.fi [88.113.24.34])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 5d4b40fc-6f88-11ee-b972-005056bdfda7;
        Fri, 20 Oct 2023 23:36:37 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 20 Oct 2023 23:36:36 +0300
To:     Jan Kara <jack@suse.cz>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Baokun Li <libaokun1@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTLk1G0KCF7YNjRx@surfacebook.localdomain>
References: <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
 <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
 <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
 <ZTLHBYv6wSUVD/DW@smile.fi.intel.com>
 <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fri, Oct 20, 2023 at 12:43:56PM -0700, Linus Torvalds kirjoitti:
> On Fri, 20 Oct 2023 at 11:29, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > I'll reply to this with the attached object file, I assume it won't go to the
> > mailing list, but should be available in your mailbox.
> 
> Honestly, both cases (that function gets inlined twice) look
> *identical* from a quick look, apart from obviously the extra call to
> __quota_error().
> 
> I might be missing something, but this most definitely is not a "gcc
> ends up creating very different code when it doesn't need to
> synchronize around the call" thing.
> 
> So a compiler issue looks very unlikely. No absolute guarantees - I
> didn't do *that* kind of walk-through instruction by instruction - but
> the results actually seem to line up perfectly.
> 
> Even register allocation didn't change, making the compare between #if
> 0 and without rather easy.
> 
> There's one extra spill/reload due to the call in the "non-#if0" case,
> and that actually made me look twice (because it spilled %eax, and
> then reloaded it as %rcx), but it turns that %eax/%ecx had the same
> value at the time of the spill, so even that was not a "real"
> difference.
> 
> So I will claim that no, it's not the compiler. It's some unrelated
> subtle timing, or possibly just a random code layout issue (because
> the code addresses do obviously change).

Okay, but since now I can't use the certain configuration, the bug is
persistent to me after this merge with the GCC. Yet, you mentioned that
you would expect some reports but I don't think many people have a
configuration similar to what I have. In any case a bug is lurking somewhere
there.

Let me check next week on different CPU (but I'm quite sceptical that it
may anyhow trigger the same behaviour as if it's a timing, many parameters
are involved, including hardware clocks, etc).

That said, if you or anyone has ideas how to debug futher, I'm all ears!

-- 
With Best Regards,
Andy Shevchenko


