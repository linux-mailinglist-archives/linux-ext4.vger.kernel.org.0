Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4759F405B4E
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Sep 2021 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbhIIQw3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Sep 2021 12:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbhIIQwW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Sep 2021 12:52:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12733C061575
        for <linux-ext4@vger.kernel.org>; Thu,  9 Sep 2021 09:51:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i21so4945836ejd.2
        for <linux-ext4@vger.kernel.org>; Thu, 09 Sep 2021 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2AHcFsyu9PCGUUDaNDcsgNX2QmZTlKGjrFoPDaUEv0=;
        b=HUf0GdRROAUCIvj9pE92DhPtc1QvMbIkEIjA4HYvXQooXdH8CTXeexHR4Ppf/TBKre
         j7LxpnsK3EtXuifhl1ZISVYpp7g6ywGtr5qJ0O8C5iOgQP7GUzdyEIYMif45ibknAKY/
         QuDyT50htErmab9ainp/W3QmNJ45vyF2ERAQb5NhkC8ybvtm36CRhTIV26L1EWWlulz+
         0fK6Wsm8+WxKo4bRwRsGCtCX4fRUAnmAUYWcM5jLo8vsLSHWmsOPwE85J/k53pT9ZyIw
         FWtgMYS/lJfRv0CkG90HvoaiKLqoJzDvNpaKTETF1UfCbQsNBRyhur4AZdfrhA2L+CaN
         +o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2AHcFsyu9PCGUUDaNDcsgNX2QmZTlKGjrFoPDaUEv0=;
        b=FgRNTRhqe6Ph6g7L6DildeNIshxzK7trH06rIbvVsGs4yQoXyD9pSeOA7iduNe4Zwm
         85WkasaFG0n/2Gx/zj1NdDmGVCW+FdA9yJS9t6j7yLbrf26a7jUm53rCL4yl4ViymKH+
         ZWCfwku+lwBMfKgFIk8wuq/qtgbOEbHstEdQqb7LsJR+1lHjECtzlFDgymBS+6AMnQnm
         rW7efSD07rXPTW6gJaTXOlqFJ8Bc7p8qfqzho4QPZKiQdLeUi5Lt76V/VKFggWVACze+
         QwXrAIcJAMxN9Nd6y9xmDFopSWUqF6cFmFFKbryeNXs7DY86WfTE2JJD+yya/NsQSiRF
         K9zA==
X-Gm-Message-State: AOAM53078TOtJ+xlYZKhx4/RRdo3kGPJCOd3sbvdvpGxrUMnh7ZOw1WD
        jUB4n46OtscqiCTzdHBQWuESkiyR91+Rq1ad9os=
X-Google-Smtp-Source: ABdhPJzsk/Iq+sSMrGrxqA898qDsiZV5LsNOzDPp/lWeRTuozRBZEVCub7M2zIsUpoTeSACOrkDLWBmbOanSHLUvLUA=
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr4526418ejc.72.1631206271574;
 Thu, 09 Sep 2021 09:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210820044505.474318-1-houtao1@huawei.com> <0129a56a-2d45-5558-9125-0b3408104b7d@huawei.com>
 <f84bf083-6933-de6e-cb86-6bdc0daa35cb@huawei.com>
In-Reply-To: <f84bf083-6933-de6e-cb86-6bdc0daa35cb@huawei.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 9 Sep 2021 09:51:00 -0700
Message-ID: <CAD+ocbxnfrvZo_Vtc3nt2B_P2v677sBtzzc1Z8JL6A_j49sKXw@mail.gmail.com>
Subject: Re: [PATCH] ext4: limit the number of blocks in one ADD_RANGE TLV
To:     Hou Tao <houtao1@huawei.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry Hou for getting back to you late. This looks good to me.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>


On Tue, Sep 7, 2021 at 4:21 AM Hou Tao <houtao1@huawei.com> wrote:
>
> ping ?
>
> On 8/30/2021 3:52 PM, Hou Tao wrote:
> > ping ?
> >
> > On 8/20/2021 12:45 PM, Hou Tao wrote:
> >> Now EXT4_FC_TAG_ADD_RANGE uses ext4_extent to track the
> >> newly-added blocks, but the limit on the max value of
> >> ee_len field is ignored, and it can lead to BUG_ON as
> >> shown below when running command "fallocate -l 128M file"
> >> on a fast_commit-enabled fs:
> >>
> >>   kernel BUG at fs/ext4/ext4_extents.h:199!
> >>   invalid opcode: 0000 [#1] SMP PTI
> >>   CPU: 3 PID: 624 Comm: fallocate Not tainted 5.14.0-rc6+ #1
> >>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> >>   RIP: 0010:ext4_fc_write_inode_data+0x1f3/0x200
> >>   Call Trace:
> >>    ? ext4_fc_write_inode+0xf2/0x150
> >>    ext4_fc_commit+0x93b/0xa00
> >>    ? ext4_fallocate+0x1ad/0x10d0
> >>    ext4_sync_file+0x157/0x340
> >>    ? ext4_sync_file+0x157/0x340
> >>    vfs_fsync_range+0x49/0x80
> >>    do_fsync+0x3d/0x70
> >>    __x64_sys_fsync+0x14/0x20
> >>    do_syscall_64+0x3b/0xc0
> >>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >> Simply fixing it by limiting the number of blocks
> >> in one EXT4_FC_TAG_ADD_RANGE TLV.
> >>
> >> Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  fs/ext4/fast_commit.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> >> index e8195229c252..782d05a3f97a 100644
> >> --- a/fs/ext4/fast_commit.c
> >> +++ b/fs/ext4/fast_commit.c
> >> @@ -893,6 +893,12 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
> >>                                          sizeof(lrange), (u8 *)&lrange, crc))
> >>                              return -ENOSPC;
> >>              } else {
> >> +                    unsigned int max = (map.m_flags & EXT4_MAP_UNWRITTEN) ?
> >> +                            EXT_UNWRITTEN_MAX_LEN : EXT_INIT_MAX_LEN;
> >> +
> >> +                    /* Limit the number of blocks in one extent */
> >> +                    map.m_len = min(max, map.m_len);
> >> +
> >>                      fc_ext.fc_ino = cpu_to_le32(inode->i_ino);
> >>                      ex = (struct ext4_extent *)&fc_ext.fc_ex;
> >>                      ex->ee_block = cpu_to_le32(map.m_lblk);
> > .
