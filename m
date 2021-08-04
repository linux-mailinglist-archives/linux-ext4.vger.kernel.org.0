Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E585A3E0427
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 17:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbhHDP1i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 11:27:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41690 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbhHDP1i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 11:27:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6957D21C98;
        Wed,  4 Aug 2021 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628090844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZeskjCH0QdPJcePoQ88fUPrOHomBxPIetxeAztT0Eg=;
        b=0w6Ls48WvVFbh6FQ2zOuuTrQPTT4FN+/djRQGbra6eXIBa1LuDik98vkfAgOK0DhspUNeH
        u79KN/X8/ULlOiP/UqKo9AbgdJZcIYeJCr8zSFBdA3W3ptharL2eojV6zsj4qjO9HKZ5vY
        zyTLSh3gbvf1hxQmI4Z7XNCmIV2STf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628090844;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZeskjCH0QdPJcePoQ88fUPrOHomBxPIetxeAztT0Eg=;
        b=9AQ26D4K2k0ycRrgwekFKAbQbxvnYTpKMuhwDLWyCsBOGRD5w5YQsVo29GS2cxUVJvSPAN
        pAgUK1Y2VDwJfCBA==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 57CF4A3B94;
        Wed,  4 Aug 2021 15:27:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1876A1F2B83; Wed,  4 Aug 2021 17:27:24 +0200 (CEST)
Date:   Wed, 4 Aug 2021 17:27:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca
Subject: Re: [PATCH V3 3/5] ext4: remove the repeated comment of
 ext4_trim_all_free
Message-ID: <20210804152724.GI4578@quack2.suse.cz>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-4-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724074124.25731-4-jianchao.wan9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 24-07-21 15:41:22, Wang Jianchao wrote:
> From: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e3844152a643..34be2f07449d 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6274,15 +6274,10 @@ static int ext4_try_to_trim_range(struct super_block *sb,
>   * @max:		last group block to examine
>   * @minblocks:		minimum extent block count
>   *
> - * ext4_trim_all_free walks through group's buddy bitmap searching for free
> - * extents. When the free block is found, ext4_trim_extent is called to TRIM
> - * the extent.
> - *
> - *
>   * ext4_trim_all_free walks through group's block bitmap searching for free
>   * extents. When the free extent is found, mark it as used in group buddy
>   * bitmap. Then issue a TRIM command on this extent and free the extent in
> - * the group buddy bitmap. This is done until whole group is scanned.
> + * the group buddy bitmap.
>   */
>  static ext4_grpblk_t
>  ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
