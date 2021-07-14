Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641C93C8958
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jul 2021 19:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhGNRKi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jul 2021 13:10:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:26414 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhGNRKi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 14 Jul 2021 13:10:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="271502514"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="271502514"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:07:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; 
   d="scan'208";a="571239941"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 10:07:46 -0700
Date:   Wed, 14 Jul 2021 10:07:46 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Javier Pello <javier.pello@urjc.es>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/ext2: Avoid page_address on pages returned by
 ext2_get_page
Message-ID: <20210714170746.GL3169279@iweiny-DESK2.sc.intel.com>
References: <20210713165821.8a268e2c1db4fd5cf452acd2@urjc.es>
 <20210713165918.10da0318af5b9b73e599a517@urjc.es>
 <20210713163018.GF24271@quack2.suse.cz>
 <20210713193319.a223cd12e3fb8687f0cae0e8@urjc.es>
 <20210714090013.GA9457@quack2.suse.cz>
 <20210714185448.8707ac239e9f12b3a7f5b9f9@urjc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714185448.8707ac239e9f12b3a7f5b9f9@urjc.es>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 14, 2021 at 06:54:48PM +0200, Javier Pello wrote:
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
> 

Again thanks for catching this!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Javier Pello <javier.pello@urjc.es>
> Fixes: 782b76d7abdf ("fs/ext2: Replace kmap() with kmap_local_page()")
> ---
> 
> v2: Use char * for the new parameter to ext2_delete_entry.
> 
>  fs/ext2/dir.c   | 12 ++++++------
>  fs/ext2/ext2.h  |  3 ++-
>  fs/ext2/namei.c |  4 ++--
>  3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index 14292dba..2c2f179b 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -106,12 +106,11 @@ static int ext2_commit_chunk(struct page *page, loff_t pos, unsigned len)
>  	return err;
>  }
>  
> -static bool ext2_check_page(struct page *page, int quiet)
> +static bool ext2_check_page(struct page *page, int quiet, char *kaddr)
>  {
>  	struct inode *dir = page->mapping->host;
>  	struct super_block *sb = dir->i_sb;
>  	unsigned chunk_size = ext2_chunk_size(dir);
> -	char *kaddr = page_address(page);
>  	u32 max_inumber = le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count);
>  	unsigned offs, rec_len;
>  	unsigned limit = PAGE_SIZE;
> @@ -205,7 +204,8 @@ static struct page * ext2_get_page(struct inode *dir, unsigned long n,
>  	if (!IS_ERR(page)) {
>  		*page_addr = kmap_local_page(page);
>  		if (unlikely(!PageChecked(page))) {
> -			if (PageError(page) || !ext2_check_page(page, quiet))
> +			if (PageError(page) || !ext2_check_page(page, quiet,
> +								*page_addr))
>  				goto fail;
>  		}
>  	}
> @@ -584,10 +584,10 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
>   * ext2_delete_entry deletes a directory entry by merging it with the
>   * previous entry. Page is up-to-date.
>   */
> -int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
> +int ext2_delete_entry (struct ext2_dir_entry_2 *dir, struct page *page,
> +			char *kaddr)
>  {
>  	struct inode *inode = page->mapping->host;
> -	char *kaddr = page_address(page);
>  	unsigned from = ((char*)dir - kaddr) & ~(ext2_chunk_size(inode)-1);
>  	unsigned to = ((char *)dir - kaddr) +
>  				ext2_rec_len_from_disk(dir->rec_len);
> @@ -607,7 +607,7 @@ int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
>  		de = ext2_next_entry(de);
>  	}
>  	if (pde)
> -		from = (char*)pde - (char*)page_address(page);
> +		from = (char *)pde - kaddr;
>  	pos = page_offset(page) + from;
>  	lock_page(page);
>  	err = ext2_prepare_chunk(page, pos, to - from);
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index b0a69482..e512630c 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -740,7 +740,8 @@ extern int ext2_inode_by_name(struct inode *dir,
>  extern int ext2_make_empty(struct inode *, struct inode *);
>  extern struct ext2_dir_entry_2 *ext2_find_entry(struct inode *, const struct qstr *,
>  						struct page **, void **res_page_addr);
> -extern int ext2_delete_entry (struct ext2_dir_entry_2 *, struct page *);
> +extern int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page,
> +			     char *kaddr);
>  extern int ext2_empty_dir (struct inode *);
>  extern struct ext2_dir_entry_2 *ext2_dotdot(struct inode *dir, struct page **p, void **pa);
>  extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, void *,
> diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
> index 1f69b816..5f6b7560 100644
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -293,7 +293,7 @@ static int ext2_unlink(struct inode * dir, struct dentry *dentry)
>  		goto out;
>  	}
>  
> -	err = ext2_delete_entry (de, page);
> +	err = ext2_delete_entry (de, page, page_addr);
>  	ext2_put_page(page, page_addr);
>  	if (err)
>  		goto out;
> @@ -397,7 +397,7 @@ static int ext2_rename (struct user_namespace * mnt_userns,
>  	old_inode->i_ctime = current_time(old_inode);
>  	mark_inode_dirty(old_inode);
>  
> -	ext2_delete_entry(old_de, old_page);
> +	ext2_delete_entry(old_de, old_page, old_page_addr);
>  
>  	if (dir_de) {
>  		if (old_dir != new_dir)
> -- 
> 2.30.1
