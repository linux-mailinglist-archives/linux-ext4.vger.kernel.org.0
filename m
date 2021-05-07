Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FDA376D3E
	for <lists+linux-ext4@lfdr.de>; Sat,  8 May 2021 01:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhEGXXk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 May 2021 19:23:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44752 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230076AbhEGXXj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 May 2021 19:23:39 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 147NMXHR029075
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 May 2021 19:22:33 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D82F015C39BD; Fri,  7 May 2021 19:22:32 -0400 (EDT)
Date:   Fri, 7 May 2021 19:22:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Peggy Gazzola <peggy.gazzola@hpe.com>
Subject: Re: [PATCH] e2fsck: zero-fill shared blocks by default
Message-ID: <YJXLuHG94oarNaha@mit.edu>
References: <20210408012323.110199-1-artem.blagodarenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408012323.110199-1-artem.blagodarenko@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 07, 2021 at 09:23:23PM -0400, Artem Blagodarenko wrote:
> e2fsck has some extended options that provide different ways of
> handling duplicate blocks:
> 
> clone=dup|zero
> shared=preserve|lost+found|delete
> 

This patch isn't applicable to the upstream e2fsprogs, because we
don't support these extended options.

I'd be open to taking commits to support these options, but I'm not
likely to change the default to be "clone=zero".

> When e2fsck detects multiply-claimed blocks, the default repair
> behavior is to clone the duplicate blocks. This is guaranteed to
> result in data corruption, and is also a security hole.

The data corruption occurred when the file system was corrupted.
Changing the default to zero cloned blocks is guaranteed to make
things worse. 

> Typically,
> one of the inodes with multiply-claimed blocks is valid, the others
> have corrupt extent data referencing some of the same disk blocks
> as the valid inode.

True; but when we clone the shared block, one of the files will
hopefully be made whole.  Zeroing means that *both* files are
guranteed to be corrupted.

Can this potentially be a security problem?  Well, it's up to the
system adminsitrator to take a look at the files that were fixed up
during pass1b handling, and decide which file should be fixed up.  If
the system administrator wants to run e2fsck -fy, and then blindly
bring up the system for sharing... that's on the system adminsitrator.
If they don't care to manually inspect the files with shared blocks
first, then sure, perhaps they should edit /etc/e2fsck.conf and change
the cloned or shared behaviour.

It might be that "shared=lost+found" might be a better choice for
them, since /lost+found is mode 700 (owned by root).  "clone=zero"
leaves both files, now guaranteed to be corrupted, left in place for
the user to trip over the corrupted file.  Moving them to lost+found
means the user still has lost access to both files, but least they are
preserved in /lost+found for the system adminsitrator (or the site
security officer if you are running a system with Mandatory Access
Controls) can look them over and them restore them to the user if that
is appropriate/safe.

I'll note, though, that if you have some directory corruption that
causes some file such as /etc/hosts.deny, /etc/iptable/rules or
/etc/ufw/ufw.conf to end up in /lost+found, blindly bringing up the
system after running the e2fsck -fy hammer isn't necessarily going to
be safe, either.  The whole *point* of e2fsck -p is that is
automatically safe, and if it fails to make some kind of fix, it's
because an intelligent human is supposed to drive, and there may be a
need to make manual adjustments to the file system or perhaps tell
e2fsck *not* to make an obvious fix, in the interests of recovering as
much data as possible.

The real problem is people who think running "e2fsck -fy" is
automatically safe and all will be better...

Cheers,

					- Ted
