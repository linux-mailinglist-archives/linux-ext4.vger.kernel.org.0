Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAA2DA050
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Dec 2020 20:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440959AbgLNTYC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Dec 2020 14:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440916AbgLNTX4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Dec 2020 14:23:56 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F515C0613D3
        for <linux-ext4@vger.kernel.org>; Mon, 14 Dec 2020 11:23:16 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id k4so18411848edl.0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Dec 2020 11:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghHpJV67+wKgi5mH36xWRJHPfw2tmD3zuq771YBph+4=;
        b=RrXQvsekFlFHIcMQod3TAGlC0QsBNVH6+miXqheLOem+h8FkMQ9KiHBUFdRndl3Be7
         mZMc+xkMoWgs0rEVP+9BCwXA01APlR5Co/F3f8GsqcwH2kZGJEH/e/1hIrFMUXC1/WGW
         6d0LJEFvYNcVvxsIknH8dsaqkuKxsetkc4O0OFrm6LFC/ATUuF0CY7fPbvITPUVwsjI6
         1xaw9c1VALl/RrzNZ/CPlx8TNyFNOCivHREZiNI37NwcQrh8jllGSIwTKawguiPB3YZy
         LmHynxlECxlYcZAHOMdFJDuXZMEUkuV3MsP9yuPiLuI5mSi817mty3yidx3yXPyJfeFM
         DGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghHpJV67+wKgi5mH36xWRJHPfw2tmD3zuq771YBph+4=;
        b=eaL70LpxhRnEnrgGKnTomU71B6b2ifGBcFPxBgQSr9nKn0r+FQN6s/9mtPBDMTAp71
         o0+1M5kdCXmpE2fTkOvRpZVChZeOAXtaDZ+PywWmEyjLxfKq1KJ+MqEI0O5pb54LVy91
         evFaF6fGSPLLpCYeZ5oE+bLFu2zjuEAK/Qjp2AJlxBdPg1snMT/XViFFGGXGfRsDVQLv
         teEVNwKGLjoxakBbRfgmpgZoqAwvUJCLWqK5PqfBy91/0I5cC9Btu8fGi08rdWkQpSah
         /vDoPR/2vKuxPJ2P4/53KRNI+NVgv1yySXm9asPMbWGuo5viL01UrSWCpDJtw34r3XG/
         e7sQ==
X-Gm-Message-State: AOAM531/Kk/xDo//O7fLAsElYn5SBRuBe55p9JSQAM+1sTYZjq67Waqp
        G1GuWiEU/a4Kn/l5DPXGrbAcdhZqflJx6hAgwYU=
X-Google-Smtp-Source: ABdhPJzPfXl877dk+5a5MhGc+8iwFTFHAK6RA/e9J4wNkoTQd9v7QkEFcjMIMQsLZ2GlJWcPbyXTBAEtbld+H5XoU/A=
X-Received: by 2002:aa7:cf85:: with SMTP id z5mr11927913edx.274.1607973795156;
 Mon, 14 Dec 2020 11:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20201127113405.26867-1-jack@suse.cz> <20201127113405.26867-9-jack@suse.cz>
