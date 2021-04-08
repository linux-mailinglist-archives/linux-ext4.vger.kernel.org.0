Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593913589B4
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 18:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhDHQ0e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 12:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhDHQ0c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 12:26:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB4C061760;
        Thu,  8 Apr 2021 09:26:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r22so3134075edq.9;
        Thu, 08 Apr 2021 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IaLjrWkR8bfcD0W5aRTsRX04L0DnyWWgAUCzh/xr3c=;
        b=c6dCsRj4+S3nE85vU8h8EVBRobqSInRsQA3+y08UQKxDWvGZbZlcmGk9/UskzBiRGY
         ENxUeZefFk5NePZOxbIIIdZPKrej4ZX2PkmJgJbVa5oXcpqWAXMik78zNT9I28bGzv8z
         WhyD+x08ph91LZb4TwBfYOrNp1aWJcCwgH/tRtntkitvkhtnB6RhUPFquqqm6R23rLw+
         PNYruyBIpF94o49y6yuwtfL8jw71PPoYkg9KWQS32zmcMeCFiORh1yzpE/tJi1m2a9sV
         ofvCTwN5dtjFDRnDof3loqZWuecyJYMTVKQAagN0Y0SHbcQiLqTGG5RLH1ZPG0In5qmL
         UGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IaLjrWkR8bfcD0W5aRTsRX04L0DnyWWgAUCzh/xr3c=;
        b=pPlq7OtyQg5L3CGgW5F29avA0geu78P4vNYeSX5sSCtBVQs2DXVX6ucUjLf9oGAzgU
         Rw0GGI59gqdRym+KCXveaIIeIcBXLAmQUKn0ERkS61TSuySlNI1pp35utmUymAXWHYUg
         FpwZEWM4vZeT2LvpajFmcwlT2XKduGt4QRHGjXkGA5ZNum5YD9xlPKTPUNyfsj0k5h/Z
         4rN3HZgsr1Zt4HHflnRGUXWF9WD1dke4MbM6KYNC+SsfMApxyg/05HTSokOPA0szisUZ
         sl1KIT9Nd9h6Os//aEFB/SCCWHwY5lMv9TD1C9wd2H2EgVC0k/fJgv7Vu+9uuJTEYUuK
         7JrA==
X-Gm-Message-State: AOAM531BT+rCSVQSKwJJ7ypuRoM8jodYxANtPYX4mxDegy2OtE+8Gdql
        tdvI8SBU4oXqsXCKovp3E8oWaWm4C0ZD+HqmJtdETVJYBHI=
X-Google-Smtp-Source: ABdhPJz322TTHQ4zinTcTaWSZd3uuSY+sR93BmbZpLGUSSD8n3zvGrcQ+hcOu/bp39rXEWXaOQNVcG90SZJm+ixb/QI=
X-Received: by 2002:a05:6402:5205:: with SMTP id s5mr9619573edd.65.1617899179793;
 Thu, 08 Apr 2021 09:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210408070033.123047-1-xuyihang@huawei.com>
In-Reply-To: <20210408070033.123047-1-xuyihang@huawei.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 8 Apr 2021 09:26:08 -0700
Message-ID: <CAD+ocbzHq0rsLvYjtN7YtSPdhTBbs+nJ2RsCR64W-8+WFGWRmQ@mail.gmail.com>
Subject: Re: [PATCH -next] ext4: fix error return code in ext4_fc_perform_commit()
To:     Xu Yihang <xuyihang@huawei.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, this looks good.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Thu, Apr 8, 2021 at 12:00 AM Xu Yihang <xuyihang@huawei.com> wrote:
>
> In case of if not ext4_fc_add_tlv branch, an error return code is missing.
>
> Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Yihang <xuyihang@huawei.com>
> ---
>  fs/ext4/fast_commit.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 7541d0b5d706..312273ed8a9f 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1088,8 +1088,10 @@ static int ext4_fc_perform_commit(journal_t *journal)
>                 head.fc_tid = cpu_to_le32(
>                         sbi->s_journal->j_running_transaction->t_tid);
>                 if (!ext4_fc_add_tlv(sb, EXT4_FC_TAG_HEAD, sizeof(head),
> -                       (u8 *)&head, &crc))
> +                       (u8 *)&head, &crc)) {
> +                       ret = -ENOSPC;
>                         goto out;
> +               }
>         }
>
>         spin_lock(&sbi->s_fc_lock);
> --
> 2.17.1
>
