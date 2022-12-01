Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C826263EF56
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 12:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiLALVZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 06:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiLALU7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 06:20:59 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5645F58
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 03:17:39 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 124so1612014pfy.0
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 03:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WAHy2xU49jukCv50vcInL2OSvyXUpoyvwPXjCgPKzcU=;
        b=b9wQJYuRRlFAJ+W/yk7igVzH30k4N+p4KMrqHspe+0ZFp/fmSK7heyyuFmVp32FQQM
         Y8eoO+8bw2oAhgz5UE9Yp+rmXdl0siOR9sA0CxOmiglrU4wo7eB0g+aa4UNovbJZgF8Z
         fJ2m1/e67XfSikaFC+PKrCzszaMNWFRCrPSCRAVJXv4jukO568bUTFN9JCmkTNHltV7Z
         NyIPsmz+e6NoPiF4SKPH3Eicus3RLnoSCUjVkEpjtmVURpWjKt+EQXz6VM7TzKfpqXck
         bXpZQX0J4d4Ho23/Dpx1L99RhdS5E7fBgXtMs5aucEVHZvz1+7iDiLbKKVsI+0JSlVm5
         5GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAHy2xU49jukCv50vcInL2OSvyXUpoyvwPXjCgPKzcU=;
        b=G3dCEprCuRT2qMbryqEmw6xG3i6UXgN8XPRmPVpKHVOx80CKtmB1JCFS9J6DzWDbhk
         QfWeSmxkpphnqO1LUV2042m2Rgy81JFpsIzSizHWVbc/vFyy1Woo20QG36Wq4LwEfbxg
         oWBi+rQJE/9//bre/POfpBXQb7zGo/GQV5mL0sUP0NrifcoE4XiBY18YWRpXvQlq47Dh
         FXvSNdpqW13EVhJjFJhG0d9Y+CWVyscyM4ONuHx1/+qNAcLkCpxwHE7C5Nv8K5XvvN8N
         TlDgYrjXHbNkIkASJpnjb/JkPeTdHuhQehmh+zSJ9D76tViRcYeESwgbE5NJ5/91aWMN
         x7Yg==
X-Gm-Message-State: ANoB5pnizqTUOSG0ThBCMeQPf0VOlwbxABfQEFyJ/052Bn/hgitzJsM7
        skQTISFzK3iEywXWYicdjr8n+F2JjI8=
X-Google-Smtp-Source: AA0mqf4pBqfFihGW2ke3rLFd/Qk4Ltp/1D+62vx1lTQr1r6GSYxPqX1AOKCde1ipzRhXZ2ECL/korw==
X-Received: by 2002:a65:5c4b:0:b0:477:2aac:56bb with SMTP id v11-20020a655c4b000000b004772aac56bbmr56044866pgr.570.1669893458713;
        Thu, 01 Dec 2022 03:17:38 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b0017849a2b56asm3404699plg.46.2022.12.01.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:17:38 -0800 (PST)
Date:   Thu, 1 Dec 2022 16:47:33 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 8/9] ext4: Switch to using ext4_do_writepages() for
 ordered data writeout
Message-ID: <20221201111733.ay64gyjmhcksheza@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-8-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130163608.29034-8-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/11/30 05:35PM, Jan Kara wrote:
> Use the standard writepages method (ext4_do_writepages()) to perform
> writeout of ordered data during journal commit.

Neat!!
Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/ext4.h  |  1 +
>  fs/ext4/inode.c | 16 ++++++++++++++++
>  fs/ext4/super.c |  3 +--
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1b3bffc04fd0..07b55cc48578 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2999,6 +2999,7 @@ extern void ext4_set_inode_flags(struct inode *, bool init);
>  extern int ext4_alloc_da_blocks(struct inode *inode);
>  extern void ext4_set_aops(struct inode *inode);
>  extern int ext4_writepage_trans_blocks(struct inode *);
> +extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
>  extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
>  extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
>  			     loff_t lstart, loff_t lend);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 00c4d12f8270..c131b611dabf 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2950,6 +2950,22 @@ static int ext4_writepages(struct address_space *mapping,
>  	return ret;
>  }
>
> +int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode)
> +{
> +	struct writeback_control wbc = {
> +		.sync_mode = WB_SYNC_ALL,
> +		.nr_to_write = LONG_MAX,
> +		.range_start = jinode->i_dirty_start,
> +		.range_end = jinode->i_dirty_end,
> +	};
> +	struct mpage_da_data mpd = {
> +		.inode = jinode->i_vfs_inode,
> +		.wbc = &wbc,
> +		.can_map = 0,
> +	};
> +	return ext4_do_writepages(&mpd);
> +}
> +
>  static int ext4_dax_writepages(struct address_space *mapping,
>  			       struct writeback_control *wbc)
>  {
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7cdd2138c897..c02329dd7574 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -540,8 +540,7 @@ static int ext4_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
>  	if (ext4_should_journal_data(jinode->i_vfs_inode))
>  		ret = ext4_journalled_submit_inode_data_buffers(jinode);
>  	else
> -		ret = jbd2_journal_submit_inode_data_buffers(jinode);
> -
> +		ret = ext4_normal_submit_inode_data_buffers(jinode);
>  	return ret;
>  }
>
> --
> 2.35.3
>
