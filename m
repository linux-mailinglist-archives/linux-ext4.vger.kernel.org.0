Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BFA240689
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgHJNZF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Aug 2020 09:25:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43396 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726330AbgHJNZE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Aug 2020 09:25:04 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07ADOvSF028256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 09:24:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 696E1420263; Mon, 10 Aug 2020 09:24:57 -0400 (EDT)
Date:   Mon, 10 Aug 2020 09:24:57 -0400
From:   tytso@mit.edu
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Wang Shilong <wangshilong1991@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>, Shuichi Ihara <sihara@ddn.com>
Subject: Re: [PATCH v3 1/2] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize
 trim
Message-ID: <20200810132457.GA14208@mit.edu>
References: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
 <20200806044703.GC7657@mit.edu>
 <CAP9B-Qnv2LXva_szv+sDOiawQ6zRb9a8u-UAsbXqSqWiK+emiQ@mail.gmail.com>
 <20200808151801.GA284779@mit.edu>
 <9789BE11-11FB-42B2-A5BE-D4887838ED10@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9789BE11-11FB-42B2-A5BE-D4887838ED10@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Aug 08, 2020 at 10:33:08PM -0600, Andreas Dilger wrote:
> What about storing "s_min_freed_blocks_to_trim" persistently in the
> superblock, and then the admin can adjust this as desired?  If it is
> set =1, then the "lazy trim" optimization would be disabled (every
> FITRIM request would honor the trim requests whenever there is a
> freed block in a group).  I suppose we could allow =0 to mean "do not
> store the WAS_TRIMMED flag persistently", so there would be no change
> for current behavior, and it would require a tune2fs option to set the
> new value into the superblock (though we might consider setting this
> to a non-zero value in mke2fs by default).

Currently the the minimum blocks to trim is passed in to FITRIM from
userspace; so we would need to define how the passed-in value from the
fstrim program interacts with the value stored in the sueprblock.
Would we always ignore the value passed-in from userspace?  That
doesn't seem right...

> The other thing we were thinkgin about was changing the "-o discard" code
> to leverage the WAS_TRIMMED flag, and just do bulk trim periodically
> in the filesystem as blocks are freed from groups, rather than tracking
> freed extents in memory and submitting trims actively during IO.  Instead,
> it would track groups that exceed "s_min_freed_blocks_to_trim", and trim
> the whole group in the background when the filesystem is not active.

Hmm, maybe.  That's an awful lot of complexity, which is my concern
with that approach.

Part of the problem here is that discard is being used for different
things for different use cases and devices with different discard
speeds.  Right now, one of the primary uses of -o discard is for
people who have fast discard implementation(s and/or people who really
want to make sure every freed block is immediately discard --- perhaps
to meet security / privacy requirements (such as HIPPA compliance,
etc.).   I don't want to break that.

We now have a requirement of people who have very slow discards --- I
think at one point people mentioned something about for devices using
HDD, probably in some kind of dm-thin use case?  One solution that we
can use for those is simply use fstrim -m 8M or some such.  But it
appears that part of the problem is people do want more precision than
that?

Another solution might be to skip trimming block groups if there have
been blocks that have been freshly freed that are pending a commit,
and skip that block group until the commit has completed.  That might
also help reduce contention on a busy file system.

Yet another solution might be bias block allocations towards LBA
Uranges that have been deleted recently --- since another way to avoid
trims is to simply overwrite those LBA's.  But then the question is
how much memory are we willing to dedicate towards tracking recently
released LBA's, and to what level of granularity?  Perhaps we just
track the freed extents, and if they don't get used within a certain
period, or if we start getting put under memory pressure, we then send
the discards at that point.

Ultimately, though, this is a space full of trade offs, and I'm
reminded of one of my father's favorite Chinese sayings: "You're
demanding a horse which can run fast, but which doesn't eat much
grass." (又要马儿跑，又要马儿不吃草).  Or translated more
idiomatically, you can't have your cake and eat it too.  It seems this
desire transcends all cultures.  :-)

	       	   	      	   	- Ted
