Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7F439C01
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Oct 2021 18:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhJYQuL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Oct 2021 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhJYQuL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Oct 2021 12:50:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD49C061745
        for <linux-ext4@vger.kernel.org>; Mon, 25 Oct 2021 09:47:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s24so4346491plp.0
        for <linux-ext4@vger.kernel.org>; Mon, 25 Oct 2021 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=6M3pBtKrq21SJ8NcjfpnAzk60UNTxnFTq/K8855bQ6A=;
        b=i/hizxmAR/0q4eRm77UkNYmfLntZh4Z5awWHHSCpQ9i79D/vf6wsLuyj9yKqo5cYn1
         If8m3PeyOLmPfODvubLs1Cx27LJpeErScMHjnmLmMFnV10MikrlMq8zMt5BnZFr4qdna
         jjebBU9m8e3CglKOC/QqcZYCVJroKMGo0/v8HoyeUHcpp2UsUrIgE2ZIgs+V1+pmhmBP
         Psv1fOVVIb2vW9V8zxtgN9Wsox4MGD3SQxnQDBhd3AkkGV8yJoIAF8TZTlC6U6QuFkIn
         1XpS3QUKzkBtU0DaCQe6MAiua5qSna++NvY7xmeaxoZ759okNMpdikuuvP4AG5e1EVh8
         dC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6M3pBtKrq21SJ8NcjfpnAzk60UNTxnFTq/K8855bQ6A=;
        b=y98kr5imVmh5YPMM5Wu5tvuDpU6ws7J4lwYejE+826LIPz6C8QII7g1PLOvNa8lZSq
         Xuac9GGv65ZsFEScB7QywPIS0e5acVFJKektWGyxTxHzAjJpnSSfr1sLwqchTUckyS7W
         iHRjvrEDxOtYMKQccwNP6wcnkwwghfJAbQEfyJGfdJS5wKv8zk7WbRHHfCYOywxe4Rw7
         k7HecKm2CEb80XF5AEXDxfV10lA0UGU72CO/mb+FgykbOZ473w4Aa4CUIRJ1YIfhxGQ6
         IpSUUbGVuUnxujM/gZlPlev6kSNV4goAakH6MyT+KaqAoWJoo7ajFNaHY8cBWzKvlm+R
         OM4g==
X-Gm-Message-State: AOAM531dr65qQGpjsLYCbWAnZnOkrEcFjaD5neo6A1nmPAxiL+Vtsgxb
        RPp7AA0IMmpeOJvcMFZ9pdzenw==
X-Google-Smtp-Source: ABdhPJw58/wiAXgDMbKyciCtDlr00xUVQ2ahMK7vzl7Gnxdwd22kmfP2Moz/x5E9bXT9PdCTiAdltg==
X-Received: by 2002:a17:90a:5b09:: with SMTP id o9mr29856611pji.171.1635180468449;
        Mon, 25 Oct 2021 09:47:48 -0700 (PDT)
Received: from smtpclient.apple (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id e7sm6919473pgk.90.2021.10.25.09.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:47:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: How to force EXT4_MB_GRP_CLEAR_TRIMMED on a live ext4?
Date:   Mon, 25 Oct 2021 10:47:46 -0600
Message-Id: <97FC9914-F57C-4D96-8C24-5B6AE7C6FE71@dilger.ca>
References: <1635175743.26818.15.camel@guerby.net>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
In-Reply-To: <1635175743.26818.15.camel@guerby.net>
To:     Laurent GUERBY <laurent@guerby.net>
X-Mailer: iPhone Mail (18H17)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Oct 25, 2021, at 09:29, Laurent GUERBY <laurent@guerby.net> wrote:
>=20
> =EF=BB=BFOn Mon, 2021-10-25 at 11:42 +0200, Lukas Czerner wrote:
>>> On Sat, Oct 23, 2021 at 12:24:40PM +0200, Laurent GUERBY wrote:
>>>=20
>>> I did end up creating dummy files to fill the filesystem and then
>>> removing them, but this is far less efficient than what a
>>> filesystem
>>> tool could do.
>>=20
>> Yeah, that's bad. The information is stored in the buddy cache in
>> memory
>> and AFAIK is only dropped on unmount. I'll have to think about how to
>> clear either the cache or selectively just the flag.
>>=20
>> What would be more convenient way of doing this for you, -o remount,
>> or
>> using let's say tune2fs ? I am not promising anything yet, but I'll
>> think
>> about how to implement it.
>>=20
>>=20
>> Meanwhile other than umount/mount, or actually writing to the dummy
>> files,
>> you can try to use fallocate to allocate all the remaining space in
>> the
>> file system and subsequently removing it. That should be more
>> efficient,
>> but don't forget to sync after remove to make sure the space is
>> released
>> before you call fstrim.
>=20
> Thanks for the advice on fallocate! It does work and is very fast.

It would be enough to allocate and free a block in each group (128MB)
of the filesystem. That can't be controlled directly by fallocate(),
but indirectly via the "goal inode", but if fallocate() if all free space is=
 fast
enough it may not be worth the effort.=20

> I would prefer a specific tune2fs as remount forcing this TRIM cache
> clearing behaviour might be unwanted.
>=20
>> You could also force fsck on ro file system and use -E discard to
>> trim the
>> free space but I can't say I recommend it.

This would have a danger to corrupt the mounted filesystem, so should
not be allowed when doing a read-only e2fsck. The bitmaps that e2fsck
is using for the trim may be stale if the filesystem is modified since the
start of the run, which may be a long time in some cases (minutes, hours).

Cheers, Andreas=
