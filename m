Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F282487DB4
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jan 2022 21:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiAGU0o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jan 2022 15:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiAGU0n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jan 2022 15:26:43 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B6DC061574;
        Fri,  7 Jan 2022 12:26:43 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id e25so7071310qkl.12;
        Fri, 07 Jan 2022 12:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srnZFRlh9ysQsQawEGT8y/8MQC8adaoMhhD5XwuRpMM=;
        b=lja69UgbMBkrCcTxdA3Sh8wFKglBslgmSfHDH9aQ/n/olCQWKyfC8HoAKwGmLN1Iy6
         nOK79rpMd5ZbQtQfIig8Lu9W2ovk2j+HKswvgGeQk+/dzbrDGlsAfuK6PMrL2VSUcLAc
         aGDPfPSGfFtRNhNDUda4JN0uKtxwkbJpd3OG3zVywl5W8t6qkW7C2XmCFnRtRcGNnoLc
         VIoTx6Dew7uGXAfrOjr/PdNx9YAiU+5ccn9xVkvQDsuUAt8tRcokP1QYnoE4MAt0SIZn
         9ZRX8tWIWH8zlB6GIodq4MvapQL6nKik+undu9hx2xClJAfYopQZM9nSiGSLUiqwlVix
         HDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srnZFRlh9ysQsQawEGT8y/8MQC8adaoMhhD5XwuRpMM=;
        b=wTgaBcQH7MHIZDkYw0NlxrpkTBvdbWyaV6J55ynCnaBKWbilogKJFIs2GEb4miOAJ9
         CDad33bNyy0IiECRU6kAGjlXVZOlhEP1FDQ8DJXAYHvIEZSlvDYLCi4fKh0ETVcnMSPr
         4bPTtVy13C4KkRpQqhBXd9/6dTu77VS8RT9jgyazUtkt481lm3Xxr4Y8yfwkjh1dZ2Ja
         LewIKgZQsb8tDutd+YxrijtUxnJxcgxDC1pIGNCEVEUxA8jtHMOZDc3lTVr79aEvuIgl
         TMCp5oOYJTJllT5YcboS9IeM244TaalG14KduN9FEqGF+Bo/2rEURX9rZz654MBjOi7u
         HYdw==
X-Gm-Message-State: AOAM533BtZyBypTjkfpzv4BrW1jLzP9eb22p0EvFSSGzc4zmidQX47wN
        9tLmB//D0OPdIj8fSVeKMANZLNHWe9A7KPOMYB3iV1fh
X-Google-Smtp-Source: ABdhPJxhGYKHJyaoeqNIZfhZ/aEtZjIGR7UMdzgVIVsYWwTf1VetwJL5bObjIJ1MfKL01y/7XtxeXAZx6xJ4hwpbeyw=
X-Received: by 2002:a05:620a:2486:: with SMTP id i6mr46164354qkn.522.1641587202089;
 Fri, 07 Jan 2022 12:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20220106024518.8161-1-yinxin.x@bytedance.com> <20220106024518.8161-2-yinxin.x@bytedance.com>
In-Reply-To: <20220106024518.8161-2-yinxin.x@bytedance.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 7 Jan 2022 12:26:31 -0800
Message-ID: <CAD+ocbx2e06YoESJM7m5ra-6so0ijWsYyN1L1ZFTXqxedMMoNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ext4: prevent used blocks from being allocated during
 fast commit replay
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 5, 2022 at 6:45 PM Xin Yin <yinxin.x@bytedance.com> wrote:
>
> during fast commit replay procedure, we clear inode blocks bitmap in
> ext4_ext_clear_bb(), this may cause ext4_mb_new_blocks_simple() allocate
> blocks still in use.
>
> make ext4_fc_record_regions() also record physical disk regions used by
> inodes during replay procedure. Then ext4_mb_new_blocks_simple() can
> excludes these blocks in use.
>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/ext4/ext4.h        |  2 ++
>  fs/ext4/extents.c     |  4 ++++
>  fs/ext4/fast_commit.c | 11 ++++++++---
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 82fa51d6f145..7b0686758691 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2932,6 +2932,8 @@ bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
>  void ext4_fc_replay_cleanup(struct super_block *sb);
>  int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
>  int __init ext4_fc_init_dentry_cache(void);
> +int ext4_fc_record_regions(struct super_block *sb, int ino,
> +                    ext4_lblk_t lblk, ext4_fsblk_t pblk, int len, int replay);
>
>  /* mballoc.c */
>  extern const struct seq_operations ext4_mb_seq_groups_ops;
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c3e76a5de661..9b6c76629c93 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -6096,11 +6096,15 @@ int ext4_ext_clear_bb(struct inode *inode)
>
>                                         ext4_mb_mark_bb(inode->i_sb,
>                                                         path[j].p_block, 1, 0);
> +                                       ext4_fc_record_regions(inode->i_sb, inode->i_ino,
> +                                                       0, path[j].p_block, 1, 1);
>                                 }
>                                 ext4_ext_drop_refs(path);
>                                 kfree(path);
>                         }
>                         ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
> +                       ext4_fc_record_regions(inode->i_sb, inode->i_ino,
> +                                       map.m_lblk, map.m_pblk, map.m_len, 1);
>                 }
>                 cur = cur + map.m_len;
>         }
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 23d13983a281..f0cd20f5fe5e 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1567,13 +1567,15 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl,
>   * Record physical disk regions which are in use as per fast commit area. Our
>   * simple replay phase allocator excludes these regions from allocation.
>   */
> -static int ext4_fc_record_regions(struct super_block *sb, int ino,
> -               ext4_lblk_t lblk, ext4_fsblk_t pblk, int len)
> +int ext4_fc_record_regions(struct super_block *sb, int ino,
> +               ext4_lblk_t lblk, ext4_fsblk_t pblk, int len, int replay)
Can you explain a bit why this replay parameter is needed here? This
function simply reallocs the regions array if it doesn't have enough
space. I am not sure why we need to change that behavior.
>  {
>         struct ext4_fc_replay_state *state;
>         struct ext4_fc_alloc_region *region;
>
>         state = &EXT4_SB(sb)->s_fc_replay_state;
> +       if (replay && state->fc_regions_used != state->fc_regions_valid)
> +               state->fc_regions_used = state->fc_regions_valid;
>         if (state->fc_regions_used == state->fc_regions_size) {
>                 state->fc_regions_size +=
>                         EXT4_FC_REPLAY_REALLOC_INCREMENT;
> @@ -1591,6 +1593,9 @@ static int ext4_fc_record_regions(struct super_block *sb, int ino,
>         region->pblk = pblk;
>         region->len = len;
>
> +       if (replay)
> +               state->fc_regions_valid++;
> +
>         return 0;
>  }
>
> @@ -1938,7 +1943,7 @@ static int ext4_fc_replay_scan(journal_t *journal,
>                         ret = ext4_fc_record_regions(sb,
>                                 le32_to_cpu(ext.fc_ino),
>                                 le32_to_cpu(ex->ee_block), ext4_ext_pblock(ex),
> -                               ext4_ext_get_actual_len(ex));
> +                               ext4_ext_get_actual_len(ex), 0);
>                         if (ret < 0)
>                                 break;
>                         ret = JBD2_FC_REPLAY_CONTINUE;
> --
> 2.20.1
>
