Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E0379B593
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 02:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbjIKVU0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Sep 2023 17:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjIKJ5T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Sep 2023 05:57:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7AFE67;
        Mon, 11 Sep 2023 02:57:14 -0700 (PDT)
Received: from [192.168.239.158] (unknown [182.191.140.203])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2133966072F4;
        Mon, 11 Sep 2023 10:57:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694426233;
        bh=0N+FDH5z9szp/PjtzByqIq81sfNr/YB7TLbioWmeuX8=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=RV6bxxbUrVnYcz+Wdo5hmrV+Guw7rVAMzIq3kHY10hoH9LoCTK0SrfTxbrn1D5XOi
         rOYQhLx68y9YmiI4qrmQmn3ueZvSrWFHSYH5g8atBGg7CRLEHpS3HS/gW1Hq0aVt3B
         X3a9y2p0BwKys6fvGNUXZJn/gFb1bdJjk+SjyHknp+swm0raZc0GbnNz/4GnHV6kcv
         H41/JREAMO9vwK1lrJL+/3EXsSxn37e/SLaRBfe0aRQCBl5vBdZjOQUV+fAwfj8t3Y
         tq1t/CjxD/W6NPPaSmSmGKVZnpFghDcgkvHdnwaAybPXv1RLI5scBUCMgawDqvEifQ
         +Lq1vcPdKgWxw==
Message-ID: <4af6a370-6d31-4413-b78e-e693be5f01a9@collabora.com>
Date:   Mon, 11 Sep 2023 14:57:02 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, stable@vger.kernel.org,
        syzbot+6e5f2db05775244c73b7@syzkaller.appspotmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext4: don't remove already removed extent
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Allison Henderson <achender@linux.vnet.ibm.com>
References: <20230911094038.3602508-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230911094038.3602508-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Apologies for sending multiple copies of same email. There was some issue
on my side.

On 9/11/23 2:40 PM, Muhammad Usama Anjum wrote:
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

-- 
BR,
Muhammad Usama Anjum
