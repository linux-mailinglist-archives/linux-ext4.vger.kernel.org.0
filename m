Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC493F152B
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 10:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhHSI3K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 04:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236854AbhHSI3J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 19 Aug 2021 04:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629361713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dg1QHNHEPcnAlUuKvEtgG0f+Yicn4eK2QW74VmzbIiM=;
        b=JzU89ttEaYzw9KWY9qqJq/hcPaokEcBM7qgj3DP6E6yWf5GXYV4HA0wXjTbbptu2mNUEIU
        S2F6Z7Ua5S0H6Etr+P138YHshRhSgJ6K0cDv2BsS4QSinL7p7fIVox/m4QuZ8tcZA73fHd
        UkUMhsqAJitrcTkDJoz/4RWBj/a8LWA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-1-W41Pn1Pm61JHTDmoanOw-1; Thu, 19 Aug 2021 04:28:32 -0400
X-MC-Unique: 1-W41Pn1Pm61JHTDmoanOw-1
Received: by mail-pf1-f200.google.com with SMTP id g2-20020a62f9420000b029035df5443c2eso2708213pfm.14
        for <linux-ext4@vger.kernel.org>; Thu, 19 Aug 2021 01:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=dg1QHNHEPcnAlUuKvEtgG0f+Yicn4eK2QW74VmzbIiM=;
        b=no9a6FQDVXUDotqaKPcL5zFF+FK8E6m683sh+dwvW3hePBXN5UmEPfSGa3Ov6qP+Bm
         mgflluyqUiXZVCKM0QidqnQ+XLbU8cigfCRD1iFQ2MRql5EWwBi7YhLGOIGaAbCLK4dv
         SW0L38r2FqQ8fxZIKbc75ERFsv0RWBYyJgpPbVUdjmMDA81rRtkgmfgZ5m0zGb5FCXuk
         1r2TtoNvQ7jipDeG3NQX+yOydasU6aILeHea1JV0COwZ4ZmGpSPqN/wQv+4dNePUdj16
         pUFp0hKRVpHfGLLh+o+dT+n3Eh6rcv87S/NgVbO0sZzdA0wW51Wo2xfFd0/tmUfyg1Kq
         H/gQ==
X-Gm-Message-State: AOAM530ChGn78u8e2CJ66og7ir2/xXY5UTUo+2dQ76vYS3I/SrqL8kEl
        UNp/gHB0KtcQh+PMhWCGURJYp58ejrYzdc0mhsuk+nui0UAgBFkm+sMYFxAocw393wmf/m+MMJe
        dhNURbtIKw/Zgy9tq+vFe2w==
X-Received: by 2002:aa7:9096:0:b0:3e1:72fd:a614 with SMTP id i22-20020aa79096000000b003e172fda614mr13388554pfa.56.1629361711183;
        Thu, 19 Aug 2021 01:28:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8a556mppq2hwYTus4MA949CnEZKjrn2tP1ZzDWXTp7tkRgqW8BwlaLGcyE6bdJLFIA/XFkg==
X-Received: by 2002:aa7:9096:0:b0:3e1:72fd:a614 with SMTP id i22-20020aa79096000000b003e172fda614mr13388539pfa.56.1629361710942;
        Thu, 19 Aug 2021 01:28:30 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v25sm2333750pfm.202.2021.08.19.01.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:28:30 -0700 (PDT)
Date:   Thu, 19 Aug 2021 16:49:08 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, eguan@linux.alibaba.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: regression test for "tune2fs -l" after ext4
 shutdown
Message-ID: <20210819084908.lxdkn7lu34dzptjv@fedora>
Mail-Followup-To: bxue@redhat.com, fstests@vger.kernel.org, jack@suse.cz,
        eguan@linux.alibaba.com, linux-ext4@vger.kernel.org
References: <20210819080751.4189684-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819080751.4189684-1-bxue@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 19, 2021 at 04:07:51PM +0800, bxue@redhat.com wrote:
> From: Boyang Xue <bxue@redhat.com>
> 
> Regression test for:
> 
> e905fbe3fd0f ext4: Fix tune2fs checksum failure for mounted filesystem
> 
> This test runs "tune2fs -l" after ext4 shutdown. tune2fs reads superblock
> checksum from the buffer cache. On unfixed kernels, the checksum is incorrect
> until the writeout happens, so tune2fs fails with "superblock checksum does not
> match" in this case.
> 
> Signed-off-by: Boyang Xue <bxue@redhat.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

