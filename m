Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786B075D071
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 19:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGURQT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGURQS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 13:16:18 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCB62D4E
        for <linux-ext4@vger.kernel.org>; Fri, 21 Jul 2023 10:16:17 -0700 (PDT)
Received: from letrec.thunk.org (ip-185-104-139-34.ptr.icomera.net [185.104.139.34])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36LHFXqP020651
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 13:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689959742; bh=Szsp8WWenCLEPTlAaYEVnrEfw0PS3KRnzvfturnU6yk=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=lI4ZTtLB5wljuOQzWBPvAShrWDQOZ+Sto4f02+n0rtdzFV30G2AhET8QBav+6NR3C
         Y+7vKGSGvJHE7r0sOxdZuyuinDOkl/MatmgrAkmH+rahaxSQgSomdKaPX5uBWolPDf
         qTr3bu1pqplymX1b3MZWf+rI/VMrua1BSYE+3UufQgaj9b4bRIftnkGaRMkH9KjI09
         zJTZOu/VPcaNO2jZTQLS03pb8g0gKjRputOw2ybO2QNaZhgefmfu5sG/H2lwHya/i+
         8xHm6GGbIXmrWtWGRG37KYrJd3wOyIBwe2cI2H8yoqkGspSYXJDy/TXrH/qHOC7w51
         6qllXjBiI4OAw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 23BB28C0717; Fri, 21 Jul 2023 13:15:29 -0400 (EDT)
Date:   Fri, 21 Jul 2023 13:15:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/4] ext4: fix BUG in ext4_mb_new_inode_pa() due to
 overflow
Message-ID: <ZLq9MROKiyet9Oce@mit.edu>
References: <87lef9lljt.fsf@doe.com>
 <c9cde644-f757-2d72-6ac6-d5cfb1e43da5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9cde644-f757-2d72-6ac6-d5cfb1e43da5@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 21, 2023 at 05:13:13PM +0800, Baokun Li wrote:
> > Doing this with helpers, IMO is not useful as we also saw above.
> 
> I still think it is necessary to add a helper to make the code more concise.
> 
> Ted, do you think the fex_end() helper function is needed here?
> 
> I think we might need your advice to end this discussion. 😅

Having helper functions doesn't bother me all _that_ much --- so long
as they are named appropriately.  The readibility issues start with
the fact that the helper function uses loff_t as opposed to
ext4_lblk_t, and because someone looking at fex_end() would need
additional thinking to figure out what it did.  If renamed it to be
fex_logical_end() and made it take an ext4_lblk_t, I think it would be
better.

The bigger complaint that I have, although it's not the fault of your
patch, is the use of "ext4_free_extent" all over ext4/mballoc.c when
it's much more often used for allocating blocks.  So the name of the
structure and the "fex" in "fex_end" or "fex_logical_end" is also
confusing.

Hmm... how about naming helper function extent_logial_end()?

And at some point we might want to do a global search and replace
changing ext4_free_extent to something like ext4_mballoc_extent, and
changing the structure element names.  Perhaps:

       fe_logical  --->  ex_lblk
       fe_start    --->  ex_cluster_start
       fe_group    --->  ex_group
       fe_len      --->  ex_cluster_len

This is addressing problems where "start" can mean the starting
physical block, the starting logical block, or the starting cluster
relative to the beginning of the block group.

There is also documentation which is just wrong.  For example:

/**
 * ext4_trim_all_free -- function to trim all free space in alloc. group
 * @sb:			super block for file system
 * @group:		group to be trimmed
 * @start:		first group block to examine
 * @max:		last group block to examine

start and max should be "first group cluster to examine" and "last
group cluster to examine", respectively.

The bottom line is that there are much larger opportunities to make
the code more maintainable than worrying about two new helper
functions.  :-)

Cheers,

					- Ted
