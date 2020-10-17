Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B082913A7
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Oct 2020 20:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437465AbgJQS06 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 17 Oct 2020 14:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436970AbgJQS06 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 17 Oct 2020 14:26:58 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE47C061755
        for <linux-ext4@vger.kernel.org>; Sat, 17 Oct 2020 11:26:54 -0700 (PDT)
Received: from myt5-23f0be3aa648.qloud-c.yandex.net (myt5-23f0be3aa648.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id A5E032E1456;
        Sat, 17 Oct 2020 21:26:38 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id MBw1bwNhIW-Qcw4tCEV;
        Sat, 17 Oct 2020 21:26:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1602959198; bh=QDkrewxCUIAVycFdaQJbt/qcXN6h537xEA8z/cZ74Qw=;
        h=Message-ID:In-Reply-To:Subject:To:From:References:Date:cc;
        b=bKdO243HqRArZr6CzsyLD5W9l5n7wVqIPBIvgaSDIP4Q+A6HJhOIK/XugrH32lQ+g
         ABbYo+HJGPAok54nqPNOwqKVWQX6LVFqmZNsp20zW6RllwlbvXdvZ4zD7tpG648VPl
         178trz9o0JMp28Hiu/6/B7pGbAQMNzZcDwccC2SQ=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:6602::1:2])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id zyPwW8ZZmN-QcnmTOxa;
        Sat, 17 Oct 2020 21:26:38 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Sat, 17 Oct 2020 21:26:37 +0300 (MSK)
From:   Roman Anufriev <dotdot@yandex-team.ru>
X-X-Sender: dotdot@dotdot-osx
To:     Jan Kara <jack@suse.cz>
cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH 2/2] ext4: export quota journalling mode via sysfs attr
 quota_mode
In-Reply-To: <20201015131522.GF7037@quack2.suse.cz>
Message-ID: <alpine.OSX.2.23.453.2010172056490.87244@dotdot-osx>
References: <1602761572-4713-1-git-send-email-dotdot@yandex-team.ru> <1602761572-4713-2-git-send-email-dotdot@yandex-team.ru> <20201015131522.GF7037@quack2.suse.cz>
User-Agent: Alpine 2.23 (OSX 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, sorry for the delay.

On Thu, 15 Oct 2020, Jan Kara wrote:

> On Thu 15-10-20 14:32:52, Roman Anufriev wrote:
>> Right now, it is hard to understand what quota journalling type is enabled:
>> you need to be quite familiar with kernel code and trace it or really
>> understand what different combinations of fs flags/mount options lead to.
>>
>> This patch exports via sysfs attr /sys/fs/ext4/<disk>/quota_mode current
>> quota jounalling mode, making it easier to check at a glance/in autotests.
>> The semantics is similar to ext4 data journalling modes:
>>
>> * journalled - quota accounting and journaling are enabled
>> * writeback  - quota accounting is enabled, but journalling is disabled
>> * none       - quota accounting is disabled
>> * disabled   - kernel compiled without CONFIG_QUOTA feature
>>
>> Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
>> Reviewed-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
>
> Hum, I'm not sure about this. The state of quota can be found out with
> "quotaon -p <mntpoint>" (or corresponding quotactl if you need this from
> C). The only thing you won't learn is journalled / writeback mode and
> generally you should not care about this although I agree that for fs
> crash testing purposes you may care. But is that big enough usecase for a
> new sysfs file when all the information is already available for userspace
> just not in a convenient form?

Rationale behind this patch was mainly the addition of an easy way to 
check whether quota journalled or not as this is quite wanted feature in 
out production environment. TBH, I was not sure about sysfs file too, but 
it seemed to me like the most natural place to put it. Maybe if sysfs is 
an overkill - just add printing to dmesg on mount? At least, you'll be 
able to check what quota type you can enable right after mounting.

> BTW, I've now realized ext4_any_quota_enabled() has actually misleading
> name in the sysfs file reports wrong information. It is rather
> ext4_any_quota_may_be_enabled() since presence of QUOTA mount option only
> says that quotaon(8) will enable quotas if it is run, not that quota
> accounting is enabled. sb_any_quota_loaded() tells you if accounting is
> actually enabled or not (however this can change anytime so that's why we
> use more relaxed checks for the purpose of journal credit estimates).

My bad! Totally forgot about the case when 'quota' mount option is present 
but quota accounting is not enabled, as our helper-tool around 
'quotactl()' do remounting+enabling in one go.

I'll rename the function to smth like 'ext4_quota_capable()' in v2. And if 
printing to dmesg is OK, I'll probably still use this function to print on 
mount what the quota type will be after accounting is enabled.

 								Roman
