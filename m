Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8596729BAB6
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Oct 2020 17:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1807473AbgJ0QK6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Oct 2020 12:10:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36590 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1807463AbgJ0QKz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Oct 2020 12:10:55 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1kXRYi-00062o-Nm
        for linux-ext4@vger.kernel.org; Tue, 27 Oct 2020 16:10:52 +0000
Received: by mail-wm1-f69.google.com with SMTP id 22so765289wmo.3
        for <linux-ext4@vger.kernel.org>; Tue, 27 Oct 2020 09:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FiwKhTTNUXKE1vlkDwixEE7F2+Xm0xm6j2vCTDuLYI=;
        b=oVIsEyViP7auzwoOuLIGoldxs2vYYx5yVBSY5ess+1560ctfM7bYYEq/ElDS/j9iXo
         dvOal8RFzawMkZ6zEMiHkVN+HcYgyu5/vXH070TXBDzszV1KSo3HXl1354DkDqn8flsO
         r1xccTvtoK35qfpJL7pfS74RVyi3X/9kPU/NCFH9wuPlML1MO411ZJKcqkxovQcSQTRo
         jG868bNoTjlxeoaDZheR2wbtxzYvsij1d1UQtsnB2JbEs5ESwFAlZMXkCpu4BoI2nf9o
         QoXmKyVpIzAc3e63bFBJUgp7fFF/YMJg8LnaecIAm4hcMVMZsjtSyTLZ5Tc+WE8OyB0N
         b9Gg==
X-Gm-Message-State: AOAM533H79zPEXyxTBhyJHBw3o4T1/yYoD4PsIYUEgDl7D3V6NVVzs8u
        BvjIoMPVE4ap2WD3tQv1uvH+XLw0gT2Qb5+zgtgjKUXpGcdMpX9/vB/Er8lyiFZFuaReARAntZu
        oUYZ1aY0e5zwdlBOD3FKXpkxBBd/FBzInrJLnK27PKUGwprnfz5uACp4=
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr3686952wrw.126.1603815052354;
        Tue, 27 Oct 2020 09:10:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXkk3MBOVKtjZWseFKSoCSz+aiXiRqbKxnid0echYsEjrlkrvTjrzGJljeEFN89XwXENdIuJxRU3H5gCf+d4k=
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr3686931wrw.126.1603815052088;
 Tue, 27 Oct 2020 09:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201027132751.29858-1-jack@suse.cz>
In-Reply-To: <20201027132751.29858-1-jack@suse.cz>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Tue, 27 Oct 2020 13:10:39 -0300
Message-ID: <CAO9xwp0AtCLG77g6fWgu9un9XPD3d5U6ZtjWc3FRJrB8NK44SQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Fix mmap write protection for data=journal mode
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Jan,

On Tue, Oct 27, 2020 at 10:27 AM Jan Kara <jack@suse.cz> wrote:
>
> Commit afb585a97f81 "ext4: data=journal: write-protect pages on
> j_submit_inode_data_buffers()") added calls ext4_jbd2_inode_add_write()
> to track inode ranges whose mappings need to get write-protected during
> transaction commits. However the added calls use wrong start of a range
> (0 instead of page offset) and so write protection is not necessarily
> effective. Use correct range start to fix the problem.
>
> Fixes: afb585a97f81 ("ext4: data=journal: write-protect pages on j_submit_inode_data_buffers()")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> Mauricio, I think this could be the reason for occasional test failures you
> were still seeing. Can you try whether this patch fixes those for you? Thanks!
>

Thanks! Nice catch. Sure, I'll give it a try and follow up.

Just as FYI, I've been working on debugging and instrumentation to
identify the corner cases
where the page has not been write protected; but got a slower pace due
to other work items.

cheers,
Mauricio

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 03c2253005f0..f4a599c6dcde 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1918,7 +1918,7 @@ static int __ext4_journalled_writepage(struct page *page,
>         }
>         if (ret == 0)
>                 ret = err;
> -       err = ext4_jbd2_inode_add_write(handle, inode, 0, len);
> +       err = ext4_jbd2_inode_add_write(handle, inode, page_offset(page), len);
>         if (ret == 0)
>                 ret = err;
>         EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
> @@ -6157,7 +6157,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>                         if (ext4_walk_page_buffers(handle, page_buffers(page),
>                                         0, len, NULL, write_end_fn))
>                                 goto out_error;
> -                       if (ext4_jbd2_inode_add_write(handle, inode, 0, len))
> +                       if (ext4_jbd2_inode_add_write(handle, inode,
> +                                                     page_offset(page), len))
>                                 goto out_error;
>                         ext4_set_inode_state(inode, EXT4_STATE_JDATA);
>                 } else {
> --
> 2.16.4
>


-- 
Mauricio Faria de Oliveira
