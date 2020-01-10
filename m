Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8913659A
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2020 03:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgAJC7r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 9 Jan 2020 21:59:47 -0500
Received: from smtp.h3c.com ([60.191.123.56]:53323 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbgAJC7r (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 Jan 2020 21:59:47 -0500
X-Greylist: delayed 3951 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 21:59:45 EST
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 00A1rt4c094626
        for <linux-ext4@vger.kernel.org>; Fri, 10 Jan 2020 09:53:55 +0800 (GMT-8)
        (envelope-from li.kai4@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 00A1rObj093422
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jan 2020 09:53:24 +0800 (GMT-8)
        (envelope-from li.kai4@h3c.com)
Received: from DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 10 Jan 2020 09:53:25 +0800
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([fe80::d67:df5a:88dc:99de])
 by DAG2EX07-IDC.srv.huawei-3com.com ([fe80::d67:df5a:88dc:99de%9]) with mapi
 id 15.01.1713.004; Fri, 10 Jan 2020 09:53:25 +0800
From:   Likai <li.kai4@h3c.com>
To:     Jan Kara <jack@suse.cz>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "liu.song11@zte.com.cn" <liu.song11@zte.com.cn>,
        "xiaoguang.wang@linux.alibaba.com" <xiaoguang.wang@linux.alibaba.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jbd2: update log tail info after journal recovery
Thread-Topic: [PATCH] jbd2: update log tail info after journal recovery
Thread-Index: AdWqTCVEilKNyzPgRxaPfivR4ixD6A==
Date:   Fri, 10 Jan 2020 01:53:24 +0000
Message-ID: <f21cc4e3be6848f49ba0c1e80a067b62@h3c.com>
References: <1f1a15b7d09c4e7896274ca352e7b1e1@h3c.com>
 <20200109115141.GB22232@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.72]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 00A1rObj093422
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/1/9 19:52, Jan Kara wrote:
> Hello!
>
> On Wed 04-12-19 03:47:52, Likai wrote:
>> Hi,  I meet a new problem that file may be lost althougth it is recorded in the jbd2 journal
>> with ocfs2 file system in one node scene(like ext4). Can you give some suggestions for this problem
>> and modification patch?
>>
>> Test method:
>> 1. touch some files after mount
>> 2. emergency restart
>> 3. mount again, then log tail will not be updated
>> 4. touch a new file and confirm that it is recorded in the journal area
>> 5.emergency restart again
>> 6. the new log will not be replayed becasuse its seq and blknum are not consistent with journal super block although it is an unbroken commit.
>>
>> After analizing the codes, its cause is as follow:
>>
>> Journal->j_flags will be set JBD2_ABORT in journal_init_common first when mount.
>> if this flag is not cleared before journal_reset in journal recovery
>> scene, super log tail cannot be updated, then the new commit trans in
>> the journal may not be replayed because new commit recover old trans area.
>>
>> logdump:
>> Block 0: Journal Superblock
>> Seq: 0   Type: 4 (JBD2_SUPERBLOCK_V2)
>> Blocksize: 4096   Total Blocks: 32768   First Block: 1
>> First Commit ID: 13   Start Log Blknum: 1
>> Error: 0
>> Feature Compat: 0
>> Feature Incompat: 2 block64
>> Feature RO compat: 0
>> Journal UUID: 4ED3822C54294467A4F8E87D2BA4BC36
>> FS Share Cnt: 1   Dynamic Superblk Blknum: 0
>> Per Txn Block Limit    Journal: 0    Data: 0
>>
>> Block 1: Journal Commit Block
>> Seq: 14   Type: 2 (JBD2_COMMIT_BLOCK)
>>
>> Block 2: Journal Descriptor
>> Seq: 15   Type: 1 (JBD2_DESCRIPTOR_BLOCK)
>> No. Blocknum        Flags
>> 0. 587             none
>> UUID: 00000000000000000000000000000000
>> 1. 8257792         JBD2_FLAG_SAME_UUID
>> 2. 619             JBD2_FLAG_SAME_UUID
>> 3. 24772864        JBD2_FLAG_SAME_UUID
>> 4. 8257802         JBD2_FLAG_SAME_UUID
>> 5. 513             JBD2_FLAG_SAME_UUID JBD2_FLAG_LAST_TAG
>> ...
>> Block 7: Inode
>> Inode: 8257802   Mode: 0640   Generation: 57157641 (0x3682809)
>> FS Generation: 2839773110 (0xa9437fb6)
>> CRC32: 00000000   ECC: 0000
>> Type: Regular   Attr: 0x0   Flags: Valid
>> Dynamic Features: (0x1) InlineData
>> User: 0 (root)   Group: 0 (root)   Size: 7
>> Links: 1   Clusters: 0
>> ctime: 0x5de5d870 0x11104c61 -- Tue Dec  3 11:37:20.286280801 2019
>> atime: 0x5de5d870 0x113181a1 -- Tue Dec  3 11:37:20.288457121 2019
>> mtime: 0x5de5d870 0x11104c61 -- Tue Dec  3 11:37:20.286280801 2019
>> dtime: 0x0 -- Thu Jan  1 08:00:00 1970
>> ...
>> Block 9: Journal Commit Block
>> Seq: 15   Type: 2 (JBD2_COMMIT_BLOCK)
>>
>> syslog:
>> Dec  3 11:41:05 cvknode02 kernel: [ 2265.648622] ocfs2: File system on device (252,1) was not unmounted cleanly, recovering it.
>> Dec  3 11:41:05 cvknode02 kernel: [ 2265.649695] fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 0
>> Dec  3 11:41:05 cvknode02 kernel: [ 2265.650407] fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 1
>> Dec  3 11:41:05 cvknode02 kernel: [ 2265.650409] fs/jbd2/recovery.c:(do_one_pass, 449): Starting recovery pass 2
>> Dec  3 11:41:05 cvknode02 kernel: [ 2265.650410] fs/jbd2/recovery.c:(jbd2_journal_recover, 278): JBD2: recovery, exit status 0, recovered transactions 13 to 13
>>
>> Seq 15 is an unbroken commit, but it cannot be replayed, inode 8257802
>> is a new file and it will be lost.
>>
>>
>> To fix this problem, I clear JBD2_ABORT flag before journal_reset so that jbd2_journal_update_sb_log_tail
>> can update log tail later. After test, it is ok now.
> Thanks for the report and the patch! I agree with the analysis and the fix.
> This seems to be a bug introduced by commit 85e0c4e89c1b8 "jbd2: if the
> journal is aborted then don't allow update of the log tail". So can you
> please create a patch with proper changelog, your signed-off-by, unmangled
> white-spaces, and also
>
> Fixes: 85e0c4e89c1b "jbd2: if the journal is aborted then don't allow update of the log tail"
>
> tag and resubmit it? Thank you!
>
> 								Honza
Thanks for you comments, I will update and resubmit it again.

Kai
>> ---
>> fs/jbd2/journal.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index 593f3e31fb21..6fc9fd41830e 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -1685,6 +1685,11 @@ int jbd2_journal_load(journal_t *journal)
>>                        journal->j_devname);
>>                 return -EFSCORRUPTED;
>>        }
>> +       /*
>> +       * clear JBD2_ABORT flag which was initialized in journal_init_common
>> +       * here to update log tail information with the newest seq.
>> +       */
>> +       journal->j_flags &= ~JBD2_ABORT;
>>         /* OK, we've finished with the dynamic journal bits:
>>         * reinitialise the dynamic contents of the superblock in memory
>> @@ -1692,7 +1697,6 @@ int jbd2_journal_load(journal_t *journal)
>>        if (journal_reset(journal))
>>                 goto recovery_error;
>> -        journal->j_flags &= ~JBD2_ABORT;
>>        journal->j_flags |= JBD2_LOADED;
>>        return 0;
>> -------------------------------------------------------------------------------------------------------------------------------------
>> ?????????????????????????????????
>> ????????????????????????????????????????
>> ????????????????????????????????????????
>> ???
>> This e-mail and its attachments contain confidential information from New H3C, which is
>> intended only for the person or entity whose address is listed above. Any use of the
>> information contained herein in any way (including, but not limited to, total or partial
>> disclosure, reproduction, or dissemination) by persons other than the intended
>> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
>> by phone or email immediately and delete it!


