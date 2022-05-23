Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522BF530D8B
	for <lists+linux-ext4@lfdr.de>; Mon, 23 May 2022 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiEWKGv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 May 2022 06:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiEWKGD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 May 2022 06:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7907821F
        for <linux-ext4@vger.kernel.org>; Mon, 23 May 2022 03:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653300360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o6NjBzDr0abUPkWwfcw8udxm2iTvapM2gAXQlVu3sNM=;
        b=jEJm0iycL/jf6xlrEs5s93tQ5eH8k+s9sw98ekRR3n0GuWscvheqvYb/ErtpgZI/p/zpiP
        +7XLKGonJp9S70LUtSDfBSlaJGf5zjqAGKye+C7SkmlBZs9NypOnscAsEc3lubYs+jcUgt
        Oxzd1XQj6FBhUGqOp4yUDrOpadEsDO4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-Utfr81TKPSSGXRDNN8YdLA-1; Mon, 23 May 2022 06:05:54 -0400
X-MC-Unique: Utfr81TKPSSGXRDNN8YdLA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA02F811E75;
        Mon, 23 May 2022 10:05:53 +0000 (UTC)
Received: from fedora (unknown [10.40.194.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4198B1410DD5;
        Mon, 23 May 2022 10:05:52 +0000 (UTC)
Date:   Mon, 23 May 2022 12:05:49 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
Message-ID: <20220523100549.jjzspu64lr4igt3m@fedora>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521134217.312071-3-libaokun1@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, May 21, 2022 at 09:42:17PM +0800, Baokun Li wrote:
> When either of the "start + size <= ac->ac_o_ex.fe_logical" or
> "start > ac->ac_o_ex.fe_logical" conditions is met, it indicates
> that the fe_logical is not in the allocated range.
> In this case, it should be bug_ON.

This seems wrong, I think that this condition is testing overflow and
it's correct as it is. Or am I missing something?

-Lukas

> 
> Fixes: dfe076c106f6 ("ext4: get rid of code duplication")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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

