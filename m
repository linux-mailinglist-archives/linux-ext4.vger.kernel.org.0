Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9BF3C7486
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhGMQdK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 12:33:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59242 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhGMQdK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jul 2021 12:33:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 39D9D201FF;
        Tue, 13 Jul 2021 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626193819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6CpxQyjv18y0aMeeHfjIcHfYe2zm0CP5+MKiPGR1ng=;
        b=wX1VV577ZLYQD2efMQXEmbJ/BNa2ozrjiGJ4pPtsK04CaGkxS6Z9XVP9rgDvIGelw52h7n
        foPSlrJunDg5ZlLu53DdDLMI0XYpWY4e/ZBQ/6VSIDRvL5jAsGrHW4JsQPtR0crrgC+8jk
        md/uD4kjkB/RYnM7rkoKjeicL2T7AtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626193819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p6CpxQyjv18y0aMeeHfjIcHfYe2zm0CP5+MKiPGR1ng=;
        b=vAEM9QWqJb882v9E2c4B5/l68KPApW+7biFz+T7ZHIQvEcLPConPabgR1CHu4/NXfv91y+
        BA9AXJVaE6SHdcBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 209D2A3B84;
        Tue, 13 Jul 2021 16:30:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F02E71E0BBE; Tue, 13 Jul 2021 18:30:18 +0200 (CEST)
Date:   Tue, 13 Jul 2021 18:30:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Javier Pello <javier.pello@urjc.es>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/1] fs/ext2: Avoid page_address on pages returned by
 ext2_get_page
Message-ID: <20210713163018.GF24271@quack2.suse.cz>
References: <20210713165821.8a268e2c1db4fd5cf452acd2@urjc.es>
 <20210713165918.10da0318af5b9b73e599a517@urjc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713165918.10da0318af5b9b73e599a517@urjc.es>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 13-07-21 16:59:18, Javier Pello wrote:
> From: Javier Pello <javier.pello@urjc.es>
> 
> Commit 782b76d7abdf02b12c46ed6f1e9bf715569027f7 ("fs/ext2: Replace
> kmap() with kmap_local_page()") replaced the kmap/kunmap calls in
> ext2_get_page/ext2_put_page with kmap_local_page/kunmap_local for
> efficiency reasons. As a necessary side change, the commit also
> made ext2_get_page (and ext2_find_entry and ext2_dotdot) return
> the mapping address along with the page itself, as it is required
> for kunmap_local, and converted uses of page_address on such pages
> to use the newly returned address instead. However, uses of
> page_address on such pages were missed in ext2_check_page and
> ext2_delete_entry, which triggers oopses if kmap_local_page happens
> to return an address from high memory. Fix this now by converting
> the remaining uses of page_address to use the right address, as
> returned by kmap_local_page.

Good catch. Thanks for the patch. Ira, can you please check the patch as
well?

I have just a few nits below:

> Signed-off-by: Javier Pello <javier.pello@urjc.es>
> Fixes: 782b76d7abdf fs/ext2: Replace kmap() with kmap_local_page()

Please wrap subject in Fixes tag into ("...").

> @@ -584,16 +584,16 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
>   * ext2_delete_entry deletes a directory entry by merging it with the
>   * previous entry. Page is up-to-date.
>   */
> -int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
> +int ext2_delete_entry (struct ext2_dir_entry_2 *dir, struct page *page,
> +			void *kaddr)

Why not have 'kaddr' as char *. We type it to char * basically everywhere
anyway.

>  {
>  	struct inode *inode = page->mapping->host;
> -	char *kaddr = page_address(page);
> -	unsigned from = ((char*)dir - kaddr) & ~(ext2_chunk_size(inode)-1);
> -	unsigned to = ((char *)dir - kaddr) +
> -				ext2_rec_len_from_disk(dir->rec_len);
> +	unsigned int delta = (char *)dir - (char *)kaddr;

Maybe I'd call this 'offset' rather than 'delta'. Also if kaddr will stay
char *, you maybe just don't need to touch this...

> +	unsigned int from = delta & ~(ext2_chunk_size(inode)-1);
> +	unsigned int to = delta + ext2_rec_len_from_disk(dir->rec_len);
>  	loff_t pos;
>  	ext2_dirent * pde = NULL;
> -	ext2_dirent * de = (ext2_dirent *) (kaddr + from);
> +	ext2_dirent *de = (ext2_dirent *) ((char *)kaddr + from);
>  	int err;
>  
>  	while ((char*)de < (char*)dir) {
> @@ -607,7 +607,7 @@ int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
>  		de = ext2_next_entry(de);
>  	}
>  	if (pde)
> -		from = (char*)pde - (char*)page_address(page);
> +		from = (char *)pde - (char *)kaddr;
>  	pos = page_offset(page) + from;
>  	lock_page(page);
>  	err = ext2_prepare_chunk(page, pos, to - from);

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
