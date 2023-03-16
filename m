Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AED6BC579
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Mar 2023 06:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCPFIJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 01:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCPFII (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 01:08:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A6A89F02
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 22:08:05 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32G57f2D014769
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 01:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678943264; bh=IA8mCWVBPzsigtShc1XM4F6ZVJgz5xJXbmMho4DYqlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ql7ZNQJV+HDLZ4SJq/3SwnlXCV1P6FFEWGxHELDSZuPbBnnlLQ0+HQtfIgvsywc2o
         MXPX5/Yrbmwo8OQ3COmlZIMF7AnXXiJC5YUu4yWisw2MBCKhsEKEiap678L7thbK+Z
         lLPYtcdoXviGzaZpRZZEynaw02zsMOqO5IYDWWEWDFtcFlZyyyD2z0tgdp8hKcC9BP
         pXncX6b/Q7SqXFVf5kwLhN2fWs7bQtnF3WJ+lQrI5ysXp0QoGEHyA/7oHvZxTMlRxu
         gufR/j8UP5OHTSNQgMeMApiM589B2R7zHVHe0KCyo6KqNnhEHhEILITJlP5h9ojzw/
         G7iBJzxCOcKwg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E099315C33A7; Thu, 16 Mar 2023 01:07:40 -0400 (EDT)
Date:   Thu, 16 Mar 2023 01:07:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/20] ext4: simplify calculation of blkoff in
 ext4_mb_new_blocks_simple
Message-ID: <20230316050740.GL860405@mit.edu>
References: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
 <20230303172120.3800725-21-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303172120.3800725-21-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 04, 2023 at 01:21:20AM +0800, Kemeng Shi wrote:
> We try to allocate a block from goal in ext4_mb_new_blocks_simple. We
> only need get blkoff in first group with goal and set blkoff to 0 for
> the rest groups.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

While this patch is OK as a simplification, there's a bigger problem
with ext4_mb_new_blocks_simple(), and that is that we start looking
for free blocks starting at the goal block, and then if we can't any
free blocks by the time we get to the last block group.... we stop,
and return ENOSPC.

This function is only used in the fast commit replay path, but for a
very full file system, this could cause a fast commit replay to fail
unnecesarily.  What we need to do is to try wrapping back to the
beginning of the file system, and stop when we hit the original group
(of the goal block) minus one.

We can fix this up in a separate patch, since this doesn't make things
any worse, but essentially we need to do something like this:

    	maxgroups = ext4_get_groups_count(sb);
	for (g = 0; g < maxgroups ; g++) {
	
		...
		group++;
		if (group > maxgroups)
			group = 0;
	}

					- Ted
