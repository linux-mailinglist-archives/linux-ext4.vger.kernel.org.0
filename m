Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3728372B03E
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Jun 2023 06:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjFKEnF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Jun 2023 00:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFKEnE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Jun 2023 00:43:04 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FC3210E
        for <linux-ext4@vger.kernel.org>; Sat, 10 Jun 2023 21:43:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35B4gS4d010701
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jun 2023 00:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686458552; bh=73bmbFBB3UxlJQ4yQs+NJDwoTzApv0bKe+6sZFaYdDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZkuyUn9JeLlmmhvEAOZLqdWNn43ppLS+lE5IUQxVWGxmhUuyyvK4K93iSknfZ5m4L
         JfwPXWewz/ZD5U32BNd/vsAzQA0hAvZfCSkeLG50eFrodmjIoIXbf6XT9WQCRyBCO+
         l+xncagRfQDRBuqR2P7FpCkE5FZ4XJjAS0m+FSONCjCUkehJkdIxhyEkxzMWWlOUYX
         ihkBH1wpN56VuMd5VcbINdxA4VHwy0LRbNRYloUee+OTVuZIAjvXPia5jNBSEePk3Q
         OhCjwKLqZoSy6XcLrWUmolQuBvvNwf/Dk04spp/DezT8Xo9dQMjVQY2Aw2M6WHYtYQ
         sMhAewWr9zAMQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C4F5215C00B0; Sun, 11 Jun 2023 00:42:28 -0400 (EDT)
Date:   Sun, 11 Jun 2023 00:42:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     adilger.kernel@dilger.ca, jack@suse.com, tudor.ambarus@linaro.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 0/6] ext4: Fix stale buffer loading from last failed
Message-ID: <20230611044228.GD1436857@mit.edu>
References: <20230315013128.3911115-1-chengzhihao1@huawei.com>
 <f67f0b5c-d02b-7a72-e723-a10336739249@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f67f0b5c-d02b-7a72-e723-a10336739249@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 09, 2023 at 04:04:47PM +0800, Zhihao Cheng wrote:
> 
> Hi Ted, will this patchset be merged in next window?

It's currently in the dev branch.  I haven't set the ack out for it
yet because I'm still seeing some test failures, including some test
hangs in my regression tests.  There are a number of patches series
submission that I'm currently working through, so we'll have to see
what the "guilty" patch set might be, and whether there is an obvious
fix for it or not.  (I've found one such problem that was missed by
code review[1], and unfortunately, there is at least one more issue
that I'm currently trying to pin down.)

[1] https://lore.kernel.org/r/20230610190319.GB1436857@mit.edu

Cheers,

					- Ted
