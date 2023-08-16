Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8503977D94F
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbjHPD52 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241684AbjHPD5U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:57:20 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AD81BF7;
        Tue, 15 Aug 2023 20:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692158240; x=1723694240;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=CZNERuYwnW/E00fFA9MDoPeobRHtTZWFyNG+bbD2IXU=;
  b=DcWyiPjwmgMNKOhD1hheflo5MRzzBq+BRohlZNYpcOxkNT6oSMQRU/MJ
   L9IwSbcXnmxEuAQcoBfswtdveHpfPqF1FhJ6+8pHFf2PFFim4IlD5cW6s
   usYLAqhL2dts23iihvBIzePGlGJRNZ6jFkelhtBmNxAGDXO08jpzjrLPr
   8=;
X-IronPort-AV: E=Sophos;i="6.01,175,1684800000"; 
   d="scan'208";a="233021073"
Subject: Re: Tasks stuck jbd2 for a long time
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 03:57:19 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id 10C19164E7A;
        Wed, 16 Aug 2023 03:57:16 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 16 Aug 2023 03:57:16 +0000
Received: from [192.168.196.32] (10.106.101.51) by
 EX19D002UWC004.ant.amazon.com (10.13.138.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 16 Aug 2023 03:57:15 +0000
Message-ID: <17b6398c-859e-4ce7-b751-8688a7288b47@amazon.com>
Date:   Tue, 15 Aug 2023 20:57:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <jack@suse.com>, <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Park, SeongJae" <sjpark@amazon.com>
References: <153d081d-e738-b916-4f72-364b2c1cc36a@amazon.com>
 <20230816022851.GH2247938@mit.edu>
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
In-Reply-To: <20230816022851.GH2247938@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.101.51]
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 8/15/23 7:28 PM, Theodore Ts'o wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> It would be helpful if you can translate address in the stack trace to
> line numbers.  See [1] and the script in
> ./scripts/decode_stacktrace.sh in the kernel sources.  (It is
> referenced in the web page at [1].)
>
> [1] https://docs.kernel.org/admin-guide/bug-hunting.html
>
> Of course, in order to interpret the line numbers, we'll need a
> pointer to the git repo of your kernel sources and the git commit ID
> you were using that presumably corresponds to 5.10.184-175.731.amzn2.x86_64.
>
> The stack trace for which I am particularly interested is the one for
> the jbd2/md0-8 task, e.g.:

Thanks for checking Ted.

We don't have fast_commit feature enabled. So it should correspond to 
this line:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/jbd2/commit.c?h=linux-5.10.y#n496

>
>>        Not tainted 5.10.184-175.731.amzn2.x86_64 #1
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:jbd2/md0-8      state:D stack:    0 pid: 8068 ppid:     2
>> flags:0x00004080
>> Call Trace:
>> __schedule+0x1f9/0x660
>>   schedule+0x46/0xb0
>>   jbd2_journal_commit_transaction+0x35d/0x1880 [jbd2]  <--------- line #?
>>   ? update_load_avg+0x7a/0x5d0
>>   ? add_wait_queue_exclusive+0x70/0x70
>>   ? lock_timer_base+0x61/0x80
>>   ? kjournald2+0xcf/0x360 [jbd2]
>>   kjournald2+0xcf/0x360 [jbd2]
> Most of the other stack traces you refenced are tasks that are waiting
> for the transaction commit to complete so they can proceed with some
> file system operation.  The stack traces which have
> start_this_handle() in them are examples of this going on.  Stack
> traces of tasks that do *not* have start_this_handle() would be
> specially interesting.
I see all other stacks apart from kjournald have "start_this_handle".
>
> The question is why is the commit thread blocking, and on what.  It
> could be blocking on some I/O; or some memory allocation; or waiting
> for some process with an open transation handle to close it.  The line
> number of the jbd2 thread in fs/jbd2/commit.c will give us at least a
> partial answer to that question.  Of course, then we'll need to answer
> the next question --- why is the I/O blocked?  Or why is the memory
> allocation not completing?   etc.

To me it looks like its waiting on some process to close the transaction 
handle.
One point to note here is we pretty run low on memory in this usecase. 
The download starts
eating memory really fast.

>
> I could make some speculation (such as perhaps some memory allocation
> is being made without GFP_NOFS, and this is causing a deadlock between
> the memory allocation code which is trying to initiate writeback, but
> that is blocked on the transaction commit completing), but without
> understanding what the jbd2_journal_commit_transaction() is blocking
> at  jbd2_journal_commit_transaction+0x35d/0x1880, that would be justa
> guess - pure speculation --- without knowing more.
>
> Cheers,
>
>                                                  - Ted
