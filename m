Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA3327A9E
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Mar 2021 10:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhCAJVy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Mar 2021 04:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhCAJVx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Mar 2021 04:21:53 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F337C06174A
        for <linux-ext4@vger.kernel.org>; Mon,  1 Mar 2021 01:21:13 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id a7so16903133iok.12
        for <linux-ext4@vger.kernel.org>; Mon, 01 Mar 2021 01:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=uuSqRwlnPptBCxKAu+L7SCXSu8mi05FUoA7AFp/UbNY=;
        b=kgdtF2o3E5Jp7HHqYDHbh78gq2/qr5eTMxSkTC6dl1d/1C2PhXlSaChL3bbnwKq3IO
         3qiEqVLDU+6P+OvE3ZujjV29g9xvXLeZIbeaH1f8n3M55NEnsG6bW9CovflM2AKNhdAp
         FiOgw1Uq9RgJE5O0NIhw0eKYNEvk0eLTpGYTQ4KpSVqc3pJ57A7G/IfjBA/S2As6iNvS
         909fAYouK9uHLYipIG0wuZ6fc7Ums5WT4PEkX9iBX6cw5Lwwe1SFW4tqJJZrcUK7+DrF
         +wietSFN2aAX8GLdO3P/hINVE0zTD5zepYrZRqPKreXhSfm9HPZyqC7E5Ka4YmFHHGY/
         3f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=uuSqRwlnPptBCxKAu+L7SCXSu8mi05FUoA7AFp/UbNY=;
        b=ZhKx29W/f4rWuz1yweb6LXoij58l3+FWoE1Kd+h03soO7LTVpbbAFil4AOVHWIAzwo
         dUvsj3wNFFQ9m5YeGpbb8miXSQB18SsiE2MkrQkq/8g2KLZCPtdZftMABWAXrM86Vl3n
         EIkZqzUHlcuMgDw5TBX9gnxpaxnzThuzeYHeHpWVtVyXK39c/1jLBeLWBKWXs+2/Czof
         vHWXsnU/kLjIFpa5sDZ1jk8kwszBR0iUs4QCa03uucm2diYF7fb897iufz7RmeLSY5xe
         cXzswgYJjR55NafadJJOgiK+jgkUJ/inBUoJr17EC5Av/OEJSHMp8yKqFlc6fhMd28l8
         OIGg==
X-Gm-Message-State: AOAM531FppdBLXjH7DmhOdhe9xjt3Cxzwo1CF3eoXiCBJv7dyHRf5tVs
        DL1sZ9RGHmJrf1Rw06jRnqUICr4bDbT5VFc6Rhc=
X-Google-Smtp-Source: ABdhPJwOwUGgcQZYBFVPZ5M2z/k/ziugGYynuLVIfkddpQGnGnol3MA3/f28LwPgi31S8eb5mzK7Hnl82KxU6ifNWno=
X-Received: by 2002:a02:b890:: with SMTP id p16mr14600331jam.138.1614590472982;
 Mon, 01 Mar 2021 01:21:12 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 1 Mar 2021 10:20:36 +0100
Message-ID: <CA+icZUXzjAniVZMzS5ePNa6HrjWL6ZrpAgzWufy74zHSyN+urQ@mail.gmail.com>
Subject: badblocks from e2fsprogs
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[ Please CC me I am not subscribed to this ML ]

Hi,

I am here on Debian/testing AMD64 and have e2fsprogs version 1.46.1-1
from Debian/unstable.

Just for the sake of completeness:
Here I use a selfmade Linux v5.12-rc1 (and pre-git as of yesterday).

To check the health of my disk I used badblocks the first time.
( All partitions are ExtFS-formatted on /dev/sdc. )

root@iniza:~/DISK-HEALTH# LC_ALL=C badblocks -v -p 1 -s /dev/sdc -o
badblocks-v-p-1-s_dev-sdc_$(uname -r).txt
Checking blocks 0 to 976762583
Checking for bad blocks (read-only test): done
Pass completed, 0 bad blocks found. (0/0/0 errors)

root@iniza:~/DISK-HEALTH# ll
badblocks-v-p-1-s_dev-sdc_5.11.0-11646.1-amd64-clang13-cfi.txt
-rw-r--r-- 1 root root 0 28. Feb 19:33
badblocks-v-p-1-s_dev-sdc_5.11.0-11646.1-amd64-clang13-cfi.txt

Unfortunately, the output-file is empty.
Do I miss something (order of options for example)?

The whole single-pass badblocks run took approx. 3 hours - last I
looked 50% was 01:26 [hh:mm].
On stdout (and in output-file) - no summary of the total-time.

Is that possible to have:

Pass completed, 0 bad blocks found. (0/0/0 errors) + <total-time_of_run>

Thanks in advance.

Regards,
- Sedat -
