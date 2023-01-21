Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B14676751
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 17:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjAUQKM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 11:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUQKL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 11:10:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204A1E9D4
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 08:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674317400; x=1705853400;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=mKOgMKfxArTuQ7wyoKa1fvUDGECHLHRT2niL0PBpSFo=;
  b=WOZ8zH5AkHuz5teU3eYhlDDvaCg/s2DoslYlkq6qapiWH6txjnrB8CK+
   HWQpvALHP+PwkveCbKsvrsiVxpOwwHKaT0vef7oAn2VTsFGp01xmmtu9X
   R9AjlQ8I6EXb8URBmnbFwSnxremKU6bWoqGAJvgJWj+rYKuqpo74iQZ8F
   6rntCS8Uw3f2snQkDtT905ZnR+wKsotS1H8qW9CFtvGJpkA+PHqicSrVd
   LwfombVR1bwgivJrVm7AqvWNiJsHUy3PliK9ZzvVbxOCEDsLqdPqMkxDK
   /amRWAHhHwcRedv5mtIgKyVizYtCWri7WyxGwZerDmX9IopkqLrZ4Gdy2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="324484732"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="324484732"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 08:09:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="989724602"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="989724602"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jan 2023 08:09:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 21 Jan 2023 08:09:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 21 Jan 2023 08:09:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 21 Jan 2023 08:09:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4VdyX86TPmGuaowmuDkNGZQ9Wtpe4v9+yWN4ws6z/5+wUZF5QGJj0qtE6JmTJw4LOMSYFjw9pyDJ58HLShsTu43GQGegqyiRC6xSS5WTjVQWvLrrPU9S0CA5LsfQxjMrhriHtNOQuj+hsiE18ouQR2SW0vhQ7M6yh1RUBxQwEGbSBpGw4OSVYjXYu76IUiQRC6Ro/5cy5KfEjsbkdk8ECdt/b9RZGeNLIVdE95sLo3hS6ESQhr267DvZ9dcoQTHiUvb8T7fAStC2gRLFXG4HhUuOWTIOlYRj0jtg2Hexch6xqVop3GoNyQdy+mDBICJAPD4l43xSUJG1Z2rN8/Ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+jMIZsxgBjxiWMvfGFoBM5d2NGjOOF/ZII7Fu3TWGw=;
 b=gbbeUMfUmOoXeP2igPCMFoPWHhM+17G7OBB/0bzdm69TtAWx6RHaU+WkziF6JkiUT/++CjoqPoiY0YKshA3UDCgC6mGDOcbCdBKICvNO8yxrRwsKoL727x/YHRYFTnVE7zYxHx+IzCdWNJ+9F9z6nOJAYl3JPhjhrCoTwU0EST9xFDkJDkcLopxRI577ooaydgOgSp6PW8v3ylCMbPDvDIq5UTAt44RKr59wftr2ePQcOLFcQqRlevePHiF4J42ue6HGulYHVQUS66XnB/4G/ixpX60y7kAWZpCl9BBpdQtTfR5X9NgxjamZ0j6CNA7rQTFJM5XdED9jaCGnNtsLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BL1PR11MB5447.namprd11.prod.outlook.com (2603:10b6:208:315::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sat, 21 Jan
 2023 16:09:51 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb%9]) with mapi id 15.20.6002.027; Sat, 21 Jan 2023
 16:09:51 +0000
Date:   Sun, 22 Jan 2023 00:07:55 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     zhanchengbin <zhanchengbin1@huawei.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Zhang Yi <yi.zhang@huawei.com>, <linux-ext4@vger.kernel.org>,
        <tytso@mit.edu>, <jack@suse.com>, <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>, zhanchengbin <zhanchengbin1@huawei.com>
Subject: Re: [PATCH 2/2] ext4: call ext4_handle_error when read extent failed
 in ext4_ext_insert_extent
Message-ID: <202301212330.48ec3159-yujie.liu@intel.com>
Content-Type: multipart/mixed; boundary="dlqobGt1ml2DdgNT"
Content-Disposition: inline
In-Reply-To: <20230110133407.994711-3-zhanchengbin1@huawei.com>
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|BL1PR11MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: 25db4cd9-7b54-425a-8ca9-08dafbc9ec66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsdOBYZCWfKf32Du2vlkFXGUiPZIwoVwC2jVyamuooTzL8AQaBXUlI/Lf+RzC1xdSDkOEZes4WIeZZMK9BXKEJhFXJ3BoohX2wGlKOTTygeQgc5wiaW+x+YQV5JakxSceGIwD4NZsTuYje+Zhxd1bN/9Vagr1h3NVIbssjSsVeIv9a0UptX/6u4I/3XqDiq9Z4sWe2NWoZay2KEIkGXtR4OabGfWOyss5fveBONcS/40IL6Qn0aZi9z06FYBLccgBKw6sL2iIo5Q8cFsrjPA9vg7za1Rs42PHnCtx45LsJjPZTEkQtFThzbjvnmVwFpE3/gbCouRuK/yaFia/SYoy7pmkUwwJEnM0bsI+Tldfqf6z9O01mAR17YkgZGLfD0QXrfQCwxWszAMlfJP6b/5F6O2oNrTmLjhkhYZEo2DtXufKpqmmLzV7DdBfPpGkchqlYqB+z43sHgtMGrK3N2938rJb/42+6SUO/ei4Wthq02XB7Y8oK+6TQgUSGcVLP43avH/Kw//sZzXbJK15oK0qXtClUNv5PJ+Gew5AEPSxw3c4J4pu5W4Or3k6clFyua0vCtg3hwp1Hd/hhwVTV0K7h36zdXsOcthtqjd0hHn9Tavy5HXqwuB1JhiNXhR8mWc9umvNukjdAQg+i3nuRZbA3KIz9p2vCdQvaF+WEcjRK60fWdZR9NNMnzcrbk3IaVhveSpoy7H/MoywMqQPOaqNvtllpdqAZBkV2j/VnNywiPinxHLHcMSx99yfADTT2QIuA+AqKzq7ISt34fIyV8wKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(36756003)(21490400003)(4326008)(8676002)(66556008)(6916009)(478600001)(1076003)(2616005)(41300700001)(66946007)(6512007)(66476007)(186003)(26005)(86362001)(2906002)(83380400001)(44144004)(6506007)(54906003)(6486002)(316002)(966005)(82960400001)(235185007)(5660300002)(8936002)(38100700002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gWaC2ADuPBWHT6yDGL7ckdRXvFFulqZOfifhSUCuMIN1KWE1N0ahzOELWDlb?=
 =?us-ascii?Q?9VEzCH8l4HSXZ0oQj+32Q4iN5TvkRKHlH1Q3/das3rxi9scISA9KPcaURV77?=
 =?us-ascii?Q?jt9QDvlJryIJHXn0DZA28zDlLVTJiZk0csPOob+yMZAJiXKQvQ++tTWtNcDy?=
 =?us-ascii?Q?Yjo255d7+W9EIEXwBW0LpXrRDPi0T5fLg1fl7dwdJDWV1GVH2ivvuw63ATiw?=
 =?us-ascii?Q?86816pRSl08QCfcS+cl1kZnGgCzHHWCytNUoyQ8bBkyigLn70hBvuJ9D8tLq?=
 =?us-ascii?Q?uO7/VBXobL6LENEwOsp2Llz3hRxqs7hFLWtDldPzz7bvYV1Y8FK8zNiprX9/?=
 =?us-ascii?Q?5o2l5OUxCbodbu2tthClCCRe8+8NVi85+BqyU27p2wdOJoJHZ7v79ST99saK?=
 =?us-ascii?Q?XMs9Ealyy/54eiUnCupmIlOEUnPVVUHJVUcmzFk5cMZfp5SkczzU6oLUNu7z?=
 =?us-ascii?Q?RVoMBS0ihTDbT8stbveEoiqyTwV8hxbmi91B8zENxunpfWJDoF3wtciXSUYd?=
 =?us-ascii?Q?scTwplLf9RSV8YSNryzyvliIJ8Q515RspN1Do98aNxbY7cTixsmcxtE8KsSm?=
 =?us-ascii?Q?5BtlI17Mukdw3vg5/bTIqFSpdXJ/RqFdxFamiUS6qDrOyqlEQlK+cfXdf3Yo?=
 =?us-ascii?Q?J4z3r3Gm9mqE+ljBWq1EzaGiBvuCYveacV7lMj1mhmdSIcYmuw889Nn13Zxh?=
 =?us-ascii?Q?lxNZaKDMxUOLbvYPeQzvTlcIHZCVNxSBdZnQ3jIDci6THdwlTEIt9Yr6tsn8?=
 =?us-ascii?Q?9/uN3tM6TWz/Td0esAsWJbNOjxqK9Q6sdWy+izu/XVqMUUnbwf/F6tZSDLES?=
 =?us-ascii?Q?yobUPXT9yAbbMMsXSVWweTm8hq3UKeHWwhHfOXQ9n+Yvf1o7QNp2v2HqsTTm?=
 =?us-ascii?Q?hQ/Vo4kgtwyWTVjDTgsVpLrgQTDmtBwakb8PwmYBBl5YEdKCHvoZnLubCoFn?=
 =?us-ascii?Q?wQfD+M9oFtSKHd5UFnlrg1WBrn8yuYSKsxEEDkF7c+gfwPVTn/kWbwfqdVlO?=
 =?us-ascii?Q?VuwifrazlhzhCHi8rjJY8ropvOGNhzL6NSfwedrSg0Sk+GnW4Y+INWMQvwQ0?=
 =?us-ascii?Q?paGyo9jMaDOIo4/15XybMY8S2RabjaX3656/oUmoM8bQ+LpExyHmnM39xC03?=
 =?us-ascii?Q?hFgHptIMGM18PnaXHWt0v1UTiqP4bu8h0+q7slz9Tpd6L89CBPpTQazPdr2y?=
 =?us-ascii?Q?BVeGVl3Vz3L4eRTRHS46RzIrG0GeCi1/UXDeKvhHI3ICZAzYNr3ic5701YiP?=
 =?us-ascii?Q?viiocb3M7ZrqzaSItikIEZZ84WK0ObVWRZUtcYVqstROZvR7s/V4uKpZsAlT?=
 =?us-ascii?Q?9HlPEh8o4pN+jLyjEl3HaRLXFF1YuARSl3PtMRH87o4KMpfATmmVV6HmCTWI?=
 =?us-ascii?Q?ccEj3QfYC2EB6WCk70Z6Szv/Uo2M4oqVr4Ij0l65uFg0uBk2qyDkXpB/ZYiJ?=
 =?us-ascii?Q?KFoLsUFMjT37xcAgYq9OwflUPxXY2RtPwiQp0UiknS9OaPOXK2w3A2MxjOaG?=
 =?us-ascii?Q?x7YDK4HN655cxBdSzNw8uXnLEEculvvlF4tHGtX1vTTdGFWHs+Sxot58tYoH?=
 =?us-ascii?Q?p9AFG+U6Rujgn6G4DEHZa2/1yZA8zIo2ZYPWMYxl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25db4cd9-7b54-425a-8ca9-08dafbc9ec66
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 16:09:51.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0B1YGKUj+XdY5G+8qZSWPqq3XAggNluscYekowiRK3et7KWk9J8ikxhgwynfvb/j2LuCXUVpMaphqCnDXiEYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5447
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--dlqobGt1ml2DdgNT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Greeting,

FYI, we noticed kernel_BUG_at_fs/ext4/extents_status.c due to commit (built with gcc-11):

commit: ce10c493af382439876867dcaee89c7efddfab46 ("[PATCH 2/2] ext4: call ext4_handle_error when read extent failed in ext4_ext_insert_extent")
url: https://github.com/intel-lab-lkp/linux/commits/zhanchengbin/ext4-fix-inode-tree-inconsistency-caused-by-ENOMEM-in-ext4_split_extent_at/20230110-211157
base: https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev
patch link: https://lore.kernel.org/all/20230110133407.994711-3-zhanchengbin1@huawei.com/
patch subject: [PATCH 2/2] ext4: call ext4_handle_error when read extent failed in ext4_ext_insert_extent

in testcase: xfstests
version: xfstests-x86_64-fb6575e-1_20230116
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv3
	test: generic-group-12

test-description: xfstests is a regression test suite for xfs and other files ystems.
test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


[  198.355648][ T1847] ------------[ cut here ]------------
[  198.360964][ T1847] kernel BUG at fs/ext4/extents_status.c:896!
[  198.366894][ T1847] invalid opcode: 0000 [#1] SMP KASAN PTI
[  198.372460][ T1847] CPU: 1 PID: 1847 Comm: smbd Not tainted 6.1.0-rc4-00062-gce10c493af38 #1
[  198.380891][ T1847] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[ 198.389823][ T1847] RIP: 0010:ext4_es_cache_extent (fs/ext4/extents_status.c:896) 
[ 198.395662][ T1847] Code: 48 8b 0c 24 e9 98 fd ff ff 44 89 44 24 0c 48 89 0c 24 e8 b0 dc d0 ff 44 8b 44 24 0c 48 8b 0c 24 e9 55 fd ff ff e8 fd 30 97 01 <0f> 0b 48 c7 c7 40 ab 0f 85 e8 8f dc d0 ff e9 2d ff ff ff e8 85 dc
All code
========
   0:	48 8b 0c 24          	mov    (%rsp),%rcx
   4:	e9 98 fd ff ff       	jmpq   0xfffffffffffffda1
   9:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
   e:	48 89 0c 24          	mov    %rcx,(%rsp)
  12:	e8 b0 dc d0 ff       	callq  0xffffffffffd0dcc7
  17:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  1c:	48 8b 0c 24          	mov    (%rsp),%rcx
  20:	e9 55 fd ff ff       	jmpq   0xfffffffffffffd7a
  25:	e8 fd 30 97 01       	callq  0x1973127
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 c7 c7 40 ab 0f 85 	mov    $0xffffffff850fab40,%rdi
  33:	e8 8f dc d0 ff       	callq  0xffffffffffd0dcc7
  38:	e9 2d ff ff ff       	jmpq   0xffffffffffffff6a
  3d:	e8                   	.byte 0xe8
  3e:	85 dc                	test   %ebx,%esp

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 c7 c7 40 ab 0f 85 	mov    $0xffffffff850fab40,%rdi
   9:	e8 8f dc d0 ff       	callq  0xffffffffffd0dc9d
   e:	e9 2d ff ff ff       	jmpq   0xffffffffffffff40
  13:	e8                   	.byte 0xe8
  14:	85 dc                	test   %ebx,%esp
[  198.415069][ T1847] RSP: 0018:ffffc90001ea76e8 EFLAGS: 00010203
[  198.420989][ T1847] RAX: 07ffffffffffffff RBX: 1ffff920003d4edf RCX: 07ffffffffffffff
[  198.428810][ T1847] RDX: 1ffff11022179815 RSI: 0000000000000050 RDI: ffff888110bcc0a8
[  198.436631][ T1847] RBP: 000000000000002f R08: 47ffffffffffffff R09: ffffc90001ea7693
[  198.444458][ T1847] R10: fffff520003d4ed2 R11: 0000000000000001 R12: ffff888429b96c20
[  198.452281][ T1847] R13: 0000000000000050 R14: dffffc0000000000 R15: ffff888110bcc000
[  198.460092][ T1847] FS:  00007fa7e95b0a40(0000) GS:ffff88837d080000(0000) knlGS:0000000000000000
[  198.468862][ T1847] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  198.475300][ T1847] CR2: 00007fa7ed951c28 CR3: 000000011a476005 CR4: 00000000003706e0
[  198.483096][ T1847] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  198.490900][ T1847] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  198.498707][ T1847] Call Trace:
[  198.501856][ T1847]  <TASK>
[ 198.504644][ T1847] ? check_heap_object (arch/x86/include/asm/bitops.h:207 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:782 include/linux/page-flags.h:803 include/linux/mm.h:732 include/linux/mm.h:1719 mm/usercopy.c:198) 
[ 198.509587][ T1847] ? ext4_es_insert_extent (fs/ext4/extents_status.c:880) 
[ 198.514877][ T1847] ? __check_object_size (mm/memremap.c:420) 
[ 198.520512][ T1847] ? ext4_find_extent (fs/ext4/extents.c:916) 
[ 198.525376][ T1847] ext4_cache_extents (fs/ext4/ext4_extents.h:207 fs/ext4/extents.c:539) 
[ 198.530255][ T1847] ? ext4_find_extent (fs/ext4/extents.c:916) 
[ 198.535132][ T1847] ext4_find_extent (fs/ext4/extents.c:815 fs/ext4/extents.c:954) 
[ 198.539823][ T1847] ext4_ext_map_blocks (fs/ext4/extents.c:4103) 
[ 198.544856][ T1847] ? sched_clock_cpu (kernel/sched/clock.c:369) 
[ 198.549546][ T1847] ? ext4_ext_release (fs/ext4/extents.c:4088) 
[ 198.554236][ T1847] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:127 kernel/locking/spinlock.c:178) 
[ 198.559013][ T1847] ? raw_spin_rq_lock_nested (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:539) 
[ 198.564308][ T1847] ? release_sock (include/net/sock.h:1820 include/net/sock.h:1825 net/core/sock.c:3470) 
[ 198.568740][ T1847] ? tcp_recvmsg (net/ipv4/tcp.c:2682) 
[ 198.573081][ T1847] ? __cond_resched (kernel/sched/core.c:8325) 
[ 198.577600][ T1847] ? down_read (arch/x86/include/asm/atomic64_64.h:34 include/linux/atomic/atomic-long.h:41 include/linux/atomic/atomic-instrumented.h:1280 kernel/locking/rwsem.c:176 kernel/locking/rwsem.c:181 kernel/locking/rwsem.c:249 kernel/locking/rwsem.c:1259 kernel/locking/rwsem.c:1269 kernel/locking/rwsem.c:1511) 
[ 198.581857][ T1847] ? rwsem_down_read_slowpath (kernel/locking/rwsem.c:1507) 
[ 198.587408][ T1847] ? ext4_es_lookup_extent (arch/x86/include/asm/atomic.h:165 arch/x86/include/asm/atomic.h:178 include/linux/atomic/atomic-instrumented.h:147 include/asm-generic/qrwlock.h:113 include/linux/rwlock_api_smp.h:232 fs/ext4/extents_status.c:980) 
[ 198.592705][ T1847] ext4_map_blocks (fs/ext4/inode.c:576) 
[ 198.597403][ T1847] ? inet6_release (net/ipv6/af_inet6.c:673) 
[ 198.601846][ T1847] ? ext4_issue_zeroout (fs/ext4/inode.c:508) 
[ 198.606900][ T1847] ? jbd2_transaction_committed (arch/x86/include/asm/atomic.h:165 arch/x86/include/asm/atomic.h:178 include/linux/atomic/atomic-instrumented.h:147 include/asm-generic/qrwlock.h:113 include/linux/rwlock_api_smp.h:232 fs/jbd2/journal.c:813) 
[ 198.612547][ T1847] ? ext4_set_iomap (arch/x86/include/asm/bitops.h:207 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 fs/ext4/ext4.h:1923 fs/ext4/inode.c:3421) 
[ 198.617232][ T1847] ext4_iomap_begin_report (fs/ext4/inode.c:3672) 
[ 198.622544][ T1847] ? mpage_map_one_extent (fs/ext4/inode.c:3631) 
[ 198.627761][ T1847] ? mpage_map_one_extent (fs/ext4/inode.c:3631) 
[ 198.632971][ T1847] ? __copy_msghdr (net/socket.c:2409) 
[ 198.637571][ T1847] ? from_kgid_munged (kernel/user_namespace.c:524) 
[ 198.642353][ T1847] ? __might_fault (mm/memory.c:5648) 
[ 198.646795][ T1847] ? memset (mm/kasan/shadow.c:44) 
[ 198.650623][ T1847] ? mpage_map_one_extent (fs/ext4/inode.c:3631) 
[ 198.655849][ T1847] iomap_iter (fs/iomap/iter.c:76) 
[ 198.660032][ T1847] ? iomap_iter (fs/iomap/iter.c:71) 
[ 198.664375][ T1847] iomap_seek_hole (fs/iomap/seek.c:49) 
[ 198.668989][ T1847] ? iomap_fiemap (fs/iomap/seek.c:35) 
[ 198.673501][ T1847] ? rwsem_down_read_slowpath (kernel/locking/rwsem.c:1507) 
[ 198.679068][ T1847] ? mutex_lock (arch/x86/include/asm/atomic64_64.h:190 include/linux/atomic/atomic-long.h:443 include/linux/atomic/atomic-instrumented.h:1781 kernel/locking/mutex.c:171 kernel/locking/mutex.c:285) 
[ 198.683247][ T1847] ? __mutex_lock_slowpath (kernel/locking/mutex.c:282) 
[ 198.688381][ T1847] ext4_llseek (include/linux/fs.h:771 fs/ext4/file.c:919) 
[ 198.692638][ T1847] ksys_lseek (fs/read_write.c:289 fs/read_write.c:302) 
[ 198.696720][ T1847] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 198.700976][ T1847] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  198.706705][ T1847] RIP: 0033:0x7fa7ed7d5647
[ 198.710976][ T1847] Code: ff ff ff ff c3 66 0f 1f 44 00 00 48 8b 15 79 a9 00 00 f7 d8 64 89 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 b8 08 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 51 a9 00 00 f7 d8 64 89 02 48
All code
========
   0:	ff                   	(bad)  
   1:	ff                   	(bad)  
   2:	ff                   	(bad)  
   3:	ff c3                	inc    %ebx
   5:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   b:	48 8b 15 79 a9 00 00 	mov    0xa979(%rip),%rdx        # 0xa98b
  12:	f7 d8                	neg    %eax
  14:	64 89 02             	mov    %eax,%fs:(%rdx)
  17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1c:	eb b8                	jmp    0xffffffffffffffd6
  1e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  23:	b8 08 00 00 00       	mov    $0x8,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 01                	ja     0x33
  32:	c3                   	retq   
  33:	48 8b 15 51 a9 00 00 	mov    0xa951(%rip),%rdx        # 0xa98b
  3a:	f7 d8                	neg    %eax
  3c:	64 89 02             	mov    %eax,%fs:(%rdx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 01                	ja     0x9
   8:	c3                   	retq   
   9:	48 8b 15 51 a9 00 00 	mov    0xa951(%rip),%rdx        # 0xa961
  10:	f7 d8                	neg    %eax
  12:	64 89 02             	mov    %eax,%fs:(%rdx)
  15:	48                   	rex.W


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202301212330.48ec3159-yujie.liu@intel.com


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

--dlqobGt1ml2DdgNT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc4-00062-gce10c493af38"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.1.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23990
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23990
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_IMA_KEXEC=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_ERDMA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IDXD_BUS=m
CONFIG_INTEL_IDXD=m
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IDXD_SVM is not set
# CONFIG_INTEL_IDXD_PERFMON is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
# CONFIG_DLM_DEPRECATED_API is not set
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
# CONFIG_IMA_KEXEC is not set
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_IMA_DISABLE_HTABLE is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_SM3_GENERIC=m
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--dlqobGt1ml2DdgNT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='xfstests'
	export testcase='xfstests'
	export category='functional'
	export need_memory='1G'
	export job_origin='xfstests-cifs.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-skl-d07'
	export tbox_group='lkp-skl-d07'
	export submit_id='63cb028b95f40aeba3472c5b'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.yaml'
	export id='eb92518411f76eb6381c04b8863a5ab554295efb'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=8
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1'
	export brand='Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz'
	export need_kconfig='BLK_DEV_SD
SCSI
{"BLOCK"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=>"y"}
EXT4_FS'
	export commit='ce10c493af382439876867dcaee89c7efddfab46'
	export ucode='0xf0'
	export bisect_dmesg=true
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2023-01-21 05:07:24 +0800'
	export _id='63cb02a195f40aeba3472c5d'
	export _rt='/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='160bb02a598f1f5b1bc814e1f008dbc1fe7a0130'
	export base_commit='5dc4c995db9eb45f6373a956eb1f69460e69e6d4'
	export branch='linux-review/zhanchengbin/ext4-fix-inode-tree-inconsistency-caused-by-ENOMEM-in-ext4_split_extent_at/20230110-211157'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export result_root='/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/vmlinuz-6.1.0-rc4-00062-gce10c493af38
branch=linux-review/zhanchengbin/ext4-fix-inode-tree-inconsistency-caused-by-ENOMEM-in-ext4_split_extent_at/20230110-211157
job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=ce10c493af382439876867dcaee89c7efddfab46
initcall_debug
nmi_watchdog=0
max_uptime=1200
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs2_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/xfstests_20230116.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/xfstests-x86_64-fb6575e-1_20230116.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.2.0-rc4'
	export repeat_to=6
	export stop_repeat_if_found='dmesg.kernel_BUG_at_fs/ext4/extents_status.c'
	export kbuild_queue_analysis=1
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/vmlinuz-6.1.0-rc4-00062-gce10c493af38'
	export dequeue_time='2023-01-21 05:19:20 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_hdd=4 $LKP_SRC/setup/disk

	run_setup fs='ext4' $LKP_SRC/setup/fs

	run_setup fs='smbv3' $LKP_SRC/setup/fs2

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='generic-group-12' $LKP_SRC/tests/wrapper xfstests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='generic-group-12' $LKP_SRC/stats/wrapper xfstests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time xfstests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--dlqobGt1ml2DdgNT
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj5CbJq+ZdACIZSGcigsEOvS5SJPSSiEZN91kUwkoEoc4C
r7bBXWVIIX3QflT+sKzVYooFrJJ/12Zhr+XMQhsyCZsZGNDDisloEmuBKnh/AISsDW1y4NagGYvl
gr7eFtbnMfci+24mkp6tx3EVxw3oan1P5qJ25eC6/+VHDJrUdrwT8SmxatqgSH60k5+/cJX19+5d
QrfVnEgHysVPQ53/kQJ/BVc1h9tiJgvTXkqLEXxXUPaI9ghb31hkrKQxkhfLQr5dgQcVVG9X6EeX
k1WJa9ShjsANAaa6Xp9/AC0R9wofSJF9rgY58g4eTQ5PcpVwH6r/1yqA/ccS9ujzwJ2jI4ug/sRz
+0iNfDowhPC5Z6EGzaCVTSZEDrb8/XAAoHNB1WKxo/yZ6OpXUzD3G5SD6k2kSoBrIJbKB+B4nOAc
8QVq2m2sc58eIWPHgmBLMyQ9/ntlcVQQ6ZqCkgdeF7OI/oZ8Pe15V6bimKUvz+D3/9FJ2COeGfyB
JHpgoP8T4qXhV7zJeHirVkgl0iqDXyyzD18ZpUUS+fjD0Tr7UHjzQi9rbOdd7iYj4PLUbP4W7luh
DICL/eaZt4/sgRqHLrGduHnKVcUbE+7/VSMMh3XEVqDbZlMYZRzuQzm+vKindvjb+8tVKHBV9ycn
E4UwlrDFns4YyytpUYTwiUoTP8galRWbkb9a915Kon5sjsGlDBFTmWdCtj/UqfiqVWQQHrEAEaaM
8R9AqwSmn3n/6ZcB1rcECVhg3oAZyJW+zza58USZYaN3/7kIH9JHzOtvmwTuRZbCfHMLniyS36WA
Rta98BHAGEZQrwRn5Twalj+XTVKFJZoKTziLNSnQgieB/bFRdQuKFeovr/MHYCTb+/FczCioOGb7
sC59RODCv8KR5uBEL5qeX5UwUvDSyOPBvTC31lPK/B7wCqyuewLoWM4EXEzvPb3IE9kG1x4cgUS8
v5SDdEzxt6WTax3p0Z+UdeDcyBQD6qZD2MRGx6O+mLoFEOrtc1lgj0TJwvtRiqxTc9LIDeAV7Wy2
w7OmbkmlZD3VJD6EulhKW9vpNWLpKm5TxHMAnl2AdL7GPzu8ginQywy424o3MmavASHWVoQ+TZpD
hXC9MKXEKFSnlClji03ZzIY3YzkDMsRhqEOXZtRM4Ux+GLkZmo3s+d/gAaNVxc2C6FZYc8vnsJ6F
Za/tqpExFs9bmuqKUcrSnYiDrNruYEvxAVumOkupObLF/ZI74E3DdT+FAd7E0Un6lDUh0mmtMG25
TLolx+6pdiUXuPQIKVxjqqJRID/DqU2HkeS+LxBfJnX6QIDChBFA79XfQpXW+wMyScgPIg0c3+ro
qbZB6+9+xVJPtev9x2hr0xnyYQLMYWjeIbVLrn0e919dZUVA+eYvBSG8RM8cph0JrYU7W2uIaZgy
Yga70EoUBDES/xSQgVExklZBVwrEd6I3OoMwLEo3pDAP3VbYDUAgNzHI1oRyKEPhxOB7ROf2oBOC
3/3yMkadXly+xLrbhQb4O/MKwkbzDZ7hJRNeTbM8xu2EAkBQiYU2CO8gT+9ZRojHdX2dp2hyDko6
MJfrguGyRmsKLySxTrSGCP12roxcl7FlAiE+afs1Hkn/ZR8odrVq+rXQaCOwEwpRVz47Bf6nm+yE
l+Tt7HbJAQimzhVYxjLtObSbPUB5xQJfiWzJFuhq1TbT5TzGO6ZXRMiHh62X55fiK1V9yaidMCN6
ZdwhDRmFaFxTcRuVzQWViNGKpIzWKijucO1/ZO6AHUoE6a5bGr35yItzjUMnbDXt1qHkuNApcjcR
4iD2xLBjdtYPRIVV2jU5i9HzofyMnH4+G9WyCOy1thBqYN3IdNpfmh8TB4bIXRkYOt2UOtl/RlVY
xOZYwYyI4nBQRS1AoZN/L8+gZmhmWs3BpGR0oYPNOD2T4Xd+Mg6wfswm+Rr+VcV8l/1R3VxD4M6j
hSu/soCpbPKfaeQcaULrz9BoCEOx7JLp42SbHQheJD38JuD/PnWelrf6O2s7GOZ2GL0CLstjdKOQ
uC8sTKuaYEP4yR5a8iVRzCQZnPJc/yby+kmbnmiqCl0DjcHMY5JmWj28tgkGcK4i6rolqJN6K9IB
xT515xrpfNlRi4zAmSa3XTwibGwvyNXs5ZCpHWdj76MtbwPj3gDBb0o/9QAAaJaWM5JTHhwu3K0B
gMxDMOE9pao36GrIWnWUMixz+DUTWw8RR+Bu35oP7nzYJOCm/aw8fiPnYOHjDTVHCK5QM+7hMKqG
lPJsbwolvxip9gaVDy4RQ6wwPsP/zMcoKEZJHjdmbSwtW0KNZYfgPzCjiFPKlU+G256fPRS1coCi
ZF02YFapeQ1iWc0SUpDbLC1ewOG+lP/JikVSn/xa4iHxPxnEd+M2PVPIvasN7RimNbnRC4xDGjNr
bedTqBAqd/CXiKPxzAE3KUAMsyT4ZF1DzvwDwi6mWSHnklEbs9V8aabJ8XYvIBlraqdD8QR4ve3m
MMedim4xwqKDLyRH0YOQ6dvlmBSdR1EsNkMvq6rq4yLluIh6g9zeV9ET6Kth+IPuGwK86ab1QgE5
P2kSbXCb+8gn5Fw41I1U3D0j3bfDu7e07/wZn+5+EX/ku9WUSgT+e3myUgIDQg8cpGmS+RPwVQDo
zVvikTqBCBi1ecIeXDWdkssT3IevuewvJHTZowJI43tjOPnBfqWZgvllehlIAUjjmnsQFGrC8reR
Y5A0D5Hlf3adAyobeWZOvYnR6bM1FhYP/3+ya0drAaLpOaG4VfVGCwns/0f5Rkwstvd+S/jKZdU+
3uDqnGd3MVtLVAsNU7E++VzoZxL2wnNKO5ypVZ+f4xrwKM+R4xJT/JLNR9plV94tdUbojpXU/D+v
TpdmTZ64cgZnCX5sGFSD8/i8YZZnHu/dfllM9RWgPGPLOkRSB9wIlxPbNhajSXHA55Gw7Dbm6oIv
lO+MaqXHVTGcHBjAv99aATlIL+5EYQ3Ug4hjS+4Tm8LO3Cxhdt3x8Zv0c+c97USeddb85GoOYUmN
xHCdmFjG2oI0ElGEix/iO7a5E8223+qN+lfnSYLJiKpPw2At5i38x0HXhxJ/rNpjIG+m3vBKjPgA
F3QfMG5S2bkS3SvwJJ1Txx4R6M7rKyC1qqu3JX9t+2bd+x8dEipiG28an6G1szyuIQiBGkyrQXr1
aLVJD/71WWxusc1OAfX6+aGYD4TyrbjuzBmWghzTuhn1YjF+8xOgxH/qgKJ1Q5+Ht3WPKg1yDADe
AT1eqFjUj//tBPLTB78s0IHmSUxpjalvN4QOkidEqtC/wm7LKevvNf3PRTdhgwsusKNznuFHQVos
elGWos9IYyMqEKmTyXavnf/gyLymG75np/e12qlvy4GjX1a3vRAsJmxXp+xDIglcji0CwG10kmv1
KznllYIVS9/IQkgHViQhTnpQVCaXNGuY9PumcJiCsefyeuP7BTOiAIBXao+OKqXgp75Y1UrpX9/j
L3eqNAQqdr+Pdc/33ThH4w/1rt5BXcXooYyXAJ+IgVr7fZ9wNNo7uuMLpXpAaR2ORBCqF+txPZOT
/QnzyOftrQxESBaWMfvyx6nmhQXXVjC24jCqSSkbidFvsdxDhxJh3ZwtHcQYNxQP//xVzgkT5suq
3drWj/P+PeoPMpb+dWsQP5mI4u7krf8Q5NZH+degtGu7SeBApf0EvTeXDh1YW0Qu7OYYYI4Yol7s
6SdH+Z3WihMsaLw8PZjvaZMfjXe0mPi5HMi82LsXoKi+bHHXgzkDr1o1F9dGoFcVCQC5zzh+q8aI
oq03lS9IBkkOtVV1ZYmCQJSZO0TW9eii12Sapju2/cEKmCmoljq3nWXhMsYyhf8S1QJaPqt8aT/g
0dP6dna08y14PIttF4iBiNrMwNO/81Q5xf44fVD6igWhCbIuiBen7aVtiBUdhHQZytcnPdGKzvUI
W72RTzPlH/SFX4WLtnTC6JQJht6nOUrA1Uk/L8lwa9HpI2QV+4RADjRAqqGDzI/rbhS8cqUKW538
UbpvI4K9gpCuRJLq/xu0i6i5wxNdYNigCeAoAYdKPUSgxHFPmBrwkKdBBg/D2HT8SVb3rX/MSddC
VjxYoGVdMMGrPnTiBxPgBV7UoUB48FE0d5/g9S/8gYx00Y4m+D1GF7WCjzJwwJUsvTWEpnLyyVp7
aX10d7338I03+rQHoLgkhHhDwceAH29gDbA4IKH8c7U5/sFoH20heDl7dYh4CvxjR+9vYX4tx655
htCklNuOI0EhCSX6lUu0ADEabSN03jhdSukVbrzUktak1TuVAzkeGla4ZK7EcfQSb+bJf952qe73
CiLtB4oQG8EF85yJy25tcHOyp7TTKMSXCovCxf8CY7OA8KKiggGlZmaJragLJI/zmh73Z5gMy0Lx
bB86PdB2t4x5K0fKm8+2qW24uwlHoy/uFXDg7Qo2DqJmIGMadEyfTSC5JypI8x9vdZdn7Hk8qERJ
sSnKiLTrO/oIcxHw9vLDsM6DAmKprwSNlVg0Uq4ohkqznnqKV5p+BMza7I0TcakWI0PiF0tYsO6j
o/bIluB/P1ArrFqxDBHxI0KL8KWd/ZEU+qDu5TisbOjPpyjtZyyWLkjlDC7ZC5OSV265FzFBjvgy
bdILT49zbsysNzxWc4icT5F0mfN9RSYBIcka4octr4DhEf/5cHnCc3JNk9NMhdhN9MNolMEJLuSy
B7US19PQmUVWsmgQdfSqDkfCBxImg3gnLKkw+01vcTLp0WCDHoWToA/D3NOEhmpZSivCcSjVHgAN
tummPzcLVhzcm5AFP99heH3aPLU958uIhcjBWkqJIuybxfj0WjA+CXYgGmi+JHABu7sESPV20LVA
hAAmMYPqJDvw1TOw9/V5JkEFYIAZY6cGyYiX/WIUcyXNvo6c6WDCXJ1KuhAUuXLhG/hmGvJf4wVX
gbHKyeiEmus+DrkSp0iA2EPEMRa2TJmTDHqML++nb4fFTfgp5tUqg1ub7AlPqE5o9uhysPqp89QK
pB+0jOuve01Fa9gW6IyJt2g9gdkV+nohs7Ca5RtWWTK+NY1qDZopjagIIXncc9fXBPu/JUjwGadl
P8X0cUn21TCo2/nlsy8epnKrQp1Y8H+lyYTE6TOx+3evyDVfpokU4PEdujPG+Th2sD1FjkeU35u3
+GkVl80DQqZ6n4WRLGItM6f5P18TjMIo0lmBUbrffvyUAqg+Joi6vKfH/Ppl3FbIOWQfRPFAUWMN
dXf29MxbsBn78KmZpLYT5hFZ/ny5AwHchwL1PICYecz7ot037oXEmXAE7vRR+oj9MunWKWqsskaK
cnHO3kv3aMXLjPvMhHNYpYOfrCJlaUTfzHcXaU15oKNO4yH5/PV8oWepfUur6kFtBTOQaWnp0OIw
pq1zKxWRqPP96hBIFswM61sc4LpXxVxvc2YLGQ62zntUQFHocP7XqRyHUIoMuPIM/TFJCFq1Wqa9
UXS+7f7HujKpl6/pO1bdQ810gzHPwEIIOIV8fWNej9G2ekd9PcQ1gTlR5hwOfPPOV5sI4ymzPleh
jkoPReu0EDeDcdnXzf0KWQc4zokZiVeNaDK9jZDNpQzCzp+yqOJiahiPX/IMq038NW7ZJyUGqr6H
2+sEpZpRvXRWeyssStdc3j2PRRjOTa1Tk+zhMADlAvZiZk5Ti8mUx0ZFNU6zoolNWKHPE1rrsZ/z
MJcJSIeRcEvb3BELYQdzEQh21D5coQGH9iS6pQ03ZsbEWy1OUq8XYK5yecSZaVnxToScQ3hdqo3T
+rFaMdtCPDhm0b44NtqulFJDioDwuoYyMrc5d9ixI1nJM78juFZsx0aONjIS7Y5JkWEvG8tVMH3y
2TM0nPvaEUoT749DdooDfLgQVO/9aVjFC0PTfD47dGhj5vVz2Q5sBve0wb+ybQ9DJTHaQkFYc0KM
Xnyh6GguZ3zzBHLL/vUhFZHVTUakcPdJFKowNWbsNXO30WoxpxA1h0bffL5BvnZp6xeY2jXbFlba
hpUe571CB/qhgeh7ohrhsoabIG7nPUShV0bMAssO3bN5jTYmdBSDbG2E/Px4YoQbObyXfh6IMOS5
UnFutaEsqIwXtOsqR38b+OTND8LEvUJo3Bk2TPoKa7cXDN+bq0fmhtYmTh1Vkiu+okgDyocfBcBM
ZzOH+hldcZqcNFqwpq3+bnP7LLt/ALIviOtDS+5iMbu99+EMuhe+dYF/r7+87uUwAC9Z6913Bfl3
qJ1aIBz3UQEdgGJUw8n7eD+VJuN+n9Kg1oOUfYtve5UEAbnK+zERUDqdiHmGEtzSHb6ziwQCGx9R
GQMMQV716Llu4u0cqPUKN7jAtH/Qbi4TxODjLH/AvCs6tjkQEYMRurlrbQY4/s7MwrgerdFgPY/f
rG5QZ4JE2FbvQ/iSe6m3THYhFHEcxsGqRbIG1xhMbNGW/5ZxgS73oS4tpfxlLlflIX7ss3L+mBjD
ZpioINEXnYd54ZZvDHk49qR6Jy0x0DIwky/3JqHIE6zxvJNAp6lW4Fb3r8bro6Bcpc8X9A9zVAIj
RnS1Mo3JzLWcOLc1w6viMX2VpYZYwZYUjaSR6+xyM8z2dySKuXorN5fPTFSQsZVilEn3PqxlLr1N
u/qVzx7ufVxg6KhHewtlugX+T8ZJVXMlATp+aOkeLEZ95xBaOHIBiuhxGU04bqU+hidYvg66Z5dX
CS0udfW4nnz1wilGiCnkQkEYvzkfDqz+sMPjZH+PHREdslqyA0yqVfDMU3RZ4TVxQ3hkYusLOwM2
fd4K5//+QDj8q2R1TAWH3KbXkKFjlOlaTePSF0UoY2r6kai/e5j6cu04J7IXpCSmZDSR7RpL/pmN
zUSnj6jgmR5KPh3Lbpi8NWPulc+mYtzusx9pQAvhOwux4Z//Qi3gVALpYEk/jwp1LI3HeE/tGamN
qCI0aKyExzfsbFsU5cowpzPe1LhaiKFuYabtN7zx4FkVVe/bG26DawttdJW9LWoI/8VeY/3sHYGr
Cg8PKUJr5K5BTX3eKIm7r1zKjRyjBi7zN4ACQ+G1P8c6EBAOO4F1hMoqhSGlYKE4GTBlaq1du9jj
FhHSvBNQWqCU5RAzbsST/cEQO7UlhTbWQud9rzI8UjnP//QBnIk/l7DJtu1LijlsH0RttqxQAZn0
vGgPZkWusN/OSCnIJZaobi9WZL3Pm4bO0HlZVqPqljSzd8asYY0imfwSeXe/iIIr0xr1oCCXvd00
r92auUARtxpY9YSWkOJMnhocVJzTHBLKa6PcKMDfgeWeE7WmLFtTRea/cFzeY2auCd6KvL9IUtc6
WF5uXuLky2OduNBypT2NbkXvD+EA9vwpgkN0M876s4ahG3JzVXdd5g3K2lS9BT5+c17v0jk5L/Zn
637nWqq63ksGhlk/PNcT/wNBMrdyuPBOma/yyx2W10sOWznLPnPE1pOhYFm8aoFSwH4LkwQVf6Lh
QtJ1XXTAQ6MdfLP3X2b0H+OwE+93+Ll1zmCyI9/4JbKkNbjc4NWCX6oO2JyKqfBERmdaHD/qlfym
77bED36dXfUTXwEs3lGpoa5T5hIBFVcDtEMgROsgeWMWjNbmkszLvkWDpRkHUe9lsz4J4zNxZR67
uf4GbcvwzvVUUApNA56fJU+IRYpYxu2zdfMgwq3jTNFCf4gYa8CK3PoNSsEhAcbBfXWcOInQQdsX
ehhCtyQ0Ugkg8UI5GqNtp2e5/HBjmqrs56zVVgiu33YAqWDI6MJLzwbMGnbpgfW7nFchgkUNYcUZ
J+K7P7A2RFI2m/QfmlgXgqzuxxfEDDRufOUxbdbFNhV5DdbhXOclwDDsJA85kBm+3a3A4NgYlMPM
fCF86IIzWvH/5JZt0XNpMr6dFVteGjZgxMgMBJsbw8gUbvoJ9egWP84eML2q4lG7gl9twwvIBkA8
XktOLJSAH7JGV2swDFJLx446EH3hpNH4gq16gf01HiK/QGFdklfwinV7LzidD3rNN9X5QBm7XO+9
iirn0HwEfJzXHZxXMxtEP47otF56cqbDi2/CAIUKNj8l1zUJv988MxO0ViPu99XDhGXtMoBQhmUl
OWLxWqyOESuF9O4eBVgVE9fEKG0fAzhWqG9zi+SVP72DTSegptVPKFBB0nZgGxWL0vzmdWILdS89
looKZfpVQRKGB/6z2egVKvuHn3t15cWqx8HD73VkdM/GK9J4L3vObkFNPLq43qEBC9JWPyhlO0eb
Hj+P6pCrmFdDfxUmJdz7VvlAGHAzICqcxv1otg3qmLRG1MOhVcXkNhm87N28CcKdnS2fGxo4Zvur
0KAyLzTdu3fsPl2S6dm+Gzn1xgxvqATqpxaqN1AlV/Wu59f+O8t8VERUlGgzGyJJmm3IDzI+kdNN
ATp4PytIwF5Mry1oRYCqR4nDK4uY7IVPuHpc32vD8nXPKTHnFcneA+PCAmzOyX24kiplDgAYtEKY
CuXaJk1g/82VsnRyegne1IGW0LeH1O/GozTnXeu7xQ3mIg0HbH3T6jQI+B6UdHl2FJO7g+VtDOZS
4xQD7IKp+qrFQVkQ5hTdv8a96QrgCtLl29LtVe9SRTMLkzGZRjx0sBJvBjMK+PCQzSy3wPj0E6+O
33T2M/PDX8ngAu5e7q8SzwdtBLEzga3cf2T2cEbPrywtxyXdcCGnP5ZJAN4f+WqzUtN/k9IDFHhA
sMT0AI9haraMKv6XteHN4YY4e+3NDcqWI1wxxAufzhFSlkcUupG/FbkASLhaUh5WJVX1DqN8hYMi
Y5sI/BoIky39AguPyvPEyZLYiYyByP1o4jQVlxvo0lfbz4qtYxCemw1dtichHLLpx39qx9iqWxPq
1qnkd7ZgAIcVEyHGkit0Qp7cNvazs/kQDeziZkj7KanIw54byiiTcNpKRsnd1khmQNfBu3VJ7++Z
4CiBRKAOkMZ76eRfzhzCgxygus/kinHch+zmJ3ap6jf+zMWh7P7Xu5emiJ990TloPnkhx/ZXMZWv
IMw7KDLaTyJzmxRfE5SST2b3JfTEhVKgNVALJU4WOOAzRfq7VDUZayswvzVjWjLEPd0aVyW1+sEb
Q5wSggYkLyRSIe87hUk7kEC1uDQNVG5mVltU45fgjradwmaqcUcALalMVI0WTxl/fVSMxjWK/03x
CPYXrkgsSLc37Zhf47LTJC6QhdKwnrAUb2zgObiFjeRUuKux5U9hfI4VYkXlhd3HLO77n6TXV3fD
NgXLMPHkZCvzCT+hYHxb5MEBzciUad9ZnwPmIB258se8ecJvgIeB3h3qVwcJWrz0qI2X58HOXtEC
RFU0CVYdijNweFHM/wHJ+uslnmCIpiYXq/QoNyVTKBUetrkY1r5UsCy0xGKlFYLQhqzhpcURYDL3
Ofc/P40xwY7WvuEjgBsdDYgsljlHlS3RP3jSulNe0Ce1stVcdlc61abnwqcLASubWe2OT0PQ+JlR
P7nZI6UbmyMM2NpX7ZnDyUFWCTCEPbA5Q7Yb3pf4+w08TSO6FmX0bX079NhWYHRehrb3wvmjvuLe
jTdesSKbQe95cWkh1qIELANYyJJKnbGOJifJidvjoiLLezo+qpGUEKNElJAJo0zxKTE0wVC4r4P8
GrRBPc83LLV6Ixw5t8gZwJapx/ozE/mtW6hbQr7/NmoNo4ZR8rjUxscg5jh4pUui+b5ewpap5PqQ
4HvbmTjCeYQ+dGC6dqaTOjswEj6sY/IxotAQ3jl+jVLKl0ttDvGJZZV4lP4U/JNY71daJ1LjPNnR
isNAyGPMkZREQ5tVs/2MPnAwpnCFihsmr3sFBRJz0yCEfo0loJ810vAV106Kmxk4kq1dQ9Fzl8c6
80z74XWiBi6T8FMbTPILIqW9BIgr1Tf3RcluNvUSs4nLd9/kXhlI7KGpVtaOd+yT8U6kIz3HFeZU
m0HcfzdGOne56IVGEHKZ9ekj77Ot0SyX8X4jsfr2iCH8kUn0pqDqMnBZeFA9Lfv0HN6p6sWlmvUk
kHhjKW1pCB2ALMBIo4MYTSvRa0XUYngsqn/kS6J8polOogDWxPbQ92z3udlrsW4pP5QvhWTuscQm
shbb5qlRDBP+xWrFllgSr8cwSVH8GfJZaNxn1rEgDzIkCdaQF2JWfk5s10ZoEB5tKwioQD4PENBH
blLXeSSsICIQC0EUOz59kzLr5tufNQ1OAbsnZSXbnqC8U4xQocUhPvxywjixE1iCGd6Ibj8IQ6bj
bAxmOPnT4BVrN5A6G31D/xfMBunRvsIomYabLP1rdn+y8Duq4PhxKppxgYE+A1wJlPgP8yiNgvPr
ieMVyHUiGo33hW1BUpu2oCA4AvwY/dqynVO2ZQ0whY56InnI3Q4/crhR+8+6l1uDwamjd7kQi6rG
QLP9gvGrifjcaM47R27pI1ym3Udi6B+U7WalF635VbdbOHe9cEbQ6HTN7Lgy6ZDX/NV2z2+aWxa3
wOemkhbxXjQj5AunxxmcNEqmcqv9UZWxoeWehabBAru3tmM7GIKELdmzk+sPp6QR4TwUgUT6VTHy
nO03rQttSvqVq2KvvAmX4MyNRn4t69+5avYcP/TN533daujd3/CvKlZxdJFImxpA6cK7I0NI79mo
KorTdxgYh0e8yozIu/zj7r0hrLs01bZ+4aCO4W8atxInuAXWIf60Rnaan1xFXDA08b1JIkjSF3pC
c3cAdIooYZpXb4kx6HsnscMVvA1vvBQCa2qhQYddBAr6Gplb2fHZxV6kE/UdPdlN9MUmYECD3RE4
itoE6U08/d83TEIWsusMeMEcR0xl82kZT91rIBrZsSUJt1H4eZsoj7N5RZLkxsB3agEFfy4fGRpX
cOwKZ4+Uzg8knUw0ZTFUxz3FW7lpcyRjrPt1RZciLjQTo97WPMTgjYbKE7XEBXqO5JvszNptyjju
6MV5erCLOCk7oeEJlget1dYi+2B6IddWSGLu79zUUwTT3ea1eiFvo3L7fHztDvYr8Jl3dXBRwier
bEWhIixkV3vcRakBULIX2OODsOV+6fwqNzwkuBXQCvGTgGkR8ZRSeYNZXaqGq9FA8hOcMzQhY6di
3IyDgfFiCga6LlUhkb+4RbwvtuugQi3VOtAdWN06/7KYJ/TCWH/GtEiZl7KglZqrgdsJ8Io2hfiD
tg19NgTa8r0MYPeb088nLDVv2g06r5sAA2YT3Y5N+D5OFPxr6ZoP80jnCriJtvXQiK4c89kuxIgG
0QYgfPPTWy+MnXiDvfQzhpiLbAMbhkL96J3fZTn0jPbA1sGBzGj8OwdqqIT1L7k2NLxbwYRuagHo
3XjTST8iq7DPQkjUWFiG/vyZM+hSbR3aCdCu1Z5VpW43KkRDQudaYVtv9vJDSquA3+8kQKBWk0fH
HboAdPVUPE5xjMuaDmDuJQf4WBxaIpdOIJ9K7IcKL+yPOpDG5kc/rnjULnyx4IKjuWnYpAn4QbcG
mgQGNRmD1b3yvyOS/QykiMPsMhJyyknKXEetR252q9o5LHWy8MZntRGLnRXi3//W+kdB6H6SxSc/
yq9PrDzvWJeLJLTfAtgisMsSaMfKsavn17kvv2OG5zYfdeowQXqRjK8O3aT8bNCrP1/v4wjA/mde
Oc6pFWRleF2LbjWZc3nibCoomV/gGGtgDZBQ+VesGb0s3qSzhopkQg98PCv42noWx6w6AQKoyWWS
l0lgeQ+nHx1GaXda5/G9Ne45Y3M5nQyIMT4Tmkh6hKdHT+sU4qkr5HfryU/ZwW4UxCn3PAIl0hYl
oFR6WUnuTUDmsk0yCwQ9C4nVj8fglqdLzeECi8SdXIZJoywUWGENtrs7MmBf12p8Wly2ahgHrPZY
cO/Et0awazt5pGHflgvcw1mVcCs1ExlXtof/ztAaHZn8ARzuHpmF/J5mFnKI6kuaRKkKoJryRy9c
XdELro4vGEZZr2aaQCV7/K2HwgWgYCq5/fEJlamJsjOeYChi6YTucCarHJjfdX/MN1TjcI5iM61C
CYRV3Lvaf5vToFq6dx1Qauk8+4O315JFlagTG9ARfhDa57Hg6xVO4YjVCBuZPLuLt+Hfe3IEybcC
Ybqkrnqo01EhqNhIGGn7KLBgheAteMx/tmo3NJ9bNkrPMQlW93ykz1MSV1AgTar02T+F5+3nGymz
yKGWEfpZqSM2YMZOmgoGHQ8eA0sH3nEDEzSkmqQ4Boe8MpdMuhT/A4DaPjMO/e0Bh8uyUd/cTB6G
Fd6B1efEUUSBBhPf9ySbQBu5yvzXpvaGqfivCLOXXTnYjxfWYx2ElTkYSv+/zp6NyNEuATHRJ8on
AYgwE/mV0hZpSGxTU3uyikIAw0n+3RXYiGhpaPNTj+6BJSeE8/1ByjgxAQSMndHcmNKE+uZpA/+t
xrJoBUQFGc9aF+gwMecK05PkGa8nN+N1S08cDqQA/h+KXAaX7Mqb1T4lhCSiIXLMCriOAowehvGO
MfWc+bda6k/lFZz3Na+SHowCdlfB5xNNkdAJrOshUvuWwI8q5LFxjvDSCt/Gx2ZnOMTioSvnWDjj
wgfeXUiVzZ8m/PeEokGzQ49VO1b34yPwTqk4jW9qo0sAhr38Y+6uuhPBeaf0Q46byCHbhMZFQB+X
wzw18XQ1JyUsHyYecx8sZPjuressuTREFrIrJTtS0devHn5HB0urCapBTC4NbK/NmOmQaI+12MJu
fbC7HMyn+u+C4DG0YHIIxCyLgtZng1Aia2ibJc9O0dSw5oTQeXZaM5K5XrT7a8mHj/+nbqLbqJ89
ZhbqJSOvp8NFa6Qrzg6+W9yZfAk+sGV8LIDQSBX6Y4ML8iqE3QgF85AC/74WZGapNchPj2QruAsK
5r9S+3qeKYcJgMHPiJItSnpdNNlpqnN2I7bLNJ49RBDxw/N0lKqZwG7XL+axKcQjKNUtQPLwYAYh
5nv8vu9OhPgkBFGiK265wXB9PAUmrXxzjtYAWwpAXn2exgPPBWbHdgzbjhcGCQi1AkWyKPw1Hmza
i76N6Tcgq/nvTZUn4X45M2AHmX8L8rJIjfAeVHvYPFJOLDjtWHv9m4A04y1W2LaKsfEfpRL6OEb3
mPbOs7x6g6CHlyZdOoJHNctmMP2iYjAnc7kJaHj/gNoo1kw9whlY6PXYW7gW64L+qupKJoucFbi4
4U6jhb4lJMpgjnpudPoQ3C6Lxum20YCM7Sbex++gKsAjnTgby46hoEmHWeD8vgK8zlY0OfNV2BkN
gts+QUVd9fCq9Ccmbj5e7bv1zuVlQC36aQVMOdsKLEqFcG2lMhRzwuLWrLl997yPKZ4CBEcQUWJ7
MDxsLrnEkYD3rrOtJOULouil6IlC+NhYRGAdoklD+evOa+OjGsVdH0iTpDzjLvgfuABEDLguUVki
BcxPEapQcTmq3c22iAdWyrONUgzH8jUlO6laoDu5mS/RNMBkpr0fg5RPU1GzR4lDrNJ9VaEzMxFv
OJPXbqyJ9Sxb6JWamcoBk7x7W5T+PwXBIJucxj6UU+bE0EUg2jt9p8CKjrwuBRqZHhVToNiSHNkc
+Oa9/5A6b0S2pPTGavxwcOYaDSEMYCkix6yeXQ/dEhoxo4LG2iIrrvglIwhHj7Hx8eySZKNxZ03Y
idiFGbIx81DS4C8E6t5Gi57hPOa9GyBod9ZUCY5FwEryjM4ke7JAFkKk5HXIGlcymQRWdplTeuG7
UryBK6gpkT7rmq5/0Q5YoQCA7RJb+BscT9vHbaD/26F/BM6MVYoys3g3JxJo4fV0E2byGcWHdA50
NzBh7QPK26+hTiqvMoJ2GekVXpdUpgK5I520f4SJlNxDmyRRQMbbD8o/8EN3o09ZxwLvlt9RM20g
21EOoPxUEnooXUD36j0JAfjB7q7n5HMZ7oejIHzuH69U2tgaWHhg/d3oYpmpMjuMlYt4SBuG59/e
7UANaz7VU3kDVQOowdt86P/cn6vjfazEBjnNcumKsKV+5aMEVUgru9zr4vWB+BMF9GJ237NsJfK/
xqc1koUQ5zZtQedmjf6+z7xeJmhKjLuWRSnCGE/SpwE5QYd80amltdXqKzdJP0RMbEzUER/KZax6
Oi77DGfMiI87GscX2JYPm9Az/ju9BoPkQcUxMX7T/Ygvkzyc0M3fwPu84xwxLECbXpRCEYO1zTvA
D1uflYaCrDnAN3jWLdf3D4YfGRuhgMZwHRB6YFfiKkj/G1y8ZaMfITnz144l38beu3E0lSdNa3+m
apGFS/9S3BxfbWNHkEIEiOJ9wDwRgSFfYeGTbvXGkDei+qzkedCKLSX4rASc3NjC44uwNdHj4t1U
ZbZhtWc0v4l2sFBv9aPnwEoAWBuKyGTNaoGnHIVF8sRkuZp791mUCJTkj2VRQDpG+/qkxqvRySid
f4ObA5kVW+mUAVlYKVWq9+tvAFjiTcfFsD1L4gCAuCwWg7NBb8M4SeH50HebSp30B8c78zcENR5K
/58TXT2FFydnoVmF09MOzaqsfVGkSYK+8GoJeQB2koCG50pVMtNQauT+8zUd1wBlNSbVLGFUXA1U
0uSi5sohp/8dHuMmkeShzAvRYnNLFFW7DGpOwynxy7H+5JbxzrEzu9SxrHUKhis50CT2Nbe9G3C6
shwMq2tKVI6LMEMXutadBwB6qL7bq0QIUaQhA+RBegTLfh67DVV7P8eXc72JVtemfw1RsMGYliTO
veI2el5o5ulvtxtGQCNiAj3TK+B5nKzDd8b3WbRF236l6P8rNXR4K+u6AJqBdZhg0I84jQvyclC2
8qysci3HQw07xgzB+6KqzheGAZp6zXtRjOlOPYkoDF3MKlIY4G6EDckbn/8X+EvZPsqPzvASoK7B
BjssUM9CIp+I+THRvO0g7ouPfsXc0faVDWXsS/suw4IjmitYKhVZEQfwB6iAwtsN/DF6RYwVXCJC
4YD9gVD4nR/YdPyJ9azWYYvFS26soT3saOQXBtgjg5yBi8GDnvA1H4MCP/P+W2aYxfsSsD6NgUhO
vgsJjPP1ImlZ+dw+eAL5DkjDSNvadEJrJ5qAMrtgv5Wz0C1SaK7mPdMkohlZYofEu8yUhR5GTPmu
TLscCDhrvwNqNL1IMatezYyGWelvCceiJiGwHsV4XLjD/4BV3EvmjbbehrI+8RzRgcHIqg8iK+m5
ht0aJwaw3Hcpmsh+ya7c8vXFSdZ2kRqwn7jjjKPoxjNcUdpDXuHMOyO5NeUfsTI2ad5L/2LsKcNb
eilILFKTeODUTNQKoNtwfE/5wmE3cjaLqTe4uQIrJjtjkw4+40Wj1In563guy2Yq2T9wESE2dD1k
s1CFoirI63QpuwlLp/pAeb6+3WreP3SLherxhDPb28cGBt/sYXexu/lSuuyEozmuwZ6mZelS40CH
AidaM/lBzfmh/npS1V4iOpXOun+gMLAKhnX6NedjVUkJWQtL5Apu5JexMoQdV5DWnkd61kqb0+wW
eme9jI+EsqnKUwgXG4gn3rIvlxIiWKtj7Wq9UERZf625xJcuDe9sim1vqJ89c7IwPoHoReilbjkL
xj+10f0yqlmz+XiHYNk6WVVYepgKvTM14qMRENbo20VhDUSVAvs8e0++Gx58sWMRcr3UGI5Gcg9p
2XKi3GetZ0sCT+qhBSj2rNQuSC0wssrPJGI2jYQ3sxTBhYT/z6B2iNYpv52cm3fJri0weZlC3mG4
/cQ+XBw6pvZqMw0Rn+mI00AUD/DrhhdFpPynFnXicsOgpIewPkvU4rAvrnoxvgaX/rLlPE38klt9
TWCYybqRmACal7nH3maczTqnGAaUVbPqpDQLjCWkqZbk9Yj4tNRZUwilqzqidHElEqFKx4cCi6pb
wgoqnhKAXPJ5ZZajE5Aw7kNB0+DXlw+xbE1N+rLXztVW73voVfGGtX6JoHo5oe+yVlp97+iCPKG5
3B2IpJyucI6P1Fk1fz96gv5rNPHTncmDg2FRjBx1MM92XTK7FCZicsZE6jeucD1cAllk/XolAo+0
qrhLUOL+sagWWMktpQ9Jyta4Hz5pdqRE7pfXoK90vATgvW+TnAPtp37SlNaiLC5O+j7yTwAsVGcG
AUB6dw5y9hdAudjdVuqbGm1o1Q5o7xim6XL6Qsuf/ryd0xkXLsY6oohaTgYkgzeNBg2kK95L1IiP
WPfuhZrJDAPIXaedGrfyw3d/BteIA7SZfPV6am38eGLNsHGCwKkBlvHbZH7tiMY4JB19hzKJ2gKF
RpAA5z67955I+PJ0r8l/dLz0NpndhWmX2gNaevCARczacHV0hbzMzZvlMtsAD/A6JApIUTTNT6Oq
4uzoYaFQZyubHJNCFZU8C8+ZwMxWOpk3ZAGmyyciU4bBOzNVTwL8Lr5QjrIkYPRlhE28nBaR8G2p
Ksd9Jd02Zxlndue4z4qRBqwS+61Ytal0DOJbO9bmyNE7LuXhv+rspFklKFFeRTnjEuL2426Dmj8H
zDT+R9A+qMmVGp/Q6W8g8F0Eh56iBcOScvo4bWVm7zvPWzNM6R/Q9WOdvC2/GSrtrSSFJsRS7qJk
l/I7O6mvOthiFJTb2lW1PX1KDoN6Tnm6csVcViH4f0QBxVvqWYe/5JWlXWOmtGpJm6XzseM4SkYp
Jsz202A1DUL1h4TmAXcnJQ7gcQNOfUF1R2bWyZL26CYrOckAKkDEHMEdoi7A+HoCicOX7zRxEguH
u0wW4Nu+tIUYd+KmpirknTjbOhiy13p3uSJLCLiDnxxtg9X9FvDfsEa2wS7LB6Y20DGSol1zTIQK
sE188LXPLH1ze2k/Xy3JeyoJPfzCg56u3EN6lVXVETnizHu/MH9JwmJ0l03OkarEznb2ln3EdmGZ
0ujrPKSXyvcG9Nm3kxZxiWnAdKHi0XKXW04/iYpbo4zBhcwQ7v80bjFEbCUJlyRvDq7uHS+rSeY2
9x5dDOKL6/fFFsIRlFtNqcPXPiVKst7J0Oafma06r+bcRxPDHt2BofEEeEJE1nr8hokkcA7oMFdZ
8t/ihS1iBti/1f5Pyj58HNOIdyH9TAVH+PMQfEl9nV9p3xaKcYsP/EH5Zx1kgNnoc/If8WlqjEet
DaeI7NX0sTQw/x5qPkYKxyOTQdWkjNGrgggdyhtJ3WN+P6HywF6HdqAOutPzGrguG+yGKg+k5hqL
/KAIiixFxAEpPDPIkycA1EiLMsgS9bO5L38NwNY96WHKODkmXu/USIOTDjPV1n12SzzVhOZb58Ah
0JT/ynSOCwMNToh/OJx/pOobgwgTCCs5nrkclSa4Qt4Yct6oM9Fi6y8T3VIlFtDBapWI455HDi+x
53LX0Hf/DPLD+hURZ31PrNXXtVqug/uXG6n4KVyMhxODbcSz0s1/iqlF8MhOPvO06x6zWsFaz45N
g2FV+1ymNVHn9mNkllkqVlROURm0wQ7ca9S017amPzYVavnVQytYhaCMTbvr0qf3+uC3dwdxJXtu
mbhfZGuX8ijIKHI71lpWKHiGVwcKcdYlopKTgGIq3iZPorX3rZdhAMktKaSknNTgH8Vi4uDDkPT/
D1Ja2KV1NbLCJFFUjbfp28WXBHtV7a+iSejRrWn7LueOKobMsSUZ77qv/lSPkzumvxYYKT1usDBE
d11JFrR3sDn8LOSzZ7R6rFBlbf3qqyzEJ2SuXbh4nkxIKC69xD8ZPwJVZAww7w9MrkfYM69/MzQZ
3RtAeulb5AXImOYeMo0VRVcEhDb6rXlpZRKTI+kVK06AjsvlL/YhhnKm8zv1d3TjDbZZ+EMsfusU
P6IfEl8gdgDSLoO4n4eugJHBR3onBfMB7kEXyuLGeiDQLfc9O8+Xbe/NGy4f4ZrCzt97USP0+V8I
7qnQLEnB2rM92zoKSnm3/7I81SgO06ZBKJS7azWrv5hk7abyjiKrwoN2D+E3x8LF54FvYpMmI/YR
YF6yiJ8D4llT0AVJ+LFxiE8duobkNl/5nxyDwIoShnJkQ1IIgy+Gtm+U+ngK2KkLc20cql3uH6I9
iBSSloC8nEHQ/sOOxFqIE4d/n/xiucoQnUMvuc28kkogTgQRnpIUned+gc7BfBS/6DWAd+HcGbuL
iX1fuy5MNWcZyvAlvkjpI5yKI0j7jIT1RhS+zdVN2/pKWy16eWEXfJClffQBfXeVZ66htov9Pir8
f+CUMwnAjkNOV8hB+srevDIqrw+DPq5yNpgRnSmtob/xtHK1iWlUG9bHlC9zzlwX9sfEjL94r/R1
4N+6MmBi9Qj/EUdEcTFyDXX+rcUs8yXeaNUpl+d88F7SyBCAQeXtXlzfvTkUvjikQX2jbMoqnTIb
0Jzr/hkO4Das6XD9KgMYRYO6xxhXlO1rv0POLl3+85ZO+3QqCgbVyHbtuJyeBb3/c9nyQ8cOzRSC
nOkVSTkZ0Sf62qysxUx1I86JK1d9uH+7n+z3BPAFEV5ZeX/khWTSxre5Q0l5hQJxbXX+1Tp+X3ZJ
GwVyr11nM7E2anjY2qBSYpUp32JZqfLFhFvkbBQ+whm+tprktEFBphq5IzIlHqOLx1Oq3fqDByp4
emG3F2fK3mRk/YMC87cruLODtJjYidTHbwVUP0GgCslqXUbHWV9MvZzdastQqTyxLzyAm4AGU8H8
H9Z0DTorFPyazByTJBEAhxoJmmCyv27DuHFVJmB15lor8+JMjtvFX8iUa2Tv13zapKXuaj3BAH6/
fFuT+y6Ynga75dWJiy6VjOxya5/jqBAouaIoZhjIlv/mdwkc65+0gGMuNHLJJKdwN7KuYega52Jq
/YQInnnpzDcHmIoxSZf4mB9RzWCSv70GZBpA6Hpeu3YhWTNBU6xMpmuM4wL4E+K4B8y756Px2Ycf
/XfgeVJZUAzSufMx5/GL6yWF/xI+JkUVxrf8qJS56vF44jKOuxasm4Crr27YwfvmYzfp/51QecVg
JO2SpWMK2fj9UkLGFQVNMDz5jKk7B3FtcoZNCMreNpEoVtWNQrAkXaflUIXfZwPRhiChTjGZLmqg
uZptzDiLKCkyTTHiQJ21IIIYsu13pxCtWHbq+7TqhYRu2e94rK3OMoIlnGeIBxdsAgaY96NSseVN
rcqzXQFxdEoDu9R2d7jNCK/g/pVwYpTzRT/dBevXZNppoD3iM0FLS99EuE1BGV0+zmPyz4KprCws
fNIJfgcv2Wt2r5aDodC05BC1+tT1v3FaNnBY41cYRCrIZ4v9Hc2tVaE2N6oZz1XOvjIrJuiDPL5d
wuZvRTGiXvE45C9m23ZcrSPVjjvifrxbysrWpVpZs+kHLAs+ycf9X15lUloJLD0H1YRH+2FhJ9mA
x/zcSemkjYSPEYzZWyUlEmdR0j0x8yyUq7JrE67B2JYawTiuXCXf+QqYuijiJz+MMNjCv6dYWpuw
WKd9gUhFDMvRBhryZZPNwAQOvCwJnGjpAqRIwUvxTAMGQJmvW96rf3BqorP4GoY849ycVtbl8YrF
4pB1rxJcPpkOZxa5vY3t1YliAgliZdhiw5BvYB6EAAjliu3RzTY/dg70jQgvxLs7xIW5960CuPco
1c7YFluFYOGwdld79CsZv8g0d76nLsFJsB9T48xWAkD0xE+g0Z30Nv9zPfA4zyqiNFBpTPJF9m0t
yKr9Wpo3D/nW1kzxrUHSYwnb8Y9ZuWzKQyp0+m9xXEcgXEOmsTSAmzxP99fMGPQ0QRVSQe3Hvcku
tHxNvlbyV5egf/wK04HucSTJWzVbAyvZsw5n6FAsVzYPsGUtJo3zkcISCLhiOuFbBdSnxGruQlJZ
rAxYrAmxUj2XmUKoHE2l53nmNja2ACHpfwjUIyhWw9/yC8zMMbu/cMjtsJxIcMWRjPRuPxSqlw2a
0pQwZIWDJPc7ihqtvjDMHjX9EGEeOEDaN+gPmNMHBg9do7usHijdisvdeY8fee2dqzGsiD51QsC4
DTKUgtoOa3Z/9O4ce5GUg/o03PqLfWovErPCeb7ODPOTaXzbWgt1lBSUgQwKgdMhp+P41tLxmKtO
Ixzbr/17ApNnSn9ww9l/Lzxfe2LVyLbbuD1dMPfOxWR3uMKPNmrfxDXnGsH+/s0tJS2+YhVs1+2l
SuTqEUzxyKWThEQHmkuCDE09wJHnQdmF7YR8ol/QsX1g6b7G20m0MPL74Y9/7g4UjQP5Lvquyo9j
I88LYZoy1CtcvJ+YRLMPV6NdctpuT2ZBDvmeRcqfJinc6cNLYEs+HLQUvqagWHh0VRAuaemnhnhB
XH6VLuPSHe2CLm4o2WvlxQlvl4ntTNb7lDQOd8jVfdgjVF9og8cLzihZSQqy4PSTiYYrGg0MSsbm
0M7n2aSSjmDx1abNueriEq/ht2n3EVKqKo3AZSCWhLo0xAztUnubhsOtEidZNQyurN1igp3tgSr6
UazHsEURUJyVtzBmRIhPTbbTt9v+wWJpggQfkGqyZDwLeMB4ueR0+RH49Q5i3JWfHIcC3PdCq+eF
yqWCoWukZoiD/smOblVwxd/ILERMnxsDXLXl4RXpNNOLrDY9mS5QYDUPqXKiAezI5diVEFztQb4B
pI6c8o1zdHVPEKBTY3Tmxq1drXRAYXwkwSbuGC9Z01IXpuyWGFZenYTngPCll2U0KBu34EUnvIkH
VJUB49Xg5baEGe7jbxOp0S8PR+Xp8+xdCwDUdzoKhnGDvWKd1zfH3AvpqoySzqYJrlVQsv+Yu6fZ
jboLqq35nZOGp2NZXjkUj8OXt33h8paWkap3NdiPUFT6gzzmYijsq8+oLqOjh+1ylg1TCTTWc+xG
rKZxHJk6lP5fSZpEwn16MPbXlnUYTPbbNRb/t9yKA3MMDAgd8d++yFuiVop/jBLwmlgkWykO9eBn
KskU6R4oEC3FcNsyrkpH4pukW1vhWtV7kp8LFjRxYdEPjHncDxUtMFJ/liZ/VCDv5KuAJE3qJacS
m2GeyCucM3h1fZp6QpbQbSW/tD06HE1Ct0pIRnf1ljslb+BlaTWQO+eeZikMHQms1wEr1Kf86mxR
YDiJqyC9EiYbC3hSw9YHENDOfCrqhrhpMnYOTLOe6vlzTuYqFnyekhcdODqyTlEwOblQm9TsT2Zt
p0a12YV773bVpZc5nYgngsZVY0HSvG8G62A0JSdetdRibrL87b7YBRi1gjAEbD4yhXddol3AL+p8
nBkm5f2tOflT90iIQQ2DOFkjhQUJniITsiYAkxAR82flO3PNvlhiDwNoBPCSkDJWYZc24Wa3T1lM
IllBAELlhkXTPP5cet3Tqx0oT6HU+Fg4rmJ0aksKyuelFg8PWk6nnhaYvaraM8HFfM52MrmSlzh6
UUQRi/2DTSPYWipqGY8F0wigRPO/hQHOE4NUiygeHMuNjMCKNt2iuaLZfp3WxMw6y2QHVzfe1Kcl
8M8+KPi/tyt+PiFRcDTMAG+0HWkJDRE2YMbdRNcu4Ct4Zz+QkkZII4VH69FpkmoxNH6Zx+Nah/b+
8phcdSvcV2n9WTvGxq3fjbJTCBQZHXr63C7Z59LEMmLwrWnWN4YRVOy4NsrMNfE/npzUf3hMmZOW
7LZQVX1tZeYVkNsYg2p7nlGvo7HKS9wN88iLtneb2arx2HCP8X2TjwGb/a/uolS6mNsNEq0qYR6l
KToeyvcR2o0l5TM+8c4Gk9xo77xnqxPOGC7ZgG2PBRfylvqiCEgNEnuY9HN4x3cpXO0YYUBkGqUM
oeQlBrdS/9f5lPni/z3m3OMf3J3sw9soVwpqx6OsclXMOg8ohBeogLX9Ko9P2N0M3R8TIKvPw4qW
jOnVuHpILcHd3vAqw4Bi8Bro3qblrYGEQeCEIXWaC99LyeqnwfPUQfjmTP9BcoHr19Bof2wcTV10
OsIjwYkofD8Z5peis1EKQP58g8NpRbkCJCCeg+PlLKimgJpXcsx3js1vhsRRYCodtAJyD+L913rM
oadKlR6Z3I5tjNw3IVSyI6tiifcHRhZ6TwCaucUtcpFk70S4abQzGfJyxQFaQucFUq1VodOhrEf5
KFQyW7krxoKHfeU+I8quWdERbHhxR5+/ukcgOse3WAmh9MiYdQ+1/MQwl4kffolQ5Ob+KJVfJIdO
5tOC3FL3t52s0Fp9gBi6eo/LF9wnhXTX1YjF9VOemTyVcpbvhPV3U6QyBUxusq1mhsdT+vNoetCa
z2v5p4V5tI5hXv/iBOF+RLkGkkO8qQJYnhGaJTOLBGYSpR6UYs8w5mknJ9aMo7Z0HeKNUOmcJj1T
14rmPDc7L2JD1AjRdYbe5rBWltW2qsew5cx4fq+z/caexk8a7kETxTox5GuO84cLQE1h14vTEJtm
pRMf70TDYrC+J8z+Ql88ig7APLUGgHRSHDp82Qrz45yxGzbeDa5wOnOQtZSEBTPQ82uC9j7IAUIH
umJQpH6USB8fUWjAgy+Ehv+fKevnUc89Sevmby82/8fLI7BAykwEOTs0Oo8C2aJFwWLPeHSvJwKO
oWlflIN/aev3sO2vYnpQsrC5XanI9L5Jta/qBLYQ8Vj/cjG5abDS8ymyFdKDcTmx5lRZgc3dTDVD
lT1ZNp1BOYqA5GG8OD0VpcMBGxTcNYPDVcJuwiLKpLSpjtoOW6jSiVSu/WssMlpAB+MMvOwzbQH2
nuZuQ32dgz4oQQiV/UIUkWloJ0cy8BfQmKjQZy793hl6XeJSfOqsd54oL4pB1EK88SX6CrSZ6nmn
jc+y4ZX/J536iEhQ2mXL3LXQf/8ZI4Jo8PCBxivV/S3VFEAtutBWG51qzBHLE9paESg72eR5cUEE
GMUNhe1CAaaJ/vhHZ6qrl+jOhojDMEtgMut+/az2PUBpJigAdu59HFA6gmevHLsFobTmTWonRxWb
e9xyBK/T57vn9DUAmca2myv1QoGJD1nRqWRAvHplc/u6Th1Xl1N8hJUU5vtfMwOg+7AWjrZSd2Hf
o9N1RA4DgAvmdWuO5bYesTA67xiLxn93cnews8beZaLNMmr+5nJUTMsQ8bHnZYTZ45EvZy/66LDA
00mZwk8Q8n4GzcTbkU77Ua8m3ePv4Ai5MWljTAklk6X4yIBGufFkkJFfv1Jmh62dfyJQ4IQAbWrZ
IO97mmvreAD36cSVw1GkBioeYxaZea+0H02g6QB7EOjhjIb/6wfMFAVJBwR1k5qTg1jM8jjGFtJZ
k+9cf7i9Gaiiig5pzjH6IFghrZ+z3y+O2fzTGve9VWDmL3OJWTgosGiquRgciE9k7U2/g9a07TbR
Lmiiea325ui3U5Bs0RSRcpbI5W4pkX0L5cgD3WjD7A+vtlYZkX6VALoDX7a5cloFlPul8//Jhbct
DHrtE2C+uxxXRFaEZkP6jgPlmNBEnomz4zJy4g5wXgawjCe0PB4zzvvsSgpMAi5xIcZVbUrK5/qP
yo22UeXTWW4q8VHXrIXH/nB6cMjRwDEpdqwQWeXjb/L0f8dDeDdQVuUVDKLAl+a+XXmQJJA/WNmF
P63sAktflp0KtYZZ8yvaJHfvVP05+RIzfg8xrnDdS5STX2jmgtoMshpdXyn3QICkIAkaaxZOn3Dd
Ws6l6gEir7sIqkEdexEedKSTy9QUx1upPp1hgzYZMt/YoD/qERg7tsl/t8w69GBBo61+VSbk8vrG
oOBYajzQ8i1ESSjJWX31qJUOXEq1cmCFcvgw4h7kyHhC+w3G0MgNnF5P/2LME6mg5C6FlrPpBbLr
K8vlq3z+EQUOrOAIaBmXQvpJDRqkCwB8g730wiR9rUooM4+220ymY9mO5EFqLNfpRVg6o+aLtICU
QGdNwkSOyIt1bWGoXg6Bt6tmEn1nynbgG2CQdz4BZ03R2/OmMO5jqzcL8g46DWvmE4DHujY53ThE
FGojhzfiX+7ZWGHwCq7w+HGyk/Wu3NDawGfChvIUVU7piX8OJtKFj8cobU6HJSvASzDdxvXDSWGB
NM0GUkcdEcRjyasE6giE54mHtffRhgMmRVrCUVUJe88RZdPYoXlPF6Z3NSOYPlFbmd+ei2VDo46H
98XlRWeieZpyiscetvzBK7u5BxBDMeFsdbYR27ZqrGzqB67OD2OfXSHKKSHogNYoKbI7SiVKEJM9
njidsr9S6u9U/U5PoVXmLImtEQHHlD3v6RQAfRI02hOvMNKNvftvhCpUv+h8z9IPVFQ6NTnEgbtG
o6McEhtjSmcQanxNEZxt3MgGNFKHG/wZhUnBc83H656MLsDoJmH9mx0E/+391A3wLaL0RRpba0ta
aUVIW8jl+DQCwPso832csC2tbJlYikiBlZHBmG+aCOAEHUCLPTCWLGikTFNRHyDqOm1mNEx4wcka
xP1+vJhLSAA5SLBePoRhytyqNcOJ5YRAJ38exFisqr2XDKe/DP0iOOp+8dwl5lMWQfDzLUDu/cMN
Hal2Z7k11a39XIDW2jbNxfTIhTSB0qbttzlOeCACPJjQI8BOshkewoOCm64hHKxKVidFExsvGUtj
u+usQuuQPrFdA0Et6CpftAvd8RS8Fp211VKDEe4u5rpT8Q+X+GWbiYIa8r9mi9K4pK6SSDDH+nQn
5YaGMdci211oeAdacWV4lMftasND+N/qB5pp9jgjvRaquEg6u6FzTe+dX8PmTQx9cOZEEIXH4cWy
vwbFLmjybakDYTOMtD0BqEzYk5p+yxLfOdK3nCRaM/fyX7w/N/G2pqbcGSerB0OC86u5aDce/HCr
D1aVOOB3eiI7znRhe163K3t+OPC0PVaCuv5N6ez5rKcfpwG4OHq3JzdQmbMz+wLlQFpbJQuATrgk
6Q/KLXFHEOX3xKLisWNRqV1FD0J9U3rznSwQycEL+wEGBYjFTEZVoG+tvJryU387uhsyZzbpIH1k
vCxkDZfhwV8YVvVhhDL4szdPtA2GfjpZISZjkd0FocCQcWi381339Bd36HhqhB1WsgVojSTs+ld3
smx1me6zOKnvOiqd02DNuT5a86qddL5KtdRypgieW9y3uw+ktWm59pnXEqQLe9f+v8EEKlqauTox
eBBGE+6ZFHiDFIsIfMyLWLl2MyYlJPNjCuwx5pPP6D0A/NAyExdVF5aEjS6lellDrLkZMkvRvhSZ
j4RtdwY3PNw5aKtqVJE1t7EKGlQrqNSX77seZZVvnAxYu9DN3R9qMLppRwGvVNcS52Zn/5Fp0WA5
fQWSzKyhSkZd+DcqduDUfkDiv4JRJ1dredGJA0V09/NgGKIccaLY2kd49FhmXjh2shozwthlH9zz
fhFod9l58MtoVeGBl1RLT8swwORMwuWQrsyEJy0iA0RZe3TvATJtpt4QBTlE/HINcbio6ED4e7kS
Unxpf7iPyL2uWVrl0kZlMK2SAvuJ8DadkVBGASKtuPo7jozi8+VzhYI3iGNG61Lj95EtsW64FoR7
uutuh5NZlnEqtle+szKS1IMxmmB1/5xrsMeS8HzUSRjQ7a8f0KAtY7DMENm+F2VNx4ENrf5q52Kc
Wo18Cs7DfuGfQpAvkJXdlK6sJOM3gYpRJwa0jaYe5zPZRi7TDYrx3vMrEIYR6IccO8/osxDnwTJa
jk1m/M5r1iPy20zv44Ugbuz2b5xIuKepJnv93HOEYlYUYmsP4azfgvhZ4TbYIIJTaD2I6fhQcg7g
7RXu1C6+0xqgis4f4YlOpeKblpmztaRWZOQ/ifOvro9neSTT9y496hX2vHpwiEI6kMqVfQuiFxBU
38BfLEgIofSDRwQRKr18Vhhm9XBjKWLdMbROFQZDjLyd8pbD2M9+W6L1Hyw3Mp2uNXs8HKgIlGHM
9CHJyeVYrVQvc88FT0hlioyjCSBaWt/p5DSJEH1mLBJEo7iwywa7UR3lYw0gQzvKAdlIHkOA/5ci
eHgxIaXp7E2Y6HaUUykm6Jp7RLdUajC5ncsOtbhkHhvri6cp2h+ajnu1Wz8NsjMvRhywwMhY5CxA
9ZMxyCWlbhMqqP4xNVrspao2mvu4PYAq7D+NC1CKsOrjfkVuA6zLcSnmEqSGjZGJqnnvO+/VHL7V
CawZ33W6GRGTFUC+Ph6Jixh/aqKZWcnwooJRzKwVbWHrfjoWESVQa/5rmAu3k3LQ1U3TxA1GeMIR
EuGIgXm7vNd3Yi7nDlWVo3fpw9a9qZrnjV6sxcSQhiwzl27M6+zOghsVmgVeHX24CT8Q4bwNmzsA
ReBR2Udm3/h3VrBITq9E3O3itxk3YargjybC8TBLlJr9sA/SqQ0tv6TkdLQsC8sG8q2bvBQQKLfl
izLzf/6YiL2l0KrzOAt1FN9eM4ti0y+x1clid26wFaEj26C3aAF7345HPme3Ymj/my5dZOz/3V9d
eW6A0eYN1kAzrxbowt7i3N1V35J6v0UGFZjEy06T1lFC3w6w5G2hA5LWn9auitG6IIn9V0/wbsQr
moT1Jqs/9cSiliIgvDqFoWxCsJ4iyfXvHLIcZcirajluSLb8LNIWBDlketv0GLIWOIGF0kBG3vfS
ZON+2sFyuLHKsaMY3ICE6GT4CStzWGD4Tlhddd2Ytkd751w6m7p8wF1ku5PqwPuxCyKYA9Qf1qmP
f6/Ccr5UXm7KHIoJdJH0dvMuYZDsIZ/ygScElytDjix7xoy+g8fIO218dd3mtAjDPbCgRaSJLjCV
++NdI+YzyBtZz6GryiiqmnoRPA09oFE/OkvkFYAh7K94KuVfzhzhQaxL1RQK7NsFSUODIvoYU+gG
f1YaE6w5nzExeg6Vqt6PgffDo0xzRJVJlzWu737yfv4LBRnh9ZwONYQ1fHmte+XZhNsNoZ8jIMDy
zDuheJhNGIWvmCo9yokRU9C+wWUWG5tCgg/E3tQODBdzFElDvaBHrr+Ktai2NO7bmtLq5UCp/qTq
CxjURAZJ5J8/qxT5Rl11eX6xV2Fo2Mf7xsFlc9Bqp1k//RIwvHnVWgoM9l5TRGjVhNTZwalyfRtn
tnwQpGsdH0dd8ILWOPDOhz3L+hAe2xIuKBJZiysjBQaOJ3AxC9rlm+kGdZ88P0zdPpj0ihyW98BZ
3eHzfVWBrxP6F7jXVLYouXZ7UQEsRRacWdUBXTzzoWqde43bs8pfK8y9vHRLarHAq6KRIdSDi42o
cNcGP58NyFg9t2Hb1WbO9w2rGIATbb43kauK8xdb3PGSaAhfT6DsGu68xDX/tgddOZrOxv0NZjPe
i+/Op2n6Ks9WWMWrg2gbB72vhcGu16Z7vK7JGW2IHxq6Y4K3haaxDgS121qkh82iCVRRIEpcyWwe
4gGjepdvI69dXSRdbcDxUQshus7CqqTAfw/fZ4eygk0BD9qSfHBZTqVCEacFuCl+2SDFwj2Ew/lR
RZ8TJ1TInMPqspS+CJHUYLmUq+kEGfGcBZBUmwRPQrg5U4k+7wL3Z4zA3am06Sioj8Ablk82v/5c
gkkDdhOUiBMVBcJsx9ihFf86d64gHFfoJRU5+Q6ECmBQdoCKRIApEnxlqbqhJYBbX98pcoyEsDpy
NtDjmYTo8kBDrmCSLr5SYsqyZxMBuwXry8VIly7g5QnVK2xMIxb8N99L2GVO3yEcfiZsKe6llPQo
TiCCUCP25FMg37gOjJPHGL2hdIdHsXHI8na5OlH2CFGyQThS+D+D97LNwXWZBu4aaEtIpZSvzU75
qZLztQovMDvOYMETHd6Snuwd3Hg3B8aq5ekpQeFkz7QywpZgu2DVXgZ/+18pg+2fwD+1EO9JHPxX
vqUmtXnigyRpmmue6cXoL/EopherPdSWjWYocV27B/K8ZyRbyyQhaeTSExC5quKmjyddjaekvzea
cP8hf9iFCg8VH3sGkCJknmWau4d0Bg/MD+T5gueQO8yeAXYSeNy3L4+P8LlFbI0NnuitJZMTyO0Y
FgRGW1lou740h2CfC+tC2kGnmuaiOciloyVh1aNJmEnSgi4UxxfkBNjU4Xt2M9CRiDkHYmK7h2p5
nZQrd+ON0LjjLvzQ14fr48nQAm/GbMaZYNUElNCuN4ADrVFT799ZGbEifyvQcCdqtTgue0+1pxGM
xAmlR1bNgmyf4zH82BVNhE3+zRMycpEu1ROWvJ4R9Gen42Xee5o8AyUMg7A2c2B45S8BQDPEvlsK
qvKZDbNP6JasR39nZDcPAgik8tYG30RVp0pHLp8Ws5TD80Ja7W2u6Xw421b9GFBpeWXCeY3bkHx+
0oq8JDt9Qsmk1SvdFHJEKkRRbGY6F5kTmRlnE4Z6ga8zcSIkk3Ut2WGJbvIlyIwo/BY7VLJcBmIk
tX5Kng8nOanAhWQlnZCIRvTX2MBmDOj5vaqfhxXwl2gBzZLxdaRFnkdrZfNugp4iWMPhIFLU4//F
Gu4+COBOtP9Qw9hWMACyhN4LBYjTTo1U0SRNGFBgROBY4USuojExrnG9veT29i1sFAsihkcIK+R/
ff96UilUqzK87XxidmgeYwaf7pzV3ZoW9tsfJJRNbgmcg88megDFD0rOswnalacKFWc+FzaelEqL
j3KlIAZKZlBVGKiDV9zKszjX+LCKQa4yC2akNVVZVvriGC355cNwHOAvBu9ycztYrCtH/PhjwP0C
uW5HHyx1QltMGo6E9/48eyo9p4dfj2C0sXNUVZwsIzVvZ8voSRF43YElxrkJrFdcOzC5vMc6ww7u
EE4kqAZcSCyNUTpERSiSa1xk7Fn/ibYWiVF1o1Z8DVZPbCuRDvr9Uda2clHfbMNhPSbrwJter8nS
p6DtJAOXYempN6oLD3VpH/ADgA4HO0co4uR3CULX1evsiTXqlyLhLjREQFeL40LXrQEusmti9G8s
ucRKSfWrKIb7clW63+z3rRAthIqVdy7HSHbeMNu163Nfh5nvpohTzzQSBDW76IFXLQ5y4uOMR88N
UPvXBGngvTdVPXmNdAfh9O59zz3/ONe9eT6QAtlsg5R4jtkXO0aijcwzyJpp7tOWgmyUELfW4IB+
h1HTOxUxlgAFlEbqhZJ4yPDyBUrVZjTKbVkjV+zrsw0MjXgmB/PI374Q4t4IVGrXvFp6u/UhKPkk
kf5Gk9M5eUGOY6rlZfxQxwlb9djgSQaJEnDOQx9xL/xZ5ywf1ewLx0Fu3NLXcs1MMl0Tq7BahOUr
Kluhhj+EYjCgJLoFFxalHaEEq97A0x5e3bxM2TrRPv/4JZXedRzzToYbfVtahudojly/WGEA8eWB
tmk7Fz42h29CtGQS6JDzdWceXjnb/HgE6Uld1vVW4aX5CgPgqcQQXYuJHvtdIP7loxkKZjyMREKZ
AvZLkQq0YM7+fRvmpgHvzKH7bA99e7hpmTnmJhhLUzN7JfpDWRDgJGvFtCL0BmNjbN/JJgl2vaqx
K3mVfNoBQPlsXulmdooLRLKFnAcmGFPwLZF6DfHoLaZIr/LITDgrGA9o+G5E44CF6S6RtMEit1+j
9qT37uGZb/urJokUppFzdWGCopPL51dpuX46VrXZwL7Z+G1CWChdqfSWvXfNCNf6fEjLgthagDWU
NWfR1J7TBfx95hShmlcswwIv3tQDNcq9DjBcPuf6zJy6DalyEoTIxbWV/yUg3WzS9A9rlcmtgX8P
/JOsn1g9ZFMhFJlRtcGhE1fHmDxjwplCpBgAkxIklpvbi1SCqMFGFoQyQKPpZXncymXBotEIZ5Ak
AKdRp+YQ6bY5R8hjM+BL8ALAZEfNS50pNmqIfdrTA8P/p6sOb+6pxswuRFGdtEontw9Cfh8tHUsw
xgxvbrdlsbkkiTdM7EZ6mhy7tPzObT7b/5HxLbajAv0n4Qvbc93mnmoWrjtZToAWDZMjbyjmxP7v
ATLQNQv2KAUiTs48/ra2jTWwwKytSuzFoL2MRb3mdURUjmscWtShwVLiHhu2eWGQ++wfzk6AHt7r
eKsu95UtWMCe3dZsCBvztvU5BUh5HMfBCgLmMpJ0RtvGj/xJ8kSszuZFCiXm0D1MzkPbKD3G39Pc
g8llHGQ5h+uk9g3UeJmYbsPUyw5u+9D260dl1DVLnIZnXyhi24XW/RpKrlhe/1CVOz9c4KVQdmT4
CBwZ4ARsMMRw5+0XVkqrmpYCZ/4mIQNudiirI6tEzNBhCLx3dZ3KSdswGEu4oOEb3QEmzlcN4iuG
OUt+q1MSIW4B1cUfSBdaRG1B2Uq89JEG2101uCCfd3QoxgDZyT5FQmsnZuBTV2VGwfsCPEW2LKju
4k3Wi827k7+pUMCIfrKeKL1y+u/B+5GM5uXabhEYMwK+E9Z6GGwJKMPOuFSAz6I2Q9hm+iorffPt
nASrYRTDmXum9kE1rCQen3jSbAVw/a+ZMSU5CzdUJPvPqvoMaIKvIkAD2P9lnXGkRy0N4kWoyBWm
TCc0iIxbuPOxp+3po11CyKnt97dgy2vsTVKOGwnJDCkzCENOGwXJR7AX6QSnUG1bSpBLp4n50lqr
/lK187Co9Y+JDFv8lWV4Seu21YdcddL1+yfrcJPkqueN9H2XnSY0KI/hsOKxkl1/FqNC9rS2ol/8
KaL9TINC8cqU3GC5lE9pQjNt+1Qy32SVijiieNg0Mgkkn5NZFhjosCGcoLv9zMihLWw0u97oa8FQ
BLQrTeqiWd3COSzjt/lHcvQnUWKVDYgDeEXMpp3PcFGz0iZ06Ae46oZqeUE7baSr59+dCjsUNSfz
+hC979FGV4RLSLNDGSgD3vhNf+Vw6zRk9VIkcs7omCnFNVwHJr8IPo0L9Fs/27YDwuWS7KQQmPyh
ZJ0IZriJQI3AeM8sXrQ2hDwARpv+XbqjdEk1yR7nfj+VznZtvy2hEkaY0gbYLaerwFEuKiqrGJAD
G7MQsb4/AWWLdlUKO9L3N6FDKADEYbs3ESY3NtRrOGnPZwPJ5HgoHjfIji0H9CNUmsT35g6fwAJx
vKj6opKqgA2mMoiIyxJY7+ViVSSkzG+ypBngM+co2PJR6Y+5qu+6wvanmgQ1X14qukn0uXJBT6oh
yVLzFSpM/1+qqu4Pm1U5kTpWAgeYUi7bL0hhsgj20Te8J0JJ0wpv36xwzWHQQFsHJ11FNqfJ74oo
/FQCY409NXnTGlTSyHCiRpexNf/lWWEL3dw6PuveZL5GHxqGW8dNFFK8VmO+uDS9EeX5Hy1EXb7T
U/qhTkYSwwUD3wBR4kl4P4noxMnZfXH+QwK5ml2HTgkM8RLRo7QFq//99DaiCv2WDafeUd0DF110
MC4B56EqG8AH1dqNYzpeqoexFtzWJMIWnrjwxCOzz5SFUY2SLTuLDKQ+sBZfSQERR3kBXZZZyftA
XjQ0mJym8M6HCLlUXvAiki7RFLsTtcwgb/6Ih+Yi7TqRniFc2JCQhNHlGUGxKZ1GVSUe0ujmLCsp
0rjAgPo+/yTeUL7QcFwH5BNrdrLRicAD8QSxoewMX5P0dNjxXpwRO8iXZAxplWwlcrOtQUOTqb1B
vOWvwcBlBgtTXuylnAKCLrd1Qw5uHPt2cR3dlOAY91jJRnP29z5n2WGgHaXKqpcuGZjcb1w/RdFv
1009q9PmaYvSXFGYvu8noLtKv5iuv4bnSXIfB7uwGB3BRjxtPCj1IutNG1NkM+8NIBV5SQ50lLqa
utDPHxuVIKGrjh/GYRvShTdHuhSkM1vJow3XO4T4/Pp4pV5pXrmuD9PE1jGSyXg9YWnqP2V2qfw+
ck+hlslP7tXMAYRmsnBd4wLV/MEHiZW6Ya9GuZ3dtFCUzAuO9OIPiLs1bndpWLjXA7NgXPjS/rmu
H+7+Y/uHFjfWPxOy0VaybQ8wdhN1E3tFqHymJuSCQoakdmvCQr3BsHAsvGo6U7LTUpUMWBYvK3y4
T/lK1SupSez2ArsbH6AyUwVwlMtpzcBWiCPvc1cXGqyj9IabFVlEmovSPiAq1tRPbSLoIv+c+D1H
E4jHw4/nzQxfhgWJiF/NiVG49xFocPvXeD2ZdjsH8jDm2lGP4uD7qns8NjWxUAMMcNI+U3GHBR8j
HJ8npbnqlxvnu1+ZOzTdjse3BaeqE76bjlERI+08kPzn0m56REWqbqaqeSwAzJ/VQHnKELIGaBKX
7ccVuECuWfEFxonfE0VTk9nMVRvWBBRQSvo2NVY67DN70INiIHfx3RCCtPaU721EuBwlE64silqM
u5P4RddHETdjTTnKvwR75VYO5hiVKYTAqiFP6nPwWl5LPRBajDqSRmAlrEw4eSBqkHY7Ub/19ayg
P1YipXfAIMXdzdOvEaa4bIcsxwafdKfmiGx89YRDO109JYPWiS82yskT2Og535SW4XdHIyuClbRw
tZscO7Dsbxnq45jkkzca1Uo4KgenK5PBTDmCiGmrMEMObUi2bN+eQWLwv4uVphZ0WSojMXY3p+P+
kdqhCgu4Fk4D4neOwoOYeSYO9PwtWYfSLckm9ezczjUQOvYfmK3xkrSGIZUgOfTch1dS8XtMBqfq
OwnqwMVCt5707PffKvMOyqQ27gRyobA6npOIu36IJA/jqD6por1UxB2GOoXarKX12mPd7qJ+1J4z
Sb1Kpwpidsv0tNpY0nvTXTjG9ZXN1tojNBHJoF5SMdZF83TK/3V0mc/JEmAQmU0qE1iT7cvfC7U+
Z7UK5/cnGHLFlR2q7h1aeSMheNC95foTnQN1lYvwVmX61xJwwT6rPpmZeKBPgMf/FpbrnGseYl/O
vfGe9ACukQ/S8MKw8sIsTz4uqyteLOOk4w+s4mWh9sJZ5JDDs9y+imRpN4rxTUonvub4ZgCa+LGQ
VG2hog80GPn6H7lCOLE3SZ3dcsb/LY+N6VZ1hzST3sYsEopzk1gPTsCP09/7rmoki24wc2k//ExS
cJNLlsHq0tCRfnRuHJdJrZwCZ69lrqYNafDySA02lis29Ah9+3PVTmQBiCRiqtm1Zg5OpiuYLcyE
spXX3Ik8bNFgCrszQfp3xYx3NPeNwGBpda1+LvI1SkVgwLp6U1vuoNkLqNWab57AbOhRcXSPlOgX
GMcXi5957xh6ae6md5oCzl7aREmSXy839IoUFuOC2Vlo5ME+JqOfm/f3OXLHkpUv+gt4Kgc1L+8n
FXzih5sq6MulpobQbYgH0sosSbBrnRL/lc+I6doAF25nNiRmIO/CECYoKAraUiZ6Anrx686ACqDV
Wqzf2qtrU+eQlU4D9aaIL5mrpsDMKzvw+PZ8dgU/9daIa0+wcsusMGhybZNs6IOBpb/AcD2Wt8z8
hILOaQMmpdO1WZE5Y1guHO4rnVUvYe1m2nYaK6Ap9tRslZv5zgqEBusawZCweoJdWTvKBaxcKZNa
EXQpOYYchHs6W0nfC7PQzfn6/6S46pob3AOSmzZSh+BWNFt/HjTeTf/d6BPCFA5a2Aq5WUhjkZmx
a6rxQcDLS3L/4g0MsCF7YjMAiEZ1ip0M39zczAI6Cn+9jbEcTIzsQKDCKlVcwd+aCkTHIywysoFf
Tze2y+4bsWQbxRRB1fAoTaK2QqDriU2QhzT73PIVY0looyDYuuqzf9swtLoZjHzwrUPfw/xFxHYC
qkxEuOv0ZbEVgZvKPIvMaVCT5TTcgAtcJI0sMhz6hwf5ubb8jE/NKtoU/ia2mCYwiPfSqIKnMEwN
mQCh3sfQnvrEtdbXGB/06U7fiY20l6d/YDz3Skkwj2g1CCXnqh/rTmPlN54HgUn8P9XLdCrVeUuj
O8bT4yPD2EQHnF36dqJ38rt7l+kmIIlcHBBVp7DpCyMrbijEM5ibqFScdUAnjVc6SDSaO+B5ONur
UoXdBq9SNhPMmtbqd9cYR9k57BgJkVScIqjY0gwMLJNojPWHUubDWDHBTFYgAaScMU4321hpxPiw
iWVwCUmbLrkDgVUwfdyj5djhWhAioFGsuPo1dnm+77gwobw2xjAFFgHskDvFDU6djX75F8fLuLz0
GZRdoYk5OZJ7Emd3LWCobxEE9qDQ6XjGgZV3dGoLdTmo6Aar6Rj9+1kxSDrvA+fxKpclUg7rLHPK
pG/tiMxPnhQSLVITlew9hCqmnCJ+0b1bWSTL1tCvqjHHb8E8WgypBxcImSsHUvldph2a/hhK/pRO
0hZSQ4ykzUGc+DP87Gc1gwK0F41fbQbcrkCK1552/N6s6e7cYfWgvB/Si42y0zLgOWp6a8Pmh/Z7
LwODOdKMlt2OZQsRHRF7Vdrosp4XOwVqyILx/NzO7w6D4p2EUpFu/O2QKczJuBrorBeOZ/Xm0Oln
EiJomBANGXFmVWBjjtiNXU0yzeUx1CeCP2DjHT4zfelQSLzybyGf7HVstnyv/QFG27Pp/zMPhiCo
HkfSxAPPLHENQHE8IoBrHPP0qx92TI1EAG/PHzJ1gBRoVjWasSONphWsMkECk5QzUaBrMIpFY7bQ
NCPheyYp/J/PeKEZG03j3kyMgGsYD+4e/iNZc45XivPRV8W2hbOMCewezX7PdDx5VYKy2cUAF09O
tF/l530S3hTXotVgRZ1Nb6q3arsJC2DQozpF9dB6BgHC7VNv3o+PJ1bCX1ZeQsHwf5zt/alwMAnW
MLrPWW/DopPht9JEjXOOssypr/zGfm7B4gabFG+gVtjcGCwGT2qB4rlahSaG953CIfGaQffChIXQ
BNYFO6MTk10uue/CtypfDcAMiYTUBqsfj/un9R6OUJp8eTu/Vyk9zkujwVOTonA0Jwwg4U/x3LzE
yQF1cxn3Y6iZ7koLi5Eul7UvxeOm8eCxZrn1JytBRGgGqx1IIjlPGscer5npNfCO37Hjq0V6g1sG
y2Zv6mIV0fD+wORK7dCNAQwyXvNyPZk9S0jJnAmb7v+r/bDxSI7L2Ep7v2pQk9Z4bXKOXYmAwpb2
sYPh3jE+p6YNKwKXejnBbyw8u9nVlX4LS9hrmc7Hzf6KU8FsDPUZqNAx5O2zvOlwxEJMEzVqE67n
V8qx89lcOUnTUGhFpcr8WYELPL4j1rhA2CDc8JmgFvgxM/NjDbwmHitQVgic2v/H0W6xBsbgtZli
Q3UGHz6/wsuejM99UXAHf/QG7vg349mzQ0JInoMh5W22MDuAdw0MaSZIhnykS+tv1q/Vkym/1kCY
1YP9H2d/83mgi/e0bGDZqMHKgSyU7ZrQcKEsebSU0/c+x3lhMMYXpMxcj13rnsnHSg176MTbTqcn
pmVE3td2LEVFVEepQXtEo1OWupiJw1FdTzN0qH06suv3v9eElXLwq1zMj1FpN3A7/8MqoQmYJ7+f
ZOzdObDB8uRonDVcGI9oljiQflyxJvN5bvur4dgWYg0n7CIyDpnuzT1kbRgzhRAPP2cmeVA/xxfx
+zcVO2kwdIvzIbkPs7On03/lEOdMMWn32E/6KIhRIuDmV7G2OJaVV3j0wsNHiAsXja8smhdEutlo
YYMK2//++eVxkQk13ZVRO9dqV0WUUDI7HzTuCSA9z4jJFIa/Vc8klb3AAgdSywFGb+Y6T1DHRXK1
3qIgp5eCr4xIJQLH/mbC4Z8w6AP4EUqubKyuhHVxoy46Aww/Rpht+7lLtJfxY7sNGfiTPbAnHbbS
LjtskHRTpvl8CqfeDxeKEx9xlYYzlh0BJdDSbKfojIuMV4RfUjXZYHr0K1kha5UgtiGhGkRIyYAk
qvTKEEva9VtMw071m6rRiFT5XFYZ3kIHCnZz+cB5FyGq5hwsIN8bcHgDYWpXVOTsYONk5zyvNjSF
ScWmCnUsWcxzAzf6vhQHIp/bJnYQDQhnyXxF21pqITsXMF80Bv+Z4Nz5hE1U0J2sPry6eolPp0X5
oTFq8wqhNSl2u82053HWa2dcx3OgwzcAMcV1dxX2JfMpJiJYn4yKUx3jzHP1c0m+Jq6rKygHNaLU
fpfe+4eMBmeIjMZrU7MpEhnF8aF39PX8BxrSIcI1GMQTKPkE5k6HmEnmIW66v88S9ubE/8BNk4/b
DwdZrYNIv9YnbKXELjHvvppKneCH4TroiBWNlUH0NLiT+APkzRhby5ogDOtU9fsj6AKo1z6Ylft9
1LoWlKMNIkhaZ3XHlA0FCvNDrh9H3VQCxbEpd7CTBh8lsiGsywcQpAW3G4/Zh8qgUZfnsbB8iQr4
yrxHupGMo25ZybxjvJvSqW8SL2fAaJoolnez4mfeMLMjKzYFauLu7JeeQJwCNT9dNP7izopWDh95
DygzBfOj1Q7MQDxIN2o5yN0Na8A/w1NKV76/DNHwjUYb7GESRwooS3w1pNhmt9Yuo69UwmqDsvcO
hJyAaoVh1Z75H0t80D6NSTqmwo+s8VKC8soYp9PsQeb+ohJpLKU1rA0osHTenFiNjWOfD4O/n+P4
BEtCAQJb1/ATipNT1uPloUrOU0STZPBzLy3P6qDqyncl3/7zX5aoEc3Aq0QJRYHAhSf8zu51rNib
kvILEI/gAVxhAdnvIcltvgN5SUZD6d7CUsCbR2ug2bw/8H6ux5bpYb89E72WBhvUKjwXw2vc1qKN
kkKSg9tlx/r/91laDW2Ux/XIomIhLZ4uJJnczIP81CaU/nMXBXBhCs/eEuBIrbSlLonekd94xOjw
bQSBNS8c63eBgPZ8FjHuNw4Q3/VhgHKyU3O0CnzxL06b6L1+9ltG1RRIwD1vSv1e8l2NiOlmLjvj
e8v2BjavYZ23hJDCwFcyWGueZpMT06EbElxI51IQsVYSwKV4rigYIfT+p2isE+MAUu6ipEKPfKqR
owwQiA3eN0zfJWr7kQd0WpZMdUGY6lJ4EstE2D5VBA08k3z36DzKNMklGThXUWIO/4s1z9xf0tAx
QxKWLOql7DLvD/s8gFI6iejMI5nKkZ1SX5/eNYGd4fqvff3Jz+Rvl6RWePZpuZayFg9TZa0rNf9v
ditTCkIxOgHb0Fb3kUAPym+NH6GUKiK31H7ELnKnTd6AoBUb5To36ID0jdfDrpPkIsmrVDreQ+WM
HFhYF4DtoV1au1mBw3BJBRHMUB1/eE9W+yKQLI2Xin5HzNESgitC3lE8YAn+Nw3ZvF6eh4vmhjkz
sjNtWe2hW+2oQO2lQTKzHCOk0OC3Z3fWTYRD/wPX2U3a+DC4XLEnLcA6WzdE27CB/UKD4Iu5s8jL
j+fx1KRpQyqdW3Tjd0I65BDCdT5z7GJ5I8CfdxCrQYeibfPgaN2mQ8I/kDQFbGiwBIc/9x9afHmb
Hh+VNvsvms4Y8fsSi3vp+LGl2Ap20i804sM9/daeZMRMDQiwRdRl7C8LBQ1V8MfDCAZz2tQCZ6yy
a9tKCJhy6JKxrnKjYPiBa9LY91+WkJF62/ko+MITR0hT086mY6QSnV2T0Y40TaSPakgwmkEjNCx9
UI975x/9cCCWsduKq/MeLcPLspubWRvupK+QWATJ/LuMwmAJFK226Y/DMLtOdbMS7D9vsyOWx+Ok
1me/EBW7qVFeZbJuTdvn42IcIK4fefzGHuZzxx4y1Ro6R3UvEmn/PVmS/9P4WsOO2Zp3YNxdYRu+
wcsbenn6aD7WhEWvdCU29GL8EQQ1PGIz00b0kK3dx0wa7yxcm0RD7Xha7fdWKHRbFx+rgtcbv1Rn
6dLu2NaWjB86TKvUK+iH+oyDfY7ClBbAcrQLK9/0yw6T0ZVq1tbFFEnLLPANZ44CJgDMj0S+0YwK
WW1q8sHilqLiQ3U/Pf974Q3xD5JY3nbAl+rQ3O14Pg+QOi2NXVJaP/JnUaTp2hPPM0HGFvMTO9cQ
q+RlsGrz7+8ECcpaU6Ep/qRJ85PLO+SVEBhGvCkxrm3mXjfFlriCw3MMFD3SReZqs7bmmHaCejY/
5g2ra64shNDkqKqKe+42d6j7vZoPbTOyJcSA+PQhRJQ4INxkfEAFknGGLLJVA2oulcPyh1UPnAcI
GT0WGi+phGP8JXPsT0oJqmwlYv1MNIhhmBp5VkWkprNLGw+6rFwDspKEBF2SLf3dRlKkK8ICod84
4PSeYrxc6CX3uZCSbYBRMj+3+wAQopXNETPB2d3QoY4sb85l6gSQZ6WApzZYnpl6pHtjJSAOx2b6
BU0WuoAkTDR2KVoZ/pWOrsCNnH/BC5l6aiUOwD1LobEdKPWxEQy6nMmnbsZm1d9+nc8esteeWdpy
qxrxdGGdJV/H2zk8rW2GtjqNjrmKzt+SThwueATpH9JyA+evzIFUoFlrPrS4oWqfWJhAIH763a0n
EfTie2k/F/8vWsXkJOsdf1aEvr3L3qbPjDkj8EaqEL8tS7Cmn1jevNAxa6u0s5b3u68pxLBBCVoy
OnKLy656/V+v9hIZOyOpWcMb1uH+b0FNQUgKk/bZQoPBavavDymAp2t91POrbvUEZlFXo7Ld1l7T
EK+Hb6nhGxjL+VhZ5rR/Xj4JjxC/oOArT+byPdxMOZ5w1M277U39bd7M0YunF2SvkR2vEKemMCtC
jakzTeRL+76ph9fIudpKkyLvcJaKKqphAARvF4ugoiyO50wkiW/p7X2kdO5fJZ8e2VlIYmdHBUFf
q2y3uUnhintohKrdKY3IyTU1ECIlBY7WJCCbQzAkl0Wmddt7zK8iKJ1/ZYz3eqLrAdMaRcgZksdU
ZfdhN+SAt6i6Km9jzlZfbVRoB+984eu0idS9e+d0em9BtXmSv2G1wgP9j2x1RsHXF/gcks3uVLzW
EMTCuDMGdbAWkj/8w9+8SkV3f4AqZ7IX6b7h7SkmvsQslhkpbRSGNWaiHrKAuUONU+wXNeQKpGCZ
DHdvAJmhFazu2rzpTG1Sy7L/S0usaIkekmbUflitChw5DRaegC7bD/kP4sJ5g7ZM2VvKOHBaBsrd
f9saG0r5UytPrLc+z8uXeD2mO3/iMmQyc5T6vgu/7/K0TNIA1ZpDH8kV5ODU2pJzQ+n5ihnSQxdn
pU+WxCaeqaRneS/Rqtrq29fXtfdZzhw3naQl7XpJa2UozI2QIMFX7K7OTj90pK0KyEWPb2WSP6Bf
NS4zObBptjDhluZ/jRu2Ju2xhUp0YkyqLW5YCGHD9z1rHfPQBSOfA8pgbYSZYi9hxRDq92R87Ys5
XGA1adfaZZGLXrMGEItAvL4Pq/M+w04AKVAQQgudMk7V8b4X/r+y31qWwPy2fodKc7fOndjBkY4y
FWbMe+jYwX0eiHI1u4QGxfJz+WdigatCLCri2hodlYcdL0Px1p2MVf4U9IOBU8pYmfZ944RDCuhG
xc6GJVeinKzVGHbo91JdJSKxgOowEfuvnxW/M+e6w8SgKERd0+e7Emndq0ZYiuGjj0dEFzga29Gq
axM0fQd0RcQXQx4PKuafJMAcIaGWQ2Mzk7Fb/2dz0xhVTptFSzbey4HpjnT0V0ZtoCNmxNga7qna
seDmzcxrAhqxQawrmOIHi4SL1aNEe0mNCJV/NmiwEWwDFqM0GYOb6O2gncaqgh3QMJ+QwSGrKWs5
ypAggUpEal+i7QFlz9Y/t5S7l+32wr/PwvqM6BlJURPPa7MUtlOofFycvLVjC4BqPNWJli936+AT
t4z4Iz6lpIE2jjnD2oiX3E32It7AC/y2uUJsLcIRdZ0TO3QxXM3pz+BSKDlVFGr79fo54WaPijhQ
QIb8mxHYyYAzUgcUA5WaOjUb7cwAS7Wl85tRGt57f4u28rYBY3RXgwZElNy1U7qVZLdA8ZnQ8a2g
X1/ifs5D+C1XwfSyxCT1Ng+mdzJZiLq5m89F785wXpOf5wt9YtFZ+7Fw47WC2198yjXKhMf990HX
asESsSrook5+Hf9JXQpnicNlrlIPsVCX7dAT+BgPP/8341k8gbgquD7raUvXr5s6LR7kXR/8rLzZ
WJR/R9wVw9EkBoId1bBBOzDKa0VnYM0n2c3g2+srY/CVKPeeVZnMCqQLW+cqLoLXG1fmeasAI8sg
jA0FDxCIshBCIPqcV30VMFQItVuDXnpc7LrDg8uoHbs0PwWNf3SGJ0UPOUhm50KBfv6JmSfh5K0D
1z9luGBBgoyCJaODtDFrDCgbZgKNWHbq+zggNeKmq37vpITC7kKTmnG/BCw0fdcwmw/SKGOIjAVq
MlBd+smQN2hum0pwWbEv1tTcxgmb2GwK6CVoqEpGya+UQzArvecQSVjdHeG/jmS3J2tnJ3xFG0tM
51VQGBgERYHrS+u/6CAh4hg4Ycw8y8oPugFBPHfcbO9LZNFytuSPQJWWXmJQ30h1+QKTS0XNhwyA
y0KZoiH8GuNo79j0MhSQ7YOsDso+nQWvg0bDtZsv15N7FkZccQYb3/ACyKN+Ov47biQYIBA/90mv
JEQYq9tZ2S5GxoFMUeVvxo3Mk7ufBS30eb1zCxv4e0ScOw9fDrdRDKCkEoAeuegGDm9RbHXEzSPT
mgOidPt4cJ20x20CA9xRBoTihRzU/puvc1ZRH6YZxd5Y1QMlzqJs8C8Jl4ZkDKhNykwqM/p0IkDY
TA89Z5fT4Try9Sg8qheOZ2uAJI393mx5C2xpjgbcN+0nxpFuIh1pEztzec4t3qYbzvRmqc32akjP
PoELAHXsHJUhpIlNIMNRsNRKvduszuufKU0gG88D/Rwbqr18YiNzrXGkW/af8V6Z+la8smMtkmCT
JUz+SsZO5dhz/u2tJXp44cnNJqWH7CnEEXO45/KbTdsV5qmNGDhvAEFP94gJcny7MYzg/aUC68FE
ZfcwnfId1DIDWi20k7NHLDFbxVDV/l6LKmj5kbLRJ+7CW6CP9uy7kaWTIbW1a9+yzpsv3W4FsOSV
hWJvI88hTevaJfFT+YCyIWPUtxkMyX4roAkXvZ16weiGFwwrsLz7Bq01/r5zTZUs1xqHhV+Qpg5I
2+uddsNJQkKg/Hu2oUn3GIieItb6RSRrKD7Sk3q46+eytwyB0hF6f8JUQa6vOWShEzYcWGX+CdaP
UnEXnkFOM9sC6w18bLJI8hVBIA+7Kksp17xrYbhnHBaJWKMxXST05AYUPjpFsMyO1GPVug0aoRrm
Rx5J9eI4glZOdyXEIepaS/ddAeJvfUNqt/Dqz8/HFhyDT5d+OyJuwM6lx2Y74KcuQbXKuEsbT/5p
7nps8FusCadOEBEg3Nh7abKxQW9oNdtWk1yfh1s9Gjj5RYe0l1teWvqY/lOJZTT7yVk7X3fc+cq3
Gey0eVgipYrM2rqdpD/NPtnU05Nzpkslm0dEMkmrXhxG5pAWKxCMVr3rT2Cbgdo1wK47Gtt1VJXp
ldUEbptNYvI0n7IX7rCIYMIV46nJPuwP5ZrQL0buS5PHGQRB6CilhTxwt1MG2RiK8ci3DzXa7KWu
LqbOEe9zMgcMWq95uw6xDtOodxka2gwwZXsH8FCy7/sEh0lzK/NdDMBs1fhDUbjYQozQI7tgColV
I/y+FkvpuqInewMIsV8bHkdsNLLiQ3WiF1AZdl7knChigxi1ZwjrCWIZ2Gm/6wZPVdyPlxK5/0/R
R8xtfGnto3pC873MiE9swypGNGymP65j4CbjU8Yo5TyE5OmiuuyrEuU7H+OH3vYirtkRyeRIbdgY
YEp9typrfb3mCkUSdObuWz4cPuGAz/1vJ/QdlG60m6aNkVi7ncGhqJ6mSNMTd0X8Qlp+2lueOpNV
pa+IsukEX0+VGulKsDUFs8mQxh5rqVg7KKkw1E2JLRpi0eBTbri+Um8zSzU0jY/hBAy3gk+SCTta
rcrPWVza0lRd/AKRswVuhFHyICBWmEAOWIQ+P2/M+jmePBkiqnOarSWn/DZAMAy5pG8+nEvGCz1M
EsTtWCI3meAqFA48iVGz1iqbjGIgGdYppNy5+nkJ1DNy0o6xbEBthSApUEKSngWggnS3HH1PceG1
Ur33GJvome94FOxTacyt39eWl0jz3IQWBgz0KmXwGje4fF0sNtd2Qmp/NTLFhRrkGVfnJE15Bvk2
I0Fe4r0430aiFO/liobPEacsFXrdRRtHuqYug/DhpgSjCJhWiOfii9m2Con5rRw8Kw1fmJIIawKT
wSTMhV0zVeYfARgAd/69NfjWVz2vYIt5LD9MJXmr0x/5j1VQ0Mmq1Lj079gCieOO65dn4Kr5i1Rg
21U3Sah+FqN1AmG5XNDrrxFGoC1MAtPIQf7jy58UuEmpqaCbIGwgYhr7/XidTt85s948m9IdoCeU
ytePxOmgWc0uur+6QL47H3HWzhg3G9ZS0afAgiObckAcRsxxM6qq1W7LAT10AXhEUe8dFafjKe3V
KSI1G57vK4QWTFSWOfhu5C6RNY40ofbjCNVcQZv5IyFVYg/Gvt/sXUfo55Qhpz7pgt97FQs+RW2q
JPnvTA4ZHv3jmejFWAYK+O6zgQXGM5mRHpexl20+ppVKHpWK7K761sBae69Oamwsn+aRfPcTKzcl
iIBCDLQH36FPZXp+z5ASxmVlZiSxormcstEov/8JcHchinxIrR3+NKOrOMGfwk6XIcdevX5p3UFS
NdagQ4L5UtzlE2CKjnAKKYAadNa4Jyb1CcwqLqyy0iVbS3R1T4ghhh4bkh7/zCnUaCRbvzZv5hPa
iE+8Ffwvy2xDFHhO3XPAScDQ02y4dBN2rbOG8CUFqaq7nhzZVUlC+gDBR2gYl9FUAIHVXnAE9tlm
vpaQMW4R6CIeBdggC7rIkgLVBa4lkvCFLfqN0PYDiwVZE/DVk5sw1lIRFov88r2XNFW3AIWO24Fg
Tjw6Bz1uSmGC8ePyct6TbW386U5pJZ3Y5JidACkLjJYdc9b7mBuyc648TBZHDtN9r/1G+0wRYmMK
4s7aAtC/nlds4rTZN5mxbc0WQZSusTGPs558Sh0nBpFp04JepQNJMm4nhm+pUuw/fpcaUZo+ExNS
lGTgVW5GkhbxIaFz++PTmZe+0zZZv3arrpyyNro3yClbv0QyBij6l9CYEkzV8k1T3/U66Tmy7kEI
OzRbFqNDr7M6Y3hnZrtFwZs15cDEuE24Gp+PoQ99VdkdL3sBlf5QUh5SyGce2lKs7VtzeBniPvg2
dBvZWfzTkWhsopwAVOPM1bNXzXsMYFrgmv1vgEcb7ktmpw3/cDUz/FSFVRF3h3m3E5N/qwevxRCL
RT+6I5p3zbEBXvgbyl8OttoJfexeNycAlYzMT7Ajfa8wlC2HGhNStv/rmZ0siE+44zjOMuLGM8PU
oL0hj6bnRVd7QaLdUveFT8wUAOOdrk4RjQKEy3Yp4rbE/NvTU5EnnVw/XBhdKOHpEYs1ZcDxkxpE
VUlq8u6WSV9NKn5+SRtpqcSgQu6NNxxwq46Y2fXvmmxs3xe6dHnXn2P+lLnTKeVYFcBpsg0GR1zg
4Admm4ZBhLYgnd2KcEmpxZ/wV2kt7ueec/uIf+XO9DqrEFmB1OZDynLO5LvZ3VbnYiYv/CpTTC9G
c4XMsyaARczJ8fnZirwEJWVPlRXKNWwkAt587WOgENq2UxKZ3vv0pG5IMR4ojpl79N5xoRn8Atib
2NKKzEwsgUIPK5CHy8qi52jgrWXUtSxDzKa4HX1iTUiX/6b+EweAkJV1iWRBLii2+hNcDVazZ0C9
WxInFDN0Wk3fF/oF5YrKxZVir6FRb5yn4xZcdAODHBXCzrhBgY1QG647bgA86mtATC3eLR8PtneU
9C0cLr3UuooGauDsjEDmaaRd1gFtv5LlGr+l0wgIwkl+dti6UrcTlz8KdJFJJflut1gQlXNOZDFB
z9qNdEJYZlu0yfSBOMAf3GsktfcmAfkV79dW7d/8PhKVkPcQ92wumMwvHKWpwZOtbXkvsH5XnHzf
fLIcYHJ8CCd/7dsp8tKuphKM82eKzdfV36tTJflezLJ2Z71UMIG74vhtHiYG5fo+RDId1vLEtSVf
AOw0HfLmDdfyhsoPCcPn7arMcdEYxWYe1/8kaWuLXql9u2EVByCJakw+ydz8XkX7jeGSSveSHM+t
pXW09shk+bamR4TKUhdmbz75mcFJ4N8oS8PX/Wa7LoSIaR5AvfwAhms7QWcMrKBUmrLzW4mt5L5g
PbAO7MtCc2Rgrgg6J+pEts/X7MKw4FTqkorKHP80PJ7IKCh/TUbkR5Qa1DOpgmrJJ2APGhKMr1YP
CtcxhGwkociDwJSn1+Rc5byQ7VBt2uXQFSA8VN6GR7BJrC636s3IWMudysq5AnnRNL3T/HCj9LPW
hSyOvxbA+0LZ2Anmk5Qd+CWs7EcyqAUS2Nq9PQfaM7/XqetdC6vAiv1Q4aQhtxIjwJSWGFHgmbpR
sC27gUBunnixuv1IQeJdgVf/pp56cgT5Zxwi6nvh4M+dH12VR56ET25jgMJvH6HxmJv52irK9dMy
5NNYz69MxBF38OCALWJBndbBIDZJql1ZPgTeSfz+0cy7/mM/OZ3lz5DqsDfX+x3dywpNvBEs2fRC
qDDaCf/ym5ipQe35jYRs27VKqiNjFoRKKESE/XGUwkYKPEloewFZMKS8mzc9erDc/RNYh8h6SvTH
glEhyhG8lA60sslkH8AGr2ykGlPrqGmHCFYJRNIRFKqbPrCGCv8wiYxmy3zBDQ0V7nNV4lkBisAp
19KIGZl3V7JEXvOOjgBo56Iw/FynIA3kweFrBOqbNzqlu0wq5W4EqUxrceVB1SdpwWNxwEVeGs5V
CyLoPvSGA5dqpxprKSTeabOIeFhOxhTG28Z1lvHYjgiz+7SRewUvAimmly1oL1NCZL859Xd+33P1
u163/nJAWklbS763tFHkSdjyokOdD5+Ep2Vf7TjfgPLe8kUvVOnk514ww3uDLi8IMpl31LawtihS
XqkdpKoqbbJ82IgFdikmASGV/rxyzX1N89mX+Nme0eF+Zg6Jf++KFljd276XOzSzNmWRGKXL1lKA
p5Z3LEzCvlnrue7fTlENpb+BpdOfD5ncM99zS9tswVcC2YDprjE1wuClYW3CHXs1VfyW5STBuUxZ
hgUjguUwKVZy1+B6fMNt+VSzyA9fLUKfE7P9XkX6ZzloBmKkQKPpyuMcxNgiKhE3cEzOC4Lt2NL6
ZpEBWodr7sNhB8gA5szTQaZgOkf0/DxMacQKt5fzfmhU7Pv+1RLgkU8gLPs1aH9T61gDla7Uzxko
X5DdEulI70L3geDEg+/EltIOs90iIYToz0ZcAB5quJJZ3ygeWl8kFdZmP/Bs2zRFErgVlXLTNlpV
MnOtYglUe7MywEf5/XT+C4skSo8mrnng64aprD3/SKvkgEdPqCQMG/ec2nArXGhurYkSWeXnGFDN
S7SO0mleZH4grykEHQXVhcDKozKlASmfXZBcEoMs6kVbd8KiRL/jUN9b8Z46si3gnqZu3c1ZG7Pw
8L/dJUvYv8OP/zUVTJVB6T9mps5F9JT9qZp24ZuN6gyFSE/iJABo3H6aPf8KYEBX+7xAjsFjQfhB
Op1DQY3uwa+cCRq83xQrDssFIGWDf4D25BO+x00VXOZI7Y/EpRFnjXVk5PGC/vyuipAg69BRKhzt
t8YGYEmeEWZk3gM2T4Es1ZZ8MYLWl5oEYg2/w5lri9jpFs94B4tdYmGVm1Z4kOblmHGU8iKZaK0M
0x8oA/RcbmdfdfY9WqBEFXPZOau33JLAEVo5uxcmS6qFyYTWL3+BQEnHu8xlWbbiDx8m2dAfY4XY
2s0E2hoovPPApPczoxIL0O6LBlL25gojjaabghL1TOv22UJGzo5nfYvvpUspJadW18zdIJTUui8T
XgAKwP6e9eajcSS4q+8f+4Rer6AeLdu+fmWhYt2njlPj3CFfc6n9LJP52b3SNn46n1lBv1Ywqm7f
x6IugRj4etFMqd1Tw3piEHntxre74GTtH6aK6knzQhTabTzAWbgLWFI7hfeF6q9ovgX0G1Bnk2y0
Kq4sp656F89U9Ggwe4yCWc/6laCFXBJIUFHFdZYA8PqYh2MSMrW+KtwDcsrX1wGBxeKlz18oWaOA
FGOFwSPswzlnxyASASJLyNr5/1oHeFaM+cPty5oNTgeHmJ5NUQUaZGF4esKt5l+VdQfbTMmytKgo
yRCOfTRT7aSrZl49c381yc5Tmz3ZGl7vyGcvNPKdVVm9159GPYqy4EAxkLoIOk0CHI98aa1XuMur
iPzTzXPF/6jpLsWE30IzmZLmPX2dlcBaJBeEGE+zUWoYlCWpQD3sTj72trs3XsZJ3WlZeJKQJfot
PC8cdeBQfiMjuAAvRl0Pp5HOy5XMwRC+0SiGeSh2SZGY2C0YDgRxskMx5rF7v+VIreDQC56ZuGx4
/y1H+96iqHMRo5K2btvlTR/tne91lnz2QtfmllJZPd4hDJIdDf/nunxin459scC5tn775H8uOJCE
pL6QeFdX4UbX6we8Oi28G/Reh8hbSl7LZY/DHvLElHu9lj2ar/Rm5VEYV/W3AKkot2O0BtKVoeBv
uTMW2ioNzc9sUaBZK2AjOZOE3bsodr5jHBIel8k1Ts5tiC3DZtC25dOKc/7lpENhfSv+26sS//j5
qnguXz7nM5tRne0VA2kexHcXKqqWwt0hLusWyDTPbUCNKbUnBqqeSUyOYE6eOGt3+xoJo6D8XEi4
2C8C3oQNBnvd03N75SHTCY9sH/43mRxRHIaX8HO4D5os/Ihehdyve9bdKRbIIorvXzuDu8JgYqwN
XXvcvdcFCOjergCpUsUkWXseLph+FuSuUrjybaCBQX+TiyUSb3hnbtAyMUpc8wUAnnIt1hLSlRKl
O1xLLn5S0slha8qqUGgTqeBIIEGYBWrgbLi1k939tYv3EfgXuyofnlRta5xOjtdMk8mNTvhGQFa8
JiY4CzLEs36erhHLcI9xQf88n1H4pQ4UrFIqeIeW/VtLBqIrXAk6wnsdNN/U8WeaEC8PD/6DfHuf
FnWqdcQ6nrBtLVDn8o0/ceL2A//qhJ0jBxag4/FH/kEuRKVjH5supmsMwbPi4MGqA0xKP6eW/LWJ
aEPlS9iSOf980oTZVbIijnL7DRy937EneguCnWXTJp+R/wXuo8GRbVDRWn08dCV3QN/756YZqm2F
4gqccmCI5eZLfDMMYVv3BU2HmKOCND6ZlhbtsegxCyBW9Q6RI2X+W4NHGeGMLZQCDnGfP6TXeKYr
Sba+pOlP2PA/vRC8WZVGvkB2r2YBCJxnLtVMPF2EgXpLu/vht+fCJN3hMKSgIawzrRgYaheQzHiF
a45z2VyC6PCyqp4Cczssr9mOx3AlqEpAOEr6rQ7jW7YQw3n0cWYIdaPJ4WcyqOY2UjPHhZVDEdh/
zo2nCkykmvCGtrMeT12UEFVM92HMyKyfuZNYlXY5s2RgZaWSQUMAzsnMbJ7Dkd/9oglYptDvlb7h
PQMubCImwk9gTY/UBHrBXPiGVXgOnG0F5lcOsZeqDTcGJDWnfkdn2FDKzVHYvbHwoN9oJb6XdWj5
8qMEwyfU+UNBZQwaWgbvQ5HLdm9Cy0OWP0FPXv0i3TCQLr3W8hwtp8h0ySkA+5JIyPhkr+lrwQs0
6bhZrN84ZmJU1sNVtKayJNamOgWWsjemAop78AQXT5xhY6XHYxuaI8V4W5jWl670AmINwGpzl9qC
s8MHwOEXb0sO4kosiO9D5tsrtHR7dMn8JF/fDUmG2C8gH+oTKUAN7vvPlJ4BOvH1evne7WUdtS5I
eplm9xU7QjYu1pzcT2tT3WbtNXc9+Y7M9lmXSH94+Ht+N5NSt/g7raLP64l5cBiJOmADPmcpqkGF
yMf85P+xOXC6IIhBOUW68jgVsadx1FoNu1iMSidJ6TtBgxtxPBqQsBuMGi6k+UOxgj1EDyOHdrIj
H2VYIj98ydNLWVZlmD4hk9cpM0YiTxqqsU2hTjH79Wg08VA7d+I3vc0oOplagBAYhdvpa1fYBdHx
H/Egsd6VwMjtPwq48iyzkf9gtmsQ7QNoI3jL6bvsja2aPOpAbHtJGmz108YAhBLXhLhMMCaz3gYh
hM7/YWxV8uOtbpLf9yji1P9mgSxYiLKKVOcs3GdMSF5m/vcyN2gPvYc0etOBEcTXIEtvfpLhm2o6
60+3JbXaKz/pOhXcnBCWReB6ofbAYL/MZRWDY0H5W1BraVGcxorhqP5p/CL0IhQedDfu/YYbrIsV
Q47br4MfHHI57qypwo0DCwRAqf2wXAlweQd+WJ1Am6cb4Uv7n0wbtBeQZw8HtCzOE9VAcG01tHAY
V5FBsD3fN5R940C1BDkIFXMf/rLn3Jsh5F0BkEWPl53tYYyuIKEUvN8JEJKbH/YGX5Xy+vPdCrKS
vFT1DY51hseVAXVIS5n5ngZpWkH642sm+MAjXHUbluPq2A5iPZUHHMlw0JKbmT+yuHutxybvBY17
iBvgO070YICcMS1wKOsL7D3cXgOdqRsYZKYcNEPUlds9QfqfB2kVGBpN1v+p0x6EdrFt2QHPcOI8
6S8OCQ482jQ1jlrzMO+6GNjJpWlSz9Rs2evxgX4s2AhRSljQb02bWoQda/BTxcudd6dfTXAH61bx
/4gB8kBP2IO9jmrSWTmHC94BpWEnp8uQ/SWFrUO2Z5CpKBdg9lpqwa1mGyUrA/sjK2x/3GBL+ef3
kTLXIeVhA7D8WJ2qrqpO4lMCgl6IPkeGh4k/LeUlqL8qWVYXMacVLxBFqncdZwP5I6W/F4yn037R
GlEv/HUIQZtWK1EGuAN1gtFOFfP1OmPhVeqzpAULOT1aE0/A5ZJAf4eU3RY+Nz2GxmWBVodCJO3c
/l9J7P9thqD5pcBJMDgYB5asFRojeYHt7cUGGleiZj781YjmAociFMjcJ5xn6gElNdzU4z6k4izA
pxv8K9vrKMWmFQ1QFHqxY+Vzm3HM3PEPHNSEGMXZwCJFC7ae4+VwEkNcIfOHWgwxDzWGi92zlwXU
ztOGY+WsWSz0Rl5leEtOfbd2ifZ5O9vaC1vmtaEQQ97bebeLLhGPuslmrpnApeV+cjSXAuPZZGM2
Qj7tO7EBeMG7l9fehymqv+prfiBBNoFyQwyW5HBUIK4y+reK/akSmu0G6OaEQzN1kDf/tTfKicGH
vn4VgKF0yPaGQJTdeHbzeCthaQuGstle6l1tTmx5MyeEKan38aTPofB84Zmkfw7h2jKoI2UOhjva
68GPF/S6kmdSR2z+pZZt2QFjh4p7uN+/9C8QOAKthxFrxyp0SkeK/A+ut7gWo587qgJkZUt3XOyr
233Qg5ikpQfJ0ei7FanCnUXzHFbo9wN+BBnHE5E1/snvnXP9DKNiFS4b+cErx610tjMlcS01eKkM
qaKERu+QNMrlG5TjzG+hA7AOkuccBWwMGVPL4xj6E5IFX8BbKJIB4M8UNBb6pKTvh5GcLuitEhFh
MTjIy8IPO4Pwxs3hdqrI4rQnW6ZUCglo5cnLjvV9fLibjQF/sMv9FBS//+oDRNi8uldkODT7JDyU
Qkui50TprEblOURC7buwcpmTnNQ9jGNy7KdGw9xw1/8RawmUsfGWWHOY8YdWjjTXN9ql1VgwCK5b
CCcG+tqxq9wG19g8mxC3h/x0GnTg4i2l1dXbIyq0BPIZXVDanW4OwkQCXWKwliPHmfjXyCO8D3Qo
Jr5lFq4uvVO5eoHwF0HI9N1Wwh/KdLs/x3XiyG73Q3ob/6Lv6ZY/+ONNbYt0/+ssqxsa3cJ0OaYS
5Xqsdo5Iyd6pfDYOQjvaNmLlG5FhywkLmEvVnX5j0UCsuP0RkBrIJwmWbcZqlTBIr9UjX0rRz5jT
yrkSa3FSyBjoOmFhP0jcrHueedycKIabDsBx1m9XsfhXrmbLv6/vaW5Gg/pfXLBqN5em1qpyZ/Z3
MWo21U9magrfbG1YEXbIutVur+a5mpIFXF75hjqb4UjXPq4x/iKvekBECOzUUbuTpKwsmYl4Ka97
CzlErjJMHSUdu9cjW8QaMQvpiIV2c7KZ70MKwvqX9SQi3zdx2m8l4wHqsz6MQklSwDO037WXCL/h
7dC/qumX8p4ZibEhR9AHSMsuvKZ6syA9+tRNPBLgQ/zLVedGQOA9yjIwGpLlh3mmqTWI7p81uTg8
/O1LUN8T8bQJOCOwx+244JbDt/MVlKF7aZVuA8GwS53CG3jHSDThFeZqPnn2+ylNCoJODEi9SUNa
NjKRg3FrGaZej4bK+5V88jZQEwKa70Yq9qy3ZE/SGX7pyIz48U65/Fc25Fss3w3ygLJfxmY/Yvb0
HIigchAqxzC7qRwffher8aRUpSoA/xmxd9MjwnzJHNYsUhKNJqfmtV3xGRv1FCmF+Z9BivmrBqw2
PXJyTqD5kSbQwkBi4gsps4aII6p3jgCK6RHG8xhat99jprWhdNR8Yx9lv6+Fx7jCq0Y42yKnZtHO
mUYhAxKKe73hhzlHFCBPgPnurjRiiAmEvF1IP76GnsdRdmWpDI/7rPvRfB2DXt3jihnqrW8yEQCV
6UIOHP8gXIVqsIAg+VuKoZtUURQlJ0SL+TahyA8e8dXvHzv/nlt7gV3ASloxZc6y96Dle3wSE/ii
bFZLJqEfwPNKlrt0qt84g9dnuQ6kMdLn52ryKM3WnyEK+TaG/mrfI97BXaXR+XwgDU4SZ4iUgQli
Px2GlcWPyCfTHf4yMHg3fGVbnwhpTFquem+L12IuLkGHCvUhWMkjQG4l5QWOxtbnT6XEu3hECqNr
bVo4/ISKv8XBYeFCGolNkZw8UU0uCqoJUSpydzGGuD5qSdogjJLdOwn8F5saJ/+/SRXyOgzmdt/Z
GJ+altyfgzaMKXvlBe8nwZ661tqojgEZACTzx7cY0XSX9K7KswKyz83WkjoAiVqeU0Qvg4w3p4A0
hsuwF/y2Gy9z0r45lGOpgZfxBo33L7nYwMrqwfLmj/bE+YLf72Fz/c3tloFtBvkr1kASikuq/SUu
IRlhLZK93tun2J7BYckzPNOaUkYXBIT21kjaJywRtVS64I7blxHixRGMM8vEQ0W93prBytBNiQkV
52gSh5l5aoHCZmKkE0ODGhNea1xb5waNBOQvbGrLhm1fp+sMB+ctVE9cpC/BDIRsfj56mejekIRr
6bW7FgCq4iQJ6E67vf/EgvdbbJEyTqJNCtSf9tN0Pr4kVhRjD2V6WJRuuZOFcXzjG1PkPT13ePkL
KTV8Gm0uav4rEbV8acE8d38V3dDYvOIox3c4o6bvxgoUq4gLXYDQCYoMFoXiV4kGsBt9pMqjtYrN
qzMX2EBIy3ugxCwUeugX+CpUoCh7AUVrIQM5qwTR+CxPqQ57jIG3HH3ouZAQ39kb/YLs0/L9G5SX
fdFMujAgHRwT9lX9ALCOErLSv5nQ1llj/sKDWZSIEzOhcx5Tfu77HHC79XuZqeZ7H957DPK3ByXL
Wq67LKbyde8ganPUmSAmqGF1tMX/i1UjI12ZIwNhXzUmQEX3WE7bie+5l/eh/W2KkN5W/KW9dTVt
z30gQVpYRj7a5QD1quqXMvoYstYg+FSD5XeacS7VRETqXOB0lCBf+RaXgK7JQrExjxGfLVTQUN30
TBmVUTc+KwjIkd2/kyX7yS0bpmmgVz/rHCFasCVetyqRXST4zoNMtIUJLSDRIWHTfn9CYcSm/ktX
jpdFeVRoqzyC/TnVw/YF5wnbylV1eAzbKwxc+vImhTz8fk82/rtsH4/IcVRfHo9J3AMTZCQKmG8R
7N/klCBkGCjrizVew3O8r8lXSzJSZSHNkxECBpjj7IgW1KHAOBi/KDnAdl0KJe6a5eiZ9hyRgNkE
THZ+7gxP6yEw4l2oKfPdEZIaKsIi4H8F0oOI0jQv6U8htLthpoO6Uq6IEnFbp+xckmLPHdXtnVoj
aMHykrk+w/utK/Z2190w2rtvJLzV2X7wedB7uV60oUckQPeNRRjm9d/m55Aevryk3Kq0cKG6ec6S
Pg5DMFcW/maghlm3gCOz4YJF4Pg7U/pLzzfvOnIogi8W/C77Q8vo43UEA0j3YxtWNbsUNyb0JqvJ
EIJm32wLLyQQDsVmHJDtb83PIrsW5dBDoYKpm/khDGv5Efmj2/XQKo6U8hDgEbRDbtk+oRbnAUNr
+6szdvN0MxTS9OLZgbXUppGFTxXgXoIU/yLHXLcrKozM0c25NCNKsQehRCoxkxfzjwAUX81nASlT
PPs1i0WxMTR08RIm9YSO4XfKtXDU4dbrZoxBX1hsabMO2Me/hlAAc3+Nlx8VlhhGlf3XqDI5QSYV
F5kAJA36NY3+eN5lQNobpfYk3Y1W9eN0ssCwR+pMJKPBfJsJjIG9jWHS6r/4iy/8odwcmDWKOZsY
iKWLUjCHr4ioB9zLnGp7cf5uGXM8H1hjaeWJUU3+4M6BuzAYfMeDp/UlyBz5LdrVtP5H4vriKlyM
Kg/av4UANoyYr19M1dAGtfqS1tz2tXiwWYZDluJmEH/1vmq8ReTmS3TvPRUnOroqMFBnbFZ5dWjo
uLiaqTB40sx5fKdbDkTpbrNw52/rH2teaqdmpZ6GdjAVQ35R1LKRdlawut7ZEA9BM5kEDwuJQ7PA
bunnUNf52yGgTpuyW4buv/SvBhrqUg8if/4xxS1cqKiYUdvMZJRfpSIGhjnv6O5O0VMtUbUb8qWn
sxbqtzbGkSoz9umJ8B0NztXvn8/tmmGcY8BPjY54247chRahRcEZnevVZfIufe9UBg0EjQsxntEi
PoE49nEsZw2HD4Cc8RlbCsVbN7dO3w/3Z0LHeUp/E1cUNr1yz/wJm3YkyhK/nmAaAok5dyDEU4EJ
uTuZzRhU6FC4gaD8/QkNF7uWc2MEYQr/n27ljIV1zwlpjQfN+naY/BtuchjnIPMJKdVnRsAem9zW
d9/XGO8JOOjEusMD57VqixY7qJLlSkWX5rd+8xAm8bNhbgbig0xfa73vSVELC5FDwh/ESONxqnh8
29pXW1OC/CW6w0JyN2ISLUylQRzzbi7aazC85RNcRflFfSG91c0GYI8yy9NHFqvnuANcTCLRNjnf
BGf/bw4bbzZ6AppWizORjgCpCfnkWe7Amjs0aGUyEXcAiXe2Cgf20Ca7ajV5BgOi5I7bxrHcQSyT
vtDNfUBNgtiBFV/YWJR6fJ6CXBjFFp1kSaGF8jypnVR0gWH40dxFODBLjLjYNl19Bsz0zdgiLcVh
ZjCEtDJBzyssf4L2jRuJ2/415Pk1yodifW0fUSW1C7K+DCxYUQCe2zN9MOZVsF3ieOtPLNf51k52
IHYTC7/OZwUMNZGC5vLFux7d1iwjs7Ht+8N53MR1edgnwfAzOjxoU4Ur48oYp14/tTc3zzUEAh2i
RcvS7enbog5W+E5zQgUKGvToytXjB0vpIE2pbZE8ImywsbB4RDMfxBG/QxLgactOxeQo1JlhxklV
lVcrloMRche65lmhMZEVRD5KwUfohQKMuczWXm5077oB6byWdv2Q77JBPej2SQnBD4yCwCKbt/MS
f7czhLMggYR+tlXdQsaQD/bj2sAHjBe5v+Bk+f/QHmJlXPVT/lR3Yl7IA1ASQjErfoSgf/WS0f6Y
Tq9795ygvlxZXDl6+eNFyydWDTa3+IRAbvkyeHn/Ezp0TP2RF74aqMPNYh524HPWIBFwS888duL4
YitlEGCVWM+cHl11Zh9VGpCN4A7sY5Xsd6EcBJbCjhQrragdIjcCPW+40d6CMACnBZOCta+vMiwa
zgwIlSpUybZu6B2ykuUN6mqFeHR/LtuNDgykJWfE8GIZQkbMndxzXGKnGsZ4EzHQlG2JGiWg1SvW
HkuzDlTwLCKocZ94HiNW2ZCzbC/ExqfcFli7y6fCvzBqbLHvTfZXO2msXv9av/L3ueyjRUu/TxKi
RMXN12kWfynuMAfrdeoGmwLFr7Q7UZCIszcBX2t00DrW/V7prNvWd1XUJuMI8SjKNjGzwO85ep/s
ErL2Cgq1NbwDYrKPxn7+ft2SdGmyPVDdfVBwUYFAN+LAdxV+nTWgk9TuY98/LEXJ16q593FCuEHS
YPcoxNI6A00b+T1dWyVV+YUtiXYM2ALNUPVMWX5Bry8lR67AE8vrX7iJBLrPWIPXVfvwVUdYGI4Y
ylp5AF2CQRGfMzSeTTFl2w1gyDRLiw8ZPHbJdNMxAXCTu0gspDz3w4xRDRM1BedXPHpalI8Jw5U3
F9PMoQfNpQTMJiw+keU9GPEp9dTb48Z/ICkUXTq9PmwG+guTs6gYv2tA07K500EsES0vleEw9KSc
GqlWvoZWjp0tUNS+bHDhyfx4E1whXn79JZcok9gD7Xmm6qr91TfvsKm2ENYEFCWgnl9fvypxWYBk
IoNvwnQJ17EWu6oLPy7QlJV9hCdh5jgb5Y6AMxGP9t5bAEVg5AbqSNSAUCQH04osMtg6ztbVGYX8
ayr+qYoN6LiQ15EzIQWdmx1Tm6xjw0s0/7l4P7XvXw09kKnkuL7f/9puId1dGk0jUfK2z0tNw+s7
ao/4hheQ93zghghKCp58UoPzvTAEfq8gD4GKi1LXnGla5KHIwtXPWf7L4ziZ9SJm62R799w4iFpq
092d8etNZDjBlMB+og0V2M271JXgXAZIZwmlkE/vemDuGxPI/Iw5ceqERK/tqicZS5CKEkzZiQVD
YgcBwN7Z7BZK1SHrSlPgF/YuXVrWSIz1+3s5yLlK8lSdbu50qsPhKRtV8xqrCtAVdBOm/XjoCW2U
B+wAS1haSUn6Y0j8rEXmec5uINhQOuXFGw20j/HbsUCMp9E1Qsnc2zydRMdGqgraOXxjaPX7i8cm
qKODvGvU/hnIb3IO4XzJHngt/AOV5D5NVSkqPC/nlHogmsaNjPerm2eGkiyUbNDRoOU2bSxXSE9T
EdI3Lz9ULdW+bNnCD4ZPGGP5EAjZSoMxCllv+FxTWq7uAHzR3gvquh4VZw8O0NlCfTP+AcCm2QlO
rNarAsc+1tivLtzPPbFL3RoraFXzBmm6HOlWnzAtnk+QogIQWH75SUPBCuXpGriYgXuVQbgaL8+J
koblunIusZpJplFHo6xLhSKWVsQCw5Ryws4J7E+6bJ1WnS8wYiT+qmcaNftASKUpWONl2uDZ2SoT
+Ji4znfneWCN5tJ1KxGJWDC6OAKTe2M8q584MQRMao2c+95r01KQMY8QyaKexBt+yTchl/4yoqtB
JGMIH+omcmFCdRLlUGvla4m8HWRBXovl8yG4rIl4fPAKEZQD5o+H8XfuL64A2hf0D1Y3/nH2zl6d
ZEVjuCG1lH7LFzvDEK0XYvDKfh8qc1/AcDYzYC2Yhcfp4DYtN/hraEZOOzrh/OhC2q+NQvYZgKYE
tbN/kkjU/u0wiyCh60i035WL48yEN1/2lb2Ypbwx2FYBaoUXa9xJcMtC3DYvBxIH8AyKOvCq6gyK
I3Gxj4NImkpD//xiPe0BQpeo+y2iOqbsje8FISc3GLG1c2Cdyboo9n2clD+NcCy8q52r9RdZOn4K
C7SyM40fNGY2Hori3T7K5KalGB5WzvmHa3FhhKcGv8PQ+x8hnLSRhkETvHHw9IDBlRHUA/c8MIHx
rucNQnN1OO17iB9iPHvtEXCDac3JU3cp9mOyQ/irpRu+dgxDaznlQyKH0KTNcCxxD1wOGRAdgq8w
WFtpw/rjChXGo5a17F0mFlENSDT7VQuSS+RXaj7+cgWZpmeQ0Mk4Mzm0tVK1KE+P0YjiTMTh80gw
ffj3UTc7BPsKFuqNMKB5TkHzjGx/byYGHmP4wGDG/fHGu0kZXO1gcNQilpDiuqEa1mqxAoNWioON
ZlavWcRKolPwzJ459sWWD1JGCdmIjLhFK+5GU2JDcPWZy3ox3Xe2A5uLuuKNPNE3jWW9eK3JDZJe
8qFolutwbv9CkLPenjxpv9ZwRyqW8FTgMrjZyGaHs81RnkqAOeHKJMxnQcizwnCAmFCZdsgpuz6o
tpVCJq+0CGD0C5tFqvJaIM4iNwNuW/rQLyll6eohDcVMl7tnQpvMOnx3ubMDV03sEX7cR1fV+70h
o5dXf2Q9AAEAcDf1tJel6ujipMr9knjeMeY/ZgZGOuPdD94qbc+NkrOarn+KsUTSDTpd6d42ArTI
vsSJslRxFarfY5xbCUoYyQOiRT2Iw2nu+tGCAybNO+cKol+sSKX1YIMSy4XNHid9oTLeA2PKhC9f
FOr3Azy/WyhcD4ufYomlGfQdnOwBWV2ICmEWS/tEYnjHVkH3leO5MC/e3+GyIOEy3k3tEyYMcx6f
8MxdyVDSBbM7vxDlydFoJOUUqeW+B6KziSgLznJr34p+XE9DdD9cKn1gELWNSLo4T9tG8/5spAEJ
JXcG8nJfRaIGiGzzf7t07mIAq7bmG5VG2Q0wPsN/0m8FmJpnHPmWa3anNoWbHvUrfK45sVFvZPSX
9U6u28fjgx62ymhQfy3CFFZE2vhdzC6UkP4n1t7q88c3Uk7j8XITRSzfIjTr3CA7M3dsi6lNS3wv
5p0BjENdPdcZs218ewqvOaxPY//WdpfiWYEHEc76DpdHNEO7F695F1+7K5zsxyRnYtX23tWW40Tg
O5epTo7VO05Yb4Bz8ByixAMkj7I3NiiSXsSSf8Bk+0nh3QLi0jROP3wPryb0FR7dV78XNdtKhz3B
37zMk/C8iOblrB5XAwPaAr9XkraTV13bMxI2dsPSyzfOSsQJqnHB1doM7e8Ym3VM+KyZM5NsqSdv
4qn9VHk9MbJ05jDgu8pdHJ/bMZC0ucHoaWCKWaOhvEoGXA86I7OqPIS0qIG4pyTkrJEqQnnsZxWg
OUSimFUh2vHT0INdaMT6k8P7dxnFIJPMspOtpgsO92bWjRTIyCY+qt+RIK2dROpfAVjyzEfwuB0G
h7N6kEBVomAKztSirQJbhAIxandbp0/k1xNzLUPtm7gLmpbBj+0z44PF+dX0cuAMf/syKymffDvx
FEnrNwGYhPYt28ujq92FrLEDliWGZ5sndAs4MCF5iu3fOBzQHAFyomWlNAiP7hniyuFoxl/ZmxUf
H8L+EOQ5B1KUx9lzWiq7W2rUusbUOEGg7v+cLQnCNfXWvFtfonrnNuqVJtrN+u9o2nafdxqJ+5v8
9JaFG77tknvy0MDQCLEnyyVHVSBZzySbnpvqoJULeQVuPu3augtGF9kokmhmebIZlGyAx6JCwoUa
CUbWK2rzWyP7JsdvwCDWxw+hlPGz14Av4an7TjVvfH//MchNawFrIZgJIZwyhLcPv8j59ui7OXaq
ihqi99piUay88zG/zVSCq1F0PgcCfIzKlwu1A33YD+aJ//e2bZ3MhUKtzw1wiSyYdFx3ZgtFi9Gt
Bw3xz3YdTfRH8MXYTrNrhSIzKrRsBOqge+9oUsHW09u95ayqp7TAULxkLdYyF66WmTMThosMDwzc
RPdJJjROH37isG1lIyoY6jPMhbm1vNP10TLiVjsC9vt5ucUu/xIS61t5i/Ogr1Ipx6tPS6ax0Ivd
Cu3f20ZD+ZUbUrjg8jknPkSGXTOvgKFDAWL81G8fLBhL8lyKIj1JOrP1Yo34XHRgHDru/GV/RHJG
zXJCdKguBWPOIPH37BQJqir65GGb2r6CcOgR4boK69PVZ9U//ljQfG+RcPBSx5CZvgYpWdQnqfbm
6hNFSar5IWaPfeIoRgzRS27ruXKShF78b7gAsDrAR2QAMLxSF92/mBkVYWSMaaDxOl3+OazxaCqL
g1dEc9aGT/+bCLNNJyu4ZSo5uOylIpucU3Ia79JKGhIZRW52jrhX2q1ljaij4pr/StYd5wzvUiwY
7sYMTbcWYAMLOcDGTjeSMXzqe4PJrL7iM0MVjomtoAkIRhcMvyGhGxS22lrCys9GDi/Ycnc6f6W5
hdKSRX9LpO0AhPgHLh0AnCth2MisKJB6fHQJxgSznh2qEriiDrAdRbKqSh2xnAMyQrpT35xPpRxs
QY9+oXITwq0cVoS4znj3RZi9L4jFSyLHDfXuoLPYgYhRue0ToWSPVW1C1ybEMHCPjSf5O3FuO5Ll
QP5wVD5/oV1RPL2U6AaYAJ6w3vdefRmHiyWuBnTEZ3Fc+0/+3O4H2x7aOrOAkvsX8VnjNC3uJ2lm
NmfnNkwGirnyG3XIDt05ot38WrxNKmHL+kcwlSv7rv/Njbb+/Ox/GQ5xjDOuMACRRNMaVyIqk0wL
UKC+OuGrkwVDr+4DpLGCeZCY+ny5Qtb01gJME6zDmrDCTdXp+Tvrao57V/YbdSQNDlIHcte8xE4Q
fcVXMUXLXWjDaHTkO6R/gLv3sVFdmo1r3xw/YwA4ZoY9ATiDbw+6ipRfp3UpytkGLoMCO1g3byFv
wDPG9TD42CD02baQ27BGBB6tsWksQ7i+7Af26BvPsPIpN6UEgPYiQlNfT2ZhVbbRRcz47Asa9cKJ
FoFZBj22RQazn389R88QvxJ+43rVqSze7KhJjGwKOMANDVGfzhAzJcj8BwYnwbcdOGdsIl0VZ70Y
izK1mQKlrdV9osBe1A1AJHPmOJsTEYuM8BZMowbxuCO4oqGcLPqW1DoOvVa8d8Na0hH3H7hUbrf5
oD13UuKu7ao5xturPyP+B3plx4TwUXRRwb8Onx1AK0OyS0yWYsgpmZ7ApBbqZPA3Vedad6K7Qput
0c92wi8gDhuqAODq+0E9XjUCtyAVvaGmXfqX9yrbUvnWDuzeIlDxK9Vd6la/8B+Dei27HLL+eJUx
mlPxH6djzu3MIk04vpDW9fefRrGE3BpAebrFSQHtIbeD55Rxny6zpHKHdIz4/IPEp8Ln51KF7MRY
EO6iw6gDOwanIYKSKvwxH1SyoTlchrw3N9+Eef7nSP32dd7mIKWzipMXq21QGvh0/9vEjE9VmTAt
jYkxExseNzvZYy2NTtMG//h4Io0KrU98W1yLtULedmgWxuTrNDMdu4qCKkuoAjCl2xLO4wsLbRbP
Wtqk+WJjWCC9qvT6tJWOU10QQZF1t0bIucX54L0R2SClov2j10rZ2GGiviRsmHloyH+chKvXUL+s
EMxhlw4XW5sqVXpFZhROYtk+60J+M+arr59zbmPaR1ubq3O0HuCAgpFXy0cJXbp6hlREjikYoBJP
Xaj40rFwR/eZA9sFds+4DPNqsD4lmIXQRaZjv/soMFLB7mBlQkmRWPnEvOo1zo0cUK9/pgwUKadk
pR0esvs65eRKbcO6mwTDxGzSYT5T7kqAaQyWpwzveAcWTon9+H/2CqVd+c1bK0qo2bGSDeyhRuGh
6jXmwv0j5PUDhzahXrHuHF2ewuzCIuHqRxDmrJJ8PXE1mcsa6boLJZpdLbuW+z859d/WG3R0I39O
dx1XFudTAs1A6l6MRY4R55asZbrwezm8bEXIzEwnPiAirY6c5M54R9/pUlnNY9zV0g/gAfXd0tGb
Ct0tACIanYgNeXDLPE5moaR/QLh2kCRtMC50Ll51lDw6CVzO8i76c3dBYWFw1y9OnrQWrGt80S6V
0lLGdvpOBCIAd6w012r/sOlyKStppFtNnJvk4CK4zuFF+aQuT8NGwmJh/6eXtlyq4v2Nd2tAy2mf
nphFgfMPEbt5fVSM9wmuzJlmTSiuzyJ63eEr/wMbUm57AAAA6jBDAnXEBu0AAYLYAsrNEOw3enyx
xGf7AgAAAAAEWVo=

--dlqobGt1ml2DdgNT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="xfstests"

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
Linux version 6.1.0-rc4-00062-gce10c493af38 (kbuild@205a9eb298e6) (gcc-11 (Debian 11.3.0-8) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39.90.20221231) #1 SMP Thu Jan 19 11:18:50 CST 2023
Command line: ip=::::lkp-skl-d07::dhcp root=/dev/ram0 RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/vmlinuz-6.1.0-rc4-00062-gce10c493af38 branch=linux-review/zhanchengbin/ext4-fix-inode-tree-inconsistency-caused-by-ENOMEM-in-ext4_split_extent_at/20230110-211157 job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=ce10c493af382439876867dcaee89c7efddfab46 initcall_debug nmi_watchdog=0 max_uptime=1200 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 s
KERNEL supported cpus:
Intel GenuineIntel
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
signal: max sigframe size: 2032
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000100-0x0000000000091bff] usable
BIOS-e820: [mem 0x0000000000091c00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000b30fafff] usable
BIOS-e820: [mem 0x00000000b30fb000-0x00000000b3c7efff] reserved
BIOS-e820: [mem 0x00000000b3c7f000-0x00000000b3e7efff] ACPI NVS
BIOS-e820: [mem 0x00000000b3e7f000-0x00000000b3efefff] ACPI data
BIOS-e820: [mem 0x00000000b3eff000-0x00000000b3efffff] usable
BIOS-e820: [mem 0x00000000b3f00000-0x00000000be7fffff] reserved
BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] reserved
BIOS-e820: [mem 0x00000000fed84000-0x00000000fed84fff] reserved
BIOS-e820: [mem 0x00000000fedb0000-0x00000000fedbffff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff700000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000043f7fffff] usable
printk: debug: ignoring loglevel setting.
printk: bootconsole [earlyser0] enabled
NX (Execute Disable) protection: active
SMBIOS 2.7 present.
DMI: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
tsc: Detected 3400.000 MHz processor
tsc: Detected 3399.906 MHz TSC
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x43f800 max_arch_pfn = 0x400000000
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
last_pfn = 0xb3f00 max_arch_pfn = 0x400000000
Scan for SMP in [mem 0x00000000-0x000003ff]
Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Scan for SMP in [mem 0x000f0000-0x000fffff]
Scan for SMP in [mem 0x00091c00-0x00091fff]
Using GB pages for direct mapping
RAMDISK: [mem 0x41ddde000-0x43a5fffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000FBE30 000024 (v02 HPQOEM)
ACPI: XSDT 0x00000000B3EFD0E8 0000AC (v01 HPQOEM SLIC-WKS 00000000      01000013)
ACPI: FACP 0x00000000B3EF1000 0000F4 (v05 HPQOEM SLIC-WKS 00000000 HP   00000001)
ACPI: DSDT 0x00000000B3ECD000 0209E1 (v02 HPQOEM 802E     00000000 INTL 20121018)
ACPI: FACS 0x00000000B3E6A000 000040
ACPI: SSDT 0x00000000B3EFC000 000108 (v02 HP     ShmTable 00000001 INTL 20121018)
ACPI: TCPA 0x00000000B3EFB000 000032 (v02 HPQOEM EDK2     00000002      01000013)
ACPI: SSDT 0x00000000B3EFA000 0003B8 (v02 HPQOEM TcgTable 00001000 INTL 20121018)
ACPI: UEFI 0x00000000B3E7A000 000042 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: SSDT 0x00000000B3EF4000 0051FA (v02 SaSsdt SaSsdt   00003000 INTL 20121018)
ACPI: SSDT 0x00000000B3EF3000 0005B1 (v01 Intel  PerfTune 00001000 INTL 20121018)
ACPI: WSMT 0x00000000B3EF2000 000028 (v01 HPQOEM 802E     00000001 HP   00000001)
ACPI: HPET 0x00000000B3EF0000 000038 (v01 HPQOEM 802E     00000001 HP   00000001)
ACPI: APIC 0x00000000B3EEF000 0000BC (v01 HPQOEM 802E     00000001 HP   00000001)
ACPI: MCFG 0x00000000B3EEE000 00003C (v01 HPQOEM 802E     00000001 HP   00000001)
ACPI: SSDT 0x00000000B3ECC000 00019A (v02 HPQOEM Sata0Ide 00001000 INTL 20121018)
ACPI: SSDT 0x00000000B3ECB000 000729 (v01 HPQOEM PtidDevc 00001000 INTL 20121018)
ACPI: SSDT 0x00000000B3ECA000 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 20121018)
ACPI: ASF! 0x00000000B3EC9000 0000A5 (v32 HPQOEM  UYA     00000001 TFSM 000F4240)
ACPI: FPDT 0x00000000B3EC8000 000044 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: BGRT 0x00000000B3EC7000 000038 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: Reserving FACP table memory at [mem 0xb3ef1000-0xb3ef10f3]
ACPI: Reserving DSDT table memory at [mem 0xb3ecd000-0xb3eed9e0]
ACPI: Reserving FACS table memory at [mem 0xb3e6a000-0xb3e6a03f]
ACPI: Reserving SSDT table memory at [mem 0xb3efc000-0xb3efc107]
ACPI: Reserving TCPA table memory at [mem 0xb3efb000-0xb3efb031]
ACPI: Reserving SSDT table memory at [mem 0xb3efa000-0xb3efa3b7]
ACPI: Reserving UEFI table memory at [mem 0xb3e7a000-0xb3e7a041]
ACPI: Reserving SSDT table memory at [mem 0xb3ef4000-0xb3ef91f9]
ACPI: Reserving SSDT table memory at [mem 0xb3ef3000-0xb3ef35b0]
ACPI: Reserving WSMT table memory at [mem 0xb3ef2000-0xb3ef2027]
ACPI: Reserving HPET table memory at [mem 0xb3ef0000-0xb3ef0037]
ACPI: Reserving APIC table memory at [mem 0xb3eef000-0xb3eef0bb]
ACPI: Reserving MCFG table memory at [mem 0xb3eee000-0xb3eee03b]
ACPI: Reserving SSDT table memory at [mem 0xb3ecc000-0xb3ecc199]
ACPI: Reserving SSDT table memory at [mem 0xb3ecb000-0xb3ecb728]
ACPI: Reserving SSDT table memory at [mem 0xb3eca000-0xb3ecae72]
ACPI: Reserving ASF! table memory at [mem 0xb3ec9000-0xb3ec90a4]
ACPI: Reserving FPDT table memory at [mem 0xb3ec8000-0xb3ec8043]
ACPI: Reserving BGRT table memory at [mem 0xb3ec7000-0xb3ec7037]
mapped APIC to ffffffffff5fc000 (        fee00000)
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x000000043f7fffff]
NODE_DATA(0) allocated [mem 0x43f7d5000-0x43f7fffff]
cma: Reserved 200 MiB at 0x0000000100000000
Zone ranges:
DMA      [mem 0x0000000000001000-0x0000000000ffffff]
DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x000000043f7fffff]
Device   empty
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x0000000000090fff]
node   0: [mem 0x0000000000100000-0x00000000b30fafff]
node   0: [mem 0x00000000b3eff000-0x00000000b3efffff]
node   0: [mem 0x0000000100000000-0x000000043f7fffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000043f7fffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 111 pages in unavailable ranges
On node 0, zone DMA32: 3588 pages in unavailable ranges
On node 0, zone Normal: 16640 pages in unavailable ranges
On node 0, zone Normal: 2048 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
Reserving Intel graphics memory at [mem 0xb6800000-0xbe7fffff]
ACPI: PM-Timer IO Port: 0x1808
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
TSC deadline timer available
smpboot: Allowing 8 CPUs, 0 hotplug CPUs
mapped IOAPIC to ffffffffff5fb000 (fec00000)
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x00091000-0x00091fff]
PM: hibernation: Registered nosave memory: [mem 0x00092000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0xb30fb000-0xb3c7efff]
PM: hibernation: Registered nosave memory: [mem 0xb3c7f000-0xb3e7efff]
PM: hibernation: Registered nosave memory: [mem 0xb3e7f000-0xb3efefff]
PM: hibernation: Registered nosave memory: [mem 0xb3f00000-0xbe7fffff]
PM: hibernation: Registered nosave memory: [mem 0xbe800000-0xdfffffff]
PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xefffffff]
PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfcffffff]
PM: hibernation: Registered nosave memory: [mem 0xfd000000-0xfe7fffff]
PM: hibernation: Registered nosave memory: [mem 0xfe800000-0xfebfffff]
PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed0ffff]
PM: hibernation: Registered nosave memory: [mem 0xfed10000-0xfed19fff]
PM: hibernation: Registered nosave memory: [mem 0xfed1a000-0xfed83fff]
PM: hibernation: Registered nosave memory: [mem 0xfed84000-0xfed84fff]
PM: hibernation: Registered nosave memory: [mem 0xfed85000-0xfedaffff]
PM: hibernation: Registered nosave memory: [mem 0xfedb0000-0xfedbffff]
PM: hibernation: Registered nosave memory: [mem 0xfedc0000-0xfedfffff]
PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xff6fffff]
PM: hibernation: Registered nosave memory: [mem 0xff700000-0xffffffff]
[mem 0xbe800000-0xdfffffff] available for PCI devices
Booting paravirtualized kernel on bare hardware
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
percpu: Embedded 66 pages/cpu s233448 r8192 d28696 u524288
pcpu-alloc: s233448 r8192 d28696 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
Fallback order for Node 0: 0 
Built 1 zonelists, mobility grouping on.  Total pages: 4074328
Policy zone: Normal
Kernel command line: ip=::::lkp-skl-d07::dhcp root=/dev/ram0 RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/vmlinuz-6.1.0-rc4-00062-gce10c493af38 branch=linux-review/zhanchengbin/ext4-fix-inode-tree-inconsistency-caused-by-ENOMEM-in-ext4_split_extent_at/20230110-211157 job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=ce10c493af382439876867dcaee89c7efddfab46 initcall_debug nmi_watchdog=0 max_uptime=1200 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on pan
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk= option
Unknown kernel command line parameters "nokaslr RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/vmlinuz-6.1.0-rc4-00062-gce10c493af38 branch=linux-review/zhanchengbin/ext4-fix-inode-tree-inconsistency-caused-by-ENOMEM-in-ext4_split_extent_at/20230110-211157 job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-func commit=ce10c493af382439876867dcaee89c7efddfab46 max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 prompt_ramdisk=0 vga=normal", will be passed to user space.
random: crng init done
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
software IO TLB: area num 8.
Memory: 3055344K/16556592K available (40969K kernel code, 13624K rwdata, 8504K rodata, 3112K init, 4444K bss, 3281940K reserved, 204800K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Kernel/User page tables isolation: enabled
ftrace: allocating 46993 entries in 184 pages
ftrace: allocated 184 pages with 4 groups
rcu: Hierarchical RCU implementation.
rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Trampoline variant of Tasks RCU enabled.
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
calling  con_init+0x0/0x579 @ 0
Console: colour VGA+ 80x25
printk: console [tty0] enabled
initcall con_init+0x0/0x579 returned 0 after 0 usecs
calling  hvc_console_init+0x0/0x14 @ 0
initcall hvc_console_init+0x0/0x14 returned 0 after 0 usecs
calling  univ8250_console_init+0x0/0x27 @ 0
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
printk: bootconsole [earlyser0] disabled
initcall univ8250_console_init+0x0/0x27 returned 0 after 0 usecs
ACPI: Core revision 20220331
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
APIC: Switch to symmetric I/O mode setup
x2apic: IRQ remapping doesn't support X2APIC mode
masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
apic 2 pin 0 not connected
IOAPIC[0]: Preconfigured routing entry (2-1 -> IRQ 1 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-2 -> IRQ 0 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-3 -> IRQ 3 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-4 -> IRQ 4 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-5 -> IRQ 5 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-6 -> IRQ 6 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-7 -> IRQ 7 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-8 -> IRQ 8 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-9 -> IRQ 9 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-10 -> IRQ 10 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-11 -> IRQ 11 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-12 -> IRQ 12 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-13 -> IRQ 13 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-14 -> IRQ 14 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-15 -> IRQ 15 Level:0 ActiveLow:0)
apic 2 pin 16 not connected
apic 2 pin 17 not connected
apic 2 pin 18 not connected
apic 2 pin 19 not connected
apic 2 pin 20 not connected
apic 2 pin 21 not connected
apic 2 pin 22 not connected
apic 2 pin 23 not connected
apic 2 pin 24 not connected
apic 2 pin 25 not connected
apic 2 pin 26 not connected
apic 2 pin 27 not connected
apic 2 pin 28 not connected
apic 2 pin 29 not connected
apic 2 pin 30 not connected
apic 2 pin 31 not connected
apic 2 pin 32 not connected
apic 2 pin 33 not connected
apic 2 pin 34 not connected
apic 2 pin 35 not connected
apic 2 pin 36 not connected
apic 2 pin 37 not connected
apic 2 pin 38 not connected
apic 2 pin 39 not connected
apic 2 pin 40 not connected
apic 2 pin 41 not connected
apic 2 pin 42 not connected
apic 2 pin 43 not connected
apic 2 pin 44 not connected
apic 2 pin 45 not connected
apic 2 pin 46 not connected
apic 2 pin 47 not connected
apic 2 pin 48 not connected
apic 2 pin 49 not connected
apic 2 pin 50 not connected
apic 2 pin 51 not connected
apic 2 pin 52 not connected
apic 2 pin 53 not connected
apic 2 pin 54 not connected
apic 2 pin 55 not connected
apic 2 pin 56 not connected
apic 2 pin 57 not connected
apic 2 pin 58 not connected
apic 2 pin 59 not connected
apic 2 pin 60 not connected
apic 2 pin 61 not connected
apic 2 pin 62 not connected
apic 2 pin 63 not connected
apic 2 pin 64 not connected
apic 2 pin 65 not connected
apic 2 pin 66 not connected
apic 2 pin 67 not connected
apic 2 pin 68 not connected
apic 2 pin 69 not connected
apic 2 pin 70 not connected
apic 2 pin 71 not connected
apic 2 pin 72 not connected
apic 2 pin 73 not connected
apic 2 pin 74 not connected
apic 2 pin 75 not connected
apic 2 pin 76 not connected
apic 2 pin 77 not connected
apic 2 pin 78 not connected
apic 2 pin 79 not connected
apic 2 pin 80 not connected
apic 2 pin 81 not connected
apic 2 pin 82 not connected
apic 2 pin 83 not connected
apic 2 pin 84 not connected
apic 2 pin 85 not connected
apic 2 pin 86 not connected
apic 2 pin 87 not connected
apic 2 pin 88 not connected
apic 2 pin 89 not connected
apic 2 pin 90 not connected
apic 2 pin 91 not connected
apic 2 pin 92 not connected
apic 2 pin 93 not connected
apic 2 pin 94 not connected
apic 2 pin 95 not connected
apic 2 pin 96 not connected
apic 2 pin 97 not connected
apic 2 pin 98 not connected
apic 2 pin 99 not connected
apic 2 pin 100 not connected
apic 2 pin 101 not connected
apic 2 pin 102 not connected
apic 2 pin 103 not connected
apic 2 pin 104 not connected
apic 2 pin 105 not connected
apic 2 pin 106 not connected
apic 2 pin 107 not connected
apic 2 pin 108 not connected
apic 2 pin 109 not connected
apic 2 pin 110 not connected
apic 2 pin 111 not connected
apic 2 pin 112 not connected
apic 2 pin 113 not connected
apic 2 pin 114 not connected
apic 2 pin 115 not connected
apic 2 pin 116 not connected
apic 2 pin 117 not connected
apic 2 pin 118 not connected
apic 2 pin 119 not connected
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3101f59f5e6, max_idle_ns: 440795259996 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. 6799.81 BogoMIPS (lpj=3399906)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
Yama: becoming mindful.
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Mitigation: IBRS
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
RETBleed: Mitigation: IBRS
Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
MDS: Mitigation: Clear CPU buffers
MMIO Stale Data: Mitigation: Clear CPU buffers
SRBDS: Mitigation: Microcode
Freeing SMP alternatives memory: 40K
smpboot: CPU0: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (family: 0x6, model: 0x5e, stepping: 0x3)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 3 and lim to 1.
cblist_init_generic: Setting shift to 3 and lim to 1.
cblist_init_generic: Setting shift to 3 and lim to 1.
calling  init_hw_perf_events+0x0/0x676 @ 1
Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
... version:                4
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
initcall init_hw_perf_events+0x0/0x676 returned 0 after 8000 usecs
calling  init_real_mode+0x0/0xc1 @ 1
initcall init_real_mode+0x0/0xc1 returned 0 after 0 usecs
calling  trace_init_perf_perm_irq_work_exit+0x0/0x13 @ 1
initcall trace_init_perf_perm_irq_work_exit+0x0/0x13 returned 0 after 0 usecs
calling  bp_init_aperfmperf+0x0/0x5a @ 1
Estimated ratio of average max frequency by base frequency (times 1024): 1024
initcall bp_init_aperfmperf+0x0/0x5a returned 0 after 1000 usecs
calling  register_nmi_cpu_backtrace_handler+0x0/0x16 @ 1
initcall register_nmi_cpu_backtrace_handler+0x0/0x16 returned 0 after 0 usecs
calling  kvm_setup_vsyscall_timeinfo+0x0/0xdd @ 1
initcall kvm_setup_vsyscall_timeinfo+0x0/0xdd returned 0 after 0 usecs
calling  spawn_ksoftirqd+0x0/0x39 @ 1
initcall spawn_ksoftirqd+0x0/0x39 returned 0 after 0 usecs
calling  migration_init+0x0/0xd1 @ 1
initcall migration_init+0x0/0xd1 returned 0 after 0 usecs
calling  srcu_bootup_announce+0x0/0x78 @ 1
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 400.
initcall srcu_bootup_announce+0x0/0x78 returned 0 after 2000 usecs
calling  rcu_spawn_gp_kthread+0x0/0x315 @ 1
initcall rcu_spawn_gp_kthread+0x0/0x315 returned 0 after 0 usecs
calling  check_cpu_stall_init+0x0/0x1b @ 1
initcall check_cpu_stall_init+0x0/0x1b returned 0 after 0 usecs
calling  rcu_sysrq_init+0x0/0x22 @ 1
initcall rcu_sysrq_init+0x0/0x22 returned 0 after 0 usecs
calling  trace_init_flags_sys_enter+0x0/0xf @ 1
initcall trace_init_flags_sys_enter+0x0/0xf returned 0 after 0 usecs
calling  trace_init_flags_sys_exit+0x0/0xf @ 1
initcall trace_init_flags_sys_exit+0x0/0xf returned 0 after 0 usecs
calling  cpu_stop_init+0x0/0x164 @ 1
initcall cpu_stop_init+0x0/0x164 returned 0 after 0 usecs
calling  init_kprobes+0x0/0x259 @ 1
initcall init_kprobes+0x0/0x259 returned 0 after 0 usecs
calling  init_events+0x0/0xc2 @ 1
initcall init_events+0x0/0xc2 returned 0 after 0 usecs
calling  init_trace_printk+0x0/0xc @ 1
initcall init_trace_printk+0x0/0xc returned 0 after 0 usecs
calling  event_trace_enable_again+0x0/0x1f @ 1
initcall event_trace_enable_again+0x0/0x1f returned 0 after 0 usecs
calling  irq_work_init_threads+0x0/0x3 @ 1
initcall irq_work_init_threads+0x0/0x3 returned 0 after 0 usecs
calling  static_call_init+0x0/0x81 @ 1
initcall static_call_init+0x0/0x81 returned 0 after 0 usecs
calling  jump_label_init_module+0x0/0x11 @ 1
initcall jump_label_init_module+0x0/0x11 returned 0 after 0 usecs
calling  init_zero_pfn+0x0/0xbb @ 1
initcall init_zero_pfn+0x0/0xbb returned 0 after 0 usecs
calling  init_fs_inode_sysctls+0x0/0x22 @ 1
initcall init_fs_inode_sysctls+0x0/0x22 returned 0 after 0 usecs
calling  init_fs_locks_sysctls+0x0/0x22 @ 1
initcall init_fs_locks_sysctls+0x0/0x22 returned 0 after 0 usecs
calling  dynamic_debug_init+0x0/0x3b9 @ 1
initcall dynamic_debug_init+0x0/0x3b9 returned 0 after 0 usecs
calling  efi_memreserve_root_init+0x0/0x26 @ 1
initcall efi_memreserve_root_init+0x0/0x26 returned 0 after 0 usecs
calling  efi_earlycon_remap_fb+0x0/0xe8 @ 1
initcall efi_earlycon_remap_fb+0x0/0xe8 returned 0 after 0 usecs
calling  bpf_dispatcher_xdp_init+0x0/0x11 @ 1
initcall bpf_dispatcher_xdp_init+0x0/0x11 returned 0 after 0 usecs
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
masked ExtINT on CPU#1
#2
masked ExtINT on CPU#2
#3
masked ExtINT on CPU#3
#4
masked ExtINT on CPU#4
MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
#5
masked ExtINT on CPU#5
#6
masked ExtINT on CPU#6
#7
masked ExtINT on CPU#7
smp: Brought up 1 node, 8 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 8 processors activated (54398.49 BogoMIPS)
node 0 deferred pages initialised in 44ms
devtmpfs: initialized
x86/mm: Memory block size: 128MB
calling  bpf_jit_charge_init+0x0/0x3c @ 1
initcall bpf_jit_charge_init+0x0/0x3c returned 0 after 0 usecs
calling  ipc_ns_init+0x0/0x11a @ 1
initcall ipc_ns_init+0x0/0x11a returned 0 after 0 usecs
calling  init_mmap_min_addr+0x0/0x16 @ 1
initcall init_mmap_min_addr+0x0/0x16 returned 0 after 0 usecs
calling  pci_realloc_setup_params+0x0/0x41 @ 1
initcall pci_realloc_setup_params+0x0/0x41 returned 0 after 0 usecs
calling  inet_frag_wq_init+0x0/0x42 @ 1
initcall inet_frag_wq_init+0x0/0x42 returned 0 after 0 usecs
calling  e820__register_nvs_regions+0x0/0x14c @ 1
ACPI: PM: Registering ACPI NVS region [mem 0xb3c7f000-0xb3e7efff] (2097152 bytes)
initcall e820__register_nvs_regions+0x0/0x14c returned 0 after 11000 usecs
calling  cpufreq_register_tsc_scaling+0x0/0x76 @ 1
initcall cpufreq_register_tsc_scaling+0x0/0x76 returned 0 after 0 usecs
calling  reboot_init+0x0/0xa5 @ 1
initcall reboot_init+0x0/0xa5 returned 0 after 0 usecs
calling  init_lapic_sysfs+0x0/0x47 @ 1
initcall init_lapic_sysfs+0x0/0x47 returned 0 after 0 usecs
calling  alloc_frozen_cpus+0x0/0x21 @ 1
initcall alloc_frozen_cpus+0x0/0x21 returned 0 after 0 usecs
calling  cpu_hotplug_pm_sync_init+0x0/0x14 @ 1
initcall cpu_hotplug_pm_sync_init+0x0/0x14 returned 0 after 0 usecs
calling  wq_sysfs_init+0x0/0x2b @ 1
initcall wq_sysfs_init+0x0/0x2b returned 0 after 0 usecs
calling  ksysfs_init+0x0/0x99 @ 1
initcall ksysfs_init+0x0/0x99 returned 0 after 0 usecs
calling  schedutil_gov_init+0x0/0x11 @ 1
initcall schedutil_gov_init+0x0/0x11 returned 0 after 0 usecs
calling  pm_init+0x0/0xb0 @ 1
initcall pm_init+0x0/0xb0 returned 0 after 0 usecs
calling  pm_disk_init+0x0/0x3e @ 1
initcall pm_disk_init+0x0/0x3e returned 0 after 0 usecs
calling  swsusp_header_init+0x0/0x31 @ 1
initcall swsusp_header_init+0x0/0x31 returned 0 after 0 usecs
calling  rcu_set_runtime_mode+0x0/0x4b @ 1
initcall rcu_set_runtime_mode+0x0/0x4b returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0x18 @ 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
initcall init_jiffies_clocksource+0x0/0x18 returned 0 after 11000 usecs
calling  futex_init+0x0/0x206 @ 1
futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
initcall futex_init+0x0/0x206 returned 0 after 8000 usecs
calling  cgroup_wq_init+0x0/0x29 @ 1
initcall cgroup_wq_init+0x0/0x29 returned 0 after 0 usecs
calling  cgroup1_wq_init+0x0/0x29 @ 1
initcall cgroup1_wq_init+0x0/0x29 returned 0 after 0 usecs
calling  ftrace_mod_cmd_init+0x0/0xc @ 1
initcall ftrace_mod_cmd_init+0x0/0xc returned 0 after 0 usecs
calling  init_wakeup_tracer+0x0/0x2d @ 1
initcall init_wakeup_tracer+0x0/0x2d returned 0 after 0 usecs
calling  init_graph_trace+0x0/0x91 @ 1
initcall init_graph_trace+0x0/0x91 returned 0 after 0 usecs
calling  trace_events_eprobe_init_early+0x0/0x27 @ 1
initcall trace_events_eprobe_init_early+0x0/0x27 returned 0 after 0 usecs
calling  trace_events_synth_init_early+0x0/0x27 @ 1
initcall trace_events_synth_init_early+0x0/0x27 returned 0 after 0 usecs
calling  init_kprobe_trace_early+0x0/0x26 @ 1
initcall init_kprobe_trace_early+0x0/0x26 returned 0 after 0 usecs
calling  kasan_memhotplug_init+0x0/0xf @ 1
initcall kasan_memhotplug_init+0x0/0xf returned 0 after 0 usecs
calling  memory_failure_init+0x0/0x253 @ 1
initcall memory_failure_init+0x0/0x253 returned 0 after 0 usecs
calling  cma_init_reserved_areas+0x0/0x42 @ 1
initcall cma_init_reserved_areas+0x0/0x42 returned 0 after 4000 usecs
calling  fsnotify_init+0x0/0x79 @ 1
initcall fsnotify_init+0x0/0x79 returned 0 after 0 usecs
calling  filelock_init+0x0/0x177 @ 1
initcall filelock_init+0x0/0x177 returned 0 after 0 usecs
calling  init_script_binfmt+0x0/0x16 @ 1
initcall init_script_binfmt+0x0/0x16 returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x16 @ 1
initcall init_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
calling  init_compat_elf_binfmt+0x0/0x16 @ 1
initcall init_compat_elf_binfmt+0x0/0x16 returned 0 after 0 usecs
calling  configfs_init+0x0/0xea @ 1
initcall configfs_init+0x0/0xea returned 0 after 0 usecs
calling  debugfs_init+0x0/0xb3 @ 1
initcall debugfs_init+0x0/0xb3 returned 0 after 0 usecs
calling  tracefs_init+0x0/0x63 @ 1
initcall tracefs_init+0x0/0x63 returned 0 after 0 usecs
calling  securityfs_init+0x0/0xba @ 1
initcall securityfs_init+0x0/0xba returned 0 after 0 usecs
calling  pinctrl_init+0x0/0xae @ 1
pinctrl core: initialized pinctrl subsystem
initcall pinctrl_init+0x0/0xae returned 0 after 6000 usecs
calling  gpiolib_dev_init+0x0/0x121 @ 1
initcall gpiolib_dev_init+0x0/0x121 returned 0 after 0 usecs
calling  virtio_init+0x0/0x20 @ 1
initcall virtio_init+0x0/0x20 returned 0 after 0 usecs
calling  iommu_init+0x0/0x51 @ 1
initcall iommu_init+0x0/0x51 returned 0 after 0 usecs
calling  component_debug_init+0x0/0x1d @ 1
initcall component_debug_init+0x0/0x1d returned 0 after 0 usecs
calling  cpufreq_core_init+0x0/0xca @ 1
initcall cpufreq_core_init+0x0/0xca returned 0 after 0 usecs
calling  cpufreq_gov_performance_init+0x0/0x11 @ 1
initcall cpufreq_gov_performance_init+0x0/0x11 returned 0 after 0 usecs
calling  cpufreq_gov_powersave_init+0x0/0x11 @ 1
initcall cpufreq_gov_powersave_init+0x0/0x11 returned 0 after 0 usecs
calling  cpufreq_gov_userspace_init+0x0/0x11 @ 1
initcall cpufreq_gov_userspace_init+0x0/0x11 returned 0 after 0 usecs
calling  CPU_FREQ_GOV_ONDEMAND_init+0x0/0x11 @ 1
initcall CPU_FREQ_GOV_ONDEMAND_init+0x0/0x11 returned 0 after 0 usecs
calling  CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x11 @ 1
initcall CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x11 returned 0 after 0 usecs
calling  cpuidle_init+0x0/0x46 @ 1
initcall cpuidle_init+0x0/0x46 returned 0 after 0 usecs
calling  sock_init+0x0/0x9f @ 1
initcall sock_init+0x0/0x9f returned 0 after 1000 usecs
calling  net_inuse_init+0x0/0x29 @ 1
initcall net_inuse_init+0x0/0x29 returned 0 after 0 usecs
calling  net_defaults_init+0x0/0x29 @ 1
initcall net_defaults_init+0x0/0x29 returned 0 after 0 usecs
calling  init_default_flow_dissectors+0x0/0x50 @ 1
initcall init_default_flow_dissectors+0x0/0x50 returned 0 after 0 usecs
calling  netpoll_init+0x0/0x29 @ 1
initcall netpoll_init+0x0/0x29 returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x292 @ 1
NET: Registered PF_NETLINK/PF_ROUTE protocol family
initcall netlink_proto_init+0x0/0x292 returned 0 after 7000 usecs
calling  genl_init+0x0/0x43 @ 1
initcall genl_init+0x0/0x43 returned 0 after 0 usecs
calling  bsp_pm_check_init+0x0/0x14 @ 1
initcall bsp_pm_check_init+0x0/0x14 returned 0 after 0 usecs
calling  irq_sysfs_init+0x0/0xb8 @ 1
initcall irq_sysfs_init+0x0/0xb8 returned 0 after 0 usecs
calling  audit_init+0x0/0x1c9 @ 1
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1674249722.112:1): state=initialized audit_enabled=0 res=1
initcall audit_init+0x0/0x1c9 returned 0 after 6000 usecs
calling  release_early_probes+0x0/0x59 @ 1
initcall release_early_probes+0x0/0x59 returned 0 after 0 usecs
calling  bdi_class_init+0x0/0x6d @ 1
initcall bdi_class_init+0x0/0x6d returned 0 after 0 usecs
calling  mm_sysfs_init+0x0/0x4f @ 1
initcall mm_sysfs_init+0x0/0x4f returned 0 after 0 usecs
calling  init_per_zone_wmark_min+0x0/0x26 @ 1
initcall init_per_zone_wmark_min+0x0/0x26 returned 0 after 0 usecs
calling  mpi_init+0x0/0xe6 @ 1
initcall mpi_init+0x0/0xe6 returned 0 after 0 usecs
calling  gpiolib_sysfs_init+0x0/0x119 @ 1
initcall gpiolib_sysfs_init+0x0/0x119 returned 0 after 0 usecs
calling  acpi_gpio_setup_params+0x0/0x116 @ 1
initcall acpi_gpio_setup_params+0x0/0x116 returned 0 after 0 usecs
calling  pcibus_class_init+0x0/0x18 @ 1
initcall pcibus_class_init+0x0/0x18 returned 0 after 0 usecs
calling  pci_driver_init+0x0/0x22 @ 1
initcall pci_driver_init+0x0/0x22 returned 0 after 0 usecs
calling  backlight_class_init+0x0/0xee @ 1
initcall backlight_class_init+0x0/0xee returned 0 after 0 usecs
calling  tty_class_init+0x0/0x58 @ 1
initcall tty_class_init+0x0/0x58 returned 0 after 0 usecs
calling  vtconsole_class_init+0x0/0x1a0 @ 1
initcall vtconsole_class_init+0x0/0x1a0 returned 0 after 1000 usecs
calling  iommu_dev_init+0x0/0x18 @ 1
initcall iommu_dev_init+0x0/0x18 returned 0 after 0 usecs
calling  mipi_dsi_bus_init+0x0/0x11 @ 1
initcall mipi_dsi_bus_init+0x0/0x11 returned 0 after 0 usecs
calling  devlink_class_init+0x0/0x46 @ 1
initcall devlink_class_init+0x0/0x46 returned 0 after 0 usecs
calling  software_node_init+0x0/0x51 @ 1
initcall software_node_init+0x0/0x51 returned 0 after 0 usecs
calling  wakeup_sources_debugfs_init+0x0/0x24 @ 1
initcall wakeup_sources_debugfs_init+0x0/0x24 returned 0 after 0 usecs
calling  wakeup_sources_sysfs_init+0x0/0x2d @ 1
initcall wakeup_sources_sysfs_init+0x0/0x2d returned 0 after 0 usecs
calling  regmap_initcall+0x0/0xd @ 1
initcall regmap_initcall+0x0/0xd returned 0 after 0 usecs
calling  spi_init+0x0/0xc7 @ 1
initcall spi_init+0x0/0xc7 returned 0 after 0 usecs
calling  i2c_init+0x0/0xe8 @ 1
initcall i2c_init+0x0/0xe8 returned 0 after 0 usecs
calling  thermal_init+0x0/0x192 @ 1
thermal_sys: Registered thermal governor 'fair_share'
thermal_sys: Registered thermal governor 'bang_bang'
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
initcall thermal_init+0x0/0x192 returned 0 after 20000 usecs
calling  init_menu+0x0/0x11 @ 1
cpuidle: using governor menu
initcall init_menu+0x0/0x11 returned 0 after 1000 usecs
calling  pcc_init+0x0/0xbd @ 1
initcall pcc_init+0x0/0xbd returned -19 after 0 usecs
calling  kobject_uevent_init+0x0/0xc @ 1
initcall kobject_uevent_init+0x0/0xc returned 0 after 0 usecs
calling  bts_init+0x0/0x130 @ 1
initcall bts_init+0x0/0x130 returned -19 after 0 usecs
calling  pt_init+0x0/0x2bd @ 1
initcall pt_init+0x0/0x2bd returned 0 after 0 usecs
calling  boot_params_ksysfs_init+0x0/0x92 @ 1
initcall boot_params_ksysfs_init+0x0/0x92 returned 0 after 0 usecs
calling  sbf_init+0x0/0xcf @ 1
initcall sbf_init+0x0/0xcf returned 0 after 0 usecs
calling  arch_kdebugfs_init+0x0/0x4d5 @ 1
initcall arch_kdebugfs_init+0x0/0x4d5 returned 0 after 0 usecs
calling  xfd_update_static_branch+0x0/0x44 @ 1
initcall xfd_update_static_branch+0x0/0x44 returned 0 after 0 usecs
calling  intel_pconfig_init+0x0/0xa5 @ 1
initcall intel_pconfig_init+0x0/0xa5 returned 0 after 0 usecs
calling  mtrr_if_init+0x0/0xab @ 1
initcall mtrr_if_init+0x0/0xab returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x32 @ 1
initcall activate_jump_labels+0x0/0x32 returned 0 after 0 usecs
calling  init_s4_sigcheck+0x0/0x8c @ 1
initcall init_s4_sigcheck+0x0/0x8c returned 0 after 0 usecs
calling  ffh_cstate_init+0x0/0x62 @ 1
initcall ffh_cstate_init+0x0/0x62 returned 0 after 0 usecs
calling  kvm_alloc_cpumask+0x0/0x1c6 @ 1
initcall kvm_alloc_cpumask+0x0/0x1c6 returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x32 @ 1
initcall activate_jump_labels+0x0/0x32 returned 0 after 0 usecs
calling  gigantic_pages_init+0x0/0x46 @ 1
initcall gigantic_pages_init+0x0/0x46 returned 0 after 0 usecs
calling  uv_rtc_setup_clock+0x0/0x276 @ 1
initcall uv_rtc_setup_clock+0x0/0x276 returned -19 after 0 usecs
calling  kcmp_cookies_init+0x0/0xa2 @ 1
initcall kcmp_cookies_init+0x0/0xa2 returned 0 after 0 usecs
calling  cryptomgr_init+0x0/0x11 @ 1
initcall cryptomgr_init+0x0/0x11 returned 0 after 0 usecs
calling  acpi_pci_init+0x0/0x149 @ 1
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
initcall acpi_pci_init+0x0/0x149 returned 0 after 15000 usecs
calling  dma_channel_table_init+0x0/0x178 @ 1
initcall dma_channel_table_init+0x0/0x178 returned 0 after 0 usecs
calling  dma_bus_init+0x0/0x20b @ 1
initcall dma_bus_init+0x0/0x20b returned 0 after 0 usecs
calling  iommu_dma_init+0x0/0x50 @ 1
initcall iommu_dma_init+0x0/0x50 returned 0 after 0 usecs
calling  dmi_id_init+0x0/0x168 @ 1
initcall dmi_id_init+0x0/0x168 returned 0 after 1000 usecs
calling  pci_arch_init+0x0/0x118 @ 1
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
PCI: Using configuration type 1 for base access
initcall pci_arch_init+0x0/0x118 returned 0 after 30000 usecs
calling  init_vdso+0x0/0x14 @ 1
initcall init_vdso+0x0/0x14 returned 0 after 0 usecs
calling  sysenter_setup+0x0/0x14 @ 1
initcall sysenter_setup+0x0/0x14 returned 0 after 0 usecs
calling  fixup_ht_bug+0x0/0x253 @ 1
initcall fixup_ht_bug+0x0/0x253 returned 0 after 0 usecs
calling  topology_init+0x0/0x9a @ 1
initcall topology_init+0x0/0x9a returned 0 after 1000 usecs
calling  intel_epb_init+0x0/0xd4 @ 1
initcall intel_epb_init+0x0/0xd4 returned 0 after 0 usecs
calling  mtrr_init_finialize+0x0/0x71 @ 1
initcall mtrr_init_finialize+0x0/0x71 returned 0 after 0 usecs
calling  uid_cache_init+0x0/0xff @ 1
initcall uid_cache_init+0x0/0xff returned 0 after 0 usecs
calling  param_sysfs_init+0x0/0xcc @ 1
initcall param_sysfs_init+0x0/0xcc returned 0 after 18000 usecs
calling  user_namespace_sysctl_init+0x0/0x11b @ 1
initcall user_namespace_sysctl_init+0x0/0x11b returned 0 after 0 usecs
calling  proc_schedstat_init+0x0/0x25 @ 1
initcall proc_schedstat_init+0x0/0x25 returned 0 after 0 usecs
calling  pm_sysrq_init+0x0/0x19 @ 1
initcall pm_sysrq_init+0x0/0x19 returned 0 after 0 usecs
calling  create_proc_profile+0x0/0xe0 @ 1
initcall create_proc_profile+0x0/0xe0 returned 0 after 0 usecs
calling  crash_save_vmcoreinfo_init+0x0/0x73e @ 1
initcall crash_save_vmcoreinfo_init+0x0/0x73e returned 0 after 0 usecs
calling  crash_notes_memory_init+0x0/0x39 @ 1
initcall crash_notes_memory_init+0x0/0x39 returned 0 after 0 usecs
calling  cgroup_sysfs_init+0x0/0x3e @ 1
initcall cgroup_sysfs_init+0x0/0x3e returned 0 after 0 usecs
calling  cgroup_namespaces_init+0x0/0x8 @ 1
initcall cgroup_namespaces_init+0x0/0x8 returned 0 after 0 usecs
calling  user_namespaces_init+0x0/0x2d @ 1
initcall user_namespaces_init+0x0/0x2d returned 0 after 0 usecs
calling  init_optprobes+0x0/0x15 @ 1
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
initcall init_optprobes+0x0/0x15 returned 0 after 9000 usecs
calling  hung_task_init+0x0/0x75 @ 1
initcall hung_task_init+0x0/0x75 returned 0 after 0 usecs
calling  ftrace_check_for_weak_functions+0x0/0x62 @ 1
initcall ftrace_check_for_weak_functions+0x0/0x62 returned 0 after 0 usecs
calling  trace_eval_init+0x0/0x85 @ 1
initcall trace_eval_init+0x0/0x85 returned 0 after 0 usecs
calling  send_signal_irq_work_init+0x0/0x150 @ 1
initcall send_signal_irq_work_init+0x0/0x150 returned 0 after 0 usecs
calling  dev_map_init+0x0/0x11f @ 1
initcall dev_map_init+0x0/0x11f returned 0 after 0 usecs
calling  cpu_map_init+0x0/0x113 @ 1
initcall cpu_map_init+0x0/0x113 returned 0 after 0 usecs
calling  netns_bpf_init+0x0/0x11 @ 1
initcall netns_bpf_init+0x0/0x11 returned 0 after 0 usecs
calling  oom_init+0x0/0x4a @ 1
initcall oom_init+0x0/0x4a returned 0 after 1000 usecs
calling  default_bdi_init+0x0/0x29 @ 1
initcall default_bdi_init+0x0/0x29 returned 0 after 0 usecs
calling  cgwb_init+0x0/0x29 @ 1
initcall cgwb_init+0x0/0x29 returned 0 after 0 usecs
calling  percpu_enable_async+0x0/0xf @ 1
initcall percpu_enable_async+0x0/0xf returned 0 after 0 usecs
calling  kcompactd_init+0x0/0x98 @ 1
initcall kcompactd_init+0x0/0x98 returned 0 after 0 usecs
calling  init_user_reserve+0x0/0xa0 @ 1
initcall init_user_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_admin_reserve+0x0/0xa0 @ 1
initcall init_admin_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_reserve_notifier+0x0/0x1f @ 1
initcall init_reserve_notifier+0x0/0x1f returned 0 after 0 usecs
calling  swap_init_sysfs+0x0/0x8e @ 1
initcall swap_init_sysfs+0x0/0x8e returned 0 after 0 usecs
calling  swapfile_init+0x0/0x147 @ 1
initcall swapfile_init+0x0/0x147 returned 0 after 0 usecs
calling  hugetlb_init+0x0/0x40b @ 1
HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
initcall hugetlb_init+0x0/0x40b returned 0 after 30000 usecs
calling  ksm_init+0x0/0x242 @ 1
initcall ksm_init+0x0/0x242 returned 0 after 1000 usecs
calling  memory_tier_init+0x0/0x146 @ 1
initcall memory_tier_init+0x0/0x146 returned 0 after 0 usecs
calling  numa_init_sysfs+0x0/0x8e @ 1
initcall numa_init_sysfs+0x0/0x8e returned 0 after 0 usecs
calling  hugepage_init+0x0/0x1b0 @ 1
initcall hugepage_init+0x0/0x1b0 returned 0 after 0 usecs
calling  mem_cgroup_init+0x0/0x359 @ 1
initcall mem_cgroup_init+0x0/0x359 returned 0 after 0 usecs
calling  mem_cgroup_swap_init+0x0/0x5c @ 1
initcall mem_cgroup_swap_init+0x0/0x5c returned 0 after 0 usecs
calling  page_idle_init+0x0/0x59 @ 1
initcall page_idle_init+0x0/0x59 returned 0 after 0 usecs
calling  seqiv_module_init+0x0/0x11 @ 1
initcall seqiv_module_init+0x0/0x11 returned 0 after 0 usecs
calling  rsa_init+0x0/0x3f @ 1
initcall rsa_init+0x0/0x3f returned 0 after 0 usecs
calling  hmac_module_init+0x0/0x11 @ 1
initcall hmac_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_null_mod_init+0x0/0x6d @ 1
initcall crypto_null_mod_init+0x0/0x6d returned 0 after 0 usecs
calling  md5_mod_init+0x0/0x11 @ 1
initcall md5_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  sha1_generic_mod_init+0x0/0x11 @ 1
initcall sha1_generic_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  sha256_generic_mod_init+0x0/0x16 @ 1
initcall sha256_generic_mod_init+0x0/0x16 returned 0 after 0 usecs
calling  sha512_generic_mod_init+0x0/0x16 @ 1
initcall sha512_generic_mod_init+0x0/0x16 returned 0 after 0 usecs
calling  crypto_ecb_module_init+0x0/0x11 @ 1
initcall crypto_ecb_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_cbc_module_init+0x0/0x11 @ 1
initcall crypto_cbc_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_cfb_module_init+0x0/0x11 @ 1
initcall crypto_cfb_module_init+0x0/0x11 returned 0 after 0 usecs
calling  crypto_ctr_module_init+0x0/0x16 @ 1
initcall crypto_ctr_module_init+0x0/0x16 returned 0 after 0 usecs
calling  crypto_gcm_module_init+0x0/0x63 @ 1
initcall crypto_gcm_module_init+0x0/0x63 returned 0 after 0 usecs
calling  cryptd_init+0x0/0x1f7 @ 1
cryptd: max_cpu_qlen set to 1000
initcall cryptd_init+0x0/0x1f7 returned 0 after 5000 usecs
calling  aes_init+0x0/0x11 @ 1
initcall aes_init+0x0/0x11 returned 0 after 0 usecs
calling  deflate_mod_init+0x0/0x44 @ 1
initcall deflate_mod_init+0x0/0x44 returned 0 after 0 usecs
calling  crc32c_mod_init+0x0/0x11 @ 1
initcall crc32c_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  crct10dif_mod_init+0x0/0x11 @ 1
initcall crct10dif_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  lzo_mod_init+0x0/0x3f @ 1
initcall lzo_mod_init+0x0/0x3f returned 0 after 0 usecs
calling  lzorle_mod_init+0x0/0x3f @ 1
initcall lzorle_mod_init+0x0/0x3f returned 0 after 0 usecs
calling  drbg_init+0x0/0xe4 @ 1
initcall drbg_init+0x0/0xe4 returned 0 after 0 usecs
calling  ghash_mod_init+0x0/0x11 @ 1
initcall ghash_mod_init+0x0/0x11 returned 0 after 0 usecs
calling  init_bio+0x0/0x111 @ 1
initcall init_bio+0x0/0x111 returned 0 after 0 usecs
calling  blk_ioc_init+0x0/0x2a @ 1
initcall blk_ioc_init+0x0/0x2a returned 0 after 0 usecs
calling  blk_mq_init+0x0/0x177 @ 1
initcall blk_mq_init+0x0/0x177 returned 0 after 0 usecs
calling  genhd_device_init+0x0/0x88 @ 1
initcall genhd_device_init+0x0/0x88 returned 0 after 0 usecs
calling  blkcg_init+0x0/0x29 @ 1
initcall blkcg_init+0x0/0x29 returned 0 after 0 usecs
calling  io_wq_init+0x0/0x39 @ 1
initcall io_wq_init+0x0/0x39 returned 0 after 0 usecs
calling  sg_pool_init+0x0/0x1a5 @ 1
initcall sg_pool_init+0x0/0x1a5 returned 0 after 0 usecs
calling  irq_poll_setup+0x0/0x145 @ 1
initcall irq_poll_setup+0x0/0x145 returned 0 after 0 usecs
calling  gpiolib_debugfs_init+0x0/0x24 @ 1
initcall gpiolib_debugfs_init+0x0/0x24 returned 0 after 0 usecs
calling  pwm_debugfs_init+0x0/0x24 @ 1
initcall pwm_debugfs_init+0x0/0x24 returned 0 after 0 usecs
calling  pwm_sysfs_init+0x0/0x18 @ 1
initcall pwm_sysfs_init+0x0/0x18 returned 0 after 1000 usecs
calling  pci_slot_init+0x0/0x40 @ 1
initcall pci_slot_init+0x0/0x40 returned 0 after 0 usecs
calling  fbmem_init+0x0/0xe1 @ 1
initcall fbmem_init+0x0/0xe1 returned 0 after 1000 usecs
calling  scan_for_dmi_ipmi+0x0/0x52 @ 1
initcall scan_for_dmi_ipmi+0x0/0x52 returned 0 after 0 usecs
calling  acpi_init+0x0/0x26d @ 1
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 8 ACPI AML tables successfully acquired and loaded
ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
ACPI: EC: EC started
ACPI: EC: interrupt blocked
ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
PCI: Using E820 reservations for host bridge windows
ACPI: Enabled 5 GPEs in block 00 to 7F
ACPI: PM: Power Resource [PG01]
ACPI: PM: Power Resource [PG02]
ACPI: PM: Power Resource [PG00]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME LTR]
acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xbe800000-0xdfffffff window]
pci_bus 0000:00: root bus resource [mem 0x1c00000000-0x1fffffffff window]
pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
pci_bus 0000:00: root bus resource [bus 00-fe]
pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x80 @ 1
pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x80 took 0 usecs
pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
pci 0000:00:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:00.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xd0000000-0xd0ffffff 64bit]
pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
pci 0000:00:02.0: calling  efifb_fixup_resources+0x0/0x490 @ 1
pci 0000:00:02.0: efifb_fixup_resources+0x0/0x490 took 0 usecs
pci 0000:00:02.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:02.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x200 @ 1
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:02.0: pci_fixup_video+0x0/0x200 took 8789 usecs
pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
pci 0000:00:14.0: reg 0x10: [mem 0xd1020000-0xd102ffff 64bit]
pci 0000:00:14.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:14.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
pci 0000:00:14.2: reg 0x10: [mem 0xd104a000-0xd104afff 64bit]
pci 0000:00:14.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:14.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
pci 0000:00:16.0: reg 0x10: [mem 0xd104b000-0xd104bfff 64bit]
pci 0000:00:16.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:16.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:16.0: PME# supported from D3hot
pci 0000:00:16.3: [8086:a13d] type 00 class 0x070002
pci 0000:00:16.3: reg 0x10: [io  0x3080-0x3087]
pci 0000:00:16.3: reg 0x14: [mem 0xd104f000-0xd104ffff]
pci 0000:00:16.3: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:16.3: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:17.0: [8086:2822] type 00 class 0x010400
pci 0000:00:17.0: reg 0x10: [mem 0xd1048000-0xd1049fff]
pci 0000:00:17.0: reg 0x14: [mem 0xd104e000-0xd104e0ff]
pci 0000:00:17.0: reg 0x18: [io  0x3088-0x308f]
pci 0000:00:17.0: reg 0x1c: [io  0x3090-0x3093]
pci 0000:00:17.0: reg 0x20: [io  0x3060-0x307f]
pci 0000:00:17.0: reg 0x24: [mem 0xd104c000-0xd104c7ff]
pci 0000:00:17.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:17.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:17.0: PME# supported from D3hot
pci 0000:00:1f.0: [8086:a149] type 00 class 0x060100
pci 0000:00:1f.0: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.0: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
pci 0000:00:1f.2: reg 0x10: [mem 0xd1044000-0xd1047fff]
pci 0000:00:1f.2: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.2: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
pci 0000:00:1f.3: reg 0x10: [mem 0xd1040000-0xd1043fff 64bit]
pci 0000:00:1f.3: reg 0x20: [mem 0xd1030000-0xd103ffff 64bit]
pci 0000:00:1f.3: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.3: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.3: PME# supported from D3hot D3cold
pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
pci 0000:00:1f.4: reg 0x10: [mem 0xd104d000-0xd104d0ff 64bit]
pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
pci 0000:00:1f.4: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.4: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.6: calling  quirk_f0_vpd_link+0x0/0x210 @ 1
pci 0000:00:1f.6: quirk_f0_vpd_link+0x0/0x210 took 0 usecs
pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
pci 0000:00:1f.6: reg 0x10: [mem 0xd1000000-0xd101ffff]
pci 0000:00:1f.6: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 1
pci 0000:00:1f.6: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
ACPI: PCI: Interrupt link LNKA configured for IRQ 11
ACPI: PCI: Interrupt link LNKA disabled
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKB disabled
ACPI: PCI: Interrupt link LNKC configured for IRQ 11
ACPI: PCI: Interrupt link LNKC disabled
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKD disabled
ACPI: PCI: Interrupt link LNKE configured for IRQ 11
ACPI: PCI: Interrupt link LNKE disabled
ACPI: PCI: Interrupt link LNKF configured for IRQ 11
ACPI: PCI: Interrupt link LNKF disabled
ACPI: PCI: Interrupt link LNKG configured for IRQ 11
ACPI: PCI: Interrupt link LNKG disabled
ACPI: PCI: Interrupt link LNKH configured for IRQ 11
ACPI: PCI: Interrupt link LNKH disabled
ACPI: EC: interrupt unblocked
ACPI: EC: event unblocked
ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: EC: GPE=0x6e
ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
initcall acpi_init+0x0/0x26d returned 0 after 2009000 usecs
calling  adxl_init+0x0/0x24c @ 1
initcall adxl_init+0x0/0x24c returned -19 after 0 usecs
calling  pnp_init+0x0/0x11 @ 1
initcall pnp_init+0x0/0x11 returned 0 after 0 usecs
calling  misc_init+0x0/0xe4 @ 1
initcall misc_init+0x0/0xe4 returned 0 after 0 usecs
calling  tpm_init+0x0/0x218 @ 1
initcall tpm_init+0x0/0x218 returned 0 after 0 usecs
calling  iommu_subsys_init+0x0/0x1a5 @ 1
iommu: Default domain type: Translated 
iommu: DMA domain TLB invalidation policy: lazy mode 
initcall iommu_subsys_init+0x0/0x1a5 returned 0 after 12000 usecs
calling  cn_init+0x0/0x180 @ 1
initcall cn_init+0x0/0x180 returned 0 after 0 usecs
calling  dax_core_init+0x0/0xe3 @ 1
initcall dax_core_init+0x0/0xe3 returned 0 after 0 usecs
calling  dma_buf_init+0x0/0xc7 @ 1
initcall dma_buf_init+0x0/0xc7 returned 0 after 0 usecs
calling  init_scsi+0x0/0x88 @ 1
SCSI subsystem initialized
initcall init_scsi+0x0/0x88 returned 0 after 5000 usecs
calling  phy_init+0x0/0x65 @ 1
initcall phy_init+0x0/0x65 returned 0 after 0 usecs
calling  usb_common_init+0x0/0x1d @ 1
initcall usb_common_init+0x0/0x1d returned 0 after 0 usecs
calling  usb_init+0x0/0x150 @ 1
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
initcall usb_init+0x0/0x150 returned 0 after 23000 usecs
calling  xdbc_init+0x0/0x151 @ 1
initcall xdbc_init+0x0/0x151 returned 0 after 0 usecs
calling  typec_init+0x0/0xae @ 1
initcall typec_init+0x0/0xae returned 0 after 0 usecs
calling  serio_init+0x0/0x2e @ 1
initcall serio_init+0x0/0x2e returned 0 after 0 usecs
calling  input_init+0x0/0x104 @ 1
initcall input_init+0x0/0x104 returned 0 after 0 usecs
calling  rtc_init+0x0/0x71 @ 1
initcall rtc_init+0x0/0x71 returned 0 after 1000 usecs
calling  pps_init+0x0/0xd6 @ 1
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
initcall pps_init+0x0/0xd6 returned 0 after 16000 usecs
calling  ptp_init+0x0/0xc0 @ 1
PTP clock support registered
initcall ptp_init+0x0/0xc0 returned 0 after 5000 usecs
calling  power_supply_class_init+0x0/0x64 @ 1
initcall power_supply_class_init+0x0/0x64 returned 0 after 0 usecs
calling  hwmon_init+0x0/0x178 @ 1
initcall hwmon_init+0x0/0x178 returned 0 after 0 usecs
calling  md_init+0x0/0x15c @ 1
initcall md_init+0x0/0x15c returned 0 after 0 usecs
calling  edac_init+0x0/0x76 @ 1
EDAC MC: Ver: 3.0.0
initcall edac_init+0x0/0x76 returned 0 after 4000 usecs
calling  leds_init+0x0/0x7f @ 1
initcall leds_init+0x0/0x7f returned 0 after 0 usecs
calling  dmi_init+0x0/0x142 @ 1
initcall dmi_init+0x0/0x142 returned 0 after 0 usecs
calling  efisubsys_init+0x0/0x272 @ 1
initcall efisubsys_init+0x0/0x272 returned 0 after 0 usecs
calling  ras_init+0x0/0xf @ 1
initcall ras_init+0x0/0xf returned 0 after 0 usecs
calling  nvmem_init+0x0/0x11 @ 1
initcall nvmem_init+0x0/0x11 returned 0 after 0 usecs
calling  proto_init+0x0/0x11 @ 1
initcall proto_init+0x0/0x11 returned 0 after 0 usecs
calling  net_dev_init+0x0/0x77d @ 1
initcall net_dev_init+0x0/0x77d returned 0 after 1000 usecs
calling  neigh_init+0x0/0x85 @ 1
initcall neigh_init+0x0/0x85 returned 0 after 0 usecs
calling  fib_notifier_init+0x0/0x11 @ 1
initcall fib_notifier_init+0x0/0x11 returned 0 after 0 usecs
calling  fib_rules_init+0x0/0xb2 @ 1
initcall fib_rules_init+0x0/0xb2 returned 0 after 0 usecs
calling  init_cgroup_netprio+0x0/0x14 @ 1
initcall init_cgroup_netprio+0x0/0x14 returned 0 after 0 usecs
calling  bpf_lwt_init+0x0/0x16 @ 1
initcall bpf_lwt_init+0x0/0x16 returned 0 after 0 usecs
calling  pktsched_init+0x0/0x113 @ 1
initcall pktsched_init+0x0/0x113 returned 0 after 0 usecs
calling  tc_filter_init+0x0/0x100 @ 1
initcall tc_filter_init+0x0/0x100 returned 0 after 0 usecs
calling  tc_action_init+0x0/0x55 @ 1
initcall tc_action_init+0x0/0x55 returned 0 after 0 usecs
calling  ethnl_init+0x0/0x58 @ 1
initcall ethnl_init+0x0/0x58 returned 0 after 0 usecs
calling  nexthop_init+0x0/0xf6 @ 1
initcall nexthop_init+0x0/0xf6 returned 0 after 0 usecs
calling  cipso_v4_init+0x0/0x114 @ 1
initcall cipso_v4_init+0x0/0x114 returned 0 after 0 usecs
calling  wireless_nlevent_init+0x0/0x3f @ 1
initcall wireless_nlevent_init+0x0/0x3f returned 0 after 0 usecs
calling  netlbl_init+0x0/0x88 @ 1
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
initcall netlbl_init+0x0/0x88 returned 0 after 22000 usecs
calling  pci_subsys_init+0x0/0x11e @ 1
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x00091c00-0x0009ffff]
e820: reserve RAM buffer [mem 0xb30fb000-0xb3ffffff]
e820: reserve RAM buffer [mem 0xb3f00000-0xb3ffffff]
e820: reserve RAM buffer [mem 0x43f800000-0x43fffffff]
initcall pci_subsys_init+0x0/0x11e returned 0 after 66000 usecs
calling  vsprintf_init_hashval+0x0/0xa @ 1
initcall vsprintf_init_hashval+0x0/0xa returned 0 after 0 usecs
calling  vga_arb_device_init+0x0/0x77 @ 1
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: bridge control possible
pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
initcall vga_arb_device_init+0x0/0x77 returned 0 after 26000 usecs
calling  watchdog_init+0x0/0x137 @ 1
initcall watchdog_init+0x0/0x137 returned 0 after 1000 usecs
calling  nmi_warning_debugfs+0x0/0x4d @ 1
initcall nmi_warning_debugfs+0x0/0x4d returned 0 after 0 usecs
calling  save_microcode_in_initrd+0x0/0xc3 @ 1
initcall save_microcode_in_initrd+0x0/0xc3 returned 0 after 0 usecs
calling  hpet_late_init+0x0/0x16f @ 1
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 24.000000 MHz counter
initcall hpet_late_init+0x0/0x16f returned 0 after 15000 usecs
calling  iomem_init_inode+0x0/0xa7 @ 1
initcall iomem_init_inode+0x0/0xa7 returned 0 after 0 usecs
calling  clocksource_done_booting+0x0/0x42 @ 1
clocksource: Switched to clocksource tsc-early
initcall clocksource_done_booting+0x0/0x42 returned 0 after 6264 usecs
calling  tracer_init_tracefs+0x0/0x151 @ 1
initcall tracer_init_tracefs+0x0/0x151 returned 0 after 12 usecs
calling  init_trace_printk_function_export+0x0/0x28 @ 1
initcall init_trace_printk_function_export+0x0/0x28 returned 0 after 8 usecs
calling  init_graph_tracefs+0x0/0x28 @ 1
initcall init_graph_tracefs+0x0/0x28 returned 0 after 10 usecs
calling  trace_events_synth_init+0x0/0x47 @ 1
initcall trace_events_synth_init+0x0/0x47 returned 0 after 7 usecs
calling  bpf_event_init+0x0/0xf @ 1
initcall bpf_event_init+0x0/0xf returned 0 after 0 usecs
calling  init_kprobe_trace+0x0/0x30c @ 1
initcall init_kprobe_trace+0x0/0x30c returned 0 after 18893 usecs
calling  init_dynamic_event+0x0/0x28 @ 1
initcall init_dynamic_event+0x0/0x28 returned 0 after 7 usecs
calling  init_uprobe_trace+0x0/0x5c @ 1
initcall init_uprobe_trace+0x0/0x5c returned 0 after 14 usecs
calling  bpf_init+0x0/0x99 @ 1
initcall bpf_init+0x0/0x99 returned 0 after 8 usecs
calling  secretmem_init+0x0/0x5c @ 1
initcall secretmem_init+0x0/0x5c returned 0 after 0 usecs
calling  init_fs_stat_sysctls+0x0/0x2e @ 1
initcall init_fs_stat_sysctls+0x0/0x2e returned 0 after 13 usecs
calling  init_fs_exec_sysctls+0x0/0x22 @ 1
initcall init_fs_exec_sysctls+0x0/0x22 returned 0 after 4 usecs
calling  init_pipe_fs+0x0/0x64 @ 1
initcall init_pipe_fs+0x0/0x64 returned 0 after 54 usecs
calling  init_fs_namei_sysctls+0x0/0x22 @ 1
initcall init_fs_namei_sysctls+0x0/0x22 returned 0 after 7 usecs
calling  init_fs_dcache_sysctls+0x0/0x22 @ 1
initcall init_fs_dcache_sysctls+0x0/0x22 returned 0 after 3 usecs
calling  init_fs_namespace_sysctls+0x0/0x22 @ 1
initcall init_fs_namespace_sysctls+0x0/0x22 returned 0 after 3 usecs
calling  cgroup_writeback_init+0x0/0x26 @ 1
initcall cgroup_writeback_init+0x0/0x26 returned 0 after 7 usecs
calling  inotify_user_setup+0x0/0x18a @ 1
initcall inotify_user_setup+0x0/0x18a returned 0 after 27 usecs
calling  eventpoll_init+0x0/0x141 @ 1
initcall eventpoll_init+0x0/0x141 returned 0 after 39 usecs
calling  anon_inode_init+0x0/0x8a @ 1
initcall anon_inode_init+0x0/0x8a returned 0 after 48 usecs
calling  init_dax_wait_table+0x0/0x34 @ 1
initcall init_dax_wait_table+0x0/0x34 returned 0 after 28 usecs
calling  proc_locks_init+0x0/0x28 @ 1
initcall proc_locks_init+0x0/0x28 returned 0 after 5 usecs
calling  init_fs_coredump_sysctls+0x0/0x22 @ 1
initcall init_fs_coredump_sysctls+0x0/0x22 returned 0 after 7 usecs
calling  iomap_init+0x0/0x20 @ 1
initcall iomap_init+0x0/0x20 returned 0 after 166 usecs
calling  dquot_init+0x0/0x163 @ 1
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
initcall dquot_init+0x0/0x163 returned 0 after 12359 usecs
calling  quota_init+0x0/0x24 @ 1
initcall quota_init+0x0/0x24 returned 0 after 43 usecs
calling  proc_cmdline_init+0x0/0x22 @ 1
initcall proc_cmdline_init+0x0/0x22 returned 0 after 4 usecs
calling  proc_consoles_init+0x0/0x25 @ 1
initcall proc_consoles_init+0x0/0x25 returned 0 after 3 usecs
calling  proc_cpuinfo_init+0x0/0x1f @ 1
initcall proc_cpuinfo_init+0x0/0x1f returned 0 after 3 usecs
calling  proc_devices_init+0x0/0x5e @ 1
initcall proc_devices_init+0x0/0x5e returned 0 after 3 usecs
calling  proc_interrupts_init+0x0/0x25 @ 1
initcall proc_interrupts_init+0x0/0x25 returned 0 after 3 usecs
calling  proc_loadavg_init+0x0/0x5b @ 1
initcall proc_loadavg_init+0x0/0x5b returned 0 after 3 usecs
calling  proc_meminfo_init+0x0/0x5b @ 1
initcall proc_meminfo_init+0x0/0x5b returned 0 after 3 usecs
calling  proc_stat_init+0x0/0x1f @ 1
initcall proc_stat_init+0x0/0x1f returned 0 after 3 usecs
calling  proc_uptime_init+0x0/0x5b @ 1
initcall proc_uptime_init+0x0/0x5b returned 0 after 3 usecs
calling  proc_version_init+0x0/0x5b @ 1
initcall proc_version_init+0x0/0x5b returned 0 after 3 usecs
calling  proc_softirqs_init+0x0/0x5b @ 1
initcall proc_softirqs_init+0x0/0x5b returned 0 after 3 usecs
calling  proc_kcore_init+0x0/0x142 @ 1
initcall proc_kcore_init+0x0/0x142 returned 0 after 26 usecs
calling  vmcore_init+0x0/0x2b9 @ 1
initcall vmcore_init+0x0/0x2b9 returned 0 after 0 usecs
calling  proc_kmsg_init+0x0/0x22 @ 1
initcall proc_kmsg_init+0x0/0x22 returned 0 after 3 usecs
calling  proc_page_init+0x0/0x56 @ 1
initcall proc_page_init+0x0/0x56 returned 0 after 8 usecs
calling  init_ramfs_fs+0x0/0x11 @ 1
initcall init_ramfs_fs+0x0/0x11 returned 0 after 0 usecs
calling  init_hugetlbfs_fs+0x0/0x2a0 @ 1
initcall init_hugetlbfs_fs+0x0/0x2a0 returned 0 after 93 usecs
calling  dynamic_debug_init_control+0x0/0x7c @ 1
initcall dynamic_debug_init_control+0x0/0x7c returned 0 after 22 usecs
calling  acpi_event_init+0x0/0x61 @ 1
initcall acpi_event_init+0x0/0x61 returned 0 after 39 usecs
calling  pnp_system_init+0x0/0x11 @ 1
initcall pnp_system_init+0x0/0x11 returned 0 after 33 usecs
calling  pnpacpi_init+0x0/0xd2 @ 1
pnp: PnP ACPI init
system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
system 00:00: [mem 0xfe000000-0xfe01ffff] has been reserved
system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
system 00:01: [io  0x0680-0x069f] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0x1800-0x18fe] has been reserved
system 00:01: [io  0x164e-0x164f] has been reserved
system 00:02: [io  0x0800-0x087f] has been reserved
system 00:04: [io  0x1854-0x1857] has been reserved
system 00:08: [io  0x0200-0x023f] has been reserved
system 00:08: [mem 0xfedb0000-0xfedbffff] has been reserved
system 00:09: [mem 0xfed10000-0xfed17fff] has been reserved
system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:09: [mem 0xfed90000-0xfed93fff] has been reserved
system 00:09: [mem 0xfed45000-0xfed8ffff] could not be reserved
system 00:09: [mem 0xff000000-0xffffffff] could not be reserved
system 00:09: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:09: [mem 0xfedc0000-0xfeddffff] has been reserved
pnp: PnP ACPI: found 11 devices
initcall pnpacpi_init+0x0/0xd2 returned 0 after 216392 usecs
calling  chr_dev_init+0x0/0x131 @ 1
initcall chr_dev_init+0x0/0x131 returned 0 after 8723 usecs
calling  hwrng_modinit+0x0/0xe6 @ 1
initcall hwrng_modinit+0x0/0xe6 returned 0 after 147 usecs
calling  firmware_class_init+0x0/0xfa @ 1
initcall firmware_class_init+0x0/0xfa returned 0 after 35 usecs
calling  init_acpi_pm_clocksource+0x0/0xd2 @ 1
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
initcall init_acpi_pm_clocksource+0x0/0xd2 returned 0 after 14173 usecs
calling  powercap_init+0x0/0x22 @ 1
initcall powercap_init+0x0/0x22 returned 0 after 216 usecs
calling  sysctl_core_init+0x0/0x2b @ 1
initcall sysctl_core_init+0x0/0x2b returned 0 after 29 usecs
calling  eth_offload_init+0x0/0x14 @ 1
initcall eth_offload_init+0x0/0x14 returned 0 after 0 usecs
calling  ipv4_offload_init+0x0/0x74 @ 1
initcall ipv4_offload_init+0x0/0x74 returned 0 after 0 usecs
calling  inet_init+0x0/0x341 @ 1
NET: Registered PF_INET protocol family
IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
TCP: Hash tables configured (established 131072 bind 65536)
UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
initcall inet_init+0x0/0x341 returned 0 after 78007 usecs
calling  af_unix_init+0x0/0x1a3 @ 1
NET: Registered PF_UNIX/PF_LOCAL protocol family
initcall af_unix_init+0x0/0x1a3 returned 0 after 6460 usecs
calling  ipv6_offload_init+0x0/0x7f @ 1
initcall ipv6_offload_init+0x0/0x7f returned 0 after 0 usecs
calling  init_sunrpc+0x0/0x88 @ 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
initcall init_sunrpc+0x0/0x88 returned 0 after 25252 usecs
calling  vlan_offload_init+0x0/0x20 @ 1
initcall vlan_offload_init+0x0/0x20 returned 0 after 0 usecs
calling  xsk_init+0x0/0x1b8 @ 1
NET: Registered PF_XDP protocol family
initcall xsk_init+0x0/0x1b8 returned 0 after 5543 usecs
calling  pcibios_assign_resources+0x0/0x236 @ 1
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xbe800000-0xdfffffff window]
pci_bus 0000:00: resource 8 [mem 0x1c00000000-0x1fffffffff window]
pci_bus 0000:00: resource 9 [mem 0xfd000000-0xfe7fffff window]
initcall pcibios_assign_resources+0x0/0x236 returned 0 after 45828 usecs
calling  pci_apply_final_quirks+0x0/0x32c @ 1
pci 0000:00:14.0: calling  quirk_usb_early_handoff+0x0/0x2d0 @ 1
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x2d0 took 12590 usecs
pci 0000:00:1f.6: calling  quirk_e100_interrupt+0x0/0x290 @ 1
pci 0000:00:1f.6: quirk_e100_interrupt+0x0/0x290 took 0 usecs
PCI: CLS 0 bytes, default 64
initcall pci_apply_final_quirks+0x0/0x32c returned 0 after 48722 usecs
calling  acpi_reserve_resources+0x0/0x273 @ 1
initcall acpi_reserve_resources+0x0/0x273 returned 0 after 17 usecs
calling  populate_rootfs+0x0/0x3c @ 1
initcall populate_rootfs+0x0/0x3c returned 0 after 7 usecs
Trying to unpack rootfs image as initramfs...
calling  pci_iommu_init+0x0/0x55 @ 1
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x00000000af0fb000-0x00000000b30fb000] (64MB)
initcall pci_iommu_init+0x0/0x55 returned 0 after 27508 usecs
calling  ir_dev_scope_init+0x0/0x6d @ 1
initcall ir_dev_scope_init+0x0/0x6d returned 0 after 0 usecs
calling  ia32_binfmt_init+0x0/0x14 @ 1
initcall ia32_binfmt_init+0x0/0x14 returned 0 after 22 usecs
calling  amd_ibs_init+0x0/0xf6 @ 1
initcall amd_ibs_init+0x0/0xf6 returned -19 after 0 usecs
calling  msr_init+0x0/0x7c @ 1
initcall msr_init+0x0/0x7c returned 0 after 5 usecs
calling  register_kernel_offset_dumper+0x0/0x1b @ 1
initcall register_kernel_offset_dumper+0x0/0x1b returned 0 after 0 usecs
calling  i8259A_init_ops+0x0/0x21 @ 1
initcall i8259A_init_ops+0x0/0x21 returned 0 after 0 usecs
calling  init_tsc_clocksource+0x0/0xe2 @ 1
initcall init_tsc_clocksource+0x0/0xe2 returned 0 after 2 usecs
calling  add_rtc_cmos+0x0/0x1f0 @ 1
initcall add_rtc_cmos+0x0/0x1f0 returned 0 after 1 usecs
calling  i8237A_init_ops+0x0/0x37 @ 1
initcall i8237A_init_ops+0x0/0x37 returned -19 after 1 usecs
calling  umwait_init+0x0/0xdd @ 1
initcall umwait_init+0x0/0xdd returned -19 after 0 usecs
calling  cpuid_init+0x0/0xfd @ 1
initcall cpuid_init+0x0/0xfd returned 0 after 1673 usecs
calling  ioapic_init_ops+0x0/0x14 @ 1
initcall ioapic_init_ops+0x0/0x14 returned 0 after 0 usecs
calling  register_e820_pmem+0x0/0x5e @ 1
initcall register_e820_pmem+0x0/0x5e returned 0 after 3 usecs
calling  add_pcspkr+0x0/0xcf @ 1
initcall add_pcspkr+0x0/0xcf returned 0 after 87 usecs
calling  start_periodic_check_for_corruption+0x0/0x30 @ 1
initcall start_periodic_check_for_corruption+0x0/0x30 returned 0 after 0 usecs
calling  audit_classes_init+0x0/0xaf @ 1
initcall audit_classes_init+0x0/0xaf returned 0 after 33 usecs
calling  sha1_ssse3_mod_init+0x0/0xe7 @ 1
initcall sha1_ssse3_mod_init+0x0/0xe7 returned 0 after 21 usecs
calling  sha256_ssse3_mod_init+0x0/0xfb @ 1
initcall sha256_ssse3_mod_init+0x0/0xfb returned 0 after 29 usecs
calling  iosf_mbi_init+0x0/0x29 @ 1
initcall iosf_mbi_init+0x0/0x29 returned 0 after 57 usecs
calling  proc_execdomains_init+0x0/0x22 @ 1
initcall proc_execdomains_init+0x0/0x22 returned 0 after 6 usecs
calling  register_warn_debugfs+0x0/0x24 @ 1
initcall register_warn_debugfs+0x0/0x24 returned 0 after 18 usecs
calling  cpuhp_sysfs_init+0x0/0x140 @ 1
initcall cpuhp_sysfs_init+0x0/0x140 returned 0 after 207 usecs
calling  ioresources_init+0x0/0x4a @ 1
initcall ioresources_init+0x0/0x4a returned 0 after 22 usecs
calling  snapshot_device_init+0x0/0x11 @ 1
initcall snapshot_device_init+0x0/0x11 returned 0 after 164 usecs
calling  irq_pm_init_ops+0x0/0x14 @ 1
initcall irq_pm_init_ops+0x0/0x14 returned 0 after 0 usecs
calling  klp_init+0x0/0x4f @ 1
initcall klp_init+0x0/0x4f returned 0 after 13 usecs
calling  proc_modules_init+0x0/0x1f @ 1
initcall proc_modules_init+0x0/0x1f returned 0 after 8 usecs
calling  timer_sysctl_init+0x0/0x1b @ 1
initcall timer_sysctl_init+0x0/0x1b returned 0 after 15 usecs
calling  timekeeping_init_ops+0x0/0x14 @ 1
initcall timekeeping_init_ops+0x0/0x14 returned 0 after 0 usecs
calling  init_clocksource_sysfs+0x0/0x24 @ 1
initcall init_clocksource_sysfs+0x0/0x24 returned 0 after 162 usecs
calling  init_timer_list_procfs+0x0/0x32 @ 1
initcall init_timer_list_procfs+0x0/0x32 returned 0 after 5 usecs
calling  alarmtimer_init+0x0/0x105 @ 1
initcall alarmtimer_init+0x0/0x105 returned 0 after 40 usecs
calling  init_posix_timers+0x0/0x2a @ 1
initcall init_posix_timers+0x0/0x2a returned 0 after 24 usecs
calling  clockevents_init_sysfs+0x0/0x19a @ 1
initcall clockevents_init_sysfs+0x0/0x19a returned 0 after 681 usecs
calling  proc_dma_init+0x0/0x22 @ 1
initcall proc_dma_init+0x0/0x22 returned 0 after 5 usecs
calling  kallsyms_init+0x0/0x22 @ 1
initcall kallsyms_init+0x0/0x22 returned 0 after 4 usecs
calling  pid_namespaces_init+0x0/0x40 @ 1
initcall pid_namespaces_init+0x0/0x40 returned 0 after 40 usecs
calling  ikconfig_init+0x0/0x42 @ 1
initcall ikconfig_init+0x0/0x42 returned 0 after 4 usecs
calling  audit_watch_init+0x0/0x3c @ 1
initcall audit_watch_init+0x0/0x3c returned 0 after 10 usecs
calling  audit_fsnotify_init+0x0/0x3f @ 1
initcall audit_fsnotify_init+0x0/0x3f returned 0 after 8 usecs
calling  audit_tree_init+0x0/0xcb @ 1
initcall audit_tree_init+0x0/0xcb returned 0 after 27 usecs
calling  seccomp_sysctl_init+0x0/0x2c @ 1
initcall seccomp_sysctl_init+0x0/0x2c returned 0 after 18 usecs
calling  utsname_sysctl_init+0x0/0x14 @ 1
initcall utsname_sysctl_init+0x0/0x14 returned 0 after 16 usecs
calling  init_tracepoints+0x0/0x2c @ 1
initcall init_tracepoints+0x0/0x2c returned 0 after 1 usecs
calling  init_lstats_procfs+0x0/0x3c @ 1
initcall init_lstats_procfs+0x0/0x3c returned 0 after 18 usecs
calling  stack_trace_init+0x0/0xa4 @ 1
initcall stack_trace_init+0x0/0xa4 returned 0 after 34 usecs
calling  perf_event_sysfs_init+0x0/0x106 @ 1
initcall perf_event_sysfs_init+0x0/0x106 returned 0 after 911 usecs
calling  system_trusted_keyring_init+0x0/0x8a @ 1
Initialise system trusted keyrings
initcall system_trusted_keyring_init+0x0/0x8a returned 0 after 5205 usecs
calling  blacklist_init+0x0/0x162 @ 1
Key type blacklist registered
initcall blacklist_init+0x0/0x162 returned 0 after 4778 usecs
calling  kswapd_init+0x0/0x60 @ 1
initcall kswapd_init+0x0/0x60 returned 0 after 88 usecs
calling  extfrag_debug_init+0x0/0x57 @ 1
initcall extfrag_debug_init+0x0/0x57 returned 0 after 24 usecs
calling  mm_compute_batch_init+0x0/0x53 @ 1
initcall mm_compute_batch_init+0x0/0x53 returned 0 after 1 usecs
calling  slab_proc_init+0x0/0x22 @ 1
initcall slab_proc_init+0x0/0x22 returned 0 after 6 usecs
calling  workingset_init+0x0/0xd0 @ 1
workingset: timestamp_bits=36 max_order=22 bucket_order=0
initcall workingset_init+0x0/0xd0 returned 0 after 7241 usecs
calling  proc_vmalloc_init+0x0/0x64 @ 1
initcall proc_vmalloc_init+0x0/0x64 returned 0 after 10 usecs
calling  procswaps_init+0x0/0x1f @ 1
initcall procswaps_init+0x0/0x1f returned 0 after 4 usecs
calling  init_frontswap+0x0/0x93 @ 1
initcall init_frontswap+0x0/0x93 returned 0 after 39 usecs
calling  slab_sysfs_init+0x0/0xee @ 1
initcall slab_sysfs_init+0x0/0xee returned 0 after 17687 usecs
calling  slab_debugfs_init+0x0/0x4e @ 1
initcall slab_debugfs_init+0x0/0x4e returned 0 after 14 usecs
calling  init_zbud+0x0/0x20 @ 1
zbud: loaded
initcall init_zbud+0x0/0x20 returned 0 after 3292 usecs
calling  zs_init+0x0/0x73 @ 1
initcall zs_init+0x0/0x73 returned 0 after 42 usecs
calling  fcntl_init+0x0/0x2a @ 1
initcall fcntl_init+0x0/0x2a returned 0 after 144 usecs
calling  proc_filesystems_init+0x0/0x22 @ 1
initcall proc_filesystems_init+0x0/0x22 returned 0 after 5 usecs
calling  start_dirtytime_writeback+0x0/0x17 @ 1
initcall start_dirtytime_writeback+0x0/0x17 returned 0 after 0 usecs
calling  dio_init+0x0/0x2d @ 1
initcall dio_init+0x0/0x2d returned 0 after 140 usecs
calling  dnotify_init+0x0/0x9d @ 1
initcall dnotify_init+0x0/0x9d returned 0 after 269 usecs
calling  fanotify_user_setup+0x0/0x1f7 @ 1
initcall fanotify_user_setup+0x0/0x1f7 returned 0 after 542 usecs
calling  aio_setup+0x0/0x98 @ 1
initcall aio_setup+0x0/0x98 returned 0 after 312 usecs
calling  mbcache_init+0x0/0x31 @ 1
initcall mbcache_init+0x0/0x31 returned 0 after 130 usecs
calling  init_grace+0x0/0x11 @ 1
initcall init_grace+0x0/0x11 returned 0 after 4 usecs
calling  init_v2_quota_format+0x0/0x22 @ 1
initcall init_v2_quota_format+0x0/0x22 returned 0 after 0 usecs
calling  init_devpts_fs+0x0/0x2c @ 1
initcall init_devpts_fs+0x0/0x2c returned 0 after 26 usecs
calling  ext4_init_fs+0x0/0x19f @ 1
initcall ext4_init_fs+0x0/0x19f returned 0 after 1839 usecs
calling  journal_init+0x0/0x12e @ 1
initcall journal_init+0x0/0x12e returned 0 after 797 usecs
calling  init_nfs_fs+0x0/0x191 @ 1
initcall init_nfs_fs+0x0/0x191 returned 0 after 1138 usecs
calling  init_nfs_v3+0x0/0x14 @ 1
initcall init_nfs_v3+0x0/0x14 returned 0 after 0 usecs
calling  init_nlm+0x0/0x62 @ 1
initcall init_nlm+0x0/0x62 returned 0 after 32 usecs
calling  init_nls_cp437+0x0/0x13 @ 1
initcall init_nls_cp437+0x0/0x13 returned 0 after 0 usecs
calling  init_nls_ascii+0x0/0x13 @ 1
initcall init_nls_ascii+0x0/0x13 returned 0 after 0 usecs
calling  init_autofs_fs+0x0/0x2a @ 1
initcall init_autofs_fs+0x0/0x2a returned 0 after 133 usecs
calling  init_v9fs+0x0/0x10f @ 1
9p: Installing v9fs 9p2000 file system support
initcall init_v9fs+0x0/0x10f returned 0 after 6378 usecs
calling  efivarfs_init+0x0/0x21 @ 1
initcall efivarfs_init+0x0/0x21 returned -19 after 0 usecs
calling  ipc_init+0x0/0x25 @ 1
initcall ipc_init+0x0/0x25 returned 0 after 33 usecs
calling  ipc_sysctl_init+0x0/0x2d @ 1
initcall ipc_sysctl_init+0x0/0x2d returned 0 after 37 usecs
calling  init_mqueue_fs+0x0/0xeb @ 1
initcall init_mqueue_fs+0x0/0xeb returned 0 after 206 usecs
calling  key_proc_init+0x0/0x6e @ 1
initcall key_proc_init+0x0/0x6e returned 0 after 8 usecs
calling  jent_mod_init+0x0/0x2e @ 1
initcall jent_mod_init+0x0/0x2e returned 0 after 6464 usecs
calling  af_alg_init+0x0/0x41 @ 1
tsc: Refined TSC clocksource calibration: 3408.000 MHz
NET: Registered PF_ALG protocol family
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fd3cd494, max_idle_ns: 440795223879 ns
initcall af_alg_init+0x0/0x41 returned 0 after 12345 usecs
calling  algif_hash_init+0x0/0x11 @ 1
clocksource: Switched to clocksource tsc
initcall algif_hash_init+0x0/0x11 returned 0 after 14 usecs
calling  algif_skcipher_init+0x0/0x11 @ 1
initcall algif_skcipher_init+0x0/0x11 returned 0 after 2 usecs
calling  rng_init+0x0/0x11 @ 1
initcall rng_init+0x0/0x11 returned 0 after 2 usecs
calling  algif_aead_init+0x0/0x11 @ 1
initcall algif_aead_init+0x0/0x11 returned 0 after 2 usecs
calling  asymmetric_key_init+0x0/0x11 @ 1
Key type asymmetric registered
initcall asymmetric_key_init+0x0/0x11 returned 0 after 4840 usecs
calling  x509_key_init+0x0/0x19 @ 1
Asymmetric key parser 'x509' registered
initcall x509_key_init+0x0/0x19 returned 0 after 5620 usecs
calling  blkdev_init+0x0/0x20 @ 1
initcall blkdev_init+0x0/0x20 returned 0 after 41 usecs
calling  proc_genhd_init+0x0/0x42 @ 1
initcall proc_genhd_init+0x0/0x42 returned 0 after 9 usecs
calling  bsg_init+0x0/0x117 @ 1
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
initcall bsg_init+0x0/0x117 returned 0 after 8168 usecs
calling  throtl_init+0x0/0x41 @ 1
initcall throtl_init+0x0/0x41 returned 0 after 96 usecs
calling  deadline_init+0x0/0x11 @ 1
io scheduler mq-deadline registered
initcall deadline_init+0x0/0x11 returned 0 after 5262 usecs
calling  kyber_init+0x0/0x11 @ 1
io scheduler kyber registered
initcall kyber_init+0x0/0x11 returned 0 after 4743 usecs
calling  bfq_init+0x0/0x8b @ 1
io scheduler bfq registered
initcall bfq_init+0x0/0x8b returned 0 after 4890 usecs
calling  io_uring_init+0x0/0x32 @ 1
initcall io_uring_init+0x0/0x32 returned 0 after 131 usecs
calling  blake2s_mod_init+0x0/0x8 @ 1
initcall blake2s_mod_init+0x0/0x8 returned 0 after 0 usecs
calling  crc_t10dif_mod_init+0x0/0x4c @ 1
initcall crc_t10dif_mod_init+0x0/0x4c returned 0 after 166 usecs
calling  percpu_counter_startup+0x0/0x51 @ 1
initcall percpu_counter_startup+0x0/0x51 returned 0 after 153 usecs
calling  digsig_init+0x0/0x39 @ 1
initcall digsig_init+0x0/0x39 returned 0 after 82 usecs
calling  pcie_portdrv_init+0x0/0x49 @ 1
initcall pcie_portdrv_init+0x0/0x49 returned 0 after 187 usecs
calling  pci_proc_init+0x0/0x6c @ 1
initcall pci_proc_init+0x0/0x6c returned 0 after 56 usecs
calling  pci_hotplug_init+0x0/0x8 @ 1
initcall pci_hotplug_init+0x0/0x8 returned 0 after 0 usecs
calling  shpcd_init+0x0/0x5d @ 1
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
initcall shpcd_init+0x0/0x5d returned 0 after 7532 usecs
calling  pci_stub_init+0x0/0x1fb @ 1
initcall pci_stub_init+0x0/0x1fb returned 0 after 45 usecs
calling  vmd_drv_init+0x0/0x1a @ 1
initcall vmd_drv_init+0x0/0x1a returned 0 after 71 usecs
calling  vesafb_driver_init+0x0/0x13 @ 1
initcall vesafb_driver_init+0x0/0x13 returned 0 after 45 usecs
calling  efifb_driver_init+0x0/0x13 @ 1
initcall efifb_driver_init+0x0/0x13 returned 0 after 39 usecs
calling  intel_idle_init+0x0/0x503 @ 1
initcall intel_idle_init+0x0/0x503 returned 0 after 4446 usecs
calling  ged_driver_init+0x0/0x13 @ 1
initcall ged_driver_init+0x0/0x13 returned 0 after 57 usecs
calling  acpi_ac_init+0x0/0x78 @ 1
initcall acpi_ac_init+0x0/0x78 returned 0 after 136 usecs
calling  acpi_button_driver_init+0x0/0xaf @ 1
input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
ACPI: button: Sleep Button [SLPB]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
ACPI: button: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
ACPI: button: Power Button [PWRF]
initcall acpi_button_driver_init+0x0/0xaf returned 0 after 43371 usecs
calling  acpi_fan_driver_init+0x0/0x13 @ 1
initcall acpi_fan_driver_init+0x0/0x13 returned 0 after 44 usecs
calling  acpi_processor_driver_init+0x0/0xeb @ 1
initcall acpi_processor_driver_init+0x0/0xeb returned 0 after 2629 usecs
calling  acpi_thermal_init+0x0/0x82 @ 1
initcall acpi_thermal_init+0x0/0x82 returned 0 after 280 usecs
calling  acpi_battery_init+0x0/0x6d @ 1
initcall acpi_battery_init+0x0/0x6d returned 0 after 8 usecs
calling  acpi_hed_driver_init+0x0/0x11 @ 1
initcall acpi_hed_driver_init+0x0/0x11 returned 0 after 102 usecs
calling  bgrt_init+0x0/0x19b @ 1
initcall bgrt_init+0x0/0x19b returned -19 after 0 usecs
calling  erst_init+0x0/0x4c3 @ 1
initcall erst_init+0x0/0x4c3 returned 0 after 837 usecs
calling  gpio_clk_driver_init+0x0/0x13 @ 1
initcall gpio_clk_driver_init+0x0/0x13 returned 0 after 77 usecs
calling  plt_clk_driver_init+0x0/0x13 @ 1
initcall plt_clk_driver_init+0x0/0x13 returned 0 after 37 usecs
calling  dw_pci_driver_init+0x0/0x1a @ 1
initcall dw_pci_driver_init+0x0/0x1a returned 0 after 55 usecs
calling  virtio_pci_driver_init+0x0/0x1a @ 1
initcall virtio_pci_driver_init+0x0/0x1a returned 0 after 65 usecs
calling  n_null_init+0x0/0x1a @ 1
initcall n_null_init+0x0/0x1a returned 0 after 0 usecs
calling  pty_init+0x0/0xd @ 1
initcall pty_init+0x0/0xd returned 0 after 237 usecs
calling  sysrq_init+0x0/0x4a @ 1
initcall sysrq_init+0x0/0x4a returned 0 after 7 usecs
calling  serial8250_init+0x0/0x2de @ 1
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:07: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
initcall serial8250_init+0x0/0x2de returned 0 after 16873 usecs
calling  serial_pci_driver_init+0x0/0x1a @ 1
IOAPIC[0]: Preconfigured routing entry (2-19 -> IRQ 19 Level:1 ActiveLow:1)
0000:00:16.3: ttyS1 at I/O 0x3080 (irq = 19, base_baud = 115200) is a 16550A
initcall serial_pci_driver_init+0x0/0x1a returned 0 after 21997 usecs
calling  exar_pci_driver_init+0x0/0x1a @ 1
initcall exar_pci_driver_init+0x0/0x1a returned 0 after 133 usecs
calling  dw8250_platform_driver_init+0x0/0x13 @ 1
initcall dw8250_platform_driver_init+0x0/0x13 returned 0 after 54 usecs
calling  lpss8250_pci_driver_init+0x0/0x1a @ 1
initcall lpss8250_pci_driver_init+0x0/0x1a returned 0 after 43 usecs
calling  mid8250_pci_driver_init+0x0/0x1a @ 1
initcall mid8250_pci_driver_init+0x0/0x1a returned 0 after 40 usecs
calling  pericom8250_pci_driver_init+0x0/0x1a @ 1
initcall pericom8250_pci_driver_init+0x0/0x1a returned 0 after 53 usecs
calling  random_sysctls_init+0x0/0x22 @ 1
initcall random_sysctls_init+0x0/0x22 returned 0 after 13 usecs
calling  hpet_init+0x0/0x72 @ 1
initcall hpet_init+0x0/0x72 returned 0 after 870 usecs
calling  nvram_module_init+0x0/0x89 @ 1
Non-volatile memory driver v1.3
initcall nvram_module_init+0x0/0x89 returned 0 after 5133 usecs
calling  virtio_rng_driver_init+0x0/0x11 @ 1
initcall virtio_rng_driver_init+0x0/0x11 returned 0 after 34 usecs
calling  init_tis+0x0/0x14a @ 1
tpm_tis 00:0a: 1.2 TPM (device-id 0x1B, rev-id 16)
tpm tpm0: TPM is disabled/deactivated (0x7)
tpm tpm0: tpm_read_log_acpi: TCPA log area empty
initcall init_tis+0x0/0x14a returned 0 after 40993 usecs
calling  crb_acpi_driver_init+0x0/0x11 @ 1
initcall crb_acpi_driver_init+0x0/0x11 returned 0 after 85 usecs
calling  cn_proc_init+0x0/0x3a @ 1
initcall cn_proc_init+0x0/0x3a returned 0 after 4 usecs
calling  topology_sysfs_init+0x0/0x2c @ 1
initcall topology_sysfs_init+0x0/0x2c returned 0 after 511 usecs
calling  cacheinfo_sysfs_init+0x0/0x2c @ 1
initcall cacheinfo_sysfs_init+0x0/0x2c returned 0 after 2817 usecs
calling  intel_lpss_init+0x0/0x1d @ 1
initcall intel_lpss_init+0x0/0x1d returned 0 after 22 usecs
calling  intel_lpss_pci_driver_init+0x0/0x1a @ 1
initcall intel_lpss_pci_driver_init+0x0/0x1a returned 0 after 67 usecs
calling  intel_lpss_acpi_driver_init+0x0/0x13 @ 1
initcall intel_lpss_acpi_driver_init+0x0/0x13 returned 0 after 41 usecs
calling  mac_hid_init+0x0/0x29 @ 1
initcall mac_hid_init+0x0/0x29 returned 0 after 45 usecs
calling  rdac_init+0x0/0x75 @ 1
rdac: device handler registered
initcall rdac_init+0x0/0x75 returned 0 after 5137 usecs
calling  hp_sw_init+0x0/0x11 @ 1
hp_sw: device handler registered
initcall hp_sw_init+0x0/0x11 returned 0 after 5008 usecs
calling  clariion_init+0x0/0x33 @ 1
emc: device handler registered
initcall clariion_init+0x0/0x33 returned 0 after 4837 usecs
calling  alua_init+0x0/0x64 @ 1
alua: device handler registered
initcall alua_init+0x0/0x64 returned 0 after 5119 usecs
calling  blackhole_netdev_init+0x0/0xcb @ 1
initcall blackhole_netdev_init+0x0/0xcb returned 0 after 20 usecs
calling  phylink_init+0x0/0xab @ 1
initcall phylink_init+0x0/0xab returned 0 after 0 usecs
calling  phy_module_init+0x0/0x18 @ 1
initcall phy_module_init+0x0/0x18 returned 0 after 142 usecs
calling  fixed_mdio_bus_init+0x0/0x241 @ 1
initcall fixed_mdio_bus_init+0x0/0x241 returned 0 after 704 usecs
calling  phy_module_init+0x0/0x18 @ 1
initcall phy_module_init+0x0/0x18 returned 0 after 594 usecs
calling  cavium_ptp_driver_init+0x0/0x1a @ 1
initcall cavium_ptp_driver_init+0x0/0x1a returned 0 after 47 usecs
calling  e1000_init_module+0x0/0x77 @ 1
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
initcall e1000_init_module+0x0/0x77 returned 0 after 12187 usecs
calling  e1000_init_module+0x0/0x32 @ 1
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 3c:52:82:60:db:86
e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
initcall e1000_init_module+0x0/0x32 returned 0 after 204014 usecs
calling  igb_init_module+0x0/0x40 @ 1
igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
initcall igb_init_module+0x0/0x40 returned 0 after 12529 usecs
calling  igc_init_module+0x0/0x40 @ 1
Intel(R) 2.5G Ethernet Linux Driver
Copyright(c) 2018 Intel Corporation.
initcall igc_init_module+0x0/0x40 returned 0 after 10703 usecs
calling  ixgbe_init_module+0x0/0xa9 @ 1
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
ixgbe: Copyright (c) 1999-2016 Intel Corporation.
initcall ixgbe_init_module+0x0/0xa9 returned 0 after 13594 usecs
calling  i40e_init_module+0x0/0x92 @ 1
i40e: Intel(R) Ethernet Connection XL710 Network Driver
i40e: Copyright (c) 2013 - 2019 Intel Corporation.
initcall i40e_init_module+0x0/0x92 returned 0 after 13776 usecs
calling  rtl8169_pci_driver_init+0x0/0x1a @ 1
initcall rtl8169_pci_driver_init+0x0/0x1a returned 0 after 40 usecs
calling  rtl8152_driver_init+0x0/0x1a @ 1
usbcore: registered new interface driver r8152
initcall rtl8152_driver_init+0x0/0x1a returned 0 after 6329 usecs
calling  asix_driver_init+0x0/0x1a @ 1
usbcore: registered new interface driver asix
initcall asix_driver_init+0x0/0x1a returned 0 after 6196 usecs
calling  ax88179_178a_driver_init+0x0/0x1a @ 1
usbcore: registered new interface driver ax88179_178a
initcall ax88179_178a_driver_init+0x0/0x1a returned 0 after 6863 usecs
calling  usbnet_init+0x0/0x2b @ 1
initcall usbnet_init+0x0/0x2b returned 0 after 0 usecs
calling  usbport_trig_init+0x0/0x11 @ 1
initcall usbport_trig_init+0x0/0x11 returned 0 after 1 usecs
calling  mon_init+0x0/0x194 @ 1
initcall mon_init+0x0/0x194 returned 0 after 298 usecs
calling  ehci_hcd_init+0x0/0x19c @ 1
initcall ehci_hcd_init+0x0/0x19c returned 0 after 9 usecs
calling  ehci_pci_init+0x0/0x52 @ 1
initcall ehci_pci_init+0x0/0x52 returned 0 after 51 usecs
calling  ohci_hcd_mod_init+0x0/0xa5 @ 1
initcall ohci_hcd_mod_init+0x0/0xa5 returned 0 after 8 usecs
calling  ohci_pci_init+0x0/0x52 @ 1
initcall ohci_pci_init+0x0/0x52 returned 0 after 43 usecs
calling  uhci_hcd_init+0x0/0x12b @ 1
initcall uhci_hcd_init+0x0/0x12b returned 0 after 231 usecs
calling  xhci_hcd_init+0x0/0x24 @ 1
initcall xhci_hcd_init+0x0/0x24 returned 0 after 51 usecs
calling  xhci_pci_init+0x0/0x4e @ 1
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.01
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: xHCI Host Controller
usb usb1: Manufacturer: Linux 6.1.0-rc4-00062-gce10c493af38 xhci-hcd
usb usb1: SerialNumber: 0000:00:14.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 16 ports detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.01
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: xHCI Host Controller
usb usb2: Manufacturer: Linux 6.1.0-rc4-00062-gce10c493af38 xhci-hcd
usb usb2: SerialNumber: 0000:00:14.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
initcall xhci_pci_init+0x0/0x4e returned 0 after 396153 usecs
calling  ucsi_acpi_platform_driver_init+0x0/0x13 @ 1
initcall ucsi_acpi_platform_driver_init+0x0/0x13 returned 0 after 46 usecs
calling  i8042_init+0x0/0x135 @ 1
i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
initcall i8042_init+0x0/0x135 returned 0 after 24528 usecs
calling  serport_init+0x0/0x2c @ 1
initcall serport_init+0x0/0x2c returned 0 after 0 usecs
calling  input_leds_init+0x0/0x11 @ 1
initcall input_leds_init+0x0/0x11 returned 0 after 34 usecs
calling  mousedev_init+0x0/0x5f @ 1
mousedev: PS/2 mouse device common for all mice
initcall mousedev_init+0x0/0x5f returned 0 after 6545 usecs
calling  evdev_init+0x0/0x11 @ 1
initcall evdev_init+0x0/0x11 returned 0 after 587 usecs
calling  atkbd_init+0x0/0x26 @ 1
initcall atkbd_init+0x0/0x26 returned 0 after 57 usecs
calling  psmouse_init+0x0/0x86 @ 1
initcall psmouse_init+0x0/0x86 returned 0 after 196 usecs
calling  uinput_misc_init+0x0/0x11 @ 1
initcall uinput_misc_init+0x0/0x11 returned 0 after 181 usecs
calling  cmos_init+0x0/0x70 @ 1
rtc_cmos 00:03: RTC can wake from S4
rtc_cmos 00:03: registered as rtc0
rtc_cmos 00:03: setting system clock to 2023-01-20T21:22:13 UTC (1674249733)
rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram
initcall cmos_init+0x0/0x70 returned 0 after 28797 usecs
calling  thermal_throttle_init_device+0x0/0x4f @ 1
initcall thermal_throttle_init_device+0x0/0x4f returned 0 after 606 usecs
calling  esb_driver_init+0x0/0x1a @ 1
initcall esb_driver_init+0x0/0x1a returned 0 after 92 usecs
calling  iTCO_wdt_driver_init+0x0/0x13 @ 1
initcall iTCO_wdt_driver_init+0x0/0x13 returned 0 after 38 usecs
calling  iTCO_vendor_init_module+0x0/0x31 @ 1
iTCO_vendor_support: vendor-support=0
initcall iTCO_vendor_init_module+0x0/0x31 returned 0 after 5434 usecs
calling  intel_pstate_init+0x0/0x4ad @ 1
intel_pstate: HWP enabled by BIOS
intel_pstate: Intel P-state driver initializing
intel_pstate: HWP enabled
initcall intel_pstate_init+0x0/0x4ad returned 0 after 17051 usecs
calling  haltpoll_init+0x0/0xef @ 1
initcall haltpoll_init+0x0/0xef returned -19 after 0 usecs
calling  dmi_sysfs_init+0x0/0x148 @ 1
initcall dmi_sysfs_init+0x0/0x148 returned 0 after 3058 usecs
calling  fw_cfg_sysfs_init+0x0/0x86 @ 1
initcall fw_cfg_sysfs_init+0x0/0x86 returned 0 after 55 usecs
calling  sysfb_init+0x0/0x11e @ 1
initcall sysfb_init+0x0/0x11e returned 0 after 95 usecs
calling  esrt_sysfs_init+0x0/0x442 @ 1
initcall esrt_sysfs_init+0x0/0x442 returned -38 after 0 usecs
calling  efivars_pstore_init+0x0/0xb1 @ 1
initcall efivars_pstore_init+0x0/0xb1 returned 0 after 0 usecs
calling  hid_init+0x0/0x62 @ 1
hid: raw HID events driver (C) Jiri Kosina
initcall hid_init+0x0/0x62 returned 0 after 6016 usecs
calling  hid_generic_init+0x0/0x1a @ 1
initcall hid_generic_init+0x0/0x1a returned 0 after 43 usecs
calling  magicmouse_driver_init+0x0/0x1a @ 1
initcall magicmouse_driver_init+0x0/0x1a returned 0 after 63 usecs
calling  sensor_hub_driver_init+0x0/0x1a @ 1
initcall sensor_hub_driver_init+0x0/0x1a returned 0 after 41 usecs
calling  hid_init+0x0/0x5e @ 1
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
initcall hid_init+0x0/0x5e returned 0 after 10982 usecs
calling  pmc_atom_init+0x0/0x6f @ 1
initcall pmc_atom_init+0x0/0x6f returned -19 after 5 usecs
calling  sock_diag_init+0x0/0x2f @ 1
initcall sock_diag_init+0x0/0x2f returned 0 after 66 usecs
calling  init_net_drop_monitor+0x0/0x33b @ 1
drop_monitor: Initializing network drop monitor service
initcall init_net_drop_monitor+0x0/0x33b returned 0 after 7042 usecs
calling  blackhole_init+0x0/0x11 @ 1
initcall blackhole_init+0x0/0x11 returned 0 after 0 usecs
calling  fq_codel_module_init+0x0/0x11 @ 1
initcall fq_codel_module_init+0x0/0x11 returned 0 after 0 usecs
calling  init_cgroup_cls+0x0/0x11 @ 1
initcall init_cgroup_cls+0x0/0x11 returned 0 after 0 usecs
calling  xt_init+0x0/0x29a @ 1
initcall xt_init+0x0/0x29a returned 0 after 47 usecs
calling  tcpudp_mt_init+0x0/0x16 @ 1
initcall tcpudp_mt_init+0x0/0x16 returned 0 after 0 usecs
calling  gre_offload_init+0x0/0x4e @ 1
initcall gre_offload_init+0x0/0x4e returned 0 after 0 usecs
calling  sysctl_ipv4_init+0x0/0x4c @ 1
initcall sysctl_ipv4_init+0x0/0x4c returned 0 after 88 usecs
calling  cubictcp_register+0x0/0x6e @ 1
initcall cubictcp_register+0x0/0x6e returned 0 after 1 usecs
calling  xfrm_user_init+0x0/0x30 @ 1
Initializing XFRM netlink socket
initcall xfrm_user_init+0x0/0x30 returned 0 after 5062 usecs
calling  inet6_init+0x0/0x4ba @ 1
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
initcall inet6_init+0x0/0x4ba returned 0 after 17540 usecs
calling  packet_init+0x0/0x7f @ 1
NET: Registered PF_PACKET protocol family
initcall packet_init+0x0/0x7f returned 0 after 5807 usecs
calling  strp_dev_init+0x0/0x33 @ 1
initcall strp_dev_init+0x0/0x33 returned 0 after 181 usecs
calling  init_p9+0x0/0x2a @ 1
9pnet: Installing 9P2000 support
initcall init_p9+0x0/0x2a returned 0 after 5170 usecs
calling  p9_trans_fd_init+0x0/0x2c @ 1
initcall p9_trans_fd_init+0x0/0x2c returned 0 after 0 usecs
calling  p9_virtio_init+0x0/0x4e @ 1
initcall p9_virtio_init+0x0/0x4e returned 0 after 37 usecs
calling  dcbnl_init+0x0/0x50 @ 1
initcall dcbnl_init+0x0/0x50 returned 0 after 8 usecs
calling  mpls_gso_init+0x0/0x2c @ 1
mpls_gso: MPLS GSO support
initcall mpls_gso_init+0x0/0x2c returned 0 after 4483 usecs
calling  nsh_init_module+0x0/0x14 @ 1
initcall nsh_init_module+0x0/0x14 returned 0 after 0 usecs
calling  pm_check_save_msr+0x0/0xf0 @ 1
initcall pm_check_save_msr+0x0/0xf0 returned 0 after 46 usecs
calling  mcheck_init_device+0x0/0x1e7 @ 1
initcall mcheck_init_device+0x0/0x1e7 returned 0 after 1871 usecs
calling  dev_mcelog_init_device+0x0/0x16d @ 1
initcall dev_mcelog_init_device+0x0/0x16d returned 0 after 182 usecs
calling  kernel_do_mounts_initrd_sysctls_init+0x0/0x22 @ 1
initcall kernel_do_mounts_initrd_sysctls_init+0x0/0x22 returned 0 after 7 usecs
calling  tboot_late_init+0x0/0x22b @ 1
initcall tboot_late_init+0x0/0x22b returned 0 after 0 usecs
calling  mcheck_late_init+0x0/0x3d @ 1
initcall mcheck_late_init+0x0/0x3d returned 0 after 55 usecs
calling  severities_debugfs_init+0x0/0x2a @ 1
initcall severities_debugfs_init+0x0/0x2a returned 0 after 8 usecs
calling  microcode_init+0x0/0x2a0 @ 1
microcode: sig=0x506e3, pf=0x2, revision=0xf0
microcode: Microcode Update Driver: v2.2.
initcall microcode_init+0x0/0x2a0 returned 0 after 6472 usecs
calling  hpet_insert_resource+0x0/0x23 @ 1
initcall hpet_insert_resource+0x0/0x23 returned 0 after 1 usecs
calling  start_sync_check_timer+0x0/0xaa @ 1
initcall start_sync_check_timer+0x0/0xaa returned 0 after 0 usecs
calling  update_mp_table+0x0/0x571 @ 1
initcall update_mp_table+0x0/0x571 returned 0 after 0 usecs
calling  lapic_insert_resource+0x0/0x43 @ 1
initcall lapic_insert_resource+0x0/0x43 returned 0 after 1 usecs
calling  print_ipi_mode+0x0/0x2d @ 1
IPI shorthand broadcast: enabled
initcall print_ipi_mode+0x0/0x2d returned 0 after 5003 usecs
calling  print_ICs+0x0/0x1d3 @ 1
... APIC ID:      00000000 (0)
... APIC VERSION: 01060015
0000000000000000000000000000000000000000000000000000000000000000
0000000000000002000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000001000

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 120.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00770020
.......     : max redirection entries: 77
.......     : PRQ implemented: 0
.......     : IO APIC version: 20
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
IOAPIC 0:
pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin01, enabled , edge , high, V(21), IRR(0), S(0), logical , D(0020), M(0)
pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(0001), M(0)
pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin07, disabled, edge , high, V(00), l, D(0000), M(0)
pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin18, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin19, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin20, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin21, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin22, disabled, edge , high, V(20), IRR(0), S(0), physical, D(0440), M(2)
pin23, disabled, edge , high, V(00), IRR(0), S(0), logical , D(0700), M(2)
pin24, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin25, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin26, disabled, edge , high, V(40), IRR(0), S(0), physical, D(0768), M(2)
pin27, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin28, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin29, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2d, disabled, edge , high, V(02), IRR(0), S(0), physical, D(6200), M(2)
pin2e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin30, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin31, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin32, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin33, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin34, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin35, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin36, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin37, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin38, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin39, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin40, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin41, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin42, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin43, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin44, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin45, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin46, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin47, disabled, edge , high, V(20), IRR(0), S(0), physical, D(0000), M(2)
pin48, disabled, edge , high, V(00), IRR(0), S(0), remapped, I(1010),  Z(2)
pin49, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4e, disabled, edge , high, V(00), IRR(0), S(0), remapped, I(01E0),  Z(2)
pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin50, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin51, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin52, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin53, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin54, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin55, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin56, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin57, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin58, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin59, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5e, disabled, edge , high, V(DD), IRR(0), S(0), physical, D(0464), M(2)
pin5f, disabled, edge , high, V(41), IRR(0), S(0), physical, D(0008), M(2)
pin60, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin61, disabled, edge , high, V(40), IRR(0), S(0), physical, D(2A00), M(2)
pin62, disabled, edge , high, V(00), IRR(0), S(0), physical, D(2200), M(2)
pin63, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin64, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin65, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin66, disabled, edge , high, V(00), IRR(0), S(0), physical, D(4200), M(2)
pin67, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin68, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin69, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6e, disabled, edge , high, V(08), IRR(0), S(0), physical, D(6200), M(2)
pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin70, disabled, edge , high, V(94), IRR(0), S(0), physical, D(4404), M(2)
pin71, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin72, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin73, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin74, disabled, edge , high, V(A8), IRR(0), S(0), physical, D(4014), M(2)
pin75, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin76, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin77, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ19 -> 0:19
.................................... done.
initcall print_ICs+0x0/0x1d3 returned 0 after 1232481 usecs
calling  setup_efi_kvm_sev_migration+0x0/0x288 @ 1
initcall setup_efi_kvm_sev_migration+0x0/0x288 returned 0 after 0 usecs
calling  create_tlb_single_page_flush_ceiling+0x0/0x4f @ 1
initcall create_tlb_single_page_flush_ceiling+0x0/0x4f returned 0 after 51 usecs
calling  pat_memtype_list_init+0x0/0x58 @ 1
initcall pat_memtype_list_init+0x0/0x58 returned 0 after 15 usecs
calling  create_init_pkru_value+0x0/0x54 @ 1
initcall create_init_pkru_value+0x0/0x54 returned 0 after 0 usecs
calling  aesni_init+0x0/0x21f @ 1
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
initcall aesni_init+0x0/0x21f returned 0 after 12586 usecs
calling  kernel_panic_sysctls_init+0x0/0x22 @ 1
initcall kernel_panic_sysctls_init+0x0/0x22 returned 0 after 7 usecs
calling  reboot_ksysfs_init+0x0/0x90 @ 1
initcall reboot_ksysfs_init+0x0/0x90 returned 0 after 33 usecs
calling  sched_core_sysctl_init+0x0/0x27 @ 1
initcall sched_core_sysctl_init+0x0/0x27 returned 0 after 42 usecs
calling  sched_fair_sysctl_init+0x0/0x22 @ 1
initcall sched_fair_sysctl_init+0x0/0x22 returned 0 after 6 usecs
calling  sched_rt_sysctl_init+0x0/0x22 @ 1
initcall sched_rt_sysctl_init+0x0/0x22 returned 0 after 18 usecs
calling  sched_dl_sysctl_init+0x0/0x22 @ 1
initcall sched_dl_sysctl_init+0x0/0x22 returned 0 after 152 usecs
calling  sched_clock_init_late+0x0/0xce @ 1
sched_clock: Marking stable (14770176310, 767859164)->(16179266151, -641230677)
initcall sched_clock_init_late+0x0/0xce returned 0 after 9208 usecs
calling  sched_init_debug+0x0/0x251 @ 1
initcall sched_init_debug+0x0/0x251 returned 0 after 1940 usecs
calling  cpu_latency_qos_init+0x0/0x3a @ 1
initcall cpu_latency_qos_init+0x0/0x3a returned 0 after 198 usecs
calling  pm_debugfs_init+0x0/0x24 @ 1
initcall pm_debugfs_init+0x0/0x24 returned 0 after 19 usecs
calling  printk_late_init+0x0/0x1f3 @ 1
initcall printk_late_init+0x0/0x1f3 returned 0 after 48 usecs
calling  init_srcu_module_notifier+0x0/0x2c @ 1
initcall init_srcu_module_notifier+0x0/0x2c returned 0 after 1 usecs
calling  swiotlb_create_default_debugfs+0x0/0x68 @ 1
initcall swiotlb_create_default_debugfs+0x0/0x68 returned 0 after 25 usecs
calling  tk_debug_sleep_time_init+0x0/0x24 @ 1
initcall tk_debug_sleep_time_init+0x0/0x24 returned 0 after 7 usecs
calling  bpf_ksym_iter_register+0x0/0x1b @ 1
initcall bpf_ksym_iter_register+0x0/0x1b returned 0 after 3 usecs
calling  kernel_acct_sysctls_init+0x0/0x22 @ 1
initcall kernel_acct_sysctls_init+0x0/0x22 returned 0 after 7 usecs
calling  kexec_core_sysctl_init+0x0/0x22 @ 1
initcall kexec_core_sysctl_init+0x0/0x22 returned 0 after 5 usecs
calling  bpf_rstat_kfunc_init+0x0/0x16 @ 1
initcall bpf_rstat_kfunc_init+0x0/0x16 returned 0 after 0 usecs
calling  debugfs_kprobe_init+0x0/0x74 @ 1
initcall debugfs_kprobe_init+0x0/0x74 returned 0 after 37 usecs
calling  kernel_delayacct_sysctls_init+0x0/0x22 @ 1
initcall kernel_delayacct_sysctls_init+0x0/0x22 returned 0 after 5 usecs
calling  taskstats_init+0x0/0x3b @ 1
registered taskstats version 1
initcall taskstats_init+0x0/0x3b returned 0 after 4864 usecs
calling  ftrace_sysctl_init+0x0/0x1d @ 1
initcall ftrace_sysctl_init+0x0/0x1d returned 0 after 5 usecs
calling  init_hwlat_tracer+0x0/0x112 @ 1
initcall init_hwlat_tracer+0x0/0x112 returned 0 after 379 usecs
calling  bpf_key_sig_kfuncs_init+0x0/0x11 @ 1
initcall bpf_key_sig_kfuncs_init+0x0/0x11 returned 0 after 0 usecs
calling  bpf_syscall_sysctl_init+0x0/0x22 @ 1
initcall bpf_syscall_sysctl_init+0x0/0x22 returned 0 after 7 usecs
calling  kfunc_init+0x0/0x16 @ 1
initcall kfunc_init+0x0/0x16 returned 0 after 0 usecs
calling  bpf_map_iter_init+0x0/0x2c @ 1
initcall bpf_map_iter_init+0x0/0x2c returned 0 after 5 usecs
calling  task_iter_init+0x0/0x2d1 @ 1
initcall task_iter_init+0x0/0x2d1 returned 0 after 7 usecs
calling  bpf_prog_iter_init+0x0/0x1b @ 1
initcall bpf_prog_iter_init+0x0/0x1b returned 0 after 2 usecs
calling  bpf_link_iter_init+0x0/0x1b @ 1
initcall bpf_link_iter_init+0x0/0x1b returned 0 after 2 usecs
calling  init_trampolines+0x0/0x71 @ 1
initcall init_trampolines+0x0/0x71 returned 0 after 1 usecs
calling  bpf_cgroup_iter_init+0x0/0x1b @ 1
initcall bpf_cgroup_iter_init+0x0/0x1b returned 0 after 3 usecs
calling  load_system_certificate_list+0x0/0x51 @ 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: c8f8df68471fd4eec22b05a451fc78d06350579e'
initcall load_system_certificate_list+0x0/0x51 returned 0 after 17666 usecs
calling  fault_around_debugfs+0x0/0x24 @ 1
initcall fault_around_debugfs+0x0/0x24 returned 0 after 11 usecs
calling  max_swapfiles_check+0x0/0x8 @ 1
initcall max_swapfiles_check+0x0/0x8 returned 0 after 0 usecs
calling  init_zswap+0x0/0x3a6 @ 1
zswap: loaded using pool lzo/zbud
initcall init_zswap+0x0/0x3a6 returned 0 after 6350 usecs
calling  hugetlb_vmemmap_init+0x0/0x123 @ 1
initcall hugetlb_vmemmap_init+0x0/0x123 returned 0 after 7 usecs
calling  kasan_cpu_quarantine_init+0x0/0x44 @ 1
initcall kasan_cpu_quarantine_init+0x0/0x44 returned 216 after 320 usecs
calling  split_huge_pages_debugfs+0x0/0x24 @ 1
initcall split_huge_pages_debugfs+0x0/0x24 returned 0 after 12 usecs
calling  pageowner_init+0x0/0x34 @ 1
page_owner is disabled
initcall pageowner_init+0x0/0x34 returned 0 after 4137 usecs
calling  check_early_ioremap_leak+0x0/0x85 @ 1
initcall check_early_ioremap_leak+0x0/0x85 returned 0 after 0 usecs
calling  set_hardened_usercopy+0x0/0x20 @ 1
initcall set_hardened_usercopy+0x0/0x20 returned 1 after 0 usecs
calling  fscrypt_init+0x0/0xc9 @ 1
Key type .fscrypt registered
Key type fscrypt-provisioning registered
initcall fscrypt_init+0x0/0xc9 returned 0 after 10703 usecs
calling  pstore_init+0x0/0x7d @ 1
initcall pstore_init+0x0/0x7d returned 0 after 8 usecs
calling  init_root_keyring+0x0/0xe @ 1
initcall init_root_keyring+0x0/0xe returned 0 after 50 usecs
calling  init_trusted+0x0/0x252 @ 1
Freeing initrd memory: 467080K
Key type trusted registered
initcall init_trusted+0x0/0x252 returned 0 after 4062175 usecs
calling  init_encrypted+0x0/0x14d @ 1
Key type encrypted registered
initcall init_encrypted+0x0/0x14d returned 0 after 17476 usecs
calling  integrity_fs_init+0x0/0x4e @ 1
initcall integrity_fs_init+0x0/0x4e returned 0 after 11 usecs
calling  init_ima+0x0/0x111 @ 1
ima: Allocated hash algorithm: sha1
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: Error Communicating to TPM chip
ima: No architecture policies found
initcall init_ima+0x0/0x111 returned 0 after 75310 usecs
calling  crypto_algapi_init+0x0/0x128 @ 1
initcall crypto_algapi_init+0x0/0x128 returned 0 after 5311 usecs
calling  fail_make_request_debugfs+0x0/0x26 @ 1
initcall fail_make_request_debugfs+0x0/0x26 returned 0 after 74 usecs
calling  blk_timeout_init+0x0/0x13 @ 1
initcall blk_timeout_init+0x0/0x13 returned 0 after 0 usecs
calling  init_error_injection+0x0/0x6a @ 1
initcall init_error_injection+0x0/0x6a returned 0 after 1949 usecs
calling  pci_resource_alignment_sysfs_init+0x0/0x18 @ 1
initcall pci_resource_alignment_sysfs_init+0x0/0x18 returned 0 after 8 usecs
calling  pci_sysfs_init+0x0/0x6e @ 1
initcall pci_sysfs_init+0x0/0x6e returned 0 after 202 usecs
calling  bert_init+0x0/0x64f @ 1
initcall bert_init+0x0/0x64f returned 0 after 9 usecs
calling  clk_debug_init+0x0/0x135 @ 1
initcall clk_debug_init+0x0/0x135 returned 0 after 38 usecs
calling  dmar_free_unused_resources+0x0/0x190 @ 1
initcall dmar_free_unused_resources+0x0/0x190 returned 0 after 0 usecs
calling  sync_state_resume_initcall+0x0/0x10 @ 1
initcall sync_state_resume_initcall+0x0/0x10 returned 0 after 0 usecs
calling  deferred_probe_initcall+0x0/0xd0 @ 1
initcall deferred_probe_initcall+0x0/0xd0 returned 0 after 27 usecs
calling  firmware_memmap_init+0x0/0x5a @ 1
initcall firmware_memmap_init+0x0/0x5a returned 0 after 403 usecs
calling  register_update_efi_random_seed+0x0/0x1e @ 1
initcall register_update_efi_random_seed+0x0/0x1e returned 0 after 0 usecs
calling  efi_shutdown_init+0x0/0x74 @ 1
initcall efi_shutdown_init+0x0/0x74 returned -19 after 0 usecs
calling  efi_earlycon_unmap_fb+0x0/0x51 @ 1
initcall efi_earlycon_unmap_fb+0x0/0x51 returned 0 after 0 usecs
calling  itmt_legacy_init+0x0/0x49 @ 1
initcall itmt_legacy_init+0x0/0x49 returned -19 after 0 usecs
calling  bpf_sockmap_iter_init+0x0/0x51 @ 1
initcall bpf_sockmap_iter_init+0x0/0x51 returned 0 after 3 usecs
calling  bpf_sk_storage_map_iter_init+0x0/0x51 @ 1
initcall bpf_sk_storage_map_iter_init+0x0/0x51 returned 0 after 2 usecs
calling  sch_default_qdisc+0x0/0x11 @ 1
initcall sch_default_qdisc+0x0/0x11 returned 0 after 1 usecs
calling  bpf_prog_test_run_init+0x0/0xe2 @ 1
initcall bpf_prog_test_run_init+0x0/0xe2 returned 0 after 0 usecs
calling  tcp_congestion_default+0x0/0x18 @ 1
initcall tcp_congestion_default+0x0/0x18 returned 0 after 0 usecs
calling  ip_auto_config+0x0/0x812 @ 1
e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Sending DHCP requests ..., OK
IP-Config: Got DHCP answer from 192.168.3.1, my address is 192.168.3.73
IP-Config: Complete:
device=eth0, hwaddr=3c:52:82:60:db:86, ipaddr=192.168.3.73, mask=255.255.255.0, gw=192.168.3.200
host=lkp-skl-d07, domain=lkp.intel.com, nis-domain=(none)
bootserver=192.168.3.200, rootserver=192.168.3.200, rootpath=
nameserver0=192.168.3.200
initcall ip_auto_config+0x0/0x812 returned 0 after 10942996 usecs
calling  tcp_bpf_v4_build_proto+0x0/0xeb @ 1
initcall tcp_bpf_v4_build_proto+0x0/0xeb returned 0 after 0 usecs
calling  udp_bpf_v4_build_proto+0x0/0x99 @ 1
initcall udp_bpf_v4_build_proto+0x0/0x99 returned 0 after 0 usecs
calling  bpf_tcp_ca_kfunc_init+0x0/0x16 @ 1
initcall bpf_tcp_ca_kfunc_init+0x0/0x16 returned 0 after 0 usecs
calling  pci_mmcfg_late_insert_resources+0x0/0xb5 @ 1
initcall pci_mmcfg_late_insert_resources+0x0/0xb5 returned 0 after 1 usecs
calling  software_resume+0x0/0x40 @ 1
initcall software_resume+0x0/0x40 returned -2 after 0 usecs
calling  ftrace_check_sync+0x0/0x14 @ 1
initcall ftrace_check_sync+0x0/0x14 returned 0 after 6 usecs
calling  latency_fsnotify_init+0x0/0x38 @ 1
initcall latency_fsnotify_init+0x0/0x38 returned 0 after 46 usecs
calling  trace_eval_sync+0x0/0x14 @ 1
initcall trace_eval_sync+0x0/0x14 returned 0 after 4 usecs
calling  late_trace_init+0x0/0x9c @ 1
initcall late_trace_init+0x0/0x9c returned 0 after 0 usecs
calling  acpi_gpio_handle_deferred_request_irqs+0x0/0xa1 @ 1
initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xa1 returned 0 after 6 usecs
calling  fb_logo_late_init+0x0/0xf @ 1
initcall fb_logo_late_init+0x0/0xf returned 0 after 0 usecs
calling  clk_disable_unused+0x0/0x18c @ 1
initcall clk_disable_unused+0x0/0x18c returned 0 after 0 usecs
Freeing unused kernel image (initmem) memory: 3112K
Write protecting the kernel read-only data: 53248k
Freeing unused kernel image (text/rodata gap) memory: 2036K
Freeing unused kernel image (rodata/data gap) memory: 1736K
Run /init as init process
with arguments:
/init
nokaslr
with environment:
HOME=/
TERM=linux
RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/vmlinuz-6.1.0-rc4-00062-gce10c493af38
branch=linux-review/zhanchengbin/ext4-fix-inode-tree-inconsistency-caused-by-ENOMEM-in-ext4_split_extent_at/20230110-211157
job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=ce10c493af382439876867dcaee89c7efddfab46
max_uptime=1200
LKP_SERVER=internal-lkp-server
selinux=0
softlockup_panic=1
prompt_ramdisk=0
vga=normal
systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
calling  ip_tables_init+0x0/0x1000 [ip_tables] @ 1
initcall ip_tables_init+0x0/0x1000 [ip_tables] returned 0 after 23 usecs


ACPI: bus type drm_connector registered
Device Events a[   32.571866][  T258] calling  tpm_inf_pnp_driver_init+0x0/0x1000 [tpm_infineon] @ 258

calling  pmc_core_driver_init+0x0/0x1000 [intel_pmc_core] @ 259
calling  acpi_wmi_init+0x0/0x1000 [wmi] @ 247
initcall acpi_pad_init+0x0/0x1000 [acpi_pad] returned 0 after 1290 usecs
intel_pmc_core INT33A1:00:  initialized
acpi PNP0C14:02: duplicate WMI GUID 2B814318-4BE8-4707-9D84-A190A859B5D0 (first instance was on PNP0C14:00)
acpi PNP0C14:02: duplicate WMI GUID 41227C2D-80E1-423F-8B8E-87E32755A0EB (first instance was on PNP0C14:00)
wmi_bus wmi_bus-PNP0C14:02: WQZZ data block query control method not found
initcall acpi_wmi_init+0x0/0x1000 [wmi] returned 0 after 15905 usecs
initcall pmc_core_driver_init+0x0/0x1000 [intel_pmc_core] returned 0 after 21425 usecs
calling  ie31200_init+0x0/0x1000 [ie31200_edac] @ 263
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 256
calling  intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] @ 243
IOAPIC[0]: Preconfigured routing entry (2-18 -> IRQ 18 Level:1 ActiveLow:1)
initcall intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] returned 0 after 4382 usecs
EDAC ie31200: No ECC support
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 0 usecs
EDAC ie31200: No ECC support
;1;39mColdplug A[   32.780877][  T260] initcall smbalert_driver_init+0x0/0x1000 [i2c_smbus] returned 0 after 1720 usecs
calling  serio_raw_drv_init+0x0/0x1000 [serio_raw] @ 257
initcall serio_raw_drv_init+0x0/0x1000 [serio_raw] returned 0 after 1771 usecs
calling  mei_init+0x0/0xb3 [mei] @ 268
;1;39mPreprocess[   32.838673][  T238] calling  intel_uncore_init+0x0/0x3a1 [intel_uncore] @ 238
NFS configurati[   32.842419][  T247] calling  acpi_video_init+0x0/0x1000 [video] @ 247
initcall acpi_video_init+0x0/0x1000 [video] returned 0 after 8 usecs
libata version 3.00 loaded.
initcall ata_init+0x0/0x86 [libata] returned 0 after 21552 usecs
initcall intel_uncore_init+0x0/0x3a1 [intel_uncore] returned 0 after 29463 usecs
calling  wmi_bmof_driver_init+0x0/0x1000 [wmi_bmof] @ 249
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 253
calling  cstate_pmu_init+0x0/0x1000 [intel_cstate] @ 238
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 0 usecs
initcall wmi_bmof_driver_init+0x0/0x1000 [wmi_bmof] returned 0 after 331 usecs
calling  rfkill_init+0x0/0x104 [rfkill] @ 267
calling  i2c_i801_init+0x0/0x1000 [i2c_i801] @ 260
initcall cstate_pmu_init+0x0/0x1000 [intel_cstate] returned 0 after 19065 usecs
initcall rfkill_init+0x0/0x104 [rfkill] returned 0 after 1969 usecs
initcall i2c_i801_init+0x0/0x1000 [i2c_i801] returned 0 after 1234 usecs
i801_smbus 0000:00:1f.4: SPD Write Disable is set
Startin[   32.976349][   T55] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
r to synchronize[   32.992470][   T55] pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
boot up for ifu[   33.001479][   T55] pci 0000:00:1f.1: calling  quirk_igfx_skip_te_disable+0x0/0x110 @ 55
pci 0000:00:1f.1: quirk_igfx_skip_te_disable+0x0/0x110 took 0 usecs
calling  mei_me_driver_init+0x0/0x1000 [mei_me] @ 268
iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
0m] Reached targ[   33.027432][   T55] i2c i2c-0: 2/4 memory slots populated (from DMI)
[0m.
i2c i2c-0: Successfully instantiated SPD at 0x52
RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
RAPL PMU: hw unit of domain package 2^-14 Joules
RAPL PMU: hw unit of domain dram 2^-14 Joules
RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
initcall rapl_pmu_init+0x0/0xf0a [rapl] returned 0 after 57604 usecs
Startin[   33.127116][  T251] calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 251
Journal to Pers[   33.135037][  T251] initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 0 usecs
0m...
calling  mei_wdt_driver_init+0x0/0x1000 [mei_wdt] @ 257
initcall mei_wdt_driver_init+0x0/0x1000 [mei_wdt] returned 0 after 733 usecs
;1;39mHelper to [   33.197686][  T241] calling  ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] @ 241
ahci 0000:00:17.0: controller can't do SNTF, turning off CAP_SNTF
synchronize boot[   33.215113][  T241] initcall ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] returned 0 after 8234 usecs
up for ifupdown[   33.215166][  T244] ahci 0000:00:17.0: SSS flag set, parallel bus scan disabled
calling  hp_wmi_init+0x0/0x1ac [hp_wmi] @ 267
hp_wmi: query 0x4 returned error 0x5
;1;39mFlush Jour[   33.255545][  T244] ahci 0000:00:17.0: flags: 64bit ncq stag led clo only pio slum part ems deso sadm sds apst 
calling  crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] @ 250
input: HP WMI hotkeys as /devices/virtual/input/input6
initcall crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] returned 0 after 7042 usecs
scsi host0: ahci
tatus /dev/rfkil[   33.315858][  T244] scsi host1: ahci
scsi host2: ahci
scsi host3: ahci
ata1: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c100 irq 123
initcall crc32_pclmul_mod_init+0x0/0x1000 [crc32_pclmul] returned 0 after 666 usecs
ata2: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c180 irq 123
ata3: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c200 irq 123
initcall hp_wmi_init+0x0/0x1ac [hp_wmi] returned 0 after 53575 usecs
ata4: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c280 irq 123
calling  crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] @ 246
calling  drm_display_helper_module_init+0x0/0x1000 [drm_display_helper] @ 262
initcall drm_display_helper_module_init+0x0/0x1000 [drm_display_helper] returned 0 after 67 usecs
initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 106 usecs
initcall ahci_pci_driver_init+0x0/0x1000 [ahci] returned 0 after 56383 usecs
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 252
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 0 usecs
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 242
calling  kvm_x86_init+0x0/0xd [kvm] @ 241
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 0 usecs
initcall kvm_x86_init+0x0/0xd [kvm] returned 0 after 1 usecs
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 245
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 0 usecs
calling  vmx_init+0x0/0x26b [kvm_intel] @ 246

initcall coretemp_init+0x0/0x1000 [coretemp] returned 0 after 898 usecs
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata1.00: ATA-9: ST2000DM001-1ER164, HP52, max UDMA/100
ata1.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 32), AA
ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
ata1.00: configured for UDMA/100
LKP: ttyS0: 340: current_version: f0, target_version: f0
LKP: ttyS0: 340: skip deploy intel ucode as ucode is same
LKP: ttyS0: 340: Kernel tests: Boot OK!
LKP: ttyS0: 340: HOSTNAME lkp-skl-d07, MAC 3c:52:82:60:db:86, kernel 6.1.0-rc4-00062-gce10c493af38 1
calling  ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] @ 395
IPMI message handler: version 39.2
initcall ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] returned 0 after 97 usecs
ata3: SATA link down (SStatus 4 SControl 300)
ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata4.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata4.00: ATA-10: INTEL SSDSC2BW480H6, RG21, max UDMA/133
ata4.00: 937703088 sectors, multi 16: LBA48 NCQ (depth 32), AA
ata4.00: Features: Dev-Sleep
ata4.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata4.00: configured for UDMA/133
scsi 3:0:0:0: Direct-Access     ATA      INTEL SSDSC2BW48 RG21 PQ: 0 ANSI: 5
calling  drm_buddy_module_init+0x0/0x1000 [drm_buddy] @ 262
calling  powerclamp_init+0x0/0x1000 [intel_powerclamp] @ 238
calling  init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] @ 395
ipmi device interface
initcall init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] returned 0 after 468 usecs
initcall drm_buddy_module_init+0x0/0x1000 [drm_buddy] returned 0 after 285 usecs
initcall powerclamp_init+0x0/0x1000 [intel_powerclamp] returned 0 after 1185 usecs
calling  pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] @ 269
calling  init_sg+0x0/0x1000 [sg] @ 258
scsi 0:0:0:0: Attached scsi generic sg0 type 0
scsi 3:0:0:0: Attached scsi generic sg1 type 0
initcall init_sg+0x0/0x1000 [sg] returned 0 after 13322 usecs
calling  init_ipmi_si+0x0/0x276 [ipmi_si] @ 505
ipmi_si: IPMI System Interface driver
ipmi_si: Unable to find any System Interface(s)
initcall init_ipmi_si+0x0/0x276 [ipmi_si] returned -19 after 13514 usecs
calling  crc64_rocksoft_mod_init+0x0/0x1000 [crc64_rocksoft] @ 247
calling  crc64_rocksoft_init+0x0/0x1000 [crc64_rocksoft_generic] @ 514
initcall crc64_rocksoft_init+0x0/0x1000 [crc64_rocksoft_generic] returned 0 after 139 usecs
initcall crc64_rocksoft_mod_init+0x0/0x1000 [crc64_rocksoft] returned 0 after 19506 usecs
initcall pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] returned 0 after 36646 usecs
calling  init_sd+0x0/0x1000 [sd_mod] @ 258
initcall init_sd+0x0/0x1000 [sd_mod] returned 0 after 1109 usecs
sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
sd 3:0:0:0: [sdb] 937703088 512-byte logical blocks: (480 GB/447 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
sd 0:0:0:0: [sda] 4096-byte physical blocks
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 239
sdb: sdb1 sdb2
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 1 usecs
sd 3:0:0:0: [sdb] Attached SCSI disk
See 'systemctl status openipmi.service' for details.
sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
calling  i915_init+0x0/0x15d [i915] @ 262
i915 0000:00:02.0: vgaarb: deactivate vga console
Console: switching to colour dummy device 80x25
calling  libcrc32c_mod_init+0x0/0x1000 [libcrc32c] @ 667
initcall libcrc32c_mod_init+0x0/0x1000 [libcrc32c] returned 0 after 33 usecs
i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 241
i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver1_27.bin failed with error -2
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 1 usecs
i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/skl_dmc_ver1_27.bin. Disabling runtime power management.
i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 239
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 96 usecs
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 246
calling  init_module+0x0/0x1000 [raid6_pq] @ 667
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 1 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 241
raid6: avx2x4   gen() 17283 MB/s
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 73 usecs
calling  rapl_init+0x0/0x1000 [intel_rapl_common] @ 239
raid6: avx2x2   gen() 15643 MB/s
initcall rapl_init+0x0/0x1000 [intel_rapl_common] returned 0 after 154 usecs
calling  intel_rapl_msr_driver_init+0x0/0x1000 [intel_rapl_msr] @ 264
raid6: avx2x1   gen() 13006 MB/s
intel_rapl_common: Found RAPL domain package
raid6: using algorithm avx2x4 gen() 17283 MB/s
intel_rapl_common: Found RAPL domain core
intel_rapl_common: Found RAPL domain uncore
intel_rapl_common: Found RAPL domain dram
raid6: .... xor() 7967 MB/s, rmw enabled
raid6: using avx2x2 recovery algorithm
initcall init_module+0x0/0x1000 [raid6_pq] returned 0 after 62245 usecs
initcall intel_rapl_msr_driver_init+0x0/0x1000 [intel_rapl_msr] returned 0 after 71094 usecs
calling  calibrate_xor_blocks+0x0/0xeae [xor] @ 667
xor: automatically using best checksumming function   avx       
initcall calibrate_xor_blocks+0x0/0xeae [xor] returned 0 after 7742 usecs
calling  blake2b_mod_init+0x0/0x1000 [blake2b_generic] @ 667
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 261
initcall blake2b_mod_init+0x0/0x1000 [blake2b_generic] returned 0 after 396 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 246
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 84 usecs
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 1 usecs
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 248
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 261
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 1 usecs
calling  init_btrfs_fs+0x0/0x144 [btrfs] @ 667
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 89 usecs
Btrfs loaded, crc32c=crc32c-intel, zoned=yes, fsverity=no
initcall init_btrfs_fs+0x0/0x144 [btrfs] returned 0 after 2522 usecs
BTRFS: device fsid fe0ac9ce-d98b-4e2d-801c-fb1ced3c698a devid 1 transid 12632 /dev/sdb1 scanned by systemd-udevd (258)
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 250
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 1 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 248
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 83 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 250
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 238
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 84 usecs
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 1 usecs
calling  acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] @ 269
initcall acpi_cpufreq_init+0x0/0xdeb [acpi_cpufreq] returned -17 after 1 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 238
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 82 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 269
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 86 usecs
i915 0000:00:02.0: [drm] failed to retrieve link info, disabling eDP
[drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input7
initcall i915_init+0x0/0x15d [i915] returned 0 after 518811 usecs
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
lkp: kernel tainted state: 0

LKP: stdout: 340: Kernel tests: Boot OK!

LKP: stdout: 340: HOSTNAME lkp-skl-d07, MAC 3c:52:82:60:db:86, kernel 6.1.0-rc4-00062-gce10c493af38 1

install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/ntpdate_1%3a4.2.8p15+dfsg-1_amd64.deb

/opt/deb/gawk_1%3a5.1.0-1_amd64.deb

/opt/deb/uuid-runtime_2.36.1-8+deb11u1_amd64.deb

/opt/deb/libssl1.1_1.1.1n-0+deb11u3_amd64.deb

/opt/deb/attr_1%3a2.4.48-6_amd64.deb

/opt/deb/libdpkg-perl_1.20.12_all.deb

/opt/deb/patch_2.7.6-7_amd64.deb

/opt/deb/libfakeroot_1.25.3-1.1_amd64.deb

/opt/deb/fakeroot_1.25.3-1.1_amd64.deb

/opt/deb/libfile-dirlist-perl_0.05-2_all.deb

/opt/deb/libfile-which-perl_1.23-1_all.deb

/opt/deb/libfile-homedir-perl_1.006-1_all.deb

/opt/deb/libfile-touch-perl_0.11-1_all.deb

/opt/deb/libio-pty-perl_1%3a1.15-2_amd64.deb

/opt/deb/libipc-run-perl_20200505.0-1_all.deb

/opt/deb/libclass-method-modifiers-perl_2.13-1_all.deb

/opt/deb/libb-hooks-op-check-perl_0.22-1+b3_amd64.deb

/opt/deb/libdynaloader-functions-perl_0.003-1.1_all.deb

/opt/deb/libdevel-callchecker-perl_0.008-1+b2_amd64.deb

/opt/deb/libparams-classify-perl_0.015-1+b3_amd64.deb

/opt/deb/libmodule-runtime-perl_0.016-1_all.deb

/opt/deb/libimport-into-perl_1.002005-1_all.deb

/opt/deb/librole-tiny-perl_2.002004-1_all.deb

/opt/deb/libstrictures-perl_2.000006-1_all.deb

/opt/deb/libsub-quote-perl_2.006006-1_all.deb

/opt/deb/libmoo-perl_2.004004-1_all.deb

/opt/deb/libencode-locale-perl_1.05-1.1_all.deb

/opt/deb/libtimedate-perl_2.3300-2_all.deb

/opt/deb/libhttp-date-perl_6.05-1_all.deb

/opt/deb/libfile-listing-perl_6.14-1_all.deb

/opt/deb/libhtml-tagset-perl_3.20-4_all.deb

/opt/deb/liburi-perl_5.08-1_all.deb

/opt/deb/libhtml-parser-perl_3.75-1+b1_amd64.deb

/opt/deb/libhtml-tree-perl_5.07-2_all.deb

/opt/deb/libio-html-perl_1.004-2_all.deb

/opt/deb/liblwp-mediatypes-perl_6.04-1_all.deb

/opt/deb/libhttp-message-perl_6.28-1_all.deb

/opt/deb/libhttp-cookies-perl_6.10-1_all.deb

/opt/deb/libhttp-negotiate-perl_6.01-1_all.deb

/opt/deb/perl-openssl-defaults_5_amd64.deb

/opt/deb/libnet-ssleay-perl_1.88-3+b1_amd64.deb

/opt/deb/libio-socket-ssl-perl_2.069-1_all.deb

/opt/deb/libnet-http-perl_6.20-1_all.deb

/opt/deb/liblwp-protocol-https-perl_6.10-1_all.deb

/opt/deb/libtry-tiny-perl_0.30-1_all.deb

/opt/deb/libwww-robotrules-perl_6.02-1_all.deb

/opt/deb/libwww-perl_6.52-1_all.deb

/opt/deb/patchutils_0.4.2-1_amd64.deb

/opt/deb/libatomic1_10.2.1-6_amd64.deb

/opt/deb/libquadmath0_10.2.1-6_amd64.deb

/opt/deb/libgcc-10-dev_10.2.1-6_amd64.deb

/opt/deb/gcc-10_10.2.1-6_amd64.deb

/opt/deb/gcc_4%3a10.2.1-1_amd64.deb

/opt/deb/libgdbm-compat-dev_1.19-2_amd64.deb

/opt/deb/libpython2.7-minimal_2.7.18-8_amd64.deb

/opt/deb/python2.7-minimal_2.7.18-8_amd64.deb

/opt/deb/python2-minimal_2.7.18-3_amd64.deb

/opt/deb/mime-support_3.66_all.deb

/opt/deb/libpython2.7-stdlib_2.7.18-8_amd64.deb

/opt/deb/python2.7_2.7.18-8_amd64.deb

/opt/deb/libpython2-stdlib_2.7.18-3_amd64.deb

/opt/deb/python2_2.7.18-3_amd64.deb

/opt/deb/python-is-python2_2.7.18-9_all.deb

/opt/deb/python3-dnspython_2.0.0-1_all.deb

/opt/deb/libpython3.9_3.9.2-1_amd64.deb

/opt/deb/python3-ldb_2%3a2.2.3-2~deb11u1_amd64.deb

/opt/deb/python3-tdb_1.4.3-1+b1_amd64.deb

/opt/deb/libavahi-common-data_0.8-5_amd64.deb

/opt/deb/python3-talloc_2.3.1-2+b1_amd64.deb

/opt/deb/python3-samba_2%3a4.13.13+dfsg-1~deb11u3_amd64.deb

Selecting previously unselected package ntpdate.

(Reading database ... 16440 files and directories currently installed.)

Preparing to unpack .../ntpdate_1%3a4.2.8p15+dfsg-1_amd64.deb ...

Unpacking ntpdate (1:4.2.8p15+dfsg-1) ...

Selecting previously unselected package gawk.

Preparing to unpack .../deb/gawk_1%3a5.1.0-1_amd64.deb ...

Unpacking gawk (1:5.1.0-1) ...

Selecting previously unselected package uuid-runtime.

Preparing to unpack .../uuid-runtime_2.36.1-8+deb11u1_amd64.deb ...

Unpacking uuid-runtime (2.36.1-8+deb11u1) ...

Preparing to unpack .../libssl1.1_1.1.1n-0+deb11u3_amd64.deb ...

Unpacking libssl1.1:amd64 (1.1.1n-0+deb11u3) over (1.1.1n-0+deb11u1) ...

Selecting previously unselected package attr.

Preparing to unpack .../attr_1%3a2.4.48-6_amd64.deb ...

Unpacking attr (1:2.4.48-6) ...

Selecting previously unselected package libdpkg-perl.

Preparing to unpack .../libdpkg-perl_1.20.12_all.deb ...

Unpacking libdpkg-perl (1.20.12) ...

Selecting previously unselected package patch.

1;39mSystem Logg[   43.976333][  T371] Unpacking patch (2.7.6-7) ...

Selecting previously unselected package libfakeroot:amd64.

Preparing to unpack .../libfakeroot_1.25.3-1.1_amd64.deb ...

Unpacking libfakeroot:amd64 (1.25.3-1.1) ...

Selecting previously unselected package fakeroot.

Preparing to unpack .../fakeroot_1.25.3-1.1_amd64.deb ...

Unpacking fakeroot (1.25.3-1.1) ...

Selecting previously unselected package libfile-dirlist-perl.

Preparing to unpack .../libfile-dirlist-perl_0.05-2_all.deb ...

Unpacking libfile-dirlist-perl (0.05-2) ...

Selecting previously unselected package libfile-which-perl.

Preparing to unpack .../libfile-which-perl_1.23-1_all.deb ...

Unpacking libfile-which-perl (1.23-1) ...

Selecting previously unselected package libfile-homedir-perl.

Preparing to unpack .../libfile-homedir-perl_1.006-1_all.deb ...

Unpacking libfile-homedir-perl (1.006-1) ...

Selecting previously unselected package libfile-touch-perl.

Preparing to unpack .../libfile-touch-perl_0.11-1_all.deb ...

Unpacking libfile-touch-perl (0.11-1) ...

Selecting previously unselected package libio-pty-perl.

Preparing to unpack .../libio-pty-perl_1%3a1.15-2_amd64.deb ...

Unpacking libio-pty-perl (1:1.15-2) ...

Selecting previously unselected package libipc-run-perl.

Preparing to unpack .../libipc-run-perl_20200505.0-1_all.deb ...

Unpacking libipc-run-perl (20200505.0-1) ...

Selecting previously unselected package libclass-method-modifiers-perl.

Preparing to unpack .../libclass-method-modifiers-perl_2.13-1_all.deb ...

Unpacking libclass-method-modifiers-perl (2.13-1) ...

Selecting previously unselected package libb-hooks-op-check-perl.

Preparing to unpack .../libb-hooks-op-check-perl_0.22-1+b3_amd64.deb ...

Unpacking libb-hooks-op-check-perl (0.22-1+b3) ...

Selecting previously unselected package libdynaloader-functions-perl.

Preparing to unpack .../libdynaloader-functions-perl_0.003-1.1_all.deb ...

Unpacking libdynaloader-functions-perl (0.003-1.1) ...

Selecting previously unselected package libdevel-callchecker-perl.

Preparing to unpack .../libdevel-callchecker-perl_0.008-1+b2_amd64.deb ...

Unpacking libdevel-callchecker-perl (0.008-1+b2) ...

Selecting previously unselected package libparams-classify-perl.

Preparing to unpack .../libparams-classify-perl_0.015-1+b3_amd64.deb ...

Unpacking libparams-classify-perl (0.015-1+b3) ...

Selecting previously unselected package libmodule-runtime-perl.

Preparing to unpack .../libmodule-runtime-perl_0.016-1_all.deb ...

Unpacking libmodule-runtime-perl (0.016-1) ...

Selecting previously unselected package libimport-into-perl.

Preparing to unpack .../libimport-into-perl_1.002005-1_all.deb ...

Unpacking libimport-into-perl (1.002005-1) ...

Selecting previously unselected package librole-tiny-perl.

Preparing to unpack .../librole-tiny-perl_2.002004-1_all.deb ...

Unpacking librole-tiny-perl (2.002004-1) ...

Selecting previously unselected package libstrictures-perl.

Preparing to unpack .../libstrictures-perl_2.000006-1_all.deb ...

Unpacking libstrictures-perl (2.000006-1) ...

Selecting previously unselected package libsub-quote-perl.

Preparing to unpack .../libsub-quote-perl_2.006006-1_all.deb ...

Unpacking libsub-quote-perl (2.006006-1) ...

Selecting previously unselected package libmoo-perl.

Preparing to unpack .../libmoo-perl_2.004004-1_all.deb ...

Unpacking libmoo-perl (2.004004-1) ...

Selecting previously unselected package libencode-locale-perl.

Preparing to unpack .../libencode-locale-perl_1.05-1.1_all.deb ...

Unpacking libencode-locale-perl (1.05-1.1) ...

Selecting previously unselected package libtimedate-perl.

Preparing to unpack .../libtimedate-perl_2.3300-2_all.deb ...

Unpacking libtimedate-perl (2.3300-2) ...

Selecting previously unselected package libhttp-date-perl.

Preparing to unpack .../libhttp-date-perl_6.05-1_all.deb ...

Unpacking libhttp-date-perl (6.05-1) ...

Selecting previously unselected package libfile-listing-perl.

Preparing to unpack .../libfile-listing-perl_6.14-1_all.deb ...

Unpacking libfile-listing-perl (6.14-1) ...

Selecting previously unselected package libhtml-tagset-perl.

Preparing to unpack .../libhtml-tagset-perl_3.20-4_all.deb ...

Unpacking libhtml-tagset-perl (3.20-4) ...

Selecting previously unselected package liburi-perl.

Preparing to unpack .../deb/liburi-perl_5.08-1_all.deb ...

Unpacking liburi-perl (5.08-1) ...

Selecting previously unselected package libhtml-parser-perl.

Preparing to unpack .../libhtml-parser-perl_3.75-1+b1_amd64.deb ...

Unpacking libhtml-parser-perl (3.75-1+b1) ...

Selecting previously unselected package libhtml-tree-perl.

Preparing to unpack .../libhtml-tree-perl_5.07-2_all.deb ...

Unpacking libhtml-tree-perl (5.07-2) ...

Selecting previously unselected package libio-html-perl.

Preparing to unpack .../libio-html-perl_1.004-2_all.deb ...

Unpacking libio-html-perl (1.004-2) ...

Selecting previously unselected package liblwp-mediatypes-perl.

Preparing to unpack .../liblwp-mediatypes-perl_6.04-1_all.deb ...

Unpacking liblwp-mediatypes-perl (6.04-1) ...

Selecting previously unselected package libhttp-message-perl.

Preparing to unpack .../libhttp-message-perl_6.28-1_all.deb ...

Unpacking libhttp-message-perl (6.28-1) ...

Selecting previously unselected package libhttp-cookies-perl.

Preparing to unpack .../libhttp-cookies-perl_6.10-1_all.deb ...

Unpacking libhttp-cookies-perl (6.10-1) ...

Selecting previously unselected package libhttp-negotiate-perl.

Preparing to unpack .../libhttp-negotiate-perl_6.01-1_all.deb ...

Unpacking libhttp-negotiate-perl (6.01-1) ...

Selecting previously unselected package perl-openssl-defaults:amd64.

Preparing to unpack .../perl-openssl-defaults_5_amd64.deb ...

Unpacking perl-openssl-defaults:amd64 (5) ...

Selecting previously unselected package libnet-ssleay-perl.

Preparing to unpack .../libnet-ssleay-perl_1.88-3+b1_amd64.deb ...

Unpacking libnet-ssleay-perl (1.88-3+b1) ...

Selecting previously unselected package libio-socket-ssl-perl.

Preparing to unpack .../libio-socket-ssl-perl_2.069-1_all.deb ...

Unpacking libio-socket-ssl-perl (2.069-1) ...

Selecting previously unselected package libnet-http-perl.

Preparing to unpack .../libnet-http-perl_6.20-1_all.deb ...

Unpacking libnet-http-perl (6.20-1) ...

Selecting previously unselected package liblwp-protocol-https-perl.

Preparing to unpack .../liblwp-protocol-https-perl_6.10-1_all.deb ...

Unpacking liblwp-protocol-https-perl (6.10-1) ...

Selecting previously unselected package libtry-tiny-perl.

Preparing to unpack .../libtry-tiny-perl_0.30-1_all.deb ...

Unpacking libtry-tiny-perl (0.30-1) ...

Selecting previously unselected package libwww-robotrules-perl.

Preparing to unpack .../libwww-robotrules-perl_6.02-1_all.deb ...

Unpacking libwww-robotrules-perl (6.02-1) ...

Selecting previously unselected package libwww-perl.

Preparing to unpack .../deb/libwww-perl_6.52-1_all.deb ...

Unpacking libwww-perl (6.52-1) ...

Selecting previously unselected package patchutils.

Preparing to unpack .../patchutils_0.4.2-1_amd64.deb ...

Unpacking patchutils (0.4.2-1) ...

Selecting previously unselected package libatomic1:amd64.

Preparing to unpack .../libatomic1_10.2.1-6_amd64.deb ...

Unpacking libatomic1:amd64 (10.2.1-6) ...

Selecting previously unselected package libquadmath0:amd64.

Preparing to unpack .../libquadmath0_10.2.1-6_amd64.deb ...

Unpacking libquadmath0:amd64 (10.2.1-6) ...

Selecting previously unselected package libgcc-10-dev:amd64.

Preparing to unpack .../libgcc-10-dev_10.2.1-6_amd64.deb ...

Unpacking libgcc-10-dev:amd64 (10.2.1-6) ...

Selecting previously unselected package gcc-10.

Preparing to unpack .../deb/gcc-10_10.2.1-6_amd64.deb ...

Unpacking gcc-10 (10.2.1-6) ...

Selecting previously unselected package gcc.

Preparing to unpack .../deb/gcc_4%3a10.2.1-1_amd64.deb ...

Unpacking gcc (4:10.2.1-1) ...

Selecting previously unselected package libgdbm-compat-dev.

Preparing to unpack .../libgdbm-compat-dev_1.19-2_amd64.deb ...

Unpacking libgdbm-compat-dev (1.19-2) ...

Selecting previously unselected package libpython2.7-minimal:amd64.

Preparing to unpack .../libpython2.7-minimal_2.7.18-8_amd64.deb ...

Unpacking libpython2.7-minimal:amd64 (2.7.18-8) ...

Selecting previously unselected package python2.7-minimal.

Preparing to unpack .../python2.7-minimal_2.7.18-8_amd64.deb ...

Unpacking python2.7-minimal (2.7.18-8) ...

Selecting previously unselected package python2-minimal.

Preparing to unpack .../python2-minimal_2.7.18-3_amd64.deb ...

Unpacking python2-minimal (2.7.18-3) ...

Selecting previously unselected package mime-support.

Preparing to unpack .../deb/mime-support_3.66_all.deb ...

Unpacking mime-support (3.66) ...

Selecting previously unselected package libpython2.7-stdlib:amd64.

Preparing to unpack .../libpython2.7-stdlib_2.7.18-8_amd64.deb ...

Unpacking libpython2.7-stdlib:amd64 (2.7.18-8) ...

Selecting previously unselected package python2.7.

Preparing to unpack .../python2.7_2.7.18-8_amd64.deb ...

Unpacking python2.7 (2.7.18-8) ...

Selecting previously unselected package libpython2-stdlib:amd64.

Preparing to unpack .../libpython2-stdlib_2.7.18-3_amd64.deb ...

Unpacking libpython2-stdlib:amd64 (2.7.18-3) ...

Selecting previously unselected package python2.

Preparing to unpack .../deb/python2_2.7.18-3_amd64.deb ...

Unpacking python2 (2.7.18-3) ...

Selecting previously unselected package python-is-python2.

Preparing to unpack .../python-is-python2_2.7.18-9_all.deb ...

Unpacking python-is-python2 (2.7.18-9) ...

Selecting previously unselected package python3-dnspython.

Preparing to unpack .../python3-dnspython_2.0.0-1_all.deb ...

Unpacking python3-dnspython (2.0.0-1) ...

Selecting previously unselected package libpython3.9:amd64.

Preparing to unpack .../libpython3.9_3.9.2-1_amd64.deb ...

Unpacking libpython3.9:amd64 (3.9.2-1) ...

Selecting previously unselected package python3-ldb.

Preparing to unpack .../python3-ldb_2%3a2.2.3-2~deb11u1_amd64.deb ...

Unpacking python3-ldb (2:2.2.3-2~deb11u1) ...

Selecting previously unselected package python3-tdb.

Preparing to unpack .../python3-tdb_1.4.3-1+b1_amd64.deb ...

Unpacking python3-tdb (1.4.3-1+b1) ...

Selecting previously unselected package libavahi-common-data:amd64.

Preparing to unpack .../libavahi-common-data_0.8-5_amd64.deb ...

Unpacking libavahi-common-data:amd64 (0.8-5) ...

Selecting previously unselected package python3-talloc:amd64.

Preparing to unpack .../python3-talloc_2.3.1-2+b1_amd64.deb ...

Unpacking python3-talloc:amd64 (2.3.1-2+b1) ...

Selecting previously unselected package python3-samba.

Preparing to unpack .../python3-samba_2%3a4.13.13+dfsg-1~deb11u3_amd64.deb ...

Unpacking python3-samba (2:4.13.13+dfsg-1~deb11u3) ...

Setting up uuid-runtime (2.36.1-8+deb11u1) ...

Adding group `uuidd' (GID 111) ...

Done.

Warning: The home dir /run/uuidd you specified can't be accessed: No such file or directory

Adding system user `uuidd' (UID 107) ...

Adding new user `uuidd' (UID 107) with group `uuidd' ...

Not creating home directory `/run/uuidd'.

Setting up libssl1.1:amd64 (1.1.1n-0+deb11u3) ...

Setting up attr (1:2.4.48-6) ...

Setting up libdpkg-perl (1.20.12) ...

Setting up patch (2.7.6-7) ...

Setting up libfakeroot:amd64 (1.25.3-1.1) ...

Setting up fakeroot (1.25.3-1.1) ...

update-alternatives: using /usr/bin/fakeroot-sysv to provide /usr/bin/fakeroot (fakeroot) in auto mode

Setting up libfile-dirlist-perl (0.05-2) ...

Setting up libfile-which-perl (1.23-1) ...

Setting up libfile-homedir-perl (1.006-1) ...

Setting up libfile-touch-perl (0.11-1) ...

Setting up libio-pty-perl (1:1.15-2) ...

Setting up libipc-run-perl (20200505.0-1) ...

Setting up libclass-method-modifiers-perl (2.13-1) ...

Setting up libb-hooks-op-check-perl (0.22-1+b3) ...

Setting up libdynaloader-functions-perl (0.003-1.1) ...

Setting up libdevel-callchecker-perl (0.008-1+b2) ...

Setting up libparams-classify-perl (0.015-1+b3) ...

Setting up libmodule-runtime-perl (0.016-1) ...

Setting up libimport-into-perl (1.002005-1) ...

Setting up librole-tiny-perl (2.002004-1) ...

Setting up libstrictures-perl (2.000006-1) ...

Setting up libsub-quote-perl (2.006006-1) ...

Setting up libmoo-perl (2.004004-1) ...

Setting up libencode-locale-perl (1.05-1.1) ...

Setting up libtimedate-perl (2.3300-2) ...

Setting up libhttp-date-perl (6.05-1) ...

Setting up libfile-listing-perl (6.14-1) ...

Setting up libhtml-tagset-perl (3.20-4) ...

Setting up liburi-perl (5.08-1) ...

Setting up libhtml-parser-perl (3.75-1+b1) ...

Setting up libhtml-tree-perl (5.07-2) ...

Setting up libio-html-perl (1.004-2) ...

Setting up liblwp-mediatypes-perl (6.04-1) ...

Setting up libhttp-message-perl (6.28-1) ...

Setting up libhttp-cookies-perl (6.10-1) ...

Setting up libhttp-negotiate-perl (6.01-1) ...

Setting up perl-openssl-defaults:amd64 (5) ...

Setting up libnet-ssleay-perl (1.88-3+b1) ...

Setting up libio-socket-ssl-perl (2.069-1) ...

Setting up libnet-http-perl (6.20-1) ...

Setting up libtry-tiny-perl (0.30-1) ...

Setting up libwww-robotrules-perl (6.02-1) ...

Setting up patchutils (0.4.2-1) ...

Setting up libatomic1:amd64 (10.2.1-6) ...

Setting up libquadmath0:amd64 (10.2.1-6) ...

Setting up libpython2.7-minimal:amd64 (2.7.18-8) ...

Setting up python2.7-minimal (2.7.18-8) ...

Linking and byte-compiling packages for runtime python2.7...

Setting up python2-minimal (2.7.18-3) ...

Setting up python3-dnspython (2.0.0-1) ...

Setting up libpython3.9:amd64 (3.9.2-1) ...

Setting up libavahi-common-data:amd64 (0.8-5) ...

Setting up ntpdate (1:4.2.8p15+dfsg-1) ...

Setting up liblwp-protocol-https-perl (6.10-1) ...

Setting up libwww-perl (6.52-1) ...

Setting up libgdbm-compat-dev (1.19-2) ...

Setting up mime-support (3.66) ...

Setting up libpython2.7-stdlib:amd64 (2.7.18-8) ...

Setting up python2.7 (2.7.18-8) ...

Setting up libpython2-stdlib:amd64 (2.7.18-3) ...

Setting up python2 (2.7.18-3) ...

Setting up python-is-python2 (2.7.18-9) ...

Setting up python3-ldb (2:2.2.3-2~deb11u1) ...

Setting up python3-tdb (1.4.3-1+b1) ...

Setting up python3-talloc:amd64 (2.3.1-2+b1) ...

Setting up python3-samba (2:4.13.13+dfsg-1~deb11u3) ...

Setting up gawk (1:5.1.0-1) ...

Setting up libgcc-10-dev:amd64 (10.2.1-6) ...

Setting up gcc-10 (10.2.1-6) ...

Setting up gcc (4:10.2.1-1) ...

Processing triggers for libc-bin (2.31-13+deb11u3) ...

20 Jan 21:20:52 ntpdate[1312]: step time server 192.168.1.200 offset -119.407219 sec

BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device sdb1): disk space caching is enabled
BTRFS info (device sdb1): enabling ssd optimizations
LKP: ttyS0: 340:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.yaml
LKP: ttyS0: 1340: current_version: f0, target_version: f0
calling  dm_init+0x0/0xd2 [dm_mod] @ 1412
device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
initcall dm_init+0x0/0xd2 [dm_mod] returned 0 after 28026 usecs
LKP: stdout: 340:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.yaml

RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/3

job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.yaml

result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/3, TMP_RESULT_ROOT: /tmp/lkp/result

run-job /lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.yaml

/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230121-60323-1eylmld-5.yaml&job_state=running -O /dev/null

target ucode: 0xf0

LKP: stdout: 1340: current_version: f0, target_version: f0

2023-01-20 21:20:54 dmsetup remove_all

2023-01-20 21:20:54 wipefs -a --force /dev/sda1

/dev/sda1: 2 bytes were erased at offset 0x00000438 (ext4): 53 ef

2023-01-20 21:20:54 wipefs -a --force /dev/sda2

2023-01-20 21:20:54 wipefs -a --force /dev/sda3

2023-01-20 21:20:54 wipefs -a --force /dev/sda4

2023-01-20 21:20:54 mkfs -t ext4 -q -F /dev/sda1

2023-01-20 21:20:54 mkfs -t ext4 -q -F /dev/sda3

2023-01-20 21:20:54 mkfs -t ext4 -q -F /dev/sda4

2023-01-20 21:20:54 mkfs -t ext4 -q -F /dev/sda2

2023-01-20 21:21:30 mkdir -p /fs/sda1

	ext4

2023-01-20 21:21:30 mount -t ext4 /dev/sda1 /fs/sda1

EXT4-fs (sda1): mounted filesystem ff2f5c74-0a42-4c2c-b45c-dc5f5cbd5839 with ordered data mode. Quota mode: none.
2023-01-20 21:21:30 mkdir -p /fs/sda2

	ext4

2023-01-20 21:21:30 mount -t ext4 /dev/sda2 /fs/sda2

EXT4-fs (sda2): mounted filesystem 9bdbabe4-75d5-4270-8767-01a4bab5b3a7 with ordered data mode. Quota mode: none.
2023-01-20 21:21:30 mkdir -p /fs/sda3

	ext4

2023-01-20 21:21:30 mount -t ext4 /dev/sda3 /fs/sda3

EXT4-fs (sda3): mounted filesystem d1f0eec2-9af3-4001-896b-43258fdf0b94 with ordered data mode. Quota mode: none.
2023-01-20 21:21:30 mkdir -p /fs/sda4

	ext4

2023-01-20 21:21:31 mount -t ext4 /dev/sda4 /fs/sda4

EXT4-fs (sda4): mounted filesystem 3685060e-c6a8-4829-911f-57a1d52840ad with ordered data mode. Quota mode: none.
Added user root.

2023-01-20 21:21:31 mkdir -p /cifs/sda1

2023-01-20 21:21:31 timeout 5m mount -t cifs -o vers=3.0 -o user=root,password=pass //localhost/fs/sda1 /cifs/sda1

calling  init_dns_resolver+0x0/0x1000 [dns_resolver] @ 1528
Key type dns_resolver registered
initcall init_dns_resolver+0x0/0x1000 [dns_resolver] returned 0 after 4972 usecs
calling  init_cifs+0x0/0x1000 [cifs] @ 1528
calling  init_nls_utf8+0x0/0x1000 [nls_utf8] @ 1534
initcall init_nls_utf8+0x0/0x1000 [nls_utf8] returned 0 after 0 usecs
Key type cifs.spnego registered
Key type cifs.idmap registered
initcall init_cifs+0x0/0x1000 [cifs] returned 0 after 18697 usecs
CIFS: Attempting to mount \\localhost\fs
calling  crypto_cmac_module_init+0x0/0x1000 [cmac] @ 1544
initcall crypto_cmac_module_init+0x0/0x1000 [cmac] returned 0 after 0 usecs
mount cifs success

2023-01-20 21:21:31 mkdir -p /cifs/sda2

2023-01-20 21:21:31 timeout 5m mount -t cifs -o vers=3.0 -o user=root,password=pass //localhost/fs/sda2 /cifs/sda2

CIFS: Attempting to mount \\localhost\fs
mount cifs success

2023-01-20 21:21:31 mkdir -p /cifs/sda3

2023-01-20 21:21:31 timeout 5m mount -t cifs -o vers=3.0 -o user=root,password=pass //localhost/fs/sda3 /cifs/sda3

CIFS: Attempting to mount \\localhost\fs
mount cifs success

2023-01-20 21:21:31 mkdir -p /cifs/sda4

2023-01-20 21:21:31 timeout 5m mount -t cifs -o vers=3.0 -o user=root,password=pass //localhost/fs/sda4 /cifs/sda4

CIFS: Attempting to mount \\localhost\fs
mount cifs success

x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3a02000-0xb3a02fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3a02000-0xb3a02fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3a02000-0xb3a02fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
EXT4-fs (sda1): unmounting filesystem ff2f5c74-0a42-4c2c-b45c-dc5f5cbd5839.
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
EXT4-fs (sda2): unmounting filesystem 9bdbabe4-75d5-4270-8767-01a4bab5b3a7.
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
EXT4-fs (sda3): unmounting filesystem d1f0eec2-9af3-4001-896b-43258fdf0b94.
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
EXT4-fs (sda4): unmounting filesystem 3685060e-c6a8-4829-911f-57a1d52840ad.
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3e7a000-0xb3e7afff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
x86/PAT: bmc-watchdog:1599 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
2023-01-20 21:21:33 mount /dev/sda1 /fs/sda1

EXT4-fs (sda1): mounted filesystem ff2f5c74-0a42-4c2c-b45c-dc5f5cbd5839 with ordered data mode. Quota mode: none.
2023-01-20 21:21:34 mkdir -p /smbv3//cifs/sda1

2023-01-20 21:21:34 export FSTYP=cifs

2023-01-20 21:21:34 export TEST_DEV=//localhost/fs/sda1

2023-01-20 21:21:34 export TEST_DIR=/smbv3//cifs/sda1

2023-01-20 21:21:34 export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=3.0,mfsymlinks,actimeo=0

2023-01-20 21:21:34 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-group-12

2023-01-20 21:21:34 ./check -E tests/cifs/exclude.incompatible-smb3.txt -E tests/cifs/exclude.very-slow.txt generic/240 generic/241 generic/242 generic/243 generic/244 generic/245 generic/246 generic/247 generic/248 generic/249 generic/250 generic/251 generic/252 generic/253 generic/254 generic/255 generic/256 generic/257 generic/258 generic/259

CIFS: Attempting to mount \\localhost\fs
512+0 records in

512+0 records out

FSTYP         -- cifs

PLATFORM      -- Linux/x86_64 lkp-skl-d07 6.1.0-rc4-00062-gce10c493af38 #1 SMP Thu Jan 19 11:18:50 CST 2023



run fstests generic/240 at 2023-01-20 21:21:35
Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
generic/240       [not run] fs block size must be larger than the device block size.  fs block size: 1024, device block size: 4096

run fstests generic/241 at 2023-01-20 21:21:36
262144 bytes (262 kB, 256 KiB) copied, 0.317932 s, 825 kB/s

512+0 records in

512+0 records out

262144 bytes (262 kB, 256 KiB) copied, 0.116779 s, 2.2 MB/s

512+0 records in

512+0 records out

262144 bytes (262 kB, 256 KiB) copied, 0.0354582 s, 7.4 MB/s

Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
generic/241       IPMI BMC is not supported on this machine, skip bmc-watchdog setup!

75s

run fstests generic/242 at 2023-01-20 21:22:51
generic/242       [not run] this test requires a valid $SCRATCH_DEV

run fstests generic/243 at 2023-01-20 21:22:51
generic/243       [not run] this test requires a valid $SCRATCH_DEV

run fstests generic/244 at 2023-01-20 21:22:52
generic/244       [not run] disk quotas not supported by this filesystem type: cifs

generic/245       [expunged]

run fstests generic/246 at 2023-01-20 21:22:52
Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
generic/246        1s

run fstests generic/247 at 2023-01-20 21:22:53
Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
generic/247        19s

run fstests generic/248 at 2023-01-20 21:23:12
CIFS: Attempting to mount \\localhost\fs
Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
generic/248        1s

run fstests generic/249 at 2023-01-20 21:23:13
Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
generic/249        1s

run fstests generic/250 at 2023-01-20 21:23:15
generic/250       [not run] this test requires a valid $SCRATCH_DEV

run fstests generic/251 at 2023-01-20 21:23:15
generic/251       [not run] this test requires a valid $SCRATCH_DEV

run fstests generic/252 at 2023-01-20 21:23:16
generic/252       [not run] this test requires a valid $SCRATCH_DEV

run fstests generic/253 at 2023-01-20 21:23:16
generic/253       [not run] this test requires a valid $SCRATCH_DEV

run fstests generic/254 at 2023-01-20 21:23:17
Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
generic/254       [not run] this test requires a valid $SCRATCH_DEV

run fstests generic/255 at 2023-01-20 21:23:18
Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
EXT4-fs error (device sda1): ext4_ext_rm_leaf:2663: inode #13: comm smbd: can not handle truncate 16:47 on extent 0:79
------------[ cut here ]------------
kernel BUG at fs/ext4/extents_status.c:896!
invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 1847 Comm: smbd Not tainted 6.1.0-rc4-00062-gce10c493af38 #1
Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
RIP: 0010:ext4_es_cache_extent+0x343/0x370
Code: 48 8b 0c 24 e9 98 fd ff ff 44 89 44 24 0c 48 89 0c 24 e8 b0 dc d0 ff 44 8b 44 24 0c 48 8b 0c 24 e9 55 fd ff ff e8 fd 30 97 01 <0f> 0b 48 c7 c7 40 ab 0f 85 e8 8f dc d0 ff e9 2d ff ff ff e8 85 dc
RSP: 0018:ffffc90001ea76e8 EFLAGS: 00010203
RAX: 07ffffffffffffff RBX: 1ffff920003d4edf RCX: 07ffffffffffffff
RDX: 1ffff11022179815 RSI: 0000000000000050 RDI: ffff888110bcc0a8
RBP: 000000000000002f R08: 47ffffffffffffff R09: ffffc90001ea7693
R10: fffff520003d4ed2 R11: 0000000000000001 R12: ffff888429b96c20
R13: 0000000000000050 R14: dffffc0000000000 R15: ffff888110bcc000
FS:  00007fa7e95b0a40(0000) GS:ffff88837d080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa7ed951c28 CR3: 000000011a476005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
? check_heap_object+0x297/0x3f0
? ext4_es_insert_extent+0x500/0x500
? __check_object_size+0x4f/0x140
? ext4_find_extent+0x7f7/0xd30
ext4_cache_extents+0x189/0x240
? ext4_find_extent+0x7f7/0xd30
ext4_find_extent+0x8a9/0xd30
ext4_ext_map_blocks+0x15d/0x1fc0
? sched_clock_cpu+0x69/0x250
? ext4_ext_release+0x10/0x10
? _raw_spin_lock_bh+0x85/0xe0
? raw_spin_rq_lock_nested+0x15/0x20
? release_sock+0xa5/0x170
? tcp_recvmsg+0xf4/0x4f0
? __cond_resched+0x1c/0x90
? down_read+0x137/0x220
? rwsem_down_read_slowpath+0xcb0/0xcb0
? ext4_es_lookup_extent+0x394/0x930
ext4_map_blocks+0x898/0x12c0
? inet6_release+0x60/0x60
? ext4_issue_zeroout+0x1b0/0x1b0
? jbd2_transaction_committed+0xde/0x120
? ext4_set_iomap+0x698/0xb50
ext4_iomap_begin_report+0x21b/0x4d0
? mpage_map_one_extent+0x4f0/0x4f0
? mpage_map_one_extent+0x4f0/0x4f0
? __copy_msghdr+0x3c0/0x3c0
? from_kgid_munged+0x84/0x100
? __might_fault+0x4d/0x70
? memset+0x20/0x40
? mpage_map_one_extent+0x4f0/0x4f0
iomap_iter+0x2c9/0x8e0
? iomap_iter+0x205/0x8e0
iomap_seek_hole+0x141/0x230
? iomap_fiemap+0x2a0/0x2a0
? rwsem_down_read_slowpath+0xcb0/0xcb0
? mutex_lock+0x9f/0xf0
? __mutex_lock_slowpath+0x10/0x10
ext4_llseek+0x1f3/0x280
ksys_lseek+0xd3/0x140
do_syscall_64+0x35/0x80
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7fa7ed7d5647
Code: ff ff ff ff c3 66 0f 1f 44 00 00 48 8b 15 79 a9 00 00 f7 d8 64 89 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 b8 08 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 51 a9 00 00 f7 d8 64 89 02 48
RSP: 002b:00007ffc907beeb8 EFLAGS: 00000202 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa7ed7d5647
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 000000000000002f
RBP: 000055cce7824b10 R08: 000055cce7858140 R09: 000055cce78248d5
R10: 000055cce78248d6 R11: 0000000000000202 R12: 000055cce7824960
R13: 000055cce7792c20 R14: 0000000000000000 R15: 000055cce7858140
</TASK>
Modules linked in: cmac nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver dm_mod btrfs blake2b_generic xor intel_rapl_msr intel_rapl_common raid6_pq zstd_compress libcrc32c i915 sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 x86_pkg_temp_thermal sg ipmi_devintf intel_powerclamp drm_buddy ipmi_msghandler coretemp kvm_intel kvm intel_gtt irqbypass crct10dif_pclmul drm_display_helper crc32_pclmul crc32c_intel ttm hp_wmi ghash_clmulni_intel sparse_keymap ahci drm_kms_helper sha512_ssse3 mei_wdt platform_profile syscopyarea rapl libahci sysfillrect mei_me rfkill intel_cstate wmi_bmof i2c_i801 sysimgblt video intel_uncore libata serio_raw i2c_smbus mei intel_pch_thermal fb_sys_fops wmi intel_pmc_core acpi_pad tpm_infineon drm fuse ip_tables
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_es_cache_extent+0x343/0x370
Code: 48 8b 0c 24 e9 98 fd ff ff 44 89 44 24 0c 48 89 0c 24 e8 b0 dc d0 ff 44 8b 44 24 0c 48 8b 0c 24 e9 55 fd ff ff e8 fd 30 97 01 <0f> 0b 48 c7 c7 40 ab 0f 85 e8 8f dc d0 ff e9 2d ff ff ff e8 85 dc
RSP: 0018:ffffc90001ea76e8 EFLAGS: 00010203
RAX: 07ffffffffffffff RBX: 1ffff920003d4edf RCX: 07ffffffffffffff
RDX: 1ffff11022179815 RSI: 0000000000000050 RDI: ffff888110bcc0a8
RBP: 000000000000002f R08: 47ffffffffffffff R09: ffffc90001ea7693
R10: fffff520003d4ed2 R11: 0000000000000001 R12: ffff888429b96c20
R13: 0000000000000050 R14: dffffc0000000000 R15: ffff888110bcc000
FS:  00007fa7e95b0a40(0000) GS:ffff88837d080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa7ed951c28 CR3: 000000011a476005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled

--dlqobGt1ml2DdgNT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/xfstests-cifs.yaml
suite: xfstests
testcase: xfstests
category: functional
need_memory: 1G
disk: 4HDD
fs: ext4
fs2: smbv3
xfstests:
  test: generic-group-12
job_origin: xfstests-cifs.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d07
tbox_group: lkp-skl-d07
submit_id: 63c8a898c10bc659da3a892a
job_file: "/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230119-23002-1m5xe6x-0.yaml"
id: ab873a9eba857029bac8ae2cc6274b6153290fa5
queuer_version: "/zday/lkp"

#! hosts/lkp-skl-d07
model: Skylake
nr_cpu: 8
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1"
brand: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/disk/nr_hdd
need_kconfig:
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- EXT4_FS

#! include/queue/cyclic
commit: ce10c493af382439876867dcaee89c7efddfab46

#! include/testbox/lkp-skl-d07
ucode: '0xf0'
bisect_dmesg: true

#! include/fs/OTHERS
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2023-01-19 10:19:05.108376538 +08:00
_id: 63c8a898c10bc659da3a892a
_rt: "/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 160bb02a598f1f5b1bc814e1f008dbc1fe7a0130
base_commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
branch: linux-devel/devel-hourly-20230117-072835
rootfs: debian-11.1-x86_64-20220510.cgz
result_root: "/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/0"
scheduler_version: "/lkp/lkp/.src-20230118-153556"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/xfstests/4HDD-ext4-smbv3-generic-group-12/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/vmlinuz-6.1.0-rc4-00062-gce10c493af38
- branch=linux-devel/devel-hourly-20230117-072835
- job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-smbv3-generic-group-12-debian-11.1-x86_64-20220510.cgz-ce10c493af382439876867dcaee89c7efddfab46-20230119-23002-1m5xe6x-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=ce10c493af382439876867dcaee89c7efddfab46
- initcall_debug
- nmi_watchdog=0
- max_uptime=1200
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw

#! runtime status
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs2_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/xfstests_20230116.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/xfstests-x86_64-fb6575e-1_20230116.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /db/releases/20230117110146/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 4.20.0
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-11/ce10c493af382439876867dcaee89c7efddfab46/vmlinuz-6.1.0-rc4-00062-gce10c493af38"
dequeue_time: 2023-01-19 11:29:27.533615619 +08:00

#! /cephfs/db/releases/20230119000137/lkp-src/include/site/inn
job_state: running

--dlqobGt1ml2DdgNT--
