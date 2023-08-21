Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0017782105
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Aug 2023 03:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjHUBLJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Aug 2023 21:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjHUBLI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Aug 2023 21:11:08 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5805FA0;
        Sun, 20 Aug 2023 18:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692580268; x=1724116268;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=+oj3MNohxcdTmrcPwpBi7p0R1DJSMKakt+IrmmmfESg=;
  b=mXT+RRjIXN1CxdN5sd8wOiCPITSEpg9kAJqGZlW6v/YuqJgq/zlobQUA
   SmHERTQhOTbLdSpCwv3s0gpjNvGnTHX5GASe/WveoshdrDzdtfABkRGEr
   BiOM3o42ih8kmccSISYSpiBZ39DjBXnMXMGmjW7GiYdlzf/ZcGKRl95Wr
   I=;
X-IronPort-AV: E=Sophos;i="6.01,189,1684800000"; 
   d="scan'208";a="233539961"
Subject: RE: Tasks stuck jbd2 for a long time
Thread-Topic: Tasks stuck jbd2 for a long time
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:11:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id 083BF474DD;
        Mon, 21 Aug 2023 01:11:02 +0000 (UTC)
Received: from EX19D002UWC002.ant.amazon.com (10.13.138.166) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 21 Aug 2023 01:10:58 +0000
Received: from EX19D017UWC004.ant.amazon.com (10.13.139.199) by
 EX19D002UWC002.ant.amazon.com (10.13.138.166) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 21 Aug 2023 01:10:58 +0000
Received: from EX19D017UWC004.ant.amazon.com ([fe80::42ff:f31:f4d8:a730]) by
 EX19D017UWC004.ant.amazon.com ([fe80::42ff:f31:f4d8:a730%6]) with mapi id
 15.02.1118.030; Mon, 21 Aug 2023 01:10:58 +0000
From:   "Lu, Davina" <davinalu@amazon.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     "Bhatnagar, Rishabh" <risbhat@amazon.com>, Jan Kara <jack@suse.cz>,
        "jack@suse.com" <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Park, SeongJae" <sjpark@amazon.com>
Thread-Index: AQHZ0T0hyB578WffgkKt4A53/u6dQa/vMecAgAAmqwCABI99MA==
Date:   Mon, 21 Aug 2023 01:10:58 +0000
Message-ID: <099884899291490caf6c529929339e50@amazon.com>
References: <153d081d-e738-b916-4f72-364b2c1cc36a@amazon.com>
 <20230816022851.GH2247938@mit.edu>
 <17b6398c-859e-4ce7-b751-8688a7288b47@amazon.com>
 <20230816145310.giogco2nbzedgak2@quack3>
 <e716473e-7251-7a81-fa5e-6bf6ba34e49f@amazon.com>
 <20230816215227.jlvmqasfbc73asi4@quack3>
 <7f687907-8982-3be6-54ee-f55aae2f4692@amazon.com>
 <20230817104917.bs46doo6duo7utlm@quack3>
 <f8b8e655-7485-ef11-e151-7118b1531f16@amazon.com>
 <d82df68eb8514951a7f7acc923132796@amazon.com>
 <20230818024144.GD3464136@mit.edu>
In-Reply-To: <20230818024144.GD3464136@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.143.134]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.

On Fri, Aug 18, 2023 at 01:31:35AM +0000, Lu, Davina wrote:
>>
>> Looks like this is a similar issue I saw before with fio test (buffered =
IO with 100 threads), it is also shows "ext4-rsv-conversion" work queue tak=
es lots CPU and make journal update every stuck.

>Given the stack traces, it is very much a different problem.

I see, I thought it maybe the same since it is all related to convert unwri=
tten extents to extents. I didn't look into details of the stuck though.

>> There is a patch and see if this is the same issue? this is not the=20
>> finial patch since there may have some issue from Ted. I will forward=20
>> that email to you in a different loop. I didn't continue on this patch=20
>> that time since we thought is might not be the real case in RDS.

