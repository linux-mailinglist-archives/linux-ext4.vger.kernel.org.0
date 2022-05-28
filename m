Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F07E536D6D
	for <lists+linux-ext4@lfdr.de>; Sat, 28 May 2022 17:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiE1PKv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 May 2022 11:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiE1PKu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 May 2022 11:10:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8B13D1A;
        Sat, 28 May 2022 08:10:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n10so7066987pjh.5;
        Sat, 28 May 2022 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=inDnD0wROpJhPH4vVDWXmOqaC6S+aIzVgfkbHUBSKG8=;
        b=QKXmnYrqiD3Cxg7dIrI2fr4J4OPY92Gibw1wtBDi/yOOXKpInV3HwaUA3W5Y0Nlp9n
         f7vEQAFOkklkFopVXCI/LagbDDZoU6XWCtAzQZDsiUW0zKvhaW5y2Cmz2FCKzFLbUfoQ
         aeP4tO/mPicwZYZtPX5caxaYHXU/ZN+WF4jFPnl+6ZlDUHJiDmn/ThWrKbTF/4MBY4pn
         TQMj6LRbbcrRBwHbFzvqWdBV4nkEHCs56rYMu8wqhKCe7st6iWXv1gbPGMTJtOcMkN81
         c3EcofeGkFxULDIF7AdwPiYjRLb0PSkeTFA09oYqG9TPfJSmj4eBY5oFzhXvbFWUYAEu
         vSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=inDnD0wROpJhPH4vVDWXmOqaC6S+aIzVgfkbHUBSKG8=;
        b=VZtX/3K7M2ZvgFECe8+W6Nw9R+7m2kFoQSbOJmvCvhKOsBo6a3rGJ8REcrtslY9bX2
         4WiU97zGPoA8CIuWGr+85TmMfYlfIPAd8baZTWdaJk+SdDindZWU2RGIq4Zq/qafHrvq
         eADWWT2/M/w+AjP3B6PoGPSvByTJnR5SlGv7PjolVDhEi6vCGvZpCSYs8yfllGJHaAVv
         v5g7lCCXLO8KEk+0wEsrcynj2BgL0y20wyJm7mj2VN9Gk/NihfRrdAYLY1gIHaZuhTwf
         7ceGI3TuUtP6KWdODCR4GF/pnS/M9gizqPa5pCoyTWqndUbFFnd3Tct6KyLJzyhQCR+9
         WyZQ==
X-Gm-Message-State: AOAM531+ik+JcT01lpP4nnP5LdkwVYVbPRUnNPafrcSuFrVRRpLCQhbI
        37oDMfils9R7ze7L/Wx4FPI=
X-Google-Smtp-Source: ABdhPJzX3+lTU4TW5kMjJHApRGcMj3jF/RuCM5RRWvIw1UlOrQMBa7IMYfwkeEG4Bmj1HURP2YLrgQ==
X-Received: by 2002:a17:90b:4f81:b0:1e0:3024:900d with SMTP id qe1-20020a17090b4f8100b001e03024900dmr13910600pjb.229.1653750649381;
        Sat, 28 May 2022 08:10:49 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:a782:286b:de51:79ce])
        by smtp.gmail.com with ESMTPSA id bi7-20020a170902bf0700b0015e8d4eb282sm5707061plb.204.2022.05.28.08.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 08:10:49 -0700 (PDT)
Date:   Sat, 28 May 2022 20:40:44 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, lczerner@redhat.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH v3 1/3] ext4: fix bug_on ext4_mb_use_inode_pa
Message-ID: <20220528151044.u3quqpy4krsfwszq@riteshh-domain>
References: <20220528110017.354175-1-libaokun1@huawei.com>
 <20220528110017.354175-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528110017.354175-2-libaokun1@huawei.com>
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
> Hulk Robot reported a BUG_ON:
> ==================================================================
> kernel BUG at fs/ext4/mballoc.c:3211!
> [...]
> RIP: 0010:ext4_mb_mark_diskspace_used.cold+0x85/0x136f
> [...]
> Call Trace:
>  ext4_mb_new_blocks+0x9df/0x5d30
>  ext4_ext_map_blocks+0x1803/0x4d80
>  ext4_map_blocks+0x3a4/0x1a10
>  ext4_writepages+0x126d/0x2c30
>  do_writepages+0x7f/0x1b0
>  __filemap_fdatawrite_range+0x285/0x3b0
>  file_write_and_wait_range+0xb1/0x140
>  ext4_sync_file+0x1aa/0xca0
>  vfs_fsync_range+0xfb/0x260
>  do_fsync+0x48/0xa0
> [...]
> ==================================================================
>
> Above issue may happen as follows:
> -------------------------------------
> do_fsync
>  vfs_fsync_range
>   ext4_sync_file
>    file_write_and_wait_range
>     __filemap_fdatawrite_range
>      do_writepages
>       ext4_writepages
>        mpage_map_and_submit_extent
>         mpage_map_one_extent
>          ext4_map_blocks
>           ext4_mb_new_blocks
>            ext4_mb_normalize_request
>             >>> start + size <= ac->ac_o_ex.fe_logical
>            ext4_mb_regular_allocator
>             ext4_mb_simple_scan_group
>              ext4_mb_use_best_found
>               ext4_mb_new_preallocation
>                ext4_mb_new_inode_pa
>                 ext4_mb_use_inode_pa
>                  >>> set ac->ac_b_ex.fe_len <= 0
>            ext4_mb_mark_diskspace_used
>             >>> BUG_ON(ac->ac_b_ex.fe_len <= 0);
>
> we can easily reproduce this problem with the following commands:
> 	`fallocate -l100M disk`
> 	`mkfs.ext4 -b 1024 -g 256 disk`
> 	`mount disk /mnt`
> 	`fsstress -d /mnt -l 0 -n 1000 -p 1`
>
> The size must be smaller than or equal to EXT4_BLOCKS_PER_GROUP.
> Therefore, "start + size <= ac->ac_o_ex.fe_logical" may occur
> when the size is truncated. So start should be the start position of
> the group where ac_o_ex.fe_logical is located after alignment.
> In addition, when the value of fe_logical or EXT4_BLOCKS_PER_GROUP
> is very large, the value calculated by start_off is more accurate.
>
> Fixes: cd648b8a8fd5 ("ext4: trim allocation requests to group size")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Replace round_down() with rounddown().
> 	Modified comments.
> V2->V3:
> 	Convert EXT4_BLOCKS_PER_GROUP type to ext4_lblk_t
> 	to avoid compilation warnings.

Looks good to me. Feel free to add -

Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

>
>  fs/ext4/mballoc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
