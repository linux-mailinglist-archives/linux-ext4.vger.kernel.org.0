Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F503E0425
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbhHDP1R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 11:27:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbhHDP1P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 11:27:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 648E921C98;
        Wed,  4 Aug 2021 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628090821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWlYTOLCY6U/jawLXTt7CFhEo+0xrkKbkWNB5BFpDeo=;
        b=ZE4/Tzxw+ENQFgAaJJfJCt7AJrEGVJk4zsgwgljG6AAai4C5KfxsJQk+vALXd1T53iyobw
        OtT3Ya9QI38oq/6SP4+uiJmRxewkozgC7HOB/ieQu9hq3DvI4waVR9Nf5s4ip9ryEcFj6T
        o5qBczv+FJ0Vg0b2pmxaUbFf5Ussro8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628090821;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWlYTOLCY6U/jawLXTt7CFhEo+0xrkKbkWNB5BFpDeo=;
        b=4gE4nL2STTa58q0fkwYuLf1LX6hzAKkthxLFVr8FtADbSBLleGqRFn6+bttJBzytgmn8nQ
        NH/+NhK6faJKf5BQ==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 3C444A3B84;
        Wed,  4 Aug 2021 15:27:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A48831F2B83; Wed,  4 Aug 2021 17:26:58 +0200 (CEST)
Date:   Wed, 4 Aug 2021 17:26:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca
Subject: Re: [PATCH V3 1/5] ext4: remove the 'group' parameter of
 ext4_trim_extent
Message-ID: <20210804152658.GH4578@quack2.suse.cz>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-2-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724074124.25731-2-jianchao.wan9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 24-07-21 15:41:20, Wang Jianchao wrote:
> From: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> Get rid of the 'group' parameter of ext4_trim_extent as we can get
> it from the 'e4b'.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 089c958aa2c3..018d5d3c6eeb 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6183,19 +6183,19 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
>   * @sb:		super block for the file system
>   * @start:	starting block of the free extent in the alloc. group
>   * @count:	number of blocks to TRIM
> - * @group:	alloc. group we are working with
>   * @e4b:	ext4 buddy for the group
>   *
>   * Trim "count" blocks starting at "start" in the "group". To assure that no
>   * one will allocate those blocks, mark it as used in buddy bitmap. This must
>   * be called with under the group lock.
>   */
> -static int ext4_trim_extent(struct super_block *sb, int start, int count,
> -			     ext4_group_t group, struct ext4_buddy *e4b)
> +static int ext4_trim_extent(struct super_block *sb,
> +		int start, int count, struct ext4_buddy *e4b)
>  __releases(bitlock)
>  __acquires(bitlock)
>  {
>  	struct ext4_free_extent ex;
> +	ext4_group_t group = e4b->bd_group;
>  	int ret = 0;
>  
>  	trace_ext4_trim_extent(sb, group, start, count);
> @@ -6271,8 +6271,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
>  		next = mb_find_next_bit(bitmap, max + 1, start);
>  
>  		if ((next - start) >= minblocks) {
> -			ret = ext4_trim_extent(sb, start,
> -					       next - start, group, &e4b);
> +			ret = ext4_trim_extent(sb, start, next - start, &e4b);
>  			if (ret && ret != -EOPNOTSUPP)
>  				break;
>  			ret = 0;
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
