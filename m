Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA524D390
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfFTQVW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 12:21:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43412 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726562AbfFTQVW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jun 2019 12:21:22 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5KGLGvt005990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 12:21:17 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2868F420484; Thu, 20 Jun 2019 12:21:16 -0400 (EDT)
Date:   Thu, 20 Jun 2019 12:21:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Removing the shared class of tests
Message-ID: <20190620162116.GA4650@mit.edu>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
 <20190620112903.GF15846@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620112903.GF15846@desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 20, 2019 at 07:29:03PM +0800, Eryu Guan wrote:
> 
> IMO, shared tests are generic tests that don't have proper _require
> rules, so they're hard-coded with explicit "_supported_fs xxx yyy". With
> proper _require rules, there should be no shared tests at all, and we'd
> try avoid adding new shared tests if possible.

Thanks for the clarification, that makes sense!

I can see some shared tests that we can probably move out, actually.
shared/00[134] and shared/272 make no sense at all for ext2.  The ext3
file system was removed in 2015, in the 4.3 kernel, and since 2009
(ten years ago) in 2.6.33, the ext4 implementation could be used to
support ext3 (and I believe many if not all enterprise distros been
taking advantage of this long before 2015, so they only had to update
patches for ext4).

(If anything, we might be better served by a two line patch to check
so that simply included the ext4 group when FSTYP == ext3.  That way
we will run more tests on those systems which still support the ext3
emulated-by-ext4 mode.)

The shared/002 test could be moved to generic if we had a way for file
systems to declare how many xattrs per file they support.

The shared/006 test needs some way of descriminating which inodes have
a fixed number of inodes, since it fills a small file system until it
runs out of space and then runs fsck on it.  Actually, if we make the
test file system smaller, so it runs in finite time, we could probably
just run it on all file systems, since checking to see what file
systems which don't have a fixed inode table (e.g., btrfs) do under
ENOSPC when creating tons of inodes probably makes sense there for
those file systems as well.

I'm not sure why shared/011 is only run on ext4 and btrfs.  Does
cgroup-aware writeback not work on other file systems?

The shared/{008,009,010} tests could be moved to generic if we added
_require_dedup.  The shared/298 tests just needs a _require_fstrim.

The bottom line is I think if this is something we care about, we can
probably move out nearly all of the tests from shared.  Should I start
sending patches?  :-)

						- Ted
