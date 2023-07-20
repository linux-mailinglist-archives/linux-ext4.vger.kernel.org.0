Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB48775B7EB
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jul 2023 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGTTY5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGTTYy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 15:24:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3308619BE;
        Thu, 20 Jul 2023 12:24:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-668704a5b5bso1025199b3a.0;
        Thu, 20 Jul 2023 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689881092; x=1690485892;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tW0BPhfnDupQJ71k/7s2nYMMhpjAsaSV8NHjgz9K0G0=;
        b=oud8Z6KFd3sIDoiUeH8jycViQb2qOVuST9m0MxjELfWUvG7zVM6YDiy6t12N1P6y0k
         Q5KB/ko+m5zIVIbwB9lerGUI5qbB1T/FEJgk2vQaAiW6I12QvtJXk/TLZJewY2Md+R7m
         4H+Zz1qANikwmwldLYw+NyJWEVWsqE8XiyDUB27h/yOZ5zgeppE4tkrRz1h0wvSakyK/
         e89hkycr28GRzIE/sdLmZ1BNlHg5K150yLM7v3MLd9i197BJGa5Wq4UMwfaRkovbENGz
         g3ETLAHF2yByOlkSECx/C1idjim+sYcUlKBH7QLcJBtEJbSyiMh0YLDneIODzsb8q+Jf
         TF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881092; x=1690485892;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tW0BPhfnDupQJ71k/7s2nYMMhpjAsaSV8NHjgz9K0G0=;
        b=C5N00NrAUx48pV2yBcvsoC2kLk8gX+XO5TCITwEPgx5O3hIjqC4ptmt3qjX8xdfL2/
         lHBQeLJfnuU2LJvQt/fVebXE2fC7th4A5M47ROQ1N5rsr9PXpm+0Y/dGtOQDMJQRx3Om
         A6HlDx9Q4OVRf9madtXt79/HGHMFxD9ectz/sAlXD9UbCfMZM6v1I8VdFff14jM8cG5r
         wtTqx4CSbutcTtjoYy/BqAO900tQXOKvZzZtipK+MPY/hhPW+RWW494YAU7hnRz5aQLK
         eGXcyheqxVWrfPZlRLoml1lkGbPn4dEGbSavqFKMbfANaovMkt1TJJsOrzOWHcdIzblm
         WWfg==
X-Gm-Message-State: ABy/qLamAH9N0bGtdQZ3BYWH1dPekRXn+mFfI1P8KhM2T2jyejbbI7cH
        jj2Wl5YczhR0FTZnSLKioE4=
X-Google-Smtp-Source: APBJJlGhxxtRzY8qMQyfcbnssyV1+DhegQoadfOTruaONwrs57XtlenILhs2EIaORgnJjgUryslV1w==
X-Received: by 2002:a05:6a00:1827:b0:684:aa3e:7bf3 with SMTP id y39-20020a056a00182700b00684aa3e7bf3mr25039066pfa.31.1689881092662;
        Thu, 20 Jul 2023 12:24:52 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id g14-20020a62e30e000000b006579b062d5dsm1570915pfh.21.2023.07.20.12.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:24:51 -0700 (PDT)
Date:   Fri, 21 Jul 2023 00:54:47 +0530
Message-Id: <87351io074.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH 3/4] ext4: avoid overlapping preallocations due to overflow
In-Reply-To: <20230718131052.283350-4-libaokun1@huawei.com>
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

> Let's say we want to allocate 2 blocks starting from 4294966386, after
> predicting the file size, start is aligned to 4294965248, len is changed
> to 2048, then end = start + size = 0x100000000. Since end is of
> type ext4_lblk_t, i.e. uint, end is truncated to 0.
>
> This causes (pa->pa_lstart >= end) to always hold when checking if the
> current extent to be allocated crosses already preallocated blocks, so the
> resulting ac_g_ex may cross already preallocated blocks.
>
> Hence we convert the end type to loff_t and use pa_end() to avoid overflow.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks again for spotting. Looks good to me (with pa_end() dropped).

-ritesh


> ---
>  fs/ext4/mballoc.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 2090e5e7ba58..77d47af525d9 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4222,12 +4222,13 @@ ext4_mb_pa_rb_next_iter(ext4_lblk_t new_start, ext4_lblk_t cur_start, struct rb_
>  
>  static inline void
>  ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
> -			  ext4_lblk_t start, ext4_lblk_t end)
> +			  ext4_lblk_t start, loff_t end)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_prealloc_space *tmp_pa;
> -	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> +	ext4_lblk_t tmp_pa_start;
> +	loff_t tmp_pa_end;
>  	struct rb_node *iter;
>  
>  	read_lock(&ei->i_prealloc_lock);
> @@ -4236,7 +4237,7 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
>  		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
>  				  pa_node.inode_node);
>  		tmp_pa_start = tmp_pa->pa_lstart;
> -		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +		tmp_pa_end = pa_end(sbi, tmp_pa);
>  
>  		spin_lock(&tmp_pa->pa_lock);
>  		if (tmp_pa->pa_deleted == 0)
> @@ -4258,14 +4259,14 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
>   */
>  static inline void
>  ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
> -			  ext4_lblk_t *start, ext4_lblk_t *end)
> +			  ext4_lblk_t *start, loff_t *end)
>  {
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_prealloc_space *tmp_pa = NULL, *left_pa = NULL, *right_pa = NULL;
>  	struct rb_node *iter;
> -	ext4_lblk_t new_start, new_end;
> -	ext4_lblk_t tmp_pa_start, tmp_pa_end, left_pa_end = -1, right_pa_start = -1;
> +	ext4_lblk_t new_start, tmp_pa_start, right_pa_start = -1;
> +	loff_t new_end, tmp_pa_end, left_pa_end = -1;
>  
>  	new_start = *start;
>  	new_end = *end;
> @@ -4284,7 +4285,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
>  				  pa_node.inode_node);
>  		tmp_pa_start = tmp_pa->pa_lstart;
> -		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +		tmp_pa_end = pa_end(sbi, tmp_pa);
>  
>  		/* PA must not overlap original request */
>  		spin_lock(&tmp_pa->pa_lock);
> @@ -4364,8 +4365,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  	}
>  
>  	if (left_pa) {
> -		left_pa_end =
> -			left_pa->pa_lstart + EXT4_C2B(sbi, left_pa->pa_len);
> +		left_pa_end = pa_end(sbi, left_pa);
>  		BUG_ON(left_pa_end > ac->ac_o_ex.fe_logical);
>  	}
>  
> @@ -4404,8 +4404,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_super_block *es = sbi->s_es;
>  	int bsbits, max;
> -	ext4_lblk_t end;
> -	loff_t size, start_off;
> +	loff_t size, start_off, end;
>  	loff_t orig_size __maybe_unused;
>  	ext4_lblk_t start;
>  
> -- 
> 2.31.1
