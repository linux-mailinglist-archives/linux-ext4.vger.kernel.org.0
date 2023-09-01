Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF4978FF4C
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344299AbjIAOgf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Sep 2023 10:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243538AbjIAOge (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Sep 2023 10:36:34 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED3DA4;
        Fri,  1 Sep 2023 07:36:31 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34ca1bcb48fso6428365ab.2;
        Fri, 01 Sep 2023 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693578990; x=1694183790; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHXbbveoHZR0tcPVV1tc/c3Ir5HWQidOEcLG9DliTh4=;
        b=EZVxumen8Qd0dhAoYIm2QtdU/yCBVENIWbRYjw08ttFBWrKmQtwTNx+QqFArMCghQI
         7pMor1OHQhrIRCQJUlywndatKF0gkpvVtIsvef6kgDd708hTIWq8IgesaSHXvxM7Plgv
         zeE2ahZnOFVLt7IM3YSzNZkEDB7Wbn2JOy7b7cbg+m1uZs0qeQqEZ2GucBw9+4BcNAWV
         DUdqWQDNY/6joaK/mtwox9dvVwmH5Bqs8DgC4+cnATrsl96IMedrhM92oBcFLUwP7uDv
         tuI8A8ZtsXWA1DCPqd+fCMVLY34H21hc5oF+XgoArDFvUrqgZKzoi1oZD0VsOnh94JdU
         OgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693578990; x=1694183790;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KHXbbveoHZR0tcPVV1tc/c3Ir5HWQidOEcLG9DliTh4=;
        b=TBkQgNEMajTKlOd8Gx6R6HoghcTnMdaZRRBoIbRNO74htB4KIPg7TgzzMCGQ2MHJyO
         zPZcKdRcqSakR/9Qq7ujcok0V8Zr/qc1eAtC2Z/BvwtBE/2lzJjhjSsoRuL9QMYECV4o
         AraX0Ic6t5FYyobZCOl5eUeY2ZHlaI5BaZfPgg0Fqy9HMUEd/+7tSZ+zKwBgTnY4Ohw7
         rZcsIy6aUgMXXSXyA3Q/bK6YGb0QT7K4SbTYKjvfRHhsyE2fKfrFVlsoa6Bpts7iJJwN
         oWUJbXfzS7DMDG86CyV07czZ2QrNEHyj9Nw80yz9sj+qaUN1ximJasRDh3QaHFtZdX0f
         Bpvg==
X-Gm-Message-State: AOJu0YyESa7gcXWbZTd1j0VD3l7R/WRz2ege+bzRUxURl1fw/Fpt+ZJv
        XGHQFrbEESSO1JkERJOnRG+m5DEjEXQ=
X-Google-Smtp-Source: AGHT+IHnkcG7PjX/zv/zi4t6XQDUb3xhZFUuyC/yhIk2Tk0L/pu6HAMCBrFkEPNRxUOGvryYlk43YA==
X-Received: by 2002:a05:6e02:1071:b0:34c:b943:d170 with SMTP id q17-20020a056e02107100b0034cb943d170mr2781226ilj.18.1693578990210;
        Fri, 01 Sep 2023 07:36:30 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id i11-20020a63b30b000000b005579f12a238sm2611803pgf.86.2023.09.01.07.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 07:36:29 -0700 (PDT)
Date:   Fri, 01 Sep 2023 20:06:22 +0530
Message-Id: <87msy6kljt.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/11] ext4: run mballoc test with different layouts setting
In-Reply-To: <20230826155028.4019470-12-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> Use KUNIT_CASE_PARAM to run mbalaloc test with different layouts setting.
                              ^^^ mballoc
small nit below
  
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc-test.c | 52 ++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 14 deletions(-)
>
> diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
> index d643c56ac003..af48a39c8ba2 100644
> --- a/fs/ext4/mballoc-test.c
> +++ b/fs/ext4/mballoc-test.c
> @@ -196,21 +196,11 @@ static int ext4_mb_mark_context_stub(struct ext4_mark_context *mc,
>  	return 0;
>  }
>  
> -#define TEST_BLOCKSIZE_BITS 10
> -#define TEST_CLUSTER_BITS 3
> -#define TEST_BLOCKS_PER_GROUP 8192
> -#define TEST_GROUP_COUNT 4
> -#define TEST_DESC_SIZE 64
>  #define TEST_GOAL_GROUP 1
>  static int mbt_kunit_init(struct kunit *test)
>  {
> -	struct mbt_ext4_block_layout layout = {
> -		.blocksize_bits = TEST_BLOCKSIZE_BITS,
> -		.cluster_bits = TEST_CLUSTER_BITS,
> -		.blocks_per_group = TEST_BLOCKS_PER_GROUP,
> -		.group_count = TEST_GROUP_COUNT,
> -		.desc_size = TEST_DESC_SIZE,
> -	};
> +	struct mbt_ext4_block_layout *layout =
> +		(struct mbt_ext4_block_layout *)(test->param_value);
>  	struct super_block *sb;
>  	int ret;
>  
> @@ -218,7 +208,7 @@ static int mbt_kunit_init(struct kunit *test)
>  	if (sb == NULL)
>  		return -ENOMEM;
>  
> -	mbt_init_sb_layout(sb, &layout);
> +	mbt_init_sb_layout(sb, layout);
>  
>  	ret = mbt_ctx_init(sb);
>  	if (ret != 0) {
> @@ -304,9 +294,43 @@ static void test_new_blocks_simple(struct kunit *test)
>  		"unexpectedly get block when no block is available");
>  }
>  
> +static const struct mbt_ext4_block_layout mbt_test_layouts[] = {
> +	{
> +		.blocksize_bits = 10,
> +		.cluster_bits = 3,
> +		.blocks_per_group = 8192,
> +		.group_count = 4,
> +		.desc_size = 64,
> +	},
> +	{
> +		.blocksize_bits = 12,
> +		.cluster_bits = 3,
> +		.blocks_per_group = 8192,
> +		.group_count = 4,
> +		.desc_size = 64,
> +	},
> +	{
> +		.blocksize_bits = 18,

64k blocksize is more common due to platforms with 64k pagesize like
Power and sometimes arm64. I would rather make it 16 here.

I tested it on Power - 

[    2.546687][    T1] KTAP version 1
[    2.547123][    T1] 1..2
[    2.547447][    T1]     KTAP version 1
[    2.547927][    T1]     # Subtest: ext4_mballoc_test
[    2.548562][    T1]     1..1
[    2.548933][    T1]         KTAP version 1
[    2.549457][    T1]         # Subtest: test_new_blocks_simple
[    2.549550][  T108] kunit_try_catch (108) used greatest stack depth: 14512 bytes left
[    2.549644][    T1]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[    2.552780][  T110] kunit_try_catch (110) used greatest stack depth: 14464 bytes left
[    2.552882][    T1]         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[    2.555909][    T1]         ok 3 block_bits=18 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[    2.557184][    T1]     # test_new_blocks_simple: pass:3 fail:0 skip:0 total:3
[    2.557186][    T1]     ok 1 test_new_blocks_simple
[    2.558083][    T1] # Totals: pass:3 fail:0 skip:0 total:3
[    2.558688][    T1] ok 1 ext4_mballoc_test

Looks good to me. Feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
