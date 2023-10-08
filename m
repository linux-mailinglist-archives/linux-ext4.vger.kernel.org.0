Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAF97BD033
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Oct 2023 23:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJHVKN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Oct 2023 17:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjJHVKM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Oct 2023 17:10:12 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983C48F
        for <linux-ext4@vger.kernel.org>; Sun,  8 Oct 2023 14:10:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-65afac36b2cso20878766d6.3
        for <linux-ext4@vger.kernel.org>; Sun, 08 Oct 2023 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696799410; x=1697404210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkz0AfUaDSl+HOSH0TYrHpxGKOapfB+XAqHpuamca4k=;
        b=Bqa7+j/6JUimKByFrIY2fbkB1+Qm+LpiI5dneOkmloHtpfeHbKWDLdndGKPg575ecV
         1Kd+E2IMyWJ8SKZH0x5APJv69c5/pM7r4r59LVGqYzmlTDUfS4/cwx6uPjvsgKo5xeeb
         5jqU1/B7fC3SG4k7tL0SRL8OKDhbMZgB6QdwIPo3rWV7c5ITN5YUzAysMCb1lPPF2Q9H
         Tpr/owx4wN7Jag+aD9N2VGtcQXeUW5aABp4l1DTY9yQHMOqbJ3kco29fCbLPIc3Mgvgp
         hvNUluiic3tPZGKUEQycSp6cZ0e6Qgl26E+SLXpbdb/+MiiGU2YnzKxDKG0dzw+t1CX1
         vPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696799410; x=1697404210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkz0AfUaDSl+HOSH0TYrHpxGKOapfB+XAqHpuamca4k=;
        b=vW0kdS8DiMIQrJKpOCHZLWAPGl5ifzmtPero6xOBvHAsQXtOaXpqgp0litaT7hM87q
         T0LtYXrGkbNFkRV+fUYoeKKYjbWvJUNXCSwsaLfCjDj90THQtpI2eMFUrxCqlLj4Uc4l
         KtmBsRYd2OITTPxrqnEfHXLhN0lQOLSR4bwROFzDn/zVmrVPDuf22Eb/voS8f7TnvlYQ
         WHoB8hON/bq45MJPmvLzswiTdK4e1FSreKIlUrBPhHyRfeRceUmsGE/xryZITOr9XSg6
         FxbZCfsKkEjULbPdg4aeMHmJ3Jp4y3LpP9WXCZ7qLM/7A96mHIgZUwAnMOtZH3tqPXwm
         w6hQ==
X-Gm-Message-State: AOJu0YzH5Y2teV0cJShzTgzT5c9XSf2WwYZ0jKUL5OysAR49/NhJiwdy
        xXUw82ocvn6JE2feLfaZ2A4=
X-Google-Smtp-Source: AGHT+IFzfwIITrisULn3NorTC/3ibb+WUcssUkBsjjLH7rqsUYYCLq6dZbisO8TLIsBp8pcJlVAliw==
X-Received: by 2002:a0c:cd07:0:b0:65d:34d:8f3c with SMTP id b7-20020a0ccd07000000b0065d034d8f3cmr12720866qvm.44.1696799409659;
        Sun, 08 Oct 2023 14:10:09 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id c17-20020a05620a165100b0076cb3690ae7sm3026731qko.68.2023.10.08.14.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 14:10:09 -0700 (PDT)
Date:   Sun, 8 Oct 2023 17:10:07 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [RFC] ext4: don't remove already removed extent
Message-ID: <ZSMar4JjHUI+/zt6@debian-BULLSEYE-live-builder-AMD64>
References: <20230911094038.3602508-1-usama.anjum@collabora.com>
 <ZQo/nX82Cf1xQC5i@debian-BULLSEYE-live-builder-AMD64>
 <8a4b33c6-d27a-43ce-9d0a-8fdcc21a6448@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4b33c6-d27a-43ce-9d0a-8fdcc21a6448@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Muhammad Usama Anjum <usama.anjum@collabora.com>:
