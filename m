Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F187B3DFAC9
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 06:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhHDExK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 00:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhHDExK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 00:53:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF9FC0613D5
        for <linux-ext4@vger.kernel.org>; Tue,  3 Aug 2021 21:52:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8322C1F43565
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com
Subject: Re: [PATCH 6/7] syscalls/fanotify20: Test file event with broken inode
Organization: Collabora
References: <20210802214645.2633028-1-krisman@collabora.com>
        <20210802214645.2633028-7-krisman@collabora.com>
        <CAOQ4uxizX0ar7d9eYgazcenQcA7Ku7quEZOLbcaxKJiY0sTPLA@mail.gmail.com>
Date:   Wed, 04 Aug 2021 00:52:52 -0400
In-Reply-To: <CAOQ4uxizX0ar7d9eYgazcenQcA7Ku7quEZOLbcaxKJiY0sTPLA@mail.gmail.com>
        (Amir Goldstein's message of "Tue, 3 Aug 2021 12:08:11 +0300")
Message-ID: <87k0l1hkuz.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Tue, Aug 3, 2021 at 12:47 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> This test corrupts an inode entry with an invalid mode through debugfs
>> and then tries to access it.  This should result in a ext4 error, which
>> we monitor through the fanotify group.
>>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> ---
>>  .../kernel/syscalls/fanotify/fanotify20.c     | 38 +++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
>> index e7ced28eb61d..0c63e90edc3a 100644
>> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
>> @@ -76,6 +76,36 @@ static void trigger_fs_abort(void)
>>                    MS_REMOUNT|MS_RDONLY, "abort");
>>  }
>>
>> +#define TCASE2_BASEDIR "tcase2"
>> +#define TCASE2_BAD_DIR TCASE2_BASEDIR"/bad_dir"
>> +
>> +static unsigned int tcase2_bad_ino;
>> +static void tcase2_prepare_fs(void)
>> +{
>> +       struct stat stat;
>> +
>> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BASEDIR, 0777);
>> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BAD_DIR, 0777);
>> +
>> +       SAFE_STAT(MOUNT_PATH"/"TCASE2_BAD_DIR, &stat);
>> +       tcase2_bad_ino = stat.st_ino;
>> +
>> +       SAFE_UMOUNT(MOUNT_PATH);
>> +       do_debugfs_request(tst_device->dev, "sif " TCASE2_BAD_DIR " mode 0xff");
>> +       SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
>> +}
>> +
>> +static void tcase2_trigger_lookup(void)
>> +{
>> +       int ret;
>> +
>> +       /* SAFE_OPEN cannot be used here because we expect it to fail. */
>> +       ret = open(MOUNT_PATH"/"TCASE2_BAD_DIR, O_RDONLY, 0);
>> +       if (ret != -1 && errno != EUCLEAN)
>> +               tst_res(TFAIL, "Unexpected lookup result(%d) of %s (%d!=%d)",
>> +                       ret, TCASE2_BAD_DIR, errno, EUCLEAN);
>> +}
>> +
>>  static const struct test_case {
>>         char *name;
>>         int error;
>> @@ -92,6 +122,14 @@ static const struct test_case {
>>                 .error_count = 1,
>>                 .error = EXT4_ERR_ESHUTDOWN,
>>                 .inode = NULL
>> +       },
>> +       {
>> +               .name = "Lookup of inode with invalid mode",
>> +               .prepare_fs = tcase2_prepare_fs,
>> +               .trigger_error = &tcase2_trigger_lookup,
>> +               .error_count = 1,
>> +               .error = 0,
>> +               .inode = &tcase2_bad_ino,
>
> Why is error 0?
> What's the rationale?

Hi Amir,

That is specific to Ext4.  Some ext4 conditions report bogus error codes.  I will
come up with a kernel patch changing it.

-- 
Gabriel Krisman Bertazi