>The patch which you've included is dangerous and can cause file system cor=
ruption.  See my reply at [1], and your corrected patch which addressed my =
concern at [2].  If folks want to try a patch, please use the one at [2], a=
nd not the one you quoted in this thread, since it's missing critically nee=
ded locking.

>[1] https://lore.kernel.org/r/YzTMZ26AfioIbl27@mit.edu
> [2] https://lore.kernel.org/r/53153bdf0cce4675b09bc2ee6483409f@amazon.com


> The reason why we never pursued it is because (a) at one of our weekly
> ext4 video chats, I was informed by Oleg Kiselev that the performance iss=
ue was addressed in a different way, and (b) I'd want to reproduce the issu=
e on a machine under my control so I could understand what was was going on=
 and so we could examine the dynamics of what was happening with and withou=
t the patch.  So I'd would have needed to know how many CPU's what kind of =
storage device (HDD?, SSD?  md-raid?
> etc.) was in use, in addition to the fio recipe.

Thanks for pointed out, I almost forget I did this version 2.=20
How to replicate this issue : CPU is X86_64, 64 cores, 2.50GHZ, MEM is 256G=
B (it is VM though). Attached with one NVME device (no lvm, drbd etc) with =
IOPS 64000 and 16GiB. I can also replicate with 10000 IOPS 1000GiB NVME vol=
ume.

Run fio test:=20
1. Create new files, fio or dd, fio is: /usr/bin/fio --name=3D16kb_rand_wri=
te_only_2048_jobs --directory=3D/rdsdbdata --rw=3Drandwrite --ioengine=3Dsy=
nc --buffered=3D1 --bs=3D16k --max-jobs=3D2048 --numjobs=3D$1 --runtime=3D3=
0 --thread --filesize=3D28800000 --fsync=3D1 --group_reporting --create_onl=
y=3D1 > /dev/null

2. sudo echo 1 > /proc/sys/vm/drop_caches

3. fio --name=3D16kb_rand_write_only_2048_jobs --directory=3D/rdsdbdata --r=
w=3Drandwrite --ioengine=3Dsync --buffered=3D1 --bs=3D16k --max-jobs=3D2048=
 --numjobs=3D2048 --runtime=3D60 --time_based --thread --filesize=3D2880000=
0 --fsync=3D1 --group_reporting
Can see the IOPS drop from 17K to=20
Jobs: 2048 (f=3D2048): [w(2048)] [13.3% done] [0KB/1296KB/0KB /s] [0/81/0 i=
ops] [eta 00m:52s]  <----- IOPS drops to less than < 100

The way to create and mount fs is:
mke2fs -m 1 -t ext4 -b 4096 -L /rdsdbdata /dev/nvme5n1 -J size=3D128
mount -o rw,noatime,nodiratime,data=3Dordered /dev/nvme5n1 /rdsdbdata

Yes, Oleg is correct, there is another way to solve this: large the journal=
 size from 128MB to 2GB. But looks like this is not an typical issue for RD=
S background so we didn't continue much on this.
What I can find is: the journal doesn't have enough space (cannot buffer mu=
ch) so it has to wait all the current transaction completes in code add_tra=
nsaction_credits() below:
if (needed > journal->j_max_transaction_buffers / 2) {  =20
               jbd2_might_wait_for_commit(journal);
               wait_event(journal->j_wait_reserved,
               atomic_read(&journal->j_reserved_credits) + rsv_blocks
                                             <=3D journal->j_max_transactio=
n_buffers / 2);
And the journal locking journal=1B$B"*=1B(Bj_state_lock show stuck at a lon=
g time. =20
But not sure why the "ext4-rsv-conversion" also plays a role here, this sho=
uld be triggered by ext4_writepages(). But what I can see is when the journ=
al lock stuck, each core's utility is almost 100% and the ext4-rsv-conversi=
on shows at that time.=20


> Finally, I'm a bit nervous about setting the internal __WQ_ORDERED flag w=
ith max_active > 1.  What was that all about, anyway?

Yes, you are correct. I didn't use "__WQ_ORDERED" carefully, it better not =
use with max_active > 1 . My purpose was try to guarantee the work queue ca=
n be sequentially implemented on each core.

Thanks
Davina Lu
