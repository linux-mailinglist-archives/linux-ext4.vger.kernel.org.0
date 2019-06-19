Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23004B6DA
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2019 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbfFSLN7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jun 2019 07:13:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:60880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfFSLN7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Jun 2019 07:13:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A905AF90;
        Wed, 19 Jun 2019 11:13:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD2D61E15DD; Wed, 19 Jun 2019 13:13:57 +0200 (CEST)
Date:   Wed, 19 Jun 2019 13:13:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove redundant assignment to node
Message-ID: <20190619111357.GD32409@quack2.suse.cz>
References: <20190619090007.26962-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619090007.26962-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 19-06-19 10:00:06, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer 'node' is assigned a value that is never read, node is
> later overwritten when it re-assigned a different value inside
> the while-loop.  The assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 023a3eb3afa3..7521de2dcf3a 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1317,7 +1317,6 @@ static int es_do_reclaim_extents(struct ext4_inode_info *ei, ext4_lblk_t end,
>  	es = __es_tree_search(&tree->root, ei->i_es_shrink_lblk);
>  	if (!es)
>  		goto out_wrap;
> -	node = &es->rb_node;
>  	while (*nr_to_scan > 0) {
>  		if (es->es_lblk > end) {
>  			ei->i_es_shrink_lblk = end + 1;
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
