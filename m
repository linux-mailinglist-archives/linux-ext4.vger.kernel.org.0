Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0911C22EC57
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 14:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgG0Mjp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 08:39:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60070 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728286AbgG0Mjp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 08:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595853583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IpMwJZAjp66W1Ax/dHd9zWBZb6rH4gvcCsfylU60l2A=;
        b=P5MGToGpMwc7In2z1zGILe9xDZJzESx2Wa2IDjCoq0/ghF49DuTfve/sxtQNOL+PEP7pE/
        G3Cy1yLML1YMvHiXPgJek+JnKXYBChHgvN/824xiEUY9ckcg6DhbLmdFcRH4KJs60XqoDF
        M8aNU2sKbIeNFeLxuM4DJyq7LrdlTEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-2JYyIPUuP1e_IJ2My1vUTg-1; Mon, 27 Jul 2020 08:39:41 -0400
X-MC-Unique: 2JYyIPUuP1e_IJ2My1vUTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC3CD100A8C0;
        Mon, 27 Jul 2020 12:39:40 +0000 (UTC)
Received: from work (unknown [10.40.192.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AB668FA5D;
        Mon, 27 Jul 2020 12:39:39 +0000 (UTC)
Date:   Mon, 27 Jul 2020 14:39:34 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/6] ext4: Handle add_system_zone() failure in
 ext4_setup_system_zone()
Message-ID: <20200727123934.ws2wbvphbbbu6ujr@work>
References: <20200727114429.1478-1-jack@suse.cz>
 <20200727114429.1478-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727114429.1478-6-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 27, 2020 at 01:44:28PM +0200, Jan Kara wrote:
> There's one place that fails to handle error from add_system_zone() call
> and thus we can fail to protect superblock and group-descriptor blocks
> properly in case of ENOMEM. Fix it.

Looks good, thanks.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Reported-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/block_validity.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 9c40214f31f9..2d008c1b58f2 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -235,10 +235,13 @@ int ext4_setup_system_zone(struct super_block *sb)
>  	for (i=0; i < ngroups; i++) {
>  		cond_resched();
>  		if (ext4_bg_has_super(sb, i) &&
> -		    ((i < 5) || ((i % flex_size) == 0)))
> -			add_system_zone(system_blks,
> +		    ((i < 5) || ((i % flex_size) == 0))) {
> +			ret = add_system_zone(system_blks,
>  					ext4_group_first_block_no(sb, i),
>  					ext4_bg_num_gdb(sb, i) + 1, 0);
> +			if (ret)
> +				goto err;
> +		}
>  		gdp = ext4_get_group_desc(sb, i, NULL);
>  		ret = add_system_zone(system_blks,
>  				ext4_block_bitmap(sb, gdp), 1, 0);
> -- 
> 2.16.4
> 

