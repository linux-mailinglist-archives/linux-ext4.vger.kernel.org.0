Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F07F5AB
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2019 13:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392250AbfHBLCf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Aug 2019 07:02:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729311AbfHBLCe (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 2 Aug 2019 07:02:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A898B617;
        Fri,  2 Aug 2019 11:02:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 15C941E3F4D; Fri,  2 Aug 2019 13:02:33 +0200 (CEST)
Date:   Fri, 2 Aug 2019 13:02:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: use rb_entry_safe() instead of open-coding it
Message-ID: <20190802110233.GB9339@quack2.suse.cz>
References: <20190725131658.17187-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725131658.17187-1-houweitaoo@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 25-07-19 21:16:58, Weitao Hou wrote:
> use rb_entry_safe() to make it clean
> 
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>

Thanks for the patch. It looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 7521de2dcf3a..08ce5ded3538 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -228,8 +228,7 @@ static struct extent_status *__es_tree_search(struct rb_root *root,
>  
>  	if (es && lblk > ext4_es_end(es)) {
>  		node = rb_next(&es->rb_node);
> -		return node ? rb_entry(node, struct extent_status, rb_node) :
> -			      NULL;
> +		return rb_entry_safe(node, struct extent_status, rb_node);
>  	}
>  
>  	return NULL;
> -- 
> 2.18.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
