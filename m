Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811866333FD
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Nov 2022 04:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiKVDfL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 22:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiKVDfG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 22:35:06 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34827275D8;
        Mon, 21 Nov 2022 19:35:03 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z1so9462195qkl.9;
        Mon, 21 Nov 2022 19:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7I/A0iqrxZCljCTmfRtDGpoHSH6u01y29lbjq53MCQ=;
        b=ohhrabe+FDlS5639l+JpnC2ukjAMdb6bfuAIpTGswwg+DwmaBlvLdh7657mErGy9JW
         pDXaUaYDFF0QsQYXJCE7pMP+IgxJ8A3MZZiQYTgP9RJsjHQK6+Bc++LrpdpSvlChCBhC
         +XN97u/oTIhOOfr+ZOIKHpoqtAhqhXZ6lg6Rj/xpP+q/SwosP+uXmB4Qx1SlWilXs64Z
         26mcqCQmR75sYPEKxq47fGVmrrEoNeo9ezI2rjzo3mAyZXmdbhHBbzsyb/SDRSdUQ+R/
         QNsyVq3gk0kNjmVnH0Ie/9L+cLx3dCffvr2yYcrAocmd0Vz92yhkgA3PFzC5Kc+CZNa8
         fajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7I/A0iqrxZCljCTmfRtDGpoHSH6u01y29lbjq53MCQ=;
        b=tlx5lyoWXSwEpEdz6UBY7RC/EvroA9U7iea33dwg6cQsUAOR7VeYrF+sDKKDgc4BmR
         yIRYMdBdq3MkBnv8yTBeAFcUfoonIVpbm5l4atqBClc2mlc9VRo2pLHL8EFYLKvOX5rR
         VKvmsMOczpoFdhxQP+V1mEC72GmlHRyw2skLxtJ02SkQ4wGCkqevzVK2dYud3p/mKsOy
         Qe88caIbeDpU9H3Y3dGy9riPmaDsx6MKUbIx4ms5I9q2gES7ML/3IoareHR6YvRGgjoP
         44G1exhGWP0s5sn8N4ViLcWebSjlhM9fUb/D+BP+QdQBUtyg0cv7oWaRDExGkwHiWw4h
         dy6A==
X-Gm-Message-State: ANoB5pmATExUXtYsQUEskchMTeA3aLYgb8wnvpvitfTIEgVk47RhdCyM
        yEgGMZbPgMIS2fPR9iEJwW8=
X-Google-Smtp-Source: AA0mqf7DEZaU8K9xSgLXBQyX0gczNViTgga48HCdIAXxJznceIB20mDBw3Dzm9i1lYIDxTOTzuC8Eg==
X-Received: by 2002:a37:8883:0:b0:6fa:93b1:8b6f with SMTP id k125-20020a378883000000b006fa93b18b6fmr19496035qkd.357.1669088102328;
        Mon, 21 Nov 2022 19:35:02 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id o22-20020ac872d6000000b00399edda03dfsm7537642qtp.67.2022.11.21.19.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:35:01 -0800 (PST)
Date:   Mon, 21 Nov 2022 22:34:59 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v2 2/3] ext4: record error when detect abnormal
 'i_reserved_data_blocks'
Message-ID: <Y3xDY4GVAF+eKAqY@debian-BULLSEYE-live-builder-AMD64>
References: <20221121121434.1061725-1-yebin@huaweicloud.com>
 <20221121121434.1061725-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121121434.1061725-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Ye Bin <yebin@huaweicloud.com>:
> From: Ye Bin <yebin10@huawei.com>
> 
> If 'i_reserved_data_blocks' is not cleared which mean something wrong with
> code, free space accounting is likely wrong, according to Jan Kara's advice
> use ext4_error() to record this abnormal let fsck to repair and also we can
> capture this issue.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/super.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0690e2e0b74d..3d30007502a4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1387,10 +1387,9 @@ static void ext4_destroy_inode(struct inode *inode)
>  	}
>  
>  	if (EXT4_I(inode)->i_reserved_data_blocks)
> -		ext4_msg(inode->i_sb, KERN_ERR,

Per the coding standard, IIRC, the string should not be split across lines
for "greppability", so it should remain as is.  It's always good to run
checkpatch to catch stuff like this.

> -			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
> -			 inode->i_ino, EXT4_I(inode),
> -			 EXT4_I(inode)->i_reserved_data_blocks);
> +		ext4_error(inode->i_sb, "Inode %lu (%p) i_reserved_data_blocks"
> +			   " (%u) not cleared!", inode->i_ino, EXT4_I(inode),
> +			   EXT4_I(inode)->i_reserved_data_blocks);
>  }
>  
>  static void init_once(void *foo)

This is an improvement over the first version.  If i_reserved_data_blocks is
non-zero, something is definitely broken, but it's perhaps less likely to
indicate file system damage than if it hits zero while there are still
outstanding delayed blocks (handled well elsewhere).  So, it's not clear
we need to escalate handling this case but it doesn't hurt, either.

Eric

> -- 
> 2.31.1
> 
