Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A683D7C3F
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jul 2021 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhG0RhM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhG0RhM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 13:37:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC3C061757
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jul 2021 10:37:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o5so70915ejy.2
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jul 2021 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XLu5iYT/G1gqYjkihnW6RhMW9BFHRJDgCodlheE6zk=;
        b=oPaEldcN2dBM1hXtm023d64yalr+Xw7xVFBnuz6eX0W/BVaqTlsWgyxpzW+nb62bvx
         2zKsqn/7G1Usg16EupiywOteWi+Z4/1Wfij1Mz+m81uWyDMyzhMpB/l30qdfM472CWCm
         8kG2g0bfUN/vF7QZO6Gs4WvWtNeLQpsz1HnvDF6VF01OGEIbJU31E2oiy6n/iTS0Rhta
         vqTN+7twyWhDbirZl3nEnIRiok9+Zg0e0RdtoPDWYnOeevESqquu6ghx87Ejd15pK8dc
         6xQCBGHw7CjzBBM8JlXbhpMgr2K9oBUMCtKPmP+MmC/bUwXXqpG9V+SxcYxWjLV7BdCP
         2cVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XLu5iYT/G1gqYjkihnW6RhMW9BFHRJDgCodlheE6zk=;
        b=HvsO9AaYvIObDmhrdC6ojEi1w5gpshW1DoIKW1X3OXTWlGDlV0Kdrtk3QXm/lbn4j6
         noZYjZjh/8h0MarROa2UKTzlPA8C3R0GN1VvthSyFz3EQ6L6Ttzivi2W7pWfDsrGWtmL
         fh5HAdtbAWaVQRjAzHHKN/dU1jVcgfKNIHKyXr2eSvW7b+jqTLRtgIbvkwbO/QqrWMQC
         2/HIXY+lHIi1XGURlq1BG2hTb/1BxboPU2Ct2M7R+o5J7YL9pMP2AccBgsoCtcUMdW7J
         0NAkHaUtmHmKwQz1wK1aL0XfeY8nugJ+isNtGr0xMVhu3RBXBnHiWFBokGif1a5MOD4g
         4qLQ==
X-Gm-Message-State: AOAM533GYHnqdw3j++Ve4OxaG7F/60jt/SGipt7HVkiRloLC8xTEWvN0
        MlOSAdwlMI7g4kJChwWEP7ROyXQrThljEm/zreA=
X-Google-Smtp-Source: ABdhPJyASAsUPJhh/4CFXRwqpXDGOWCcF67+G6xbBGVQiWO5GhYSmqWW1oYxI3N8rQ52LCQmsEXp+hIpgVSfdG3OnkA=
X-Received: by 2002:a17:906:1412:: with SMTP id p18mr4110579ejc.545.1627407429758;
 Tue, 27 Jul 2021 10:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210727080708.3708814-1-guoqing.jiang@linux.dev>
In-Reply-To: <20210727080708.3708814-1-guoqing.jiang@linux.dev>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 27 Jul 2021 10:36:58 -0700
Message-ID: <CAD+ocbyXcJ4YwEhsV4YO1B9m_K8S-OT1S6aoTp-u4UPYndoc=g@mail.gmail.com>
Subject: Re: [PATCH] ext4: reduce arguments of ext4_fc_add_dentry_tlv
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the cleanup! Looks good.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>


On Tue, Jul 27, 2021 at 1:11 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> From: Guoqing Jiang <jiangguoqing@kylinos.cn>
>
> Let's pass fc_dentry directly since those arguments (tag, parent_ino and
> ino etc) can be deferenced from it.
>
> Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
> ---
>  fs/ext4/fast_commit.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 5106c9fe2e19..797105adcabf 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -775,28 +775,27 @@ static bool ext4_fc_add_tlv(struct super_block *sb, u16 tag, u16 len, u8 *val,
>  }
>
>  /* Same as above, but adds dentry tlv. */
> -static  bool ext4_fc_add_dentry_tlv(struct super_block *sb, u16 tag,
> -                                       int parent_ino, int ino, int dlen,
> -                                       const unsigned char *dname,
> -                                       u32 *crc)
> +static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
> +                                  struct ext4_fc_dentry_update *fc_dentry)
>  {
>         struct ext4_fc_dentry_info fcd;
>         struct ext4_fc_tl tl;
> +       int dlen = fc_dentry->fcd_name.len;
>         u8 *dst = ext4_fc_reserve_space(sb, sizeof(tl) + sizeof(fcd) + dlen,
>                                         crc);
>
>         if (!dst)
>                 return false;
>
> -       fcd.fc_parent_ino = cpu_to_le32(parent_ino);
> -       fcd.fc_ino = cpu_to_le32(ino);
> -       tl.fc_tag = cpu_to_le16(tag);
> +       fcd.fc_parent_ino = cpu_to_le32(fc_dentry->fcd_parent);
> +       fcd.fc_ino = cpu_to_le32(fc_dentry->fcd_ino);
> +       tl.fc_tag = cpu_to_le16(fc_dentry->fcd_op);
>         tl.fc_len = cpu_to_le16(sizeof(fcd) + dlen);
>         ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), crc);
>         dst += sizeof(tl);
>         ext4_fc_memcpy(sb, dst, &fcd, sizeof(fcd), crc);
>         dst += sizeof(fcd);
> -       ext4_fc_memcpy(sb, dst, dname, dlen, crc);
> +       ext4_fc_memcpy(sb, dst, fc_dentry->fcd_name.name, dlen, crc);
>         dst += dlen;
>
>         return true;
> @@ -991,11 +990,7 @@ __acquires(&sbi->s_fc_lock)
>                                  &sbi->s_fc_dentry_q[FC_Q_MAIN], fcd_list) {
>                 if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT) {
>                         spin_unlock(&sbi->s_fc_lock);
> -                       if (!ext4_fc_add_dentry_tlv(
> -                               sb, fc_dentry->fcd_op,
> -                               fc_dentry->fcd_parent, fc_dentry->fcd_ino,
> -                               fc_dentry->fcd_name.len,
> -                               fc_dentry->fcd_name.name, crc)) {
> +                       if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry)) {
>                                 ret = -ENOSPC;
>                                 goto lock_and_exit;
>                         }
> @@ -1034,11 +1029,7 @@ __acquires(&sbi->s_fc_lock)
>                 if (ret)
>                         goto lock_and_exit;
>
> -               if (!ext4_fc_add_dentry_tlv(
> -                       sb, fc_dentry->fcd_op,
> -                       fc_dentry->fcd_parent, fc_dentry->fcd_ino,
> -                       fc_dentry->fcd_name.len,
> -                       fc_dentry->fcd_name.name, crc)) {
> +               if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry)) {
>                         ret = -ENOSPC;
>                         goto lock_and_exit;
>                 }
> --
> 2.25.1
>
