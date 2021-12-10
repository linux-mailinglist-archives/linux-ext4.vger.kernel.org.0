Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EBC470B24
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Dec 2021 20:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbhLJT6v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Dec 2021 14:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243539AbhLJT6v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Dec 2021 14:58:51 -0500
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BE6C061746
        for <linux-ext4@vger.kernel.org>; Fri, 10 Dec 2021 11:55:15 -0800 (PST)
Received: from myt5-23f0be3aa648.qloud-c.yandex.net (myt5-23f0be3aa648.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 825C92E19D9;
        Fri, 10 Dec 2021 22:55:11 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id Qf3g4r9lEE-tALOcJoZ;
        Fri, 10 Dec 2021 22:55:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1639166111; bh=x2PZgvoo/kReUy2QOjLYtPwBVSCbht88jKxnF+nK3VY=;
        h=Message-ID:Subject:To:From:In-Reply-To:cc:References:Date;
        b=NTDosWMYbkSiv4v65sAUWLREa/qi7bhLE1RPiWzDz/Q3PtkOYCixXdenjWavAQ+qn
         WniKRUBeN01+mNzq4HNCWuk5qm0l4rpVJs+CGKzCc2zlvo3RmvfTuMg0utlcLs/YsT
         bg9RO3ELduzJ1GYgPgG7z3/t/yxvYTzL0OEoic9s=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:fc5c:865:23f2:ff7c])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id bPTyncLYzJ-tAPaQGS8;
        Fri, 10 Dec 2021 22:55:10 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Date:   Fri, 10 Dec 2021 22:55:10 +0300 (MSK)
From:   Roman Anufriev <dotdot@yandex-team.ru>
X-X-Sender: dotdot@dotdot-osx
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
cc:     david@fromorbit.com, adilger@dilger.ca, linux-ext4@vger.kernel.org,
        jack@suse.cz, wshilong@ddn.com, dmtrmonakhov@yandex-team.ru,
        darrick.wong@oracle.com
Subject: Re: [PATCH] ext4: compare inode's i_projid with EXT4_DEF_PROJID
 rather than check EXT4_INODE_PROJINHERIT flag
In-Reply-To: <Ya+3L3gBFCeWZki7@mit.edu>
Message-ID: <alpine.OSX.2.23.453.2112102232440.94559@dotdot-osx>
References: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru> <alpine.OSX.2.23.453.2112071702150.70498@dotdot-osx> <Ya+3L3gBFCeWZki7@mit.edu>
User-Agent: Alpine 2.23 (OSX 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Tue, 7 Dec 2021, Theodore Y. Ts'o wrote:

> On Tue, Dec 07, 2021 at 05:05:19PM +0300, Roman Anufriev wrote:
>>> Commit 7ddf79a10395 ("ext4: only set project inherit bit for directory")
>>> removes EXT4_INODE_PROJINHERIT flag from regular files. This makes
>>> ext4_statfs() output incorrect (function does not apply quota limits
>>> on used/available space, etc) when called on dentry of regular file
>>> with project quota enabled.
>
> Under what circumstance is userspace trying to call statfs on a file
> descriptor?
>
> Removing the test for EXT4_INODE_PROJINHERIT will cause
> incorrect/misleading results being returned in the case where we have
> a directory where a directory hierarchy is using project id's, but
> which is *not* using PROJINHERIT.

I'm not sure I quite understood what will be wrong in that case, because
as Dave mentioned:

> PROJINHERIT just indicates the default projid that an inode is
> created with; ...

 								Roman
