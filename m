Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE13D2B021F
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Nov 2020 10:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKLJlP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Nov 2020 04:41:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:57820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgKLJlP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Nov 2020 04:41:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7982ABCC;
        Thu, 12 Nov 2020 09:41:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A4A4F1E130B; Thu, 12 Nov 2020 10:34:54 +0100 (CET)
Date:   Thu, 12 Nov 2020 10:34:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ext2: Use ext2_put_page
Message-ID: <20201112093454.GA27697@quack2.suse.cz>
References: <20201111205530.436692-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111205530.436692-1-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 11-11-20 12:55:30, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> There are 3 places in namei.c where the equivalent of ext2_put_page() is
> open coded on a page which was returned from the ext2_get_page() call
> [through the use of ext2_find_entry() and ext2_dotdot()].
> 
> Move ext2_get_page() and ext2_put_page() to ext2.h in order to help
> clarify the use of the get/put and then use ext2_put_page() in namei.c
> 
> Also add a comment regarding the proper way to release the page returned
> from ext2_find_entry() and ext2_dotdot().
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Thanks. Good cleanup. I've added it to my tree.

								Honza

> 
> ---
> 
> This was originally part of the kmap_thread() series here:
> 
> https://lore.kernel.org/lkml/20201009195033.3208459-37-ira.weiny@intel.com/
> 
> But this is really a valid clean up regardless of the
> kmap_thread[local]() changes.
> ---
>  fs/ext2/dir.c   | 33 ++++++++-------------------------
>  fs/ext2/ext2.h  | 27 +++++++++++++++++++++++++++
>  fs/ext2/namei.c | 15 +++++----------
>  3 files changed, 40 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index 70355ab6740e..8acd77a66ff4 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -66,12 +66,6 @@ static inline unsigned ext2_chunk_size(struct inode *inode)
>  	return inode->i_sb->s_blocksize;
>  }
>  
> -static inline void ext2_put_page(struct page *page)
> -{
> -	kunmap(page);
> -	put_page(page);
> -}
> -
>  /*
>   * Return the offset into page `page_nr' of the last valid
>   * byte in that page, plus one.
> @@ -196,25 +190,6 @@ static bool ext2_check_page(struct page *page, int quiet)
>  	return false;
>  }
>  
> -static struct page * ext2_get_page(struct inode *dir, unsigned long n,
> -				   int quiet)
> -{
> -	struct address_space *mapping = dir->i_mapping;
> -	struct page *page = read_mapping_page(mapping, n, NULL);
> -	if (!IS_ERR(page)) {
> -		kmap(page);
> -		if (unlikely(!PageChecked(page))) {
> -			if (PageError(page) || !ext2_check_page(page, quiet))
> -				goto fail;
> -		}
> -	}
> -	return page;
> -
> -fail:
> -	ext2_put_page(page);
> -	return ERR_PTR(-EIO);
> -}
> -
>  /*
>   * NOTE! unlike strncmp, ext2_match returns 1 for success, 0 for failure.
>   *
> @@ -336,6 +311,8 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
>   * returns the page in which the entry was found (as a parameter - res_page),
>   * and the entry itself. Page is returned mapped and unlocked.
>   * Entry is guaranteed to be valid.
> + *
> + * On Success ext2_put_page() should be called on *res_page.
>   */
>  struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
>  			const struct qstr *child, struct page **res_page)
> @@ -401,6 +378,12 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
>  	return de;
>  }
>  
> +/**
> + * Return the '..' directory entry and the page in which the entry was found
> + * (as a parameter - p).
> + *
> + * On Success ext2_put_page() should be called on *p.
> + */
>  struct ext2_dir_entry_2 * ext2_dotdot (struct inode *dir, struct page **p)
>  {
>  	struct page *page = ext2_get_page(dir, 0, 0);
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index 5136b7289e8d..b4403f96858b 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -16,6 +16,8 @@
>  #include <linux/blockgroup_lock.h>
>  #include <linux/percpu_counter.h>
>  #include <linux/rbtree.h>
> +#include <linux/mm.h>
> +#include <linux/highmem.h>
>  
>  /* XXX Here for now... not interested in restructing headers JUST now */
>  
> @@ -745,6 +747,31 @@ extern int ext2_delete_entry (struct ext2_dir_entry_2 *, struct page *);
>  extern int ext2_empty_dir (struct inode *);
>  extern struct ext2_dir_entry_2 * ext2_dotdot (struct inode *, struct page **);
>  extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, struct inode *, int);
> +static inline void ext2_put_page(struct page *page)
> +{
> +	kunmap(page);
> +	put_page(page);
> +}
> +
> +static inline struct page * ext2_get_page(struct inode *dir, unsigned long n,
> +				   int quiet)
> +{
> +	struct address_space *mapping = dir->i_mapping;
> +	struct page *page = read_mapping_page(mapping, n, NULL);
> +	if (!IS_ERR(page)) {
> +		kmap(page);
> +		if (unlikely(!PageChecked(page))) {
> +			if (PageError(page) || !ext2_check_page(page, quiet))
> +				goto fail;
> +		}
> +	}
> +	return page;
> +
> +fail:
> +	ext2_put_page(page);
> +	return ERR_PTR(-EIO);
> +}
> +
>  
>  /* ialloc.c */
>  extern struct inode * ext2_new_inode (struct inode *, umode_t, const struct qstr *);
> diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
> index 5bf2c145643b..ea980f1e2e99 100644
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -389,23 +389,18 @@ static int ext2_rename (struct inode * old_dir, struct dentry * old_dentry,
>  	if (dir_de) {
>  		if (old_dir != new_dir)
>  			ext2_set_link(old_inode, dir_de, dir_page, new_dir, 0);
> -		else {
> -			kunmap(dir_page);
> -			put_page(dir_page);
> -		}
> +		else
> +			ext2_put_page(dir_page);
>  		inode_dec_link_count(old_dir);
>  	}
>  	return 0;
>  
>  
>  out_dir:
> -	if (dir_de) {
> -		kunmap(dir_page);
> -		put_page(dir_page);
> -	}
> +	if (dir_de)
> +		ext2_put_page(dir_page);
>  out_old:
> -	kunmap(old_page);
> -	put_page(old_page);
> +	ext2_put_page(old_page);
>  out:
>  	return err;
>  }
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
