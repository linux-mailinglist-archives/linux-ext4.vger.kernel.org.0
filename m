Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9176268D156
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Feb 2023 09:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjBGIOa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Feb 2023 03:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBGIO3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Feb 2023 03:14:29 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF88274A1
        for <linux-ext4@vger.kernel.org>; Tue,  7 Feb 2023 00:14:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u9so10589112plf.3
        for <linux-ext4@vger.kernel.org>; Tue, 07 Feb 2023 00:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3nh53s656rQBFJKGoTKZMouF3QVtP/WF8kGSIE78eg=;
        b=X5AgTAHuhRwjohAgX5EW4XpFdoJ/N8ezXLMu13zX4/dlmkY4K36C3a1LZSnZMUSH7L
         KYEHys/OsGgIcDPP9pepFjVadfhgdbFEODBtxIdY0CS6bmtnEpUlBo7Ojhfi4hAWbGyb
         SEtPxVg76CTvYiNA2U7vTvxvFu5XHGuyw6cL93mkE12H96VrUnYPXYSp5bRKdHuTN+DN
         gbKrtthpKIegbqf5JpxAbweVoQ+UYhu/4ydThCOKlYCRJS18180PB9Rfp7IXSVDT3UFo
         Uzn9PVSHk/ZdqtMemKYyNMupkprurjcms6g7jaKD9iASGnaA8AV6Wv1BE7DIbaMiCoAZ
         bzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X3nh53s656rQBFJKGoTKZMouF3QVtP/WF8kGSIE78eg=;
        b=F176FTK5WMBStpkCdkIVJczj5QcQPzEaHepByW97qDovQuk3L+i94GfKKGZPELsUtv
         IKEPKLyA+jjdmmDOxUUhO4R0yRKBMO00UWGTzClPbhUumO6p+sdKE1CMdC8+yP87LzKJ
         bOQXap4SpisPgV/sD8QIgZAGAkbzcFsptQgg0aL0eGDg86xJ0vmm5Y9eLt/zMmcTZS9B
         nMNeVRAEhr7q6z2HGNgqpjIsZ7Weq1g19VXJdnnHMOwMWBVQCxquNhcwGSaCOdB3ihSJ
         JOJDjHypcYs5GvgQuY3W8liX+xhN7dkAB0n3inUWN6jbKKJ5AeK1YAOuX5l8b6ZG/iYU
         q1Jg==
X-Gm-Message-State: AO0yUKWEytbwyJ/vgljBm6Rd0ifWeM1YEzuO0j8niW92BWfi5IyggDQT
        I8s0p95AHtoFTUH9WIPWgvIV1Q==
X-Google-Smtp-Source: AK7set/BkGkzuwS3EUw0f2iZ+dJjFkQxIiGuxcsfEC/EC5oTyNRE6Q7609D+b8uifg+qxVlCJDncoQ==
X-Received: by 2002:a17:903:22d0:b0:199:190c:3c16 with SMTP id y16-20020a17090322d000b00199190c3c16mr2549151plg.45.1675757641397;
        Tue, 07 Feb 2023 00:14:01 -0800 (PST)
Received: from [10.3.157.223] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b001991594d783sm3571795plb.302.2023.02.07.00.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 00:14:01 -0800 (PST)
Message-ID: <2f16e76c-aaad-45cc-c3ac-f29456b021ac@bytedance.com>
Date:   Tue, 7 Feb 2023 16:13:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] ext4: make dioread_nolock consistent in each mapping
 round
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230207064203.72102-1-hanjinke.666@bytedance.com>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <20230207064203.72102-1-hanjinke.666@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi,all

Please ignore this patch, maybe I missed some something critical.

在 2023/2/7 下午2:42, Jinke Han 写道:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> When disable and enable dioread_nolock by remount, we may see
> dioread_lock in ext4_do_writepages while see dioread_nolock in
> mpage_map_one_extent. This inconsistency may triger the warning
> in ext4_release_io_end. Although this warning is harmless, we'd
> better fix it
> 
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
> ---
>   fs/ext4/inode.c | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 40579ef513b7..122a22ccddb3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1568,6 +1568,7 @@ struct mpage_da_data {
>   	struct ext4_io_submit io_submit;	/* IO submission data */
>   	unsigned int do_map:1;
>   	unsigned int scanned_until_end:1;
> +	unsigned int dioread_nolock:1;
>   };
>   
>   static void mpage_release_unused_pages(struct mpage_da_data *mpd,
> @@ -2391,7 +2392,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>   	struct inode *inode = mpd->inode;
>   	struct ext4_map_blocks *map = &mpd->map;
>   	int get_blocks_flags;
> -	int err, dioread_nolock;
> +	int err, dioread_nolock = mpd->dioread_nolock;
>   
>   	trace_ext4_da_write_pages_extent(inode, map);
>   	/*
> @@ -2412,7 +2413,6 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>   	get_blocks_flags = EXT4_GET_BLOCKS_CREATE |
>   			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
>   			   EXT4_GET_BLOCKS_IO_SUBMIT;
> -	dioread_nolock = ext4_should_dioread_nolock(inode);
>   	if (dioread_nolock)
>   		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
>   	if (map->m_flags & BIT(BH_Delay))
> @@ -2727,10 +2727,11 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>   	handle_t *handle = NULL;
>   	struct inode *inode = mpd->inode;
>   	struct address_space *mapping = inode->i_mapping;
> -	int needed_blocks, rsv_blocks = 0, ret = 0;
> +	int needed_blocks, rsv_blocks = 0, rsv = 0, ret = 0;
>   	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
>   	struct blk_plug plug;
>   	bool give_up_on_write = false;
> +	bool dioread_nolock;
>   
>   	trace_ext4_writepages(inode, wbc);
>   
> @@ -2783,15 +2784,6 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>   		ext4_journal_stop(handle);
>   	}
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
>   	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>   		range_whole = 1;
>   
> @@ -2837,6 +2829,18 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>   		goto unplug;
>   
>   	while (!mpd->scanned_until_end && wbc->nr_to_write > 0) {
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
>   		/* For each extent of pages we use new io_end */
>   		mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
>   		if (!mpd->io_submit.io_end) {
