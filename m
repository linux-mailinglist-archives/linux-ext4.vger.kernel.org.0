Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44E4133CAD
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2020 09:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgAHILT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jan 2020 03:11:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44353 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgAHILT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jan 2020 03:11:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so1169379pgl.11
        for <linux-ext4@vger.kernel.org>; Wed, 08 Jan 2020 00:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rUue1DCP3hEjtK7CuLTd3s374OML36ouGMsr5aZSPss=;
        b=OhpmP9mgnxi17cddtcq/09MRP4EMn/tQyWa1Ifia6Nef6hMwj1ZXh0Gx2RvIyftTyL
         Oe1LRIPK5WkDjxfQkNL/hbvEVnFnApltAgK2NFpwjr+tbK9rCwT9pFPcQouK32rRqNGw
         /nlsBvvDsXna+eazoz7lPwK80rfYCUHKm1oH3qpceRnjh30HIeV1G3qEHb4WUCLkNwaw
         +Hlbu9Xfo66VdCC+VISYGLyN4cqZdUZ68ni0Q6EPfLgcHVB4ASpRziLDRGAhUS9pzUYL
         Zm9mptraBLw0DaFJ80Ix7WqGulwhrbi3SXNefY4yANu/4IOKbLAb56kwdG4JJTjkUknF
         sKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rUue1DCP3hEjtK7CuLTd3s374OML36ouGMsr5aZSPss=;
        b=j1ugStsQf4RQbyMGIRYg5sI3troGy2TsisOZoSQ/onm0cYfxFD7wxKjP2Gp9KohFuP
         q0FrxqWC7ROu02fyGF0HnmTv/+7M91bLukNn0Nw+i9agEbrxyeiPm8c5zlIXbTaEHUY6
         Ah8XMz02CC96Imi57+i9mwEEoWOUKHPc0QaX113w2/O7+qLDoc8FOGNVFefUGsTvfEnr
         7i2ax8otyqHF6RZer6oXcZnx4eRPaRhU4/CalztVSV/pPWadoKFj32CFv8V+tAqhqzFv
         g0t+XeVhOzIXQsm5e/eH6sQr1ibNFeR5YUMpVSo/o8wKw1UBwM0xBQ8G8tNBwMdlpyn0
         S5Sw==
X-Gm-Message-State: APjAAAUwb/M1WJoOXDZXiIUuX0EszEEC++lhLw3VpOZcr8RojZGJu0/z
        d4zmFb9FmQC0/T+MrL+iiM1A2bbU
X-Google-Smtp-Source: APXvYqwpsmkFjCZk903wQd7kT+Djdup7eOy05m7aaPCAQ8l5N+3K8j7K27h6ie5HVYdXZqjUte6+rQ==
X-Received: by 2002:a63:cd06:: with SMTP id i6mr4115388pgg.48.1578471078648;
        Wed, 08 Jan 2020 00:11:18 -0800 (PST)
Received: from hpz4g4.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id e9sm2477820pgn.49.2020.01.08.00.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 00:11:18 -0800 (PST)
Subject: Re: [PATCH] ext4: Prevent ext4_kvmalloc re-entring the filesystem and
 deadlocking
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <20191226071008.7812-1-naoto.kobayashi4c@gmail.com>
 <20191226143934.GC3158@mit.edu>
From:   Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
Message-ID: <b16c5913-2dd5-5d62-1eea-cda96ec2d973@gmail.com>
Date:   Wed, 8 Jan 2020 17:11:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191226143934.GC3158@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/12/26 23:39, Theodore Y. Ts'o wrote:
> On Thu, Dec 26, 2019 at 04:10:08PM +0900, Naoto Kobayashi wrote:
>> Although __vmalloc() doesn't support GFP_NOFS[1],
>> ext4_kvmalloc/kvzalloc caller may be under GFP_NOFS context
>> (e.g. fs/ext4/resize.c::add_new_gdb). In such cases, the memory
>> reclaim can re-entr the filesystem and potentially deadlock.
>>
>> To prevent the memory relcaim re-entring the filesystem,
>> use memalloc_nofs_save/restore that gets __vmalloc() to drop
>> __GFP_FS flag.
>>
>> [1] linux-tree/Documentation/core-api/gfp-mask-fs-io.rst
>>
>> Signed-off-by: Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
> 
> Good catch!  However, we're not actually using ext4_kvzalloc()
> anywhere, at least not any more.  And also, all the users of
> ext4_kvmalloc() are using GFP_NOFS (otherwise, they would have been
> converted over to use the generic kvmalloc() helper function).
> 
> So... a cleaner fix would be to (a) delete ext4_kvmazalloc(), (b)
> rename ext4_kvmalloc() to ext4_kvmalloc_nofs(), and drop its flags
> argument, and then the calls memalloc_nfs_save/restore() to
> ext4_kvmalloc_nofs() --- and so we won't need the
> 
> 	if (!(flags & __GFP_FS))
> 
> test.
> 
> Could you make those changes and resend the patch?
> 
> Thanks,
> 
> 					- Ted
> 

Thank you for the review! I made the changes you suggested and resent
the patch.

  [PATCH v2 0/3] ext4: Prevent memory reclaim from re-entering the filesystem and deadlocking
  https://marc.info/?l=linux-ext4&m=157743393000807&w=2

Would you review the patch?

Thanks,

                                       - Naoto
