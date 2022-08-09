Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C1F58D532
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 10:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiHIIM5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 04:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiHIIM4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 04:12:56 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE87EB7D1;
        Tue,  9 Aug 2022 01:12:54 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id b96so14238874edf.0;
        Tue, 09 Aug 2022 01:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bfhpdBf9mMKSbuiJfy4rarhtFq4lToUv1af8epZ9Sgs=;
        b=knAfTmtMAvTjA8sOM7Dp8eBeUmZ3SKl8qjmvBtscVVLmlhas+Byy8DpIbQ5tVA6h84
         Ik2smagUz0a+LIQAvkDoNt+6yNK8IrVzz7JNki9Us0Gl6VjyHg5P3hEjnHWW6PJRB6zi
         M094y81gxoGCweScGXtiZpjkQB4N44swTvrujl7/GuydWDvwoqoHkwoaewahS9spZwkP
         bwb9xIEr4+6i7tz7AS25kSD1vRTbZ1EQoUnhah0NtREorH6YxYLXSPx8JnxXyzY7mEfe
         HBB0SpbMvNZOoxqZM4L1rkRVdDipJ+vXhJE0u3sU5yeW+shOmqEgdRdwFlRAGOcpJdB3
         GklA==
X-Gm-Message-State: ACgBeo3gS/lu+fm2k699GKGRNKcbqf+YpScy2HT/LZP3HFlo+inynXBr
        T5kffoOwo1Q36MUAMDvqxrQ=
X-Google-Smtp-Source: AA6agR4kxo3Sx51N9iYvHZrLIGhmkILLl9NR0tsJH+phmGVFW7UWlLhn0MF+L45aoNzTOS3vEuaBHw==
X-Received: by 2002:a05:6402:11d1:b0:43e:33b:93fa with SMTP id j17-20020a05640211d100b0043e033b93famr21114498edw.419.1660032773476;
        Tue, 09 Aug 2022 01:12:53 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id ku19-20020a170907789300b00730b5a35288sm805901ejc.214.2022.08.09.01.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 01:12:53 -0700 (PDT)
Message-ID: <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
Date:   Tue, 9 Aug 2022 10:12:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: ext2/zram issue [was: Linux 5.19]
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jan Kara <jack@suse.com>, Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        avromanov@sberdevices.ru, ddrokosov@sberdevices.ru
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
In-Reply-To: <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 09. 08. 22, 9:59, Jiri Slaby wrote:
> Ah, now I can. It's easy when one lowers memory available to qemu. -m 
> 800M in this case:
> echo $((1000*1024*1024)) > /sys/block/zram0/disksize
> mkfs.ext2 /dev/zram0
> mount /dev/zram0 /mnt/a/
> dd if=/dev/urandom of=/mnt/a/stuff
> [  200.334277][    T8] EXT4-fs warning (device zram0): ext4_end_bio:343: 
> I/O error 10 writing to inode 12 starting block 8192)
> [  200.340198][    T8] Buffer I/O error on device zram0, logical block 8192
> 
> 
> So currently, I blame:
> commit e7be8d1dd983156bbdd22c0319b71119a8fbb697
> Author: Alexey Romanov <avromanov@sberdevices.ru>
> Date:   Thu May 12 20:23:07 2022 -0700
> 
>      zram: remove double compression logic
> 
> 
> /me needs to confirm.

With that commit reverted, I see no more I/O errors, only oom-killer 
messages (which is OK IMO, provided I write 1G of urandom on a machine 
w/ 800M of RAM):
[   30.424603][  T728] dd invoked oom-killer: 
gfp_mask=0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), order=0, oom_score_adj=0

Now let me submit it to openQA too...

thanks,
-- 
js
suse labs

