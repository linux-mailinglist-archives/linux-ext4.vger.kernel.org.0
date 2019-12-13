Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D048911E2DA
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2019 12:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLMLfN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Dec 2019 06:35:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:33890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfLMLfN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 13 Dec 2019 06:35:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 724F5ACD9;
        Fri, 13 Dec 2019 11:35:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E5FC21E0CAF; Fri, 13 Dec 2019 12:35:10 +0100 (CET)
Date:   Fri, 13 Dec 2019 12:35:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, paulmck@kernel.org,
        joel@joelfernandes.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, rcu@vger.kernel.org
Subject: Re: [PATCH] ext4: use rcu API in debug_print_tree
Message-ID: <20191213113510.GG15474@quack2.suse.cz>
References: <20191201035107.24355-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191201035107.24355-1-tranmanphong@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 01-12-19 10:51:07, Phong Tran wrote:
> struct ext4_sb_info.system_blks was marked __rcu.
> But access the pointer without using RCU lock and dereference.
> Sparse warning with __rcu notation:
> 
> block_validity.c:139:29: warning: incorrect type in argument 1 (different address spaces)
> block_validity.c:139:29:    expected struct rb_root const *
> block_validity.c:139:29:    got struct rb_root [noderef] <asn:4> *
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

Thanks for the patch. It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/block_validity.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index d4d4fdfac1a6..1ee04e76bbe0 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -133,10 +133,13 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
>  {
>  	struct rb_node *node;
>  	struct ext4_system_zone *entry;
> +	struct ext4_system_blocks *system_blks;
>  	int first = 1;
>  
>  	printk(KERN_INFO "System zones: ");
> -	node = rb_first(&sbi->system_blks->root);
> +	rcu_read_lock();
> +	system_blks = rcu_dereference(sbi->system_blks);
> +	node = rb_first(&system_blks->root);
>  	while (node) {
>  		entry = rb_entry(node, struct ext4_system_zone, node);
>  		printk(KERN_CONT "%s%llu-%llu", first ? "" : ", ",
> @@ -144,6 +147,7 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
>  		first = 0;
>  		node = rb_next(node);
>  	}
> +	rcu_read_unlock();
>  	printk(KERN_CONT "\n");
>  }
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
