Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5DA77E3B7
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbjHPOfA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbjHPOey (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 10:34:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDB42716
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 07:34:51 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5657659a8a1so782626a12.1
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692196491; x=1692801291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NScA+PcQZhcEVersyfhdbefEy+tNTcLh+PJYZN6zQJY=;
        b=q/RxBKZSnukRvIDE0HYoCV4LgKpFAYqMpW+27qXlHUQKSf5Fs6m5Xttjc9/BTz0qFa
         EnYmRE/ypCWNUC825ADvHK0GyceBhxWCpdQkwcTireVpf7IktBoDQYYMQK10U0r1fPan
         ks2KyM/LgWV97fVodqrURGLMtPIZgVZsJZUuRRxf6PmivrG0xxd/Z1gPjXP0KEn4F0o9
         F17r0+ZduirB3SWwwcdEfG61OXZtdptrXD6aC5ClUKiFpUZ1KRYKYaESmqucnc14Blvc
         WPMgI0zGIL+g0WRCgsFGyPSdyqJgBqayLXujFx04YlFE0DfLqhb99btgSOQlz5U2VNzK
         YfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692196491; x=1692801291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NScA+PcQZhcEVersyfhdbefEy+tNTcLh+PJYZN6zQJY=;
        b=GQJMONvNrTX2KcQ91CCUdjiKothFZTShKp0vw4xHnXJFQNYX+W72xQI9ZYq/ctYjCb
         50iIIpw09lFNhMvNNqcGQ939TZZLnox6XW8Pps4Fp9TNvME/J4fmOEFCn0tYGIi4Z4lI
         TEjDbVTc8f2AuxcFFQLula7NxY6ccFEh3R37MhqWY2s2IFvKNKiU+l91sHsAf7pWNHfc
         JlKuyqjWxnt+9g/DW+TjiBm6JWseBwVgAMNaz+7riPMCjuQN7slVKdt/LpfR6FqoURIU
         Pby+nhGYX0Vum2KKK4Wu7wObnvpvmAkhf3/JDGEbl4L5RypXYs3I30HA/P6Jlm5J66SC
         o4tA==
X-Gm-Message-State: AOJu0YxC8PB4x3gkJjZ+aXHdp6YZ7939JOtu78nl/vLfV4YdLUEA9Pyy
        u0Gi2nLEfsm5Bg9EkbAFtrCQtA==
X-Google-Smtp-Source: AGHT+IG53xkS59ODIviBNRX/zHspgxoqmaG7VcA2xXmb5Q9LAQUUTyxr4spMWPcEPQPdtmxrEmfdaw==
X-Received: by 2002:a17:90a:3ee5:b0:26b:27f6:90cc with SMTP id k92-20020a17090a3ee500b0026b27f690ccmr1710801pjc.2.1692196491224;
        Wed, 16 Aug 2023 07:34:51 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y22-20020a1709027c9600b001b8a85489a3sm13164080pll.262.2023.08.16.07.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 07:34:50 -0700 (PDT)
Message-ID: <324fc71c-dead-4418-af81-6817e1f41c39@kernel.dk>
Date:   Wed, 16 Aug 2023 08:34:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Content-Language: en-US
To:     "Dr. David Alan Gilbert" <dave@treblig.org>,
        Theodore Ts'o <tytso@mit.edu>, hch@lst.de
Cc:     adilger.kernel@dilger.ca, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <ZNqWfQPTScJDkmpX@gallifrey> <20230815125146.GA1508930@mit.edu>
 <ZNt11WbPn7LCXPvB@gallifrey> <ZNu668KGiNcwCSVe@gallifrey>
 <ZNwm7Mo9yv7uIkno@gallifrey>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZNwm7Mo9yv7uIkno@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/15/23 7:31 PM, Dr. David Alan Gilbert wrote:
> (Copying in Christoph and Jens)
> 
> * Dr. David Alan Gilbert (dave@treblig.org) wrote:
>> * Dr. David Alan Gilbert (dave@treblig.org) wrote:
>>> * Theodore Ts'o (tytso@mit.edu) wrote:
>>>> On Mon, Aug 14, 2023 at 09:02:53PM +0000, Dr. David Alan Gilbert wrote:
>>>>> dg         29594   29592  0 18:40 pts/0    00:00:00 /usr/bin/ar --plugin /usr/libexec/gcc/x86_64-redhat-linux/13/liblto_plugin.so -csrDT src/intel/perf/libintel_perf.a src/intel/perf/libintel_perf.a.p/meson-generated_.._intel_perf_metrics.c.o src/intel/perf/libintel_perf.a.p/intel_perf.c.o src/intel/perf/libintel_perf.a.p/intel_perf_query.c.o src/intel/perf/libintel_perf.a.p/intel_perf_mdapi.c.o
>>>>>
>>>>> [root@dalek dg]# cat /proc/29594/stack 
>>>>> [<0>] md_super_wait+0xa2/0xe0
>>>>> [<0>] md_bitmap_unplug+0xd2/0x120
>>>>> [<0>] flush_bio_list+0xf3/0x100 [raid1]
>>>>> [<0>] raid1_unplug+0x3b/0xb0 [raid1]
>>>>> [<0>] __blk_flush_plug+0xd7/0x150
>>>>> [<0>] blk_finish_plug+0x29/0x40
>>>>> [<0>] ext4_do_writepages+0x401/0xc90
>>>>> [<0>] ext4_writepages+0xad/0x180
>>>>
>>>> If you want a few seconds and try grabbing cat /proc/29594/stack
>>>> again, what does the stack trace stay consistent as above?
>>>
>>> I'll get back to that and retry it.
>>
>> Yeh, the stack is consistent; this time around it's an 'ar' in a kernel
>> build:
>>
>> [root@dalek dg]# cat /proc/17970/stack
>> [<0>] md_super_wait+0xa2/0xe0
>> [<0>] md_bitmap_unplug+0xad/0x120
>> [<0>] flush_bio_list+0xf3/0x100 [raid1]
>> [<0>] raid1_unplug+0x3b/0xb0 [raid1]
>> [<0>] __blk_flush_plug+0xd7/0x150
>> [<0>] blk_finish_plug+0x29/0x40
>> [<0>] ext4_do_writepages+0x401/0xc90
>> [<0>] ext4_writepages+0xad/0x180
>> [<0>] do_writepages+0xd2/0x1e0
>> [<0>] filemap_fdatawrite_wbc+0x63/0x90
>> [<0>] __filemap_fdatawrite_range+0x5c/0x80
>> [<0>] ext4_release_file+0x74/0xb0
>> [<0>] __fput+0xf5/0x2a0
>> [<0>] task_work_run+0x5d/0x90
>> [<0>] exit_to_user_mode_prepare+0x1e6/0x1f0
>> [<0>] syscall_exit_to_user_mode+0x1b/0x40
>> [<0>] do_syscall_64+0x6c/0x90
>> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>> [root@dalek dg]# cat /proc/17970/stack
>> [<0>] md_super_wait+0xa2/0xe0
>> [<0>] md_bitmap_unplug+0xad/0x120
>> [<0>] flush_bio_list+0xf3/0x100 [raid1]
>> [<0>] raid1_unplug+0x3b/0xb0 [raid1]
>> [<0>] __blk_flush_plug+0xd7/0x150
>> [<0>] blk_finish_plug+0x29/0x40
>> [<0>] ext4_do_writepages+0x401/0xc90
>> [<0>] ext4_writepages+0xad/0x180
>> [<0>] do_writepages+0xd2/0x1e0
>> [<0>] filemap_fdatawrite_wbc+0x63/0x90
>> [<0>] __filemap_fdatawrite_range+0x5c/0x80
>> [<0>] ext4_release_file+0x74/0xb0
>> [<0>] __fput+0xf5/0x2a0
>> [<0>] task_work_run+0x5d/0x90
>> [<0>] exit_to_user_mode_prepare+0x1e6/0x1f0
>> [<0>] syscall_exit_to_user_mode+0x1b/0x40
>> [<0>] do_syscall_64+0x6c/0x90
>> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>
>>>> Also, if you have iostat installed (usually part of the sysstat
>>>> package), does "iostat 1" show any I/O activity on the md device?
>>
>> iostat is showing something odd, most devices are at 0,
>> except for 3 of the dm's that are stuck at 100% utilisation with
>> apparently nothing going on:
>>
>> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>>            0.06    0.00    0.03   53.06    0.00   46.84
>>
>> Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wkB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dkB/s   drqm/s  %drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
>> ...
>> dm-16            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00 100.00
>> dm-17            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00 100.00
>> dm-18            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
>> dm-19            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
>> dm-2             0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
>> dm-20            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00 100.00
>> ....
>>
>> dm-20 is the /dev/mapper/main-more which is the RAID on which the
>> fs runs, 16 and 17 are main-more_rmeta_0 and main-more_rimage_0
>> so something screwy is going on there.
> 
> I've just finished a bisect of this hang, and got to:
> 
> 615939a2ae734e3e68c816d6749d1f5f79c62ab7 is the first bad commit
> commit 615939a2ae734e3e68c816d6749d1f5f79c62ab7
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri May 19 06:40:48 2023 +0200
> 
>     blk-mq: defer to the normal submission path for post-flush requests
> 
>     Requests with the FUA bit on hardware without FUA support need a post
>     flush before returning to the caller, but they can still be sent using
>     the normal I/O path after initializing the flush-related fields and
>     end I/O handler.
> 
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>     Link: https://lore.kernel.org/r/20230519044050.107790-6-hch@lst.de
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

Can you try and pull in:

https://git.kernel.dk/cgit/linux/commit/?h=block-6.5&id=5ff3213a5387e076af2b87f796f94b36965e8c3a

and see if that helps?

-- 
Jens Axboe

