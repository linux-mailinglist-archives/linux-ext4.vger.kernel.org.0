Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A4F46BD35
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Dec 2021 15:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhLGOJK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Dec 2021 09:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhLGOJK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Dec 2021 09:09:10 -0500
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7301C061574
        for <linux-ext4@vger.kernel.org>; Tue,  7 Dec 2021 06:05:39 -0800 (PST)
Received: from sas1-3cba3404b018.qloud-c.yandex.net (sas1-3cba3404b018.qloud-c.yandex.net [IPv6:2a02:6b8:c08:bd26:0:640:3cba:3404])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 156B92E1FA2;
        Tue,  7 Dec 2021 17:05:35 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-3cba3404b018.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 8KcV68HvCd-5YLmb7OY;
        Tue, 07 Dec 2021 17:05:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1638885935; bh=06Qste8PV9ZwA9XuvtQGdPGSPmjXNlbQahbwQrKMamo=;
        h=Message-ID:Subject:To:From:In-Reply-To:cc:References:Date;
        b=P268nmj+qSa3A9UBExYqt/dKBrT5NcEsOPBPSEFxq/lEJx5WJG4NkReEg0KRwoEU8
         DN5BHXThjAzXwbEA3l9Cmv+1vsk5GGJSOtCZw/42CnbjsU3BF5T0w4NhkTQSdEoCbi
         PQblMI0PikmzZacsZuG1VIHmInw4x7CMmk3KPfrk=
Authentication-Results: sas1-3cba3404b018.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:408:68da:13a6:fab:32c])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Rsd4XjkM9p-5YQead3X;
        Tue, 07 Dec 2021 17:05:34 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Date:   Tue, 7 Dec 2021 17:05:19 +0300 (MSK)
From:   Roman Anufriev <dotdot@yandex-team.ru>
X-X-Sender: dotdot@dotdot-osx
To:     linux-ext4@vger.kernel.org
cc:     tytso@mit.edu, jack@suse.cz, wshilong@ddn.com,
        dmtrmonakhov@yandex-team.ru, dotdot@yandex-team.ru
Subject: Re: [PATCH] ext4: compare inode's i_projid with EXT4_DEF_PROJID
 rather than check EXT4_INODE_PROJINHERIT flag
In-Reply-To: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru>
Message-ID: <alpine.OSX.2.23.453.2112071702150.70498@dotdot-osx>
References: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru>
User-Agent: Alpine 2.23 (OSX 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Tue, 7 Dec 2021, Roman Anufriev wrote:

> Commit 7ddf79a10395 ("ext4: only set project inherit bit for directory")
> removes EXT4_INODE_PROJINHERIT flag from regular files. This makes
> ext4_statfs() output incorrect (function does not apply quota limits
> on used/available space, etc) when called on dentry of regular file
> with project quota enabled.
>
> This patch fixes this by comparing inode's i_projid with
> EXT4_DEF_PROJID, as there is no point in calling ext4_statfs_project()
> for inode with default project id.
>
> $ sudo project_quota info dir/
> project   2147516417
> usage     4096
> limit     5242880
> inodes    4
> ilimit    0
> $ sudo project_quota info dir/file | grep project
> project   2147516417
> $ df -h /dev/loop0
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      232M  2.1M  214M   1% /mnt/ext4img
>
> without patch:
> $ df -h dir/
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      5.0M  4.0K  5.0M   1% /mnt/ext4img
> $ df -h dir/file
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      232M  2.1M  214M   1% /mnt/ext4img
>
> with patch:
> $ df -h dir/
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      5.0M  4.0K  5.0M   1% /mnt/ext4img
> $ df -h dir/file
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop0      5.0M  4.0K  5.0M   1% /mnt/ext4img
>
> Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
> ---
> fs/ext4/super.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 79b6a0c..682d675 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6074,6 +6074,7 @@ static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf)
> 	struct super_block *sb = dentry->d_sb;
> 	struct ext4_sb_info *sbi = EXT4_SB(sb);
> 	struct ext4_super_block *es = sbi->s_es;
> +	kprojid_t kprojid;
> 	ext4_fsblk_t overhead = 0, resv_blocks;
> 	s64 bfree;
> 	resv_blocks = EXT4_C2B(sbi, atomic64_read(&sbi->s_resv_clusters));
> @@ -6098,9 +6099,10 @@ static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf)
> 	buf->f_fsid = uuid_to_fsid(es->s_uuid);
>
> #ifdef CONFIG_QUOTA
> -	if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&
> +	kprojid = EXT4_I(dentry->d_inode)->i_projid;
> +	if ((from_kprojid(current_user_ns(), kprojid) != EXT4_DEF_PROJID) &&
> 	    sb_has_quota_limits_enabled(sb, PRJQUOTA))
> -		ext4_statfs_project(sb, EXT4_I(dentry->d_inode)->i_projid, buf);
> +		ext4_statfs_project(sb, kprojid, buf);
> #endif
> 	return 0;
> }
> -- 
> 2.7.4
>
>

+Cc Wang Shilong <wshilong@ddn.com> author of 7ddf79a10395
