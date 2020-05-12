Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686451D002A
	for <lists+linux-ext4@lfdr.de>; Tue, 12 May 2020 23:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgELVJa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 May 2020 17:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726324AbgELVJ3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 12 May 2020 17:09:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB2C061A0C
        for <linux-ext4@vger.kernel.org>; Tue, 12 May 2020 14:09:29 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u20so5037687ljo.1
        for <linux-ext4@vger.kernel.org>; Tue, 12 May 2020 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to;
        bh=QrdeiwPOaLeiQU5fVLZhQO3+YcM1zVUJBdHK2z33Hn0=;
        b=DO8q2KqQVqQLFjuGKD4BpbJRaQFKmPwZzNaBCFWjis4v37INkz57upQu27wtscekTY
         n3HeJnTT4QWQIql32ZkczMjhpG15jTB9hVjdGZw7wvMYKcV5W6xr83wWNRkR84zqTI5/
         fO7B1tr88hC/9TW6q8GREX8k67hilNiiuE9949TgCryIDKQ+spT72W0tha+ghnnQUhDV
         vWNq8AssrsXNDfbssranYt9f/RZ2uuCrfcjKzcDRMYpYc3zcq/6p6aA2n6zHPkfRnk2Q
         Yiifjt3ygorWVJ9yVkCzuq55UJMAtIndSYlzZmJKint5H9M31/i0uIGqDOBqBF8jnKFd
         32yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=QrdeiwPOaLeiQU5fVLZhQO3+YcM1zVUJBdHK2z33Hn0=;
        b=onshTcFdl8D65y+c+hsQcoyjJx5f6nbP+DMPOM867IhBVG0qmRid1qabWpH1cG9fN6
         3a5GcFM6lz8N8AZe8avMtFjarTMDN9e/Nwhfepg43VPt0dblPOepkXdSIW8s3gqLKC9N
         IzXqsB1fTdsEu2Yg+spOBxTdt/dwjP+gSS88ZIdTbwifD5KrldqsPnoxkB4qjffG9LzK
         FpBGU1cvj4sURuukt4HTCYKlTIqvm2XVasvyU0IXk2m01PrwYlvuPueTQJo9GT6DnEAH
         s7+9Pq7k6Hi7scUc7iMRHiSzVqP+OffPOOQMym/raM8AkxrPsHEJ5RtP0+X0BkWAZAbD
         1/SQ==
X-Gm-Message-State: AOAM531FWNE9PTBXwsiEmeHVWNR3FOPyGN8sFwsegP/CrTUOv3OPxbTX
        f4IXGGCCxR1glXRyIZOzo+ExSg6Tc0xz2yDjBpWGbm1G
X-Google-Smtp-Source: ABdhPJz3wV8nZ6ghoXrxhUfLBap0l0Iqy8eGfWkgaYeJkF1xaT48TWkCKMZH6CdqxLgXTCcgKnJ+MKYlRUfzUkBWBtY=
X-Received: by 2002:a2e:80c1:: with SMTP id r1mr14290816ljg.227.1589317767796;
 Tue, 12 May 2020 14:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPA0+rx8eLJU6j1uus2bBY63SrY_WC4TU_WTy0MoXk031wNjJw@mail.gmail.com>
In-Reply-To: <CAPA0+rx8eLJU6j1uus2bBY63SrY_WC4TU_WTy0MoXk031wNjJw@mail.gmail.com>
Reply-To: julio.lajara@alum.rpi.edu
From:   Julio Lajara <ju2wheels@gmail.com>
Date:   Tue, 12 May 2020 17:08:51 -0400
Message-ID: <CAPA0+ryNcZM7ch_beUHkj=s1_FOo7myV=OiY=4qNwoYeAg6FDg@mail.gmail.com>
Subject: Reducing ext4 fs issues resulting from frequent hard poweroffs
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all, I currently manage an IOT fleet based on Intel NUCs running
Ubuntu 18.04 Server on SSDs with etx4, no swap. The device usage is
more CPU bound than I/O bound and we are having some issues keeping a
subset of devices running due to them being hard powered off in the
field in some regions (sometimes as frequently as every 12hrs). Due to
current difficulties in getting devices back from the field I'm
looking into tweaking them as best as possible to survive these hard
power off barring any physical SSD issues.

Currently I have tried tweaking some ext4 and I/O settings with the following:

* kernel options:
  elevator=noop fsck.mode=force fsck.repair=yes

* fstab ext4 specific mount options:
  commit=1,max_batch_time=0

Are there any other configuration settings or changes to the above
that would make sense to try here for this use case? I am hoping to at
least make the fsck repair the last line of defence so it doesnt get
stuck waiting for a prompt to repair it at boot, but want to try to
change the I/O / ext4 behavior if possible so its writing as
frequently as sanely possible to try to reduce the frequency where
fsck is actually needed.

Thanks,
