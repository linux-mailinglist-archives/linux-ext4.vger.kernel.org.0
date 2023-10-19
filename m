Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF35E7CF6A3
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 13:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345354AbjJSLYi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 07:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbjJSLYh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 07:24:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E58D138;
        Thu, 19 Oct 2023 04:24:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 944B21F88B;
        Thu, 19 Oct 2023 11:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697714674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GH7bHoFiiYweuGwSLXTm1+GpFbgEwwOFBwYm87XjDpM=;
        b=eS9c0gPE9/6N+qA/JEcQndyWSIYqCD3N3kYJBbgj6exBVBsVTSaO8OIUYDXTmzvc9fzY+C
        1Y7LnLTlub0uFV+QcJqijwv0lqLmczdZjArxREE8iZF9SAx41OR4uPz+npPoLaTR56lifd
        PpO8VjZx+BAXNYzGrtyH0gqZBLHmwYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697714674;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GH7bHoFiiYweuGwSLXTm1+GpFbgEwwOFBwYm87XjDpM=;
        b=KDEVkNiuw2U5TtLrtlizEy9x4yZp6xO8v9KLOnmpMjw7Cl2wHjBcwyhtMEMgmuLbpY9Zlv
        qgYhTcu5xMsYWiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8719E139C2;
        Thu, 19 Oct 2023 11:24:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tGT0IPIRMWVQGgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 11:24:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1C057A06B0; Thu, 19 Oct 2023 13:24:34 +0200 (CEST)
Date:   Thu, 19 Oct 2023 13:24:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/4] ext4: remove unnecessary check from alloc_flex_gd()
Message-ID: <20231019112434.epx7cl7okturn4xq@quack3>
References: <20231018114221.441526-1-libaokun1@huawei.com>
 <20231018114221.441526-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018114221.441526-3-libaokun1@huawei.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -8.53
X-Spamd-Result: default: False [-8.53 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-2.43)[97.39%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 18-10-23 19:42:19, Baokun Li wrote:
> In commit 967ac8af4475 ("ext4: fix potential integer overflow in
> alloc_flex_gd()"), an overflow check is added to alloc_flex_gd() to
> prevent the allocated memory from being smaller than expected due to
> the overflow. However, after kmalloc() is replaced with kmalloc_array()
> in commit 6da2ec56059c ("treewide: kmalloc() -> kmalloc_array()"), the
> kmalloc_array() function has an overflow check, so the above problem
> will not occur. Therefore, the extra check is removed.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/resize.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index c6d4539d4c1f..0a57b199883c 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -236,10 +236,7 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
>  	if (flex_gd == NULL)
>  		goto out3;
>  
> -	if (flexbg_size >= UINT_MAX / sizeof(struct ext4_new_group_data))
> -		goto out2;
>  	flex_gd->count = flexbg_size;
> -
>  	flex_gd->groups = kmalloc_array(flexbg_size,
>  					sizeof(struct ext4_new_group_data),
>  					GFP_NOFS);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
