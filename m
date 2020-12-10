Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792D42D6501
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 19:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393020AbgLJS3R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 13:29:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43549 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390329AbgLJS3O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 13:29:14 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BAISLo8017856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 13:28:21 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 14282420136; Thu, 10 Dec 2020 13:28:21 -0500 (EST)
Date:   Thu, 10 Dec 2020 13:28:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+345b75652b1d24227443@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: UBSAN: shift-out-of-bounds in ext4_fill_super
Message-ID: <20201210182821.GS52960@mit.edu>
References: <20201210023638.GP52960@mit.edu>
 <00000000000024030c05b61412e6@google.com>
 <CACT4Y+bkaVq1RzONGuPJxu-pSyCSRrEs7xV0sa2n0oLNkicHQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bkaVq1RzONGuPJxu-pSyCSRrEs7xV0sa2n0oLNkicHQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 10, 2020 at 09:09:51AM +0100, Dmitry Vyukov wrote:
> >  * [new tag]                   ext4-for-linus-5.8-rc1-2 -> ext4-for-linus-5.8-rc1-2
> >  ! [rejected]                  ext4_for_linus           -> ext4_for_linus  (would clobber existing tag)
> 
> Interesting. First time I see this. Should syzkaller use 'git fetch
> --tags --force"?...
> StackOverflow suggests it should help:
> https://stackoverflow.com/questions/58031165/how-to-get-rid-of-would-clobber-existing-tag

Yeah, sorry, ext4_for_linus is a signed tag which is only used to
authenticate my pull request to Linus.  After Linus accepts the pull,
the digital signature is going to be upstream, and so I end up
deleting and the reusing that tag for the next merge window.

I guess I could just start always using ext4_for_linus-<VERSION> and
just delete the tags once they have been accepted, to keep my list of
tags clean. 

It's going to make everyone else's tags who pull from ext4.git messy,
though, with gobs of tags that probably won't be of use to them.  It
does avoid the need to use git fetch --tags --force, and I guess
people are used to the need to GC tags with the linux-repo.  So maybe
that's the right thing to do going forward.


	     	 	       	       	   	- Ted
