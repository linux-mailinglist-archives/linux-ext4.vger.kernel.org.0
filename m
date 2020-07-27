Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2031522E845
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgG0I6T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 04:58:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:38898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgG0I6T (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 04:58:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8176AC37;
        Mon, 27 Jul 2020 08:58:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 740091E12C5; Mon, 27 Jul 2020 10:58:17 +0200 (CEST)
Date:   Mon, 27 Jul 2020 10:58:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: ext2.h: fix duplicated word + typos
Message-ID: <20200727085817.GF23179@quack2.suse.cz>
References: <20200720001327.23603-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720001327.23603-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 19-07-20 17:13:27, Randy Dunlap wrote:
> Change the repeated word "the" in "it the the" to "it is the".
> Fix typo "recentl" to "recently".
> Fix verb "give" to "gives".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jan Kara <jack@suse.com>
> Cc: linux-ext4@vger.kernel.org

Thanks! Applied.

									Honza

> ---
>  fs/ext2/ext2.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200717.orig/fs/ext2/ext2.h
> +++ linux-next-20200717/fs/ext2/ext2.h
> @@ -52,8 +52,8 @@ struct ext2_block_alloc_info {
>  	/*
>  	 * Was i_next_alloc_goal in ext2_inode_info
>  	 * is the *physical* companion to i_next_alloc_block.
> -	 * it the the physical block number of the block which was most-recentl
> -	 * allocated to this file.  This give us the goal (target) for the next
> +	 * it is the physical block number of the block which was most-recently
> +	 * allocated to this file.  This gives us the goal (target) for the next
>  	 * allocation when we detect linearly ascending requests.
>  	 */
>  	ext2_fsblk_t		last_alloc_physical_block;
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
