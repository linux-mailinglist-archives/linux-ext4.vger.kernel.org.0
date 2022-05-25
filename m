Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869D85337C6
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 09:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiEYHva (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiEYHv3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 03:51:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257B53FBE9;
        Wed, 25 May 2022 00:51:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h13so12263518pfq.5;
        Wed, 25 May 2022 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fCV26XsT8ltkw34ERAc6SjsXO4ZxGrWCDVUX/kH81Vk=;
        b=aMMvHrc2DCz6gzzNskOYahSxyH7xMzBNRVmonJxwlGdAh/IKZW8QywwYepLtbD1t9y
         9rwFIMVEMX+QaGgKhMYKl5w7En/Xv6eAJGEkNKH7HAYzhsXjdLsf5jCqjovXDn1lBt2s
         9Vu6NKZKSJASDc1fHaScbH5nKfFHPs9DozECzAKCEEbII9GWPP3JipIWa26iEXNnUPy3
         Ma0gnIjaUG6NSftBw9xCSAN+IPTd3nq4LYSrPZAcDskTIzbZ357DImTjR6vpo3vG7IIy
         19Rp+hCjsDhjzqBQ0HB8Bf/mr6IoTW2KFKg9PmFLyRs93aP1OzoCGEjT92J0+P1Nn3Fb
         c+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fCV26XsT8ltkw34ERAc6SjsXO4ZxGrWCDVUX/kH81Vk=;
        b=zQuwzqToiu3xamlljIkcmz4FLjMo4Z1XcW0NAFI69HnkHHvsGB1cQRSyTEx+4hWunt
         AnJuhnIOfGBpKMSWDh7H/mVAMgK9gneqAPXhlmGlIL5CerA9AM5qnnMymMmUPbvdLIbE
         ZL4TC5loU6grMRiXoXCc8gf3DbpQUIN+ZzJq9lh4IdGv30yFW+LcnRSgg29pUK4/z8jd
         2HJiwaHfPnbSv84yYViChWg+EmBXyJ6G9MCcZh53fkkiSUUq/ulsdZL4l8TFVG949FJe
         Mh4+cBHYfUbs9TLEApL2e96JZ4hHeIa6TqM4ELl4Tmm5Dx2Z9s0Z10Q4PlKfgWOfZ9Yi
         6iBQ==
X-Gm-Message-State: AOAM533ieZOHNW+X6uAeZioyDaT0zRGkful2PLr3w78xP9+4rZYeE073
        4lheHj4UoZubu4g1XfPYidVOX1+zW4U=
X-Google-Smtp-Source: ABdhPJy5sSpWNK6ksae+id3CHXoYNnY/dUHroQ67YKg+Z/+4CnmE9yHE8FARWKED+AR5t8oCBMMj/w==
X-Received: by 2002:a63:5a01:0:b0:3d8:22cb:9224 with SMTP id o1-20020a635a01000000b003d822cb9224mr27350223pgb.548.1653465088611;
        Wed, 25 May 2022 00:51:28 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:a782:286b:de51:79ce])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a630500b001dedb8bbe66sm1012980pjj.33.2022.05.25.00.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 00:51:27 -0700 (PDT)
Date:   Wed, 25 May 2022 13:21:23 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: fix super block checksum incorrect after
 mount
Message-ID: <20220525075123.rx5v7fe6ocn354wn@riteshh-domain>
References: <20220525012904.1604737-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525012904.1604737-1-yebin10@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/25 09:29AM, Ye Bin wrote:
> We got issue as follows:
> [home]# mount  /dev/sda  test
> EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
> [home]# dmesg
> EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
> EXT4-fs (sda): Errors on filesystem, clearing orphan list.
> EXT4-fs (sda): recovery complete
> EXT4-fs (sda): mounted filesystem with ordered data mode. Quota mode: none.
> [home]# debugfs /dev/sda
> debugfs 1.46.5 (30-Dec-2021)
> Checksum errors in superblock!  Retrying...
>
> Reason is ext4_orphan_cleanup will reset ‘s_last_orphan’ but not update
> super block checksum.
> To solve above issue, defer update super block checksum after ext4_orphan_cleanup.

I agree with the analysis. However after [1], I think all updates to superblock
(including checksum computation) should be done within buffer lock.
(lock_buffer(), unlock_buffer()).

[1]: https://lore.kernel.org/all/20201216101844.22917-4-jack@suse.cz/

With lock changes added, feel free to add -

Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>


>
>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/super.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index f9a3ad683b4a..c47204029429 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5300,14 +5300,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
>  					  GFP_KERNEL);
>  	}
> -	/*
> -	 * Update the checksum after updating free space/inode
> -	 * counters.  Otherwise the superblock can have an incorrect
> -	 * checksum in the buffer cache until it is written out and
> -	 * e2fsprogs programs trying to open a file system immediately
> -	 * after it is mounted can fail.
> -	 */
> -	ext4_superblock_csum_set(sb);
>  	if (!err)
>  		err = percpu_counter_init(&sbi->s_dirs_counter,
>  					  ext4_count_dirs(sb), GFP_KERNEL);
> @@ -5365,6 +5357,14 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
>  	ext4_orphan_cleanup(sb, es);
>  	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
> +	/*
> +	 * Update the checksum after updating free space/inode counters and
> +	 * ext4_orphan_cleanup. Otherwise the superblock can have an incorrect
> +	 * checksum in the buffer cache until it is written out and
> +	 * e2fsprogs programs trying to open a file system immediately
> +	 * after it is mounted can fail.
> +	 */
> +	ext4_superblock_csum_set(sb);
>  	if (needs_recovery) {
>  		ext4_msg(sb, KERN_INFO, "recovery complete");
>  		err = ext4_mark_recovery_complete(sb, es);
> --
> 2.31.1
>
