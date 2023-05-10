Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C596FD657
	for <lists+linux-ext4@lfdr.de>; Wed, 10 May 2023 07:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjEJFsE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 May 2023 01:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjEJFsD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 May 2023 01:48:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A405C3ABA
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 22:48:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f14ec8d72aso5582356e87.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 May 2023 22:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683697680; x=1686289680;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o5+QXfteDoMM/MBHMjWR7m54CgRR9Yc30ZB9wrZNep8=;
        b=mQ1BCJajFuWroRHisLyLBAv8ela3DqXGZ6QtsFFUyZ/tDkZlZwCiNYqYuChAq0tDGl
         4OOXVVJx7Lf1Gel+Ee3BEZdWgo/Crp6njjHudNxJDmNGooqnwYi/3MAZi0uYea/gBr6w
         8xI+nE4HhqyOxeAurUuY72dm5rKXVCSi5x/lJtfAQXFZHgtbon67vTehsxOtcRZu56ff
         KRqpe9V9+UuDZpEuUzqUET6kVRd90hvbkz6t3DZZfaj+HtxngvMxmuTDut/cOLlVTfbJ
         vJ8vP34lA5eMVjWZtoRz0MPzC5jKnY8DFefz1/6a71IOxWcjSVzu/7Cus/EvPPxZW3wy
         oApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683697680; x=1686289680;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5+QXfteDoMM/MBHMjWR7m54CgRR9Yc30ZB9wrZNep8=;
        b=ENBAd2oNibC3U7n5WUtDXvUAxoNqnQXb8NBnP2GNgvlsgkKOuzLO/Q8qrkHgrYI4cR
         YjpFPkY3OSOQhw5SmuQcxSBpzZTNE+p3czRLyMw9wYW7DoXl88X2a8JCr5g9yJOgxvT6
         BLhITxtBB7sUJ+0y0/065ZvNgWylzqXCpNpIu29XOFTOOjgXPC79H1qL43EekQiaCdK7
         K5Jf6xwY/aXnDbiWGHl1GXu/elZdmfFwZ1BP6f7GoxJXlj+AP+4mV1uvYbUxC4QMcdEl
         RDqKioc3ezZ9ZTCj6B+V6eOcVTKdTghpJEVKYwhmHBM6zgJiqFNchikDLm1Yffji+/9S
         +2aw==
X-Gm-Message-State: AC+VfDxJTlYmdr93ILSpxSx/V6VwzzHc1T/QXG1eDIAefdVpJJPjvoDv
        PT84aPMKXsq0aRRj1n9qv79E0b4iUVJ/0Tsms9U=
X-Google-Smtp-Source: ACHHUZ5P14gBDc3lMk63UQSvVLvIHh8EuMboaYR29sNoEbn3acMPZdeeHKNaM/T8+U0tZ8FeOIfWX08eOhbUXLyoEYM=
X-Received: by 2002:ac2:482d:0:b0:4f0:4b3:fb1f with SMTP id
 13-20020ac2482d000000b004f004b3fb1fmr1271117lft.6.1683697679394; Tue, 09 May
 2023 22:47:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:1179:b0:224:262d:c651 with HTTP; Tue, 9 May 2023
 22:47:58 -0700 (PDT)
In-Reply-To: <CAOzgRdbkno+k1_vFfH9XVPcWxG7YCQRUWC2sX6kMSE3_gLODfA@mail.gmail.com>
References: <20221207112722.22220-12-jack@suse.cz> <20230508175108.6986-1-youling257@gmail.com>
 <20230509050227.GA1180@quark.localdomain> <ZFqSwegsnsqi3vAu@mit.edu> <CAOzgRdbkno+k1_vFfH9XVPcWxG7YCQRUWC2sX6kMSE3_gLODfA@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Wed, 10 May 2023 13:47:58 +0800
Message-ID: <CAOzgRdYXOgAM+s6OY=eNdg2oJOOTVO6rq+R+PMA6sLyEfm-OdQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] ext4: Stop providing .writepage hook
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>, jack@suse.cz,
        hch@infradead.org, hch@lst.de, linux-ext4@vger.kernel.org,
        ritesh.list@gmail.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I do more test, it is android esdfs or sdcardfs
/storage/emulated/0/Android/data problem,
"ext4: Stop providing .writepage hook" cause
/storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.0
/storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.1
/storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.idx
unable read,

