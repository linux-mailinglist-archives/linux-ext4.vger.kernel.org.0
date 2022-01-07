Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A06487D90
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jan 2022 21:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiAGUOv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jan 2022 15:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiAGUOu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jan 2022 15:14:50 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF23C061574;
        Fri,  7 Jan 2022 12:14:50 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id bp39so6609475qtb.6;
        Fri, 07 Jan 2022 12:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ag1/YTZJK/8u8wjP97ga++hgt87lnPOdShC/rpANk20=;
        b=Qm//ra+l+x9JCm0U22Wp6gVi84KifGOy/yRP+goPrHN9MAUPK/mN7T5BUNRSxn9U1U
         DSet6q01EPgQ2K7MvKOa9oZTsLaIZs8HOQ6znKIcULNPB2atiDfBh44X80teTvU7cAjI
         dn9k4cJpqsYsmWsSsfO2c6dwyFT/6PgeCicM3SjdbVi3aIHGx93IA9PBzCO9wle+7BvV
         iHeYWS9dOa0Jmu3czOsJj6GXSFGLCo5ToiILhCjm1qRD5Gm3+K/grL8E7ntB8wVVMTJi
         AtMM7rJS3V8EjiFwCcprw1AD7WOnF7k9m1tdbK6gy3wt18tl9nmT8mSYEA59xF1y2Bz3
         /5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ag1/YTZJK/8u8wjP97ga++hgt87lnPOdShC/rpANk20=;
        b=NgJF5BMoUESbOasB+z670mFt6rZbi2hFwWbDo6kQmHZFhRb6GJC2/pgiMmUQguTlzx
         cmqMvNwVhei38vMzUQDW0m6t9N1XALqhqJrWgRmUX4X7YDmB60FLz+pj7HqIrBRUMhyy
         WTnGNptoeYr6ru0UMv7s6o6TMgQrTHN25LZHI8cALLkNJru0c9LfVTdM1YDZ18ZAttAz
         c7oWoTxlK7WB1kyJUfMpdzIG6U6+CuaVv3pzCpO/5KHruC1WjXRj/2mksQD6q07oHe2J
         EHdDWz6U/gApLqK3NtpkqQoSchcROGYEQC0dIcQEjKJn2eCThW6R1AW8JovfGMma3yby
         syxA==
X-Gm-Message-State: AOAM532Mc7NnvFlPYGU7oEHrgyk2LBHULLctAnrU2RCiN9pouIiH1FGX
        t2CY+BN6AKNzHMLeS6ptk6Z2w+ki/znyrkT1syv2OiZR7wA=
X-Google-Smtp-Source: ABdhPJwki4uydZYpBksepwEf0KQxAW4lxn75phAwiE+/849/yUPM37YJ8MLlyQB16OSJl+a29rpKylV7oJWq5PVAmVQ=
X-Received: by 2002:ac8:4c9b:: with SMTP id j27mr56702066qtv.656.1641586489353;
 Fri, 07 Jan 2022 12:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20220107121215.1912-1-yinxin.x@bytedance.com> <20220107121215.1912-3-yinxin.x@bytedance.com>
In-Reply-To: <20220107121215.1912-3-yinxin.x@bytedance.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 7 Jan 2022 12:14:38 -0800
Message-ID: <CAD+ocbxUaQMjhOof-zphqYs2MvtqtM5dLxmfxmRGrj2sORZ+sQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ext4: fast commit may miss file actions
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Makes sense. With this change, we don't really need
EXT4_MF_FC_COMMITTING flag anymore. So, we can drop it. But other than
that, this patch looks good.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Fri, Jan 7, 2022 at 4:13 AM Xin Yin <yinxin.x@bytedance.com> wrote:
>
> in the follow scenario:
> 1. jbd start transaction n
> 2. task A get new handle for transaction n+1
> 3. task A do some actions and add inode to FC_Q_MAIN fc_q
> 4. jbd complete transaction n and clear FC_Q_MAIN fc_q
> 5. task A call fsync
>
> fast commit will lost the file actions during a full commit.
>
> we should also add updates to staging queue during a full commit.
> and in ext4_fc_cleanup(), when reset a inode's fc track range, check
> it's i_sync_tid, if it bigger than current transaction tid, do not
> rest it, or we will lost the track range.
>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/ext4/fast_commit.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 3673d4798af3..4cea92aec7c4 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -365,7 +365,8 @@ static int ext4_fc_track_template(
>         spin_lock(&sbi->s_fc_lock);
>         if (list_empty(&EXT4_I(inode)->i_fc_list))
>                 list_add_tail(&EXT4_I(inode)->i_fc_list,
> -                               (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING)) ?
> +                               (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> +                                sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
>                                 &sbi->s_fc_q[FC_Q_STAGING] :
>                                 &sbi->s_fc_q[FC_Q_MAIN]);
>         spin_unlock(&sbi->s_fc_lock);
> @@ -418,7 +419,8 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>         node->fcd_name.len = dentry->d_name.len;
>
>         spin_lock(&sbi->s_fc_lock);
> -       if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING))
> +       if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> +               sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
>                 list_add_tail(&node->fcd_list,
>                                 &sbi->s_fc_dentry_q[FC_Q_STAGING]);
>         else
> @@ -1202,7 +1204,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>                 list_del_init(&iter->i_fc_list);
>                 ext4_clear_inode_state(&iter->vfs_inode,
>                                        EXT4_STATE_FC_COMMITTING);
> -               ext4_fc_reset_inode(&iter->vfs_inode);
> +               if (iter->i_sync_tid <= tid)
> +                       ext4_fc_reset_inode(&iter->vfs_inode);
>                 /* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
>                 smp_mb();
>  #if (BITS_PER_LONG < 64)
> --
> 2.20.1
>
