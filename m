Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E4734A82
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jun 2023 05:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjFSDOJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 18 Jun 2023 23:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFSDOI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 18 Jun 2023 23:14:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFED9E
        for <linux-ext4@vger.kernel.org>; Sun, 18 Jun 2023 20:14:06 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3fdd37c16bfso9084801cf.1
        for <linux-ext4@vger.kernel.org>; Sun, 18 Jun 2023 20:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687144445; x=1689736445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKyRppiRwrrJIW1MqpLct0EWkMnjzLS74PdPWWkb/B0=;
        b=ZWoptBdRjkwOy8n4IGBBaTwaqO8r/CyVA173rqo9vk5sCjbg4CJpB3H77cALXGgEgW
         X5599/UOpUgOtHtELp/bBpHNmxH/dKDl9TIEp1E3PAS0IneBJPzYQ3QJKW1C2dImQGlw
         T5Vsbkz3ktx0K+R0SNShBb7hqNLIs5yRygJddtYqWh32U4jvKPV3voJ4IvEOVCt3A25c
         rnyMrcMXnPJZfoDElqm1MYXjlzzo/+GzjsupAiiT+zrvJtXm2eKza2kCX3o7TyIL4NnR
         F1VhWPTWd0RNMWC8NK48VK4IbI4GlaTIZblxqpC8YxPmR0pXvz+AQgxtChvquqT56t4k
         d5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687144445; x=1689736445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKyRppiRwrrJIW1MqpLct0EWkMnjzLS74PdPWWkb/B0=;
        b=EgXXDigEBWAVPyzp/yGY1K9Tw9zmJ+pnsWDYB7sQ7MhwJyucFGsjQIcpqyTmpjPu7Z
         aOObrQKVFGPp0/YIrBINmnt9sjxHGlDrfkQpHOryZQvJ9bEBaTrlTh8UdmfuiRk6e/NM
         aVbUZVdaBerR2HMzfxQebc4NSCZ75yNRMHJBp/qd2g1dCN39t3g8OXk/hKB2ONtvyxy6
         B/CiN4c6PHCFuTRnZUrV0Xo7eVEpcYJpQRhRglz1O7lJoqKocxh14ko79ChOeo4WCYvZ
         xo1k0+LQ4oq+KsbBLnjwSo1TpAlpSTI+SePfjcDSLQl+CxWPXzLYRxTcU1zcLjWQmr+P
         8mFg==
X-Gm-Message-State: AC+VfDzqpoQILbchj71aDCLuwJ8lVnmDL4THeHLMWjeupB46Q4DSRDeo
        9LtTJkvD8lsQaaoVjPXtl/OZMBlUrXQ5erCXVYuSpA==
X-Google-Smtp-Source: ACHHUZ4r+tLCi4WxRm54ooicxkgmRJVsOROyDMNmWnudaJXAbUB5UCRl472OMlT7NfLGnUrfE/Q4mIacwdjTLWXIlTw=
X-Received: by 2002:a05:622a:189c:b0:3f6:ab9a:3d8e with SMTP id
 v28-20020a05622a189c00b003f6ab9a3d8emr12570871qtc.4.1687144445674; Sun, 18
 Jun 2023 20:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230615111200.11949-1-changfengnan@bytedance.com>
In-Reply-To: <20230615111200.11949-1-changfengnan@bytedance.com>
From:   Fengnan Chang <changfengnan@bytedance.com>
Date:   Mon, 19 Jun 2023 11:13:54 +0800
Message-ID: <CAPFOzZtapph+eKWpOC0Wyx9qDcd6HngA9QQR0Kz2BzmSxEiZfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ext4: improve discard efficiency
To:     wangjianchao@kuaishou.com, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch free blocks too earily when do discard, maybe cause data
corrupt, I'll fix this in
next version.

Fengnan Chang <changfengnan@bytedance.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=88=
15=E6=97=A5=E5=91=A8=E5=9B=9B 19:12=E5=86=99=E9=81=93=EF=BC=9A
>
> In commit a015434480dc("ext4: send parallel discards on commit
> completions"), issue all discard commands in parallel make all
> bios could merged into one request, so lowlevel drive can issue
> multi segments in one time which is more efficiency, but commit
> 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> seems broke this way, let's fix it.
> In my test, the time of fstrim fs with multi big sparse file
> reduce from 6.7s to 1.3s.
>
> Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> ---
>  fs/ext4/mballoc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a2475b8c9fb5..e5a27fd2e959 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6790,7 +6790,7 @@ int ext4_group_add_blocks(handle_t *handle, struct =
super_block *sb,
>   * be called with under the group lock.
>   */
>  static int ext4_trim_extent(struct super_block *sb,
> -               int start, int count, struct ext4_buddy *e4b)
> +               int start, int count, struct ext4_buddy *e4b, struct bio =
**biop)
>  __releases(bitlock)
>  __acquires(bitlock)
>  {
> @@ -6812,7 +6812,7 @@ __acquires(bitlock)
>          */
>         mb_mark_used(e4b, &ex);
>         ext4_unlock_group(sb, group);
> -       ret =3D ext4_issue_discard(sb, group, start, count, NULL);
> +       ret =3D ext4_issue_discard(sb, group, start, count, biop);
>         ext4_lock_group(sb, group);
>         mb_free_blocks(NULL, e4b, start, ex.fe_len);
>         return ret;
> @@ -6826,12 +6826,15 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group)=
)
>  {
>         ext4_grpblk_t next, count, free_count;
>         void *bitmap;
> +       struct bio *discard_bio =3D NULL;
> +       struct blk_plug plug;
>
>         bitmap =3D e4b->bd_bitmap;
>         start =3D (e4b->bd_info->bb_first_free > start) ?
>                 e4b->bd_info->bb_first_free : start;
>         count =3D 0;
>         free_count =3D 0;
> +       blk_start_plug(&plug);
>
>         while (start <=3D max) {
>                 start =3D mb_find_next_zero_bit(bitmap, max + 1, start);
> @@ -6840,7 +6843,7 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>                 next =3D mb_find_next_bit(bitmap, max + 1, start);
>
>                 if ((next - start) >=3D minblocks) {
> -                       int ret =3D ext4_trim_extent(sb, start, next - st=
art, e4b);
> +                       int ret =3D ext4_trim_extent(sb, start, next - st=
art, e4b, &discard_bio);
>
>                         if (ret && ret !=3D -EOPNOTSUPP)
>                                 break;
> @@ -6864,6 +6867,14 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>                         break;
>         }
>
> +       if (discard_bio) {
> +               ext4_unlock_group(sb, e4b->bd_group);
> +               submit_bio_wait(discard_bio);
> +               bio_put(discard_bio);
> +               ext4_lock_group(sb, e4b->bd_group);
> +       }
> +       blk_finish_plug(&plug);
> +
>         return count;
>  }
>
> --
> 2.37.1 (Apple Git-137.1)
>
