Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55C764C31E
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 05:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLNETc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Dec 2022 23:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiLNETb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Dec 2022 23:19:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4111326D7;
        Tue, 13 Dec 2022 20:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670991569; x=1702527569;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gD5qUs4zvHK9tSZZg4PIwU/i16qoXYxEwgoTgtshsig=;
  b=ZMGhjlR+K3+sCBIxqqSM9c2zMeM8T868ky6QgKDINUDuies35u7aKVx8
   X5CsMgik55J6hKNBSQKZBdQA7nDmzlehxaLKQiKXpZ73Axn834OZ6zFVH
   UO1X4xmmlZhCIhVJHdiPXN2H0fggtDrwbFkcQWKlcZV2EDLmlQnlOS0nE
   5RiZ3GzaYxtegUl7hi8chOjzPl6ma7NCtNaOaC/D7mwNLkqSKwuMTFY4V
   gfeGK8cbxDAcB0x8rWw2S31Orss2sIdHGYXYgz0E7/He4PDVXI8fCfYAG
   coh8/NYY1++Nwq8JyIzQcXpkj/lco4IeeYnEJVSbcL69YxcuA4N/lFB9L
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="382607526"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="382607526"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 20:19:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="737597730"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="737597730"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2022 20:19:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 20:19:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 20:19:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 20:19:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJZ/M1x0Ohanc6mLD+l0Feud0JwCP2gscsm1xjle+QMYTYxGbQSEOsD4Y7uPxkY6Dm+72M/Ov0p1hV05gCugsrQ9Q0ry/2PaHnTgcYczILDLCsyJ/7hm359OW9EmClmFpSTVFyPRlhR5APiyH/h/B2h6gIn+hUNZEKn8L+3q2KTGzsD+fDdEAId9cFFogKLSWWo0os/7oNOugJL9bIDqD42dz6DBhT4oPRnDjE09TTRyCBG4mv044Ga6gO2rgJkRH4H8WOf/JZFjg20UfOfee5DjbSqspprkywYKPclYnS8zuoBU/u9s3iILdVsnMZ0SYpiTKbbFN+09Iv93bqIqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeEzVarl+eSCjWciuPgSghZNS1Sm50pgFpNNu8ld48M=;
 b=eT8hH/9EACy1FNqDV5tNN6Dmeif0d4Zna7IK7OyIcA3L/cJti07IC1J4q5NPwQiCJ4AkSmHHojRonJrzXN9Ix/Vix7aKIybhWzUxYW0s2nNcpJWE7N2DraHh8HURI4OyRsIcUx/h96qyo+bvFmL7cH5/bVlp3Gmd63KfaBXdP6dunk7amtdQ4psjV1GizpOc74Y6gO5YNqepMQ/WI43RT3IbzbTHPdhvhzZMeIw81+r0ZzWdrN+PZ+M5PDCExn6sTseI7XKY70ma23U7gbn2iikdn7SbkvPx5qsjRv7wLfDroWTJHwWSbt+D99bvThl1Y+4cFJn8eC03dUWdTB8D1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 04:19:26 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 04:19:25 +0000
Date:   Wed, 14 Dec 2022 12:19:59 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <yebin10@huawei.com>
CC:     <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <heng.su@intel.com>,
        <pengfei.xu@intel.com>
Subject: [Syzkaller & bisect] There is "possible deadlock in ext4_bmap" issue
 in v6.1 kernel
