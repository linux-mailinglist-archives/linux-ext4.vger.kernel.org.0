Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD9B789C80
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Aug 2023 11:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjH0JFy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Aug 2023 05:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjH0JFg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 27 Aug 2023 05:05:36 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA10AC;
        Sun, 27 Aug 2023 02:05:32 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-79a46f02d45so625854241.0;
        Sun, 27 Aug 2023 02:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693127131; x=1693731931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1p/OfYP/CILEOwow8hS+QJZ2ORum3pGJZjhjujQrcE=;
        b=cS3hHxlURkh8ge5BxO7rsXVtz1rq+/bDKXwhLnYOLC8nhCsHDzlVNwSecndZxjSXqm
         6YdmmJfA9w4GTYifDZ+TQlHLPTdMMbPhUok53QNiYcVGuMDiUCj4R9BziTHIkoajnhkJ
         qQydYxNH8+iVJX0NAppkh/tKIjXIreH8QWAfiXwfklX6KBYOqHZ1wsEDHssItVwRStHu
         B1InE9a4cWuuoF8Ssp4YgYPg8xzGrrCz4knivBWfgpu6w5ol3oNPC9FL0x/1D7EdJIiK
         DfR3cTKxouHoYu97jymW6xnW3xHbInkTHdoEyaHRTSvZ0s4955MuQKvv2u6tl8lb/kK+
         sRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693127131; x=1693731931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1p/OfYP/CILEOwow8hS+QJZ2ORum3pGJZjhjujQrcE=;
        b=GLjd6u7FGtsy+Q2SLFUEjwsPaqbD+SXCHtUO4jxdteKeBgrjQeTFLaXTgUxb7p0q2P
         vW9n6O4n/8H+ekvRAvo2LM0EQtzZ5thwHDw1biBMm7gfsetKfZvWOvUBdcwcF+dqRRTN
         FZiv7HU1CtrcvNR0Ec58EPy19z0GkvBCmNrT9wzbrVHn3QcCc8qvhRysKpItxtXoKU/x
         RVm8jOrO7uVPFMbkzDKVtSEK7pdLupSeqKm6xx0yB7XcTIPysjKXsy3BD9VAlgrto4rt
         FQHR4zcZ0gGsF61X7RMElVN4yAyeRSJg1qu77XZiuf3kbQQnAzsCJ90prp7tGTyiQyb6
         Whlg==
X-Gm-Message-State: AOJu0YxFG/7CXwTWrpwd0HZAw8b2ORGMe7Bm/dv8leYO2GRaR9n4aRzE
        cu0F1xDr+30Dm9lxAkqz+kBhpRZAW/B9HTD9pF8=
X-Google-Smtp-Source: AGHT+IEd45DR1hQ0sTK/hCfS1Dnp7wuQpOSUYrtHwkWi4zlnfs7uVXvsi4rI98lbJG8+BeiGOaU85PoeeR+K0YKU/pU=
X-Received: by 2002:a67:f70b:0:b0:44e:98d8:c62e with SMTP id
 m11-20020a67f70b000000b0044e98d8c62emr7493396vso.33.1693127131508; Sun, 27
 Aug 2023 02:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230625135033.3205742-1-amir73il@gmail.com>
In-Reply-To: <20230625135033.3205742-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 27 Aug 2023 12:05:20 +0300
Message-ID: <CAOQ4uxiuHfECh6ARBma86DbDCDzNPa1wCCxXLB9CRWQShj8q4g@mail.gmail.com>
Subject: Re: [PATCH 0/3] fstests-bld overlayfs updates
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@google.com>,
        Alexander Larsson <alexl@redhat.com>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        fstests@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 25, 2023 at 4:50=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Hi Ted,
>
> The first patch enables testing the new overlayfs verity feature,
> which is NOT the same as saying that overlayfs supports fsverity.
>
> The other two are cleanups and fixes to overlayfs configs.
>

Hi Ted,

Ping.

Did these two small patches get lost?

FYI, Alexander's overlayfs verity patches are queued for 6.6
and his overlay/verity fstests have already been merged to
fstests release v2023.07.23.

It would be great if fstests-bld support to test this feature would
be merged as well.

Thanks,
Amir.

>
> Amir Goldstein (3):
>   test-appliance: enable verity for testing overlay over ext4
>   test-appliance: remove redudant overlay configs
>   test-appliance: skip overlayfs tests from base fs exclude list
>
>  .../files/root/fs/overlay/cfg/large-ext4           | 14 --------------
>  test-appliance/files/root/fs/overlay/cfg/large-xfs | 14 --------------
>  .../files/root/fs/overlay/cfg/small-ext4           | 14 --------------
>  .../files/root/fs/overlay/cfg/small-ext4.exclude   |  1 -
>  test-appliance/files/root/fs/overlay/cfg/small-xfs | 14 --------------
>  .../files/root/fs/overlay/cfg/small-xfs.exclude    |  1 -
>  test-appliance/files/root/fs/overlay/config        |  2 +-
>  test-appliance/files/root/runtests.sh              |  1 +
>  8 files changed, 2 insertions(+), 59 deletions(-)
>  delete mode 100644 test-appliance/files/root/fs/overlay/cfg/large-ext4
>  delete mode 100644 test-appliance/files/root/fs/overlay/cfg/large-xfs
>  delete mode 100644 test-appliance/files/root/fs/overlay/cfg/small-ext4
>  delete mode 100644 test-appliance/files/root/fs/overlay/cfg/small-ext4.e=
xclude
>  delete mode 100644 test-appliance/files/root/fs/overlay/cfg/small-xfs
>  delete mode 100644 test-appliance/files/root/fs/overlay/cfg/small-xfs.ex=
clude
>
> --
> 2.34.1
>
