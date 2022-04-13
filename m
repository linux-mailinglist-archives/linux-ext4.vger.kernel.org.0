Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D846F4FEFDD
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Apr 2022 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiDMGgT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Apr 2022 02:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiDMGgQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Apr 2022 02:36:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F60312A9F
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 23:33:56 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KdXnK02zQzgYlH;
        Wed, 13 Apr 2022 14:32:05 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 14:33:53 +0800
Subject: Re: [RFC PATCH] ext4: add unmount filesystem message
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <jack@suse.cz>, <yukuai3@huawei.com>, <yebin10@huawei.com>,
        <liuzhiqiang26@huawei.com>, <liangyun2@huawei.com>
References: <20220412145320.2669897-1-yi.zhang@huawei.com>
 <87pmlmcmu6.fsf@collabora.com> <YlYo/FqujCnUHH6X@mit.edu>
 <fe9fcfcd-7c6c-19eb-525c-f8a79804481c@huawei.com>
 <20220413035107.GA16747@magnolia>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <e13dd15a-e394-6408-217c-e5f1aaa09c47@huawei.com>
Date:   Wed, 13 Apr 2022 14:33:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220413035107.GA16747@magnolia>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/4/13 11:51, Darrick J. Wong wrote:
> On Wed, Apr 13, 2022 at 10:23:31AM +0800, Zhang Yi wrote:
>> On 2022/4/13 9:35, Theodore Ts'o wrote:
>>> On Tue, Apr 12, 2022 at 12:01:37PM -0400, Gabriel Krisman Bertazi wrote:
>>>> Zhang Yi <yi.zhang@huawei.com> writes:
>>>>
>>>>> Now that we have kernel message at mount time, system administrator
>>>
>>> "Now that we have...." is a bit misleading, since (at least to an
>>> English speaker) that this is something that was recently added, and
>>> that's not the case.
>>>
>>>>> could acquire the mount time, device and options easily. But we don't
>>>>> have corresponding unmounting message at umount time, so we cannot know
>>>>> if someone umount a filesystem easily. Some of the modern filesystems
>>>>> (e.g. xfs) have the umounting kernel message, so add one for ext4
>>>>> filesystem for convenience.
>>>>>
>>>>>  EXT4-fs (sdb): mounted filesystem with ordered data mode. Quota mode: none.
>>>>>  EXT4-fs (sdb): unmounting filesystem.
>>>>
>>>> I don't think sysadmins should be relying on the kernel log for this,
>>>> since the information can easily be overwritten by new messages there.
>>>> Is there a reason why you can't just monitor /proc/self/mountinfo?
>>>
>>> You're right that it can be dangerous for sysadmins to be relying on
>>> the kernel log for mount and umount notifications --- but it depends
>>> on what they think it means, and the potential pitfalls are there for
>>> both the mount and unmount messages.  The problem of course, is that
>>> bind mounts, and mount name spaces, so if the question is whether a
>>> file system is available at a particular mount point, then using the
>>> kernel log is definitely not going to be reliable.
>>>
>>> But if the goal is to determine whether a particular device is safe to
>>> run fsck or otherwise access directly, or for the purposes of
>>> debugging the kernel and looking at the logs to understand when the
>>> device is being accessed by the kernel and when the file system is
>>> done with the device, I can see how it might be useful.
>>>
>>
>> Yes, I understand that the kernel log is not reliable, and
>> /proc/self/mountinfo neither. Our goal is simple, As Ted said, just add a
>> method to help sysadmins to know whether a particular ext4 device is really
>> doing unmount procedure, it could be helpful for us to debug kernel and
>> locate kernel bug.
> 
> But if the mount/unmount messages are ratelimited, how will you know for
> sure if the ratelimiting mechanism elides the message?
> 

This is to be expected that the messages are ratelimited, it's just a "try best"
way to let us acquire more information, it's best if it write something down and
not surprising if not. If the messages are ratelimited will get the "...suppressed"
message and could know what happened, we will combine other logs (e.g. systemd log)
to make things clear as far as possible.

Thanks,
Yi.
