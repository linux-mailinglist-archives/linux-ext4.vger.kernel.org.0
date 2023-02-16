Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83A269954F
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 14:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBPNOD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 08:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBPNNp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 08:13:45 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984653B0FD;
        Thu, 16 Feb 2023 05:13:42 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so2106253pjw.2;
        Thu, 16 Feb 2023 05:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3QV6dagoaFtxVNP4EIl0deHoYTOELIU5lXZHFOYxb/Y=;
        b=H0OuOoKdSQ7+ltWg1cLBRqi3r6aP/4xfnwMjUIcMI7UepfAdqldXYGDBFbl4ZTJgvR
         7gQASmcg/K1369yitsezhQQkOPllQ37s2vHJsjjMvBWt536beKUX99CLVOtfGgLDRylx
         j1lbQd8rTLUMJP93F2iD6QJij2+PqI0xFnLPe5/8fEVvaOytDb+h0urWY+5y3Z/U0gBC
         WdwlQBjaNn5KZzAVXWAhF2W4Eccsq6QoIJ3L+SZpq20eqKIG6J0FHRlw3Og7ZzNzfvyE
         XsE6r/nXdC3n3Qxt2MY7uyLdYuoondAHc0iyhhg+UlumobBRhnGDHwtnw4H9MHI7UeOJ
         9veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QV6dagoaFtxVNP4EIl0deHoYTOELIU5lXZHFOYxb/Y=;
        b=VZbzY8ernlSrc3xrExraoxxKla3MR4MYtV3c4ob7fLQANIUiH0b4SiwVheVOq5ag+x
         rvILB9ohtZeu0SW/OJQB5ikUinN5t9AOfOjNI3hr0HjZy2/0RqoVvMVYCZKaLfcs0JzB
         /lHG3rlY5v2YNJu9JC5PPmuil6nfWAQD1WeHVv0v2qfceF+dCpC0tue1RwoVVgzkGkRU
         6Y8TAXKSaKuR/kdNeN7au2u1rS+OGLNxhhfmQDMjdXRROjTyXgsiJSIXg+dbvFOy3iKE
         1nfPh9fADfHnnjXRuLfkYwWG78NfNX5SR4+uO87gF3Y6yEeb7kgvdikAlATtrepGgPCT
         tpAg==
X-Gm-Message-State: AO0yUKW3yG+3lQiU/RkRahPz8CYo6xCKmXcHBzmgjMYE740qstQQKZjZ
        7WCLAwOP9ab9GVbFg6siRug=
X-Google-Smtp-Source: AK7set+I+GjxCYAMAuv1Z43P/O8C/6Lq3CFcdbt8bu0xadjMzcGQ68Hpgs9bKSFfUsDhU6dbMpARvA==
X-Received: by 2002:a05:6a20:a012:b0:c7:1d82:838c with SMTP id p18-20020a056a20a01200b000c71d82838cmr2361598pzj.41.1676553221979;
        Thu, 16 Feb 2023 05:13:41 -0800 (PST)
Received: from rh-tp ([2406:7400:63:5056:148f:873b:4bc8:1e77])
        by smtp.gmail.com with ESMTPSA id w2-20020aa78582000000b005a8cc32b23csm93636pfn.20.2023.02.16.05.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 05:13:41 -0800 (PST)
Date:   Thu, 16 Feb 2023 18:43:22 +0530
Message-Id: <87fsb5lpn1.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jinke Han <hanjinke.666@bytedance.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, Jinke Han <hanjinke.666@bytedance.com>
Subject: Re: [PATCH v2] ext4: make dioread_nolock consistent in each mapping round
In-Reply-To: <20230207124136.88222-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jinke Han <hanjinke.666@bytedance.com> writes:

> From: Jinke Han <hanjinke.666@bytedance.com>
>
> When disable and enable dioread_nolock by remount, we may see
> dioread_lock in ext4_do_writepages while see dioread_nolock in
> mpage_map_one_extent. This inconsistency may triger the warning
> in ext4_add_complete_io when the io_end->handle is NULL. Although
> this warning is harmless in most cases, there is still a risk of
> insufficient log reservation in conversion of unwritten extents.
>

Sorry, I haven't completely gone through the patch yet. But this idea of
caching the initial value of mount parameter and passing it do different
functions while an I/O request completes, is not looking right to me.

If that's the case shouldn't we disallow this mount option to change
until all the outstanding I/O's are done or complete?
Then we need not cache the value of dioread_nolock at the start of
writepages and continue to pass it down in case it it changes.

Just my initial thoughts.

-ritesh

> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 40579ef513b7..122a22ccddb3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1568,6 +1568,7 @@ struct mpage_da_data {
>  	struct ext4_io_submit io_submit;	/* IO submission data */
>  	unsigned int do_map:1;
>  	unsigned int scanned_until_end:1;
> +	unsigned int dioread_nolock:1;
>  };
>
>  static void mpage_release_unused_pages(struct mpage_da_data *mpd,
> @@ -2391,7 +2392,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>  	struct inode *inode = mpd->inode;
>  	struct ext4_map_blocks *map = &mpd->map;
>  	int get_blocks_flags;
> -	int err, dioread_nolock;
> +	int err, dioread_nolock = mpd->dioread_nolock;
>
>  	trace_ext4_da_write_pages_extent(inode, map);
>  	/*
> @@ -2412,7 +2413,6 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>  	get_blocks_flags = EXT4_GET_BLOCKS_CREATE |
>  			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
>  			   EXT4_GET_BLOCKS_IO_SUBMIT;
> -	dioread_nolock = ext4_should_dioread_nolock(inode);
>  	if (dioread_nolock)
>  		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
>  	if (map->m_flags & BIT(BH_Delay))
> @@ -2727,10 +2727,11 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  	handle_t *handle = NULL;
>  	struct inode *inode = mpd->inode;
>  	struct address_space *mapping = inode->i_mapping;
> -	int needed_blocks, rsv_blocks = 0, ret = 0;
> +	int needed_blocks, rsv_blocks = 0, rsv = 0, ret = 0;
>  	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
>  	struct blk_plug plug;
>  	bool give_up_on_write = false;
> +	bool dioread_nolock;
>
>  	trace_ext4_writepages(inode, wbc);
>
> @@ -2783,15 +2784,6 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  		ext4_journal_stop(handle);
>  	}
>
> -	if (ext4_should_dioread_nolock(inode)) {
> -		/*
> -		 * We may need to convert up to one extent per block in
> -		 * the page and we may dirty the inode.
> -		 */
> -		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
> -						PAGE_SIZE >> inode->i_blkbits);
> -	}
> -
>  	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>  		range_whole = 1;
>
> @@ -2837,6 +2829,18 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  		goto unplug;
>
>  	while (!mpd->scanned_until_end && wbc->nr_to_write > 0) {
> +		dioread_nolock = ext4_should_dioread_nolock(inode);
> +		if (!rsv && dioread_nolock) {
> +			/*
> +			 * We may need to convert up to one extent per block in
> +			 * the page and we may dirty the inode.
> +			 */
> +			rsv = 1 + ext4_chunk_trans_blocks(inode,
> +							PAGE_SIZE >> inode->i_blkbits);
> +		}
> +		rsv_blocks = dioread_nolock ? rsv : 0;
> +		mpd->dioread_nolock = dioread_nolock;
> +
>  		/* For each extent of pages we use new io_end */
>  		mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
>  		if (!mpd->io_submit.io_end) {
> --
> 2.20.1
