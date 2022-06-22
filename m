Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA30E554A46
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jun 2022 14:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiFVMpJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Jun 2022 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiFVMpJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Jun 2022 08:45:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5AB20BF0;
        Wed, 22 Jun 2022 05:45:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EDA901FCFE;
        Wed, 22 Jun 2022 12:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655901906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VXjJY4Luze5utSA7XTTpfAHSCLkMAaEkvH9dVFHpgnc=;
        b=gA1ZSsbbfuu29Jzz6b/AS6vamPeW1qgGC+AC/x0ZFXR2QbNrvRe0vJUqPggPaRRhMhd4SC
        YSvyf9PiChSJJtZQvB2LouPbwbqh//46InKgIHq9V2nw1XXgLCt+KoDQgyTiY6ek/iTPeg
        kq87o0k+6gHyJiwHcEJZ3BvEw/MOY4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655901906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VXjJY4Luze5utSA7XTTpfAHSCLkMAaEkvH9dVFHpgnc=;
        b=wMCmdKOXSByKa54e0mZTYBuBL+uhlBRyudUHlZ7UvBp7yjtNYGmV2jjSoD68T4Uk0VQBaT
        7dSNSDPeveQ4yLDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D47692C141;
        Wed, 22 Jun 2022 12:45:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4C923A062B; Wed, 22 Jun 2022 14:45:03 +0200 (CEST)
Date:   Wed, 22 Jun 2022 14:45:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: avoid remove directory when directory is
 corrupted
Message-ID: <20220622124503.i7cloht5g2xxrxhh@quack3.lan>
References: <20220622090223.682234-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622090223.682234-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-06-22 17:02:23, Ye Bin wrote:
> Now if check directoy entry is corrupted, ext4_empty_dir may return true
> then directory will be removed when file system mounted with "errors=continue".
> In order not to make things worse just return false when directory is corrupted.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

OK, looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 47d0ca4c795b..bc503e3275db 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3066,11 +3066,8 @@ bool ext4_empty_dir(struct inode *inode)
>  		de = (struct ext4_dir_entry_2 *) (bh->b_data +
>  					(offset & (sb->s_blocksize - 1)));
>  		if (ext4_check_dir_entry(inode, NULL, de, bh,
> -					 bh->b_data, bh->b_size, offset)) {
> -			offset = (offset | (sb->s_blocksize - 1)) + 1;
> -			continue;
> -		}
> -		if (le32_to_cpu(de->inode)) {
> +					 bh->b_data, bh->b_size, offset) ||
> +		    le32_to_cpu(de->inode)) {
>  			brelse(bh);
>  			return false;
>  		}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
