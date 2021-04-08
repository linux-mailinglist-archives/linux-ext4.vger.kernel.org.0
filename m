Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B598A357AE7
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 05:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhDHDs4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Apr 2021 23:48:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37871 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229506AbhDHDsz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Apr 2021 23:48:55 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1383me61021585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Apr 2021 23:48:41 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5021C15C3B0C; Wed,  7 Apr 2021 23:48:40 -0400 (EDT)
Date:   Wed, 7 Apr 2021 23:48:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ext4: wipe filename upon file deletion
Message-ID: <YG59GE+8bhtVLOQr@mit.edu>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-2-leah.rumancik@gmail.com>
 <YG4lG2B9Wf4t6IfA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG4lG2B9Wf4t6IfA@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 07, 2021 at 02:33:15PM -0700, Eric Biggers wrote:
> On Wed, Apr 07, 2021 at 03:42:01PM +0000, Leah Rumancik wrote:
> > Zero out filename and file type fields when file is deleted.
> 
> Why?

Eric is right that we need to have a better explanation in the commit
description.

In answer to Eric's question, the problem that is trying to be solved
here is that if a customer happens to be storing PII in filenames
(e-mail addresses, SSN's, etc.) that they might want to have a
guarantee that if a file is deleted, the filename and the file's
contents can be considered as *gone* after some wipeout time period
has elapsed.  So the use case is every N hours, some system daemon
will execute FITRIM and FS_IOC_CHKPT_JRNL with the CHKPT_JRNL_DISCARD
flag set, in order to meet this particular guarantee.

Yes, we can't guarantee that discard will always zap all unused data
blocks in the general case and SSD's may very well have copies made as
a side effect of their GC operations, yadda, yadda.  Fortunately, for
this particular use case, the primary concern is for cloud customers
running services on Google Cloud's Persistent Disks.

> Also what about when a dir_entry is moved?  Wouldn't you want to make sure that
> any copies don't get left around?

Yes, we need to also make sure that after we do a hash tree leaf node
split in fs/ext4/namei.c:do_split(), that the empty space is also
zero'ed out.

> > @@ -2492,6 +2492,10 @@ int ext4_generic_delete_entry(struct inode *dir,
> >  			else
> >  				de->inode = 0;
> >  			inode_inc_iversion(dir);
> > +
> > +			memset(de_del->name, 0, de_del->name_len);
> > +			memset(&de_del->file_type, 0, sizeof(__u8));
> 
> The second line could be written as simply 'de_del->file_type = 0'.
> 
> Also why zero these two fields in particular and not the whole dir_entry?

Agreed, it would be a good diea to clear everything up to rec_len:

	memset(de_del->name, 0, de_del->rec_len - 12);

and we should probably zero out de_del->name_len as well.  Better to
not leave anything behind.

						- Ted

P.S.  By the way, this is a guarantee that we're going to eventually
want to care about for XFS as well, since as of COS-85
(Container-Optimized OS), XFS is supported in Preview Mode.  This
means that eventually we're going to want submit patches so as to be
able to support the CHKPT_JRNL_DISCARD flag for FS_IOC_CHKPT_JRNL in
XFS as well.

P.P.S.  We'll also want to have a mount option which supresses file
names (for example, from ext4_error() messages) from showing up in
kernel logs, to ease potential privacy concerns with respect to serial
console and kernel logs.  But that's for another patch set....
