Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5285A2ADB00
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Nov 2020 16:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbgKJP5q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Nov 2020 10:57:46 -0500
Received: from mail-eopbgr760077.outbound.protection.outlook.com ([40.107.76.77]:47585
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731125AbgKJP5q (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Nov 2020 10:57:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8rHybqdNztR+jZ8h1QRKaP4aS+GHSrpL+NxYdcsFaoec2aJt8uotiUNpP7ObhJIjERNjktmv+yC+OqsRM7HewihgaUq19QoqsWJ8KthLf+6+VwruD0solMYZcxqfecp6jMOOjljf6Fvo5e7V6B3xbHgwvD/6cjbwKb2E95j6i2kMIfyruvbuImZdDrDZnSaHuyhz4+gP1wVeYLcsjl9cklWM2cPbXDviYZu+CvH7XeyhwyzuHrtCesS61VSkDeJX0bDFoqa0NZZ9np8vPEXin4IzOE0NdpF7OeqvTwlelq9h1h+tKwWxJVT/mqCvxM0eWYPpKIU5n3pOl+95wZAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7blexKcXLvnvkugqBfLY5A1xEOLMRbfHwGiH7X9CimM=;
 b=lLiSklIGsnRU7uqeBZNVlCX123d0j3cUdh7UslIYwzHkREc1P9h/V0aiePol82E6Pv4sMFMTtuy0GAlEcAoZiDAMECdXxDTjRGKAYJY7TjdeuS+wFV9I5xlLD6z3L37dTvW/Oryv5x5Dx/O22BmUh4+sin2mcRST9I3Ybir5GOwkvhoxmcVJBjPAmN4KOSQWPCx9t0HSfldNhbSngyLDIPhNlVZr1KO/rA/TYPbaQirEq4an2ethvX/msuXVPLuEZh4P0uL4gtezshfKAP50ZbA02+uEaDr05Jv1yWnoOZ58vuRJp2mtqOmHZ3y8bD3h2x9w7hzuJ50DgiKXSenp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7blexKcXLvnvkugqBfLY5A1xEOLMRbfHwGiH7X9CimM=;
 b=Bo2sle+4v1SocDFLurOsA3MCmqxdL00d0yH4/yRfuvYEKYYaEe0kTyhHIbIgi4iMhJFvi7gugK6fItwfEPbDjFJ2XgJs1e9sVdBzTskK+tONtkRA3D3zdgGiREKx2hMuJ2h+ZSpJS780w2ElkDPF+a91TwiRe7G7EVgCld0FGvo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB2885.namprd11.prod.outlook.com (2603:10b6:a03:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Tue, 10 Nov
 2020 15:57:42 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 15:57:42 +0000
Subject: Re: looking for assistance with jbd2 (and other processes) hung
 trying to write to disk
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
References: <17a059de-6e95-ef97-6e0a-5e52af1b9a04@windriver.com>
 <20201110114202.GF20780@quack2.suse.cz>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <7fa5a43f-bdd6-9cf1-172a-b2af47239e96@windriver.com>
Date:   Tue, 10 Nov 2020 09:57:39 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201110114202.GF20780@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.64.76.237]
X-ClientProxiedBy: BYAPR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:a03:100::36) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.76.237) by BYAPR08CA0023.namprd08.prod.outlook.com (2603:10b6:a03:100::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Tue, 10 Nov 2020 15:57:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd0c7435-648b-49d9-9fd3-08d885915b6a
X-MS-TrafficTypeDiagnostic: BYAPR11MB2885:
X-Microsoft-Antispam-PRVS: <BYAPR11MB28853B839453B840F63CA1D1F6E90@BYAPR11MB2885.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpHMyDC7OQGW9NJPFHwn+q5KU1RjQr8OSz7FLj5GrgeF7jddWs7P6sYFlMLAqo7GBX8DwfjxPJkXIQuwx2Wgor+iYgxd2mD0yha7WgTIheO004y27A3iQXu0V6HJFNj/CjCzgEf6gzz/lp3mNqo6zgJQ4fbg+RJ3HG/92DkdLxUsogge2Koxk2aUBXn0VQeEYPBOt0PvdIB9c2OfIEx7Y/ExkvnELtTZqcHuAXuKlWnvVTSVpvS7uynkTLBl6NIpwczMbo7w+aKX7VvPjtioYVYFGaIvTFpGhAbdbUGWlgZmhiIIvT2GOWp1zTuT6NS2C0pEe5/toGZNs/AVESz0iqKENPh6xlmPmW3oUYkPGF4Df50WuqN2vA3agqGykUuPuvyNowMgqt6Ru7eJd20AZyuJxnQTk1l4sKZHWUv8S2AAnE/udiLu0F8VUVGsdiUIbQiF5XWyT7F/QtH+ifCSSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(136003)(396003)(376002)(66946007)(5660300002)(86362001)(6916009)(44832011)(186003)(4326008)(31696002)(31686004)(956004)(66556008)(16576012)(16526019)(316002)(478600001)(36756003)(2616005)(52116002)(66476007)(2906002)(8936002)(966005)(6486002)(53546011)(26005)(83380400001)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7t28nrsIVWhWxDzb+8i7bakxu0PU3ViK+20sxuP/clEBk+IDGl/7q2qlMO62NfUHO8th5/hWiAu1pnVXpt470LTQvgShZ+9yZJAOVlI+o0xrJTfojpTKBiq9wwXhKD9YcWXh1Hpx2n23mItrg9XMNKqUgQOsEsmIHoYyNzMdHEDNMaHAuUpZqjem448Z0AbKaE6425pJAiUPzuQrwat9GuWd8ygVD9sT3WW6jk6tWUXqHOqaxtWoWu0b184JQX+mht7n/aKyozl5/QR+vBCa1MlUfv5hcBxc80JWCXvQbCrPJ3dcp/pA4n1ZK/lCSX8AKR8YMv+Ge7n+Wz53tnp1wpXblHmnCQPR67K+w0EJM+V46sQuwVBk9v9t3ygqoojI7ByEwCTFPtGKlJ+XTOTDJP28ETajsnqDdOri20D4yM7ZbrGewsU9ODbOjdEkrtk7KuhmuewykwW9dp/8pX0F3K2hYRQAYtDg8nV+UJlXfTPYTKJYV8YYsLBhKILe8ZMZe0JxlhbVLMeigTLKMu/ggNgx2LOhEgH04HC5Jd3iMGRvpIPrfDd/Yg9i3pxgMP25+/8e5FDxAJ3185kCK0Ih9PlnBYODpd9RtY50szW4srAuT1FaQ7uHaYRVz0GyVoFypfjgeFjHI59ntSTlj84cZO/u4yb+k7Q995HUZCr/ijA8hXuG12DWABEUX3KVD9Qp/YWSgLeXShlFcn60sHYn1XeLjwjkHopYu3vwewua+KhKPCdNZTo4WEgMmIpZKhChBENmgdrJizU4rdpBAZwQy0S2Xut5VKoW3ySAbFD8Yuy/JhdVZCt2jtf9MCTyP16yILDnvG/sHCtx1Tdioluc3yrtk5CQgwkLuwkOoAIz2niKfc967KQfRYaFYXyOSWaYYcs+YFUxtUUaDGOOkSb1UQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0c7435-648b-49d9-9fd3-08d885915b6a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 15:57:42.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFJPozCrjd7lM9NriaTMUkIFMq/JRp+x8kHbttYQzGKTMaKZ6uiG2WfUktgPpjzSr+zRf3kBIk/VRwg2UPHpRNeDRdgam0DnKOARLDVpXuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2885
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11/10/2020 5:42 AM, Jan Kara wrote:
> On Mon 09-11-20 15:11:58, Chris Friesen wrote:

>> Can anyone give some suggestions on how to track down what's causing the
>> delay here?  I suspect there's a race condition somewhere similar to what
>> happened with https://access.redhat.com/solutions/3226391, although that one
>> was specific to device-mapper and the root filesystem here is directly on
>> the nvme device.
> 
> Sadly I don't have access to RH portal to be able to check what that hang
> was about...

They had exactly the same stack trace (different addresses) with 
"jbd2/dm-16-8" trying to commit a journal transaction.  In their case it 
was apparently due to two problems, "the RAID1 code leaking the r1bio", 
and "dm-raid not handling a needed retry scenario".  They fixed it by 
backporting upstream commits.  The kernel we're running should have 
those fixes, and in our case we're operating directly on an nvme device.

>> crash> ps -m 930
>> [0 00:09:11.694] [UN]  PID: 930    TASK: ffffa14b5f9032c0  CPU: 1 COMMAND:
>> "jbd2/nvme2n1p4-"
>>
> 
> Are the tasks below the only ones hanging in D state (UN state in crash)?
> Because I can see processes are waiting for the locked buffer but it is
> unclear who is holding the buffer lock...

No, there are quite a few of them.  I've included them below.  I agree, 
it's not clear who's holding the lock.  Is there a way to find that out?

Just to be sure, I'm looking for whoever has the BH_Lock bit set on the 
buffer_head "b_state" field, right?  I don't see any ownership field the 
way we have for mutexes.  Is there some way to find out who would have 
locked the buffer?

Do you think it would help at all to enable CONFIG_JBD_DEBUG?

Processes in "UN" state in crashdump:

crash> ps|grep UN
       1      0   1  ffffa14b687d8000  UN   0.0  193616   6620  systemd
     930      2   1  ffffa14b5f9032c0  UN   0.0       0      0 
[jbd2/nvme2n1p4-]
    1489      2   1  ffffa14b641f0000  UN   0.0       0      0 
[jbd2/dm-0-8]
    1494      2   1  ffffa14b641f2610  UN   0.0       0      0 
[jbd2/dm-11-8]
    1523      2   1  ffffa14b64182610  UN   0.0       0      0 
[jbd2/dm-1-8]
    1912      1   1  ffffa14b62dc2610  UN   0.0  117868  17568  syslog-ng
   86293      1   1  ffffa14ae4650cb0  UN   0.1 4618100 116664  containerd
   86314      1   1  ffffa14ae2639960  UN   0.1 4618100 116664  containerd
   88019      1   1  ffffa14ae26ad8d0  UN   0.2  651196 210260  safe_timer
   90539      1   1  ffffa13caca3bf70  UN   0.0   25868   2140  fsmond
   94006  93595   1  ffffa14ae31fe580  UN   0.1 13843140 113604  etcd
   95061  93508   1  ffffa14a913e8cb0  UN   0.1  721888 114652  log
   96367      1   1  ffffa14af53f9960  UN   0.0  119404  19084  python
   121292      1   1  ffffa14ae18932c0  UN   0.1 4618100 116664  containerd
   122042      1   1  ffffa14a950a6580  UN   0.0  111680   9496 
containerd-shim
   126119  122328  23  ffffa14b3d76a610  UN   0.0       0      0  com.xcg
   126171  122328  47  ffffa14a91571960  UN   0.0       0      0  com.xcg
   126173  122328  23  ffffa14a91573f70  UN   0.0       0      0  com.xcg
   126177  122328  23  ffffa14a91888000  UN   0.0       0      0  com.xcg
   128049  124763  47  ffffa14a964e6580  UN   0.1 1817292  80388  confd
   136938  136924   1  ffffa14b5bb7d8d0  UN   0.0  146256  25672  coredns
   136972  136924   1  ffffa14a9aae2610  UN   0.0  146256  25672  coredns
   136978  136924   1  ffffa14ae2238000  UN   0.0  146256  25672  coredns
   143026  142739   1  ffffa14b035e0000  UN   0.0       0      0  cainjector
   166456  165537  44  ffffa14af3cb8000  UN   0.0  325468  10736  nronmd.xcg
   166712  165537  44  ffffa149a2fecc20  UN   0.0  200116   3728  vpms.xcg
   166725  165537  44  ffffa14962fb6580  UN   0.1 2108336  58176  vrlcb.xcg
   166860  165537  45  ffffa14afd22bf70  UN   0.0  848320  12180  gcci.xcg
   166882  165537  45  ffffa14aff3c58d0  UN   0.0  693256  11624  ndc.xcg
   167556  165537  44  ffffa14929a6cc20  UN   0.0  119604   2612  gcdm.xcg
   170732  122328  23  ffffa1492987bf70  UN   0.0  616660   4348  com.xcg
   170741  122328  46  ffffa1492987cc20  UN   0.0       0      0  com.xcg
   170745  122328  23  ffffa1492987e580  UN   0.0       0      0  com.xcg
   170750  122328  23  ffffa14924d4f230  UN   0.0       0      0  com.xcg
   170774  122328  23  ffffa14924d4bf70  UN   0.0       0      0  com.xcg
   189870  187717  46  ffffa14873591960  UN   0.1  881516  83840  filebeat
   332649  136924   1  ffffa147efd49960  UN   0.0  146256  25672  coredns
   1036113  3779184  23  ffffa13c9317bf70  UN   0.9 6703644 878848 
pool-3-thread-1
   1793349      2   1  ffffa14ae2402610  UN   0.0       0      0 
[kworker/1:0]
   1850718  166101   0  ffffa14807448cb0  UN   0.0   18724   6068  exe
   1850727  1850722   0  ffffa147e18dd8d0  UN   0.0   18724   6068  exe
   1850733  120305   1  ffffa147e18da610  UN   0.0  135924   6512  runc
   1850792  128006  46  ffffa14ae1948cb0  UN   0.0   21716   1280  logrotate
   1850914  1850911   1  ffffa147086dbf70  UN   0.0   18724   6068  exe
   1851274  127909  46  ffffa14703661960  UN   0.0   53344   3232 
redis-server
   1851474  1850787   1  ffffa1470026cc20  UN   0.0  115704   1244  ceph
   1853422  1853340  44  ffffa146dfdc1960  UN   0.0   12396   2312  sh
   1854005      1   1  ffffa146d7d8f230  UN   0.0  116872    812  mkdir
   1854955  2847282   1  ffffa146c5d18cb0  UN   0.0   18724   6068  exe
   1856515  166108   1  ffffa146aa071960  UN   0.0   18724   6068  exe
   1856602  84624   1  ffffa146aa073f70  UN   0.0  184416   1988  crond
   1859661  1859658   1  ffffa14672090000  UN   0.0  116872    812  mkdir
   2232051  165443   7  ffffa147e1ac0000  UN   0.0       0      0 
eal-intr-thread


Thanks,
Chris

