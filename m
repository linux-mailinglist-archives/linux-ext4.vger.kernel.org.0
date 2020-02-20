Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F9716608C
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 16:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBTPLJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 10:11:09 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:52616 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728079AbgBTPLI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Feb 2020 10:11:08 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 736082E14AC;
        Thu, 20 Feb 2020 18:11:05 +0300 (MSK)
Received: from sas2-3e4aeb094591.qloud-c.yandex.net (sas2-3e4aeb094591.qloud-c.yandex.net [2a02:6b8:c08:7192:0:640:3e4a:eb09])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id NP8L47g1nH-B5LaKIL4;
        Thu, 20 Feb 2020 18:11:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1582211465; bh=JzY2p2yHfC8DQGPlmESsIrH/GFQVIX3iYWYSsaBApj4=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=VFQusz4YCZw+u71YaH5NIAPwsPcuxHZXBxW91aEO2ClZuFFaLYWPqzEq1vgbRhce8
         1OW5vb47U3rZBsSZ0Yhtr8uOdNjpbNsVXtCGbSRohjnTnQW4xGxY3Xyffdbx7nbTwZ
         RBhQkpzmj/9ht9D7xc0LQk0RlMjia0fH4Mi+ihCk=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by sas2-3e4aeb094591.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id DmFdqeadjf-B4UaZij4;
        Thu, 20 Feb 2020 18:11:04 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] ext4: fix handling mount -o remount,nolazytime
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <158210399258.5335.3994877510070204710.stgit@buzz>
 <20200219162242.GI330201@mit.edu>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <2326451b-faf2-72a5-cb55-89cb6d8ce9ed@yandex-team.ru>
Date:   Thu, 20 Feb 2020 18:11:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219162242.GI330201@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 19/02/2020 19.22, Theodore Y. Ts'o wrote:
> On Wed, Feb 19, 2020 at 12:19:52PM +0300, Konstantin Khlebnikov wrote:
>> Tool "mount" from util-linux >= 2.27 knows about flag MS_LAZYTIME and
>> handles options "lazytime" and "nolazytime" as fs-independent.
>>
>> For ext4 it works for enabling lazytime: mount(MS_REMOUNT | MS_LAZYTIME),
>> but does not work for disabling: mount(MS_REMOUNT).
>>
>> Currently ext4 has performance issue in lazytime implementation caused by
>> contention around inode_hash_lock in ext4_update_other_inodes_time().
>>
>> Fortunately lazytime still could be disabled without unmounting by passing
>> "nolazytime" as fs-specific mount option: mount(MS_REMOUNT, "nolazytime").
>> But modern versions of tool "mount" cannot do that.
>>
>> This patch fixes remount for modern tool and keeps backward compatibility.
> 
> Actually, if you are using ancient versions of mount that don't know
> about MS_LAZYTIME, then when you do something like mount -o
> remount,usrquota /dev/sdb" with your patch, it will disable
> MS_LAZYTIME, which would be a backwards incompatible change.
> 
> So if we make this change, and there is someone who wants to use
> lazytime on some ancient enterprise linux system which is still using
> an old version of util-linux, and then take a kernel with this change,
> then it will result in a change in the behavior they will see.  The
> good news is that RHEL 8 is using util-linux 2.32, but RHEL 7 is still
> using util-linux 2.23.
> 
> Lazytime is not enabled by default, so this issue is really only a
> problem for someone which explicitly enables lazytime using a newer
> version of util-linux, and then disables lazytime with a newer version
> of util-linux.  So the behaviour of a2fd66d069d8 ("ext4: set lazytime
> on remount if MS_LAZYTIME is set by mount") was in fact an explicit
> decision to do things in that way.
> 
> So maybe we might want to change things, assuming that it's unlikely
> users will try to be running new kernels on ancient distros.  But I
> really wouldn't want to add a Fixes tag, and I would want to make sure
> this doesn't get backported to older kernels, since the change does
> *not* keep backwards compatibility.
> 
> Unfortunately, it's not possible to do this without breaking
> compatibility for at least some systems.  The question is whether or
> not we think systems running util-linux less than 2.27 is something we
> care about for new kernels.  Times may have changed since
> a2fd66d069d8.
> 
> So I might be willing to take this patch (I invite comments from
> others), but there will need to be a DO NOT BACKPORT warning in the
> commit description.

Usually all these options are saved in /etc/fstab and
mount -o remount,... includes them into line passed into syscall.
In this case remounting any other option will not disable lazytime.

But there might be implementations of /bin/mount which doesn't do that.

> 
> Cheers,
> 
> 						- Ted
> 
