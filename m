Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59282EA90D
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2019 03:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJaCBj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Oct 2019 22:01:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfJaCBj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Oct 2019 22:01:39 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A534779C3B1900C0935C;
        Thu, 31 Oct 2019 10:01:30 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 31 Oct
 2019 10:01:21 +0800
Subject: Re: [PATCH] ext4: bio_alloc never fails
To:     Gao Xiang <gaoxiang25@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191030042618.124220-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2716559d-95ac-399b-8105-38834f5ed660@huawei.com>
Date:   Thu, 31 Oct 2019 10:01:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191030042618.124220-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/10/30 12:26, Gao Xiang wrote:
> Similar to [1] [2], it seems a trivial cleanup since
> bio_alloc can handle memory allocation as mentioned in
> fs/direct-io.c (also see fs/block_dev.c, fs/buffer.c, ..)
> 
> [1] https://lore.kernel.org/r/20191030035518.65477-1-gaoxiang25@huawei.com
> [2] https://lore.kernel.org/r/20190830162812.GA10694@infradead.org
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

I notice that there is still similar code in mpage.c

static struct bio *
mpage_alloc(struct block_device *bdev,
		sector_t first_sector, int nr_vecs,
		gfp_t gfp_flags)
{
	struct bio *bio;

	/* Restrict the given (page cache) mask for slab allocations */
	gfp_flags &= GFP_KERNEL;
	bio = bio_alloc(gfp_flags, nr_vecs);

	if (bio == NULL && (current->flags & PF_MEMALLOC)) {
		while (!bio && (nr_vecs /= 2))
			bio = bio_alloc(gfp_flags, nr_vecs);
	}

	if (bio) {
		bio_set_dev(bio, bdev);
		bio->bi_iter.bi_sector = first_sector;
	}
	return bio;
}

Should we clean up them as well? however, I doubt we should get rid of loop in
mempool allocation to relief the memory pressure on those uncritical path, for
critical path like we should never fail, it would be fine looping in bio_alloc().

Thanks,

> ---
>  fs/ext4/page-io.c  | 11 +++--------
>  fs/ext4/readpage.c |  2 --
>  2 files changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 12ceadef32c5..f1f7b6601780 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -358,14 +358,12 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
>  	io->io_end = NULL;
>  }
>  
> -static int io_submit_init_bio(struct ext4_io_submit *io,
> -			      struct buffer_head *bh)
> +static void io_submit_init_bio(struct ext4_io_submit *io,
> +			       struct buffer_head *bh)
>  {
>  	struct bio *bio;
>  
>  	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
> -	if (!bio)
> -		return -ENOMEM;
>  	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
>  	bio_set_dev(bio, bh->b_bdev);
>  	bio->bi_end_io = ext4_end_bio;
> @@ -373,7 +371,6 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
>  	io->io_bio = bio;
>  	io->io_next_block = bh->b_blocknr;
>  	wbc_init_bio(io->io_wbc, bio);
> -	return 0;
>  }
>  
>  static int io_submit_add_bh(struct ext4_io_submit *io,
> @@ -388,9 +385,7 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
>  		ext4_io_submit(io);
>  	}
>  	if (io->io_bio == NULL) {
> -		ret = io_submit_init_bio(io, bh);
> -		if (ret)
> -			return ret;
> +		io_submit_init_bio(io, bh);
>  		io->io_bio->bi_write_hint = inode->i_write_hint;
>  	}
>  	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index a30b203fa461..bfeb77b93f48 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -362,8 +362,6 @@ int ext4_mpage_readpages(struct address_space *mapping,
>  
>  			bio = bio_alloc(GFP_KERNEL,
>  				min_t(int, nr_pages, BIO_MAX_PAGES));
> -			if (!bio)
> -				goto set_error_page;
>  			ctx = get_bio_post_read_ctx(inode, bio, page->index);
>  			if (IS_ERR(ctx)) {
>  				bio_put(bio);
> 
