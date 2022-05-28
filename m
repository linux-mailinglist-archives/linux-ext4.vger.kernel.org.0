Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A7E536D6F
	for <lists+linux-ext4@lfdr.de>; Sat, 28 May 2022 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiE1PM0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 May 2022 11:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbiE1PM0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 May 2022 11:12:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167B315A3D;
        Sat, 28 May 2022 08:12:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q4so6599404plr.11;
        Sat, 28 May 2022 08:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B5mFiaBmbFAgvSLD1k8I0pYH8BNutIgWRHpbfdHvERY=;
        b=IV9oPszlelkJ4w0dwGDjTehwjb5u5dUCP2DFe/SbM8ztgHrmoPdlfHk/pNTQQG2bu+
         e+t/am9hrZjirdADtS24BJB1WMToWDvhW4Bjm2sV0OzN1bfBfDXavEe92Pk+UwteWG41
         Ji+b6hY671PuQQ0sHHCJfYfs6ZlnRlgjcMsSFqjFr89R/tWXosygMWODMnAXcYac1tNv
         LY0GbZgDXzon0It8W7kx1jGYP51vY6KG9diFYxYhabceXdaeEhaBbft+gMcwX4nauJFR
         XfzsLJpsrpt/G3Q3ff9VlerGg4eZfw+Jd8ieiqsG7RFBeiauy1DIQYe8Vs1Rqq5gB9X+
         FXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B5mFiaBmbFAgvSLD1k8I0pYH8BNutIgWRHpbfdHvERY=;
        b=7/PuFYDDTuOwxyklQE0+4U5N187IXnGLKFWwwWRUESbjYI87HGHlHk3/SCeeHvVtme
         PgbGtsy4SBcWaOZNPjPQgPpj0PnmoE2rJoHguwkaSrmfbUY3V+mD33MTzMsz79BYWvq8
         RXkcaIoyeRDBoL7VYHlSrX1vlZWmtUm2526wtaIjcvyNmL0FE/gsxugKzT7chVEI/wMu
         +gvMbuaj8cNAgBwhNUt+ctBjhCwxqNWwG5GTy9OnhBzZKfm81I532t3pxcUi/KKkZSIw
         Si48mHiREjQhj4gc/O58S7ddvb4BEkr6p8MWXJbM1isdv4Nrr5JHX6yAzV37uRmLrVcL
         //pA==
X-Gm-Message-State: AOAM530Wt+bo+/z0J0J1DnuzW6p3jxeMcl3xOXqF93IzMPwMXNcDG7Gg
        sm97M0Po6hzRMVmR1S6bA7A=
X-Google-Smtp-Source: ABdhPJw9/uAnYy1iWqXAPosPe6iGCdsynT6rvhi1zWc9zXKyzDoBP6TxrkXD0CkUqZFTJb/F/k84Dw==
X-Received: by 2002:a17:902:d716:b0:15f:179c:9817 with SMTP id w22-20020a170902d71600b0015f179c9817mr47444547ply.150.1653750744528;
        Sat, 28 May 2022 08:12:24 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:a782:286b:de51:79ce])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b00161ef05c480sm5809380plf.6.2022.05.28.08.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 08:12:24 -0700 (PDT)
Date:   Sat, 28 May 2022 20:42:19 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 2/3] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
Message-ID: <20220528151219.ojgwg7pct6ci5zd6@riteshh-domain>
References: <20220528110017.354175-1-libaokun1@huawei.com>
 <20220528110017.354175-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528110017.354175-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/28 07:00PM, Baokun Li wrote:
> ext4_mb_normalize_request() can move logical start of allocated blocks
> to reduce fragmentation and better utilize preallocation. However logical
> block requested as a start of allocation (ac->ac_o_ex.fe_logical) should
> always be covered by allocated blocks so we should check that by
> modifying and to or in the assertion.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Changes looks good to me as we discussed. Feel free to add -

Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

> ---
> V1->V2:
> 	Change Fixes from dfe076c106f6 to c9de560ded61.
> V2->V3:
> 	Delete Fixes tag.
> 	Add more comments and commit logs to make the code easier to understand.
>
>  fs/ext4/mballoc.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4d3740fdff90..9e06334771a3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4185,7 +4185,22 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	}
>  	rcu_read_unlock();
>
> -	if (start + size <= ac->ac_o_ex.fe_logical &&
> +	/*
> +	 * In this function "start" and "size" are normalized for better
> +	 * alignment and length such that we could preallocate more blocks.
> +	 * This normalization is done such that original request of
> +	 * ac->ac_o_ex.fe_logical & fe_len should always lie within "start" and
> +	 * "size" boundaries.
> +	 * (Note fe_len can be relaxed since FS block allocation API does not
> +	 * provide gurantee on number of contiguous blocks allocation since that
> +	 * depends upon free space left, etc).
> +	 * In case of inode pa, later we use the allocated blocks
> +	 * [pa_start + fe_logical - pa_lstart, fe_len/size] from the preallocated
> +	 * range of goal/best blocks [start, size] to put it at the
> +	 * ac_o_ex.fe_logical extent of this inode.
> +	 * (See ext4_mb_use_inode_pa() for more details)
> +	 */
> +	if (start + size <= ac->ac_o_ex.fe_logical ||
>  			start > ac->ac_o_ex.fe_logical) {
>  		ext4_msg(ac->ac_sb, KERN_ERR,
>  			 "start %lu, size %lu, fe_logical %lu",
> --
> 2.31.1
>
