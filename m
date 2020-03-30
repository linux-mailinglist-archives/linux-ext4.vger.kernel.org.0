Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3E6197CDB
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Mar 2020 15:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgC3N1V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Mar 2020 09:27:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27766 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727612AbgC3N1V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Mar 2020 09:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585574840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHQJCUONvDqpSAFMflFfDpjoPZMifg3S9PXNAJKsZ2M=;
        b=bjyWe9epjZ96RblFLctRrvW07ErLEhZITXHfwPc85SDbmwwzOv3jPZHyKxlj+xX6Zi+3TL
        5Wjl2rJncc5PQpo3Tk/33U4D+8QTvtRMQpA0ZKzVuVVO4uAVRPRIeAubj8R6UFoQoDBA8M
        FWAGCB8CM8J8ay6vrFIZnVYUgiK4g7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-VuAJxnkKOIG7je8S8_x3GQ-1; Mon, 30 Mar 2020 09:27:18 -0400
X-MC-Unique: VuAJxnkKOIG7je8S8_x3GQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 719FA149C5;
        Mon, 30 Mar 2020 13:27:17 +0000 (UTC)
Received: from work (unknown [10.40.192.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66B04A63A7;
        Mon, 30 Mar 2020 13:27:16 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:27:12 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] ext2fs: Fix off-by-one in dx_grow_tree()
Message-ID: <20200330132712.ckevhpof4vrsx5rw@work>
References: <20200330090932.29445-1-jack@suse.cz>
 <20200330090932.29445-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330090932.29445-3-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 30, 2020 at 11:09:32AM +0200, Jan Kara wrote:
> There is an off-by-one error in dx_grow_tree() when checking whether we
> can add another level to the tree. Thus we can grow tree too much
> leading to possible crashes in the library or corrupted filesystem. Fix
> the bug.

Looks good, thanks

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Don't we have basically the same off-by-one in
e2fsck/pass1.c handle_htree() ?

       if ((root->indirect_levels > ext2_dir_htree_level(fs)) &&
           fix_problem(ctx, PR_1_HTREE_DEPTH, pctx))

-Lukas

> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  lib/ext2fs/link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/ext2fs/link.c b/lib/ext2fs/link.c
> index 7b5bb022117c..469eea8cd06d 100644
> --- a/lib/ext2fs/link.c
> +++ b/lib/ext2fs/link.c
> @@ -473,7 +473,7 @@ static errcode_t dx_grow_tree(ext2_filsys fs, ext2_ino_t dir,
>  		    ext2fs_le16_to_cpu(info->frames[i].head->limit))
>  			break;
>  	/* Need to grow tree depth? */
> -	if (i < 0 && info->levels > ext2_dir_htree_level(fs))
> +	if (i < 0 && info->levels >= ext2_dir_htree_level(fs))
>  		return EXT2_ET_DIR_NO_SPACE;
>  	lblk = size / fs->blocksize;
>  	size += fs->blocksize;
> -- 
> 2.16.4
> 

