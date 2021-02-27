Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9B326AE8
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Feb 2021 01:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhB0A7P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 19:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhB0A7P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Feb 2021 19:59:15 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D8BC061574
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 16:58:34 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id h22so10856542otr.6
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 16:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwOwOGqL/8hoQKZDtN6VWqaAjhvECRNAYLPZMtIaHK4=;
        b=fUnDtnW5mbYS4fp0xIyCrqDGDo1XM8BybKy9aKdQ7O6DBzweCPlm8bdr5E7HO1+ehd
         +an398yG2qZs4FVXV1Jb6nljN2mmWHpfwrlj0LStwOX6GIPTEmYxM//NhBXWJcc8H3az
         6Q/0yxDuEY51bTMTWdyklNaUWWttCKYu9jwWKMXJVf4UT33blcsAO6Kl3GufiKV1lk/D
         s3rAiEJDQNL1mAxlpjuqWmteBNuxMrZE89B9irvJf0OkgpoSeUKa3PhRGCs34np9Vayu
         gd7uygw2R1DKJXCKBSMgU/wdbqnUINuJd8XcrqHhxHORRA0tsOexLkm18IbIWlBWgYdJ
         y5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwOwOGqL/8hoQKZDtN6VWqaAjhvECRNAYLPZMtIaHK4=;
        b=dylxlkKUC/r6NrNhSOj6xaOLVg9veAgVGdGLcKn92KLcCkfp1rBdxPu/92AzdjVkxL
         TiA87B21m81DzzJDtHdc9EhYuMMr5XPWRHTybnaKYNRjZtjxfZbxPp89jMVgadd0DERz
         l1hSYBNvDEN4UIF/EihglmCcWiMU4PNOivfnIA/pjU8p20p+qWbnAub/un57QpvzLtPS
         vFP+TjbfnxNmODZjmUqOBM3STtpegIyVVeIMwDhRTQkHaQrb1B2KUZvUHL6H/qRkeWPX
         N6rmCJnT9LGFkPUCvpuXSRt7xwktEv8pOzH6ZDtoAP45ZR4YCzLz1StDSnhG7S/LeEH6
         xzrA==
X-Gm-Message-State: AOAM531SyI/q6NPt6k+heqXh3Q8DbyJSo2HVEEkt1vSR59SzJBv1S6uA
        PydadUoC9zNXMENLM0WQeioY9CWDmMAxMZ9T/Ms=
X-Google-Smtp-Source: ABdhPJwgm6HyACx13YKnCrJCX4YoOV3zK5rqcqfna9ir9BqeJg6Yf5+evrHDUEhlCtqdirVKFwuriMLg+s2M+9Xmrhw=
X-Received: by 2002:a05:6830:1688:: with SMTP id k8mr4690122otr.45.1614387513714;
 Fri, 26 Feb 2021 16:58:33 -0800 (PST)
MIME-Version: 1.0
References: <bug-211971-13602@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211971-13602@https.bugzilla.kernel.org/>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Fri, 26 Feb 2021 16:58:23 -0800
Message-ID: <CAE1WUT6NueggML9Kf+JxB-dX=fyKrOhDszAnbt7UvFhQqwm3Gg@mail.gmail.com>
Subject: Re: [Bug 211971] New: Incorrect fix by e2fsck for blocks_count corruption
To:     bugzilla-daemon@bugzilla.kernel.org
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Can you replicate this on modern 5.4 from kernel.org? -generic kernels
are from Canonical and are sometimes broken compared to upstream. If
you can't replicate this on mainline, you'll need to contact
Canonical. We can't do anything if the problem only persists on
distribution kernels.

On Fri, Feb 26, 2021 at 1:41 PM <bugzilla-daemon@bugzilla.kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=211971
>
>             Bug ID: 211971
>            Summary: Incorrect fix by e2fsck for blocks_count corruption
>            Product: File System
>            Version: 2.5
>     Kernel Version: Linux 5.4.0-65-generic
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: ext4
>           Assignee: fs_ext4@kernel-bugs.osdl.org
>           Reporter: tmahmud@iastate.edu
>         Regression: No
>
> Created attachment 295497
>   --> https://bugzilla.kernel.org/attachment.cgi?id=295497&action=edit
> log files from mke2fs, dumpe2fs and e2fsck
>
> For an ext4 file system image with only one superblock, if the blocks_count
> field in superblock is corrupted, e2fsck fixed it incorrectly. In the fixed
> image, the corrupted blocks_count is unchanged and other fields (e.g., free
> blocks count) are changed accordingly.
> This issue also occurs in images with multiple superblocks too. For example,
> For an ext4 image with primary and backup superblock (backup superblocks are
> not located in default locations, e.g., it is located on 513rd block), if the
> blocks_count field in superblock is corrupted, e2fsck fixed it incorrectly. In
> the fixed image, the corrupted blocks_count is unchanged and other fields
> (e.g., free blocks count) are changed accordingly.
>
> e2fsprogs_version_used: e2fsprogs 1.45.6 (20-Mar-2020)
> The commands that I ran to recreate the scenario are:
> For image with only one superblock:
>
> dd if=/dev/zero bs=1024 count=8193 of=/home/hdd/image
> mke2fs -b 1024 image 8193
> debugfs -w image
> debugfs:  ssv blocks_count 4000
> debugfs:  q
> e2fsck -yf image
> e2fsck -yf image
>
> # e2fsck fixes the blocks_count corruption in correctly
> # In the clean image the blocks_count was 8193, in the fixed image the
> blocks_count is 4000
> #The second run of e2fsck is consistent with the first run, it doesn't fix
> anything, but blocks_count is still 4000
> # Expected that e2fsck would fix the blocks count corruption instead of
> changing other fields (e.g.,free blocks_count)
>
> For image with multiple superblocks:
> dd if=/dev/zero bs=1024 count=8193 of=/home/hdd/image1
> mke2fs -b 1024 -g 512 image1 8193
> debugfs -w image1
> debugfs:  ssv blocks_count 4000
> debugfs:  q
> e2fsck -yf image1
> e2fsck -yf image1
>
> # e2fsck fixes the blocks_count corruption in correctly
> # In the clean image the blocks_count was 8193, in the fixed image the
> blocks_count is 4000
> # The second run of e2fsck is consistent with the first run, it doesn't fix
> anything, but blocks_count is still 4000
> #There were 16 block groups in the clean image, but there are only 7 block
> groups in the fixed image
> # Expected that e2fsck would fix the blocks count corruption instead of
> changing other fields (e.g.,free blocks_count) and removing the block groups.
>
> I attached the images and also the logs from mke2fs, dumpe2fs and e2fsck.
>
> --
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You are watching the assignee of the bug.
