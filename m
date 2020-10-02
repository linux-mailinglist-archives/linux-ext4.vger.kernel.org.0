Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B9280C6E
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Oct 2020 05:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbgJBDEX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 23:04:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39443 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727780AbgJBDEX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 23:04:23 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09234JJi021423
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Oct 2020 23:04:20 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 79DA142003C; Thu,  1 Oct 2020 23:04:19 -0400 (EDT)
Date:   Thu, 1 Oct 2020 23:04:19 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] e2fsck: skip extent optimization by default
Message-ID: <20201002030419.GS23474@mit.edu>
References: <1600726562-9567-1-git-send-email-adilger@whamcloud.com>
 <20201001180336.GM23474@mit.edu>
 <3B21D37E-AA2D-4D54-B4C7-8D094FFB766D@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B21D37E-AA2D-4D54-B4C7-8D094FFB766D@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 01, 2020 at 08:11:06PM -0600, Andreas Dilger wrote:
> > We already have a no_optimize_extents option supported in e2fsck.conf.
> > So if we want to change the default, a simpler way to do this might be
> > to edit e2fsck.conf.5.in to simply add "no_optimize_extents=true" to
> > the default version of e2fsck.conf defined by default.
> 
> Does that mean you *don't* want a refresh of this patch that fixes the
> test cases?  Lukas had also been discussing how to change e2fsck so it
> still fixed the inodes, but didn't print a message for each one, though
> it wasn't clear to me that there is much benefit to this at all.

I think that if e2fsck is going to make a change, we need to print
something --- otherwise people will get confused since e2fsck will say
"file system modified", and without any kind of messages, people will
get confused in a different way.  It also makes it hard to debug if
e2fsck doesn't print anything at all.

Yet another approach would be change the messaging so that it's more
clear that e2fsck is optimizing the extent tree.

In the long run, the really right way this fix is to have the kernel
optimize the extent tree at runtime, so we don't need to let e2fsck do
things.  So it may be that simply changing the default e2fsck.conf
might be a better approach.  At least, we should consider that
alternative, which is why I suggested.
> 
> > As a reminder, for future changes, when we add a new tunable to
> > e2fsck.conf or mke2fs.conf, the man page should be edited.
> 
> Yes, I did edit the e2fsck.8.in man page to describe the change in
> default behavior.

I was referring to the e2fsck.conf.5.in man page.  If we're going to
add a new tunable to e2fsck.conf, it really needs to be documented in
the e2fsck.conf(5) man page.

Cheers,

					- Ted
