Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28C43FEF4
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Oct 2021 17:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhJ2PFt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Oct 2021 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2PFt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Oct 2021 11:05:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B134CC061570
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 08:03:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C21601F45B3F;
        Fri, 29 Oct 2021 16:03:17 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com,
        Ext4 <linux-ext4@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Subject: Re: [PATCH v2 10/10] syscalls/fanotify20: Test capture of multiple
 errors
Organization: Collabora
References: <20211026184239.151156-1-krisman@collabora.com>
        <20211026184239.151156-11-krisman@collabora.com>
        <CAOQ4uxia5Qhieui+keBLumWwGd2+wv88+FykWq-zMrDrHmZUrA@mail.gmail.com>
Date:   Fri, 29 Oct 2021 12:03:11 -0300
In-Reply-To: <CAOQ4uxia5Qhieui+keBLumWwGd2+wv88+FykWq-zMrDrHmZUrA@mail.gmail.com>
        (Amir Goldstein's message of "Wed, 27 Oct 2021 13:00:07 +0300")
Message-ID: <87bl37an68.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Tue, Oct 26, 2021 at 9:44 PM Gabriel Krisman Bertazi
>> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
>> @@ -78,6 +78,18 @@ static void tcase2_trigger_lookup(void)
>>                         ret, BAD_DIR, errno, EUCLEAN);
>>  }
>>
>> +static void tcase3_trigger(void)
>> +{
>> +       trigger_fs_abort();
>> +       tcase2_trigger_lookup();
>
> So after remount,abort filesystem operations can still be executed?
> Then I guess my comment from the previous patch about running the test in a loop
> is not relevant?

Hi Amir,

As you mentioned here, -i works fine.  Abort will remount with
MS_RDONLY, and this doesn't affect the existing tests.  Future tests
that write to the file system inside .trigger_error() would require the
umount-mount cycle but, since the goal is testing fanotify and not
specific fs errors, I think we don't need the added complexity of such
tests.

Output of '-i #' always pass:

  root@test-box:~/ltp/testcases/kernel/syscalls/fanotify# ./fanotify20 -i 5
  tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
  tst_test.c:932: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
  mke2fs 1.46.4 (18-Aug-2021)
  tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
  fanotify.h:252: TINFO: fid(test_mnt) = 469af9fc.8ced5767.2.0.0...
  fanotify.h:252: TINFO: fid(test_mnt/internal_dir/bad_dir) = 469af9fc.8ced5767.8002.acd05469.0...
  debugfs 1.46.4 (18-Aug-2021)
  fanotify20.c:234: TPASS: Successfully received: Trigger abort
  fanotify20.c:234: TPASS: Successfully received: Lookup of inode with invalid mode
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission 2
  fanotify20.c:234: TPASS: Successfully received: Trigger abort
  fanotify20.c:234: TPASS: Successfully received: Lookup of inode with invalid mode
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission 2
  fanotify20.c:234: TPASS: Successfully received: Trigger abort
  fanotify20.c:234: TPASS: Successfully received: Lookup of inode with invalid mode
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission 2
  fanotify20.c:234: TPASS: Successfully received: Trigger abort
  fanotify20.c:234: TPASS: Successfully received: Lookup of inode with invalid mode
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission 2
  fanotify20.c:234: TPASS: Successfully received: Trigger abort
  fanotify20.c:234: TPASS: Successfully received: Lookup of inode with invalid mode
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission
  fanotify20.c:234: TPASS: Successfully received: Multiple error submission 2

  Summary:
  passed   20
  failed   0
  broken   0
  skipped  0
  warnings 0

Thanks,

-- 
Gabriel Krisman Bertazi
