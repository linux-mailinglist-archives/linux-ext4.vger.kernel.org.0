Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7936964FE7A
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Dec 2022 11:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLRKjw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 18 Dec 2022 05:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiLRKjq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 18 Dec 2022 05:39:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6469FAE6E
        for <linux-ext4@vger.kernel.org>; Sun, 18 Dec 2022 02:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671359938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tyO6GaWJEPdrRydeCYofiCnC/vVvQWTP2UHTEnmEL2A=;
        b=hyzyVanaA5tspnwTv2gVICOVea4PTbaD09v1TT4V6Z8iDYW/p+W4vEF9D3RwOB0zBuNmX5
        uThove3nXQHsCOIEdZJxQsmAcQWAeBKJ/4zNIQsZLO4jitVc+E3XjFx2L3WWoPouir9zBt
        TjEUq5H9EOgtbi5Z8mLulncq6sXMIGY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-336-5pd5zHXZOvqcuRbmXJLmAA-1; Sun, 18 Dec 2022 05:38:57 -0500
X-MC-Unique: 5pd5zHXZOvqcuRbmXJLmAA-1
Received: by mail-pl1-f200.google.com with SMTP id m16-20020a170902db1000b0018fa0de6aa6so4937250plx.18
        for <linux-ext4@vger.kernel.org>; Sun, 18 Dec 2022 02:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyO6GaWJEPdrRydeCYofiCnC/vVvQWTP2UHTEnmEL2A=;
        b=FhI6vUeQjECwDFAY8KKD+gjLDHJ4pM9BlbmbeEhdBR0ExYqR9KdnRRJJljt0cpEVXO
         uNi7cAJaPGE17SVoNQaEu51Cx7LGBF+1CG6x3igjxrfJvPSw/zyEjZdSZfMjM7EF4SkM
         ElyCUt2GwI6Kahi5NVr44Ov41gTGOTR5Cb9rs4s7dBHDW4EctmW3LdeFP+LLJ/6sxZOT
         oETmXyLZAoV2yQVjOxHd4mMFPMnzydEYZvmEs7XtNmPzYenl92bom+BKjV8RLe8AFD4H
         gT4EgcDLkWnF+HtmtBx+DRXBMaXsJsiiXMAXdSVktcxHzmZsl/UYsU/v8xj2xGn5GCkf
         HwKg==
X-Gm-Message-State: ANoB5pnys07b2L31+y+k31i6qZcEBgucHAlUpAm8pE4zkFcc6Os2TrXD
        Ctx3RLL0CObfc3W03kIQ3InfbUPWlPHWOAD0fol/encZDFFALhGQEjQbpw579i2a0Z0j2wyA1X4
        ztt1w4EKulyq3A2heHtvE5A==
X-Received: by 2002:a05:6a20:3d22:b0:a3:cc70:6dcc with SMTP id y34-20020a056a203d2200b000a3cc706dccmr55742904pzi.39.1671359935939;
        Sun, 18 Dec 2022 02:38:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6/AQPN5ocW67fi1WrHISvWq5/0jZenjHK4Dna4mCkbA71FxMv88CVYNEhFtzkimCldVI96mg==
X-Received: by 2002:a05:6a20:3d22:b0:a3:cc70:6dcc with SMTP id y34-20020a056a203d2200b000a3cc706dccmr55742887pzi.39.1671359935577;
        Sun, 18 Dec 2022 02:38:55 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902e88600b0017f8094a52asm4856255plg.29.2022.12.18.02.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 02:38:55 -0800 (PST)
Date:   Sun, 18 Dec 2022 18:38:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Why fstests g/673 and g/683~687 suddently fail (on xfs, ext4...) on
 latest linux v6.1+ ?
Message-ID: <20221218103850.cbqdq3bmw7zl7iad@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

fstests generic/673 and generic/683~687 are a series of test cases to
verify suid and sgid bits are dropped properly. xfs-list writes these
cases to verify xfs behavior follows vfs, e.g. [1]. And these cases
test passed on xfs and ext4 for long time. Even on my last regression
test on linux v6.1-rc8+, they were passed too.

But now the default behavior looks like be changed again, xfs and ext4
start to fail [2] on latest linux v6.1+ (HEAD [0]), So there must be
changed. I'd like to make sure what's changed, and if it's expected?

Thanks,
Zorro

[0]
commit f9ff5644bcc04221bae56f922122f2b7f5d24d62
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Dec 17 08:55:19 2022 -0600

    Merge tag 'hsi-for-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-h

[1]
commit e014f37db1a2d109afa750042ac4d69cf3e3d88e
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Tue Mar 8 10:51:16 2022 -0800

    xfs: use setattr_copy to set vfs inode attributes

[2]
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR

generic/673       - output mismatch (see /var/lib/xfstests/results//generic/673.out.bad)
    --- tests/generic/673.out	2022-12-17 13:57:40.336589178 -0500
    +++ /var/lib/xfstests/results//generic/673.out.bad	2022-12-18 00:00:53.627210256 -0500
    @@ -51,7 +51,7 @@
     310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
     2666 -rw-rwSrw- SCRATCH_MNT/a
     3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
    -2666 -rw-rwSrw- SCRATCH_MNT/a
    +666 -rw-rw-rw- SCRATCH_MNT/a
     
     Test 10 - qa_user, group-exec file, only sgid
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/673.out /var/lib/xfstests/results//generic/673.out.bad'  to see the entire diff)
Ran: generic/673
Failures: generic/673
Failed 1 of 1 tests

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR

generic/683       - output mismatch (see /var/lib/xfstests/results//generic/683.out.bad)
    --- tests/generic/683.out	2022-12-17 13:57:40.696589178 -0500
    +++ /var/lib/xfstests/results//generic/683.out.bad	2022-12-18 00:04:55.297220255 -0500
    @@ -33,7 +33,7 @@
     
     Test 9 - qa_user, non-exec file falloc, only sgid
     2666 -rw-rwSrw- TEST_DIR/683/a
    -2666 -rw-rwSrw- TEST_DIR/683/a
    +666 -rw-rw-rw- TEST_DIR/683/a
     
     Test 10 - qa_user, group-exec file falloc, only sgid
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/683.out /var/lib/xfstests/results//generic/683.out.bad'  to see the entire diff)
Ran: generic/683
Failures: generic/683
Failed 1 of 1 tests

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR

generic/684       - output mismatch (see /var/lib/xfstests/results//generic/684.out.bad)
    --- tests/generic/684.out	2022-12-17 13:57:40.766589178 -0500
    +++ /var/lib/xfstests/results//generic/684.out.bad	2022-12-18 00:05:27.597220255 -0500
    @@ -33,7 +33,7 @@
     
     Test 9 - qa_user, non-exec file fpunch, only sgid
     2666 -rw-rwSrw- TEST_DIR/684/a
    -2666 -rw-rwSrw- TEST_DIR/684/a
    +666 -rw-rw-rw- TEST_DIR/684/a
     
     Test 10 - qa_user, group-exec file fpunch, only sgid
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/684.out /var/lib/xfstests/results//generic/684.out.bad'  to see the entire diff)
Ran: generic/684
Failures: generic/684
Failed 1 of 1 tests
....
....


Thanks,
Zorro

