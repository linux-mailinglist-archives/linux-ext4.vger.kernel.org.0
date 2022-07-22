Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BA057E5CC
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiGVRqI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 13:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiGVRqH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 13:46:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F312ED5A;
        Fri, 22 Jul 2022 10:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0BF2B829D7;
        Fri, 22 Jul 2022 17:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E327C341C6;
        Fri, 22 Jul 2022 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658511963;
        bh=XZZJmzeJO/5mk40jvpARF6vwsesp+pzNXLCOtSZI65Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oF79YoCi2IgeGTUYIDgHVMfWe9u4z1PIXD1k6fpjw0vmpUlQwkAy4wrFO/aTG71SR
         aRJNbpLp4jWA+kIAf/J7kjBixjOh1aNRNkSTgPlXzOtnDH8tFS3hHv+ss5xVbor6DI
         txLxprNUAnhHN5p6WU26cn2NCL47pSfWgD9sKW/p8gXKDgNkblHiT4Wq5d2LBcZS7k
         7OOMFtCy42cqiAicYxzAqjwjsEd973IfdhVlsFwz9iZUmnxdRrlrhKs9PnbpIXNWXd
         og/xhF7oUKkY5CGMj5Vd7+LAsr2zr4TTdV3vM8Qg26EdLpn95UBJjI2H6wkzJnKvSp
         BOXPZc7/DMLFQ==
Date:   Fri, 22 Jul 2022 10:46:02 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jeremy Bongio <bongiojp@gmail.com>,
        linux-ext4@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4
 filesystem.
Message-ID: <YtriWvxMcNMUPBry@magnolia>
References: <20220720234512.354076-1-bongiojp@gmail.com>
 <YtiZ+gOmOFTpiAjW@magnolia>
 <e503645b-e665-50c4-37a9-cdc8637ba1d8@gmail.com>
 <YtmXAyoF2PXstnLY@magnolia>
 <e1573002-7ea3-2636-b2d2-331767a5622f@gmail.com>
 <YtqsTM2qXyR+dlz6@mit.edu>
 <c1bcaed9-0711-83de-f823-c38ba0302b4b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1bcaed9-0711-83de-f823-c38ba0302b4b@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 22, 2022 at 04:32:45PM +0200, Alejandro Colomar wrote:
> Hi Ted,
> 
> On 7/22/22 15:55, Theodore Ts'o wrote:
> > On Fri, Jul 22, 2022 at 12:03:23PM +0200, Alejandro Colomar (man-pages) wrote:
> > > > SEE ALSO
> > > > 	ioctl(2)
> > > > 
> > > > at the end of an ioctl_XXX manpage like this one.
> > > > 
> > > 
> > > Okay.  Then may I ask for an EXAMPLES section with a program that
> > > unequivocally shows users how to use it?
> > 
> > I'll note that existing ioctl man pages don't have an explicit
> > statement that a libc is required --- nor do we do this for open(2),
> > stat(2), etc.

I think you and I missed that discussion:
https://lore.kernel.org/linux-man/20210911160117.552617-1-alx.manpages@gmail.com/ 

> That's because there hasn't been a man-pages release in around a year.
> If you see the man-pages git repo, you'll see that (almost) all man pages in
> sections 2 and 3 have a new LIBRARY section.
> 
> ioctl(2) pages now have this LIBRARY section:
> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man2/ioctl_fat.2>
> 
> This was based on FreeBSD's man pages:
> <https://www.freebsd.org/cgi/man.cgi?query=stat&apropos=0&sektion=2&manpath=FreeBSD+13.1-RELEASE+and+Ports&arch=default&format=html>
> >   (And that's especially necessary for stat(2), BTW!)
> 
> stat(2) now says <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man2/stat.2#n22>:
> 
> LIBRARY
>        Standard C library (libc, -lc)
> 
> 
> If you would like to improve on that, I'm open to ideas, or patches from
> programmers who know the syscalls much better than I do.

I still think it's redundant to say that you have to link against the
standard C library -- it's a standard feature on Linux, and you have to
pass -nolibc to opt out of it.  Libraries that have to be opted-into
(e.g. -lpthread) should be documented here, but not stuff that's enabled
by default.

Oh well, you're the maintainer, it is your prerogative.

> > Many of the ioctl man pages (or other system call man pages, for that
> > matter) also don't have an EXAMPLES section, either.
> > 
> > Perhaps it would be useful to have a discussion over what the
> > standards are for man pages in section 2, and when we need to state
> > things that seem to be rather obvious (like "you must have a C
> > library") and when there should be things like an EXAMPLES section?
> 
> Now that you say it, I forgot to document the LIBRARY section in
> man-pages(7).  There's something about it, but I forgot to add a paragraph
> describing it in detail.

That would've helped, since I scanned
https://man7.org/linux/man-pages/man7/man-pages.7.html
and didn't see much about what goes in this section...

> Regarding the EXAMPLES section, every page in man2 or man3 should have an
> example program, IMO.  Consider that there are programmers that may find it
> easier to learn a function by experimenting with a working example of C
> code, rather than a dense textual description in a language that may not be
> native to the programmer.

Frankly I'd rather push people to have example code over documenting
that standard C library functions require the standard C library. :)

That said, I don't always enjoy the textbook examples that have been
slimmed down for manpages -- I prefer a link to a real implementation
in (say) the test suite so that I can see code that (one would hope)
exercises all the functionality exposed through the interface.

But I guess that's really up to the manpage author to decide.

> There are many pages that lack examples, but that's not something I would
> consider a good thing.
> 
> > 
> > Some the suggestions you are making don't seem to be adhered to by
> > the existing man pages, and more text is not always better.
> 
> The next release of the man-pages is certainly going to be an important one.
> It may be hated by many, loved by many others.  I hope overall I did a
> significant improvement in both improving the transmission of information
> and simplifying maintenance.

I'm not convinced that having to open *two* manpages just to figure out
how to call an ioctl is going to simplify maintenance unless the struct
is shared across more than one manpage, but I've already made that
point.

(There isn't any magical way to #include a manpage within another
manpage, is there?)

--D

> 
> > 
> > https://www.npr.org/sections/13.7/2014/02/03/270680304/this-could-have-been-shorter
> 
> Sorry, but I'm not able to read that page.  It prompts the usual GPDR
> notice, and doesn't give me the option to reject cookies (only accept).
> 
> Anyway, I guess what it says.  I hope I wasn't too much verbose with my many
> changes.
> 
> Cheers,
> 
> Alex
> 
> -- 
> Alejandro Colomar
> <http://www.alejandro-colomar.es/>



