Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B23F173E
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 12:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhHSK0w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 06:26:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44670 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbhHSK0w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Aug 2021 06:26:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5BA1F1FD87;
        Thu, 19 Aug 2021 10:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629368775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSDuwTm/rdxvSKGgmTHoO82+8/F3OMOJA4M/ZMsGgXo=;
        b=qxX3jlDGyN04MBkQWmxyW5jXYeQtMCy2qeb4pi3OnPnfBt7RohLl1N/Ffnr5PftLg3Vwb3
        hRXjlwz0lr3accwMNuthmYpd7iqS4iNZIuLhvUeVAVYDKZeJSY6AOo30IMiGVOQO855Umx
        SWpVvYI/aMQ+l5hCjv5L55gdDPHPlmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629368775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSDuwTm/rdxvSKGgmTHoO82+8/F3OMOJA4M/ZMsGgXo=;
        b=R6hamqo9r0rxFp6SSl1xX6RTNzktujMu008CGAI1ccnj3Qn4TsZgVwGcBMUeW2qTMF2dh0
        TQ/Chd4KxrflGdBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 7E0C2A3BC1;
        Thu, 19 Aug 2021 10:25:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C0FAE1E0679; Thu, 19 Aug 2021 12:26:14 +0200 (CEST)
Date:   Thu, 19 Aug 2021 12:26:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v2 3/4] ext4: don't return error if huge_file feature
 mismatch
Message-ID: <20210819102614.GA32435@quack2.suse.cz>
References: <20210819065704.1248402-1-yi.zhang@huawei.com>
 <20210819065704.1248402-4-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819065704.1248402-4-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 19-08-21 14:57:03, Zhang Yi wrote:
> In ext4_inode_blocks_set(), huge_file feature should exist when setting
> i_blocks beyond a 32 bit variable could be represented, return EFBIG if
> not. This error should never happen in theory since sb->s_maxbytes should
> not have allowed this, and we have already init sb->s_maxbytes according
> to this feature in ext4_fill_super(). So switch to use WARN_ON_ONCE
> instead.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---

One comment below:

> @@ -4918,10 +4918,15 @@ static int ext4_inode_blocks_set(handle_t *handle,
>  		raw_inode->i_blocks_lo   = cpu_to_le32(i_blocks);
>  		raw_inode->i_blocks_high = 0;
>  		ext4_clear_inode_flag(inode, EXT4_INODE_HUGE_FILE);
> -		return 0;
> +		return;
>  	}
> -	if (!ext4_has_feature_huge_file(sb))
> -		return -EFBIG;
> +
> +	/*
> +	 * This should never happen since sb->s_maxbytes should not have
> +	 * allowed this, which was set according to the huge_file feature
> +	 * in ext4_fill_super().
> +	 */
> +	WARN_ON_ONCE(!ext4_has_feature_huge_file(sb));

Thinking about this a bit more, this could also happen due to fs
corruption. So we probably need to call ext4_error_inode() here instead of
WARN_ON_ONCE(). Also it will result in properly marking fs as having
errors. But since we hold i_raw_lock at this call site we need to
keep the error bail out from ext4_inode_blocks_set() and in
ext4_do_update_inode() finish updating inode and then call
ext4_error_inode() after dropping i_raw_lock.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