> Hi,
> 
> This is the v2 of the test. I have fixed various errors in this version
> according to comments for v1. Hope I'm not missing anything here. Please help
> review it. Thanks!
> 
> 
> JFYI, I paste the test log here:
> 
> On good kernel
> ```
> [root@kvm101 repo_xfstests]# ./check ext4/309
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 kvm101 4.18.0-305.el8.x86_64 #1 SMP Mon Aug 16 15:20:14 EDT 2021
> MKFS_OPTIONS  -- -b 1024 /dev/vda2
> MOUNT_OPTIONS -- -o rw,relatime,seclabel -o context=system_u:object_r:root_t:s0 /dev/vda2 /scratch
> 
> ext4/309 1s ...  1s
> Ran: ext4/309
> Passed all 1 tests
> 
> [root@kvm101 repo_xfstests]# cat results/ext4/309.out.bad
> cat: results/ext4/309.out.bad: No such file or directory
> [root@kvm101 repo_xfstests]# cat results/ext4/309.full
> tune2fs 1.45.6 (20-Mar-2020)
> Filesystem volume name:   <none>
> Last mounted on:          /scratch
> Filesystem UUID:          f1ffdc35-a925-4007-99ab-b8f3bdec21cd
> ```
> 
> On bad kerenel
> ```
> [root@kvm102 repo_xfstests]# ./check ext4/309
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 kvm102 5.14.0-0.rc4.35.xx.x86_64 #1 SMP Tue Aug 3 13:02:44 EDT 2021
> MKFS_OPTIONS  -- -b 1024 /dev/vda3
> MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/vda3 /scratch
> 
> ext4/309        - output mismatch (see /root/repo_xfstests/results//ext4/309.out.bad)
>     --- tests/ext4/309.out      2021-08-19 05:02:40.188366781 -0400
>     +++ /root/repo_xfstests/results//ext4/309.out.bad   2021-08-19 08:02:47.902366781 -0400
>     @@ -1,2 +1,4 @@
>      QA output created by 309
>      Silence is golden
>     +/usr/sbin/tune2fs: Superblock checksum does not match superblock while trying to open /dev/vda3
>     +Couldn't find valid filesystem superblock.
>     ...
>     (Run 'diff -u /root/repo_xfstests/tests/ext4/309.out /root/repo_xfstests/results//ext4/309.out.bad'  to see the entire diff)
> Ran: ext4/309
> Failures: ext4/309
> Failed 1 of 1 tests
> [root@kvm102 repo_xfstests]# cat results/ext4/309.out.bad
> QA output created by 309
> Silence is golden
> /usr/sbin/tune2fs: Superblock checksum does not match superblock while trying to open /dev/vda3
> Couldn't find valid filesystem superblock.
> [root@kvm102 repo_xfstests]# cat results/ext4/309.full
> tune2fs 1.46.2 (28-Feb-2021)
> ```
> 
> -Boyang
> 
>  tests/ext4/309     | 29 +++++++++++++++++++++++++++++
>  tests/ext4/309.out |  2 ++
>  2 files changed, 31 insertions(+)
>  create mode 100755 tests/ext4/309
>  create mode 100644 tests/ext4/309.out
> 
> diff --git a/tests/ext4/309 b/tests/ext4/309
> new file mode 100755
> index 00000000..8594d264
> --- /dev/null
> +++ b/tests/ext4/309
> @@ -0,0 +1,29 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat Inc.  All Rights Reserved.
> +#
> +# FS QA Test 309
> +#
> +# Test that tune2fs doesn't fail after ext4 shutdown
> +# Regression test for commit:
> +# e905fbe3fd0f ext4: Fix tune2fs checksum failure for mounted filesystem
> +#
> +. ./common/preamble
> +_begin_fstest auto rw quick
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_require_scratch
> +_require_scratch_shutdown
> +_require_command "$TUNE2FS_PROG" tune2fs
> +
> +echo "Silence is golden"
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount
> +echo "This is a test" > $SCRATCH_MNT/testfile
> +_scratch_shutdown
> +_scratch_cycle_mount
> +$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full
> +status=0
> +exit
> diff --git a/tests/ext4/309.out b/tests/ext4/309.out
> new file mode 100644
> index 00000000..56330d65
> --- /dev/null
> +++ b/tests/ext4/309.out
> @@ -0,0 +1,2 @@
> +QA output created by 309
> +Silence is golden
> -- 
> 2.27.0
> 

