Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB83320488
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Feb 2021 10:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhBTI66 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 20 Feb 2021 03:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTI65 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 20 Feb 2021 03:58:57 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E75CC061574
        for <linux-ext4@vger.kernel.org>; Sat, 20 Feb 2021 00:58:17 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y7so35963861lji.7
        for <linux-ext4@vger.kernel.org>; Sat, 20 Feb 2021 00:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gLo6T2X/dBxTXolHkZRnrkKFTE/1lwnNrtBdL/ZOox4=;
        b=Ab0fc+DXNK5Uv2cCyJa/1E0baTNeVAu5R1yuv8R0cOmNTsaso1qTNCyahZi6R+zzF3
         hjCbRT//JlY99YFWivZQqlzDGOnQZOeIOhOg8YySRV4BfK/vP2cfvSLf4UfYuqdGFOq7
         LxZB08Heff733LI5T751v9x9ycYGY3u+Niexz1+Tzv0yIlpy31AbMYzJ8TT9szjKIsUm
         uYAjLuM4uTlhGVp4WiN/2PahBUnzPaxNu6PqviDXixBdm/E9hsjD77PXdiWblia10CjR
         R79snRQ0kYDqvmzkjYn6A1BhRQw5NjaVkVD3E+sU47FuIbNquXMlxvP5MbIDer4PewMY
         dZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gLo6T2X/dBxTXolHkZRnrkKFTE/1lwnNrtBdL/ZOox4=;
        b=B94dELOgwbb0SVsu+U3zf6wQvdEJxHE5t7J702RmSR65VM1QqIRfUHucIEmmsVwQiV
         pwNUxhjd1xEX6UCmfTuVSMq6z786uv+eJTMOszVdbQ+/L3eU8yf8DbrDtFIT9CAaFUiP
         MXkG5ggF4tqwzuCqHD04PzdeUcYiOU8s23gGXoKNhbvmlDPmO7QSm4p02ijkUw9V9Hyg
         bVjZ7Z7VxWVC/SJPYuBPef1EXeyztnM4VYWx6ANpel7T9piPf0p1ARLPqREeivkhLGgq
         EZv98GQvWnyYDjODgPC4dvdm9fEpm0D5onQt172WXHtdF92m59+SSaOfk4ypsCarCPg2
         caRA==
X-Gm-Message-State: AOAM531WDK4VDJKeNwyBM2fQz4avkHhfaeomheq4rNjM+ZOlT9TnuUN+
        3GmjT6/QOsnQKkthfg9ES6Nk2T+3VDi5Tps1
X-Google-Smtp-Source: ABdhPJzYBXODGQm/UfTm9VJtCWL5nKfUUqWKU3nyi3ejzMgmGMlJs722pjRT4uuU2Kv/Opa94TxLVg==
X-Received: by 2002:a05:651c:17:: with SMTP id n23mr8865965lja.25.1613811495506;
        Sat, 20 Feb 2021 00:58:15 -0800 (PST)
Received: from [192.168.2.192] ([62.33.36.35])
        by smtp.gmail.com with ESMTPSA id l21sm1204949lfg.300.2021.02.20.00.58.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2021 00:58:14 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH 1/4] e2fsck: don't ignore return values in
 e2fsck_rewrite_extent_tree
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20210219210333.1439525-1-harshads@google.com>
Date:   Sat, 20 Feb 2021 11:58:12 +0300
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <CAADEDFF-59C9-411A-93F3-BE1AEBE1CE39@gmail.com>
References: <20210219210333.1439525-1-harshads@google.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Harshad,

ext2fs_iblk_set in the same e2fsck_rewrite_extent_tee returns a return =
code, but code is ignored.
Could you also add check there?

Best regards,
Artem Blagodarenko

> On 20 Feb 2021, at 00:03, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>=20
> Don't ignore return values of ext2fs_read/write_inode_full() in
> e2fsck_rewrite_extent_tree.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
> e2fsck/extents.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/e2fsck/extents.c b/e2fsck/extents.c
> index 600dbc97..f48f14ff 100644
> --- a/e2fsck/extents.c
> +++ b/e2fsck/extents.c
> @@ -290,8 +290,10 @@ errcode_t e2fsck_rewrite_extent_tree(e2fsck_t =
ctx, struct extent_list *list)
> 	errcode_t err;
>=20
> 	memset(&inode, 0, sizeof(inode));
> -	ext2fs_read_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
> -				sizeof(inode));
> +	err =3D ext2fs_read_inode_full(ctx->fs, list->ino, =
EXT2_INODE(&inode),
> +				     sizeof(inode));
> +	if (err)
> +		return err;
>=20
> 	/* Skip deleted inodes and inline data files */
> 	if (inode.i_flags & EXT4_INLINE_DATA_FL)
> @@ -306,10 +308,8 @@ errcode_t e2fsck_rewrite_extent_tree(e2fsck_t =
ctx, struct extent_list *list)
> 	if (err)
> 		return err;
> 	ext2fs_iblk_set(ctx->fs, EXT2_INODE(&inode), blk_count);
> -	ext2fs_write_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
> -		sizeof(inode));
> -
> -	return 0;
> +	return ext2fs_write_inode_full(ctx->fs, list->ino, =
EXT2_INODE(&inode),
> +				       sizeof(inode));
> }
>=20
> errcode_t e2fsck_read_extents(e2fsck_t ctx, struct extent_list =
*extents)
> --=20
> 2.30.0.617.g56c4b15f3c-goog
>=20

