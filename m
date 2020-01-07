Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4784213230C
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 10:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgAGJzx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 04:55:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:59414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgAGJzx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 7 Jan 2020 04:55:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 15BA8AB87;
        Tue,  7 Jan 2020 09:55:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D781F1E0B47; Tue,  7 Jan 2020 10:55:51 +0100 (CET)
Date:   Tue, 7 Jan 2020 10:55:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, ebiggers@kernel.org, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH 1/1] ext4: remove unused macro MPAGE_DA_EXTENT_TAIL
Message-ID: <20200107095551.GD26849@quack2.suse.cz>
References: <20191231180444.46586-1-ebiggers@kernel.org>
 <20200101095137.25656-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101095137.25656-1-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 01-01-20 15:21:37, Ritesh Harjani wrote:
> Remove unused macro MPAGE_DA_EXTENT_TAIL which
> is no more used after below commit
> 4e7ea81d ("ext4: restructure writeback path")
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/inode.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 748a9e6baab1..b1249e82e57c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -48,8 +48,6 @@
>  
>  #include <trace/events/ext4.h>
>  
> -#define MPAGE_DA_EXTENT_TAIL 0x01
> -
>  static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
>  			      struct ext4_inode_info *ei)
>  {
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
