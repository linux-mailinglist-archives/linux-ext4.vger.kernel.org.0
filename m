Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58C83E9C0B
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 03:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhHLBsK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 21:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233440AbhHLBsJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 11 Aug 2021 21:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628732864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I9drUWprpizqc04oZLDcbbvr04UcpePzTV8+AFv5W1Y=;
        b=JwXdUi29DkidKH1UlGvt+ayKutMKy6FlPU/5DZyDTLdeEgFJ0YLXuWFWLZCv/WTIdJO6Cn
        9GNQH4ikFSAnIbe8zlREiw+OlXHSagSTfF4PwxP1hCV8sm461BsQFNv3FWIRGC0jXezdGE
        U//XJzfXBHRit6T9zWG3dqvklzq67zI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-XgwC8DZcO_ui_odn7hMWDg-1; Wed, 11 Aug 2021 21:47:43 -0400
X-MC-Unique: XgwC8DZcO_ui_odn7hMWDg-1
Received: by mail-pj1-f69.google.com with SMTP id r13-20020a17090a4dcdb0290176dc35536aso2978249pjl.8
        for <linux-ext4@vger.kernel.org>; Wed, 11 Aug 2021 18:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9drUWprpizqc04oZLDcbbvr04UcpePzTV8+AFv5W1Y=;
        b=Q40Ftc0JNGmPmuNQK7u6h8N5uDT8Ryn5judrwLpWEt4S9q1/0C2TqnxZ7as4vhhE69
         z7BAzzGw4Ef9+zWl7UCAx1W5TUu6WIAxY/ADIlPpLRLbIfYkaDxD4fbSXHk9t3kIV2lj
         nTHrggWamAs0j3wkm5y34SDc/CKHpFCJKyZXfOVJcj32+WzwSmq8A/Fo52jQgMV2yeYg
         BL4Kw+QLgp9QWZdPK9m/KHba80ewnrv0z+yODKf3pCodvFDr/8e0l89sjVp7fWVrsWzV
         s+19XiSruykWTbOQ6VIsaMFqRcNrV9MnDLNQFEmWCNhRUBgf/lMPM/o5o81Wo7d8pN8z
         dYpg==
X-Gm-Message-State: AOAM533f/Q6FbLn5ui0rmM7UbQRYPXO3YJvqmZ064WK1oFQfr2BpC8T4
        9qyRK5bt5Ix4q3cRUZuAsUGUl7oVufh16g+KY/LYJqP195p2V3VYJgv5qhG39B7w1cEjQFLWcCI
        WrFbr1KsxOMtW24ygzvN3M1gLNVhhhpOKbjxCFA==
X-Received: by 2002:a17:902:bd43:b029:12c:def4:588e with SMTP id b3-20020a170902bd43b029012cdef4588emr1440046plx.25.1628732862169;
        Wed, 11 Aug 2021 18:47:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDXB8P+j32jHMmxszXw5RZlcl3w4F5+kWHF25Et30j9/Q/hASpqRjc7oV+pWH0YOtWWdkQxqNQgycDThPPUMA=
X-Received: by 2002:a17:902:bd43:b029:12c:def4:588e with SMTP id
 b3-20020a170902bd43b029012cdef4588emr1440039plx.25.1628732861943; Wed, 11 Aug
 2021 18:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLe9YbqejLQJO-6-a0ETtNUitQtsYr3Q2b7xW4VV=6fXO6APw@mail.gmail.com>
In-Reply-To: <CAHLe9YbqejLQJO-6-a0ETtNUitQtsYr3Q2b7xW4VV=6fXO6APw@mail.gmail.com>
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 12 Aug 2021 09:47:30 +0800
Message-ID: <CAHLe9YZN2LJHMzKPkA-g7C=fx-u-0Jw-2s6Ebyy-XUmv_5y-gg@mail.gmail.com>
Subject: Re: [kernel-5.11 regression] tune2fs fails after shutdown
To:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

(Adding the author of the commits)

Hi Jan,

The commit

81414b4dd48 ext4: remove redundant sb checksum recomputation

breaks the original reproducer of

4274f516d4bc ext4: recalucate superblock checksum after updating free
blocks/inodes

I'm wondering is it expected please?

Thanks,
Boyang

On Thu, Aug 5, 2021 at 10:35 AM Boyang Xue <bxue@redhat.com> wrote:
>
> Hi,
>
> kernel commit
>
> 4274f516d4bc ext4: recalucate superblock checksum after updating free
> blocks/inodes
>
> had been reverted by
>
> 81414b4dd48 ext4: remove redundant sb checksum recomputation
>
> since kernel-5.11-rc1. As a result, the original reproducer fails again.
>
> Reproducer:
> ```
> mkdir mntpt
> fallocate -l 256M mntpt.img
> mkfs.ext4 -Fq -t ext4 mntpt.img 128M
> LPDEV=$(losetup -f --show mntpt.img)
> mount "$LPDEV" mntpt
> cp /proc/version mntpt/
> ./godown mntpt # godown program attached.
> umount mntpt
> mount "$LPDEV" mntpt
> tune2fs -l "$LPDEV"
> ```
>
> tune2fs fails with
> ```
> tune2fs 1.46.2 (28-Feb-2021)
> tune2fs: Superblock checksum does not match superblock while trying to
> open /dev/loop0
> Couldn't find valid filesystem superblock.
> ```
>
> Tested on e2fsprogs-1.46.2 + kernel-5.14.0-0.rc3.29. I think it's a
> regression. If this is the case, can we fix it again please?
>
> Thanks,
> Boyang

