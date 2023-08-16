Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A990B77E8C7
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345546AbjHPSdg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 14:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345567AbjHPSdK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 14:33:10 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7B72136;
        Wed, 16 Aug 2023 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692210778; x=1723746778;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=DWVG/Gj+SaC5/yNAxZXP/Jv3cKCKZjBE62SFwQ3nnBA=;
  b=upgVILbK4XMoi5fhfCl4kJOOAbi3pKlOJv4D4Z/FkgtAjLN8v+coQ4bC
   Xi/sQAR3nQnmHAcpg6B8dgvixldTZz4Hh+WjdIVoEQNvxKcm/3vwewLmf
   Mp+VtmJhwsNdM/RV22ypbdXZN0gsBPTI7qL6zDD1jS9KS36jQtYD0nt5/
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,177,1684800000"; 
   d="scan'208";a="22926156"
Subject: Re: Tasks stuck jbd2 for a long time
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 18:32:57 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com (Postfix) with ESMTPS id 9BEB940DB5;
        Wed, 16 Aug 2023 18:32:57 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 16 Aug 2023 18:32:49 +0000
Received: from [10.94.35.220] (10.94.35.220) by EX19D002UWC004.ant.amazon.com
 (10.13.138.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 16 Aug
 2023 18:32:48 +0000
Message-ID: <e716473e-7251-7a81-fa5e-6bf6ba34e49f@amazon.com>
Date:   Wed, 16 Aug 2023 11:32:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     Theodore Ts'o <tytso@mit.edu>, <jack@suse.com>,
        <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Park, SeongJae" <sjpark@amazon.com>
References: <153d081d-e738-b916-4f72-364b2c1cc36a@amazon.com>
 <20230816022851.GH2247938@mit.edu>
 <17b6398c-859e-4ce7-b751-8688a7288b47@amazon.com>
 <20230816145310.giogco2nbzedgak2@quack3>
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
In-Reply-To: <20230816145310.giogco2nbzedgak2@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.94.35.220]
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 8/16/23 7:53 AM, Jan Kara wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Tue 15-08-23 20:57:14, Bhatnagar, Rishabh wrote:
>> On 8/15/23 7:28 PM, Theodore Ts'o wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> It would be helpful if you can translate address in the stack trace to
>>> line numbers.  See [1] and the script in
>>> ./scripts/decode_stacktrace.sh in the kernel sources.  (It is
>>> referenced in the web page at [1].)
>>>
>>> [1] https://docs.kernel.org/admin-guide/bug-hunting.html
>>>
>>> Of course, in order to interpret the line numbers, we'll need a
>>> pointer to the git repo of your kernel sources and the git commit ID
>>> you were using that presumably corresponds to 5.10.184-175.731.amzn2.x86_64.
>>>
>>> The stack trace for which I am particularly interested is the one for
>>> the jbd2/md0-8 task, e.g.:
>> Thanks for checking Ted.
>>
>> We don't have fast_commit feature enabled. So it should correspond to this
>> line:
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/jbd2/commit.c?h=linux-5.10.y#n496
>>
>>>>         Not tainted 5.10.184-175.731.amzn2.x86_64 #1
>>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>> task:jbd2/md0-8      state:D stack:    0 pid: 8068 ppid:     2
>>>> flags:0x00004080
>>>> Call Trace:
>>>> __schedule+0x1f9/0x660
>>>>    schedule+0x46/0xb0
>>>>    jbd2_journal_commit_transaction+0x35d/0x1880 [jbd2]  <--------- line #?
>>>>    ? update_load_avg+0x7a/0x5d0
>>>>    ? add_wait_queue_exclusive+0x70/0x70
>>>>    ? lock_timer_base+0x61/0x80
>>>>    ? kjournald2+0xcf/0x360 [jbd2]
>>>>    kjournald2+0xcf/0x360 [jbd2]
>>> Most of the other stack traces you refenced are tasks that are waiting
>>> for the transaction commit to complete so they can proceed with some
>>> file system operation.  The stack traces which have
>>> start_this_handle() in them are examples of this going on.  Stack
>>> traces of tasks that do *not* have start_this_handle() would be
>>> specially interesting.
>> I see all other stacks apart from kjournald have "start_this_handle".
> That would be strange. Can you post full output of "echo w
>> /proc/sysrq-trigger" to dmesg, ideally passed through scripts/faddr2line as
> Ted suggests. Thanks!

Sure i'll try to collect that. The system freezes when such a situation 
happens and i'm not able
to collect much information. I'll try to crash the kernel and collect 
kdump and see if i can get that info.

Can low available memory be a reason for a thread to not be able to 
close the transaction handle for a long time?
Maybe some writeback thread starts the handle but is not able to 
complete writeback?

>
>                                                                  Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
