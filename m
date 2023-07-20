Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CAF75AEAA
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jul 2023 14:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGTMpB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 08:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGTMpA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 08:45:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F0B2135;
        Thu, 20 Jul 2023 05:44:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8b318c5a7so5287605ad.3;
        Thu, 20 Jul 2023 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689857099; x=1690461899;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tTrmxWcTD08nNFUROvbx6pQF30kzsq9RlWmPzoK93Ng=;
        b=JtkZHqD0hre7Cag7gAu/8k8hgfgyWjbVm0BdafyETEKz89ZNaCOQx6wdWFNRIhMEYq
         M6YufK1clFYno509HLSQ2sMD+kCDEGkRCZ+r0+w3Wnx4DaMSMK4AYk5JfuvO/ZfmnCSh
         y7os7j8R3fPTognkzYrtMTaDo3gzml6tccZ40Y4Yeoz4jV63fccTx5CAzeI1le1SXu7C
         mPVQQfk0cJEq4/P2NzDDwLqcNlISwVpQSfzV0wfvN/kcgZrPPAmf3sQIJEStu2pGR4fp
         4gThIBR0nkQ+n4MtElr2XKuhLHZ225YhtmNChMQyeUMtjmdvl/o/jobiIW894dwWAj9J
         mcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689857099; x=1690461899;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tTrmxWcTD08nNFUROvbx6pQF30kzsq9RlWmPzoK93Ng=;
        b=SvBYGr0pESMQic4ZFEFyMuALSRH0Tq4cdevolHoYIRFr/OV/JkT0O982ZZz9ny17Jr
         qg+awWhXf+yamIOCceNkbPXEhAfEWjqaY9x43LujPYA+dGGRkW5TWycgHShr2KSGpIjq
         Vd5Bl+UAtXtaL97FS61GxiRQfUIzJ/Y82lkfGXzY5qRjHdUXSfMrsixbeSIcQenam4df
         nph1GbE51fj/JVa44FA6ph483khgLVHblWLc02j3E34DdoC1CPqmFPtl9VyFHGIrM34r
         A+aXs2lhQs4EVQ6k61pMAHlcDuwIxPhrQEvfo+b/CsW6RlvY9ioFJN6L1gkWDnFtmgAt
         FvzA==
X-Gm-Message-State: ABy/qLabPcTh6cYmlb2bOPbBifi+GWOXcmEgGxTc7cYD2vH05PKecYre
        Nk9XgI/qhwCqnvC0tSXMVDo=
X-Google-Smtp-Source: APBJJlGDlYXcAmEmJZtvFfNg7DRXGzIritakBelFQZYwl/O8ijYFOyyFB15uqh0R1igEiETrjxJiXQ==
X-Received: by 2002:a17:902:d38c:b0:1b8:66f6:87a3 with SMTP id e12-20020a170902d38c00b001b866f687a3mr19520605pld.52.1689857099258;
        Thu, 20 Jul 2023 05:44:59 -0700 (PDT)
Received: from dw-tp ([129.41.58.5])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902d70300b001b87bedcc6fsm1269778ply.93.2023.07.20.05.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 05:44:58 -0700 (PDT)
Date:   Thu, 20 Jul 2023 18:14:52 +0530
Message-Id: <87edl2oipn.fsf@doe.com>
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

Nice spotting.

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


Could you please also add it into xfstests?
I think it's a nice test which can check the boundary conditions for
start and end of data types used in mballoc. I think it should even work
if you don't do fsstress but instead just fallocate some remaining space
in filesystem, so that when you open and try to write it to 0th offset,
if automatically hits this error in ext4_mb_new_inode_pa().

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
> @@ -5117,8 +5116,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  
>  		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>  		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
> -		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
> -				      EXT4_C2B(sbi, ac->ac_orig_goal_len)));

Ok so the right hand becomes 0 (because then end can go upto 1<<32 which
will be 0 for unsigned int). And the left (new_bex_end) might be
negative due to some operations above as I see it. 
And comparing an int with unsigned int, it will promote new_bex_end to
unsigned int which will make it's value too large and will hit the
bug_on. 

I would like to carefully review all such paths. I will soon review and
get back.


> +		BUG_ON(new_bex_end >
> +			fex_end(sbi, &ac->ac_g_ex, &ac->ac_orig_goal_len));

I am not sure whether using fex_end or pa_end is any helpful. 
I think we can just typecast if needed and keep it simple rather
than adding helpers functions for addition operation.
(because of the fact that fex_end() can take a third parameter which
sometimes you pass as NULL. Hence it doesn't look clean, IMO)

>  	}
>  
>  	pa->pa_lstart = ac->ac_b_ex.fe_logical;
> -- 
> 2.31.1

-ritesh
