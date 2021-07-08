Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854713BF454
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jul 2021 05:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhGHDsV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jul 2021 23:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhGHDsV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jul 2021 23:48:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBCBC061574
        for <linux-ext4@vger.kernel.org>; Wed,  7 Jul 2021 20:45:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t15so5607957wry.11
        for <linux-ext4@vger.kernel.org>; Wed, 07 Jul 2021 20:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=famzah-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=L7TV9HRQGJcCM/M1kpARQ74d2LO3GdmS7EU/qNCb7As=;
        b=MjK+tYMl3bcg194QCKxmtVCrvsn8LjLfReI1NHKmULCErk4r6KUFpsLwQhKlCOueym
         SRJawCGb8fEOrttF9llkvdtutJVp6QD+C2UTKCjN5ScH/yTY3YRSMlBbBJWQvwkBMYlQ
         B098WQAY+VzfOuObnGbO5CdF+orWMvV1w1mHUEyxcpWfV3ej+zn1C03oSiFKjh466Dc8
         XohpNcpu6hmP5Od5THcLe+AOEuWuo/AIZBm3fZzj0ZMIUmZCtJGzYJvP7Kp51auDkP0T
         iY7vuYgCexmDXvJCtSJd2RGWTbz/qwgLLz8gPTJLlpKLsM1E0Kj93DHx0aIfahxHEk3n
         L55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L7TV9HRQGJcCM/M1kpARQ74d2LO3GdmS7EU/qNCb7As=;
        b=ILhqsI5ZYXdoeoqXA3Iu1U39Ps9REQKZ1B/c1akuApu44g45iK7R0Buz7AxuL3SvOp
         Jg8ltwVZl8mo+FkkRr7wgrw30xRGup7cokEGJV0TDH3UD4N5DvifBNbgJ4agbazV5ngN
         dFErUZd0+e5U8lit225eh0vDlOxJ+N9Zn4KfISnpPHtkS3kintcm8MpABa+Mb0AdsW5Y
         vVpvrzz8F4QTIEb0ejaeP/MTWeswERHs9UKtLr89HSQ/cXiGeDwDoA4AKVzgODPkmT0q
         LQwd210ZpvkuLe59h+ArTJySsFjc+PfgKcCrYfSK2rLXD1sMYnhm9wYld5Kewn0emdOk
         OOQA==
X-Gm-Message-State: AOAM5306pUO3dSYYsSxEFffxHGYYAklpcRpCra5x9WS6Vjxd58xpMBLH
        /EaeOJpKBzOC0hTu11zrxDv2Dw==
X-Google-Smtp-Source: ABdhPJxMz5lHzaLCh/vAVc7YdYaFHz8Rl9QwizqSXWmMg0pMDvEZChRcjq3Odm9KMbGadzAJeU3BjA==
X-Received: by 2002:adf:e610:: with SMTP id p16mr31983342wrm.13.1625715937286;
        Wed, 07 Jul 2021 20:45:37 -0700 (PDT)
Received: from [192.168.190.220] ([130.204.22.70])
        by smtp.googlemail.com with ESMTPSA id j16sm701055wrw.62.2021.07.07.20.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 20:45:36 -0700 (PDT)
Subject: Re: jbd2: fix deadlock while checkpoint thread waits commit thread to
 finish (backport to 4.14)
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <3221ced0-e8f3-53da-3474-28367272f35d@famzah.net>
 <YOY+SXgPShxGzyJO@mit.edu>
From:   Ivan Zahariev <famzah@famzah.net>
Message-ID: <44dd99fc-11ce-6a73-20bd-6ee645c5dd5e@famzah.net>
Date:   Thu, 8 Jul 2021 06:45:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOY+SXgPShxGzyJO@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Out of thousand machines, one would trigger the problem about every 1 to 
10 days. Some machines trigger the problem much often than others. So I 
can say that we have a way to verify quickly if applying the patch will 
fix this for us.

The most important question is: Is it safe to apply the patch on 
production machines with kernel 4.14?

We can't risk data loss. And I lack the expertise to asses what risks 
this small patch brings.

Best regards.
--Ivan

On 8.7.2021 г. 2:52, Theodore Ts'o wrote:
> On Wed, Jul 07, 2021 at 09:42:25PM +0300, Ivan Zahariev wrote:
>> Hello,
>>
>> We're running Linux kernel 4.14.x and our systems occasionally suffer a bug
>> which is already fixed: https://github.com/torvalds/linux/commit/53cf978457325d8fb2cdecd7981b31a8229e446e
>>
>> This bugfix hasn't been ported to Linux kernels 4.14 or 4.19. The patch
>> applies cleanly. The two files "fs/jbd2/checkpoint.c" and
>> "fs/jbd2/journal.c" seem pretty identical in the affected sections compared
>> to kernel 5.4 where we have this bugfix already applied.
>>
>> Is it on purpose that this bugfix hasn't been ported to 4.14? Is it safe
>> that we backport it manually in our kernel 4.14 builds? Or is the "ext4"
>> system in 4.14 and 5.4 fundamentally different and this would lead to data
>> loss or other problems?
> The commit was over two years ago, so my memory is not going to be
> perfect.  However, Jan had made a comment suggesting the approach in
> this commit because it should be easier to backport into older stble
> kernels[1].
>
>     "Since proper locking change is going to be a bit more involved, can you
>      perhaps fix this deadlock by just dropping j_checkpoint_mutex in
>      log_do_checkpoint() when we are going to wait for transaction commit. I've
>      checked and that should be fine and that is going to be much easier change
>      to backport into stable kernels..."
>
> [1] https://marc.info/?l=linux-ext4&m=154212553014669&w=2
>
> So I suspect it was just that I failed to remember to add a "Cc:
> stable@kernel.org" and so it was never automatically backported into
> 4.14 or 4.19.
>
> Do you have a reliable reproduction which is triggering the deadlock
> on your kernels?  If so, have you tried applying the patch and does it
> make the problem go away for you?
>
> Cheers,
>
> 						- Ted
