Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB54D470AFB
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Dec 2021 20:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbhLJT4l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Dec 2021 14:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242846AbhLJT4l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Dec 2021 14:56:41 -0500
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2354C0617A2
        for <linux-ext4@vger.kernel.org>; Fri, 10 Dec 2021 11:53:05 -0800 (PST)
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id B086A2E0AB2;
        Fri, 10 Dec 2021 22:53:02 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id dGRH4JAEoK-r1OmcMK1;
        Fri, 10 Dec 2021 22:53:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1639165982; bh=a3X0PzGEXMz27vgdL2yNUIgHS+Q2NoTKQKOI3G0CHek=;
        h=Message-ID:Subject:To:From:In-Reply-To:cc:References:Date;
        b=Ce98YCFgydwFrY3ZTLLG1SvtNyVSJxaxMYkrAWtkbT4cis400bbWgjatxA4e7/kDy
         ulNW3TByc3gD8g5xwxjSfr2tFH/hqNRP21TKw1Dq07EyXZOglbzZju7davYaRdfcjO
         DhnjqH927ISQxHXHIC1xWg5D/atnQi7B9+5uzwQw=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:fc5c:865:23f2:ff7c])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id zCF5zzQpxY-r1QW4Zne;
        Fri, 10 Dec 2021 22:53:01 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Date:   Fri, 10 Dec 2021 22:53:00 +0300 (MSK)
From:   Roman Anufriev <dotdot@yandex-team.ru>
X-X-Sender: dotdot@dotdot-osx
To:     Andreas Dilger <adilger@dilger.ca>
cc:     "Theodore Y. Ts'o" <tytso@MIT.EDU>, david@fromorbit.com,
        linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] ext4: compare inode's i_projid with EXT4_DEF_PROJID
 rather than check EXT4_INODE_PROJINHERIT flag
In-Reply-To: <F12B316D-D695-4B38-ABEA-D5F558696E9A@dilger.ca>
Message-ID: <alpine.OSX.2.23.453.2112102151100.90425@dotdot-osx>
References: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru> <alpine.OSX.2.23.453.2112071702150.70498@dotdot-osx> <Ya+3L3gBFCeWZki7@mit.edu> <F12B316D-D695-4B38-ABEA-D5F558696E9A@dilger.ca>
User-Agent: Alpine 2.23 (OSX 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Thu, 9 Dec 2021, Andreas Dilger wrote:

> On Dec 7, 2021, at 12:34 PM, Theodore Y. Ts'o <tytso@MIT.EDU> wrote:
>>
>> On Tue, Dec 07, 2021 at 05:05:19PM +0300, Roman Anufriev wrote:
>>>> Commit 7ddf79a10395 ("ext4: only set project inherit bit for directory")
>>>> removes EXT4_INODE_PROJINHERIT flag from regular files. This makes
>>>> ext4_statfs() output incorrect (function does not apply quota limits
>>>> on used/available space, etc) when called on dentry of regular file
>>>> with project quota enabled.
>>
>> Under what circumstance is userspace trying to call statfs on a file
>> descriptor?
>
> Who knows what users do?  Calling statfs() on a regular file works fine
> (returns stats for the filesystem), so I don't see why it wouldn't be
> consistent when calling statfs() on a file with projid set?

This is exactly my reasoning for this patch.

> Darrick, how does XFS handle this case?  I think it makes sense to be
> consistent with that implementation, since that was the main reason to
> remove PROJINHERIT from regular files in the first place.
>
>> Removing the test for EXT4_INODE_PROJINHERIT will cause
>> incorrect/misleading results being returned in the case where we have
>> a directory where a directory hierarchy is using project id's, but
>> which is *not* using PROJINHERIT.
>
> One alternative would be to check the PROJINHERIT status of the parent
> directory after calling statfs() on the regular file?  That should
> keep the semantics for PROJINHERIT the same, but avoid inconsistent
> results if called on a regular file:
>
> #ifdef CONFIG_QUOTA
> -	if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&
> +	if (ext4_test_inode_flag(S_ISDIR(dentry->d_inode) ? dentry->d_inode :
> +			   dentry->d_parent->d_inode, EXT4_INODE_PROJINHERIT) &&
> 	    sb_has_quota_limits_enabled(sb, PRJQUOTA))
> 		ext4_statfs_project(sb, EXT4_I(dentry->d_inode)->i_projid, buf);
> #endif
>
> Roman, does that work for you?

Yes, it was actually the first thing that came to my mind. But later I
realised, that there may be some pitfalls and it would probably make more
sense to check inode's own project id and report stats based on that. As
I thought that we check presense of EXT4_INODE_PROJINHERIT flag only to
make sure that this inode belongs to some project.

 								Roman
