Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462732AA886
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Nov 2020 01:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKHAMP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 19:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgKHAMP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 19:12:15 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3005C0613CF
        for <linux-ext4@vger.kernel.org>; Sat,  7 Nov 2020 16:12:14 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f23so504943ejk.2
        for <linux-ext4@vger.kernel.org>; Sat, 07 Nov 2020 16:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6ir1umg82Hpz9yS9hntzbm2kCu9EX5Rd7cz2s11lJs=;
        b=HjYbSl/K1419XcHV+4Pc5u8N/IWJlxslFpXm6uTi+H0Sojx52ovQA0s0oO1Tw7H5HH
         xsJz3y+AU5qZOCgcUWGwwMy8nxw0Nps+6x4gqe/RUK3Yrm8GoCaDFOsPNd2vtC3BsSzS
         Cqx5pSJhlB+X6pIHTttT9+LfZIoG+S/Tt8AJSYAcmMRblk+na3zoZ6HSxQtYUOg+Ol8j
         FXDrjH5JpMBSdj8sLU7hoQsTHy/KevFgASXV71lGFnj2h3OARiVF3OfH4GY0va4nfinP
         s8zCTXEDNcbCsfxRLTPMBQNCa+Hy77vkerT+29X6RzoFEoGex4jIMZaFl6tdgczN+lNG
         i9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6ir1umg82Hpz9yS9hntzbm2kCu9EX5Rd7cz2s11lJs=;
        b=mlJWjI/aXEIQLH0VCoxc2xuqHqqW4HF+WmfWM4raI1oGyKvPNTw8tB3DZxMPCZ3gc5
         Hw0x5YSBF7neov9CFCJ1+lxlsNfA7Hhb1lGSWp/AT9AOjzmMJAsItKtiPALH4x0ZFufD
         +dtkjUiUi/GmaWPZfjxpGUg6IXVwQi9t4Q5ixATVCiGhVN4KhoTLfWYaEWPVpEvThEaG
         zCouNBffykB78jZVcNFPNL4cta8phvUBchO4gRdiYwhgrzlDsa6O8bGhDBWGHewiA0yR
         D7k58yEtST22gE1gJFXa/0TP91lsklZpv2PYfJ0FMAQHuTLb7/cE5xWaPk2paTB9alRK
         XcOw==
X-Gm-Message-State: AOAM531E+rZfAStqfA0NuJWStBxhXJWRbal0vKYskiX50N5fqtpGCYeJ
        yncqAE6R2xnpa+irLJ4qdiyTXON94jfA3zTkcws=
X-Google-Smtp-Source: ABdhPJyqFJUZFuCa+fgUf8REVCTTaBSFWD4m54Ekvlwxf6jcTHTuV1/V0Rnhm8ShAVEzx3PGnfJf0BScBpf8mefjXHg=
X-Received: by 2002:a17:906:fcc2:: with SMTP id qx2mr8923484ejb.549.1604794333484;
 Sat, 07 Nov 2020 16:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20201107050959.2561329-1-tytso@mit.edu> <20201107050959.2561329-2-tytso@mit.edu>
In-Reply-To: <20201107050959.2561329-2-tytso@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sat, 7 Nov 2020 16:12:02 -0800
Message-ID: <CAD+ocbzQKM0UFzQ2KLKXxW_RYkqf7kMHxw6CzpsRzoVbToDogw@mail.gmail.com>
Subject: Re: [PATCH 2/2] jbd2: fix up sparse warnings in checkpoint code
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the change, it looks good to me.

- Harshad

On Fri, Nov 6, 2020 at 9:12 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> Add missing __acquires() and __releases() annotations.  Also, in an
> "this should never happen" WARN_ON check, if it *does* actually
> happen, we need to release j_state_lock since this function is always
> supposed to release that lock.  Otherwise, things will quickly grind
> to a halt after the WARN_ON trips.
>
> Fixes: 96f1e0974575 ("jbd2: avoid long hold times of j_state_lock...")
> Cc: stable@kernel.org
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/jbd2/checkpoint.c  | 2 ++
>  fs/jbd2/transaction.c | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 263f02ad8ebf..472932b9e6bc 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -106,6 +106,8 @@ static int __try_to_free_cp_buf(struct journal_head *jh)
>   * for a checkpoint to free up some space in the log.
>   */
>  void __jbd2_log_wait_for_space(journal_t *journal)
> +__acquires(&journal->j_state_lock)
> +__releases(&journal->j_state_lock)
>  {
>         int nblocks, space_left;
>         /* assert_spin_locked(&journal->j_state_lock); */
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 43985738aa86..d54f04674e8e 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -195,8 +195,10 @@ static void wait_transaction_switching(journal_t *journal)
>         DEFINE_WAIT(wait);
>
>         if (WARN_ON(!journal->j_running_transaction ||
> -                   journal->j_running_transaction->t_state != T_SWITCH))
> +                   journal->j_running_transaction->t_state != T_SWITCH)) {
> +               read_unlock(&journal->j_state_lock);
>                 return;
> +       }
>         prepare_to_wait(&journal->j_wait_transaction_locked, &wait,
>                         TASK_UNINTERRUPTIBLE);
>         read_unlock(&journal->j_state_lock);
> --
> 2.28.0
>
