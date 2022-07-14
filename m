Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994F7575425
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 19:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbiGNRkM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 13:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiGNRkM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 13:40:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2544AD54
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 10:40:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y141so2485500pfb.7
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/pVu+X6Y7sPIHlVRuzDDpbAjT83u1f3ZnpFrT2GdbiQ=;
        b=G+UVHhB8pOCMxJCUor+r5jn+SlzMdqJuXuGcKyjEpgJalYbn6MfBLUmA9lRfahjtk2
         uryE6QKl0OP9PSeh8HI2oJB8ZdIZcS7oOM1Q885mC/Eb8FOMbMBphvw93CAFiYCEljG6
         iJW4j/mM1S60e7yAIEKj2NMhrD3YEEMR75bYEOW/4EdcsU5ExhDxpsv0Pe78Wf7gWZD3
         c6O8+46MjLkWXvOzN5W96ohQPZJTT8/NxvYNKWMOCRBLGOZng5af4PqHcjlkaxAXmf2g
         jax72LEEHwgYkczbxArkhPyb6mYIU2mNvA1MT+RTswaSHMfsgJVEoxN4FYWkGKKZHIPE
         2ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/pVu+X6Y7sPIHlVRuzDDpbAjT83u1f3ZnpFrT2GdbiQ=;
        b=m8fQ3uE5kJN8FZgp4ASIQAf8qeJYJbAuhOB9iygqlHkfKjR4IOT9ggZYLNegq5o8+1
         eSE14Vct/X4N0ujCWrDAhlHqQhXlJTXXAdBLTTvs0LJB12o+vHpIUTzcNElVz/D1EObw
         K+dltIpDQluHZxPppth0z/0/EOa0SG/F+v590Ake0oN3g2/pUTnZfncnnvIFO0XdrRJA
         pixVWgOVomboYJ070bz3ixc8f+IU2PUKoNr78egg1aYnamPzmCD8ZxpLML2PEMlj3Hde
         Rwl+l7fN2tFS8YfY+KqdylyoZCUWsc7RYGUlTfP/8FrxQVOedPGS1OWr2tIUKHEOeunK
         LrRA==
X-Gm-Message-State: AJIora/VDYOgoRtJtZr0ugMR8BMwK4pv0Sa6mDfCdkE1MnaIDbt3/+L7
        nkaJnqIByAZnIZiY8cnuWHVSYg==
X-Google-Smtp-Source: AGRyM1t59ax7eRsT5VzvoLqk/TfG+1hpDOvpAzDQfeS6z28FH4hddLyhBa+CskfcT7eJOzpFTRwSQw==
X-Received: by 2002:a63:78ce:0:b0:40c:3c04:e3d8 with SMTP id t197-20020a6378ce000000b0040c3c04e3d8mr8528810pgc.202.1657820410750;
        Thu, 14 Jul 2022 10:40:10 -0700 (PDT)
Received: from ?IPV6:2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225? ([2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225])
        by smtp.gmail.com with ESMTPSA id e12-20020a17090301cc00b0016bd67bc868sm1793350plh.210.2022.07.14.10.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:40:10 -0700 (PDT)
Message-ID: <249cfcb9-06ab-c75a-b416-e66252e71cc7@linaro.org>
Date:   Thu, 14 Jul 2022 10:40:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ext4: block range must be validated before use in
 ext4_mb_clear_bb()
Content-Language: en-US
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu,
        syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com
References: <20220714095300.ffij7re6l5n6ixlg@fedora>
 <20220714165903.58260-1-lczerner@redhat.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <20220714165903.58260-1-lczerner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 7/14/22 09:59, Lukas Czerner wrote:
> Block range to free is validated in ext4_free_blocks() using
> ext4_inode_block_valid() and then it's passed to ext4_mb_clear_bb().
> However in some situations on bigalloc file system the range might be
> adjusted after the validation in ext4_free_blocks() which can lead to
> troubles on corrupted file systems such as one found by syzkaller that
> resulted in the following BUG
> 
> kernel BUG at fs/ext4/ext4.h:3319!
> PREEMPT SMP NOPTI
> CPU: 28 PID: 4243 Comm: repro Kdump: loaded Not tainted 5.19.0-rc6+ #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
> RIP: 0010:ext4_free_blocks+0x95e/0xa90
> Call Trace:
>   <TASK>
>   ? lock_timer_base+0x61/0x80
>   ? __es_remove_extent+0x5a/0x760
>   ? __mod_timer+0x256/0x380
>   ? ext4_ind_truncate_ensure_credits+0x90/0x220
>   ext4_clear_blocks+0x107/0x1b0
>   ext4_free_data+0x15b/0x170
>   ext4_ind_truncate+0x214/0x2c0
>   ? _raw_spin_unlock+0x15/0x30
>   ? ext4_discard_preallocations+0x15a/0x410
>   ? ext4_journal_check_start+0xe/0x90
>   ? __ext4_journal_start_sb+0x2f/0x110
>   ext4_truncate+0x1b5/0x460
>   ? __ext4_journal_start_sb+0x2f/0x110
>   ext4_evict_inode+0x2b4/0x6f0
>   evict+0xd0/0x1d0
>   ext4_enable_quotas+0x11f/0x1f0
>   ext4_orphan_cleanup+0x3de/0x430
>   ? proc_create_seq_private+0x43/0x50
>   ext4_fill_super+0x295f/0x3ae0
>   ? snprintf+0x39/0x40
>   ? sget_fc+0x19c/0x330
>   ? ext4_reconfigure+0x850/0x850
>   get_tree_bdev+0x16d/0x260
>   vfs_get_tree+0x25/0xb0
>   path_mount+0x431/0xa70
>   __x64_sys_mount+0xe2/0x120
>   do_syscall_64+0x5b/0x80
>   ? do_user_addr_fault+0x1e2/0x670
>   ? exc_page_fault+0x70/0x170
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fdf4e512ace
> 
> Fix it by making sure that the block range is properly validated before
> used every time it changes in ext4_free_blocks() or ext4_mb_clear_bb().

That works for me. Once applied it will need to be ported to stable
kernels. I will take care of that. Thanks!

Tested-by: Tadeusz Struk <tadeusz.struk@linaro.org>

-- 
Thanks,
Tadeusz