Message-ID: <Y5lO7xPYh/c6Qyq/@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: b526e0ec-c422-4cb9-9790-08dadd8a625f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHZY10bhUuHAnz/COu53//Fce84Nshqz1mZBzuuJ0Lo0afNI7hN5AApvZecGmSNNzIy6G7iY5DpdpOctCunHvV8CzQPJ4Fgj2HhgTKnXOi+haJg3RUKT2ykZvkvq3obsL/7//lEIdQ5EQ38J06ReDCDfa+jHL33PHpMkIUsZyg7JQYOnUlppGyWf2gIa8rdrsxxNJlrx7YyhAeLNC/nFnDvH72rN8+5ndzmfA6i6VWo6F/y6tECG+UFrq3owqFoFd4dS7lGAJqbAEgSWl/zoIXlNssi08RENs4IzivO/6iC37oQP8QCpluhwY4XlrJT4egoV6GUx4+0e/Tg6Buna5A8t9YY67x3cYRo8duGUok/l40OvP9FQC1UHs0AcM5taQ2c5+6qDuMe018RbHUC5AH3I0Gv+KhhW8aE33/0XdQPF7mdt6eTRhuKvbmsjvvdfSgAJHZP1jdrBT5SkyL0Fo5OflnX0fc3Hn+76tkFxDNKKAHV/u/1zwYNefAIFIwI0v9915nzpGtVFRkG47en7mcKV42SLZ7HwMf5cUI3cdNznqQ20sEyYmxQyYce8zO2e3zDJYyKVIjl00hKaa2RiqwWZyFbldpluqjwsFBoT1FW74pQmOWNi2Qek3FNtObYQCbcwrDBWpAl8B9z/BqH4EJog943TN0ZOVI4Wzn+kZO7U7wkRxMlbbCY7w/puaAWXkfYtjO+JVua09UpLjsPoZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(107886003)(6666004)(966005)(6486002)(478600001)(38100700002)(86362001)(8936002)(82960400001)(5660300002)(44832011)(41300700001)(4326008)(8676002)(6916009)(186003)(66556008)(66946007)(66476007)(26005)(6506007)(316002)(2906002)(6512007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fh6gVWsKjVDYRIwpX917jsSgXVrIl3rjn7u1kPjsMLzJo75erE7xek6XymD4?=
 =?us-ascii?Q?vIpsm95JpUw1p1kD45xTwtJs3flI7YhQAIll0W3G9zKZ2T6+WgRCvTV/tKYx?=
 =?us-ascii?Q?pS/K9GW7F2C+YBCRcuvhN87BnHTDNEkQGwFRtp4JPtYFnG/4stXdpNzZSQG8?=
 =?us-ascii?Q?6Z2do902qnltcg2xj3fF8bftDSqu9PnoP3ymmQBUCvzTaGHsBLfr/83WdAjK?=
 =?us-ascii?Q?/3vETkj51yx5q6OTQ7VuRpm8z/yhclMlWv5K6sP6lvBWoot7H6sWmva/gn+3?=
 =?us-ascii?Q?O0g24RFKjHeC5NL0DOiAWjUpcsrERLOGxbA1FCg6Leb+eHwwWTsggm8bFVRp?=
 =?us-ascii?Q?TBeDMJhWfEbSXpa16SGhPqjMeNxbxJxUTXzL+I0ob+Mjx4sG4NZpdtQbxhFX?=
 =?us-ascii?Q?IQV2//gdHJao3e6JA1NxOzkhNdr9cCF4FCyRegdLcpPn/9ACy4FWJyM+1jVe?=
 =?us-ascii?Q?sPl9sQ1XwUfDU8DZ084oxo+42UDV6vGhOk77uDgpN8l0BPYo6i+vCW3RC6RT?=
 =?us-ascii?Q?JRqQ10Yw7OQMsPhed2ACEqOG+EUUvnCVavQIIZSvY6z+mYIqFFw0hvn7z9gz?=
 =?us-ascii?Q?o+9inw77YW5kDW/BCGe0C8jZG6xbhhySjAINizBCgzPXu6kIGzppZQbrPRhC?=
 =?us-ascii?Q?B517xn+lBgJv4NrDAV1PD2Q/Ock0z858tARFvtyDyudjebDX9hMtk5L9MMyo?=
 =?us-ascii?Q?AcWp9O66mYRpKHMTtmpMJEQEQH6zWNXUb8Zx4qnFxztfVjANg1yl09Qchb/d?=
 =?us-ascii?Q?H2ic0qDeyI4iP5te2golfIDpWtRlJetmQ0q9ITOHIhO0DsbZmgghcerstLzs?=
 =?us-ascii?Q?yrqGZoezfoJnp/+vhsiORTCrYKx+bXO5CO4ZMrcdFesR0BuSeApyZnvCNhUR?=
 =?us-ascii?Q?FWcrhbavI8fE3+jAzRE42PBrfPr7l3LSM2uy95rBGoQTHdCoNEE88iOk1p/Q?=
 =?us-ascii?Q?vvTgG3C4imIaJPZ+DxzNdOp2HIusWhiUhvI2GCzyV81drOdcH9pkXWZNUjlX?=
 =?us-ascii?Q?ccgn/qmPyaao71Ifz6FZGk1yRVoGw5X9kILGItTHU+pEWstbSdelBtd9qTEA?=
 =?us-ascii?Q?AT4mwEPwPUTaFEsFw14tp2k0mSClGmtApZCf5a4W93Wb3qCp2m4QYvJm9MtQ?=
 =?us-ascii?Q?3RqkiTA2BvVHTsgN9snmjfqAhw3k4+1dget/W5Qjy1/ovmleU/yDsPo0pgSa?=
 =?us-ascii?Q?vxye84bXxp7fO6EU10xm71NrwU1i1/ltQG4B21B7XmPFWAc9sbyiE0YWlBdk?=
 =?us-ascii?Q?yPBo6JF77iHUSiLwOkLtfNQy6u0VG1D4rcupK+OJbkN1WDuZOfXL6fnCxGjW?=
 =?us-ascii?Q?cdcLhjAYNqHGqoJzaVI1MRyYX34wiPONk20bfujOs8UBhMGZC0fd14Q40vh1?=
 =?us-ascii?Q?W0mhEU+ohweike3iCvTh34AjM4Bt/stYWmcPkGT6+rXt4puwNDsaZX5mHbWD?=
 =?us-ascii?Q?8V1K8KyHw8vvt4ZzIT/0FDgv7C2/ahomb7PlPQzGs2UoIXaY8OF6+mq47Sms?=
 =?us-ascii?Q?4nKDv8i5zuoiDqyovYrUbCh5U8tsPPgXEMdhYbEVO7oyZUNRUlvqAb1FVBpS?=
 =?us-ascii?Q?xyneYwaiwzbuMrGZMuwbJG4CDgk4OYFhcj1AkL33jCB4QPiJBYumw6o5AB/Y?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b526e0ec-c422-4cb9-9790-08dadd8a625f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 04:19:25.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpqWDUFlFO9dHGjfQgtxLdX3k00Sq1spewqJR61S74HK2pnEGvlDc+Epu/5/bejrH3MMuKDSnMc+zJhNyAJZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ye Bin and ext4 expert,

