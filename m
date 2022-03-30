Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72474EB809
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Mar 2022 03:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbiC3B7H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Mar 2022 21:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbiC3B7G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Mar 2022 21:59:06 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DE6181B2C
        for <linux-ext4@vger.kernel.org>; Tue, 29 Mar 2022 18:57:20 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22U1vI3B079229;
        Wed, 30 Mar 2022 10:57:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Wed, 30 Mar 2022 10:57:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22U1vIWs079191
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 30 Mar 2022 10:57:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fb5d20c5-36a6-2c51-288a-7cc1e0a76d3e@I-love.SAKURA.ne.jp>
Date:   Wed, 30 Mar 2022 10:57:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] possible deadlock in p9_write_work
Content-Language: en-US
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Andrew Perepechko <andrew.perepechko@hpe.com>,
        Andreas Dilger <adilger@dilger.ca>,
        "Theodore Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+bde0f89deacca7c765b8@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>
References: <0000000000009523b605db620972@google.com>
 <385ce718-f965-4005-56b6-34922c4533b8@I-love.SAKURA.ne.jp>
 <YkObebLZMp5AyRpr@codewreck.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YkObebLZMp5AyRpr@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/03/30 8:51, Dominique Martinet wrote:
> Tetsuo Handa wrote on Wed, Mar 30, 2022 at 07:35:47AM +0900:
>> This seems to be an example of
>> https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
>> introduced by "ext4: truncate during setxattr leads to kernel panic".
> 
> Thanks for the pointer
> 
>> Please don't use schedule_work() if you need to use flush_scheduled_work().
> 
> In this case we don't call flush_scheduled_work -- ext4 does.

Yes, that's why I changed recipients to ext4 people.

> The problem is mixing in the two subsystems when someone (e.g. syzbot)
> opens an ext4 file and passes that fd to 9p when mounting with e.g.
> mount -t 9p -o rfdno=<no>,wfdno=<no>
> 
> Frankly that's just not something I consider useful, interacting through
> 9p to a local file doesn't make sense except for testing.
> 
> If that is a real problem, the simplest way out would be to just forbid
> non-socket FDs if it's something we can check.

Do you mean that p9_fd_open() in net/9p/trans_fd.c does not need to accept non-socket file descriptors?
Then, it's something you can check. You can use S_ISSOCK() like e.g. netlink_getsockbyfilp() does.
