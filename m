Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C9316BD87
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 10:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgBYJlP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Feb 2020 04:41:15 -0500
Received: from mail-yw1-f50.google.com ([209.85.161.50]:46836 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgBYJlP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Feb 2020 04:41:15 -0500
Received: by mail-yw1-f50.google.com with SMTP id z141so7104813ywd.13
        for <linux-ext4@vger.kernel.org>; Tue, 25 Feb 2020 01:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1ZEKigPuTcXie8xfs66gzYq90s8XhvoabWQhBrxo3jM=;
        b=ZOB07NqO0cYJj/aio9nIQmDJzIdlzEW0EP9biCGWCbltWSfln/4RarJtDCkXQzBwHG
         2PpL3yhUEOj5TudAKeimnE4lVyg/Fr179Ss04OKLKXp8R5Rx1M8V2KebbnCPhHVcinVP
         5mS039voZcgE/2NWDx04fuWyAGwsOa1htV2n1ocdjhiMPlUDMo3ZZaGTvYtzEEy2yZB5
         ie8/oYGKH6F5vEOhADmcUyiksSV8C/ry75wMlvTr8i1AVwmyCuU3dIH0EYCX4N6dsHvO
         a+ODydul6QXfMp9beZWuM9lTLooVdwChNouWPWr9gh+8cpNuZjqJ3PBQcAqY0Dob4Ms+
         462A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1ZEKigPuTcXie8xfs66gzYq90s8XhvoabWQhBrxo3jM=;
        b=NnrwuvZS8qJFm2SX8mVAO8vm/+8x5o2UCxKXIJx+bBLEdaQpgRMB3SVvG6bRcdu9jT
         QdKnSvm90UD5mW6XYbZOzwBxPCOz8VxYJJnAtsHba1GNvTrvlqnXWSKr4QtpV7dTBkVp
         tvQH1xSaLE7VKq0REvtVKl8la778mCpq0kvzQ1uzT8XgL7CwfOwOs6dm25WjxqHpQ8JE
         f6krL2GKc1hpyuRoA7OKKx7knflcBygq/JIBpZzLCmFANBp6pY28Y2lcesYokaup/aTe
         MiBhbwZfiGGns614FOvBQDzBrQoe0kNLzaQSfTx6zCUEYsZSfLdGkx/f3tvbp/WGUYsF
         0mvA==
X-Gm-Message-State: APjAAAXTBgGaHD8B0iubOs0iA3glcUpNcCRnhFiDR4fFrupgb7FmvNqD
        2stX2jqxRibPL3w2herhaiF0IEfACjfAxJU2t9td322tgiRfVA==
X-Google-Smtp-Source: APXvYqwc8XNbv7RK2tva+Dh1FGNcBWnSmlsitQAR3CeAYsn1FPCWJRUy98pCTAUD6wp5q4takkjwH7SaeI5ivLKXUq4=
X-Received: by 2002:a25:dd5:: with SMTP id 204mr12379689ybn.444.1582623672540;
 Tue, 25 Feb 2020 01:41:12 -0800 (PST)
MIME-Version: 1.0
From:   Alok Jain <jain.alok103@gmail.com>
Date:   Tue, 25 Feb 2020 15:11:01 +0530
Message-ID: <CAG-6nk9iqbkwUh_=v0xrH+YN81tN4eWWNQzOM8NHr-3uR8fveQ@mail.gmail.com>
Subject: Getting issue while creating ext4 file system
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Guys,

Thanks for your time to look into this
While connecting a block volume to my instance I m getting the below error
Command: mkfs.ext4 /dev/sdd1
Error Message:
mke2fs 1.42.9 (28-Dec-2013)
Could not stat /dev/sdd1 --- No such file or directory

The device apparently does not exist; did you specify it correctly?

Before executing this command I did run iscsi command to attach
followed by these partition commands, all completed successfully
parted -s -a optimal /dev/sdd mklabel gpt
parted -s -a optimal /dev/sdd mkpart primary '1MiB -1'
Any idea?

Thanks,
Alok
