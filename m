Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FFB3DFACB
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 06:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhHDEy2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 00:54:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59420 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhHDEy0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 00:54:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B56E21F43565
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com
Subject: Re: [PATCH 3/7] syscalls/fanotify20: Validate incoming FID in
 FAN_FS_ERROR
Organization: Collabora
References: <20210802214645.2633028-1-krisman@collabora.com>
        <20210802214645.2633028-4-krisman@collabora.com>
        <CAOQ4uxjMfJM4FM4tWJWgjbK4a2K1hNJdEBRvwQTh9+5su2N0Tw@mail.gmail.com>
Date:   Wed, 04 Aug 2021 00:54:09 -0400
In-Reply-To: <CAOQ4uxjMfJM4FM4tWJWgjbK4a2K1hNJdEBRvwQTh9+5su2N0Tw@mail.gmail.com>
        (Amir Goldstein's message of "Tue, 3 Aug 2021 11:56:31 +0300")
Message-ID: <87fsvphksu.fsf@collabora.com>
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
>> Verify the FID provided in the event.  If the testcase has a null inode,
>> this is assumed to be a superblock error (i.e. null FH).
>>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> ---
>>  .../kernel/syscalls/fanotify/fanotify20.c     | 51 +++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
>> index fd5cfb8744f1..d8d788ae685f 100644
>> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
>> @@ -40,6 +40,14 @@
>>
>>  #define FAN_EVENT_INFO_TYPE_ERROR      4
>>
>> +#ifndef FILEID_INVALID
>> +#define        FILEID_INVALID          0xff
>> +#endif
>> +
>> +#ifndef FILEID_INO32_GEN
>> +#define FILEID_INO32_GEN       1
>> +#endif
>> +
>>  struct fanotify_event_info_error {
>>         struct fanotify_event_info_header hdr;
>>         __s32 error;
>> @@ -57,6 +65,9 @@ static const struct test_case {
>>         char *name;
>>         int error;
>>         unsigned int error_count;
>> +
>> +       /* inode can be null for superblock errors */
>> +       unsigned int *inode;
>
> Any reason not to use fanotify_fid_t * like fanotify16.c?

No reason other than I didn't notice they existed. Sorry. I will get
this fixed.

-- 
Gabriel Krisman Bertazi
