Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC42D4EBA
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 00:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388018AbgLIXZd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Dec 2020 18:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLIXZd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Dec 2020 18:25:33 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85986C0613CF;
        Wed,  9 Dec 2020 15:24:52 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so4661051ejj.5;
        Wed, 09 Dec 2020 15:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkDUNHuZH8W689678VfNtJ4EUTRBTUIakwlkMZkzZFk=;
        b=PqNpPXp4r8Xs0rVDw2BmhT46xgmv2pvmOxRevsPBKAhDtokinSZ1ext8vD3Qey7Pw6
         xIc4HVJupcRw8aPPy7/JoGIdTeBQwlhtoyOEzmv16qZKQ6AAD+SvxZMdabvsqBdOqD4y
         +TYIuvnwELG6DyWJ/V63recT/kS+vQ/2BxXPgZjzt7+zmzvXR9qRW1XLIMTvsGKIGqng
         nmSktYGzYS5uLZuTVnRKxzj6iNxet1HFiB7c80cB4hfdGDBwQg+WDTse0C325w9SxZo2
         8RdDNbjIV1pyZrU1PRQeOMeuIiGZKbdL/t3AFtmBVfb3DEvd82eCs8thNsrORIJR8YOk
         EOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkDUNHuZH8W689678VfNtJ4EUTRBTUIakwlkMZkzZFk=;
        b=IIffCC/90Uhs2MBtND54SmCmjKM/78XwvPgmpL4xHBb7Ycwg3gJLgLzhxV695/gTWq
         Kji0VzaZ7S9QXt7hab8JguC86IRmdmw6VOFCebzakTVtMMbNR/ChKkJO/6RNKlSBIwh6
         JYptg5Gcv4gx23CzL+SvfU5SHB1DjlClTBCY6vNhJSKj2ptstRrMDh6RzlxUsZE5qUwH
         Kb3S3aS11KE4B91DZtHKNzIW3cSwyQRgmyPvUJtXZ0qpXwrZ44y2AVT3xoakxcy7srA9
         V2bcwhOoGDCIVeiVoWDC0Blg0V/KvYLeRxpYqiQbfMW9Pqqsmn18RDT0gRcIS2XYHwcI
         pQjQ==
X-Gm-Message-State: AOAM530M+6gV/gdNHW8dhNy+8I5gYEX27gNpX+ytdtM0DJQ1K4UKL3Ae
        SWQzVvn+nTwLzA/gR8xTQR39vchox4rAu/O3VeBFNWPTAik=
X-Google-Smtp-Source: ABdhPJydW8Wt+BgOLLNkaU6igg+XLEsU15ie4coLH1wX8KoLLL7b7xXXMLdTWpRVpEGSqZP7kt3sC7i+gE8nvqRrfWQ=
X-Received: by 2002:a17:906:6c8b:: with SMTP id s11mr3989344ejr.187.1607556291255;
 Wed, 09 Dec 2020 15:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20201201151301.22025-1-richard@nod.at>
In-Reply-To: <20201201151301.22025-1-richard@nod.at>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 9 Dec 2020 15:24:40 -0800
Message-ID: <CAD+ocbxftRZCxqBKdry6pAxkgnarXMZtqfrz5Dp-=Dy=ZXuWOQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Don't leak old mountpoint samples
To:     Richard Weinberger <richard@nod.at>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the patch Richard, it looks good to me.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>


On Tue, Dec 1, 2020 at 7:29 AM Richard Weinberger <richard@nod.at> wrote:
>
> As soon the first file is opened, ext4 samples the mountpoint
> of the filesystem in 64 bytes of the super block.
> It does so using strlcpy(), this means that the remaining bytes
> in the super block string buffer are untouched.
> If the mount point before had a longer path than the current one,
> it can be reconstructed.
>
> Consider the case where the fs was mounted to "/media/johnjdeveloper"
> and later to "/".
> The the super block buffer then contains "/\x00edia/johnjdeveloper".
>
> This case was seen in the wild and caused confusion how the name
> of a developer ands up on the super block of a filesystem used
> in production...
>
> Fix this by clearing the string buffer before writing to it,
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/ext4/file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 3ed8c048fb12..dba521250d01 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -809,6 +809,7 @@ static int ext4_sample_last_mounted(struct super_block *sb,
>         err = ext4_journal_get_write_access(handle, sbi->s_sbh);
>         if (err)
>                 goto out_journal;
> +       memset(sbi->s_es->s_last_mounted, 0x00, sizeof(sbi->s_es->s_last_mounted));
>         strlcpy(sbi->s_es->s_last_mounted, cp,
>                 sizeof(sbi->s_es->s_last_mounted));
>         ext4_handle_dirty_super(handle, sb);
> --
> 2.26.2
>
