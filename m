Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6B7689FA
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jul 2023 04:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGaC0k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Jul 2023 22:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaC0j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Jul 2023 22:26:39 -0400
Received: from out-96.mta1.migadu.com (out-96.mta1.migadu.com [IPv6:2001:41d0:203:375::60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD337E50
        for <linux-ext4@vger.kernel.org>; Sun, 30 Jul 2023 19:26:37 -0700 (PDT)
Message-ID: <810f6c3a-89a1-837f-fd79-46f1fd32bbe7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690770394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTzUFJc6W4ODCkBOdsGkHTqDeUIKhkOKulF83oZaLHo=;
        b=v7S+NouvGEcpurG2w4gvDqRs74vRLDqcksZnMzcAZsBwhXufdmcy6eiW5SZ6kziyAjx7XO
        4i+0gN+q2zLVWF9v1Cljlp76lbNtTo5VdE7jQKu5noX4EEXwjdHvE4twnZFoKvcgi3k/RO
        kPPv8XRPpdYUeS+b1WtfTaHxCqcn4ZA=
Date:   Mon, 31 Jul 2023 10:26:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3] ext4: improve trim efficiency
To:     Fengnan Chang <changfengnan@bytedance.com>,
        adilger.kernel@dilger.ca, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <20230725121848.26865-1-changfengnan@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20230725121848.26865-1-changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 7/25/23 20:18, Fengnan Chang wrote:
> In commit a015434480dc("ext4: send parallel discards on commit
> completions"), issue all discard commands in parallel make all
> bios could merged into one request, so lowlevel drive can issue
> multi segments in one time which is more efficiency, but commit
> 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> seems broke this way, let's fix it.
> In my test:
> 1. create 10 normal files, each file size is 10G.
> 2. deallocate file, punch a 16k holes every 32k.
> 3. trim all fs.
>
> the time of fstrim fs reduce from 6.7s to 1.3s.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202307171455.ee68ef8b-oliver.sang@intel.com
> Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> ---
>   fs/ext4/mballoc.c | 49 +++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a2475b8c9fb5..b75ca1df0d30 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6790,7 +6790,8 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
>    * be called with under the group lock.
>    */
>   static int ext4_trim_extent(struct super_block *sb,
> -		int start, int count, struct ext4_buddy *e4b)
> +		int start, int count, bool noalloc, struct ext4_buddy *e4b,
> +		struct bio **biop, struct ext4_free_data **entryp)
>   __releases(bitlock)
>   __acquires(bitlock)
>   {
> @@ -6812,9 +6813,16 @@ __acquires(bitlock)
>   	 */
>   	mb_mark_used(e4b, &ex);
>   	ext4_unlock_group(sb, group);
> -	ret = ext4_issue_discard(sb, group, start, count, NULL);
> +	ret = ext4_issue_discard(sb, group, start, count, biop);
> +	if (!ret && !noalloc) {
> +		struct ext4_free_data *entry = kmem_cache_alloc(ext4_free_data_cachep,
> +				GFP_NOFS|__GFP_NOFAIL);
> +		entry->efd_start_cluster = start;
> +		entry->efd_count = count;
> +		*entryp  = entry;
> +	}
> +
>   	ext4_lock_group(sb, group);
> -	mb_free_blocks(NULL, e4b, start, ex.fe_len);
>   	return ret;
>   }
>   
> @@ -6824,26 +6832,40 @@ static int ext4_try_to_trim_range(struct super_block *sb,
>   __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
>   __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>   {
> -	ext4_grpblk_t next, count, free_count;
> +	ext4_grpblk_t next, count, free_count, bak;
>   	void *bitmap;
> +	struct ext4_free_data *entry = NULL, *fd, *nfd;
> +	struct list_head discard_data_list;
> +	struct bio *discard_bio = NULL;
> +	struct blk_plug plug;
> +	bool noalloc = false;
> +
> +	INIT_LIST_HEAD(&discard_data_list);
>   
>   	bitmap = e4b->bd_bitmap;
>   	start = (e4b->bd_info->bb_first_free > start) ?
>   		e4b->bd_info->bb_first_free : start;
>   	count = 0;
>   	free_count = 0;
> +	bak = start;
>   
> +	blk_start_plug(&plug);
>   	while (start <= max) {
>   		start = mb_find_next_zero_bit(bitmap, max + 1, start);
>   		if (start > max)
>   			break;
>   		next = mb_find_next_bit(bitmap, max + 1, start);
> +		/* when only one segment, there is no need to alloc entry */
> +		noalloc = (free_count == 0) && (next >= max);
>   
>   		if ((next - start) >= minblocks) {
> -			int ret = ext4_trim_extent(sb, start, next - start, e4b);
> +			int ret = ext4_trim_extent(sb, start, next - start, noalloc, e4b,
> +							&discard_bio, &entry);
>   
> -			if (ret && ret != -EOPNOTSUPP)
> +			if (ret < 0)
>   				break;
> +			if (entry)
> +				list_add_tail(&entry->efd_list, &discard_data_list);
>   			count += next - start;
>   		}
>   		free_count += next - start;
> @@ -6863,6 +6885,21 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>   		if ((e4b->bd_info->bb_free - free_count) < minblocks)
>   			break;
>   	}
> +	if (discard_bio) {
> +		ext4_unlock_group(sb, e4b->bd_group);
> +		submit_bio_wait(discard_bio);
> +		bio_put(discard_bio);
> +		ext4_lock_group(sb, e4b->bd_group);
> +	}
> +	blk_finish_plug(&plug);
> +
> +	if (noalloc)
> +		mb_free_blocks(NULL, e4b, bak, free_count);
> +
> +	list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list) {
> +		mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->efd_count);
> +		kmem_cache_free(ext4_free_data_cachep, fd);
> +	}
>   
>   	return count;
>   }

With the new version, I don't see big difference from my test.

Thanks,
Guoqing
