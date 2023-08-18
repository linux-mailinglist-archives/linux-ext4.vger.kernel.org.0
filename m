Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52598780FBC
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 18:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378381AbjHRQBU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 12:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355209AbjHRQAz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 12:00:55 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AEF1BB
        for <linux-ext4@vger.kernel.org>; Fri, 18 Aug 2023 09:00:52 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-121-162.bstnma.fios.verizon.net [173.48.121.162])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37IG0cj2027529
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 12:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692374440; bh=erXmcdQ1KNay9clvH0vrxMVcc8mv/hyvtygv6MA0HQQ=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=MX0VX5azL5th5g1QwH3Uz+cp0CDRzBNoSr3kQb/SkOuAjIMyixOl1Q3kRUhZslotV
         GGatnZWiFcQkL/Kfk/R6pNe71I0zbhomfXi3OOBx/V0UmOMTm+rZK2lgYathaZ9u0E
         4eYzP/TmTBzgVR+UjrjkXsQO6t/wGS6k6mPN7U1gIv/wrcNDz/YbDe/ANf9zzq1yM+
         SaVmEZCDW0RWVpBbpYfeQ4RGg9BFzyjI+hC+lM6WDRa8BgluJPfiFxL2QTYX87HiTC
         NQIs2NoLpZEJge8XuktV+uPJSWr2urCPR7GsEkIlDFlo+uZYr0qONCfvgovtKidiKG
         3ax7jvjhz0y8w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7BCCF15C0501; Fri, 18 Aug 2023 12:00:38 -0400 (EDT)
Date:   Fri, 18 Aug 2023 12:00:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] ext4: remove unnecessary check for avoiding
 multiple update_backups in ext4_flex_group_add
Message-ID: <20230818160038.GA3515079@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-13-shikemeng@huaweicloud.com>
 <20230816034730.GT2247938@mit.edu>
 <2a0c45d9-29f0-10a3-fc40-d48e101c8d91@huaweicloud.com>
 <20230817141112.GZ2247938@mit.edu>
 <cfad4b27-3174-1124-1516-a2ddb3843639@huaweicloud.com>
 <20230818050036.GG3464136@mit.edu>
 <8f8dc5cf-cfd9-eb90-9f09-ee2dc89de537@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8dc5cf-cfd9-eb90-9f09-ee2dc89de537@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 18, 2023 at 04:42:31PM +0800, Kemeng Shi wrote:
> > s_group_desc[] is initialized in ext4_group_desc_init() in
> > fs/ext4/super.c, and it is used in fs/ext4/balloc.c, and of course, it
> > is defined in fs/ext4.h.  
> I plan to add comment in fs/ext4.h as following:
> struct ext4_sb_info {
> 	...
> 	struct buffer_head * __rcu *s_group_desc; /* Primary gdb blocks of online groups */
> But I'm not sure it's proper now as you menthioned s_group_desc[] is to
> keep the buffer_heads for the block group descriptor blocks in memory
> and it contains primary gdb block is a coincidence that we only modify
> primary block in kernel.

In general, the terminology that ext4 developers have used is "block
group descriptors" and "backup block group descriptors".  The kernel
never *uses* the backup block group users; and with the sparse_super2
feature, the "backup superblocks" and "backup block group descriptors"
are optional.

They are used by e2fsck if we need to recover a trashed superblock and
block group descriptors, which is why code that is resizing the file
system, or updating the label or the UUID need to update the backup
superblocks and/or backup block group descriptors so that we can
better recover disaster.

So I'd just suggest changing the comment above to "array of bh's for
the block group descriptors".

Cheers,

							- Ted

> Besides, I plan to go through the resize code again in fulture and
> add some comments to make it easy for anyone starting read this
> or make it easy to maintain. Please let me if you disklike it.

P.S.

BTW, a useful test program to add is one that checks to make sure that
the "static" parts of the superblock and block group descriptors
(i.e., the parts that don't get changed under normal operation while
the file system is mounted when the kernel *isn't* trying to do a
resize or change the label, UUID, or in the future, the new ioctl's to
update the parts of the superblock that can get modified by tune2fs),
and to make sure that all of the backup superblock and block group
descriptors have gotten updated.

Some of the bugs that you found may have resulted in some of the
backup bg descriptors not getting updataed, which we wouldn't
necessarily notice unless we had a test program that explicitly
checked for them.

And truth to tell, the only backup superblock and block group
descriptor that actually gets used to recover the file system is the
first one, since that's the one e2fsck will fall back to
automatically.  An expert might try to use one of the other backup
block groups as a desperate measure, and there might be some automated
programs that might be smart enough to use the backup block groups
when trying to recover the location of the partition table when the
file system and partition table is very badly damaged --- so that's
one of the reasons why with sparse_super2, the number of backup block
group descriptors can be limited to (for example) one located in the
first block group, and one located in the very last block group.