Greeting!

There is "possible deadlock in ext4_bmap" issue in v6.1 kernel:
"
[   28.421104] 
[   28.421671] ======================================================
[   28.422016] WARNING: possible circular locking dependency detected
[   28.422358] 6.1.0-830b3c68c1fb #1 Not tainted
[   28.422607] ------------------------------------------------------
[   28.422956] repro/588 is trying to acquire lock:
[   28.423217] ff110000060e5980 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_bmap+0x39/0x1c0
[   28.423729] 
[   28.423729] but task is already holding lock:
[   28.424055] ff110000093323f8 (&journal->j_checkpoint_mutex){+.+.}-{3:3}, at: jbd2_journal_flush+0x267/0x5f0
[   28.424610] 
[   28.424610] which lock already depends on the new lock.
[   28.424610] 
[   28.425057] 
[   28.425057] the existing dependency chain (in reverse order) is:
[   28.425467] 
[   28.425467] -> #3 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
[   28.425877]        mutex_lock_io_nested+0xad/0xd60
[   28.426156]        jbd2_journal_flush+0xcf/0x5f0
[   28.426429]        __ext4_ioctl+0x225/0x25c0
[   28.426680]        ext4_ioctl+0x2e/0x40
[   28.426908]        __x64_sys_ioctl+0x10e/0x160
[   28.427171]        do_syscall_64+0x3b/0x90
[   28.427417]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   28.427739] 
[   28.427739] -> #2 (&journal->j_barrier){+.+.}-{3:3}:
[   28.428105]        __mutex_lock+0x9c/0xf30
[   28.428342]        mutex_lock_nested+0x1f/0x30
[   28.428600]        jbd2_journal_lock_updates+0xbe/0x1a0
[   28.428909]        ext4_change_inode_journal_flag+0xd4/0x2c0
[   28.429234]        ext4_fileattr_set+0x86d/0xe60
[   28.429501]        vfs_fileattr_set+0x365/0x4e0
[   28.429765]        do_vfs_ioctl+0x378/0xcc0
[   28.430010]        __x64_sys_ioctl+0xca/0x160
[   28.430265]        do_syscall_64+0x3b/0x90
[   28.430508]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   28.430832] 
[   28.430832] -> #1 (&sbi->s_writepages_rwsem){++++}-{0:0}:
[   28.431224]        percpu_down_write+0x4d/0x2d0
[   28.431487]        ext4_ind_migrate+0xcc/0x390
[   28.431748]        ext4_fileattr_set+0xbba/0xe60
[   28.432018]        vfs_fileattr_set+0x365/0x4e0
[   28.432280]        do_vfs_ioctl+0x378/0xcc0
[   28.432525]        __x64_sys_ioctl+0xca/0x160
[   28.432780]        do_syscall_64+0x3b/0x90
[   28.433027]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   28.433349] 
[   28.433349] -> #0 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
[   28.433751]        __lock_acquire+0x1023/0x1d20
[   28.434022]        lock_acquire+0xd6/0x2f0
[   28.434259]        down_read+0x45/0x160
[   28.434483]        ext4_bmap+0x39/0x1c0
[   28.434718]        bmap+0x40/0x70
[   28.434925]        jbd2_journal_bmap+0x61/0xe0
[   28.435186]        jbd2_journal_flush+0x461/0x5f0
[   28.435459]        __ext4_ioctl+0x225/0x25c0
[   28.435708]        ext4_ioctl+0x2e/0x40
[   28.435935]        __x64_sys_ioctl+0x10e/0x160
[   28.436193]        do_syscall_64+0x3b/0x90
[   28.436436]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   28.436757] 
[   28.436757] other info that might help us debug this:
[   28.436757] 
[   28.437194] Chain exists of:
[   28.437194]   &sb->s_type->i_mutex_key#8 --> &journal->j_barrier --> &journal->j_checkpoint_mutex
[   28.437194] 
[   28.437924]  Possible unsafe locking scenario:
[   28.437924] 
[   28.438251]        CPU0                    CPU1
[   28.438505]        ----                    ----
[   28.438759]   lock(&journal->j_checkpoint_mutex);
[   28.439030]                                lock(&journal->j_barrier);
[   28.439388]                                lock(&journal->j_checkpoint_mutex);
[   28.439788]   lock(&sb->s_type->i_mutex_key#8);
[   28.440052] 
[   28.440052]  *** DEADLOCK ***
[   28.440052] 
[   28.440378] 2 locks held by repro/588:
[   28.440595]  #0: ff11000009332170 (&journal->j_barrier){+.+.}-{3:3}, at: jbd2_journal_lock_updates+0xbe/0x1a0
[   28.441168]  #1: ff110000093323f8 (&journal->j_checkpoint_mutex){+.+.}-{3:3}, at: jbd2_journal_flush+0x267/0x5f0
[   28.441746] 
[   28.441746] stack backtrace:
[   28.441994] CPU: 1 PID: 588 Comm: repro Not tainted 6.1.0-830b3c68c1fb #1
[   28.442375] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   28.443004] Call Trace:
[   28.443148]  <TASK>
[   28.443275]  dump_stack_lvl+0xa7/0xdb
[   28.443497]  dump_stack+0x19/0x1f
[   28.443699]  print_circular_bug.isra.46.cold.67+0x13e/0x143
[   28.444031]  check_noncircular+0x102/0x120
[   28.444277]  ? write_comp_data+0x2f/0x90
[   28.444508]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   28.444783]  __lock_acquire+0x1023/0x1d20
[   28.445025]  lock_acquire+0xd6/0x2f0
[   28.445236]  ? ext4_bmap+0x39/0x1c0
[   28.445453]  down_read+0x45/0x160
[   28.445652]  ? ext4_bmap+0x39/0x1c0
[   28.445865]  ? ext4_invalidate_folio+0x1e0/0x1e0
[   28.446143]  ext4_bmap+0x39/0x1c0
[   28.446347]  ? ext4_invalidate_folio+0x1e0/0x1e0
[   28.446622]  bmap+0x40/0x70
[   28.446800]  jbd2_journal_bmap+0x61/0xe0
[   28.447038]  jbd2_journal_flush+0x461/0x5f0
[   28.447287]  __ext4_ioctl+0x225/0x25c0
[   28.447510]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   28.447782]  ? do_vfs_ioctl+0xb8/0xcc0
[   28.448006]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   28.448281]  ext4_ioctl+0x2e/0x40
[   28.448480]  __x64_sys_ioctl+0x10e/0x160
[   28.448712]  ? ext4_fileattr_set+0xe60/0xe60
[   28.448964]  do_syscall_64+0x3b/0x90
[   28.449183]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   28.449479] RIP: 0033:0x7f839e4b959d
[   28.449689] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
[   28.450702] RSP: 002b:00007ffd48343808 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
[   28.451127] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f839e4b959d
[   28.451523] RDX: 0000000020000080 RSI: 000000004004662b RDI: 0000000000000004
[   28.451922] RBP: 00007ffd48343820 R08: 00007ffd48343900 R09: 00007ffd48343900
[   28.452317] R10: 00007ffd48343900 R11: 0000000000000217 R12: 0000000000401060
[   28.452712] R13: 00007ffd48343900 R14: 0000000000000000 R15: 0000000000000000
[   28.453116]  </TASK>
[   28.675120] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   28.898857] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   29.121957] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   29.343926] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   29.563709] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   29.783732] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   30.002988] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   30.222407] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   30.442175] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   33.495841] ext4_ioctl_checkpoint: 13 callbacks suppressed
[   33.495853] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   33.714325] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   33.932831] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   34.151299] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   34.370576] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   34.589091] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   34.808403] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   35.028663] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   35.247587] warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
"
Bisect and found that, the first bad commit is:
51ae846cff568c8c29921b1b28eb2dfbcd4ac12d
ext4: fix warning in ext4_iomap_begin as race between bmap and write

After reverted the bad commit on top of v6.1, this issue was gone.

All above bisect info, kconfig, reproduced code from syzkaller is in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/221212_234319_ext4_bmap

============================================================================


There was one more similar "possible deadlock in jbd2_journal_lock_updates"
issue found by syzkaller, and bisected and found that the first bad commit is
also 51ae846cff568c8c29921b1b28eb2dfbcd4ac12d

Reverted above commit on top of v6.1, the jbd2_journal_lock_updates issue was
gone also.

Related issue bisect info, reproduced code is in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/221213_160256_jbd2_journal_lock_updates


Thanks!
BR.
