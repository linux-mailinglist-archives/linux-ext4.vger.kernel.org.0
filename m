Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA51D4DCFF
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 23:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfFTVqo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 17:46:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57617 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725921AbfFTVqo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jun 2019 17:46:44 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5KLkVQl013281
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 17:46:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A92D0420484; Thu, 20 Jun 2019 17:46:31 -0400 (EDT)
Date:   Thu, 20 Jun 2019 17:46:31 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: Removing the shared class of tests
Message-ID: <20190620214631.GF4650@mit.edu>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
 <20190620112903.GF15846@desktop>
 <20190620162116.GA4650@mit.edu>
 <20190620175035.GA5380@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620175035.GA5380@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 20, 2019 at 10:50:35AM -0700, Darrick J. Wong wrote:
> > The shared/006 test needs some way of descriminating which inodes have
> > a fixed number of inodes, since it fills a small file system until it
> > runs out of space and then runs fsck on it.  Actually, if we make the
> > test file system smaller, so it runs in finite time, we could probably
> > just run it on all file systems, since checking to see what file
> > systems which don't have a fixed inode table (e.g., btrfs) do under
> > ENOSPC when creating tons of inodes probably makes sense there for
> > those file systems as well.
> 
> xfs doesn't have a fixed inode table either, so ... that sounds like a
> good idea.

Which is amusing, given that shared/006 declares that it is supported
for xfs.  So it might just work on btrfs w/o any changes; although
maybe it just takes too long to run.  :-)

	      	      	    	- Ted
