Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8DC278F8A
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 19:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgIYRWx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 13:22:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7874 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727290AbgIYRWw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 25 Sep 2020 13:22:52 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08PHH0YL002957;
        Fri, 25 Sep 2020 10:22:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oTtmHfp7jMBfiEX3+bBsSGROk4Xz+n76C4SUkuQBMd4=;
 b=H+uRYTCZWxfgO4Il1+LLqx/Zycr6vqhJN1ICnzzKKrAhwFCxEyV+1p9eMRiuiGJPUT52
 T0rp0fRBUuutoAKpYmMfdliFjUXRaksPMOLGm2kFDZBxATPzEk1mamXOZLCy1OW9cn9i
 qrQ5VVJgVWWjjCXW2ILUc8iP4EbOmPTZk7o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp7gsra-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 10:22:40 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 25 Sep 2020 10:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmn4q3CrFITuXWq0qSvk4rDjtT80JGPhr0KW69HSwj1zlO3uv5NjjP7F5RHsEY2FvNRCG9nZCWCiqT9x8pdWDirrVBwgQ63iM0Fwwn8BcDMKRmhaAUQsd9GAOOj2RhK3YU2Jj4MD+3IpP5BzJZKZfGuFANDYMWsYPGJBFgkwvZXuDvb0xRNsxo5W0XcB9Nuna77A4jE/yQ0HIMCqvd8mBXNAYDpCavzw4wsnW3NZL/DyLO3tRoMFD4mtwOCSCkVa3GTlTGNnjACAcBGs93fHODFgD5TmIJdxn4UcrfWDGbNyWyQp7nCoUGQN50Agr68p+jU5uRV62/+lTv+ZXPJ16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTtmHfp7jMBfiEX3+bBsSGROk4Xz+n76C4SUkuQBMd4=;
 b=kVtc4YaKRwp94Zp0D8xlHmGR4wvJtLYgom7TcnXhPn7lpU3Jlkoq4EF2tReApZui4TdpVY2L0VoxKVmKdFxLD5yupBQqgxFPRVsJq/nPM0GNo4GzMYIr1B/5RA1bVBszWZGn8PhDD8NRkVQhlvQUytldsw5uqDmQT5g6zOc1NGpg8/+2nTlo/DQXi+oQRaARx0cXYtrhzwp6ZwV0MOa50dGDvib0It3SCEU/6hDxfQoyUiRVPldVXvb1+HKORJtUt/vQ8dpiP4/GpR3BJ6Oik1ZyMZrk5k0uBaqDhCiLAKCXmz2gB0RFxikkFhjJvU8gd3im86WGp31Zhp5w2EFVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTtmHfp7jMBfiEX3+bBsSGROk4Xz+n76C4SUkuQBMd4=;
 b=NK12tAcvy8opI/Hni7cPQ0yMgJT7iDwmNUZJLCMQYM9b15Ba8ZGl7xHRWlu1KYLLiqa5eCyX06norNp5OE3RPrvtQJDOid9XF/MXNYTR9tCzcunftFMb3MDgijEs6Npecq3TqnU41VrWx5byzTKuOxjeGdFfYJr1UgHWuwEFeIs=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3143.namprd15.prod.outlook.com (2603:10b6:a03:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 25 Sep
 2020 17:22:37 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3391.027; Fri, 25 Sep 2020
 17:22:37 +0000
Date:   Fri, 25 Sep 2020 10:22:32 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Ming Lei <ming.lei@redhat.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>, <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200925172232.GA2180331@carbon.dhcp.thefacebook.com>
References: <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590>
 <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590>
 <20200924143345.GD482521@mit.edu>
 <20200925011311.GJ482521@mit.edu>
 <20200925073145.GC2388140@T590>
 <20200925161918.GD2388140@T590>
 <CALvZod6QUvmD_3xf0FM4qt=9YT=nwuMV3ZqFayND+dUp9oQUsQ@mail.gmail.com>
 <CALvZod4uLs399uGh89RV=QsjOXu0-iFLW8ifgWjC9N6OpRqu-w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4uLs399uGh89RV=QsjOXu0-iFLW8ifgWjC9N6OpRqu-w@mail.gmail.com>
X-ClientProxiedBy: MWHPR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:300:116::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:d27c) by MWHPR07CA0014.namprd07.prod.outlook.com (2603:10b6:300:116::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Fri, 25 Sep 2020 17:22:36 +0000
X-Originating-IP: [2620:10d:c090:400::5:d27c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1961144d-7982-432b-9997-08d86177992a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3143:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3143B7B64F96ED4E209EECBABE360@BYAPR15MB3143.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0wgBklH8Qycte7iF9x150mjMJpWJ6pA77rTeIBr5Xmt18tumrnLy+OnRj+4+r71QWGBp1+hCk3k2aCitwT4JYdRgthgoSZJ3qEB+AYChFi/Fj0ZQhhtmtkQhiRhawoM5Z13lPurLvNSyUVnIsTTHl71bAovsEy2javv0X5CYRtb1uhNrLCA5PmmVjXlNUFb0IbTen1Wrx4hKXcPfRnlbwE77gNii/mhqjNhlJ2o1bUhnN5qfmkBJsqH3gpyv4zKv6roZytzsfM+uPmdFy06ysE734DKs0MbB+3XHoAmS4U9uv9XJzM3HrpkEC+aygrtD2487fYCYWzs0NFMiX5JZ6O9+Py+q5bFisD0mK96ZBRdMpBEUE16l+eAyy+I9f8eBklemWji/PdiN93CrJQd4cKvpnKCayWRSHJg4xDaIhEelFHiG82FYGeLpUkMkwqg2elMoJdM7+gf+aUdMhJhtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(346002)(376002)(366004)(16526019)(186003)(316002)(7696005)(6506007)(7416002)(33656002)(2906002)(66556008)(66476007)(53546011)(66946007)(966005)(8676002)(5660300002)(9686003)(52116002)(478600001)(54906003)(4326008)(6666004)(83380400001)(6916009)(8936002)(86362001)(55016002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: kma/QY7SvroCKcKMwxZzSlI5E/RpyTCjB6TYps4ePwdcNPxJp0Xy3LpzUN2NSzdSN4PNWS5TkAGIp1jfoyDVc3jJtYyZiKvSD5vESiaMS0EvoSA8GyZ6sFip2Ygp28np43n+wOohHDGc4eV8P26kuP10Po1IPRt1SkaXDpbh7e90A7qDFs7qn9hNM71U+IlEwlehEyzMaC4bFUw+EXzxzWVAgTv5r15CMbMR0hdcYhnxbuOLUQrz63Z+sHQQ8ls0uSyTnhbO9FQSDVtWnn2+xd5IffWMUSqH2T2cw71bQ3s2VTPg8YqC3h3Tjq+nT7TN0RnRptNscpLYNI/NZh1lC6mw1hUxTXbParLhKOqdzEF8xOEHtgFZ/QMGeN78Q1qbcrVocrPwsVwr+uAke6SfI1NejnsGUQ98n5XMvQ7X/cpk+v7J84KAgnlMyCqylPGuQ8LEvj1Lv9KhMYakbBHOfmHtLeHqLvHtzybliJ4UZpFClDlP+rpBoJSTEViWWzDLXSEVDaUVC644a8pEULQEDdkkiUIhmkZuWtmeRJRD8260mkQoCPg9kCdUlqCfCNvCIFaUpAnLMjlwUMlbiAFbhaW3uadAAnCwM/nwQXIwRNj+5K/tuFBmjl9b80vqj7G5sPsba35CyteBZr7BHihATXOM/DqjhIJQENDJGJ5DxJo=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1961144d-7982-432b-9997-08d86177992a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 17:22:37.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kArdMZMwgw6le8RoO4boybZ1K7kQNHn1VjrayMNemSFu05Z8MAeEIcdjd662DDFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3143
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-25_15:2020-09-24,2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1011 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009250120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 09:47:43AM -0700, Shakeel Butt wrote:
> On Fri, Sep 25, 2020 at 9:32 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Fri, Sep 25, 2020 at 9:19 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Fri, Sep 25, 2020 at 03:31:45PM +0800, Ming Lei wrote:
> > > > On Thu, Sep 24, 2020 at 09:13:11PM -0400, Theodore Y. Ts'o wrote:
> > > > > On Thu, Sep 24, 2020 at 10:33:45AM -0400, Theodore Y. Ts'o wrote:
> > > > > > HOWEVER, thanks to a hint from a colleague at $WORK, and realizing
> > > > > > that one of the stack traces had virtio balloon in the trace, I
> > > > > > realized that when I switched the GCE VM type from e1-standard-2 to
> > > > > > n1-standard-2 (where e1 VM's are cheaper because they use
> > > > > > virtio-balloon to better manage host OS memory utilization), problem
> > > > > > has become, much, *much* rarer (and possibly has gone away, although
> > > > > > I'm going to want to run a lot more tests before I say that
> > > > > > conclusively) on my test setup.  At the very least, using an n1 VM
> > > > > > (which doesn't have virtio-balloon enabled in the hypervisor) is
> > > > > > enough to unblock ext4 development.
> > > > >
> > > > > .... and I spoke too soon.  A number of runs using -rc6 are now
> > > > > failing even with the n1-standard-2 VM, so virtio-ballon may not be an
> > > > > indicator.
> > > > >
> > > > > This is why debugging this is frustrating; it is very much a heisenbug
> > > > > --- although 5.8 seems to work completely reliably, as does commits
> > > > > before 37f4a24c2469.  Anything after that point will show random
> > > > > failures.  :-(
> > > >
> > > > It does not make sense to mention 37f4a24c2469, which is reverted in
> > > > 4e2f62e566b5. Later the patch in 37f4a24c2469 is fixed and re-commited
> > > > as 568f27006577.
> > > >
> > > > However, I can _not_ reproduce the issue by running the same test on
> > > > kernel built from 568f27006577 directly.
> > > >
> > > > Also you have confirmed that the issue can't be fixed after reverting
> > > > 568f27006577 against v5.9-rc4.
> > > >
> > > > Looks the real issue(slab list corruption) should be introduced between
> > > > 568f27006577 and v5.9-rc4.
> > >
> > > git bisect shows the first bad commit:
> > >
> > >         [10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of
> > >                 kmem_caches for all allocations
> > >
> > > And I have double checked that the above commit is really the first bad
> > > commit for the list corruption issue of 'list_del corruption, ffffe1c241b00408->next
> > > is LIST_POISON1 (dead000000000100)', see the detailed stack trace and
> > > kernel oops log in the following link:
> > >
> > >         https://lore.kernel.org/lkml/20200916202026.GC38283@mit.edu/
> >
> > The failure signature is similar to
> > https://lore.kernel.org/lkml/20200901075321.GL4299@shao2-debian/
> >
> > >
> > > And the kernel config is the one(without KASAN) used by Theodore in GCE VM, see
> > > the following link:
> > >
> > >         https://lore.kernel.org/lkml/20200917143012.GF38283@mit.edu/
> > >
> > > The reproducer is xfstests generic/038. In my setting, test device is virtio-scsi, and
> > > scratch device is virtio-blk.
> 
> Is it possible to check SLUB as well to confirm that the issue is only
> happening on SLAB?

Can you also, please, check if passing cgroup.memory=nokmem as a boot argument
is fixing the issue?

Thanks!