on linux 6.4, i use mount bind data/media on storage/emulated, chmod
-R 0777 /data/media/0, rm
/storage/emulated/0/Android/data/com.android.gallery3d/cache/*, open
gallery app can read pictures thumbnail,
/storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.idx
/storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.0
/storage/emulated/0/Android/data/com.android.gallery3d/cache/imgcache.1
available read.


2023-05-10 13:17 GMT+08:00, youling 257 <youling257@gmail.com>:
> It isn't android storage emulated esdfs or sdcardfs problem, i test
> mount bind /data/media on /storage/emulated, can reproduce my problem.
> Let me say clear my problem, "ext4: Stop providing .writepage hook"
> cause android gallery app unable read pictures thumbnails.
>
> I test linux kernel 6.3 Revert "ext4: Stop providing .writepage hook",
> android gallery can read pictures thumbnails,
>
> this is mount bind /data/media on /storage/emulated
> /dev/nvme0n1p1 on /storage/emulated type ext4 (rw,seclabel,noatime)
> /dev/nvme0n1p1 on /mnt/runtime/default/emulated type ext4
> (rw,seclabel,noatime)
> /dev/nvme0n1p1 on /mnt/runtime/read/emulated type ext4
> (rw,seclabel,noatime)
> /dev/nvme0n1p1 on /mnt/runtime/write/emulated type ext4
> (rw,seclabel,noatime)
> /dev/nvme0n1p1 on /mnt/runtime/full/emulated type ext4
> (rw,seclabel,noatime)
>
> this is esdfs,
> /data/media on /mnt/runtime/default/emulated type esdfs
> (rw,nosuid,nodev,noexec,noatime,lower=1023:1023:664:775,upper=0:1015:771:771,derive=multi,noconfine,derive_gid,default_normal,unshared_obb)
> /data/media on /storage/emulated type esdfs
> (rw,nosuid,nodev,noexec,noatime,lower=1023:1023:664:775,upper=0:1015:771:771,derive=multi,noconfine,derive_gid,default_normal,unshared_obb)
> /data/media on /mnt/runtime/read/emulated type esdfs
> (rw,nosuid,nodev,noexec,noatime,lower=1023:1023:664:775,upper=0:9997:750:750,derive=multi,noconfine,derive_gid,default_normal,unshared_obb)
> /data/media on /mnt/runtime/write/emulated type esdfs
> (rw,nosuid,nodev,noexec,noatime,lower=1023:1023:664:775,upper=0:9997:770:770,derive=multi,noconfine,derive_gid,default_normal,unshared_obb)
> /data/media on /mnt/runtime/full/emulated type esdfs
> (rw,nosuid,nodev,noexec,noatime,lower=1023:1023:664:775,upper=0:9997:770:770,derive=multi,noconfine,derive_gid,default_normal,unshared_obb)
>
> if i do mount bind data/media on storage/emulated, take a screenshot,
> will create
> /data/media/0/Pictures/Screenshots/Screenshot_20230510-130020.png
> file,
> chmod -R 0777 /data/media/0/Pictures/Screenshots,
> on linux 6.3 Revert "ext4: Stop providing .writepage hook", android
> gallery app can read
> /storage/emulated/0/Pictures/Screenshots/Screenshot_20230510-130020.png
> thumbnail,
> linux 6.4 removed .writepage hook, android gallery unable read thumbnail.
>
>
> 2023-05-10 2:36 GMT+08:00, Theodore Ts'o <tytso@mit.edu>:
>> On Mon, May 08, 2023 at 10:02:27PM -0700, Eric Biggers wrote:
>>> On Tue, May 09, 2023 at 01:51:08AM +0800, youling257 wrote:
>>> > I using linux mainline kernel on android.
>>> > https://github.com/youling257/android-mainline/commits/6.4
>>> > https://github.com/youling257/android-mainline/commits/6.3
>>> > "ext4: Stop providing .writepage hook" cause some android app unable
>>> > to
>>> > read storage/emulated/0 files, i need to say android esdfs file system
>>> > storage/emulated is ext4 data/media bind mount.
>>> > I want to ask, why android storage/emulated need .writepage hook?
>>>
>>> "esdfs" doesn't exist upstream, so linux-ext4 can't provide support for
>>> it.
>>>
>>> Also, it doesn't exist in the Android Common Kernels either, so the
>>> Android team
>>> cannot help you either.
>>
>> The problem with esdfs is that it's based on the old stackable file
>> system paradigm which is filled with races and is inherently
>> unreliable (just for fun, try running fsstress on the upper and lower
>> file systems of a stackable file system simultaneously, and watch the
>> kernel crash and burn).  For that reason, some number of us have been
>> working for a while to eliminate the need for stacking file systems,
>> such as sdcardfs. esdfs, etc. from the Android kernel.
>>
>> The other thing I would add is that upstream has been working[1] on
>> getting rid of writepage function.  So out-of-tree file systems are
>> going to need to adapt --- or die.
>>
>> [1] https://lore.kernel.org/all/20221202102644.770505-1-hch@lst.de/
>>
>> It looks like esdfs is coming from the Chromium kernel?  The latest
>> Chromium kernel I can find is 5.15 based, and it has esdfs in it.  I'm
>> sad to see that esdfs hasn't been removed from the Chromium kernel
>> yet, and replaced with something more stable and reliable, but maybe
>> we can find someone who is more familiar with the Chromium kernel to
>> comment.
>>
>> Cheers,
>>
>> 						- Ted
>>
>
