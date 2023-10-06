Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255287BB59D
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjJFKrz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 06:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjJFKry (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 06:47:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B50CA
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 03:47:53 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.184.141])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 03FF66612212;
        Fri,  6 Oct 2023 11:47:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696589272;
        bh=7gBFf6NWqP6XqBx6y090zR5/QITvjmucqTQaatKVQyE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ntky7VzS7JEENGsNYcVVnOqz2QaNLmjjdZwndEUW+kYWpFfwVX4+FeMP4HifLCxxv
         lZXXSspJl56rDat0489ZWOo6TITcEBd+y3LL7y3xetihskqtbeVliRM55MiNTm0/JZ
         6WzcAnKk0mYV3DLpNreEa18T3odGufjKwwYGC/hMx+ZePPK8Veq3bdhUUXeaknomMT
         T8WvXSSfT24IflKqgFd0Ujmyo/7jJQvCneCyBUCz+wKZbnVk4baH3mJB9zhdq7sAeY
         M4fJLaZyFxeygVR8lrhePFov67d0Gncm6g6H7JwEYmUaMhYnsM4NxcKCoM1IN6G8qK
         xPjYctq0GGQ4Q==
Message-ID: <8a4b33c6-d27a-43ce-9d0a-8fdcc21a6448@collabora.com>
Date:   Fri, 6 Oct 2023 15:47:46 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [RFC] ext4: don't remove already removed extent
Content-Language: en-US
To:     Eric Whitney <enwlinux@gmail.com>
References: <20230911094038.3602508-1-usama.anjum@collabora.com>
 <ZQo/nX82Cf1xQC5i@debian-BULLSEYE-live-builder-AMD64>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZQo/nX82Cf1xQC5i@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 9/20/23 5:41 AM, Eric Whitney wrote:
> * Muhammad Usama Anjum <usama.anjum@collabora.com>:
>> Syzbot has hit the following bug on current and all older kernels:
>> BUG: KASAN: out-of-bounds in ext4_ext_rm_leaf fs/ext4/extents.c:2736 [inline]
>> BUG: KASAN: out-of-bounds in ext4_ext_remove_space+0x2482/0x4d90 fs/ext4/extents.c:2958
>> Read of size 18446744073709551508 at addr ffff888073aea078 by task syz-executor420/6443
>>
>> On investigation, I've found that eh->eh_entries is zero, ex is
>> referring to last entry and EXT_LAST_EXTENT(eh) is referring to first.
>> Hence EXT_LAST_EXTENT(eh) - ex becomes negative and causes the wrong
>> buffer read.
>>
>> element: FFFF8882F8F0D06C       <----- ex
>> element: FFFF8882F8F0D060
>> element: FFFF8882F8F0D054
>> element: FFFF8882F8F0D048
>> element: FFFF8882F8F0D03C
>> element: FFFF8882F8F0D030
>> element: FFFF8882F8F0D024
>> element: FFFF8882F8F0D018
>> element: FFFF8882F8F0D00C	<------  EXT_FIRST_EXTENT(eh)
>> header:  FFFF8882F8F0D000	<------  EXT_LAST_EXTENT(eh) and eh
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: syzbot+6e5f2db05775244c73b7@syzkaller.appspotmail.com
>> Closes: https://groups.google.com/g/syzkaller-bugs/c/G6zS-LKgDW0/m/63MgF6V7BAAJ
>> Fixes: d583fb87a3ff ("ext4: punch out extents")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> This patch is only fixing the local issue. There may be bigger bug. Why
>> is ex set to last entry if the eh->eh_entries is 0. If any ext4
>> developer want to look at the bug, please don't hesitate.
>> ---
>>  fs/ext4/extents.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index e4115d338f101..7b7779b4cb87f 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -2726,7 +2726,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
>>  		 * If the extent was completely released,
>>  		 * we need to remove it from the leaf
>>  		 */
>> -		if (num == 0) {
>> +		if (num == 0 && eh->eh_entries) {
>>  			if (end != EXT_MAX_BLOCKS - 1) {
>>  				/*
>>  				 * For hole punching, we need to scoot all the
>> -- 
>> 2.40.1
>>
> 
> Hi:
> 
> First, thanks for taking the time to look at this.
Thank you for replying and giving me pointers that I need to start looking
at problem from first warning until the bug which can be difficult until I
debug the problem smartly and learn at least the basics of ext4.

> 
> I'm suspicious that syzbot may be fuzzing an extent header or other extent
> tree components.  As you noticed, eh_entries and ex appear to be inconsistent.
> Also, note the long series of corrupted file system reports in the console log
> occurring before the KASAN bug - ext4 had been detecting and rejecting bad
> data up to that point.  The file system on the disk image provided by sysbot
> indicates that metadata checksumming was enabled (and it fscks cleanly).
> That should have caught a corrupted extent header or inode, but perhaps
> there's a problem.
> 
> The console log indicates that the problem occurred on inode #16.  Does the
> information you've provided above come from testing you did on inode #16
> (looks like the name was /bin/base64)?
I couldn't analyze the problem in broad spectrum. There must be some bigger
thing wrong here.

> 
> By any chance, have you found a simpler reproducer than what syzbot provides?
Not yet, this gets reproduced after a while. I'll try to come up with
better reproducer if I can.

> 
> Thanks,
> Eric
> 
> 

-- 
BR,
Muhammad Usama Anjum
