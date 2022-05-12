Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE6C5253C9
	for <lists+linux-ext4@lfdr.de>; Thu, 12 May 2022 19:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356944AbiELRha (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 May 2022 13:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357102AbiELRh3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 May 2022 13:37:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0A35C35C;
        Thu, 12 May 2022 10:37:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D5FB41F8EF;
        Thu, 12 May 2022 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652377047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DH9tpcw8E7gD1BdV7gXzMqLXhRL92mNLWvekh2QazIs=;
        b=e5lauj1ioX/B6JAxrXC2eoZA2jY2xWp5JbGyNUDSGprRWU8DiHDavrm1hiSrK8MBfA9iEy
        Nm/oYCsbEgsoiJ+IfzGzvlqTQ5f/vrSVl7VTf/SmcthiK5jHd7urqTQr1Xa6kGgmEL5M0P
        mawjT19n3QdnNCd9WMtDwpbhDyFYsWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652377047;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DH9tpcw8E7gD1BdV7gXzMqLXhRL92mNLWvekh2QazIs=;
        b=TFE29LzbBlLbfv/EmGCmvWuCO1sLfOHUNOIqRvqSI3N9lIwevpihIDOYX6qMWCcMmXxucQ
        0geAxgLzfuzedlDA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C04162C141;
        Thu, 12 May 2022 17:37:27 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6ACCEA062A; Thu, 12 May 2022 19:37:27 +0200 (CEST)
Date:   Thu, 12 May 2022 19:37:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] fs: Fix jbd2_journal_try_to_free_buffers()
 kernel-doc comment
Message-ID: <20220512173727.azszrl272bxjxheb@quack3.lan>
References: <20220512075432.31763-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512075432.31763-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 12-05-22 15:54:32, Yang Li wrote:
> Add the description of @folio and remove @page in function kernel-doc
> comment to remove warnings found by running scripts/kernel-doc, which
> is caused by using 'make W=1'.
> 
> fs/jbd2/transaction.c:2149: warning: Function parameter or member
> 'folio' not described in 'jbd2_journal_try_to_free_buffers'
> fs/jbd2/transaction.c:2149: warning: Excess function parameter 'page'
> description in 'jbd2_journal_try_to_free_buffers'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

OK, but isn't this on linux-next only? Because I don't see the 'folio'
parameter in current Linus' tree yet.

								Honza

> ---
>  fs/jbd2/transaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index e49bb0938376..e9c308ae475f 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2114,7 +2114,7 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
>  /**
>   * jbd2_journal_try_to_free_buffers() - try to free page buffers.
>   * @journal: journal for operation
> - * @page: to try and free
> + * @folio: Folio to detach data from.
>   *
>   * For all the buffers on this page,
>   * if they are fully written out ordered data, move them onto BUF_CLEAN
> -- 
> 2.20.1.7.g153144c
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
