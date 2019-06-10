Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08303ADCA
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jun 2019 05:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbfFJDyj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Jun 2019 23:54:39 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:33319 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbfFJDyi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Jun 2019 23:54:38 -0400
Received: by mail-pf1-f169.google.com with SMTP id x15so4475076pfq.0
        for <linux-ext4@vger.kernel.org>; Sun, 09 Jun 2019 20:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eycaHKwjNhVgla3zln2jkG+dBMvDp9ZL+9upAhqi6V8=;
        b=n+in00v1j7Mjzq01z58S2zGghAi7PRdS96NC8ZBg4kYfQ8fbvlFBC5XQOXAQXxiI7T
         lfI/n03HaNeiIDr2r6bpaK+hMJoqRSNYtbD+Qi0PoJlMpuJ3GtZw1lC0UBaR1A+6easT
         0giKiogNlVyi11UHTQCAG0q+PB8H4lZF3ckEtyWP98XG3i6bMpl6a3IofXfpz1tZiJCm
         CsA2+EEKqOBw+NZTRyKgJW4ZFYs15mBYO4Kl/wKxp63JwfwFd4K/LRDITCLZiZ5C9tnl
         +IqZt/txCAjYO41ur044YJC+dC6KxmFpf8BodNoXxOmCNJzORiM6ecUm3RrVEXKexnaM
         fcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eycaHKwjNhVgla3zln2jkG+dBMvDp9ZL+9upAhqi6V8=;
        b=LRnIzPYmLKb8F4TrU2WrRSH8dNLtQK1ZpxEhdFQG18VEsR2SsEhQcINo7EtGTw7zSD
         GAsFCEQFYacaoF+UsrZ/bn9Lfoy5YJNc9JpDkiy5xkp4XW3PEeOKtrtJneeS8Z9tstQd
         +5wkRh7lc8OXzyh68BiFglWj9EX3OfWYKw6DdXHUh78Glo+ZSam6j76STFqtIMy6hs1i
         xPYb6yqxUG89Z8w3xz60hVFaL/AyRR3rk+bq9ZqzVhndod5/ah4oxXTdNXf0ilTOnE1g
         H6iWKyVNnd3Uehnc38UGMwDfEWAoYYub/HA0jWLAqBfU5O7tptobV8r8AEKD8L7tRobC
         mUFg==
X-Gm-Message-State: APjAAAU/mqHn+rYRL669Fhopwi+lk36r38QlqKmLe3NJzdgvFsjWJ1Nw
        E/9Tz6A28Bl2hSLtfmX0FPQ=
X-Google-Smtp-Source: APXvYqxkZJByCO7rnRqzU84KYVgKuDr8Erng8HEqv6TAiUQIz4mmapEbuq2BOrHdOv+3V3k/QyQ9eg==
X-Received: by 2002:a62:5387:: with SMTP id h129mr74213486pfb.6.1560138878028;
        Sun, 09 Jun 2019 20:54:38 -0700 (PDT)
Received: from [0.0.0.0] ([47.244.216.228])
        by smtp.gmail.com with ESMTPSA id l38sm8446873pje.12.2019.06.09.20.54.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 20:54:37 -0700 (PDT)
Subject: Re: [HELP] What are the allocated blocks on a newly created ext4 fs ?
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
References: <b64110a4-8112-a230-2179-5095aa943af9@gmail.com>
 <7FD3148B-1E27-4BFA-965C-9FDC7FC8FD96@gmail.com>
 <22ccd72a-8926-0d12-0fbe-8ad5604d1584@gmail.com>
 <20190610033927.GA15963@mit.edu>
From:   Jianchao Wang <jianchao.wan9@gmail.com>
Message-ID: <683bc83a-a56d-1ecf-aa3d-5aa0aa3ac289@gmail.com>
Date:   Mon, 10 Jun 2019 11:54:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190610033927.GA15963@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/6/10 11:39, Theodore Ts'o wrote:
> On Mon, Jun 10, 2019 at 11:25:47AM +0800, Jianchao Wang wrote:
>> Hi Artem 
>>
>> Thanks so much for your help.
>>
>> On 2019/6/6 20:32, Artem Blagodarenko wrote:
>>> Hello Jianchao,
>>>
>>> Not enought input data to give an answer. It depends on mkfs options. For example, if flex_bg option is enabled, then several block groups are tied together as one logical block group; the bitmap spaces and the inode table space in the first block group, so some groups are not totally free just after FS creating.
>>
>> In my environment, there are 16 bgs per flex_bg.
>> The bitmaps and inode table .etc should lay on the first bg of every flex_bg.
>> So I can see there are about 8223 blocks allocated in the 1st bg of every flex_bg.
>>
>> But as you can see in the output of mb_groups, there are some bgs
>> which get allocated about 1024 blocks.
>>
>> I have out figured out what are they for.
> 
> The best way to understand what the blocks are used for is to use the
> dumpe2fs program, e.g:
> 
> % mke2fs -t ext4 -Fq /tmp/foo.img 1T
> % dumpe2fs /tmp/foo.img | more
>     ...
> Group 0: (Blocks 0-32767) csum 0xe6f6 [ITABLE_ZEROED]
>   Primary superblock at 0, Group descriptors at 1-128
>   Reserved GDT blocks at 129-1152
>   Block bitmap at 1153 (+1153), csum 0xb033995a
>   Inode bitmap at 1169 (+1169), csum 0x108d3d73
>   Inode table at 1185-1696 (+1185)
>   23385 free blocks, 8181 free inodes, 2 directories, 8181 unused inodes
>   Free blocks: 9383-32767
>   Free inodes: 12-8192
> Group 1: (Blocks 32768-65535) csum 0xe50b [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
>   Backup superblock at 32768, Group descriptors at 32769-32896
>   Reserved GDT blocks at 32897-33920
>   Block bitmap at 1154 (bg #0 + 1154), csum 0x00000000
>   Inode bitmap at 1170 (bg #0 + 1170), csum 0x00000000
>   Inode table at 1697-2208 (bg #0 + 1697)
>   31615 free blocks, 8192 free inodes, 0 directories, 8192 unused inodes
>   Free blocks: 33921-65535
>   Free inodes: 8193-16384
>     ...
> 

Hi Ted

Many thanks for your help

These allocated blocks should be the reserved GDT blocks.

Many thanks again.
Jianchao

