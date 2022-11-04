Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923D6619C4F
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Nov 2022 16:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiKDP63 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Nov 2022 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiKDP6V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Nov 2022 11:58:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27FA317C9;
        Fri,  4 Nov 2022 08:58:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B08AB82E72;
        Fri,  4 Nov 2022 15:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44012C433D6;
        Fri,  4 Nov 2022 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667577497;
        bh=fw/r56JRaG6g0O3frwp/sUklhs/1zLiMmtYN/vV8sQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9PqOKlvgVhVNobh5w4MrSBW7mb0Qbi0QJ9gw0m/3SH1X4aFviSrE/AE/V66V/Z6s
         g+c1aU3WDlXt74xGL73byXry8LzeAuzwdbyaxDY6aBEx8dnbrFyvJdQFVRoIhUMDmw
         HB5EO7ptlcisaPi2cbk4h1hBhYgRLoaGsStjneDcgKxdZc8+FhTLyL3019bpTEr0Is
         +Pwo5sEfh+CeoL4RobT9PzA7bY6D7YUtca7g2sODjWNx3Obt88eKTabUWJSZy13GRD
         l+XU+fpFbgCFNPFMJUaaPUcWadIQv9KrhlcCle4FsRCR1UlBfKVW+hmilHE7sVXOlr
         oZ4a9x+XA4wug==
Date:   Fri, 4 Nov 2022 08:58:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix bad checksum after online resize
Message-ID: <Y2U2mNnUuOsbh5QG@magnolia>
References: <20221104083553.581928-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104083553.581928-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 04, 2022 at 04:35:53PM +0800, Baokun Li wrote:
> When online resizing is performed twice consecutively, the error message
> "Superblock checksum does not match superblock" is displayed for the
> second time. Here's the reproducer:
> 
> 	mkfs.ext4 -F /dev/sdb 100M
> 	mount /dev/sdb /tmp/test
> 	resize2fs /dev/sdb 5G
> 	resize2fs /dev/sdb 6G
> 
> To solve this issue, we moved the update of the checksum after the
> es->s_overhead_clusters is updated.
> 
> Fixes: 026d0d27c488 ("ext4: reduce computation of overhead during resize")
> Fixes: de394a86658f ("ext4: update s_overhead_clusters in the superblock during an on-line resize")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Yep, that looks correct.  Sort of a pity that the checksum computation
isn't quite as automatic as it is in other filesystems, but that's my
fault... :/

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/ext4/resize.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 6dfe9ccae0c5..32fbfc173571 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1471,8 +1471,6 @@ static void ext4_update_super(struct super_block *sb,
>  	 * active. */
>  	ext4_r_blocks_count_set(es, ext4_r_blocks_count(es) +
>  				reserved_blocks);
> -	ext4_superblock_csum_set(sb);
> -	unlock_buffer(sbi->s_sbh);
>  
>  	/* Update the free space counts */
>  	percpu_counter_add(&sbi->s_freeclusters_counter,
> @@ -1508,6 +1506,8 @@ static void ext4_update_super(struct super_block *sb,
>  		ext4_calculate_overhead(sb);
>  	es->s_overhead_clusters = cpu_to_le32(sbi->s_overhead);
>  
> +	ext4_superblock_csum_set(sb);
> +	unlock_buffer(sbi->s_sbh);
>  	if (test_opt(sb, DEBUG))
>  		printk(KERN_DEBUG "EXT4-fs: added group %u:"
>  		       "%llu blocks(%llu free %llu reserved)\n", flex_gd->count,
> -- 
> 2.31.1
> 
