Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7B235265F
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 07:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhDBFHL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Apr 2021 01:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDBFHK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 01:07:10 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1A4C0613E6
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 22:07:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y3so158515pgi.0
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 22:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ygzimTgFOeq3o3xHdu79pKaSSOIN+dC8HLkgcHUA3ME=;
        b=VUXdDB0Byaielwa/Ve63o8+++8I2z2qM1z2ThQLfS0/sKIrnp1tzh9+KZz1eknVawU
         ZL6UGWzuFYza26ZnNiB4IWwnYc0yvWspCZ2EpCLd+Glla/CxdI9FgFCa5i/VB7Q87qof
         r2So9ljkzTY3KNTRFkX6G0aMOMs4qQ9i6tWQSoV+YLfLJJStGx26/nxJq69ng8dhh/vP
         a33oteVBU6t+5D5b+wvNDLDXCQO9a+DCnWMt7/OXe/ceFrsU9rhf+RFjtvGJ9h0n54Rh
         lEX6I/bXnKibqz5YMlqrUX/Oc6g0ivi/bZyFaEtZ9U6Zqe0GskDH3eh2qD7NIjwLqkoS
         qcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygzimTgFOeq3o3xHdu79pKaSSOIN+dC8HLkgcHUA3ME=;
        b=NBjSoZxCtIg7BqrPZipmIVjUmJZiicQwxLJjimaNAR4EYEEqDHOAZ96FwTX0w3bwce
         f8T934CxwXjjeD1nJBX+BwdIkhnvPGaRWCcjdPCjHAlj7L77mVgtSEelYPZ+tnQjUO2Q
         mk+I92iAfc6q/BwewAvE049FmaO6zWPQRpNyCkG48tQPJqT/Wfd9H+yDW99iNnF0gNoN
         LCW8QUrJ/85f7jx7u4vFwvN73Eii2LbokoRaGz1DrTv3FCIqHYSDFFkqKOGleUPEoI/9
         hnXSpkU5mZ6PLFCmshdGPsq4CSJaeVcmSuGaJ3/dSsq6Z9241hM5r0a65nyPKqoi8xCL
         OVYQ==
X-Gm-Message-State: AOAM532352n1unZmTjvzXiz5/Lr+ddmJcsZQBjjeUKJy6MvRfsHa0Dbe
        Iqx1ZSvbOopuSPcnYRBLQxs=
X-Google-Smtp-Source: ABdhPJxfx6TzmzBd5VtEcvyDnJS7yxOIgwQy5mqPorSX6mL7VJrNP2yRt08q4RoMn8F28ptPOuYuIA==
X-Received: by 2002:a63:7a07:: with SMTP id v7mr10382144pgc.26.1617340026757;
        Thu, 01 Apr 2021 22:07:06 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id v18sm7061360pfn.117.2021.04.01.22.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 22:07:06 -0700 (PDT)
Date:   Fri, 2 Apr 2021 10:37:04 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, willy@infradead.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: generic/418 regression seen on 5.12-rc3
Message-ID: <20210402050704.js3xab67u7avlwbs@riteshh-domain>
References: <20210318181613.GA13891@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318181613.GA13891@localhost.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/03/18 02:16PM, Eric Whitney wrote:
> As mentioned in today's ext4 concall, I've seen generic/418 fail from time to
> time when run on 5.12-rc3 and 5.12-rc1 kernels.  This first occurred when
> running the 1k test case using kvm-xfstests.  I was then able to bisect the
> failure to a patch landed in the -rc1 merge window:
>
> (bd8a1f3655a7) mm/filemap: support readpage splitting a page
>
> Typical test output resulting from a failure looks like:
>
>      QA output created by 418
>     +cmpbuf: offset 0: Expected: 0x1, got 0x0
>     +[6:0] FAIL - comparison failed, offset 3072
>     +diotest -w -b 512 -n 8 -i 4 failed at loop 0
>      Silence is golden
>     ...
>
> I've also been able to reproduce the failure on -rc3 in the 4k test case as
> well.  The failure frequency there was 10 out of 100 runs.  It was anywhere
> from 2 to 8 failures out of 100 runs in the 1k case.

Ok, I kept the test running for overnight on PPC64, since as you mentioned
the reproducibility rate is less.

./check -I 1000 tests/generic/418  // this stops the test as soon as we hit it.

I could hit the test on 8th iteration of the test.
Note this is 4k blocksize on 64K pagesize.

<logs>
======
SECTION       -- ext4_4k
FSTYP         -- ext4
PLATFORM      -- Linux/ppc64le qemu 5.12.0-rc2-00313-gae9fda3a723 #66 SMP Sun Mar 14 23:05:24 CDT 2021
MKFS_OPTIONS  -- -F -b4096 -I 256 -O 64bit /dev/loop3
MOUNT_OPTIONS -- -o block_validity /dev/loop3 /mnt1/scratch

generic/418 320s ... - output mismatch (see /home/qemu/work-tools/xfstests/results//ext4_4k/generic/418.out.bad)
    --- tests/generic/418.out   2020-08-04 09:59:08.658307281 +0000
    +++ /home/qemu/work-tools/xfstests/results//ext4_4k/generic/418.out.bad     2021-04-01 18:27:47.498465793 +0000
    @@ -1,2 +1,5 @@
     QA output created by 418
    +cmpbuf: offset 0: Expected: 0x1, got 0x0
    +[1:0] FAIL - comparison failed, offset 32768
    +diotest -w -b 32768 -n 3 -i 1 failed at loop 6
     Silence is golden
Ran: generic/418
Failures: generic/418
Failed 1 of 1 tests

-ritesh
