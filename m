Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9119E509EE0
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Apr 2022 13:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiDULtN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Apr 2022 07:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiDULtM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Apr 2022 07:49:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487222180B;
        Thu, 21 Apr 2022 04:46:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CB02221112;
        Thu, 21 Apr 2022 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650541581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bm8nsCHL4UjnhlxnMU5t74kbrYF+wIwbJJq6DAogO/Y=;
        b=M5L2vcFCaAStbjrshazuPm5IbibI1SVYZH8i4Sq6HiCl8kAR6qE6erimTe+pHS9DvmzpgS
        iP8c+mjkltw0Zld6pf7h8v59IbbF6BYbkenEzFwoAfB+5Jq0WTUx4viVUKAer5CIYpDA9Z
        x+LU4joI91S5ORdDRoQC4BKHHRLaw3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650541581;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bm8nsCHL4UjnhlxnMU5t74kbrYF+wIwbJJq6DAogO/Y=;
        b=JMgeRw1R1ofpsO8nJ02YHcxS1I+EXUKSFcPEZQS3LC/QBfCUUvB3MUVY2szLZdUqgIVtLz
        /53GweWm9bFGHdDQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B49612C141;
        Thu, 21 Apr 2022 11:46:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B4119A0620; Thu, 21 Apr 2022 13:46:15 +0200 (CEST)
Date:   Thu, 21 Apr 2022 13:46:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove unnecessary code in __mb_check_buddy
Message-ID: <20220421114615.njmtsnuifqjpfum2@quack3.lan>
References: <20220404152243.13556-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404152243.13556-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 04-04-22 23:22:43, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> When enter elseif branch, the the MB_CHECK_ASSERT will never fail.
> In addtion, the only illegal combination is 0/0, which can be caught
> by the first if branch.
> 
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>
	
Ted, this seems to have fallen through the cracks...

								Honza

> ---
>  fs/ext4/mballoc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e5d43d2ee474..eba650b31870 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -576,13 +576,10 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
>  		for (i = 0; i < max; i++) {
>  
>  			if (mb_test_bit(i, buddy)) {
> -				/* only single bit in buddy2 may be 1 */
> +				/* only single bit in buddy2 may be 0 */
>  				if (!mb_test_bit(i << 1, buddy2)) {
>  					MB_CHECK_ASSERT(
>  						mb_test_bit((i<<1)+1, buddy2));
> -				} else if (!mb_test_bit((i << 1) + 1, buddy2)) {
> -					MB_CHECK_ASSERT(
> -						mb_test_bit(i << 1, buddy2));
>  				}
>  				continue;
>  			}
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
