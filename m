Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF1212D05
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jul 2020 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGBTS6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jul 2020 15:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBTS6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jul 2020 15:18:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A4AC08C5C1
        for <linux-ext4@vger.kernel.org>; Thu,  2 Jul 2020 12:18:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id y13so14295731ybj.10
        for <linux-ext4@vger.kernel.org>; Thu, 02 Jul 2020 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JCumGnavVI6OO24Iz6vTh8ANROCCxWPwM7ZoCqxwS5E=;
        b=jOZHkQiJV91hekkwP6ufdBsT2PY2vjKnZn54uFiM6gGGAxe1RVQfmLic0wzjIfljWx
         WRV+cws7pmEEDO36CVUyhZZfA5luCbDjfswcqaeV6mRA5I8AalN1rh8Z+qoMyeBa/YCW
         svPpHAHoq691/1eK4eMcJhTAWw3r3llt9BON0zwO5AR14AGOtTqGRmLQJWIYCurZcOOw
         FrnCkl9HCvrBKW5AzJczX6cDmaJMtQ1IQAoS+h7YLsjrlKQDfwrxNRjyMiDbQP8h+qKH
         WdIPgoXttJpz0xOHQ6xE5qkFQbD6jyxPSEbaNu6AUn13dtx/5+0X2ly1LLdRjSyOKkxH
         PsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JCumGnavVI6OO24Iz6vTh8ANROCCxWPwM7ZoCqxwS5E=;
        b=rRvTjUXwXo6srfsNVd2liqfpKABqQyvjC+fZCM5pP8e3cb1xJDdPb/ctHH91piH76t
         scjJPASQQGG2FdpgekPCncTDr8hYOJGZXpZ27WvdvzuyVOogpHFIxofHpagKQ/53KvYa
         lOMLKVQ3fGhQFujh1wiMjS/M8SGLDtI8IUx3E4WGSnrSdzigtrJqI32XFrmekOoQXcYq
         QO5LMNYe+4uAEdmNrpZ507Bt7VyRn9d6EnOyj+L4lECnePzXrtmOA/87bcoaIEQsIZ6g
         QxUPJT5wYOyQrwYnaUYnsuWoOs1hn7S5jBepK6/cag1GNvNqy/9+mPl84V1Cc4s1s9ni
         s9Kg==
X-Gm-Message-State: AOAM530ad+d/tkpKMIauJzZmTXkcICB/G9yR7zZK28Xi6jxdSNdP1xtl
        /kgZDYpcc4Lk0qctw6S9BLzAMcpRpGaPy/puYq4wrRUOiGoQqQ==
X-Google-Smtp-Source: ABdhPJwTg4x+05bULMmfCbleM/Qfaj2FBbwGU/qTChNin0jifOiSjnI8CCrgVsdXf1dVN9BqLdw6bS73sW3r060dszM=
X-Received: by 2002:a25:bc81:: with SMTP id e1mr50426828ybk.375.1593717536275;
 Thu, 02 Jul 2020 12:18:56 -0700 (PDT)
MIME-Version: 1.0
From:   Alok Jain <jain.alok103@gmail.com>
Date:   Fri, 3 Jul 2020 00:48:43 +0530
Message-ID: <CAG-6nk9Cy6itStS917HxL7dvcy5=J+CCpSAqRoC9Um8P9LJ=kw@mail.gmail.com>
Subject: Grow ext4 filesystem on mounted device
To:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Experts,

I want to grow the ext4 file system on mounted device by running
resize2fs utility but it fails, same works in case of unmounted FS
with additional invocation of e2fsck utility.

This is what i am doing

1)Rescanning the device
echo "1" | sudo tee /sys/block/sdd/device/rescan
2) Extending the partition
growpart /dev/sdd 1
3) resizing the file system
resize2fs /dev/sdd1
resize2fs 1.43-WIP (20-Jun-2013)
The filesystem is already 43253499 blocks long.  Nothing to do!


parted -s /dev/sdd1 print free
Model: Unknown (unknown)
Disk /dev/sdd1: 177GB
Sector size (logical/physical): 512B/4096B
Partition Table: loop

Number  Start  End    Size   File system  Flags
 1      0.00B  177GB  177GB  ext4

Any help?

Thanks,
Alok
