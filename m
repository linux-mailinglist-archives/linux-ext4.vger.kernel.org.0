Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A96BED4D
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 16:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCQPvT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCQPvS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 11:51:18 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25538457C4
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 08:51:17 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32HFolij015247
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 11:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679068250; bh=tsuI/3AQbb01opNQjlPT5OtU6shs2k5NRqebA+XQ/O4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=oGQSktXGSx7A73SE3u8bOgcG6CYh40tQTA0hbo3KWAxrR4P/XVYNa/tT5l8cteSqy
         6wZt7G7NO/Bn3tiQsQixOtl87C2xELVCdHL2l0PNYsD3jian/BBX0SVVQSNix5snOY
         mrlK650tq/w+I2gqnkeDV8+5VTBjzy8n9PjPH8kp9EWCtUgN9sD90PeBJf1s59X/AR
         DPsjzjeKYLH4Ro84Yfv2UDibyOlLDqlL/eF2bnG/i1lAXJWI+2T8kUWhi+hfcjNzAe
         rxGigEa5azKlALNSjDB/tpS4YNjycjNuORbUws1NEECTsVeubgnJRVgADf+Hotlurh
         IWTrg4dPzxkjg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B108615C33A7; Fri, 17 Mar 2023 11:50:47 -0400 (EDT)
Date:   Fri, 17 Mar 2023 11:50:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/20] ext4: simplify calculation of blkoff in
 ext4_mb_new_blocks_simple
Message-ID: <20230317155047.GB3270589@mit.edu>
References: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
 <20230303172120.3800725-21-shikemeng@huaweicloud.com>
 <20230316050740.GL860405@mit.edu>
 <d88a3d33-6832-2921-c8bb-b935b19e7db4@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d88a3d33-6832-2921-c8bb-b935b19e7db4@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 16, 2023 at 06:19:40PM +0800, Kemeng Shi wrote:
> Hi Theodore, thanks for feedback. I will submit another patchset for
> mballoc and I would like to include this fix if no one else does. As
> new patches may be conflicted with old ones I submited, I would submit
> the new patchset after the old ones are fully reviewed and applied
> if this fix is not in rush. Thanks!

Hi, I've already taken the your patches into the dev branch; were
there any changes you were intending to make to your patches?

If you could submit a separate fix for the bug that I noticed, that
would be great.

Also, if you are interested in doing some more work in mballoc.c, I
was wondering if you would be interested in adding some Kunit tests
for mballoc.c.  A simple example Kunit test for ext4 can be found in
fs/ext4/inode_test.c.  (The convention is to place tests for foo.c in
foo_test.c.)

[1] https://docs.kernel.org/dev-tools/kunit/

In order to add mballoc Kunit tests, we will need to add some "mock"[2]
functions to simulate what happens when mballoc.c tries reading a
block bitmap.  My thinking was to have a test provide an array of some
data structure like this:

struct test_bitmap {
       unsigned int	start;
       unsigned int	len;
};

[2] https://en.wikipedia.org/wiki/Mock_object

... which indicates the starting block, and the length of a run of
blocks that are marked as in use, where the list of blocks are sorted
by starting block number, and where a starting block of ~0 indicates
the end of the list of block extents.

We would also need have a set of utility ext4 Kunit functions to
create "fake" ext4 superblocks and ext4_sb_info structures.

I was originally thinking that obvious starting Kunit tests would be
for fs/ext4/hash.c and fs/ext4/extents_status.c, since they require
the little or no "mocking" support.  However, there are so many
changes in fs/ext4/mballoc.c, the urgency in having unit tests for it
is getting more urgent --- since if there is a bug in one of these
functions, such as the one that I noted in
ext4_mb_new_blocks_simple(), since it's harder to exhaustively test
some of these smaller sub-functions in integration tests such as those
found in xfstests.  Unit tests are the best way to make sure we're
testing all of the code paths in a complex module such as mballoc.c

Cheers,

						- Ted
