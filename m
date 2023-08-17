Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDF777FEBE
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 21:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354778AbjHQTyv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 15:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354282AbjHQTyY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 15:54:24 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19399359B
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 12:54:22 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37HJsFc9010762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 15:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692302056; bh=+DQ+xTM0RtIWofNR/uzYP24pp+QmQL2QsvhfbW4uJFM=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=f58bZCeYlrSugHHjR1TOGu6crKOqt9nHBr11Ho30354Z8/nj19XVGw/AwVBuznv7w
         j0sbLgR2UE39n5eQ42IWdlJen2GJtc6AFviYYIGsq1R5VfGtH+WCUDi1laBLWdYn8p
         86qjuUslK555t3yD/l/Dg8ObojMv+BGrNe6EmoGGg55SojQToAhhXF6I9Sk627n0ML
         ZYJhWsgo/rbL0QdQxXywVrPfXAAR6s4EXHKejHQ8UktkqAFyMalt8040I7sgOEL9X1
         uREqLwYgYFf7qi8MGnyAtRaCKw7vxqnQ6H8GPebRDiIYh8pcM9Gf9Hu2ujZX9ppMZJ
         4gr2c6uKBb9LA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0DD7915C0501; Thu, 17 Aug 2023 15:54:15 -0400 (EDT)
Date:   Thu, 17 Aug 2023 15:54:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Jianjian <wangjianjian0@foxmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Free data blocks directly for ordered journal
Message-ID: <20230817195415.GE2247938@mit.edu>
References: <tencent_D6CD42314E6CD7A9ABA771CF10C464390005@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D6CD42314E6CD7A9ABA771CF10C464390005@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jun 24, 2023 at 11:52:59PM +0800, Wang Jianjian wrote:
> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 7b2e36d103cb..41fdc2f8c061 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6206,7 +6206,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  	 * consistency guarantees.
>  	 */
>  	if (ext4_handle_valid(handle) &&
> -	    ((flags & EXT4_FREE_BLOCKS_METADATA) ||
> +	    ((ext4_should_order_data(inode) && (flags & EXT4_FREE_BLOCKS_METADATA)) ||
>  	     !ext4_should_writeback_data(inode))) {
>  		struct ext4_free_data *new_entry;
>  		/*

This is not a safe thing to do, so I have to reject this patch.  As
stated in the comment immediately above this code:

	/*
	 * We need to make sure we don't reuse the freed block until after the
	 * transaction is committed. We make an exception if the inode is to be
	 * written in writeback mode since writeback mode has weak data
	 * consistency guarantees.
	 */

In ordered mode, we *do* care that if a file is deleted, and then the
block gets reallocated and used for some new file --- and then we
crash before a transaction commits, then the not-actually-deleted file
would have its data blocks corrupted.

							- Ted
