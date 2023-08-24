Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589FD78666E
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 05:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjHXDzb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Aug 2023 23:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbjHXDzA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Aug 2023 23:55:00 -0400
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF21FD9;
        Wed, 23 Aug 2023 20:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692849226; x=1724385226;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=L6yr3F5rphRUMJexgvXXRSdT/PI8QQQWbd95l5gki+Q=;
  b=L1W8/aEr2XKKJuOTUp1nbei8B0NFM73DiT9oy4bqMgPaI0Q+l1OuOvyz
   AihpR1m6NO/iZ3MfzYes70GUYClCgZdYJTD6J3jccZBXO22h2aQMvUOfq
   ZZdW4eTPqR3dKm3kbyw6I99YwgBQW4oaZ4+fXg1HgcTm/h4eJdjLqEDOX
   o=;
X-IronPort-AV: E=Sophos;i="6.01,195,1684800000"; 
   d="scan'208";a="600451668"
Subject: RE: Tasks stuck jbd2 for a long time
Thread-Topic: Tasks stuck jbd2 for a long time
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 03:52:08 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id F1C4D169A84;
        Thu, 24 Aug 2023 03:52:05 +0000 (UTC)
Received: from EX19D002UWC002.ant.amazon.com (10.13.138.166) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 24 Aug 2023 03:52:04 +0000
Received: from EX19D017UWC003.ant.amazon.com (10.13.139.227) by
 EX19D002UWC002.ant.amazon.com (10.13.138.166) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 24 Aug 2023 03:52:04 +0000
Received: from EX19D017UWC003.ant.amazon.com ([fe80::f6d2:d06:a0ec:a97e]) by
 EX19D017UWC003.ant.amazon.com ([fe80::f6d2:d06:a0ec:a97e%6]) with mapi id
 15.02.1118.037; Thu, 24 Aug 2023 03:52:04 +0000
From:   "Lu, Davina" <davinalu@amazon.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     "Bhatnagar, Rishabh" <risbhat@amazon.com>, Jan Kara <jack@suse.cz>,
        "jack@suse.com" <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Park, SeongJae" <sjpark@amazon.com>
Thread-Index: AQHZ0T0hyB578WffgkKt4A53/u6dQa/vMecAgAAmqwCABI99MIABMumAgAO8f9A=
Date:   Thu, 24 Aug 2023 03:52:04 +0000
Message-ID: <70943eab978e4482b9fa4f68119bc8ea@amazon.com>
References: <17b6398c-859e-4ce7-b751-8688a7288b47@amazon.com>
 <20230816145310.giogco2nbzedgak2@quack3>
 <e716473e-7251-7a81-fa5e-6bf6ba34e49f@amazon.com>
 <20230816215227.jlvmqasfbc73asi4@quack3>
 <7f687907-8982-3be6-54ee-f55aae2f4692@amazon.com>
 <20230817104917.bs46doo6duo7utlm@quack3>
 <f8b8e655-7485-ef11-e151-7118b1531f16@amazon.com>
 <d82df68eb8514951a7f7acc923132796@amazon.com>
 <20230818024144.GD3464136@mit.edu>
 <099884899291490caf6c529929339e50@amazon.com> <ZOOvOT4dL1SCHQDz@mit.edu>
In-Reply-To: <ZOOvOT4dL1SCHQDz@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.143.137]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.

> Thanks for the details.  This is something that am interested in trying t=
o potentially to merge, since for a sufficiently coversion-heavy workload (=
assuming the conversion is happening=20
> across multiple inodes, and not just a huge number of random writes into =
a single fallocated file), limiting the number of kernel threads to one CPU=
 isn't always going to be the right thing. =20
>The reason why we had done this way was because at the time, the only choi=
ces that we had was between a single kernel thread, or spawning a kernel th=
read for every single CPU --=20
>which for a very high-core-count system, consumed a huge amount of system =
resources.  This is no longer the case with the new Concurrency Managed Wor=
kqueue (cmwq), but we never=20
>did the experiment to make sure cmwq didn't have surprising gotchas.

Thank you for the detailed explanation.=20


> I won't have time to look at this before the next merge window, but what =
I'm hoping to look at is your patch at [2], with two changes:
> a)  Drop the _WQ_ORDERED flag, since it is an internal flag.
> b) Just pass in 0 for max_active instead of "num_active_cpus() > 1 ?
 > num_active_cpus() : 1", for two reasons.  Num_active_cpus() doesn't
 >  take into account CPU hotplugs (for example, if you have a
  > dynmically adjustable VM shape where the number of active CPU's
  > might change over time).  Is there a reason why we need to set that
  > limit?

> Do you see any potential problem with these changes?

Sorry for the late response, after the internal discussion, I can continue =
on this patch. These 2 points are easy to change, I will also do some xfste=
st for EXT4 and run BMS on RDS environment to do a quick verify.  We can ch=
ange num_active_cpus() to 0. Why adding that: just because during fio test,=
 the max active number goes to ~50 we won't see this issue. But this is not=
 necessary. I will see what's Oleg's opinion later offline.

Thanks,
Davina
                                            =20
