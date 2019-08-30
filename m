Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1273DA2C38
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2019 03:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfH3BWr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Aug 2019 21:22:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46620 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727176AbfH3BWr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Aug 2019 21:22:47 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7U1MbrB027165
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 21:22:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0F41342049E; Thu, 29 Aug 2019 21:22:37 -0400 (EDT)
Date:   Thu, 29 Aug 2019 21:22:36 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     dann frazier <dann.frazier@canonical.com>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Colin King <colin.king@canonical.com>,
        Ryan Harper <ryan.harper@canonical.com>
Subject: Re: ext4 fsck vs. kernel recovery policy
Message-ID: <20190830012236.GC10779@mit.edu>
References: <CALdTtnuRqgZ=By1JQ0yJJYczUPxxYCWPkAey4BjBkmj77q7aaA@mail.gmail.com>
 <5FEB4E1B-B21B-418D-801D-81FF7C6C069F@dilger.ca>
 <20190829225348.GA13045@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829225348.GA13045@xps13.dannf>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

(Changing the cc from linux-fsdevel to linux-ext4.)

On Thu, Aug 29, 2019 at 04:53:48PM -0600, dann frazier wrote:
> JBD2: Invalid checksum recovering data block 517634 in log
> 
> So is it correct to say that the checksum errors were identifying
> filesystem correctness issues, and therefore e2fsck was needed to
> correct them?

That's correct.  More precisely, checksum errors for journal blocks
are presumed to mean that file system might be corrupt, so a full
e2fsck check was needed to make sure the file system was consistent.

> You're probably right - this issue is very easy to reproduce w/
> data=journal,journal_checksum. I was never able to reproduce it
> otherwise.

I've looked at the data block numbers that you've reported, and they
come from a journald file.  The problem is with data=journal +
journal_checksum + mmap.  Unfortunately, we don't handle that
combination correctly at the moment.

The fix is going to have to involve fixing __ext4_journalled_writepage()
to call set_page_writeback() before it unlocks the page, adding a list of
pages under data=journalled writeback which is attached to the
transaction handle, have the jbd2 commit hook call end_page_writeback()
on all of these pages, and then in the places where ext4 calls
wait_for_stable_page() or grab_cache_page_write_begin(),
we need to add:

	if (ext4_should_journal_data(inode))
		wait_on_page_writeback(page);

It's all relatively straightforward except for the part where we have to
attach a list of pages to the currently running transaction.  That
will require adding  some plumbing into the jbd2 layer.

Dann, any interest in trying to code this fix?

      	  	      	     	     	  - Ted
