Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278736CA16E
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 12:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjC0K3o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Mar 2023 06:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjC0K3U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Mar 2023 06:29:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D0661A3
        for <linux-ext4@vger.kernel.org>; Mon, 27 Mar 2023 03:29:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso7002810wms.1
        for <linux-ext4@vger.kernel.org>; Mon, 27 Mar 2023 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679912947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnuLCwRUqYuG4ttKHFUpMdC4OgObPQ+nUX4sCi/8Imw=;
        b=m+SjGwIVWIIJi47yHBHgkJMl+1UiszXLtLUr37B+5OKP7Df8f3pZhYAc+j7a3L+t3x
         TIrEMq5B4LPRIitH5yjNYZReeN24cvzpbw95/FOG8GL6+o906TudWkBgApToG+rujpEM
         51eCnzTgesYWuLpaxVTDluZIWXcdTpd9f0MLQOBnyAPCnOreH6WroECtnpMTXIjCLvEn
         VorLULtq08nq3WTerP7kElRWveLojMR6nAyOmamZHYQhLsHNxioAxHkoTEJzPl1XkSwM
         N4xrLf1dAfJX+b57YHVwZvplGaliaGeG3lW6Wqla0Ws4MRbgK5qQlmih9zwDG4JzdiYs
         B5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnuLCwRUqYuG4ttKHFUpMdC4OgObPQ+nUX4sCi/8Imw=;
        b=sHeO0wwyCID0c53rPlZSfPFQIqslXpL6XS3XjGSoK6seQLl1pIGXUzHCUjUqgxLx0m
         I/uEjNzK0wh8wHQnLhUnioxChaf1n6aIEXjYEdIn0K9RLMQfUBR3XWe9+3Z/EQ1yDAEY
         4dxmuwUFv9R+FVq9QjCnR/NvHVq1Tu/qD6l+wg0nzvUxKwGHFjWOgAUie2yOviNesH/B
         gcAgL5ge7fmLrrsCUPU1NmKs0dFBMV1ASBA2Jvr8R9FfeXhYeSGNr34GtEFlocM/WOF0
         v53XBnc1ttHyeOMLs0c7zfKVEzlU10OqdWuC1PTcI5QSJkMRm6H//UYuLMQ/wdVb9Vbb
         TJcA==
X-Gm-Message-State: AO0yUKVj5eGy2ezeXDyJQ+lGfGAU34VrJ1caY9StGJMDHjEGeABvsLSC
        pNpUVSyrCI8AP+ydfd2gP2OjAByq8bj8EsQFYtbHVbSkikTBMft+
X-Google-Smtp-Source: AK7set8DoB24e/hprYI0nDY1r+eatL0GzWHGkdO64wKqUkh+5SGCXwF/12U689WDwKQMK6HkIe7Mn/omif1WEHri5oc=
X-Received: by 2002:a1c:7406:0:b0:3ed:e6db:c7a9 with SMTP id
 p6-20020a1c7406000000b003ede6dbc7a9mr2608837wmc.2.1679912946658; Mon, 27 Mar
 2023 03:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230324092907.1341457-1-cccheng@synology.com> <20230327092914.mzizhh52izbvjhhv@quack3>
In-Reply-To: <20230327092914.mzizhh52izbvjhhv@quack3>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Mon, 27 Mar 2023 18:28:55 +0800
Message-ID: <CAHuHWt=LaNBwNy-1RY2-OZ4zGKEgTBfZZGWoQJSjL3ADbRRCoQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: defer updating i_disksize until endio
To:     Jan Kara <jack@suse.cz>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com, kernel@cccheng.net,
        Robbie Ko <robbieko@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 27, 2023 at 5:29=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> As Zhang Yi already noted in his review, this is expected at least with
> data=3Dwriteback mount option. With data=3Dordered this should not happen
> though as the commit of the transaction with i_disksize update will wait
> for page writeback to complete (this is exactly the reason why data=3Dord=
ered
> exists after all). Are you able to observe this problem with data=3Dorder=
ed
> mount option?
>
>                                                                 Honza

It's a pity that this issue also occurs with data=3Dordered due to delayed
allocation being enabled by default. If delayed allocation were disabled,
it would not be as easy to reproduce.

This is because if data is written to the end of a file and the block is
allocated, the new i_disksize will be immediately committed to the journal
at ext4_da_write_end(), but the writeback procedure is not yet triggered.
By default, ext4 commits the journal every 5 seconds, but a dirty page may
not be written back until 30 seconds later. This is not a short time window=
,
and any improper shutdown during this time may lead to the issue :(

Thanks.
C.C.Cheng
