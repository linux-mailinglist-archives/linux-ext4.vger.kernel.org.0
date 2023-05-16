Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BADA70557D
	for <lists+linux-ext4@lfdr.de>; Tue, 16 May 2023 19:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjEPRzC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 May 2023 13:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjEPRyo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 May 2023 13:54:44 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D571FFB
        for <linux-ext4@vger.kernel.org>; Tue, 16 May 2023 10:54:43 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62382464ca3so2614846d6.1
        for <linux-ext4@vger.kernel.org>; Tue, 16 May 2023 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684259682; x=1686851682;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/erDpC8BVnuOTGydUZRBBP9NR8KrL+4iM6uBb52s9Pw=;
        b=O8VAduL5LXb9grUmrNPMbds5I89W7SPmiuNPtvIvCbE9K5tbYKfRaOLTBFBNCPa3d4
         4oJIxbvwERK74d0SxeQPaKysH3NXuWlhgp7uIpXqJsC6lY18UYvHihNPUKmLqwYPl2aL
         bu4RQIgo/VT79ax6HRKoPbgQObrqsEr0zBfG+MV9EjS2qfmPHLUuZ3Ly97gfzPZ2eika
         XWzIZlrUKZ6ho66RFQ13k0QwCvG1TAZGGB1xTiAQ3NJ+QNjHR79XdlKfa5H3FOGYXg9j
         t9j8DRknSj+vfRmx9lcM8Yvhs+uFfG/21VIb3YY8atNxFpUSNfFrekCPMUTB76MqMarI
         ptUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684259682; x=1686851682;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/erDpC8BVnuOTGydUZRBBP9NR8KrL+4iM6uBb52s9Pw=;
        b=hdo6H1KuLAjkXgeVUn8REsi5vlKkS4Q2vyk0X7kitVKvl9Qzi7+YEYIt5blB4OLMwM
         H+5GvlWutielC58GC8u4cE1Pk+HSZ2NaG6+GOM4qzq5I0k2hIoHuvaO71VMzeTNsiHw9
         j090xXdWtwMVRJdE5Tp20ctR4tfxQ+c5Cvx8zv4AyOqM0MuyYlvi0PIFoYiOEvTUk+fY
         FrVjSR9IXjpmnrOfgpgKTgFs/eB0BnUMf4FKscSTBEjD0l/fsLFOjLMyc67O6Kne/PPH
         /9nfaRN3dW5wSmIX3dbQmaSIGlbcogfXqnMk/Aj22BVsazTYPn7j2qvLXsU3I+I/J56c
         ijBw==
X-Gm-Message-State: AC+VfDxYQCIMNBa32DkD6JfmzGcQh1/YRwL5QlbY7gSv0n5ngnDhfWlt
        RfT6b8TJagMTdDDpwCnTcO4=
X-Google-Smtp-Source: ACHHUZ7HN/mtz4NndY0+sC+CshUzdvDAFQeQn/6fP0AJlDnjjLqJTAt5KtESSWDB0ASKhcGuarjggw==
X-Received: by 2002:a05:6214:5193:b0:5ef:4446:22f1 with SMTP id kl19-20020a056214519300b005ef444622f1mr55015698qvb.19.1684259682124;
        Tue, 16 May 2023 10:54:42 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id f8-20020a0cf3c8000000b0061b67ae2ff9sm5794769qvm.121.2023.05.16.10.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 10:54:41 -0700 (PDT)
Date:   Tue, 16 May 2023 13:54:39 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: 6.4-rc2 xfstests-bld nojournal regression - generic/231
Message-ID: <ZGPDX3pMMa3yg4yg@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted:

I'm seeing an apparent test regression on 6.4-rc2 while running the nojournal
test case with kvm-xfstests.  This is generic/231, which fails with 40%
reliability (or better) for me in 10 trial runs.  I'm not seeing failures in
the other test cases, including 0 failures in a 10 trial run on 4k.

The relevant output from 231.full is:

ltp/fsx -q -l 64000000 -o 65536 -N 20000 -S 12221 /vdc/fsx_file1
All 20000 operations completed A-OK!
ltp/fsx -q -l 64000000 -o 65536 -N 20000 -S 30719 /vdc/fsx_file1
ltp/fsx -q -l 64000000 -o 65536 -N 20000 -S 7219 /vdc/fsx_file2
ltp/fsx -q -l 64000000 -o 65536 -N 20000 -S 29252 /vdc/fsx_file3
ltp/fsx -q -l 64000000 -o 65536 -N 20000 -S 7909 /vdc/fsx_file4
All 20000 operations completed A-OK!
All 20000 operations completed A-OK!
All 20000 operations completed A-OK!
All 20000 operations completed A-OK!
ltp/fsx -f -q -l 64000000 -o 65536 -N 20000 -S 6375 /vdc/fsx_file1
All 20000 operations completed A-OK!
_check_generic_filesystem: filesystem on /dev/vdc is inconsistent
*** fsck.ext4 output ***
fsck from util-linux 2.36.1
e2fsck 1.47.0 (5-Feb-2023)
Pass 1: Checking inodes, blocks, and sizes
Inode 17 passes checks, but checksum does not match inode.  Fix? no

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/vdc: ********** WARNING: Filesystem still has errors **********

This test failure bisects to:  a44be64bbecb ("ext4: don't clear SB_RDONLY when
remounting r/w until quota is re-enabled").  Reverting this patch eliminates
the test failure (passes 100/100 trials).

Eric
