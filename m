Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13A5200037
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 04:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFSCbK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 22:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgFSCbJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 22:31:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8CC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 19:31:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so8166102wru.0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 19:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yiWrnPLf7Tt3qVA6DFfe/vRtls4UslWtfUz1t40GdvQ=;
        b=LSvyYBzIvXbbLR8pHyx5MUXAXmQBOAI31NNiEZOfSJrVCnll1k6EaLaA4D2wXH7Zv2
         J5YTEEBYQta1rEv426pDQvrSVsm+ZXiprW/kKI1npk3OI/o1kb5K/y3Jtv6srHtCpX6O
         OBQWRI0sdPsJPYjzqUFBP7cCqsEF4ju8GKQlZt6t7ISjpTYCZZnUt5vBzX8q3bmHa1dP
         JxiAQ6denVlxVNdMU7OkaxRZ30400YiBXr2cn4To6wjcErE+GoBp66ML6N+Zlw2XGj9I
         e2+vraFJyGEd8TdSM3Yh5hZQ53xHQDQe4LUf2wAXeeYCz34+fz2C2efAMO3/1XU1zMTQ
         u+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yiWrnPLf7Tt3qVA6DFfe/vRtls4UslWtfUz1t40GdvQ=;
        b=c27pFMgZeiyni6CUP91RL0GvpH5f/NsRtzLmTb4XPOPRYl5c9FnmRAL9we5qANdPta
         QapgIgjFbZs/ZyXkBul1EnXHJvkpGVlxJCK7getSfUdk4mc6mp3/SBJggzKWRzG8CYb7
         QtqjhB0FY6DmUdztGpxR5JXBtj6L87tXMjg9xxTt5s0amw01fPhc4eUPgfpRlWSzcIs9
         4XD8jfjt6nonXu/JP7M5uew/qgo4WLLNB6VRCls+JRzMQrWi7UlCgAwctdyJ4BiSdnVF
         HbJq0KYirZVPkN0YCLW48Exnun6zmrZQFr2t7o59FsXIh93bnRIDcDx0/gLmaFp4vX1f
         sOBw==
X-Gm-Message-State: AOAM530dXcx/Ibj/1SbHoKRwNqGYpEWuRl3QJDI+iazxXUmif3yPb6zX
        RLCJhhVb7qDmtXAjDbUu8my28XawmF0LJCkAqt0zJ1iP
X-Google-Smtp-Source: ABdhPJxDxj66RIp9WEBj8P8l78/C+B6Y3eIO/kuGCTqi4kHWsUKls4jhw4JqhG59qzZ1sBTiYbIjOZF7ffCUFoWJEFE=
X-Received: by 2002:adf:8521:: with SMTP id 30mr1392726wrh.238.1592533866579;
 Thu, 18 Jun 2020 19:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <1592533574-24249-1-git-send-email-wangshilong1991@gmail.com>
In-Reply-To: <1592533574-24249-1-git-send-email-wangshilong1991@gmail.com>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Fri, 19 Jun 2020 10:30:49 +0800
Message-ID: <CAP9B-QnauzeJtbTYvUAHoXbJqKeu-UBGTSjVg2R=DESWqg5dDA@mail.gmail.com>
Subject: Re: [PATCH v2] Valgrind reported error messages like following:
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     ebiggers@kernel.org, Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry, please ignore this version, patch title is wrong...

On Fri, Jun 19, 2020 at 10:26 AM Wang Shilong <wangshilong1991@gmail.com> wrote:
>
> From: Wang Shilong <wshilong@ddn.com>
>
> ==129205==  Address 0x1b804b04 is 4 bytes after a block of size 4,096 alloc'd
> ==129205==    at 0x483980B: malloc (vg_replace_malloc.c:307)
> ==129205==    by 0x44F973: ext2fs_get_mem (ext2fs.h:1846)
> ==129205==    by 0x44F973: ext2fs_get_pathname (get_pathname.c:162)
> ==129205==    by 0x430917: print_pathname (message.c:212)
> ==129205==    by 0x430FB1: expand_percent_expression (message.c:462)
> ==129205==    by 0x430FB1: print_e2fsck_message (message.c:544)
> ==129205==    by 0x430BED: expand_at_expression (message.c:262)
> ==129205==    by 0x430BED: print_e2fsck_message (message.c:528)
> ==129205==    by 0x430450: fix_problem (problem.c:2494)
> ==129205==    by 0x423F8B: e2fsck_process_bad_inode (pass2.c:1929)
> ==129205==    by 0x425AE8: check_dir_block (pass2.c:1407)
> ==129205==    by 0x426942: check_dir_block2 (pass2.c:961)
> ==129205==    by 0x445736: ext2fs_dblist_iterate3.part.0 (dblist.c:254)
> ==129205==    by 0x423835: e2fsck_pass2 (pass2.c:187)
> ==129205==    by 0x414B19: e2fsck_run (e2fsck.c:257)
>
> Dir block might be corrupted and cause the next dirent is out
> of block size boundary, even though we have the check to avoid
> problem, memory check tools like valgrind still complains it.
>
> Patch try to fix the problem by checking if offset exceed max
> offset firstly before getting the pointer.
>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
> v1->v2:
> kept same return value for corruption case as before.
> ---
>  lib/ext2fs/csum.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/lib/ext2fs/csum.c b/lib/ext2fs/csum.c
> index c2550365..417a1fba 100644
> --- a/lib/ext2fs/csum.c
> +++ b/lib/ext2fs/csum.c
> @@ -266,16 +266,14 @@ static errcode_t __get_dirent_tail(ext2_filsys fs,
>         d = dirent;
>         top = EXT2_DIRENT_TAIL(dirent, fs->blocksize);
>
> -       rec_len = translate(d->rec_len);
>         while ((void *) d < top) {
> -               if ((rec_len < 8) || (rec_len & 0x03))
> +               rec_len = translate(d->rec_len);
> +               if ((rec_len < 8) || (rec_len & 0x03) ||
> +                   (rec_len > (char *)dirent + fs->blocksize - (char *)d))
>                         return EXT2_ET_DIR_CORRUPTED;
>                 d = (struct ext2_dir_entry *)(((char *)d) + rec_len);
> -               rec_len = translate(d->rec_len);
>         }
>
> -       if ((char *)d > ((char *)dirent + fs->blocksize))
> -                       return EXT2_ET_DIR_CORRUPTED;
>         if (d != top)
>                 return EXT2_ET_DIR_NO_SPACE_FOR_CSUM;
>
> --
> 2.25.4
>
