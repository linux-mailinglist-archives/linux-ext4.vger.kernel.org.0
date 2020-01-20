Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F76142349
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Jan 2020 07:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgATGbK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 20 Jan 2020 01:31:10 -0500
Received: from smtp.h3c.com ([60.191.123.56]:10667 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgATGbJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Jan 2020 01:31:09 -0500
Received: from DAG2EX01-BASE.srv.huawei-3com.com ([10.8.0.64])
        by h3cspam01-ex.h3c.com with ESMTPS id 00K6UV8G061761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jan 2020 14:30:31 +0800 (GMT-8)
        (envelope-from li.kai4@h3c.com)
Received: from DAG2EX07-IDC.srv.huawei-3com.com (10.8.0.70) by
 DAG2EX01-BASE.srv.huawei-3com.com (10.8.0.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jan 2020 14:30:33 +0800
Received: from DAG2EX07-IDC.srv.huawei-3com.com ([fe80::d67:df5a:88dc:99de])
 by DAG2EX07-IDC.srv.huawei-3com.com ([fe80::d67:df5a:88dc:99de%9]) with mapi
 id 15.01.1713.004; Mon, 20 Jan 2020 14:30:33 +0800
From:   Likai <li.kai4@h3c.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "gechangwei@live.cn" <gechangwei@live.cn>,
        Wangyong <wang.yongD@h3c.com>, Wangxibo <wang.xibo@h3c.com>
Subject: Re: [PATCH] jbd2: clear JBD2_ABORT flag before journal_reset to
 update log tail info when load journal
Thread-Topic: [PATCH] jbd2: clear JBD2_ABORT flag before journal_reset to
 update log tail info when load journal
Thread-Index: AQHVyCaRHtk3NUs57kilnbYsclaMFg==
Date:   Mon, 20 Jan 2020 06:30:33 +0000
Message-ID: <453bb3b47a214a429abb5c2e38c494c8@h3c.com>
References: <20200111022542.5008-1-li.kai4@h3c.com>
 <20200114103119.GE6466@quack2.suse.cz> <20200117212657.GF448999@mit.edu>
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
X-MAIL: h3cspam01-ex.h3c.com 00K6UV8G061761
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/1/18 5:27, Theodore Y. Ts'o wrote:
> On Tue, Jan 14, 2020 at 11:31:19AM +0100, Jan Kara wrote:
>> Thanks for the patch! Just some small comments below:
>>
>> On Sat 11-01-20 10:25:42, Kai Li wrote:
>>> Fixes: 85e0c4e89c1b "jbd2: if the journal is aborted then don't allow update of the log tail"
>> This tag should come at the bottom of the changelog (close to your
>> Signed-off-by).
>>
>>> If journal is dirty when mount, it will be replayed but jbd2 sb
>>> log tail cannot be updated to mark a new start because
>>> journal->j_flags has already been set with JBD2_ABORT first
>>> in journal_init_common.
>>> When a new transaction is committed, it will be recorded in block 1
>>> first(journal->j_tail is set to 1 in journal_reset). If emergency
>>> restart again before journal super block is updated unfortunately,
>>> the new recorded trans will not be replayed in the next mount.
>>> It is danerous which may lead to metadata corruption for file system.
>> I'd slightly rephrase the text here so that it is more easily readable and
>> correct some grammar mistakes. Something like:
>>
>> If the journal is dirty when the filesystem is mounted, jbd2 will replay
>> the journal but the journal superblock will not be updated by
>> journal_reset() because JBD2_ABORT flag is still set (it was set in
>> journal_init_common()). This is problematic because when a new transaction
>> is then committed, it will be recorded in block 1 (journal->j_tail was set
>> to 1 in journal_reset()). If unclean shutdown happens again before the
>> journal superblock is updated, the new recorded transaction will not be
>> replayed during the next mount (because of stale sb->s_start and
>> sb->s_sequence values) which can lead to filesystem corruption.
>>
>> Otherwise the patch looks good to me so feel free to add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>>
>> (again this is added to the bottom of the changelog like the 'Fixes' tag or
>> 'Signed-off-by' tag).
> Thanks, applied with a fixed up commit description.
>
> 		       	     	       - Ted
>
Sorry for reply so late due to my business trip recently.  This new
comment is ok and more clear. Thanks.

                                                                       
                                                                       
      - Kai

