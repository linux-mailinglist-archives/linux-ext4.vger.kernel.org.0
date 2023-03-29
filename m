Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54BA6CD0BF
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 05:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjC2DhG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Mar 2023 23:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjC2DhC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Mar 2023 23:37:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC4C35AD
        for <linux-ext4@vger.kernel.org>; Tue, 28 Mar 2023 20:36:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e18so14211193wra.9
        for <linux-ext4@vger.kernel.org>; Tue, 28 Mar 2023 20:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680061017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKPA/fEp6Y8GE/rfc/c4zMqFp4+yZmBO+tg+7Y+LKB8=;
        b=lskYP87VnQMRxzjh5kLVoPj2E2LbdMp0gcoZC8kpa51niCTQzJH/rvPohG4T51LvH+
         1ogSxPR3h0wTdZwZO/VfBsS9WooONeskTN242P95JWwJxK06ETrMo9l/u5ZAKMITN5ZM
         hjxYE2JsGcJTia1XGk2bXBnZApLo2C+2lo8vxyr/aLWWvEL7ACqhr8qwjTXxJVyqW8WO
         1HC0RLfr+fllYveWsj08WGMYFi6yKuQXjGX6sl9QRYatjOAhkYvxogNbL+iMyxeo7p8X
         bfVvhO3qGe8nT8u8XVrCfWpB92PhoeFrDHsDGSd/NJiEXesXEC9hsEpDpAWl74++Dl1d
         yGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680061017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKPA/fEp6Y8GE/rfc/c4zMqFp4+yZmBO+tg+7Y+LKB8=;
        b=G+9xfNtBEaoBbWT8tzdw4bMbcqLxROmd89xpwduWFL/wYN+5v0P3wF2ygwBZU1NtlR
         EdpwRnWZiW6uTNd/sD2raFqmkB6x+cZAev3l/T2kwhhLOg4B+t40lI0XrKP/cH9EUK6X
         fCA4SMd26nLhh3RFvQU6KH32Cz/7mZ/1QrXhd9/cCfAKAvPIXsrWzpvlGndHhYSoE12I
         pcIgRtpkklAIF85BV7oCaXklC+gPlcDmRU+wSG3kSsYiFdhI8hAegoIhn/zh/f7r1h9o
         th66ruFaPC3hfWg/JDNxFuUUgO765v5JomFxfs0i9r/1zM+U6y5JkTgZ6kiAWmYzuOmo
         nNzw==
X-Gm-Message-State: AAQBX9eTFWPeuYfDF0dhz7dJ0gl0HlSiOw95eSYtiy3vteA2oqkSfcgz
        M8S1sQjmXRP7+zDlzpXpYH/EBTGVogQACsxqfeo=
X-Google-Smtp-Source: AKy350a+oUuNu1ilmmjM55cc/t0/JR4yYzhdtQnYuyE6ZWgpsJPQitmPyScGapfpbJFJN8kCCEtXczUA5klgjE2ihRc=
X-Received: by 2002:adf:e4d1:0:b0:2cf:e995:afef with SMTP id
 v17-20020adfe4d1000000b002cfe995afefmr3598450wrm.13.1680061017438; Tue, 28
 Mar 2023 20:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230324092907.1341457-1-cccheng@synology.com>
 <20230327092914.mzizhh52izbvjhhv@quack3> <CAHuHWt=LaNBwNy-1RY2-OZ4zGKEgTBfZZGWoQJSjL3ADbRRCoQ@mail.gmail.com>
 <08c67287-53d8-58ce-e4bb-b1656bc6013e@huawei.com>
In-Reply-To: <08c67287-53d8-58ce-e4bb-b1656bc6013e@huawei.com>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Wed, 29 Mar 2023 11:36:46 +0800
Message-ID: <CAHuHWtnPtMscpO+fxYncQ_K+T+j2AGxG75kimoL6gp5Q__GfTw@mail.gmail.com>
Subject: Re: [PATCH] ext4: defer updating i_disksize until endio
To:     Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, kernel@cccheng.net,
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

On Mon, Mar 27, 2023 at 7:17=E2=80=AFPM Zhang Yi <yi.zhang@huawei.com> wrot=
e:
>
> On 2023/3/27 18:28, Chung-Chiang Cheng wrote:
> > It's a pity that this issue also occurs with data=3Dordered due to dela=
yed
> > allocation being enabled by default. If delayed allocation were disable=
d,
> > it would not be as easy to reproduce.
> >
> > This is because if data is written to the end of a file and the block i=
s
> > allocated, the new i_disksize will be immediately committed to the jour=
nal
> > at ext4_da_write_end(), but the writeback procedure is not yet triggere=
d.
> > By default, ext4 commits the journal every 5 seconds, but a dirty page =
may
> > not be written back until 30 seconds later. This is not a short time wi=
ndow,
> > and any improper shutdown during this time may lead to the issue :(
> >

Thank you for the explanation from you and Jan. I agree that it is not the
responsibility of ext4 to provide application consistency, but this case is
not even crash consistent, although no sensitive data were revealed after
crash.

> It seems that the case you've mentioned is intra-block append write (no?)=
,
> current data=3Dordered mount option doesn't work in this case because
> ext4_map_blocks() doesn't attach inode to the t_inode_list of the running
> transaction. If delayed allocation were disabled, the lose data window is=
 still
> there, because ext4_write_end()->ext4_update_inode_size() is also updatin=
g
> i_disksize before writing data back. This is at least guarantee no store =
data.
> We had discussed this in [1].

Yes, you're right. I've reconfirmed my experiment and determined that this
issue can be reproduced with or without delayed allocation.

I've tried your previous solution of adding the required inode to the curre=
nt
transaction's ordered data list. It seems to work perfectly for me and simp=
ly
solves the issue, but the journal handling needs to be added back to the
delayed allocation write. Does it really have an obvious performance impact=
?

>
> [1]. https://lore.kernel.org/linux-ext4/1554370192-113254-1-git-send-emai=
l-yi.zhang@huawei.com/
>
> Thanks,
> Yi.
