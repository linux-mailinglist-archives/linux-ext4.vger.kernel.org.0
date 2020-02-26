Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE8616FE9B
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 13:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgBZMDM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Feb 2020 07:03:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:51944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgBZMDM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 Feb 2020 07:03:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A0080AE48;
        Wed, 26 Feb 2020 12:03:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DDABB1E0EA2; Wed, 26 Feb 2020 13:03:08 +0100 (CET)
Date:   Wed, 26 Feb 2020 13:03:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: using matching invalidatepage in ext4_writepage
Message-ID: <20200226120308.GI10728@quack2.suse.cz>
References: <20200226041002.13914-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226041002.13914-1-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 26-02-20 12:10:02, yangerkun wrote:
> Run generic/388 with journal data mode sometimes may trigger the warning
> in ext4_invalidatepage. Actually, we should use the matching invalidatepage
> in ext4_writepage.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Thanks for the patch! It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index fa0ff78dc033..78e805d42ada 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1974,7 +1974,7 @@ static int ext4_writepage(struct page *page,
>  	bool keep_towrite = false;
>  
>  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
> -		ext4_invalidatepage(page, 0, PAGE_SIZE);
> +		inode->i_mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
>  		unlock_page(page);
>  		return -EIO;
>  	}
> -- 
> 2.23.0.rc2.8.gff66981f45
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
