Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9EF227D2A
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGUKhM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 06:37:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37535 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbgGUKhM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 Jul 2020 06:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595327830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QR2hCphuvwAGaWepx5vffd7yvUYpdlXoSQP8Q2CvwL8=;
        b=S9vDU+Kcl7Um/bBZoM1nf6OMYn/alIeZ8hoWdpeq6GC2AbiRmceD0Egxq2MXzBskdJONxQ
        Foi0RbNcz4S0Rgw6T1zMrnoDt40cc+TUxAIoIJ+LNT9L+G/b4Sxz3KM/UtzA9nz2fQYG2H
        Onhzn+DjT29e8LR4hkcbzS6Zmm71UT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-evUVTeHxMCC0uE5MUqcORg-1; Tue, 21 Jul 2020 06:37:06 -0400
X-MC-Unique: evUVTeHxMCC0uE5MUqcORg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48F0E100AA25;
        Tue, 21 Jul 2020 10:37:05 +0000 (UTC)
Received: from work (unknown [10.40.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE5D67303C;
        Tue, 21 Jul 2020 10:37:02 +0000 (UTC)
Date:   Tue, 21 Jul 2020 12:36:59 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Wolfgang Frisch <wolfgang.frisch@suse.com>
Subject: Re: [PATCH 2/4] ext4: Don't allow overlapping system zones
Message-ID: <20200721103659.je33lyuqubuhkizg@work>
References: <20200715131812.7243-1-jack@suse.cz>
 <20200715131812.7243-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715131812.7243-3-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 15, 2020 at 03:18:10PM +0200, Jan Kara wrote:
> Currently, add_system_zone() just silently merges two added system zones
> that overlap. However the overlap should not happen and it generally
> suggests that some unrelated metadata overlap which indicates the fs is
> corrupted. We should have caught such problems earlier (e.g. in
> ext4_check_descriptors()) but add this check as another line of defense.
> In later patch we also use this for stricter checking of journal inode
> extent tree.

Looks good, thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>


> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/block_validity.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 16e9b2fda03a..b394a50ebbe3 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -68,7 +68,7 @@ static int add_system_zone(struct ext4_system_blocks *system_blks,
>  			   ext4_fsblk_t start_blk,
>  			   unsigned int count)
>  {
> -	struct ext4_system_zone *new_entry = NULL, *entry;
> +	struct ext4_system_zone *new_entry, *entry;
>  	struct rb_node **n = &system_blks->root.rb_node, *node;
>  	struct rb_node *parent = NULL, *new_node = NULL;
>  
> @@ -79,30 +79,20 @@ static int add_system_zone(struct ext4_system_blocks *system_blks,
>  			n = &(*n)->rb_left;
>  		else if (start_blk >= (entry->start_blk + entry->count))
>  			n = &(*n)->rb_right;
> -		else {
> -			if (start_blk + count > (entry->start_blk +
> -						 entry->count))
> -				entry->count = (start_blk + count -
> -						entry->start_blk);
> -			new_node = *n;
> -			new_entry = rb_entry(new_node, struct ext4_system_zone,
> -					     node);
> -			break;
> -		}
> +		else	/* Unexpected overlap of system zones. */
> +			return -EFSCORRUPTED;
>  	}
>  
> -	if (!new_entry) {
> -		new_entry = kmem_cache_alloc(ext4_system_zone_cachep,
> -					     GFP_KERNEL);
> -		if (!new_entry)
> -			return -ENOMEM;
> -		new_entry->start_blk = start_blk;
> -		new_entry->count = count;
> -		new_node = &new_entry->node;
> -
> -		rb_link_node(new_node, parent, n);
> -		rb_insert_color(new_node, &system_blks->root);
> -	}
> +	new_entry = kmem_cache_alloc(ext4_system_zone_cachep,
> +				     GFP_KERNEL);
> +	if (!new_entry)
> +		return -ENOMEM;
> +	new_entry->start_blk = start_blk;
> +	new_entry->count = count;
> +	new_node = &new_entry->node;
> +
> +	rb_link_node(new_node, parent, n);
> +	rb_insert_color(new_node, &system_blks->root);
>  
>  	/* Can we merge to the left? */
>  	node = rb_prev(new_node);
> -- 
> 2.16.4
> 

