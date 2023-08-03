Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AACB76EB55
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 15:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjHCN6t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 09:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbjHCN6n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 09:58:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85709171D;
        Thu,  3 Aug 2023 06:58:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DE0C1F45F;
        Thu,  3 Aug 2023 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691071121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d01RP3i18IXF4FZKDRE94E/YmeTO0k9D4PcJR2I6SjE=;
        b=VZo5dtpydQlEgjpW20dMabiQnevXdUVmYE8mamo6ele0aTPxB06V0pBg3sNu/2dKYpPns4
        zWE6iiwC7F7aB4TB48CqWSF7B5mec+eRd5cPFlruNWwAS1ReXdJnF0qlmJMQK8KQuPUT+k
        TutsJcDysx8OfH6K4lrBrIclBK86gGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691071121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d01RP3i18IXF4FZKDRE94E/YmeTO0k9D4PcJR2I6SjE=;
        b=Im4ls460HFAZsMMI1rsDEecV9WCM+cLxG0PVw6DRsPfeVn/4eqF+E6m7lA5eN9X5zaVkNM
        nQw8GucY2BShD1Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19B641333C;
        Thu,  3 Aug 2023 13:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fv1CBpGyy2RKAQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 13:58:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ACBD9A076B; Thu,  3 Aug 2023 15:58:40 +0200 (CEST)
Date:   Thu, 3 Aug 2023 15:58:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        stable@kernel.org
Subject: Re: [PATCH v2 2/3] ext4: fix BUG in ext4_mb_new_inode_pa() due to
 overflow
Message-ID: <20230803135840.hmz2ibnwvodqluk5@quack3>
References: <20230724121059.11834-1-libaokun1@huawei.com>
 <20230724121059.11834-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724121059.11834-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-07-23 20:10:58, Baokun Li wrote:
> When we calculate the end position of ext4_free_extent, this position may
> be exactly where ext4_lblk_t (i.e. uint) overflows. For example, if
> ac_g_ex.fe_logical is 4294965248 and ac_orig_goal_len is 2048, then the
> computed end is 0x100000000, which is 0. If ac->ac_o_ex.fe_logical is not
> the first case of adjusting the best extent, that is, new_bex_end > 0, the
> following BUG_ON will be triggered:
> 
> =========================================================
> kernel BUG at fs/ext4/mballoc.c:5116!
> invalid opcode: 0000 [#1] PREEMPT SMP PTI
> CPU: 3 PID: 673 Comm: xfs_io Tainted: G E 6.5.0-rc1+ #279
> RIP: 0010:ext4_mb_new_inode_pa+0xc5/0x430
> Call Trace:
>  <TASK>
>  ext4_mb_use_best_found+0x203/0x2f0
>  ext4_mb_try_best_found+0x163/0x240
>  ext4_mb_regular_allocator+0x158/0x1550
>  ext4_mb_new_blocks+0x86a/0xe10
>  ext4_ext_map_blocks+0xb0c/0x13a0
>  ext4_map_blocks+0x2cd/0x8f0
>  ext4_iomap_begin+0x27b/0x400
>  iomap_iter+0x222/0x3d0
>  __iomap_dio_rw+0x243/0xcb0
>  iomap_dio_rw+0x16/0x80
> =========================================================
> 
> A simple reproducer demonstrating the problem:
> 
> 	mkfs.ext4 -F /dev/sda -b 4096 100M
> 	mount /dev/sda /tmp/test
> 	fallocate -l1M /tmp/test/tmp
> 	fallocate -l10M /tmp/test/file
> 	fallocate -i -o 1M -l16777203M /tmp/test/file
> 	fsstress -d /tmp/test -l 0 -n 100000 -p 8 &
> 	sleep 10 && killall -9 fsstress
> 	rm -f /tmp/test/tmp
> 	xfs_io -c "open -ad /tmp/test/file" -c "pwrite -S 0xff 0 8192"
> 
> We simply refactor the logic for adjusting the best extent by adding
> a temporary ext4_free_extent ex and use extent_logical_end() to avoid
> overflow, which also simplifies the code.
> 
> Cc: stable@kernel.org # 6.4
> Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4cb13b3e41b3..86bce870dc5a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5177,8 +5177,11 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  	pa = ac->ac_pa;
>  
>  	if (ac->ac_b_ex.fe_len < ac->ac_orig_goal_len) {
> -		int new_bex_start;
> -		int new_bex_end;
> +		struct ext4_free_extent ex = {
> +			.fe_logical = ac->ac_g_ex.fe_logical,
> +			.fe_len = ac->ac_orig_goal_len,
> +		};
> +		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
>  
>  		/* we can't allocate as much as normalizer wants.
>  		 * so, found space must get proper lstart
> @@ -5197,29 +5200,23 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  		 *    still cover original start
>  		 * 3. Else, keep the best ex at start of original request.
>  		 */
> -		new_bex_end = ac->ac_g_ex.fe_logical +
> -			EXT4_C2B(sbi, ac->ac_orig_goal_len);
> -		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> -		if (ac->ac_o_ex.fe_logical >= new_bex_start)
> -			goto adjust_bex;
> +		ex.fe_len = ac->ac_b_ex.fe_len;
>  
> -		new_bex_start = ac->ac_g_ex.fe_logical;
> -		new_bex_end =
> -			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> -		if (ac->ac_o_ex.fe_logical < new_bex_end)
> +		ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
> +		if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
>  			goto adjust_bex;
>  
> -		new_bex_start = ac->ac_o_ex.fe_logical;
> -		new_bex_end =
> -			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> +		ex.fe_logical = ac->ac_g_ex.fe_logical;
> +		if (ac->ac_o_ex.fe_logical < extent_logical_end(sbi, &ex))
> +			goto adjust_bex;
>  
> +		ex.fe_logical = ac->ac_o_ex.fe_logical;
>  adjust_bex:
> -		ac->ac_b_ex.fe_logical = new_bex_start;
> +		ac->ac_b_ex.fe_logical = ex.fe_logical;
>  
>  		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>  		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
> -		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
> -				      EXT4_C2B(sbi, ac->ac_orig_goal_len)));
> +		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
>  	}
>  
>  	pa->pa_lstart = ac->ac_b_ex.fe_logical;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
