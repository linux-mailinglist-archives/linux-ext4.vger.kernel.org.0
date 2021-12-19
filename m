Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADCB479F12
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Dec 2021 05:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhLSEFJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Dec 2021 23:05:09 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49143 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235197AbhLSEFI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Dec 2021 23:05:08 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BJ451Bd016034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Dec 2021 23:05:02 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4CCC715C00C8; Sat, 18 Dec 2021 23:05:01 -0500 (EST)
Date:   Sat, 18 Dec 2021 23:05:01 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: Re: [PATCH] test-appliance: add ext4/050 to encrypt.exclude
Message-ID: <Yb6vbf6M+EYMXvQG@mit.edu>
References: <20211218040814.632571-1-tytso@mit.edu>
 <Yb6XEo/RcXEZxSai@quark.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yb6XEo/RcXEZxSai@quark.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 18, 2021 at 08:21:06PM -0600, Eric Biggers wrote:
> On Fri, Dec 17, 2021 at 11:08:14PM -0500, Theodore Ts'o wrote:
> > The ext4/050 test can't handle encrypted directories, so skip it for
> > now.
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  .../test-appliance/files/root/fs/ext4/cfg/encrypt.exclude    | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
> > index f3c7a959..21a8b45f 100644
> > --- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
> > +++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/encrypt.exclude
> > @@ -12,6 +12,11 @@ ext4/028
> >  # file systems with encryption enabled can't be mounted with ext3
> >  ext4/044
> >  
> > +# This test to make sure ext4 directory entries are appropriately
> > +# wiped after a file is deleted, or after htree operations is
> > +# incompatible with an encrypted directory.
> > +ext4/048
> 
> The commit message says ext4/050, but the test added to the list is ext4/048.
> Is ext4/048 the one intended?

Yes, it's the commit message that was incorrect.  Thanks for pointing
that out.  I'll fix the commit description in my tree.

     	   	    	       		   - Ted
