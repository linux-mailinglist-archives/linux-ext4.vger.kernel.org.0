Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E326C65C761
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jan 2023 20:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbjACTVd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Jan 2023 14:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbjACTVJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Jan 2023 14:21:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B2119C05;
        Tue,  3 Jan 2023 11:17:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3896BB80EC5;
        Tue,  3 Jan 2023 19:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA9FC433D2;
        Tue,  3 Jan 2023 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672773441;
        bh=9lTPqBlAfYpCTNF83gttPyeAkRuebjqagMHt7cxTsFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3+0qTce2KM1q/HaepEZAgW34u+gLPhVxNrEhc5ewzJZD6ricHn+dRv4nhczlfKOk
         xmcRXd32SlJRR94kZT87mPNonooTLBsc2vzwyolVzqFEAAId9xYDm7RLwfE+5/sYko
         hcllVVznqXjWNSxnM+o2zA0Q3D2azrhJXzzzRHuks3kxJK6d+kWKMPUnViZfc8CZKz
         hzQKa4xquOnTlvBFsRoueTbV7S7IgKbQDgb13Y6YL2ixpPEOv5LJiN2EQ/SNhEiJ09
         HttaOMJKsUgzOI30p2rYH9RfQ/GfpSEpilDyirGJECO369WlQyZon5PYbvTI3lWAmN
         dpmk/TnZfEERw==
Date:   Tue, 3 Jan 2023 11:17:20 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tudor.ambarus@linaro.org
Subject: Re: [PATCH] ext4: reject 1k block fs on the first block of disk
Message-ID: <Y7R/QKIbYQ2TCP+W@magnolia>
References: <20221229014502.2322727-1-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229014502.2322727-1-jun.nie@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 29, 2022 at 09:45:02AM +0800, Jun Nie wrote:
> For 1k-block filesystems, the filesystem starts at block 1, not block 0.
> If start_fsb is 0, it will be bump up to s_first_data_block. Then
> ext4_get_group_no_and_offset don't know what to do and return garbage
> results (blockgroup 2^32-1). The underflow make index
> exceed es->s_groups_count in ext4_get_group_info() and trigger the BUG_ON.
> 
> Fixes: 4a4956249dac0 ("ext4: fix off-by-one fsmap error on 1k block filesystems")
> Link: https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002
> Reported-by: syzbot+6be2b977c89f79b6b153@syzkaller.appspotmail.com
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  fs/ext4/fsmap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index 4493ef0c715e..1aef127b0634 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -702,6 +702,12 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
>  		if (handlers[i].gfd_dev > head->fmh_keys[0].fmr_device)
>  			memset(&dkeys[0], 0, sizeof(struct ext4_fsmap));
>  
> +		/*
> +		 * Re-check the range after above limit operation and reject
> +		 * 1K fs on block 0 as fs should start block 1. */
> +		if (dkeys[0].fmr_physical ==0 && dkeys[1].fmr_physical == 0)
> +			continue;

...and if this filesystem has 4k blocks, and therefore *does* define a
block 0?

--D

> +
>  		info.gfi_dev = handlers[i].gfd_dev;
>  		info.gfi_last = false;
>  		info.gfi_agno = -1;
> -- 
> 2.34.1
> 
