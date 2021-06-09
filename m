Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76F03A10F5
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jun 2021 12:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbhFIKXm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Jun 2021 06:23:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38132 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhFIKXl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Jun 2021 06:23:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 43CD9219B7;
        Wed,  9 Jun 2021 09:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623232623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1n79+Yb5JfJ38DF1vEyJE9JDeJ+6JyOcbGRp+kXDSs=;
        b=XitamoalySDEAqVDYryO4DT/gXQWcczzQTmdY9D87s83UKKq1iUdGPtaivZ4aob5Z/HsUT
        MIdosWpUp3bzb9S+ikEGQiXvM/SUVmxXK4AanpEV3MRYojg/o+lAN54uGDQxVpVMbipGcX
        CaKUGpNZqE23Te/Y+lqlNsKX2KHp/DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623232623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1n79+Yb5JfJ38DF1vEyJE9JDeJ+6JyOcbGRp+kXDSs=;
        b=Fz15OeqXMX7kkZzgx2Mnl90Zrs+BEcIMmHAYjhGk/KYCMcJ2FIRZnlaq9945c1ITe10mZt
        SkdTg65CBcbj37Ag==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 35883A3B81;
        Wed,  9 Jun 2021 09:57:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 15B841F2C98; Wed,  9 Jun 2021 11:57:03 +0200 (CEST)
Date:   Wed, 9 Jun 2021 11:57:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: no need to verify new add extent block
Message-ID: <20210609095703.GK5562@quack2.suse.cz>
References: <20210609075545.1442160-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609075545.1442160-1-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 09-06-21 15:55:45, yangerkun wrote:
> ext4_ext_grow_indepth will add a new extent block which has init the
> expected content. We can mark this buffer as verified so to stop a
> useless check in __read_extent_tree_block.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index cbf37b2cf871..6ca5be8a8fc2 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1306,6 +1306,7 @@ static int ext4_ext_grow_indepth(handle_t *handle, struct inode *inode,
>  	neh->eh_magic = EXT4_EXT_MAGIC;
>  	ext4_extent_block_csum_set(inode, neh);
>  	set_buffer_uptodate(bh);
> +	set_buffer_verified(bh);
>  	unlock_buffer(bh);
>  
>  	err = ext4_handle_dirty_metadata(handle, inode, bh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
