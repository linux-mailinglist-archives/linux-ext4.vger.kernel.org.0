Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC0528A2B
	for <lists+linux-ext4@lfdr.de>; Mon, 16 May 2022 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiEPQVd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 May 2022 12:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbiEPQVc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 May 2022 12:21:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E776B39684
        for <linux-ext4@vger.kernel.org>; Mon, 16 May 2022 09:21:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so26733850lfg.7
        for <linux-ext4@vger.kernel.org>; Mon, 16 May 2022 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEO/IRgSrMqglPVj7IDec9RWfs8+x3aQSo76jnhMWPs=;
        b=SouOFJoJbjvTGBYF4DsTyxytNDa7tJFSL3o2OPi8r7WDJ6vnp7MT3gvYhLFwVGGlRZ
         mOLkf1FTPTMNqLBxeE/+ZwUmuAMZd49tyyHNreeH9UZUrRKjB6Vvt5+B975td2stY3Kf
         4zI8LWAM+oSKT8ziMuSPfhwyo3TiEw53NVWWNrBO8SQgKpOeUnP1sMjkiqnxqA5PXcoR
         M1sNKTnjM8g3BRZOW79vKZvaLtLRZUnN/jN3DK21tzzdFuWHYb4dQhgh0hz9CgfEFTeX
         cJrRp17tt6Lo+7gg+sVpzvzg4QZ5x+5o2zCobigz1IFTLYslkYVSguI/WW1aC7guWeJV
         yA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEO/IRgSrMqglPVj7IDec9RWfs8+x3aQSo76jnhMWPs=;
        b=B9odcR0xMLWJwCaMmpuuGzsZc5kRE+zV7xdCGX1vdpJsUf6zLK30YbSpSXE8cSpIjl
         GtehF4QA8IXJ+5Rou+vIg33AHckFFC7m5Wzwn+OvQAoXhtqQ2VQsfP6j2xe6DJ90Bc84
         3y3zSi48xi5BrVhGAQLY3RpDyyQBjR4N+3sWOk2/maw7tOVwUcw7Au0ASQHm+ZszHO59
         GLvx3dnexgrF0AUZWt7XZC4fTv3livXDy8VAIgEm7WU3Lt4coLAF7BEXji3ib3iGu2Ej
         4ILVww+umppgzHCyaWLXxyBvl8az4ssgIiaEt7j/9xwvrjjJiL3C+y/wdnG8hPYy17Gz
         sGbw==
X-Gm-Message-State: AOAM533yD4Zatzv2IjAu3qbNb0LuLqbpAgzTlay43ycM0iJc/KQx/rtw
        fftnDtkpNVGfVNyCH4mkq7QPKvapGdruqMSSNVs=
X-Google-Smtp-Source: ABdhPJz4flsJWnXg2xHEuGBiZELZoxgeUfmMswPANW8gVe7n5hngBMXPgMcpEjElfoDSXtNcyjsDFpbAJEDixv7q4iU=
X-Received: by 2002:a05:6512:3f01:b0:46b:a5ba:3b89 with SMTP id
 y1-20020a0565123f0100b0046ba5ba3b89mr13981440lfa.28.1652718088270; Mon, 16
 May 2022 09:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAKuJGC-uO-ywctcRH-i0UUfvzX3Yvep0kpSVi+FQXJjWgYMtdA@mail.gmail.com>
 <YoJmWmN6UMnzxLpI@mit.edu> <CAKuJGC__aRPGK2a8e5VK=aDzN92PbJoC3z=AM6x=vJ-g7vd5sA@mail.gmail.com>
In-Reply-To: <CAKuJGC__aRPGK2a8e5VK=aDzN92PbJoC3z=AM6x=vJ-g7vd5sA@mail.gmail.com>
From:   "Lakshmipathi.G" <lakshmipathi.g@gmail.com>
Date:   Mon, 16 May 2022 21:50:51 +0530
Message-ID: <CAKuJGC_4zx79fOrY9z6O+if5Aq_DBY8w6cmgvSXYeDzt+zvCGQ@mail.gmail.com>
Subject: Re: fast_commit option not recognized/supported by e2fsck?
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

>   sudo update-initramfs -u -k all

After running the above update, now it works!

> P.S.  fast commit is a relatively new feature, and we are still fixing
> bugs in fast commit.  So please be careful before using it in a
> production system, especially if it is mission- or life- critical. If
> you really want to use it, you may want to be using newer kernels than
> 5.13.0, such as 5.15 LTS.

Thanks for the warning :-) I was actually testing this for production
systems :p I'll wait until it reaches a more stable form. Thank you!

----
Cheers,
Lakshmipathi.G
http://www.giis.co.in https://www.webminal.org