In-Reply-To: <20201127113405.26867-9-jack@suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 14 Dec 2020 11:23:04 -0800
Message-ID: <CAD+ocbwLVsjrB1HRsOm-mD6zm+1Et1C5FcwcGvNmt-AkuZo4Uw@mail.gmail.com>
Subject: Re: [PATCH 08/12] ext4: Combine ext4_handle_error() and save_error_info()
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 27, 2020 at 3:38 AM Jan Kara <jack@suse.cz> wrote:
>
> save_error_info() is always called together with ext4_handle_error().
> Combine them into a single call and move unconditional bits out of
> save_error_info() into ext4_handle_error().
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 2d7dc0908cdd..73a09b73fc11 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -592,9 +592,6 @@ static void __save_error_info(struct super_block *sb, int error,
>  {
>         struct ext4_sb_info *sbi = EXT4_SB(sb);
>
> -       EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
> -       if (bdev_read_only(sb->s_bdev))
> -               return;
>         /* We default to EFSCORRUPTED error... */
>         if (error == 0)
>                 error = EFSCORRUPTED;
> @@ -647,13 +644,19 @@ static void save_error_info(struct super_block *sb, int error,
>   * used to deal with unrecoverable failures such as journal IO errors or ENOMEM
>   * at a critical moment in log management.
>   */
> -static void ext4_handle_error(struct super_block *sb, bool force_ro)
> +static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
> +                             __u32 ino, __u64 block,
> +                             const char *func, unsigned int line)
>  {
>         journal_t *journal = EXT4_SB(sb)->s_journal;
>
> +       EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
>         if (test_opt(sb, WARN_ON_ERROR))
>                 WARN_ON_ONCE(1);
>
> +       if (!bdev_read_only(sb->s_bdev))
> +               save_error_info(sb, error, ino, block, func, line);
> +
>         if (sb_rdonly(sb) || (!force_ro && test_opt(sb, ERRORS_CONT)))
>                 return;
>
> @@ -710,8 +713,7 @@ void __ext4_error(struct super_block *sb, const char *function,
>                        sb->s_id, function, line, current->comm, &vaf);
>                 va_end(args);
>         }
> -       save_error_info(sb, error, 0, block, function, line);
> -       ext4_handle_error(sb, force_ro);
> +       ext4_handle_error(sb, force_ro, error, 0, block, function, line);
>  }
>
>  void __ext4_error_inode(struct inode *inode, const char *function,
> @@ -741,9 +743,8 @@ void __ext4_error_inode(struct inode *inode, const char *function,
>                                current->comm, &vaf);
>                 va_end(args);
>         }
> -       save_error_info(inode->i_sb, error, inode->i_ino, block,
> -                       function, line);
> -       ext4_handle_error(inode->i_sb, false);
> +       ext4_handle_error(inode->i_sb, false, error, inode->i_ino, block,
> +                         function, line);
>  }
>
>  void __ext4_error_file(struct file *file, const char *function,
> @@ -780,9 +781,8 @@ void __ext4_error_file(struct file *file, const char *function,
>                                current->comm, path, &vaf);
>                 va_end(args);
>         }
> -       save_error_info(inode->i_sb, EFSCORRUPTED, inode->i_ino, block,
> -                       function, line);
> -       ext4_handle_error(inode->i_sb, false);
> +       ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
> +                         function, line);
>  }
>
>  const char *ext4_decode_error(struct super_block *sb, int errno,
> @@ -849,8 +849,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
>                        sb->s_id, function, line, errstr);
>         }
>
> -       save_error_info(sb, -errno, 0, 0, function, line);
> -       ext4_handle_error(sb, false);
> +       ext4_handle_error(sb, false, -errno, 0, 0, function, line);
>  }
>
>  void __ext4_msg(struct super_block *sb,
> @@ -944,13 +943,13 @@ __acquires(bitlock)
>         if (test_opt(sb, ERRORS_CONT)) {
>                 if (test_opt(sb, WARN_ON_ERROR))
>                         WARN_ON_ONCE(1);
> +               EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
Since you moved the bdev_read_only() check from __save_error_info to
ext4_handle_error(), should we add that check here?

- Harshad
>                 __save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
>                 schedule_work(&EXT4_SB(sb)->s_error_work);
>                 return;
>         }
>         ext4_unlock_group(sb, grp);
> -       save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
> -       ext4_handle_error(sb, false);
> +       ext4_handle_error(sb, false, EFSCORRUPTED, ino, block, function, line);
>         /*
>          * We only get here in the ERRORS_RO case; relocking the group
>          * may be dangerous, but nothing bad will happen since the
> --
> 2.16.4
>
