Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8213D73BBD5
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jun 2023 17:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjFWPiy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Jun 2023 11:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjFWPiw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Jun 2023 11:38:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CB62116;
        Fri, 23 Jun 2023 08:38:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b51780c1b3so5621135ad.1;
        Fri, 23 Jun 2023 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687534727; x=1690126727;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XNZdRHIsjCZL1R/q6ps5SptZy5yf5lhtVRXpT/nMulA=;
        b=C0/t8l6UgAzUXZH1ZJAgtP1tAGP6FJHUKqT4vXuBdr39sHkhdlNkBLgkJ4d/AIfOP3
         9lXjoOV849J9X1nkAzyCg7HMUe5N1HBilt56GjhaPFx9xe+ueN68kGA2F6GA2J6capjR
         4t9DSEh/fiMQjRMRHpflmh1e5+CHdGqFWHA5p21sOC0GzSQIVqKZ3e7BJSa++ryjlBnq
         5cCM7ZoebyxI0evhV6MezS0NmfDHjEETrYEBXCioL569uT/f67jVtA2E3//+LdmjhDoi
         rKKF0ABEfmbWB7STEjGCVIgrswHZXkd2hNxdEulf3gsVfRxtl2DhLZ9C6aZoap7fFw5k
         djrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687534727; x=1690126727;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNZdRHIsjCZL1R/q6ps5SptZy5yf5lhtVRXpT/nMulA=;
        b=F+t6zczb3dD+FzY9FnracUkJWN7ImFtP6OushBrk0Yj1UdFd+1HbJXQ/ykZHvp/eib
         jsuLnx+6Z6Pi5hOJcoJX6ddSxUGvgy6WZjpMxpY941mXTHRdTV5NH61aJxbAkU8WvGIN
         jMJWGCQ8KaZyZNhfF6VllCo3cJreyUg4tJ604B4UvMmEaoK0zllqWga3adaSaWdSR5TB
         UpmyfaCVrHEvqVC99X3XBtk7jt5y/iNoPfKf5JUkmNHo3TM3fI+EN/ESNglkMS9CCL2q
         lZH2nC07mxpQLQsUD2U95+UMu9Csj7Q8Y32ITmSztReJ8x/y3go2HOgVJ37ncj4sow+4
         7/Mg==
X-Gm-Message-State: AC+VfDxvpkFLI7iQ77xdQWGXQbldEYdvqLhMf0jNzjk5RKoAldwA2pRC
        vdO8DL5y/UtGksgjzMS1/ss=
X-Google-Smtp-Source: ACHHUZ5yI6hpMC0b80iPcCrL/vZmdOPT5tYihNRG2uEyShIAhBakGKH/6qdQ/N9g/8u7Mcw7ddkLAA==
X-Received: by 2002:a17:902:e751:b0:1b6:b805:5ae3 with SMTP id p17-20020a170902e75100b001b6b8055ae3mr4491841plf.3.1687534726988;
        Fri, 23 Jun 2023 08:38:46 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id bd7-20020a170902830700b001b53472353csm7315119plb.211.2023.06.23.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:38:46 -0700 (PDT)
Date:   Fri, 23 Jun 2023 21:08:37 +0530
Message-Id: <87leganq82.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Sean Greenslade <sean@seangreenslade.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: RO mount of ext4 filesystem causes writes
In-Reply-To: <20230623143411.GF34229@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Thu, Jun 22, 2023 at 11:18:04PM -0700, Sean Greenslade wrote:
>> I perhaps should have been more explicit in my report. The issue is not
>> that the image is any different after the mount; indeed, the md5sums are
>> identical before and after on my machine as well. The issue is that
>> something is issuing writes to the backing image, which bumps the mtime
>> of the backing image. When handling the images with rsync, a difference
>> in mtime causes the whole image to need to be read.
>
> Ah, yes, your initial report said "small writes", but it didn't
> specify whether the issue was that writes were modifying the image, or
> just simply touching the mtime field of the backing file.  I assume
> these must be largish fs images, since it must have made the increased
> rsync time noticeable?
>
> This appears to fix the problem for me, given the clarified
> reproduction information.  Could you please try it on your end?
>
> 	     		   	     	    - Ted
>
> From 6bb438fa0aac4c08acd626d408cb6d4b745df7fd Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Fri, 23 Jun 2023 10:18:51 -0400
> Subject: [PATCH] ext4: avoid updating the superblock on a r/o mount if not
>  needed
>
> This was noticed by a user who noticied that the mtime of a file
> backing a loopback device was getting bumped when the loopback device
> is mounted read/only.  Note: This doesn't show up when doing a
> loopback mount of a file directly, via "mount -o ro /tmp/foo.img
> /mnt", since the loop device is set read-only when mount automatically
> creates loop device.  However, this is noticeable for a LUKS loop
> device like this:
>
> % cryptsetup luksOpen /tmp/foo.img test
> % mount -o ro /dev/loop0 /mnt ; umount /mnt
>
> or, if LUKS is not in use, if the user manually creates the loop
> device like this:
>
> % losetup /dev/loop0 /tmp/foo.img
> % mount -o ro /dev/loop0 /mnt ; umount /mnt
>
> The modified mtime causes rsync to do a rolling checksum scan of the
> file on the local and remote side, incrementally increasing the time
> to rsync the not-modified-but-touched image file.
>
> Fixes: eee00237fa5e ("ext4: commit super block if fs record error when journal record without error")
> Cc: stable@kernel.org
> Link: https://lore.kernel.org/r/ZIauBR7YiV3rVAHL@glitch
> Reported-by: Sean Greenslade <sean@seangreenslade.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/super.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b3819e70093e..c638b0db3b2b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5997,19 +5997,27 @@ static int ext4_load_journal(struct super_block *sb,
>  		err = jbd2_journal_wipe(journal, !really_read_only);
>  	if (!err) {
>  		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
> +		__le16 orig_state;
> +		bool changed = false;
>  
>  		if (save)
>  			memcpy(save, ((char *) es) +
>  			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
>  		err = jbd2_journal_load(journal);
> -		if (save)
> +		if (save && memcmp(((char *) es) + EXT4_S_ERR_START,
> +				   save, EXT4_S_ERR_LEN)) {
>  			memcpy(((char *) es) + EXT4_S_ERR_START,
>  			       save, EXT4_S_ERR_LEN);
> +			changed = true;
> +		}

It seems in the original code what we were trying to do was to preseve
the error information area of superblock across journal load (which I am
not sure why though?)

In the new code we see if the journal load changed that area and if yes
we change that back to original log but we also marked changed = true. Why?

>  		kfree(save);
> +		orig_state = es->s_state;
>  		es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state &
>  					   EXT4_ERROR_FS);
> +		if (orig_state != es->s_state)
> +			changed = true;
>  		/* Write out restored error information to the superblock */
> -		if (!bdev_read_only(sb->s_bdev)) {
> +		if (changed && !really_read_only) {
>  			int err2;
>  			err2 = ext4_commit_super(sb);
>  			err = err ? : err2;

Yes, this make sense. Earlier we were always doing ext4_commit_super()
even if es->s_state hasn't changed. But this code we only do
ext4_commit_super when there is a es->s_state change from orig_state.

-ritesh

> -- 
> 2.31.0
