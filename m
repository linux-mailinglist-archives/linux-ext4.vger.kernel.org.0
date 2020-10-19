Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22D2924B3
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgJSJhD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:37:03 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:55168 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgJSJhD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Oct 2020 05:37:03 -0400
X-Greylist: delayed 1042 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 05:37:02 EDT
Received: from myt5-23f0be3aa648.qloud-c.yandex.net (myt5-23f0be3aa648.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 7F76B2E1331;
        Mon, 19 Oct 2020 12:37:00 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id gHqJocfj1e-axwG6tbW;
        Mon, 19 Oct 2020 12:37:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1603100220; bh=NCXciKeDK3t4SxDpjti3y669IiQFWhJsiY1JYtCvPYo=;
        h=Message-ID:In-Reply-To:Subject:To:From:References:Date:cc;
        b=FUNhA8BXegJkNmeNasuqRphHpcOYz0yE/QYSa5mFOS/JqDJg9vJZT5t7MWzI0RR/U
         +nwPMd/U2aoLsezpMEfKXiIrR6SHihe8MXD9h+HmV0glsBF923QmUtHvURV9QZo2lh
         NseudYSu33Y3E6ZD9WE3tGp3yf7E5Bg9BgqmtZ40=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:6506::1:11])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id AyDRzt6Ii6-axn0ah8i;
        Mon, 19 Oct 2020 12:36:59 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Mon, 19 Oct 2020 12:36:59 +0300 (MSK)
From:   Roman Anufriev <dotdot@yandex-team.ru>
X-X-Sender: dotdot@dotdot-osx
To:     Jan Kara <jack@suse.cz>
cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH 2/2] ext4: export quota journalling mode via sysfs attr
 quota_mode
In-Reply-To: <20201019081927.GA30825@quack2.suse.cz>
Message-ID: <alpine.OSX.2.23.453.2010191229290.55532@dotdot-osx>
References: <1602761572-4713-1-git-send-email-dotdot@yandex-team.ru> <1602761572-4713-2-git-send-email-dotdot@yandex-team.ru> <20201015131522.GF7037@quack2.suse.cz> <alpine.OSX.2.23.453.2010172056490.87244@dotdot-osx>
 <20201019081927.GA30825@quack2.suse.cz>
User-Agent: Alpine 2.23 (OSX 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 19 Oct 2020, Jan Kara wrote:

> On Sat 17-10-20 21:26:37, Roman Anufriev wrote:
>> Hi, sorry for the delay.
>>
>> On Thu, 15 Oct 2020, Jan Kara wrote:
>>
>>> On Thu 15-10-20 14:32:52, Roman Anufriev wrote:
>>>> Right now, it is hard to understand what quota journalling type is enabled:
>>>> you need to be quite familiar with kernel code and trace it or really
>>>> understand what different combinations of fs flags/mount options lead to.
>>>>
>>>> This patch exports via sysfs attr /sys/fs/ext4/<disk>/quota_mode current
>>>> quota jounalling mode, making it easier to check at a glance/in autotests.
>>>> The semantics is similar to ext4 data journalling modes:
>>>>
>>>> * journalled - quota accounting and journaling are enabled
>>>> * writeback  - quota accounting is enabled, but journalling is disabled
>>>> * none       - quota accounting is disabled
>>>> * disabled   - kernel compiled without CONFIG_QUOTA feature
>>>>
>>>> Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
>>>> Reviewed-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
>>>
>>> Hum, I'm not sure about this. The state of quota can be found out with
>>> "quotaon -p <mntpoint>" (or corresponding quotactl if you need this from
>>> C). The only thing you won't learn is journalled / writeback mode and
>>> generally you should not care about this although I agree that for fs
>>> crash testing purposes you may care. But is that big enough usecase for a
>>> new sysfs file when all the information is already available for userspace
>>> just not in a convenient form?
>>
>> Rationale behind this patch was mainly the addition of an easy way to check
>> whether quota journalled or not as this is quite wanted feature in out
>> production environment. TBH, I was not sure about sysfs file too, but it
>> seemed to me like the most natural place to put it. Maybe if sysfs is an
>> overkill - just add printing to dmesg on mount? At least, you'll be able to
>> check what quota type you can enable right after mounting.
>>
>>> BTW, I've now realized ext4_any_quota_enabled() has actually misleading
>>> name in the sysfs file reports wrong information. It is rather
>>> ext4_any_quota_may_be_enabled() since presence of QUOTA mount option only
>>> says that quotaon(8) will enable quotas if it is run, not that quota
>>> accounting is enabled. sb_any_quota_loaded() tells you if accounting is
>>> actually enabled or not (however this can change anytime so that's why we
>>> use more relaxed checks for the purpose of journal credit estimates).
>>
>> My bad! Totally forgot about the case when 'quota' mount option is present
>> but quota accounting is not enabled, as our helper-tool around 'quotactl()'
>> do remounting+enabling in one go.
>>
>> I'll rename the function to smth like 'ext4_quota_capable()' in v2. And if
>> printing to dmesg is OK, I'll probably still use this function to print on
>> mount what the quota type will be after accounting is enabled.
>
> Yeah, if a message in dmesg is fine for your purposes, I'd rather go with
> that than with a sysfs file.

I think it'll be enough. I've implemented this in v3 (skip the v2, please 
- made a syntax mistake there): 
https://lore.kernel.org/linux-ext4/1603099162-25028-1-git-send-email-dotdot@yandex-team.ru/

 								Roman
