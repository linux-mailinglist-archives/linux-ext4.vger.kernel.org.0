Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24699240600
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgHJMiB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Aug 2020 08:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgHJMiA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Aug 2020 08:38:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B00C061756
        for <linux-ext4@vger.kernel.org>; Mon, 10 Aug 2020 05:38:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bo3so9164120ejb.11
        for <linux-ext4@vger.kernel.org>; Mon, 10 Aug 2020 05:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AYMYv/RtmqZzu//iHYyi5t/eBtvTabtXaLeRqTpyxJw=;
        b=JJMCV+DzFbd7m+rqi0hGo1wViav7rFNqQyNAWi1C4d87QC2liAYcTUyLaYlrUfum3p
         wQAPcnA2eyd38p8MrgDnpWQDuhVa3aoz6z+//fVSzw6fPZwJN8wUGzDPhDzQjPyYbXHa
         nENKiKCFnJB4/Tx8AvmQz1c3agwSy0oHEr55iKj0E5S0ZgbVCeO2XdbBd4o0sj/wCYuJ
         GCO0KVnKkUxswwxeK223R1fuiPCVl0CVi77njS10PGI3zxRez/PH9tYo+OmQnEJcnRGn
         VLNg1xDsrUUjAC73Z0vn3UGr3GbD5rAS7UJszzQ4PA5TtC61lBTeoIR4O0GeSnbDL9ai
         b+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AYMYv/RtmqZzu//iHYyi5t/eBtvTabtXaLeRqTpyxJw=;
        b=WIi7h4SqKIuTVmcSfqWuuZKB/TOfrh7iC4EnK/n4af0uqchxfdPMeHfrCJqlFtyGhN
         kXQanhzHb21LmWRb3DtUuoeNTRFv7NScD4Ock/d0JsCkH4V2KGyckcEXTLdvlmRDBznn
         JKCDB+8eyhLYX8IlLbZAuCi5OTDo+At8gh/ZusYTpv9yzihlUl8FlDLTNGjKJiuWpZ+C
         Fdl6V+5BByDdI4tY3zTDXMh/TfAMTASnWdL22l1VY3FsJfCApa+sEGKExyFov3uAS9Wz
         TQcYNQ+iwyJVn64o685Sdtgbz1Hj/0YDPkwqwZbcDDyNSqBAvaGZMjHh6+HuiXAkXW9K
         cCYA==
X-Gm-Message-State: AOAM5301lMyuxgqQeGVIdSNTuyFuPEZYl4VhZjnyHE83XcKmNTRZt+f0
        7gRrhSslqCtRLB9KU7T80nWr+wakIwORfrsGjQ7D1Gi+2JU=
X-Google-Smtp-Source: ABdhPJxJIzZSQJAByqP1kjs9qTwPpQ5NWzl43fKccMLZ2hPqOm3giOVR0fksFKBMrD41e6fn8qt1ORokNBjNx1Gxigk=
X-Received: by 2002:a17:906:7155:: with SMTP id z21mr22758726ejj.282.1597063077958;
 Mon, 10 Aug 2020 05:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPQccj4_Tz-11AfXaSiPj4aRWYU2mX9eJuJyGNR68Mini0PZjw@mail.gmail.com>
In-Reply-To: <CAPQccj4_Tz-11AfXaSiPj4aRWYU2mX9eJuJyGNR68Mini0PZjw@mail.gmail.com>
From:   Maciej Jablonski <mafjmafj@gmail.com>
Date:   Mon, 10 Aug 2020 13:37:45 +0100
Message-ID: <CAPQccj7XwunXerNYxPBTpBa0JVX7vzC=7aBoE8m35ttFHYNOPg@mail.gmail.com>
Subject: Re: libext2fs: mkfs.ext3 really slow on centos 8.2
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On upgrading from centos 7.6 to centos 8.2 mkfs slowed down by orders
of magnitude.

e.g. 35GB partition from under 8s to 4m+ on the same host.

Most time is spent on writing the journal to the disk.

strace shows the following:

We have got strace which shows that each each block is zeroed with
fallocate and each
 invocation of fallocate takes 10ms, this accumulates of course.

We have found that using

UNIX_IO_NOZEROOUT=1 to affect libext2fs

Brings the timings back in line down to seconds.

If this is not a known bug I can send more details,

Looks that calling fallocate for each block is very inefficient on some system.
In our case this is dellr640 (skylake) with a mechanical disk.

Kind Regards,

Maciej


On Mon, 10 Aug 2020 at 13:35, Maciej Jablonski <mafjmafj@gmail.com> wrote:
>
> Hi,
>
> On upgrading from centos 7.6 to centos 8.2 mkfs slowed down by orders of magnitude.
>
> e.g. 35GB partition from under 8s to 4m+ on the same host.
>
> Most time is spent on writing the journal to the disk.
>
> strace shows the following:
>
> 16:19:49.827056 prctl(PR_GET_DUMPABLE)  = 1 (SUID_DUMP_USER)
> 16:19:49.827112 fallocate(3, FALLOC_FL_ZERO_RANGE, 3383296, 4096) = 0
> 16:19:49.835203 pwrite64(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 3362816) = 4096
> 16:19:49.835321 getuid()                = 0
> 16:19:49.835403 geteuid()               = 0
> 16:19:49.835463 getgid()                = 0
> 16:19:49.835513 getegid()               = 0
> 16:19:49.835582 prctl(PR_GET_DUMPABLE)  = 1 (SUID_DUMP_USER)
> 16:19:49.835657 fallocate(3, FALLOC_FL_ZERO_RANGE, 3387392, 4096) = 0
> 16:19:49.843471 pwrite64(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 3366912) = 4096
> 16:19:49.843562 getuid()                = 0
> 16:19:49.843619 geteuid()               = 0
> 16:19:49.843669 getgid()                = 0
> 16:19:49.843715 getegid()               = 0
> 16:19:49.843785 prctl(PR_GET_DUMPABLE)  = 1 (SUID_DUMP_USER)
> 16:19:49.843836 fallocate(3, FALLOC_FL_ZERO_RANGE, 3391488, 4096) = 0
> 16:19:49.851885 pwrite64(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096, 3371008) = 4096
>
>
> Each invocation of fallocate takes 10ms, this accumulates of course.
> We have found that using
>
> UNIX_IO_NOZEROOUT=1 to affect libext2fs
>
> Brings the timings back in line down to seconds.
>
> If this is not a known bug I can send more details,
>
> Looks that calling fallocate for each block is very inefficient on some system.
> In our case this is dellr640 (skylake) with a mechanical disk.
>
> Kind Regards,
>
> Maciej
>
>
