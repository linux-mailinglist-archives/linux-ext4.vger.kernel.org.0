Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD263B891D
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhF3TXC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 15:23:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59419 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233536AbhF3TXA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 15:23:00 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15UJKNdL003140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 15:20:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 75A8715C3C8E; Wed, 30 Jun 2021 15:20:23 -0400 (EDT)
Date:   Wed, 30 Jun 2021 15:20:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 9/9] common/attr: Reduce MAX_ATTRS to leave some overhead
 for 64K blocksize
Message-ID: <YNzD90/uocoRveYq@mit.edu>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <f23e6788b958849ec9c1fb7fed0081e58c02a13a.1623651783.git.riteshh@linux.ibm.com>
 <20210630155150.GC13743@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630155150.GC13743@locust>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 30, 2021 at 08:51:50AM -0700, Darrick J. Wong wrote:
> On Mon, Jun 14, 2021 at 11:58:13AM +0530, Ritesh Harjani wrote:
> > Test generic/020 fails for ext4 with 64K blocksize. So increase some overhead
> > value to reduce the MAX_ATTRS so that it can accomodate for 64K blocksize.
> > 
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  common/attr | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/attr b/common/attr
> > index d3902346..e8661d80 100644
> > --- a/common/attr
> > +++ b/common/attr
> > @@ -260,7 +260,7 @@ xfs|udf|pvfs2|9p|ceph|nfs)
> >  	# Assume max ~1 block of attrs
> >  	BLOCK_SIZE=`_get_block_size $TEST_DIR`
> >  	# user.attribute_XXX="value.XXX" is about 32 bytes; leave some overhead
> > -	let MAX_ATTRS=$BLOCK_SIZE/40
> > +	let MAX_ATTRS=$BLOCK_SIZE/48
> 
> 50% is quite a lot of overhead; maybe we should special-case this?

The problem is that 32 bytes is an underestimate when i > 99 for
user.attribute_$i=value_$i.  And with a 4k blocksize, MAX_ATTRS =
4096 / 40 = 102.

The exact calculation for ext4 is:

fixed_block_overhead = 32
fixed_entry_overhead = 16
max_attr = (block_size - fixed_block_overhead) /
	(fixed_entry_overhead + round_up(len(attr_name), 4) +
	 round_up(len(value), 4))

For 4k blocksizes, most of the attributes have an attr_name of
"attribute_NN" which is 8, and "value_NN" which is 12.

But for larger block sizes, we start having extended attributes of the
form "attribute_NNN" or "attribute_NNNN", and "value_NNN" and
"value_NNNN", which causes the round(len(..), 4) to jump up by 4
bytes.  So round_up(len(attr_name, 4)) becomes 12 instead of 8, and
round_up(len(value, 4)) becomes 16 instead of 12.  So:

	max_attrs = (block_size - 32) / (16 + 12 + 16)
or
	max_attrs = (block_size - 32) / 44

instead of:

	max_attrs = (block_size - 32) / (16 + 8 + 12)
or
	max_attrs = (block_size - 32) / 36

So special casing things for block sizes > 4k may very well make
sense.  Perhaps it's even worth it to put in an ext[234] specific,
exalc calculation for MAX_ATTRS in common/attr.

Cheers,

						- Ted
