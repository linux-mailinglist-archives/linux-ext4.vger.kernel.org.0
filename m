Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B39C7427D8
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjF2OAX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjF2OAW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jun 2023 10:00:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EBE19B5;
        Thu, 29 Jun 2023 07:00:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 667F721836;
        Thu, 29 Jun 2023 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688047219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3XvzUQu801FzKs3iHBW/hsxqJwuXABN8gyB4Y3gdE7o=;
        b=ppZd0acwCMJhuiNjBA5IXPFF7rbhySCTrty7M/XTzecktoCJmNfc7k5k8PcFvgpicaXH2M
        NGnLwA7kEvKl9Q3OhWDYOh0zqSkKBGZjXcTgCW0usXlPtudZncoH2Uu8voxtAsTxin04TU
        8uezYNtjJxzVsfOcU4kklvp9qkHpYFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688047219;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3XvzUQu801FzKs3iHBW/hsxqJwuXABN8gyB4Y3gdE7o=;
        b=Lidt5ltBK3XiQ+0j4+ksxbTNrvY3zSJfovpUuD/y8/54xO/2/8B9RvS/NSGoj3C2aN71zC
        X1XnggrnvIE/08CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5772A13905;
        Thu, 29 Jun 2023 14:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8IJNFXOOnWQ/CQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 14:00:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E5210A0722; Thu, 29 Jun 2023 16:00:18 +0200 (CEST)
Date:   Thu, 29 Jun 2023 16:00:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>
Subject: Re: [PATCH] ext4: Replace CR_FAST macro with inline function for
 readability
Message-ID: <20230629140018.duaaxqnxe55yfvqq@quack3>
References: <20230629134719.108104-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629134719.108104-1-ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 29-06-23 19:17:19, Ojaswin Mujoo wrote:
> Replace CR_FAST with ext4_mb_cr_expensive() inline function for better
> readability. This function returns true if the criteria is one of the
> expensive/slower ones where lots of disk IO/prefetching is acceptable.
> 
> No functional changes are intended in this patch.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks for this cleanup! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one suggestion for consideration below:

> @@ -2630,7 +2630,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>  	free = grp->bb_free;
>  	if (free == 0)
>  		goto out;
> -	if (cr <= CR_FAST && free < ac->ac_g_ex.fe_len)
> +	if (cr <= CR_GOAL_LEN_SLOW && free < ac->ac_g_ex.fe_len)

Maybe this could be (!ext4_mb_cr_expensive(cr) || cr == CR_GOAL_LEN_SLOW)?
Or maybe more explanatory would be (cr < CR_ANY_FREE) because AFAIU that's
the only scan where we bother scanning groups that have no chance of
satisfying the full allocation? Anyway a short comment explaining this
might be useful. And in either case we can get rid of a bit confusing
CR_FAST define.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
