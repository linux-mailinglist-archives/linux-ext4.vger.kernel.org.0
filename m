Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297B62EC5F4
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 23:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbhAFV7o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jan 2021 16:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbhAFV7o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Jan 2021 16:59:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E4DC061575;
        Wed,  6 Jan 2021 13:58:40 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b73so5721248edf.13;
        Wed, 06 Jan 2021 13:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+NJQyB4dJl3kE78FgPWzygB5svv50HkNremhOQCqaE=;
        b=vKg9vME9/2B9JoXXrm+0O4A5rHrVIwnY59vLD/ZyJ2GuV+UblYbykqJ8HqEorRDXOq
         LQb6hCgR8xqbggbsAmCFZuGh5/2agW8QV1q8/Vuzy9U5xX/srPG4YCpHUqkqRc5pMaoF
         Z7pzrRPa+9Y4eRBN26+qDVYlj7eS/FP6MxaCeUhGXvu8ZwCdfU1Y0FJLceJmJsSMqBm8
         0HEq7bcFRRxkcCwlKSlJh2eLOhuWKSHFW4nggTRIrsjICwbpPwjuS0YwvkVwiE9k/fC/
         akEBgoYhCPUo6c4lvdlB1SEaDHwl1sVmsN7d05gLOy+F0UIpEsw26GynMrlP1a9qamiW
         M16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+NJQyB4dJl3kE78FgPWzygB5svv50HkNremhOQCqaE=;
        b=XLw9sxVEFaYe9rV4QosmTAtHF0Nm3Coluo5k7L6fzy/pGVdDYRcrnwKmBSIlOW52+l
         hxDMmao8Fe7fK57GOtiFOXHGi6rmcA+WhSYiHDe3SMkiTxXQhnmC6W2aAvg7gdUAqs3O
         9PtvKTojaKRg9qknqJN+tkfAT0Hi8G0iNQtQa8YPbEMGBbqqvpriVf/rsRMnwlXbkyXa
         svOgC0BolpLLGZT2/zDNhlAlayBoBxo11fbl9nnPB9n/fjSocnjdWb5ARZIhq42L1CmM
         SNLPDuHDd5y8H+2Xz8Zv0OhyUX31TuyLkhYM5i/kLgFBNQQcVB9tSH+Ca9e2O0kRzJoJ
         ztmQ==
X-Gm-Message-State: AOAM531DAWaSmQh1rmgrnDpjrSldy9HloHBbpcOQ2fyeCSJ/zKaWKWGH
        J9spcdD/Btgwo08v9+jAXduhHfsOOFechHBrJcU=
X-Google-Smtp-Source: ABdhPJxOHBRYFuXA858OcL9XemA5fduTRiMaPWSuvZFAwdUE/v4VfqL2k0QlQ4WBLkLCDb41WN2dhBE6api/jmkoawQ=
X-Received: by 2002:aa7:cf85:: with SMTP id z5mr5341394edx.274.1609970319592;
 Wed, 06 Jan 2021 13:58:39 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
 <20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
In-Reply-To: <20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 6 Jan 2021 13:58:28 -0800
Message-ID: <CAD+ocbyp+SOzpDDYsJVpd+t+UcjanZRtR85dHLgykLdURhV5wA@mail.gmail.com>
Subject: Re: [PATCH] ext4: Remove expensive flush on fast commit
To:     daejun7.park@samsung.com
Cc:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Daejun! This looks good.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Tue, Jan 5, 2021 at 5:32 PM Daejun Park <daejun7.park@samsung.com> wrote:
>
> In the fast commit, it adds REQ_FUA and REQ_PREFLUSH on each fast commit
> block when barrier is enabled. However, in recovery phase, ext4 compares
> CRC value in the tail. So it is sufficient adds REQ_FUA and REQ_PREFLUSH
> on the block that has tail.
>
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>  fs/ext4/fast_commit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 4fcc21c25e79..e66507be334c 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -604,13 +604,13 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
>         trace_ext4_fc_track_range(inode, start, end, ret);
>  }
>
> -static void ext4_fc_submit_bh(struct super_block *sb)
> +static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
>  {
>         int write_flags = REQ_SYNC;
>         struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
>
> -       /* TODO: REQ_FUA | REQ_PREFLUSH is unnecessarily expensive. */
> -       if (test_opt(sb, BARRIER))
> +       /* Add REQ_FUA | REQ_PREFLUSH only its tail */
> +       if (test_opt(sb, BARRIER) && is_tail)
>                 write_flags |= REQ_FUA | REQ_PREFLUSH;
>         lock_buffer(bh);
>         set_buffer_dirty(bh);
> @@ -684,7 +684,7 @@ static u8 *ext4_fc_reserve_space(struct super_block *sb, int len, u32 *crc)
>                 *crc = ext4_chksum(sbi, *crc, tl, sizeof(*tl));
>         if (pad_len > 0)
>                 ext4_fc_memzero(sb, tl + 1, pad_len, crc);
> -       ext4_fc_submit_bh(sb);
> +       ext4_fc_submit_bh(sb, false);
>
>         ret = jbd2_fc_get_buf(EXT4_SB(sb)->s_journal, &bh);
>         if (ret)
> @@ -741,7 +741,7 @@ static int ext4_fc_write_tail(struct super_block *sb, u32 crc)
>         tail.fc_crc = cpu_to_le32(crc);
>         ext4_fc_memcpy(sb, dst, &tail.fc_crc, sizeof(tail.fc_crc), NULL);
>
> -       ext4_fc_submit_bh(sb);
> +       ext4_fc_submit_bh(sb, true);
>
>         return 0;
>  }
> --
> 2.25.1
>
