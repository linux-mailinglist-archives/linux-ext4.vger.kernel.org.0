Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B481F9DE0
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jun 2020 18:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgFOQyq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Jun 2020 12:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgFOQyp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Jun 2020 12:54:45 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753AEC061A0E
        for <linux-ext4@vger.kernel.org>; Mon, 15 Jun 2020 09:54:45 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r18so9342637ybl.5
        for <linux-ext4@vger.kernel.org>; Mon, 15 Jun 2020 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TqaF1SNH764R5q+IqNOURmEmi2vAm/8ba5Mao92PUJc=;
        b=vc8IEwwinKFNTjtbpRuPJ9QHHN/zWT7zyuU1FJQb8c+8XvjidArvDqtzLgTAWq42zQ
         8dQ//cJYL7cTd/onmhrhIr4ECEfyRx8eidVW64H/Ae06AMof6pcMGPJFloWj4LQOR9gb
         wSD9TvkiAjbd/iql21huhofIMyUm0WT9/xq6vjj4WRwjNPe8VPqwGoI+ZtK4recqczy2
         4BHm+Lrj9M2wDOHO/ylCRAcn6J1d/Shj8w8nFxowdsmAx63D6OrwjVu+oErM/raEUtvG
         jYMhlSYTA5nC6NGN/8NQsgdGsa3mKWRfH/xKbgqM2ciFhlO5ekU4AqM/g3Qs+N5i5zzC
         A8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TqaF1SNH764R5q+IqNOURmEmi2vAm/8ba5Mao92PUJc=;
        b=KOoSUT1FFhaeK6rqGKkEew1w9tJbj88hpcxoQ95G5MBBevFBa+PCjy9ii21z3WgMKc
         bU2HKrt09jUAATb61FUXqNq06xG2Yy6z70A7we1/uA1AWkHgqONShyjcg6/Q7R5UEr85
         bLrHJ6BixukPyY7Tqq3HaxRzWDYZIaCEv2WSIAsQldTGwo2nwlmxS7cIgoB+3GZbbRlC
         mgkY9t5xDC04IJVHJF6CU+6REovuwl2KY66dNy64bqin411lGatGwNpEnm2CRAO93HjF
         XWLHzph7RvmqViw4NMUMNeZrlV50UcC8LoexhHrXHUxmnqntPCtmsrtTu1pMSd+t2+iy
         9MWw==
X-Gm-Message-State: AOAM532z//ZGSt6CO0WgqLCeKGnXABXmezNCRYuxCEtq+NxLf/jF/BdI
        xUYTZbdRdvU5p7pb6L2I5Nc0Rd5ZyCIlG07bIsL3e3ZL
X-Google-Smtp-Source: ABdhPJx3Jk7eAUOFVbm5BCIbAilwOEWe7YjGC4VwIa2kge7T9mpRWhZcRIxFTGJ5/1XZUiY1vcOsDT4rlgOuD7N++Tk=
X-Received: by 2002:a25:9d0f:: with SMTP id i15mr43755488ybp.508.1592240084067;
 Mon, 15 Jun 2020 09:54:44 -0700 (PDT)
MIME-Version: 1.0
From:   Alok Jain <jain.alok103@gmail.com>
Date:   Mon, 15 Jun 2020 22:24:33 +0530
Message-ID: <CAG-6nk9hZUxDERrjbvwUReGtepnQA5bNWeNPyVa9x_+WCQ2W9w@mail.gmail.com>
Subject: Problem in updating UUID in ext4 FS on block device
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Expert,

 I am facing issue when I updated the block device UUID (ext4 file
system,  command: tune2fs -U random /dev/sdX1) and remount the FS,
sometime below error is coming while mounting the device.

 wrong fs type, bad option, bad superblock on /dev/sde1,
 missing codepage or helper program, or other error
 In some cases useful info is found in syslog - try
 dmesg | tail  or so

  I had to run fsck utility to fix the corrupt superblock which update
the UUID back to original value, looks like UUID is not getting
updated in all the superblocks.

Any idea how to replicate UUID to all the superblock? and also check
if it got replicated properly

Thanks in advance!
Alok
