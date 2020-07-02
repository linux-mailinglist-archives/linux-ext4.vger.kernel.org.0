Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C31212D20
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jul 2020 21:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgGBT3d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jul 2020 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGBT3c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jul 2020 15:29:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7590EC08C5C1
        for <linux-ext4@vger.kernel.org>; Thu,  2 Jul 2020 12:29:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f16so2549680pjt.0
        for <linux-ext4@vger.kernel.org>; Thu, 02 Jul 2020 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=8aWCEvr+Js0tYOnq/XOnbh/Rps1YbsOGWhRz+Wh6Sjc=;
        b=HRwbUgyVgzWTQjbg4NaukeYXEg3xv5j4WTbTS4VpIkQLF7Lg1IfWo9h8UL+3cPB0WU
         MG1ApqpGv/PAX8SdZ255cs6Fj9aldvVZyxIrBi/MG7JfVTKY5PxiDb02iJ74l6LQVH1d
         +aeiMTJvU4q9d0q20ogvwlxcROKTX0Z9gO2Tt0xvYi3sUspk1bNrIn6hh2IfrZYtx7yR
         qdWQ2zkwZ6vPbHTGByo+01Mq+xyN4jJjxAk+WdO/6UbK2PP6deklb4+czYe6H2c9mKPR
         noX92BalNvd6CmNerY7TrVYYJ3B3vxqNB8syra2X4W2SnmzyExZ36RI2RUREwN8PHhPi
         h4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=8aWCEvr+Js0tYOnq/XOnbh/Rps1YbsOGWhRz+Wh6Sjc=;
        b=nIROLwRhyOiICTs6Y0p4C1BiMkpBIglVjsqMde6ZZL6XSPSGVLwaJjYpjK3SejpndW
         VsByYsALYzbCl84wJXwEXCHSnstOkBbqvC9UrWpFn1xEGYRqp9clN+A+qnzKfWNNhIc6
         /5B6GpYO76XpGyA7eay0GCTct/hZkpLWtP0sAxqVXSvDPUFp6ofRVDmqWpgBdVc+QKtw
         aG3MrENFcQaFjwfcqLuqOZRleslC39BKY3rLwNAjez2yU7RqsWUB7P+Z/314Rzbsz0aV
         QNeOtQvgKd4XnFJGs1/JOX+LyYp9KTozA4g5UIJP29lNJOzbR/sCJT1PKVvgxPqTc0Ba
         yIqg==
X-Gm-Message-State: AOAM531Jqo+VuE/TogNrB2fdr5DpQysJFmQ0/cgg4Dx3y1vQJGFXD8oz
        Tl++Fw0F8ELXVHJUVUBUHRF6fQ==
X-Google-Smtp-Source: ABdhPJyqfLVqYs7UCvaxgSmuvnfCzNyXEvBOIymNavXDdeJuAZo8WahLr29KtirNhaFOJiqGt10Hfw==
X-Received: by 2002:a17:902:b48a:: with SMTP id y10mr26538392plr.97.1593718171846;
        Thu, 02 Jul 2020 12:29:31 -0700 (PDT)
Received: from [192.168.0.149] (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id o42sm8967031pje.10.2020.07.02.12.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 12:29:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: Grow ext4 filesystem on mounted device
Date:   Thu, 2 Jul 2020 13:29:28 -0600
Message-Id: <A735B112-0384-43F8-8F0F-CACFD34CEA67@dilger.ca>
References: <CAG-6nk9Cy6itStS917HxL7dvcy5=J+CCpSAqRoC9Um8P9LJ=kw@mail.gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
In-Reply-To: <CAG-6nk9Cy6itStS917HxL7dvcy5=J+CCpSAqRoC9Um8P9LJ=kw@mail.gmail.com>
To:     Alok Jain <jain.alok103@gmail.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Jul 2, 2020, at 13:18, Alok Jain <jain.alok103@gmail.com> wrote:
>=20
> =EF=BB=BFHi Experts,
>=20
> I want to grow the ext4 file system on mounted device by running
> resize2fs utility but it fails, same works in case of unmounted FS
> with additional invocation of e2fsck utility.
>=20
> This is what i am doing
>=20
> 1)Rescanning the device
> echo "1" | sudo tee /sys/block/sdd/device/rescan
> 2) Extending the partition
> growpart /dev/sdd 1
> 3) resizing the file system
> resize2fs /dev/sdd1
> resize2fs 1.43-WIP (20-Jun-2013)
> The filesystem is already 43253499 blocks long.  Nothing to do!

What does "grep sdd1 /proc/partitions" show?  Is the kernel
aware of the larger partition size?

> parted -s /dev/sdd1 print free
> Model: Unknown (unknown)
> Disk /dev/sdd1: 177GB
> Sector size (logical/physical): 512B/4096B
> Partition Table: loop
>=20
> Number  Start  End    Size   File system  Flags
> 1      0.00B  177GB  177GB  ext4
>=20
> Any help?
>=20
> Thanks,
> Alok
