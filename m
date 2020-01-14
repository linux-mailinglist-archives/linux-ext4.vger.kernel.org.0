Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEAB13AE50
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 17:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgANQEb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 11:04:31 -0500
Received: from mail-yw1-f46.google.com ([209.85.161.46]:42350 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANQEb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jan 2020 11:04:31 -0500
Received: by mail-yw1-f46.google.com with SMTP id l14so9415480ywj.9
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2020 08:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2Hnd5hqkHODpIhJgoDjUxxgBahxGOLvwgQd81tSfF5c=;
        b=Jkr/tiOvyYWDtcX2wFA8yXeIFeZHNioP4aNN4XRxvY516qmzsQuzSiRjc/bLSoTFdY
         XhBC7ZuJWqnj50TMqoaMOaXvuD0vDNqoli3LI0JfjFJ4FKl22r2eleEvtieowjdalVbo
         eco67qeyDPXTUcpbNEmg748LO9Hu1Yax5nXNDHgAiNprxooVS0Uqq9p4ZTCYyySq07If
         oB5HHuE2PmAwvH7mCNgh7uewqhm5XxO9UyxN1Ql889P9gFoL9chFGF15lszNB3YubQkd
         F7xkJeuSc3ix5U6XeQqPw9VgF3hfo5ZsE5K1rQglQkhtZgj9XofZudJN9LW32s1CwAG2
         hKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2Hnd5hqkHODpIhJgoDjUxxgBahxGOLvwgQd81tSfF5c=;
        b=kgWW2m1EO8h2kRDf04fzR4YpBCcncKseqKy6qq4/dKdktK7byMMpIJsfjULYO/8iY0
         UBVe10us+upm9vr+wgqetNT9YAksJpDQQld7DgzT5IVZuZp0KDfYB001S5EbTBg6I4ft
         ibf6vHVWCKvS0doH3pabvwmOP8VLIUlL1iUaAKXcneukJ1wnkEjjipkEV/8sNMxEcTjC
         38H97bNuPWQM4dfxLAL6ccWQl16PUDkHQWE9i8WQq9pcoREhaE4mPkbv2SoZrIUK4zPt
         QBRhSNEpD16hUiJXZ0ynvBa4HdH+QT1ILuTBznl4k/F+U/Kjj7a3ynj1083qjQHczyfZ
         PNwA==
X-Gm-Message-State: APjAAAWPO6g0azHeQLOZ11Of2usTKAShW4w2ymSXMob4cBN/JqjMkd9F
        KK9DWsGLn2+e7iyaO3cHPYw3E/Ah15sj8pPOERV5kWXT
X-Google-Smtp-Source: APXvYqz9R6mOIx4rGO3+Jzo4V7DHODk678p4thbeTxjn0LJq7NUS2oWhK36MgYsQfn9EV0fyTrjvHAlef2q6Ayixtmc=
X-Received: by 2002:a0d:f185:: with SMTP id a127mr18347314ywf.206.1579017869828;
 Tue, 14 Jan 2020 08:04:29 -0800 (PST)
MIME-Version: 1.0
From:   James Courtier-Dutton <james.dutton@gmail.com>
Date:   Tue, 14 Jan 2020 16:03:53 +0000
Message-ID: <CAAMvbhFjLCLiLKhu5s7QtLdUY29h8eZ2pHd120o94gDduo+BLw@mail.gmail.com>
Subject: ext4 recovery
To:     linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Say I started with 1 disk using LVM with an ext4 partition.
I then added another disk. Added it to the LVM group, expanded the
ext4 partition to then fill 2 disks.
I then added another disk. Added it to the LVM group, expanded the
ext4 partition to then fill 3 disks.

One of the disk has now failed.
Are there any tools available for ext4 that could help recover this?
Note, I am a single user, not a company, so there is no money to give
to a data recovery company, so I wish to try myself.

Is there a mount option that will mount an ext4 partition even if
there are lots of sector errors, or a missing disk. So, at least some
of the files will be recoverable.
Or a tool that will scan the disk for super blocks, then find inodes
and then find the sector location of the files, even if they don't
have filenames.

Kind Regards

James
