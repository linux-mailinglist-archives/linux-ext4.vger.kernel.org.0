Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858ACB8EC7
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408656AbfITLEE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 07:04:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:39474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406008AbfITLEE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 07:04:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DFABAAEF6;
        Fri, 20 Sep 2019 11:04:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8068E1E443E; Fri, 20 Sep 2019 13:04:13 +0200 (CEST)
Date:   Fri, 20 Sep 2019 13:04:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com
Subject: Re: [PATCH v2] ext4: fix a bug in ext4_wait_for_tail_page_commit
Message-ID: <20190920110413.GB25765@quack2.suse.cz>
References: <20190919063508.1045-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919063508.1045-1-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 19-09-19 14:35:08, yangerkun wrote:
> No need to wait for any commit once the page is fully truncated.
> Besides, it may confuse e.g. concurrent ext4_writepage() with the page
> still be dirty (will be cleared by truncate_pagecache() in
> ext4_setattr()) but buffers has been freed; and then trigger a bug
> show as below:
> 
> [   26.057508] ------------[ cut here ]------------
> [   26.058531] kernel BUG at fs/ext4/inode.c:2134!
> ...
> [   26.088130] Call trace:
> [   26.088695]  ext4_writepage+0x914/0xb28
> [   26.089541]  writeout.isra.4+0x1b4/0x2b8
> [   26.090409]  move_to_new_page+0x3b0/0x568
> [   26.091338]  __unmap_and_move+0x648/0x988
> [   26.092241]  unmap_and_move+0x48c/0xbb8
> [   26.093096]  migrate_pages+0x220/0xb28
> [   26.093945]  kernel_mbind+0x828/0xa18
> [   26.094791]  __arm64_sys_mbind+0xc8/0x138
> [   26.095716]  el0_svc_common+0x190/0x490
> [   26.096571]  el0_svc_handler+0x60/0xd0
> [   26.097423]  el0_svc+0x8/0xc
> 
> Run the procedure (generate by syzkaller) parallel with ext3.
> 
> void main()
> {
> 	int fd, fd1, ret;
> 	void *addr;
> 	size_t length = 4096;
> 	int flags;
> 	off_t offset = 0;
> 	char *str = "12345";
> 
> 	fd = open("a", O_RDWR | O_CREAT);
> 	assert(fd >= 0);
> 
> 	/* Truncate to 4k */
> 	ret = ftruncate(fd, length);
> 	assert(ret == 0);
> 
> 	/* Journal data mode */
> 	flags = 0xc00f;
> 	ret = ioctl(fd, _IOW('f', 2, long), &flags);
> 	assert(ret == 0);
> 
> 	/* Truncate to 0 */
> 	fd1 = open("a", O_TRUNC | O_NOATIME);
> 	assert(fd1 >= 0);
> 
> 	addr = mmap(NULL, length, PROT_WRITE | PROT_READ,
> 					MAP_SHARED, fd, offset);
> 	assert(addr != (void *)-1);
> 
> 	memcpy(addr, str, 5);
> 	mbind(addr, length, 0, 0, 0, MPOL_MF_MOVE);
> }
> 
> And the bug will be triggered once we seen the below order.
> 
> reproduce1                         reproduce2
> 
> ...                            |   ...
> truncate to 4k                 |
> change to journal data mode    |
>                                |   memcpy(set page dirty)
> truncate to 0:                 |
> ext4_setattr:                  |
> ...                            |
> ext4_wait_for_tail_page_commit |
>                                |   mbind(trigger bug)
> truncate_pagecache(clean dirty)|   ...
> ...                            |
> 
> mbind will call ext4_writepage() since the page still be dirty, and then
> report the bug since the buffers has been free. Fix it by return
> directly once offset equals to 0 which means the page has been fully
> truncated.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Thanks for the patch! It looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 006b7a2070bf..db273d23dfba 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5475,11 +5475,15 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
>  
>  	offset = inode->i_size & (PAGE_SIZE - 1);
>  	/*
> -	 * All buffers in the last page remain valid? Then there's nothing to
> -	 * do. We do the check mainly to optimize the common PAGE_SIZE ==
> -	 * blocksize case
> +	 * If the page is fully truncated, we don't need to wait for any commit
> +	 * (and we even should not as __ext4_journalled_invalidatepage() may
> +	 * strip all buffers from the page but keep the page dirty which can then
> +	 * confuse e.g. concurrent ext4_writepage() seeing dirty page without
> +	 * buffers). Also we don't need to wait for any commit if all buffers in
> +	 * the page remain valid. This is most beneficial for the common case of
> +	 * blocksize == PAGESIZE.
>  	 */
> -	if (offset > PAGE_SIZE - i_blocksize(inode))
> +	if (!offset || offset > (PAGE_SIZE - i_blocksize(inode)))
>  		return;
>  	while (1) {
>  		page = find_lock_page(inode->i_mapping,
> -- 
> 2.17.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
