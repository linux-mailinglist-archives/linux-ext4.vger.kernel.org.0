Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ADD7816BD
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Aug 2023 04:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbjHSCjA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 22:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244117AbjHSCik (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 22:38:40 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E143AAF;
        Fri, 18 Aug 2023 19:38:39 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4106eb44e64so7405691cf.0;
        Fri, 18 Aug 2023 19:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692412718; x=1693017518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZwhCwjDtTWBjVB0IrnL1Vfvj4aOSGOZqsrM0tJ8VXU=;
        b=nzmSWNYhIZKGfoBBbZn6xNLlQzWETNY8VMRRjojHTh4tqElvCO+mDkL4DgsLylrxRW
         /KX3jVWQGAvKHpcfBgvYtJRnXTRVkIC0kC/v+EElN1ILwv4SIryRgRV/whqlpDdbvU4c
         +PRRbRTMLImlBDAUJLCWUCLoZw0ftT/FL67Hu46ZHCRWkRGSckzRPsSngqfHSsP4GAu4
         /DZhIi9mBFgSAKC50C/NzGEgw9t0BojdYZFhjqB1eT/7qugsMgY6z1039AryfLOOX06p
         x4JLbieD+CJ82f9/4Dd/B3IM7/DoAXFYyPnPQ4iUa7FQfEQdmhiZd7j9ji+7CDD6h7HP
         GbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692412718; x=1693017518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZwhCwjDtTWBjVB0IrnL1Vfvj4aOSGOZqsrM0tJ8VXU=;
        b=jnOY8g0VdnK1z2TP/UaXacRWPlybiX/SdP1kCEwoCYTSKo38LBD17PD+xEWHLCjGyk
         +wsaH+pCnb7mnQxrUgQF6DdDs1Q6Z6OWVmsncbcDW6NwxuNwmos9ya1od3hGjPFKSRsK
         l3tuQ6RGS/taGGloMyCRccW9tWRR0+XycJkXHFicKUuVeIG5nVQgpxgrnh28nj31mYlN
         1zBaCTyLLW3s9GxHouiqP9zu6ExsquTEULxcGC1yTsN9rulFCgwdYnPwy/kAMjUofTx+
         lYQ9jkv5mPOW4JAM7k3QmyIYOFtUpT/sU2mY2RZJXaAf2NhLTXU3+C+09KeuCtnpej/P
         yWRw==
X-Gm-Message-State: AOJu0YwjSfVBKOHNFKv8O7EgAEH/MahXF1bSA6RUcXZgGipJP7shkA4U
        F5oi5coDbSmodw5lfiWInXkG6pQpEykolY33ycP53Puz6h2qa1m+
X-Google-Smtp-Source: AGHT+IGj2Ut6HctwWBmQ1s5YsHe0+JQy/zocuAMLVSkSl2DcUmnSDdj0eL5V1fDaNl6oPJKSEbs/T3UHZfnACiN+KqU=
X-Received: by 2002:a05:622a:309:b0:407:c2e2:2a06 with SMTP id
 q9-20020a05622a030900b00407c2e22a06mr1421607qtw.8.1692412718074; Fri, 18 Aug
 2023 19:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230807012654.55951-1-zhangshida@kylinos.cn> <20230817173123.GD2247938@mit.edu>
In-Reply-To: <20230817173123.GD2247938@mit.edu>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Sat, 19 Aug 2023 10:38:02 +0800
Message-ID: <CANubcdW1z4QqDsHuuTqGxa_P40uG2s6LRk=pCkk_zL0TmJULrg@mail.gmail.com>
Subject: Re: [PATCH] ext4: Modify the rec_len helpers to accommodate future cases
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
        Andreas Dilger <adilger@dilger.ca>
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

Theodore Ts'o <tytso@mit.edu> =E4=BA=8E2023=E5=B9=B48=E6=9C=8818=E6=97=A5=
=E5=91=A8=E4=BA=94 01:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 07, 2023 at 09:26:54AM +0800, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Following Andreas' suggestion, it is time to adapt these helpers
> > to handle larger records during runtime, especially in preparation
> > for the eventual support of ext4 with a block size greater than
> > PAGE_SIZE.
>
> Is there a reason for landing this now?  We don't have support for
> block_size > PAGE_SIZE yet, and this patch doesn't come for free, at
> least not systems with page_size < 64k.  These inline functions are
> *very* hot and get used in a large number of places.  Have you looked
> to see what it might do to text size of the ext4 code?  And whether
> the expansion to the icache might actually impact performance on CPU
> bound workloads with very large directories?
>
> I will note that there are some opportunities to optimize how often we
> use ext4_rec_len_from_disk.  For example, it gets called from
> ext4_check_dir_entry(), and often the callers of that function will
> need the directory record length.  So having ext4_check_dir_entry()
> optionally fill in the rec_len via a passed-in pointer might be
> worthwhile.

Yep, the best way to do it is to leave it unmerged until it is necessary.
At the same time, I will try to eliminate these regression concerns based
on these suggestions.

Cheers,
Shida

>
> Cheers,
>
>                                                 - Ted
