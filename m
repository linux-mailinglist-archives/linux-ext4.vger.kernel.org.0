Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCCA5E74F3
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Sep 2022 09:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiIWHiP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Sep 2022 03:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiIWHiO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Sep 2022 03:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2AD12849A
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663918693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qHPWWT76GcLGyzf4127Tvk5MldeTP1SW/jnKOb4C9FE=;
        b=iP5LeF05Mq/yYeKPCRZQJKefEqRHVmzssg2gAF2+MgpB4uHlVbxtMfdAjkFHIJVXoxJX8u
        c+zCEGTZkifZeBvezt9QarBQ/Aex4Pd1598T8oUNI3i/HFY4C8rc6cKj6cMjh/soWPAhd4
        5ddp9O/nzo73bRTuGwG/HD9Kjv7DxnA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-527-Rr28vkOnNPq7Q4btc9lHYA-1; Fri, 23 Sep 2022 03:38:10 -0400
X-MC-Unique: Rr28vkOnNPq7Q4btc9lHYA-1
Received: by mail-lj1-f198.google.com with SMTP id q5-20020a2e84c5000000b0025ec9ff93c8so3673818ljh.15
        for <linux-ext4@vger.kernel.org>; Fri, 23 Sep 2022 00:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qHPWWT76GcLGyzf4127Tvk5MldeTP1SW/jnKOb4C9FE=;
        b=ql0sEU3NeMtmSV7DzaIkbkIVf4ekYcnxRiY6AbzE7aSzI5iDkYANL25i0NMcBAv2Lv
         mr16b2JZmfwPQ99KUDnoDAHDOCzluXRfFRZhuFMHDphL1G/VkA4GT/Y0e/4pV/VIuc4k
         vrG4gXhReJvvZeyHSQDEtOYyHLQgplvNcBWGrEACUTa/LZr2GIwfPx7IGlivZ2+bI4rj
         loL3vQiynWXodTwCmPM7hMY2CIlrJR9H6M+8GaZMOxJAQnTJZrgdiZc/n4agyYFMF4YB
         yE+KMytAsvgunldMNIzJcJjfKGtzVIRPvAqT6l1uSBjeqeEyDroC9Iax3RBL0pJ4+mp7
         5fsg==
X-Gm-Message-State: ACrzQf19OG0YYxeKT9TocFLvaUcLAvwVI88RcdQv3waavwPJ/VMfceIX
        xDXMctL8aQu4ICm32i3+xsiPQIG3Zw4lS6EKzeOwzqxC+E5Crm3O1Mrso5FW4ig9FgVGQacfh8E
        6MN6q69Ntnq4meA0fI86Dz2WG7ePRoQ1jMxmSDg==
X-Received: by 2002:a05:651c:90a:b0:25d:57c9:30c4 with SMTP id e10-20020a05651c090a00b0025d57c930c4mr2248953ljq.386.1663918688504;
        Fri, 23 Sep 2022 00:38:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ptv27ifFE3TM8bknZD8Iow8Hjj0kc8Exwr7RYCbw04Q8ecuzJwJq8A5uJR5TNSTxrtm4hor87dteOsgZsmPo=
X-Received: by 2002:a05:651c:90a:b0:25d:57c9:30c4 with SMTP id
 e10-20020a05651c090a00b0025d57c930c4mr2248945ljq.386.1663918688236; Fri, 23
 Sep 2022 00:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLe9YZvOcbimNsaYa=jk27uUR1jgVDtXXztLEa0AVnqveOoyQ@mail.gmail.com>
 <20220922120207.3jeasu24dmx5khlz@quack3>
In-Reply-To: <20220922120207.3jeasu24dmx5khlz@quack3>
From:   Boyang Xue <bxue@redhat.com>
Date:   Fri, 23 Sep 2022 15:37:55 +0800
Message-ID: <CAHLe9YbPph=6PqeDNYANvRnrmkir5iLSbVD6gAhVZju6k8cgbA@mail.gmail.com>
Subject: Re: [bug report] disk quota exceed after multiple write/delete loops
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

On Thu, Sep 22, 2022 at 8:02 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> On Tue 23-08-22 12:16:46, Boyang Xue wrote:
> > On the latest kernel 6.0.0-0.rc2, I find the user quota limit in an
> > ext4 mount is unstable, that after several successful "write file then
> > delete" loops, it will finally fail with "Disk quota exceeded". This
> > bug can be reproduced on at least kernel-6.0.0-0.rc2 and
> > kernel-5.14.0-*, but can't be reproduced on kernel-4.18.0 based RHEL8
> > kernel.
>
> <snip reproducer>
>
> > Run log on kernel-6.0.0-0.rc2
> > ```
> > (...skip successful Run#[1-2]...)
> > *** Run#3 ***
> > --- Quota before writing file ---
> > Disk quotas for user quota_test_user1 (uid 1003):
> >      Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
> >      /dev/loop0       0  200000  300000               0    2000    3000
> > --- ---
> > dd: error writing '/mntpt/test_300m': Disk quota exceeded
> > 299997+0 records in
> > 299996+0 records out
> > 307195904 bytes (307 MB, 293 MiB) copied, 1.44836 s, 212 MB/s
>
> So this shows that we have failed allocating the last filesystem block.  I
> suspect this happens because the file gets allocted from several free space
> extens and so one extra indirect tree block needs to be allocated (or
> something like that). To verify that you can check the created file with
> "filefrag -v".

By hooking a "filefrag -v" in each run, I find a pattern that only
when the dd command writes out of disk quota, "filefrag -v" shows
"unwritten extents", like this:
```
Filesystem type is: ef53
File size of /mntpt/test_300m is 307195904 (74999 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..    1023:      98976..     99999:   1024:
   1:     1024..   18431:     112640..    130047:  17408:     100000:
   2:    18432..   51199:     131072..    163839:  32768:     130048:
   3:    51200..   55236:     165888..    169924:   4037:     163840: unwritten
   4:    55237..   74998:          0..         0:      0:
last,unknown_loc,delalloc,eof
/mntpt/test_300m: 5 extents found
```

>
> Anyway I don't think it is quite correct to assume the filesystem can fit
> 300000 data blocks within 300000 block quota because the metadata overhead
> gets accounted into quota as well and the user has no direct control over
> that. So you should probably give filesystem some slack space in your
> tests for metadata overhead.

It makes sense to me. Indeed my test should count in the metadata
overhead. Thanks for the explanation!

-Boyang

>
> > --- Quota after writing file ---
> > Disk quotas for user quota_test_user1 (uid 1003):
> >      Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
> >      /dev/loop0  300000* 200000  300000   7days       1    2000    3000
> > --- ---
> > --- Quota after deleting file ---
> > Disk quotas for user quota_test_user1 (uid 1003):
> >      Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
> >      /dev/loop0       0  200000  300000               0    2000    3000
> > --- ---
> > ```
>
>                                                                 Honza
>
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>

