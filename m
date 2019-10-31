Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF15EEAC4F
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2019 10:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfJaJHw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Oct 2019 05:07:52 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2075 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbfJaJHw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 31 Oct 2019 05:07:52 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id EECDE1A731B038F76B1D;
        Thu, 31 Oct 2019 17:07:49 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 31 Oct 2019 17:07:49 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 31 Oct 2019 17:07:49 +0800
Date:   Thu, 31 Oct 2019 17:10:33 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: bio_alloc never fails
Message-ID: <20191031091033.GA89030@architecture4>
References: <20191030042618.124220-1-gaoxiang25@huawei.com>
 <2716559d-95ac-399b-8105-38834f5ed660@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2716559d-95ac-399b-8105-38834f5ed660@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme717-chm.china.huawei.com (10.1.199.113) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Chao,

On Thu, Oct 31, 2019 at 10:01:20AM +0800, Chao Yu wrote:
> On 2019/10/30 12:26, Gao Xiang wrote:
> > Similar to [1] [2], it seems a trivial cleanup since
> > bio_alloc can handle memory allocation as mentioned in
> > fs/direct-io.c (also see fs/block_dev.c, fs/buffer.c, ..)
> > 
> > [1] https://lore.kernel.org/r/20191030035518.65477-1-gaoxiang25@huawei.com
> > [2] https://lore.kernel.org/r/20190830162812.GA10694@infradead.org
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> I notice that there is still similar code in mpage.c
> 
> static struct bio *
> mpage_alloc(struct block_device *bdev,
> 		sector_t first_sector, int nr_vecs,
> 		gfp_t gfp_flags)
> {
> 	struct bio *bio;
> 
> 	/* Restrict the given (page cache) mask for slab allocations */
> 	gfp_flags &= GFP_KERNEL;
> 	bio = bio_alloc(gfp_flags, nr_vecs);
> 
> 	if (bio == NULL && (current->flags & PF_MEMALLOC)) {
> 		while (!bio && (nr_vecs /= 2))
> 			bio = bio_alloc(gfp_flags, nr_vecs);
> 	}
> 
> 	if (bio) {
> 		bio_set_dev(bio, bdev);
> 		bio->bi_iter.bi_sector = first_sector;
> 	}
> 	return bio;
> }
> 
> Should we clean up them as well? however, I doubt we should get rid of loop in
> mempool allocation to relief the memory pressure on those uncritical path, for
> critical path like we should never fail, it would be fine looping in bio_alloc().

Thanks for your suggestion.

For mpage.c, it seems another story since those gfp_flags are
actually derived from specific inodes (via mapping_gfp_constraint
or readahead_gfp_mask), so I think leaving such paths for mpage.c
could be necessary. Just my personal thought.

Thanks,
Gao Xiang


> 
> Thanks,
> 
> > ---
> >  fs/ext4/page-io.c  | 11 +++--------
> >  fs/ext4/readpage.c |  2 --
> >  2 files changed, 3 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> > index 12ceadef32c5..f1f7b6601780 100644
> > --- a/fs/ext4/page-io.c
> > +++ b/fs/ext4/page-io.c
> > @@ -358,14 +358,12 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
> >  	io->io_end = NULL;
> >  }
> >  
> > -static int io_submit_init_bio(struct ext4_io_submit *io,
> > -			      struct buffer_head *bh)
> > +static void io_submit_init_bio(struct ext4_io_submit *io,
> > +			       struct buffer_head *bh)
> >  {
> >  	struct bio *bio;
> >  
> >  	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
> > -	if (!bio)
> > -		return -ENOMEM;
> >  	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
> >  	bio_set_dev(bio, bh->b_bdev);
> >  	bio->bi_end_io = ext4_end_bio;
> > @@ -373,7 +371,6 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
> >  	io->io_bio = bio;
> >  	io->io_next_block = bh->b_blocknr;
> >  	wbc_init_bio(io->io_wbc, bio);
> > -	return 0;
> >  }
> >  
> >  static int io_submit_add_bh(struct ext4_io_submit *io,
> > @@ -388,9 +385,7 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
> >  		ext4_io_submit(io);
> >  	}
> >  	if (io->io_bio == NULL) {
> > -		ret = io_submit_init_bio(io, bh);
> > -		if (ret)
> > -			return ret;
> > +		io_submit_init_bio(io, bh);
> >  		io->io_bio->bi_write_hint = inode->i_write_hint;
> >  	}
> >  	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
> > diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> > index a30b203fa461..bfeb77b93f48 100644
> > --- a/fs/ext4/readpage.c
> > +++ b/fs/ext4/readpage.c
> > @@ -362,8 +362,6 @@ int ext4_mpage_readpages(struct address_space *mapping,
> >  
> >  			bio = bio_alloc(GFP_KERNEL,
> >  				min_t(int, nr_pages, BIO_MAX_PAGES));
> > -			if (!bio)
> > -				goto set_error_page;
> >  			ctx = get_bio_post_read_ctx(inode, bio, page->index);
> >  			if (IS_ERR(ctx)) {
> >  				bio_put(bio);
> > 
