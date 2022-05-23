Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB79530D9D
	for <lists+linux-ext4@lfdr.de>; Mon, 23 May 2022 12:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiEWJkj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 May 2022 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiEWJkZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 May 2022 05:40:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0F21E38;
        Mon, 23 May 2022 02:40:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D30F921A0C;
        Mon, 23 May 2022 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653298823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OqPhQgD39nH9jn1vWntr2AG2dGogHj/8W1Qt0RQY900=;
        b=RfqLLS1v44hQwb7YiwnKp5vE+kfJZdBNQwNmaF0gpEKyqyA+vW09tQrkor3A2j1SMkeXxd
        Ins9UwPNYvCeH+9w7WOHg0obMlKOXNkvm4AqOeB0EJ5nIEb7BCyZUwCt2uQq5iIANLHtsL
        dv/4+tkgYvxzPae8ce5q96MjPFGMgyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653298823;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OqPhQgD39nH9jn1vWntr2AG2dGogHj/8W1Qt0RQY900=;
        b=hKcyRDSq+Pml8cw64L+F1oI7n3fWsv4K6fl2GLrxFukrR8LRvclg0obUmJxusW/9Pmu/Sn
        OJ9/4K7s+iOjO8Cw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B99472C141;
        Mon, 23 May 2022 09:40:23 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 56D1FA0632; Mon, 23 May 2022 11:40:23 +0200 (CEST)
Date:   Mon, 23 May 2022 11:40:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
Message-ID: <20220523094023.e3rnile4wh7uiich@quack3.lan>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521134217.312071-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 21-05-22 21:42:17, Baokun Li wrote:
> When either of the "start + size <= ac->ac_o_ex.fe_logical" or
> "start > ac->ac_o_ex.fe_logical" conditions is met, it indicates
> that the fe_logical is not in the allocated range.
> In this case, it should be bug_ON.
> 
> Fixes: dfe076c106f6 ("ext4: get rid of code duplication")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I think this is actually wrong. The original condition checks whether
start + size does not overflow the used integer type. Your condition is
much stronger and I don't think it always has to be true. E.g. allocation
goal block (start variable) can be pushed to larger values by existing
preallocation or so.

								Honza 


> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 32410b79b664..d0fb57970648 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4190,7 +4190,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	}
>  	rcu_read_unlock();
>  
> -	if (start + size <= ac->ac_o_ex.fe_logical &&
> +	if (start + size <= ac->ac_o_ex.fe_logical ||
>  			start > ac->ac_o_ex.fe_logical) {
>  		ext4_msg(ac->ac_sb, KERN_ERR,
>  			 "start %lu, size %lu, fe_logical %lu",
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
