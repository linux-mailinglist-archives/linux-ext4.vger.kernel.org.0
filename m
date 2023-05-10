Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADEA6FE461
	for <lists+linux-ext4@lfdr.de>; Wed, 10 May 2023 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjEJTEL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 May 2023 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjEJTEH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 May 2023 15:04:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C0959E9
        for <linux-ext4@vger.kernel.org>; Wed, 10 May 2023 12:03:41 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33164ec77ccso385065ab.0
        for <linux-ext4@vger.kernel.org>; Wed, 10 May 2023 12:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683745420; x=1686337420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbhNMNTbdw0qSNr0k4GpjBRX50qyOAXsQymwFeq14SQ=;
        b=ALKj+cgF6QebrDIyAnmVX9FjK0szrVsXsON/2iAcGk0STw53FR1dwLN7acc5qq5JEP
         zTfJzSZx4XigbhJsQJzq55FJCy3hUPonwmhltIzQu6RXKjP/S+DHm6Xmv11fyYjSCtg6
         Y05NP1Q8h+wTJIgIQdP2sMwFzQAv/gbnNSRDF5OKxvpUQ/g8+9RvWr5zGpPqNZmcY+t0
         tXG65o7WNuwLUWNV0DeN2rOJmlhmAPIHZQphqhRRzGwGZRPr+TRKgK4/4UHLf+ndm49i
         ZdHFOY0JrGWBMXytzvLWAqnvwblCdIXDo2Gv9iFRNu5uarqlfLODc62jEfzAm8iztL2O
         3HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683745420; x=1686337420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbhNMNTbdw0qSNr0k4GpjBRX50qyOAXsQymwFeq14SQ=;
        b=W0OQC8YZ2vs5hX1GRIsrlwzujWtK1AYO64+ccI2gOM7ph+pNonj2oETAHu0WQW8fmk
         0mKptu3vrhq33PVNhY1B1zYasYkevda+v6QDt0S/4v6BWxHtlrvUEqVRnkYBU8Mkk0BX
         z8hUQtSIWyLfSFkl2P7IBw6LwhMRii98NRtM2mqLS83M5610F7LBRfxH5eye9qlv5AIn
         i1CNDnNqoWhCmtUv5LwzvGnyuMFF2qTQS+vN9H1Ac3uMPDtp1lQLzHDjdnhIFOFU/EeK
         7rWse+y4i1spNotqAcvkTChywVRU0Y3uN0P5Dl8/t57+1VWbMx5NecY5HpG3XrR01zuI
         H3eQ==
X-Gm-Message-State: AC+VfDxB8i5v6yv1PMdjiQzpDLF4cdI6lmnVD1xzf48NUXqnZjyAjUwL
        8agoiRIk+mA06HwMsYKWxkjbe71jEc6MdV9FoAkg44NuqFPsg5R8EEE=
X-Google-Smtp-Source: ACHHUZ6veQGLSpr6GGUnXWOfjv15A2Rk/hJDrJPU/i7J6ttYheTKI1yAN0to5XpAHpU2QEXKoI2EPyA9y24FdQDEIy4=
X-Received: by 2002:a05:6e02:1d03:b0:331:2623:c5f4 with SMTP id
 i3-20020a056e021d0300b003312623c5f4mr24618ila.1.1683745420690; Wed, 10 May
 2023 12:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZFvpefM2MgrdJ7v4@mit.edu> <000000000000bd687205fb5b7714@google.com>
In-Reply-To: <000000000000bd687205fb5b7714@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 10 May 2023 21:03:29 +0200
Message-ID: <CANp29Y6kwK_BAjtOrc0_3NhOzU1RaA2dH2ctwE3uRHg-S56P0g@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid
 context in alloc_buffer_head
To:     syzbot <syzbot+3c6cac1550288f8e7060@syzkaller.appspotmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz set subsystems: mm

On Wed, May 10, 2023 at 8:59=E2=80=AFPM syzbot
<syzbot+3c6cac1550288f8e7060@syzkaller.appspotmail.com> wrote:
>
> > #syz set: subsystems mm
>
> The specified label "mm" is unknown.
> Please use one of the supported labels.
>
> The following labels are suported:
> missing-backport, no-reminders, prio: {low, normal, high}, subsystems: {.=
. see below ..}
> The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems=
?all=3Dtrue
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000bd687205fb5b7714%40google.com.
