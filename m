Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36540470B00
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Dec 2021 20:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhLJT5i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Dec 2021 14:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbhLJT5h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Dec 2021 14:57:37 -0500
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221DFC061746
        for <linux-ext4@vger.kernel.org>; Fri, 10 Dec 2021 11:54:02 -0800 (PST)
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 2A4E22E0A46;
        Fri, 10 Dec 2021 22:54:00 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id WCikWf3PjJ-rxOmT7ZB;
        Fri, 10 Dec 2021 22:54:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1639166040; bh=YP9X/joXOEdNPiny5TuzTiTw7+SG2i0a4/kcKBkOkGc=;
        h=Message-ID:Subject:To:From:In-Reply-To:cc:References:Date;
        b=Tws7ByylJxy8kB5br8Rx9CbkHp6NDaMW9RmKKTnh6nwXpxVJOG77kZxXvD4Hp8JNM
         8LvLmjZy0iMV4dLYstZeBf4abjsoTMmyDOGbLoiYHNtmMuNGvinyfJ971HXgkkd+S/
         p4PHryXM+CSt0dv55Bbt/v8zM9Qb3WJPp43xXjjA=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:fc5c:865:23f2:ff7c])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id SPVLANn380-rxQe9OsM;
        Fri, 10 Dec 2021 22:53:59 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Date:   Fri, 10 Dec 2021 22:53:59 +0300 (MSK)
From:   Roman Anufriev <dotdot@yandex-team.ru>
X-X-Sender: dotdot@dotdot-osx
To:     Dave Chinner <david@fromorbit.com>
cc:     Andreas Dilger <adilger@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] ext4: compare inode's i_projid with EXT4_DEF_PROJID
 rather than check EXT4_INODE_PROJINHERIT flag
In-Reply-To: <20211209233017.GA279368@dread.disaster.area>
Message-ID: <alpine.OSX.2.23.453.2112102213450.94515@dotdot-osx>
References: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru> <alpine.OSX.2.23.453.2112071702150.70498@dotdot-osx> <Ya+3L3gBFCeWZki7@mit.edu> <F12B316D-D695-4B38-ABEA-D5F558696E9A@dilger.ca> <20211209233017.GA279368@dread.disaster.area>
User-Agent: Alpine 2.23 (OSX 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Fri, 10 Dec 2021, Dave Chinner wrote:

> On Thu, Dec 09, 2021 at 03:53:55PM -0700, Andreas Dilger wrote:
>> On Dec 7, 2021, at 12:34 PM, Theodore Y. Ts'o <tytso@MIT.EDU> wrote:
>>>
>>> On Tue, Dec 07, 2021 at 05:05:19PM +0300, Roman Anufriev wrote:
>>>>> Commit 7ddf79a10395 ("ext4: only set project inherit bit for directory")
>>>>> removes EXT4_INODE_PROJINHERIT flag from regular files. This makes
>>>>> ext4_statfs() output incorrect (function does not apply quota limits
>>>>> on used/available space, etc) when called on dentry of regular file
>>>>> with project quota enabled.
>>>
>>> Under what circumstance is userspace trying to call statfs on a file
>>> descriptor?
>>
>> Who knows what users do?  Calling statfs() on a regular file works fine
>> (returns stats for the filesystem), so I don't see why it wouldn't be
>> consistent when calling statfs() on a file with projid set?
>>
>> Darrick, how does XFS handle this case?  I think it makes sense to be
>> consistent with that implementation, since that was the main reason to
>> remove PROJINHERIT from regular files in the first place.
>
> If PROJINHERIT is set on the inode, it will return the information
> for the projid on that inode. XFS doesn't care what type of inode it
> is, just whether the PROJINHERIT flag is set.
>
> That said, on XFS, only directory inodes will have the PROJINHERIT
> flag set. So, in effect, only statfs() on directory inodes can
> report project quota limits.

This is the thing that confused our users. It basically means that user
program should always trim paths up to directories to get true available
space, etc.

> PROJINHERIT just indicates the default projid that an inode is
> created with; it does not mean that directory tree quotas are what
> the user it doing with them...
>
>>> Removing the test for EXT4_INODE_PROJINHERIT will cause
>>> incorrect/misleading results being returned in the case where we have
>>> a directory where a directory hierarchy is using project id's, but
>>> which is *not* using PROJINHERIT.
>>
>> One alternative would be to check the PROJINHERIT status of the parent
>> directory after calling statfs() on the regular file?  That should
>> keep the semantics for PROJINHERIT the same, but avoid inconsistent
>> results if called on a regular file:
>
> This just opens a bigger can of worms that still has no consistent
> solution.
>
> What if the user has changed the projid of the file and it doesn't
> match the parent directory? That then reports something irrelevant
> to the user.
>
> What if there are hard links and the parent directories have
> different projid state? This can happen - we don't allow hard links
> into a new projid controlled directory, but we allow them into
> non-projid controlled directories even if the source is from a
> projid controlled heirarchy. We can add PROJINHERIT after a
> directory has already been populated. We can remove PROJINHERIT,
> too, after hardlinks within the same projid have been created. Hence
> a regular file inode can have different parent PROJINHERIT depending
> on path.  How do you do consistency then, because it's clearly not a
> directory quota controlled setup and there's no way of detecting
> that from statfs() context?

I think that part of these concerns are solved by the fact that we
check PROJINHERIT on parent directory, but use our own dentry/inode for
all calculations later (e.g. non-matching project ids of parent
directory and file is not an issue - statfs() will produce right output).
So, this approach is kinda useful for simple cases.

 								Roman
