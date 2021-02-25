Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC2B32544B
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Feb 2021 18:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhBYREB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Feb 2021 12:04:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58218 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234102AbhBYRDZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Feb 2021 12:03:25 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11PH23xr002652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 12:02:04 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 51FA015C343C; Thu, 25 Feb 2021 12:02:03 -0500 (EST)
Date:   Thu, 25 Feb 2021 12:02:03 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>,
        lihaotian <lihaotian9@huawei.com>,
        "lijinlin (A)" <lijinlin3@huawei.com>
Subject: Re: [PATCH] debugfs: fix memory leak problem in read_list()
Message-ID: <YDfYC+xUal5EdibL@mit.edu>
References: <c6fb0951-a472-dbb4-1970-fe9cece5d182@huawei.com>
 <CAD+ocbwkQ4rMYhiOm4msnBH65vh6Pm25ZkPsC2pD0sFy68bPgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbwkQ4rMYhiOm4msnBH65vh6Pm25ZkPsC2pD0sFy68bPgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 25, 2021 at 07:51:09AM -0800, harshad shirwadkar wrote:
> On Sat, Feb 20, 2021 at 12:41 AM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
> >
> >
> > In read_list func, if strtoull() fails in while loop,
> > we will return the error code directly. Then, memory of
> > variable lst will be leaked without setting to *list.
> >
> > Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> > Signed-off-by: linfeilong <linfeilong@huawei.com>
> > ---
> >  debugfs/util.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/debugfs/util.c b/debugfs/util.c
> > index be6b550e..9e880548 100644
> > --- a/debugfs/util.c
> > +++ b/debugfs/util.c
> > @@ -530,12 +530,16 @@ errcode_t read_list(char *str, blk64_t **list, size_t *len)
> >
> >                 errno = 0;
> >                 y = x = strtoull(tok, &e, 0);
> > -               if (errno)
> > -                       return errno;
> > +               if (errno) {
> > +                       retval = errno;
> > +                       break;
> > +               }
> Shouldn't we have `goto err;` here instead of break? strtoull failure
> here indicates that no valid value was found, so instead of returning
> the allocated memory, we should just free the memory and return error.

As of commit 462c424500a5 ("debugfs: fix memory allocation failures
when parsing journal_write arguments") there is no longer the err:
goto target.  The goal is to move to a model where the caller is
exclusively responsible for freeing any allocated memory, since if
realloc() has gotten into the act, the memory pointed to in *list
would have been freed by realloc().  The fix is to make sure *list is
updated before we return.  This also allows the caller to have access
to the list of numbers parsed before we ran into an error.

So the Zhiqiang's patch is correc, and I will apply it.

       		  	   	       	 - Ted
