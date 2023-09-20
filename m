Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C937A6FEE
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Sep 2023 02:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjITAlL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 20:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITAlK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 20:41:10 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F6AB
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 17:41:05 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76ee895a3cbso410499585a.0
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 17:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695170464; x=1695775264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ+OJDO9Gpw6b3BwF7SnzNOyE85w/s1i843p0gnqUY0=;
        b=Vr9PRyJuELhKmXqWUSpyZAr64CN4+TTnOnIaJJQlDllN3HhEKP5pSKP7mrGt+oZ/0M
         8PtA3vy1O7zZmh9tZeUfurlKwZAL2DieKVmw4YOeiBviHYpSVnFDHcyAgSaTEfAQuAS6
         KThHBTf8CBq4xhiXjrFj7Ei8yxKfMdN+IO5L6qHBXvyhfDOcRtrFB++fYpifltmoua3v
         aNwB+KoYLhFF5Yso3txbTeplu34GSGgwoum878NHfUJV03wzdbDibt7jm3fPP4IyTaGl
         UyCqvhERFqq8hBYQEkVjPr4IqxItMPnyqIIFgOuH8uaqs8gc2yZ/jSVFhpYrvtigi3BS
         efDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695170464; x=1695775264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQ+OJDO9Gpw6b3BwF7SnzNOyE85w/s1i843p0gnqUY0=;
        b=V9HED+L3NX0lP8QiwAVe6AwV7hrZFuGg3rhiQ17V7sGprV41FCBDmfY+Q2FM+rkzFE
         t3epEw6xljoIndMTlITDjhV4w14Dglp1Xrd4kc+uv5Hiq5CRWK45I9etTuNg0QpX3mmH
         e1Aeg4TxBQqhryPJlgH0b7pl3JJ74s8JhFuiKO4RstXSoEHL1dlHaaiIu5g4KvVR+To0
         tq0Yv5Zo12KKLDhJTJGGgUE73blPXLlbVm+BL7M7BhEge5ysaCSNp33/QRhhIakEoapL
         Jh8bnVbvK+Xkdu+EdyP78c2rvkqzauan/ByyQ8W5DTaM7bnTDCUJYoJoBOmFXFYVS+L6
         HDZw==
X-Gm-Message-State: AOJu0YzuJFR7+LEb6WCotEuy2FduR7tl1ff6cFavv6tqUAQXPwtJYPYW
        91OEPbI4ErCTZbQE8HcrRAU=
X-Google-Smtp-Source: AGHT+IFBBihJbOE3cOo+Av5W9sKAQMHU/9Ttlw9bklDEKB8IfGTmbxpX4b9oQgFXKRCtQl95n38B6Q==
X-Received: by 2002:a05:620a:2a0b:b0:76e:f2df:1585 with SMTP id o11-20020a05620a2a0b00b0076ef2df1585mr1680423qkp.56.1695170463979;
        Tue, 19 Sep 2023 17:41:03 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a071000b007671b599cf5sm4393348qkc.40.2023.09.19.17.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 17:41:03 -0700 (PDT)
Date:   Tue, 19 Sep 2023 20:41:01 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [RFC] ext4: don't remove already removed extent
Message-ID: <ZQo/nX82Cf1xQC5i@debian-BULLSEYE-live-builder-AMD64>
References: <20230911094038.3602508-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911094038.3602508-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Muhammad Usama Anjum <usama.anjum@collabora.com>:
> Syzbot has hit the following bug on current and all older kernels:
> BUG: KASAN: out-of-bounds in ext4_ext_rm_leaf fs/ext4/extents.c:2736 [inline]
> BUG: KASAN: out-of-bounds in ext4_ext_remove_space+0x2482/0x4d90 fs/ext4/extents.c:2958
> Read of size 18446744073709551508 at addr ffff888073aea078 by task syz-executor420/6443
> 
> On investigation, I've found that eh->eh_entries is zero, ex is
> referring to last entry and EXT_LAST_EXTENT(eh) is referring to first.
> Hence EXT_LAST_EXTENT(eh) - ex becomes negative and causes the wrong
> buffer read.
> 
> element: FFFF8882F8F0D06C       <----- ex
> element: FFFF8882F8F0D060
> element: FFFF8882F8F0D054
> element: FFFF8882F8F0D048
> element: FFFF8882F8F0D03C
> element: FFFF8882F8F0D030
> element: FFFF8882F8F0D024
> element: FFFF8882F8F0D018
> element: FFFF8882F8F0D00C	<------  EXT_FIRST_EXTENT(eh)
> header:  FFFF8882F8F0D000	<------  EXT_LAST_EXTENT(eh) and eh
> 
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+6e5f2db05775244c73b7@syzkaller.appspotmail.com
> Closes: https://groups.google.com/g/syzkaller-bugs/c/G6zS-LKgDW0/m/63MgF6V7BAAJ
> Fixes: d583fb87a3ff ("ext4: punch out extents")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> This patch is only fixing the local issue. There may be bigger bug. Why
> is ex set to last entry if the eh->eh_entries is 0. If any ext4
> developer want to look at the bug, please don't hesitate.
> ---
>  fs/ext4/extents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e4115d338f101..7b7779b4cb87f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2726,7 +2726,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
>  		 * If the extent was completely released,
>  		 * we need to remove it from the leaf
>  		 */
> -		if (num == 0) {
> +		if (num == 0 && eh->eh_entries) {
>  			if (end != EXT_MAX_BLOCKS - 1) {
>  				/*
>  				 * For hole punching, we need to scoot all the
> -- 
> 2.40.1
> 

Hi:

First, thanks for taking the time to look at this.

I'm suspicious that syzbot may be fuzzing an extent header or other extent
tree components.  As you noticed, eh_entries and ex appear to be inconsistent.
Also, note the long series of corrupted file system reports in the console log
occurring before the KASAN bug - ext4 had been detecting and rejecting bad
data up to that point.  The file system on the disk image provided by sysbot
indicates that metadata checksumming was enabled (and it fscks cleanly).
That should have caught a corrupted extent header or inode, but perhaps
there's a problem.

The console log indicates that the problem occurred on inode #16.  Does the
information you've provided above come from testing you did on inode #16
(looks like the name was /bin/base64)?

By any chance, have you found a simpler reproducer than what syzbot provides?

Thanks,
Eric


