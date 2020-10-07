Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C34285BF4
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Oct 2020 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgJGJiw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Oct 2020 05:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgJGJiw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Oct 2020 05:38:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DC4C061755
        for <linux-ext4@vger.kernel.org>; Wed,  7 Oct 2020 02:38:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d24so1510398lfa.8
        for <linux-ext4@vger.kernel.org>; Wed, 07 Oct 2020 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iastate.edu; s=google20150603;
        h=mime-version:from:date:message-id:subject:to;
        bh=vUOkbXK7Vzgcm7KtrOCLHPK8GVHRzrzqej168SESYLU=;
        b=RqdzF0ku2Mad6hdpHC5Njnaqv2J826nWtEEIONvcQvu4iV5kkPNsB8bcgCwiXsBYBQ
         a+SSqSuayEH8c/yegOmfQ4M+QWqDqaCsccl9fOo/znkmXxdtMyv+HHLW5yj4DtV8uZ44
         OV7r6yhOkgWze3dgaOJW61/8bqUC/mc8Swn58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vUOkbXK7Vzgcm7KtrOCLHPK8GVHRzrzqej168SESYLU=;
        b=jy4bPSVKsqzOtUiDWBBKLC27Q0kByqWrpLDRwh0iQc2fceZfgg+BmP7KUGffrrzftX
         Z8dLL2EMK4IhuovPm+JM33wXgK6kQLdycmGeEEyxGgdwVwedVDVIhR8vNKHvUDNClyaH
         UvpfcxcTtMgDL3hD8+FCOotWZx1/U8D+217RLuQAUdI+HKRbM19MhjVxLnZsX7zcMWIZ
         cusdOBv3h9VZDjXkn0lt+L8dWjUCG0nOH1z4e2ZtwYApFIGj9wQzQbLeQGOd7pnbVs0p
         QvDWTmHqfJY7Po5RMgcj1k2daoUQbHRFMHxVrwPJM/DwE4b3oPnq7zOEZMRREaOMjhW5
         XrQg==
X-Gm-Message-State: AOAM531Dh7BWHWjJKa9Tp9FdTm/FCZgYnS9KIgL/RsM1QvkNdPTBVXyF
        1iff1BSXLNrIBHUwaHUdjggGO+YorqlA1s+xX2zerNJS+Q1/WQ==
X-Google-Smtp-Source: ABdhPJyAGo8PWzGtoZkrqzAFbWId1LHAV8AGeUYCJl/QEyf0t3oCnQq2ePBa6Oc3LAGPz5EA0ZA6jzQ9x8MdU04QVNs=
X-Received: by 2002:a19:e45:: with SMTP id 66mr767062lfo.376.1602063529434;
 Wed, 07 Oct 2020 02:38:49 -0700 (PDT)
MIME-Version: 1.0
From:   Om Gatla <ogatla@iastate.edu>
Date:   Wed, 7 Oct 2020 04:38:38 -0500
Message-ID: <CAE0mYSWO0gEUebYXWs2M_4ZnWh6-Pm1U5F21iZCsAiqFjMq1Jg@mail.gmail.com>
Subject: Redo log for file system checkers
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello all,

Our research group at Iowa State University and Western Digital have
designed and developed a generic redo log interface for file system
checkers (fsck). The source code is available at:
https://git.ece.iastate.edu/data-storage-lab/prototypes/rfsck

The design of our redo log is based on the undo log feature available
in e2fsck and provides a transaction interface. We identified that the
existing undo log in e2fsck is not properly implemented and that there
are issues concerning synchronizing updates across the undo log file
and the device.

For further details please refer to our paper:
https://www.usenix.org/system/files/conference/fast18/fast18-gatla.pdf

I request the community to kindly review our work and provide us some feedback.

Regards
Om Rameshwar Gatla
