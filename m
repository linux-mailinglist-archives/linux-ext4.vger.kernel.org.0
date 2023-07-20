Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F085575B772
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jul 2023 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjGTTHv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 15:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjGTTHs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 15:07:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D701BC1;
        Thu, 20 Jul 2023 12:07:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b89e10d356so7779315ad.3;
        Thu, 20 Jul 2023 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689880061; x=1690484861;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YYggVKsa3FoABe/1TlxkOR2On5ZBxV16BqCpVVc2v9U=;
        b=VnZXmEJLnJ8ddybQfov0MqmI37XUQBlq1IvNrbETVUVj5th0VBsMfIlyQOdAkH9jhY
         NPhDopgGmDcH/oYJdoJQxBGy/KanXFJHCh+a5qEp7xsrS92ycznImQfqPUxS4h+bxnEX
         eOz17sxopCTYnJOa9HWLHumV7iWN5s1J0U4WC8Gt6OoTR8gY9083usms7+gebBTZiEXE
         e8CqmlDtXZLSwlF28X4TYoDFqQiB97G0ag1+i3kC0BQ4eJVrVQH8P6ohwCt80a51zdSk
         EwzjEl4ymmuo4+zI+2oM0vdpOvNbNH5oLITH9QR8Tm5QWA8wM6LsGazT2m/jwuYhY+VX
         TMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880061; x=1690484861;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYggVKsa3FoABe/1TlxkOR2On5ZBxV16BqCpVVc2v9U=;
        b=LhEiyjnv2CowRdhhK7YQDJHLT1NgXxrLY6/AMOCWNe0iADZpy7D6qkZSWbLUwfi1mw
         aDkv1nvQxjiEEx5Wa/kf7dA+E2u0Tc3KanE8mWrynrxVzF+8opv7eJE/Kl6w38lStFEh
         e9SiNfCR3nVPyUWf0mK4MXIEkJ1NkApaZwNg8eucib5U9Iiukmk5azCRVNGXiz78n84z
         wRFlSBuHNpKfVGoUDmsTIf0wQF6T/T5WCA5uMaMzxW04lVQVlIjoPeNt3miXtbq780nP
         wSghxMqM7W03B82NLUwOWgnTd71Gh0M/Yq/BQq2wkhG3PZkR0+Q+hcv7PwXg9AtaaBl/
         CsYg==
X-Gm-Message-State: ABy/qLZQ2dIVUczR9m7j9SpUP4mUcY9OUdoj+jXnFtfA5q9jy7Rm6Mc/
        oDGKTUZOPlDcL16nZNNe/YQ=
X-Google-Smtp-Source: APBJJlFgWzLyfILBrzWo+oPL1fsGel4w7Sd+bQ8rDXbSnpZvmA5sublTJwAM+1hqCQ0m7yMRRMf4Iw==
X-Received: by 2002:a17:903:1c4:b0:1b8:3786:3344 with SMTP id e4-20020a17090301c400b001b837863344mr257729plh.49.1689880061250;
        Thu, 20 Jul 2023 12:07:41 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b001bb3dac1577sm1768024plj.95.2023.07.20.12.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:07:40 -0700 (PDT)
Date:   Fri, 21 Jul 2023 00:37:35 +0530
Message-Id: <878rbao0zs.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH 2/4] ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow
In-Reply-To: <20230718131052.283350-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Baokun Li <libaokun1@huawei.com> writes:

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
> We declare new_bex_start and new_bex_end as correct types and use fex_end()
> to avoid the problems caused by the ext4_lblk_t overflow above.
>
> Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index eb7f5d35ef96..2090e5e7ba58 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5076,8 +5076,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  	pa = ac->ac_pa;
>  
>  	if (ac->ac_b_ex.fe_len < ac->ac_orig_goal_len) {
> -		int new_bex_start;
> -		int new_bex_end;
> +		ext4_lblk_t new_bex_start;
> +		loff_t new_bex_end;
>  
>  		/* we can't allocate as much as normalizer wants.
>  		 * so, found space must get proper lstart
> @@ -5096,8 +5096,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  		 *    still cover original start
>  		 * 3. Else, keep the best ex at start of original request.
>  		 */
> -		new_bex_end = ac->ac_g_ex.fe_logical +
> -			EXT4_C2B(sbi, ac->ac_orig_goal_len);
> +		new_bex_end = fex_end(sbi, &ac->ac_g_ex, &ac->ac_orig_goal_len);
>  		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
>  		if (ac->ac_o_ex.fe_logical >= new_bex_start)
>  			goto adjust_bex;

		new_bex_end = ac->ac_g_ex.fe_logical +
			EXT4_C2B(sbi, ac->ac_orig_goal_len);
		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
		if (ac->ac_o_ex.fe_logical >= new_bex_start)
			goto adjust_bex;

		new_bex_start = ac->ac_g_ex.fe_logical;
		new_bex_end =
			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
		if (ac->ac_o_ex.fe_logical < new_bex_end)
			goto adjust_bex;

		new_bex_start = ac->ac_o_ex.fe_logical;
		new_bex_end =
			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);

I think it will be safer if we typecast all above new_bex_end
calculations. I understand that it might never happen here that
fe_logical + best found extent length will make it overflow.
Simply because we only enter here when ac_b_ex.fe_len <
ac_orig_goal_len. But I think if we change any logic tomorrow or
refactor any part of code, it will be much safer if we simply keep the
typecast in place so that we avoid any future tripping caused by
arithmatic overflow here.

Also I am not finding fex_end() or pa_end() helpers very intuitive way
of doing it. I feel typecasting in place is much simpler and reads better.

-ritesh

> @@ -5117,8 +5116,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  
>  		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>  		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
> -		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
> -				      EXT4_C2B(sbi, ac->ac_orig_goal_len)));
> +		BUG_ON(new_bex_end >
> +			fex_end(sbi, &ac->ac_g_ex, &ac->ac_orig_goal_len));
>  	}
>  
>  	pa->pa_lstart = ac->ac_b_ex.fe_logical;
> -- 
> 2.31.1
