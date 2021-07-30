Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780B03DB9DA
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jul 2021 15:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbhG3N57 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Jul 2021 09:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbhG3N56 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Jul 2021 09:57:58 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E3DC06175F
        for <linux-ext4@vger.kernel.org>; Fri, 30 Jul 2021 06:57:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h14so18070553lfv.7
        for <linux-ext4@vger.kernel.org>; Fri, 30 Jul 2021 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id
         :disposition-notification-to:date:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b2p0ukoxUQwDd5MGHHSymt9vdtnBMHaIOemseo8wkeU=;
        b=iqBcV6vq/mFxX8rQBApjKmUGvPWBoTEob5GWaWM2F7e+N10veW5s0xtjkOpmQkv6c7
         Vq5/jH9jqVBEGHDIK8rWsWuvcSaWN9DdWoMErkrr7ISphoIcDYqe7aUByag7fuRlcWeJ
         dI1TW3FB07N/k6SiHY0UGCEpbLCeYMkngKMaQz09rtfqgxgHvqGzees/Pwf3RU1+Yrft
         lGrVXfmkljigm9HwEBK6h57mdL9Sr8OEhBpO5++wDySSRQXWc5CqNOvVSxNnwkMQsGLU
         RpNUl+63tbRTjriZdj+xjVY2ahq+yzzkzneh6vSnGXYhg24UeF6hPamflxOi1yHWi1Tf
         fLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id
         :disposition-notification-to:date:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b2p0ukoxUQwDd5MGHHSymt9vdtnBMHaIOemseo8wkeU=;
        b=kCMVlAdJRaNnpilJ8mHsCfhZXtP5JZl5J75+XF9ryFPVTZ2rXP8b/YFqf8Mh3JsXAS
         z88TUG03ZSdP69TMK2dljwbwNwzeeCUjX5gQ2m1DKZCa3u9rZzuVLLlmaFFcjoFBgzBb
         wZAKL7NT74rLoFOm+FZf3A1Dy5gGyMEcxjQCxIUB0NO6p+Qdn/mX1YEGCXSHbcFTc+4d
         zLWakoP5g1Jd/DhyvvVgWeqFy4DMp5nQk0lqkZ1qtZa5cMmhiKnV1kjZetLpwxlwVEel
         CPPFbuQGHtLAUxFORvFOtzKC0LPz2iEnPAwgg20DwMN84Z/ueN/IaBmM6SFYjESS8kgY
         dLbg==
X-Gm-Message-State: AOAM5328Bbfs48DG1PapPqz8C3IGoUvZvnbZ7eWyz4rpEQK4+K/jHQZx
        l8adVdZoYlw5gG+agDw6nLCTanGZ7ko=
X-Google-Smtp-Source: ABdhPJySDeJXC8ZmD9uBotpKIPN6/6h5POv7uGyz281F/J3+tzX1wa+69u3GhGYdtMB1GQC7/UoN4Q==
X-Received: by 2002:a05:6512:31c8:: with SMTP id j8mr2103630lfe.458.1627653472525;
        Fri, 30 Jul 2021 06:57:52 -0700 (PDT)
Received: from localhost (public-gprs548858.centertel.pl. [37.225.7.59])
        by smtp.gmail.com with ESMTPSA id q15sm158845lfd.94.2021.07.30.06.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 06:57:51 -0700 (PDT)
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <0dc45cbd-b3b0-97ab-66a9-f68331cb483e@gmail.com>
 <YQCQODCGtJRTKwS9@mit.edu> <ba95a978-18af-794a-4c9d-a8406ade31ae@gmail.com>
 <YQLsl7s/GcgMGi47@mit.edu>
From:   Mikhail Morfikov <mmorfikov@gmail.com>
Subject: Re: Is it safe to use the bigalloc feature in the case of ext4
 filesystem?
Message-ID: <1aa38330-eaed-ab37-b941-203d970a7727@gmail.com>
Date:   Fri, 30 Jul 2021 15:57:49 +0200
MIME-Version: 1.0
In-Reply-To: <YQLsl7s/GcgMGi47@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I have a question concerning the *hugefiles* parameters. When a 
filesystems is created using the hugefiles stanza, it also creates 
lots of chunk-* files inside of the /storage/ dir. You say that it 
guarantees the huge files to be 100% contiguous. But if I create 
the filesystem with the preallocated files that consume the whole 
drive, how am I suppose to use that drive? :) Are the files only
temporary, and should they be removed once the filesystem is 
"ready"? What's the purpose of such options? Do they affect the 
EXT4 metadata in some way? I mean, what's the change compared to 
not using the options?

Also I have a question concerning the hugefiles stanza 
itself -- it's missing the bigalloc feature, should it be there?


On 29/07/2021 19.59, Theodore Ts'o wrote:
>...
> If you see the hugefile and hugefiles stanzas below, that's an example
> of one way bigalloc has gotten a fair amount of use.  In this use case
> mke2fs has pre-allocated the huge data files guaranteeing that they
> will be 100% contiguous.  We're using a 32k cluster becuase there are
> some metadata files where better allocation efficiencies is desired.
> 
>...
>
> 	hugefiles = {
> 		features = extent,huge_file,flex_bg,uninit_bg,dir_nlink,extra_isize,^resize_inode,sparse_super2
> 		hash_alg = half_md4
> 		reserved_ratio = 0.0
> 		num_backup_sb = 0
> 		packed_meta_blocks = 1
> 		make_hugefiles = 1
> 		inode_ratio = 4194304
> 		hugefiles_dir = /storage
> 		hugefiles_name = chunk-
> 		hugefiles_digits = 5
> 		hugefiles_size = 4G
> 		hugefiles_align = 256M
> 		hugefiles_align_disk = true
> 		zero_hugefiles = false
> 		flex_bg_size = 262144
> 	}
> 
> 	hugefile = {
> 		features = extent,huge_file,bigalloc,flex_bg,uninit_bg,dir_nlink,extra_isize,^resize_inode,sparse_super2
> 		cluster_size = 32768
> 		hash_alg = half_md4
> 		reserved_ratio = 0.0
> 		num_backup_sb = 0
> 		packed_meta_blocks = 1
> 		make_hugefiles = 1
> 		inode_ratio = 4194304
> 		hugefiles_dir = /storage
> 		hugefiles_name = huge-file
> 		hugefiles_digits = 0
> 		hugefiles_size = 0
> 		hugefiles_align = 256M
> 		hugefiles_align_disk = true
> 		num_hugefiles = 1
> 		zero_hugefiles = false
> 	}
