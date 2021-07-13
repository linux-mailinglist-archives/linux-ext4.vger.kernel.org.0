Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B62A3C765D
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhGMSUr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 14:20:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:33725 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMSUr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 13 Jul 2021 14:20:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="232024689"
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="232024689"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 11:17:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="562186964"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 11:17:54 -0700
Date:   Tue, 13 Jul 2021 11:17:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Javier Pello <javier.pello@urjc.es>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] fs/ext2: Avoid page_address on pages returned by
 ext2_get_page
Message-ID: <20210713181754.GD3169279@iweiny-DESK2.sc.intel.com>
References: <20210713165821.8a268e2c1db4fd5cf452acd2@urjc.es>
 <20210713165918.10da0318af5b9b73e599a517@urjc.es>
 <20210713163018.GF24271@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713163018.GF24271@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 13, 2021 at 06:30:18PM +0200, Jan Kara wrote:
> On Tue 13-07-21 16:59:18, Javier Pello wrote:
> > From: Javier Pello <javier.pello@urjc.es>
> > 
> > Commit 782b76d7abdf02b12c46ed6f1e9bf715569027f7 ("fs/ext2: Replace
> > kmap() with kmap_local_page()") replaced the kmap/kunmap calls in
> > ext2_get_page/ext2_put_page with kmap_local_page/kunmap_local for
> > efficiency reasons. As a necessary side change, the commit also
> > made ext2_get_page (and ext2_find_entry and ext2_dotdot) return
> > the mapping address along with the page itself, as it is required
> > for kunmap_local, and converted uses of page_address on such pages
> > to use the newly returned address instead. However, uses of
> > page_address on such pages were missed in ext2_check_page and
> > ext2_delete_entry, which triggers oopses if kmap_local_page happens
> > to return an address from high memory. Fix this now by converting
> > the remaining uses of page_address to use the right address, as
> > returned by kmap_local_page.
> 
> Good catch. Thanks for the patch. Ira, can you please check the patch as
> well?

Yes thanks...  I totally missed those uses.  Sorry.

I don't see any issues with the patch but I think Jan's suggestions below are
good.

On a deeper note I wonder if adding kmap local support to page_address is
appropriate.  But for now this is the correct fix.

Please CC me on V2.  And sorry for the problem,
Ira

> 
> I have just a few nits below:
> 
> > Signed-off-by: Javier Pello <javier.pello@urjc.es>
> > Fixes: 782b76d7abdf fs/ext2: Replace kmap() with kmap_local_page()
> 
> Please wrap subject in Fixes tag into ("...").
> 
> > @@ -584,16 +584,16 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
> >   * ext2_delete_entry deletes a directory entry by merging it with the
> >   * previous entry. Page is up-to-date.
> >   */
> > -int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
> > +int ext2_delete_entry (struct ext2_dir_entry_2 *dir, struct page *page,
> > +			void *kaddr)
> 
> Why not have 'kaddr' as char *. We type it to char * basically everywhere
> anyway.
> 
> >  {
> >  	struct inode *inode = page->mapping->host;
> > -	char *kaddr = page_address(page);
> > -	unsigned from = ((char*)dir - kaddr) & ~(ext2_chunk_size(inode)-1);
> > -	unsigned to = ((char *)dir - kaddr) +
> > -				ext2_rec_len_from_disk(dir->rec_len);
> > +	unsigned int delta = (char *)dir - (char *)kaddr;
> 
> Maybe I'd call this 'offset' rather than 'delta'. Also if kaddr will stay
> char *, you maybe just don't need to touch this...
> 
> > +	unsigned int from = delta & ~(ext2_chunk_size(inode)-1);
> > +	unsigned int to = delta + ext2_rec_len_from_disk(dir->rec_len);
> >  	loff_t pos;
> >  	ext2_dirent * pde = NULL;
> > -	ext2_dirent * de = (ext2_dirent *) (kaddr + from);
> > +	ext2_dirent *de = (ext2_dirent *) ((char *)kaddr + from);
> >  	int err;
> >  
> >  	while ((char*)de < (char*)dir) {
> > @@ -607,7 +607,7 @@ int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
> >  		de = ext2_next_entry(de);
> >  	}
> >  	if (pde)
> > -		from = (char*)pde - (char*)page_address(page);
> > +		from = (char *)pde - (char *)kaddr;
> >  	pos = page_offset(page) + from;
> >  	lock_page(page);
> >  	err = ext2_prepare_chunk(page, pos, to - from);
> 
> 									Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
