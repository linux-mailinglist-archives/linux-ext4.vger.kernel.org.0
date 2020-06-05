Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C691EFC38
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 17:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgFEPLC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 11:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgFEPLC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jun 2020 11:11:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D2B4AD35;
        Fri,  5 Jun 2020 15:11:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A29591E1281; Fri,  5 Jun 2020 17:11:00 +0200 (CEST)
Date:   Fri, 5 Jun 2020 17:11:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH v2 2/2] ext2: ext2_find_entry() return -ENOENT if no
 entry found
Message-ID: <20200605151100.GD13248@quack2.suse.cz>
References: <20200603063514.3904811-1-yi.zhang@huawei.com>
 <20200603063514.3904811-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603063514.3904811-2-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 03-06-20 14:35:14, zhangyi (F) wrote:
> Almost all callers of ext2_find_entry() transform NULL return value to
> -ENOENT, so just let ext2_find_entry() retuen -ENOENT instead of NULL
> if no valid entry found, and also switch to check the return value of
> ext2_inode_by_name() in ext2_lookup() and ext2_get_parent().
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Thanks for the patch. Just one small nit below.

> @@ -419,11 +419,16 @@ int ext2_inode_by_name(struct inode *dir, const struct qstr *child, ino_t *ino)
>  	struct page *page;
>  	
>  	de = ext2_find_entry(dir, child, &page);
> -	if (IS_ERR_OR_NULL(de))
> +	if (IS_ERR(de))
>  		return PTR_ERR(de);
>  
> -	*ino = le32_to_cpu(de->inode);
>  	ext2_put_page(page);
> +	if (!de->inode) {

ext2_find_entry() will not ever return de with de->inode == 0 because
ext2_match() never returns true for such entries. So I'd just remove this
condition...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
