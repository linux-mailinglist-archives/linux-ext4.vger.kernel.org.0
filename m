Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7467419B660
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 21:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbgDAT2m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 15:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732532AbgDAT2m (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 1 Apr 2020 15:28:42 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F022A20714;
        Wed,  1 Apr 2020 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585769322;
        bh=d/bCQW+hnL9Iv8GDV9WBaojyb702ZUAFOnnZXitKl+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJPSaPvh9VXPwXUGoHhIY8yyg4up+UO+6B4mF6x8Cv68+n3w6WnMjJkmaA872x4ii
         yxEWmLmSsK8aNVfUincbleGEmTVDCpjNHbyrl8CGDv6Ss/1isFI0IjttcDx44kgcwB
         mru5WDNAQBaGp4lbiRJs5BtTg1ivTf0Dkbe3ZY8Q=
Date:   Wed, 1 Apr 2020 12:28:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     David Howells <dhowells@redhat.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: Exporting ext4-specific information through fsinfo attributes
Message-ID: <20200401192840.GC201933@gmail.com>
References: <2461554.1585726747@warthog.procyon.org.uk>
 <20200401162744.GB201933@gmail.com>
 <20200401190553.GC56931@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401190553.GC56931@magnolia>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 01, 2020 at 12:05:53PM -0700, Darrick J. Wong wrote:
> On Wed, Apr 01, 2020 at 09:27:44AM -0700, Eric Biggers wrote:
> > On Wed, Apr 01, 2020 at 08:39:07AM +0100, David Howells wrote:
> > > Hi Ted,
> > > 
> > > Whilst we were at Vault, I asked you if there was any live ext4 information
> > > that it could be useful to export through fsinfo().  I've implemented a patch
> > > that exports six superblock timestamps:
> > > 
> > > 	FSINFO_ATTR_EXT4_TIMESTAMPS: 
> > > 		mkfs    : 2016-02-26 00:37:03
> > > 		mount   : 2020-03-31 21:57:30
> > > 		write   : 2020-03-31 21:57:28
> > > 		fsck    : 2018-12-17 23:32:45
> > > 		1st-err : -
> > > 		last-err: -
> > > 
> > > but is there anything else that could be of interest?
> > > 
> > > Thanks,
> > > David
> > > 
> > 
> > FWIW, the filesystem UUID would be useful for testing ext4 and f2fs encryption
> > (since it's now sometimes used in the derivation of encryption keys).  But I see
> > you already included it as FSINFO_ATTR_VOLUME_UUID.
> 
> It is??  What happens if you tune2fs -U if csum_seed isn't enabled?
> 

It's only used for IV_INO_LBLK_64 encryption policies, which include the inode
number in the IVs.  The UUID had to be used to distinguish the same inode number
on multiple filesystems, in case the same key is used on multiple filesystems.

Since this type of encryption policy also requires stable inode numbers, on ext4
it can only be set if user has run 'tune2fs -O stable_inodes' to also prevent
filesystem shrinking.

I didn't know that e2fsprogs had a supported way to change the filesystem UUID.
We maybe should make tune2fs -U refuse to operate on filesystems that have the
stable_inodes feature set.  However, the chance that someone would actually
break their encrypted files by changing their filesystem UUID is pretty low,
since most users use the normal fscrypt policies instead.  IV_INO_LBLK_64 is
only really useful with UFS inline encryption hardware, and systems with this
hardware aren't the type of systems you can just log into and randomly change
your filesystem UUID.  For standard Linux distros we have a tool
https://github.com/google/fscrypt, but it doesn't support IV_INO_LBLK_64 yet.

- Eric
