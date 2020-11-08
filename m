Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0052AA883
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Nov 2020 01:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgKHALw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 19:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgKHALw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 19:11:52 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F44DC0613CF
        for <linux-ext4@vger.kernel.org>; Sat,  7 Nov 2020 16:11:50 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id o9so7167698ejg.1
        for <linux-ext4@vger.kernel.org>; Sat, 07 Nov 2020 16:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQown+dXN/7MJi/851IyRYaN1mLN+qK5QG4KY26yItE=;
        b=YiyurmZG+NU9Q9je6zjY/9T6stJkvPXofDqyWjdclVh9kDcDYlaMAt1HLAY/zC6mhj
         12jTMcOez5QcDu0Nx+s0FnEuHG0gUpm4FtRgr/HCGCPocXbZytovgk8JTS9CPpEzOwLs
         YVi4cpm8fhLFz5BR8cWE+ga2Cqu1LSuZSrY6E2Vwi74ug18v9sSlQ+xUA5K5UYNd2KTb
         ZWY4G4VMPr02Qt9Pwd75GlM8nqh6DzphnvJrPp2JGq6quVN7VQG3COFavrJopfyam81N
         rSrJ3kPrBWrz7qtq+yUU4pL2e/M2v8udVhtunIE9xU7pAKL746yt66xANc6Mw8sBBguc
         XluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQown+dXN/7MJi/851IyRYaN1mLN+qK5QG4KY26yItE=;
        b=CBtJGEvdTeDK5i0RFRJ25e0yefrfbisfxveBPjXUZ/WqofvuIdOVVLrImxBEfLtOXR
         MQRF6rTQqm0Q4+hY3yDQlrSEDIit09d2kLFy6X1i9VWIEQRnzRTZgAuciwMAdiEBp5QG
         vfcenPMN+8ob2D/Jbc8JJdjWPQF7YicOEGXswPu7eHSEwwY0B0cn949oFfqBvhvBH9zr
         C00kMQvSoZHLB9PbE2+914CeXnZJeePHhVxP+wRVn1mcnaYnVrfaaRM16RU9TjiuzP8x
         VRZz9woUNwGH/Rbx+v8IT4NcNfpneq/4u+RtUV2UdccbaYRPFwbL8aQmIP+IryGbsjdG
         9xGA==
X-Gm-Message-State: AOAM530mOWA74x/TBilS5bs/5GAAB4kCM2C8c3dBcPdFKyaH+B5c96Gl
        t/R3NrCP0JbAUujav3P8cdPjoqSA8+URk349/1Y=
X-Google-Smtp-Source: ABdhPJwR/YzGAZyZ7CXBQbIY+tTxVdMgPrSp1bEtGO0c/7uBClVZADrN1MEipdStBNlVeEyzC6OY28c5FCMl+EuR11I=
X-Received: by 2002:a17:906:f148:: with SMTP id gw8mr8454698ejb.192.1604794308879;
 Sat, 07 Nov 2020 16:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20201107050959.2561329-1-tytso@mit.edu>
In-Reply-To: <20201107050959.2561329-1-tytso@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sat, 7 Nov 2020 16:11:37 -0800
Message-ID: <CAD+ocbxxSAUeLdF59b3aHcSktO2asac-oxbSsDCWwFkJjHnFiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ext4: fix sparse warnings in fast_commit code
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the change, it looks good to me.

- Harshad

On Fri, Nov 6, 2020 at 9:14 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> Add missing __acquire() and __releases() annotations, and make
> fc_ineligible_reasons[] static, as it is not used outside of
> fs/ext4/fast_commit.c.
>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/fast_commit.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 5cd6630ab1b9..f2033e13a273 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -156,6 +156,7 @@ void ext4_fc_init_inode(struct inode *inode)
>
>  /* This function must be called with sbi->s_fc_lock held. */
>  static void ext4_fc_wait_committing_inode(struct inode *inode)
> +__releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
>  {
>         wait_queue_head_t *wq;
>         struct ext4_inode_info *ei = EXT4_I(inode);
> @@ -911,6 +912,8 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
>
>  /* Commit all the directory entry updates */
>  static int ext4_fc_commit_dentry_updates(journal_t *journal, u32 *crc)
> +__acquires(&sbi->s_fc_lock)
> +__releases(&sbi->s_fc_lock)
>  {
>         struct super_block *sb = (struct super_block *)(journal->j_private);
>         struct ext4_sb_info *sbi = EXT4_SB(sb);
> @@ -2106,7 +2109,7 @@ void ext4_fc_init(struct super_block *sb, journal_t *journal)
>         journal->j_fc_cleanup_callback = ext4_fc_cleanup;
>  }
>
> -const char *fc_ineligible_reasons[] = {
> +static const char *fc_ineligible_reasons[] = {
>         "Extended attributes changed",
>         "Cross rename",
>         "Journal flag changed",
> --
> 2.28.0
>