> On 9/20/23 5:41 AM, Eric Whitney wrote:
> > * Muhammad Usama Anjum <usama.anjum@collabora.com>:
> >> Syzbot has hit the following bug on current and all older kernels:
> >> BUG: KASAN: out-of-bounds in ext4_ext_rm_leaf fs/ext4/extents.c:2736 [inline]
> >> BUG: KASAN: out-of-bounds in ext4_ext_remove_space+0x2482/0x4d90 fs/ext4/extents.c:2958
> >> Read of size 18446744073709551508 at addr ffff888073aea078 by task syz-executor420/6443
> >>
> >> On investigation, I've found that eh->eh_entries is zero, ex is
> >> referring to last entry and EXT_LAST_EXTENT(eh) is referring to first.
> >> Hence EXT_LAST_EXTENT(eh) - ex becomes negative and causes the wrong
> >> buffer read.
> >>
> >> element: FFFF8882F8F0D06C       <----- ex
> >> element: FFFF8882F8F0D060
> >> element: FFFF8882F8F0D054
> >> element: FFFF8882F8F0D048
> >> element: FFFF8882F8F0D03C
> >> element: FFFF8882F8F0D030
> >> element: FFFF8882F8F0D024
> >> element: FFFF8882F8F0D018
> >> element: FFFF8882F8F0D00C	<------  EXT_FIRST_EXTENT(eh)
> >> header:  FFFF8882F8F0D000	<------  EXT_LAST_EXTENT(eh) and eh
> >>
> >> Cc: stable@vger.kernel.org
> >> Reported-by: syzbot+6e5f2db05775244c73b7@syzkaller.appspotmail.com
> >> Closes: https://groups.google.com/g/syzkaller-bugs/c/G6zS-LKgDW0/m/63MgF6V7BAAJ
> >> Fixes: d583fb87a3ff ("ext4: punch out extents")
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >> This patch is only fixing the local issue. There may be bigger bug. Why
> >> is ex set to last entry if the eh->eh_entries is 0. If any ext4
> >> developer want to look at the bug, please don't hesitate.
> >> ---
> >>  fs/ext4/extents.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> >> index e4115d338f101..7b7779b4cb87f 100644
> >> --- a/fs/ext4/extents.c
> >> +++ b/fs/ext4/extents.c
> >> @@ -2726,7 +2726,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
> >>  		 * If the extent was completely released,
> >>  		 * we need to remove it from the leaf
> >>  		 */
> >> -		if (num == 0) {
> >> +		if (num == 0 && eh->eh_entries) {
> >>  			if (end != EXT_MAX_BLOCKS - 1) {
> >>  				/*
> >>  				 * For hole punching, we need to scoot all the
> >> -- 
> >> 2.40.1
> >>
> > 
> > Hi:
> > 
> > First, thanks for taking the time to look at this.
> Thank you for replying and giving me pointers that I need to start looking
> at problem from first warning until the bug which can be difficult until I
> debug the problem smartly and learn at least the basics of ext4.
> 
> > 
> > I'm suspicious that syzbot may be fuzzing an extent header or other extent
> > tree components.  As you noticed, eh_entries and ex appear to be inconsistent.
> > Also, note the long series of corrupted file system reports in the console log
> > occurring before the KASAN bug - ext4 had been detecting and rejecting bad
> > data up to that point.  The file system on the disk image provided by sysbot
> > indicates that metadata checksumming was enabled (and it fscks cleanly).
> > That should have caught a corrupted extent header or inode, but perhaps
> > there's a problem.
> > 
> > The console log indicates that the problem occurred on inode #16.  Does the
> > information you've provided above come from testing you did on inode #16
> > (looks like the name was /bin/base64)?
> I couldn't analyze the problem in broad spectrum. There must be some bigger
> thing wrong here.
> 
> > 
> > By any chance, have you found a simpler reproducer than what syzbot provides?
> Not yet, this gets reproduced after a while. I'll try to come up with
> better reproducer if I can.
> 

My suggestion would be to first determine whether syzbot has disabled
metadata checksumming by the point in time when the problem occurs (or
whether temporarily modifying ext4 to make it impossible to disable
metadata checksumming also makes it impossible to reproduce the failure).
It may have done this as part of its test.  If so, this becomes a very low
priority bug for ext4, and you could avoid the effort to find a reproducer.

Eric
