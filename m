Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC654CF7D
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jun 2022 19:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347344AbiFORNQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jun 2022 13:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiFORNP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jun 2022 13:13:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F471F62A;
        Wed, 15 Jun 2022 10:13:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D50EC1F96C;
        Wed, 15 Jun 2022 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655313193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8CivEbm1eQi+6T7TD7NaoGDD1tb2zmymQeNybmz0yHg=;
        b=aHExjNRAIBAuMFp4cvmZuCx8Veb4Ll79aAL2k9p+y75mUzQuOt8x5CzZqM3YCBg7rHdMKu
        M/pzatmmlNob7/NoVzZRa+wAjRm5Ah5AiU3EzwhuYg+lYoKqYBERGlNBPVNzz9F5R5QpQs
        w5isb8ydQA24NpKth03GJXMPx//yDBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655313193;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8CivEbm1eQi+6T7TD7NaoGDD1tb2zmymQeNybmz0yHg=;
        b=XSwputMt4tdWK70Xtwr3duiDh7aZGJwQKTyi+RvDZ7+jaI4TddgO7J+3Jm3/ZrXpMjZI6q
        SeVXixep3fRystBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B6CB52C141;
        Wed, 15 Jun 2022 17:13:13 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2AACDA062E; Wed, 15 Jun 2022 19:13:13 +0200 (CEST)
Date:   Wed, 15 Jun 2022 19:13:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext2: fix fs corruption when trying to remove a
 non-empty directory with IO error
Message-ID: <20220615171313.fnfn6cnozn76cmrl@quack3.lan>
References: <20220615090010.1544152-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615090010.1544152-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-06-22 17:00:10, Ye Bin wrote:
> We got issue as follows:
> [home]# mount  /dev/sdd  test
> [home]# cd test
> [test]# ls
> dir1  lost+found
> [test]# rmdir  dir1
> ext2_empty_dir: inject fault
> [test]# ls
> lost+found
> [test]# cd ..
> [home]# umount test
> [home]# fsck.ext2 -fn  /dev/sdd
> e2fsck 1.42.9 (28-Dec-2013)
> Pass 1: Checking inodes, blocks, and sizes
> Inode 4065, i_size is 0, should be 1024.  Fix? no
> 
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Unconnected directory inode 4065 (/???)
> Connect to /lost+found? no
> 
> '..' in ... (4065) is / (2), should be <The NULL inode> (0).
> Fix? no
> 
> Pass 4: Checking reference counts
> Inode 2 ref count is 3, should be 4.  Fix? no
> 
> Inode 4065 ref count is 2, should be 3.  Fix? no
> 
> Pass 5: Checking group summary information
> 
> /dev/sdd: ********** WARNING: Filesystem still has errors **********
> 
> /dev/sdd: 14/128016 files (0.0% non-contiguous), 18477/512000 blocks
> 
> Reason is same with commit 7aab5c84a0f6. We can't assume directory
> is empty when read directory entry failed.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Honestly, I'm not very much concerned about corrupting the filesystem more
when we've got EIO for metadata but OK, probably what you propose is a
saner choice. I've added the patch to my tree.

								Honza

> ---
>  fs/ext2/dir.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index 3bd5772b401b..8f597753ac12 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -672,17 +672,14 @@ int ext2_empty_dir (struct inode * inode)
>  	void *page_addr = NULL;
>  	struct page *page = NULL;
>  	unsigned long i, npages = dir_pages(inode);
> -	int dir_has_error = 0;
>  
>  	for (i = 0; i < npages; i++) {
>  		char *kaddr;
>  		ext2_dirent * de;
> -		page = ext2_get_page(inode, i, dir_has_error, &page_addr);
> +		page = ext2_get_page(inode, i, 0, &page_addr);
>  
> -		if (IS_ERR(page)) {
> -			dir_has_error = 1;
> -			continue;
> -		}
> +		if (IS_ERR(page))
> +			goto not_empty;
>  
>  		kaddr = page_addr;
>  		de = (ext2_dirent *)kaddr;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
