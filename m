Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E504FECD5
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Apr 2022 04:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiDMCZy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Apr 2022 22:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiDMCZx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Apr 2022 22:25:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0CC2529E
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 19:23:33 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KdRFr6PHLz1HBrY;
        Wed, 13 Apr 2022 10:22:56 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 10:23:31 +0800
Subject: Re: [RFC PATCH] ext4: add unmount filesystem message
To:     Theodore Ts'o <tytso@mit.edu>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <jack@suse.cz>, <yukuai3@huawei.com>, <yebin10@huawei.com>,
        <liuzhiqiang26@huawei.com>, <liangyun2@huawei.com>
References: <20220412145320.2669897-1-yi.zhang@huawei.com>
 <87pmlmcmu6.fsf@collabora.com> <YlYo/FqujCnUHH6X@mit.edu>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <fe9fcfcd-7c6c-19eb-525c-f8a79804481c@huawei.com>
Date:   Wed, 13 Apr 2022 10:23:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YlYo/FqujCnUHH6X@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/4/13 9:35, Theodore Ts'o wrote:
> On Tue, Apr 12, 2022 at 12:01:37PM -0400, Gabriel Krisman Bertazi wrote:
>> Zhang Yi <yi.zhang@huawei.com> writes:
>>
>>> Now that we have kernel message at mount time, system administrator
> 
> "Now that we have...." is a bit misleading, since (at least to an
> English speaker) that this is something that was recently added, and
> that's not the case.
> 
>>> could acquire the mount time, device and options easily. But we don't
>>> have corresponding unmounting message at umount time, so we cannot know
>>> if someone umount a filesystem easily. Some of the modern filesystems
>>> (e.g. xfs) have the umounting kernel message, so add one for ext4
>>> filesystem for convenience.
>>>
>>>  EXT4-fs (sdb): mounted filesystem with ordered data mode. Quota mode: none.
>>>  EXT4-fs (sdb): unmounting filesystem.
>>
>> I don't think sysadmins should be relying on the kernel log for this,
>> since the information can easily be overwritten by new messages there.
>> Is there a reason why you can't just monitor /proc/self/mountinfo?
> 
> You're right that it can be dangerous for sysadmins to be relying on
> the kernel log for mount and umount notifications --- but it depends
> on what they think it means, and the potential pitfalls are there for
> both the mount and unmount messages.  The problem of course, is that
> bind mounts, and mount name spaces, so if the question is whether a
> file system is available at a particular mount point, then using the
> kernel log is definitely not going to be reliable.
> 
> But if the goal is to determine whether a particular device is safe to
> run fsck or otherwise access directly, or for the purposes of
> debugging the kernel and looking at the logs to understand when the
> device is being accessed by the kernel and when the file system is
> done with the device, I can see how it might be useful.
> 

Yes, I understand that the kernel log is not reliable, and
/proc/self/mountinfo neither. Our goal is simple, As Ted said, just add a
method to help sysadmins to know whether a particular ext4 device is really
doing unmount procedure, it could be helpful for us to debug kernel and
locate kernel bug.

Thanks,
Yi.



