Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E096A42CCF7
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Oct 2021 23:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJMVne (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Oct 2021 17:43:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39349 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229702AbhJMVnd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Oct 2021 17:43:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19DLfCeL022673
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 17:41:13 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A29C915C00CA; Wed, 13 Oct 2021 17:41:12 -0400 (EDT)
Date:   Wed, 13 Oct 2021 17:41:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     yebin <yebin10@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2 2/6] ext4: introduce last_check_time record
 previous check time
Message-ID: <YWdSeMuosYio7TFv@mit.edu>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-3-yebin10@huawei.com>
 <20211007123100.GG12712@quack2.suse.cz>
 <615FA55B.5070404@huawei.com>
 <615FAF27.8070000@huawei.com>
 <20211012084727.GF9697@quack2.suse.cz>
 <61657590.2050407@huawei.com>
 <20211013093847.GB19200@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013093847.GB19200@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 13, 2021 at 11:38:47AM +0200, Jan Kara wrote:
> 
> OK, I see. So the race in ext4_multi_mount_protect() goes like:
> 
> hostA				hostB
> 
> read_mmp_block()		read_mmp_block()
> - sees EXT4_MMP_SEQ_CLEAN	- sees EXT4_MMP_SEQ_CLEAN
> write_mmp_block()
> wait_time == 0 -> no wait
> read_mmp_block()
>   - all OK, mount
> 				write_mmp_block()
> 				wait_time == 0 -> no wait
> 				read_mmp_block()
> 				  - all OK, mount
> 
> Do I get it right? Actually, if we passed seq we wrote in
> ext4_multi_mount_protect() to kmmpd (probably in sb), then kmmpd would
> notice the conflict on its first invocation but still that would be a bit
> late because there would be a time window where hostA and hostB would be
> both using the fs.
> 
> We could reduce the likelyhood of this race by always waiting in
> ext4_multi_mount_protect() between write & read but I guess that is
> undesirable as it would slow down all clean mounts. Ted?

I'd like Andreas to comment here.  My understanding is that MMP
originally intended as a safety mechanism which would be used as part
of a primary/backup high availability system, but not as the *primary*
system where you might try to have two servers simultaneously try to
mount the file system and use MMP as the "election" mechanism to
decide which server is going to be the primary system, and which would
be the backup system.

The cost of being able to handle this particular race is it would slow
down the mounts of cleanly unmounted systems.

There *are* better systems to implement leader elections[1] than using
MMP.  Most of these more efficient leader elections assume that you
have a working IP network, and so if you have a separate storage
network (including a shared SCSI bus) from your standard IP network,
then MMP is a useful failsafe in the face of a network partition of
your IP network.  The question is whether MMP should be useful for
more than that.  And if it isn't, then we should probably document
what MMP is and isn't good for, and give advice in the form of an
application note for how MMP should be used in the context of a larger
system.

[1] https://en.wikipedia.org/wiki/Leader_election

						- Ted
