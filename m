Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC61A7DE
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2019 14:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfEKMna (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 May 2019 08:43:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55813 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfEKMna (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 May 2019 08:43:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id y2so9833260wmi.5;
        Sat, 11 May 2019 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOvKsBn/LkqXY5E0wRAnpgOTDwuv3IaXSaUHRvhtbCw=;
        b=ujr0npfLjDrpG3SDlbPpizkVHDvCrYVbU+O2WOtXzHQgaDLNRc2NvY+6hjUuVcuwTF
         MEIWSK+FksTw4nQouZDfGz3Ikw8aQWg7FPaoG+kdbxDX00Crro/BhqUno68SesPCAd4m
         S1DB6LOHrZ//7Wl5VMyoeUWByg5O3UDWTMjoiqRHzUmQNCEptvSy6FDXTyz+K4CSOaH1
         Gyle+Os6rMxCKt0icjzZKeNo3U9fplGzIDB5LSMu+PDox9WbcypAZsCrEuPwuNvHxDPs
         85RAePnX3uQavrz6leqU3KEMj9r+dxkXP9KCu5wsryNaITDxeC2x7TGNGTeNNPAHN5yO
         /n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOvKsBn/LkqXY5E0wRAnpgOTDwuv3IaXSaUHRvhtbCw=;
        b=a71lCQxD0rp4HGqqM3XSe0LpUyrpLBTPOfynsK3yuRvclBSgN6h3w9G0UGhkwTafRw
         M54s3tom9PGJ5zMYnO5H2uOSV9Ye4mioD5cTfhIg//3E98T/8F22toM6NtTSQq7XcW19
         zKVmzg3w5d3b6bS0/VwuGTp4+u/81ASqdx5QjYZom6SGmwdMMH7PA8g5ahz0ktv/v5mZ
         z2oxC5RC0+VuiSCTJEYx4m2ty+DATGbobHI9++UOHCH85Ch3SMFPbWJbJFXpNOrEMOP+
         GXNHieFaKzlqjNzldvL8sEQsdmbw046QcuJXulFBch7HtqhUoGCYUp67ViTF5zGtnnI/
         MPeQ==
X-Gm-Message-State: APjAAAX94qKM9bzPyqq9lVdKRYpjCMya+1qD3e7zgp6DUfFQ/33e0dsM
        z8oMfoQ0iQ2bV2FJRf4ZR61UKDXoas8feZYq2XPWAmGL
X-Google-Smtp-Source: APXvYqwXQpWoN3eXZifOwnGZf9xC6qeNNgfkIo4PC6WVGSAgbUe1HRX8kzrFow2kxA7rdy2P7axfLQc/S/vZB5b1FrQ=
X-Received: by 2002:a1c:494:: with SMTP id 142mr10613231wme.115.1557578608236;
 Sat, 11 May 2019 05:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net>
In-Reply-To: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sat, 11 May 2019 14:43:16 +0200
Message-ID: <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com>
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
To:     Arthur Marsh <arthur.marsh@internode.on.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[CC'in linux-ext4]

On Sat, May 11, 2019 at 1:47 PM Arthur Marsh
<arthur.marsh@internode.on.net> wrote:
>
> I have yet to bisect, but have had trouble with recent, post 5.1.0 kernels built from Linus' git head on both i386 (Pentium 4 pc) and amd64 (Athlon II X4 640).
>
> The easiest way to trigger the problem is:
>
> git gc
>
> on the kernel source tree, although the problem can occur without doing a git gc.
>
> The filesystem with the kernel source tree is the root file system, ext3, mounted as:
>
> /dev/sdb7 on / type ext3 (rw,relatime,errors=remount-ro)
>
> After the "Compressing objects" stage, the following appears in dmesg:
>
> [  848.968550] EXT4-fs error (device sdb7): ext4_get_branch:171: inode #8: block 30343695: comm jbd2/sdb7-8: invalid block
> [  849.077426] Aborting journal on device sdb7-8.
> [  849.100963] EXT4-fs (sdb7): Remounting filesystem read-only
> [  849.100976] jbd2_journal_bmap: journal block not found at offset 989 on sdb7-8
>
> fsck -yv
>
> then reports:
>
> # fsck -yv
> fsck from util-linux 2.33.1
> e2fsck 1.45.0 (6-Mar-2019)
> /dev/sdb7: recovering journal
> /dev/sdb7 contains a file system with errors, check forced.
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> Free blocks count wrong (4619656, counted=4619444).
> Fix? yes
>
> Free inodes count wrong (15884075, counted=15884058).
> Fix? yes
>
>
> /dev/sdb7: ***** FILE SYSTEM WAS MODIFIED *****
>
> Other times, I have gotten:
>
> "Inodes that were part of a corrupted orphan linked list found."
> "Block bitmap differences:"
> "Free blocks sound wrong for group"
>
> No problems have been observed with the 5.1.0 release kernel.
>
> Any suggestions for narrowing down the issue welcome.

Can you git-bisect it?

-- 
Thanks,
//richard
