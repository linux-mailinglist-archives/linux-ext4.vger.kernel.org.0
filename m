Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D7D8AFC
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2019 10:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfJPIbK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Oct 2019 04:31:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfJPIbK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Oct 2019 04:31:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99E11B600;
        Wed, 16 Oct 2019 08:31:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4ED151E3BDE; Wed, 16 Oct 2019 10:31:08 +0200 (CEST)
Date:   Wed, 16 Oct 2019 10:31:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        tytso@mit.edu, mbobrowski@mbobrowski.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/2] ext4: Move ext4 bmap to use iomap infrastructure.
Message-ID: <20191016083108.GA30337@quack2.suse.cz>
References: <20190820130634.25954-1-riteshh@linux.ibm.com>
 <20190820130634.25954-2-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820130634.25954-2-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 20-08-19 18:36:33, Ritesh Harjani wrote:
> ext4_iomap_begin is already implemented which provides
> ext4_map_blocks, so just move the API from
> generic_block_bmap to iomap_bmap for iomap conversion.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

This seems to have fallen through the cracks. The patch looks OK, feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>
	
								Honza

> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 420fe3deed39..d6a34214e9df 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3355,7 +3355,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>  			return 0;
>  	}
>  
> -	return generic_block_bmap(mapping, block, ext4_get_block);
> +	return iomap_bmap(mapping, block, &ext4_iomap_ops);
>  }
>  
>  static int ext4_readpage(struct file *file, struct page *page)
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
