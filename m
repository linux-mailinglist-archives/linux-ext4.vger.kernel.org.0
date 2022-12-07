Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50998645A17
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 13:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLGMoo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 07:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGMom (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 07:44:42 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC7F625E
        for <linux-ext4@vger.kernel.org>; Wed,  7 Dec 2022 04:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670417079; x=1701953079;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oLpmzeejWodX/7Qcv6sIrMl9lqpfrzA1FRkvrzuwVHs=;
  b=nYbqYr3EIQC9M7pDmVGwvA1hMfEg1CunU+WvPBnWaGgcgrKbWxseJYCL
   mwWQFhVNj/XDGLvMtXlHSz/OXAlni3n5dFn4G3fuTU+TSqqeznJ6eQPG0
   0+WMvp0a4V/iEX3jkHHn9kR3Pg/jaLsdfZIWh+N3wgSFg7Tl2jKG64EF3
   USuLBEeTGCoR2+N6ey91+bn71iYSXe0KJYM0j+bScVQVjXnzoJ0xIAlNt
   qGkvzrtyphagagH+jK+4mSnYw+sTYEN+ilCtIyQYaVvLiG+izD6kDRGIj
   EsVCqtyDVEH1RScLQCpSHZS+hBNScPEThcAhcUejBkh/k4RDh3Vj+izzN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="318023312"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="log'?scan'208";a="318023312"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 04:44:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="679124194"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="log'?scan'208";a="679124194"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2022 04:44:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 04:44:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 04:44:37 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 04:44:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmjhrVSQOLVtF9wP+O6+Ku69GGF41tOgBKMrQ5axNc+khc0AxsxQASh8VXZyPpRJ4wF4PyHeYqoXg7sK6JqMSoQDOSfubeQYbnzXjtUV6VCB4VbDOO+M371WkxiEU8riP+e5Ggjy4T7/0cciIaW4tsswmmsYOpq/a/W+nK+XiiX4H99mku6AuacOfCkCGRSUt8R0ehit36xLR8Knrc+n+XWr2H+Lonhd9L7bATNmBvho6ULiL+qL0l7Kutr+PFbNMNsgm+qF9VooVil3e/njv0U6125mIaVJn//UkLC0Ro5X6jY8ntXURLVoqo0Q9MwyEEcQrgIG416RUIk3HJWRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAv5wWlOJPfTI/n3kyUo5GuNJ9s4MVrmk8+dcxE/Joc=;
 b=ZIpM5zzdsgiehX1B/niXvaMzZeEKJqs7zU/P3OWGP0y/VbuKzcrHWvGCaa6U1ZkqcuARR4q1q6w+EmimkggVJ7A3skavrFdwvVK47CUYUfrdmAf/yRON6q2do/gWNm/6MrVMvFHquuqnDekxF51/T8oIK52eefaoIuvCTMrU9+l+GRThbKKbA1Qo1QsO9/DG+meFubjyrGcI8MdgCqnYyOAZA2MzBa4Y6nEUwi6WjU0uVIzKZOZopjmFKYUXKs7qZbnyCmeYURX6C5INMkd60QWlJGJmLJpaxbZSRXveaEO6QlxkwWs3VVXRKWIxmNW9zXveDh9UmO2vMzyqQYCY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW5PR11MB5932.namprd11.prod.outlook.com (2603:10b6:303:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 12:44:35 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28%2]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 12:44:35 +0000
Date:   Wed, 7 Dec 2022 20:45:11 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jan Kara <jack@suse.cz>
CC:     Ted Tso <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <heng.su@intel.com>, <pengfei.xu@intel.com>
Subject: Re: [PATCH 2/2] ext4: Avoid unaccounted block allocation when
 expanding inode
Message-ID: <Y5CK1/Ydc24D6q46@xpf.sh.intel.com>
References: <20221207115122.29033-1-jack@suse.cz>
 <20221207115937.26601-2-jack@suse.cz>
Content-Type: multipart/mixed; boundary="zz+P7kz/bu7wp1J1"
Content-Disposition: inline
In-Reply-To: <20221207115937.26601-2-jack@suse.cz>
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW5PR11MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc59031-5aee-41b1-d603-08dad850cbba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQeCu7os+ZdG17g2ABHQz1SCIusxlc3HPmtUW8QoJE1k23erGrsvT4bAhbzeIdJ+Zrti7AiYZrRM8f1nOuW6OjTBQEMFGnSg+Q6xMNl3eBIf/iZA3P14AMY5I/ktGl9DVOopaAD60eV5wrFmVMz9/cWTT3WaFW/hM0V6zJ/HzQLCsQqOP3kdPdsaJe7mX+hKWCLSnRjL+TZBbH5rua6rHch3LIgizNJPypmkmj2FXU+Px65tXShquhDvRIw6gczb7tFsFIV6SKOxCTQvsxikaVpDVig110AbxUs6JimYUKs2iqFBhM6RCn4RmXt5GytEUDmDwtasdsidiDrmysE9YSKseD5SJP1CWzA4ASNT9D3dRvdTM92X89Zvfszv/84VyUUGArI0ye8uD01noPaX+Enj6PBCckjR/Qb0TYbZIvsMDsTQaTTrJ6b8dceAg9fssTmLEb67CzXUuQtiJhw4g5OkTO/0ijgjBa64mAKciY0bMT3aESV45Ski5W8bL4Yt/0x7/7NC0WFwu2wCKH6DpRRd9zOmO9l7d/M3tljrJi6sXKbNufgHauGGPr/eFIywBtm2kD0uCfyopCF4y1YPj9vt4LdtOjU21YjhKD3/hZLfbCvSI6/LDzm2K3r+X4ZKE4/dz2Uk62z2SSOtsQAUOTNXyg5lkQj1pfUQ417dAut0I/BybSR8xdAXiEvgbSZETD6gdUQ6HdWcwVVvLSdvgcLIQg2o8cMB+oC+RWU+CE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(41300700001)(38100700002)(82960400001)(966005)(2906002)(186003)(83380400001)(5660300002)(235185007)(44832011)(8936002)(478600001)(21480400003)(107886003)(6666004)(44144004)(6486002)(53546011)(6506007)(66476007)(8676002)(86362001)(66556008)(66946007)(6512007)(26005)(4326008)(316002)(6916009)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xooBL2mPlt1wT5fVz5TRPE9Lgtv+lcoWjY3WV96ZsubTrNzXES4Dj6NfC8Qh?=
 =?us-ascii?Q?oKsZ/uuwt4elgE/H0ET4YXPCn/dopXaiXYcAiXs0/gGXACegzoX/ygBEW7Ky?=
 =?us-ascii?Q?oLsQzYN+4NpwX1lnvxsenvPBN4IDBU2XX5C+ACAoB5A8J5T4kglPk6V78x+K?=
 =?us-ascii?Q?1D4A01n8usNzHYgXCF8ERKAuVmaW9enNxfNGUS2+wQY4A+3Wuvs2bn70oJ3A?=
 =?us-ascii?Q?44vWhomtcaq3xLCfKMB3m6lnfmWNg1NMSziTR3OV9DF8iL8cfoV+ZKAR6dkZ?=
 =?us-ascii?Q?glJ8lo4C0frhrmLiUmDJKjullDF3Bg5lFvk9ovtjjtO2foZXQIq7kLXdM+9L?=
 =?us-ascii?Q?tHVQCHBoaROGw+Z7P7W4Va/cFljD02by9cBp7TLZJClnLYSe25gjh5Qt3f9e?=
 =?us-ascii?Q?ab8Gfk9FuXMVyzJhgezmi7pFKLoBqd9713afbtSF/1lFj7BFB7fJ7R7hucm9?=
 =?us-ascii?Q?lrfrH/uf+g1jSEbxbdtp/c0uYhT/nV1QQljultBGRP7wUtcmf0BB7u5V4Z0A?=
 =?us-ascii?Q?u5nPAOP0w0c0fuVb8AEO5tf7dK2YJxpqkv4YhyNbeq3aXCtHdzvMj9ML0ot9?=
 =?us-ascii?Q?H0Jfcmksom+LgOo56clUXO91C6ivMVb1m83l4mo+8VZVPeO5mBNDW2b1EBTT?=
 =?us-ascii?Q?ivlV/OGWXnbErYy9NhJpf5QSf0NsD72G0azPXa7tu7Wb++osHZjkDymPMSa5?=
 =?us-ascii?Q?aDWFSaWMIfuL3FhPOLJHu48vFjXr2+nFGQHpntE/CtK4CcLFj38fFSa3ObeR?=
 =?us-ascii?Q?8JsA3T7/ViRP6BF5EJ0YYAgzy9rlSnRoper1PSMBnvq4CbJE0XepSMV+Z0AE?=
 =?us-ascii?Q?t3ka6VMlAeTMLjz9YpSuDk8xfD2p4VwwyYIuB10jDLzf0dcTgSmgg0j7LcLd?=
 =?us-ascii?Q?S3EAtRWSsNtKZc1qTzBWwafSUzqn/7aiBYPaFfO/gjRxLuwpkVu4xVfxOlM3?=
 =?us-ascii?Q?8f/NOWDdo7e4Bh8fmSmPPt0AUQpbRRaIqQIuiRp8g02YaJuhMojOfoaZuOP6?=
 =?us-ascii?Q?S02+wrV1h0m2lU5alYg0igVSHhd43dScWZhm7+D9HsxPPpMgjb+WmAnOikN6?=
 =?us-ascii?Q?14b0PxxUhYNsmUGOBeircXjagYDvZu4Hg7X4fQV2oPHoHDUa24sO5y1PUYT1?=
 =?us-ascii?Q?WFzohjLRyRn+KBZnhxwb4j03LZ2DGpu822QxU+G6NV8xKEGHvn6SOoHa2t22?=
 =?us-ascii?Q?E28uY0pyvYwNIeZ+QzJ0kLwY6Hai3Gz7FhufBdhpr4LFywgRwxQ+XXJBTMuZ?=
 =?us-ascii?Q?CPIUvHGDKuyNsukvaQkMqizEij3pg3sizTbp0IgEIRNMvQp+5I52cCqIC17S?=
 =?us-ascii?Q?ed6tYj/NQ63gMZTaRn/PswP0QQEjjx7HN6uI4124TXBgYw5swmMicJWpEUOH?=
 =?us-ascii?Q?2Hs/oBDZmy1C5wCvIQ/0J4/KRdxcoYbfcBlR76yDCINz2mwNsEmS/dJm3Y+r?=
 =?us-ascii?Q?5c836WlDauW59GQxekmSfbUVwc9eoNj21z0Y2tcoY/9YJf28dOvwMc8urTYH?=
 =?us-ascii?Q?NVLfUPvF28QQzye0s2hzAn+j7+ITkqNlevLioaTqldgMkLUEcS/u/sg1ZBd0?=
 =?us-ascii?Q?p0UOVuwyginyJetLYsdf5R+DEXtHaaLLxUHwgag3S3iPbcRb541pJXfMKkz2?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc59031-5aee-41b1-d603-08dad850cbba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 12:44:35.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IxuLNqjVeWZFmFvvTjvWPxum8AzEKD6ftZZctbmVNBdFyIyYqMXAtOQU7QrkCftRtEAY9kH3E93AoiCntjEPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5932
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--zz+P7kz/bu7wp1J1
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Jan Kara,

On 2022-12-07 at 12:59:28 +0100, Jan Kara wrote:
> When expanding inode space in ext4_expand_extra_isize_ea() we may need
> to allocate external xattr block. If quota is not initialized for the
> inode, the block allocation will not be accounted into quota usage. Make
> sure the quota is initialized before we try to expand inode space.
> 
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lore.kernel.org/all/Y5BT+k6xWqthZc1P@xpf.sh.intel.com
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2b5ef1b64249..62c81af57bb0 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5853,6 +5853,14 @@ static int __ext4_expand_extra_isize(struct inode *inode,
>  		return 0;
>  	}
>  
> +	/*
> +	 * We may need to allocate external xattr block so we need quotas
> +	 * initialized. Here we can be called with various locks held so we
> +	 * cannot affort to initialize quotas ourselves. So just bail.
> +	 */
> +	if (dquot_initialize_needed(inode))
> +		return -EAGAIN;
> +
>  	/* try to expand with EAs present */
>  	error = ext4_expand_extra_isize_ea(inode, new_extra_isize,
>  					   raw_inode, handle);

I installed the both patches on top of v6.1-rc8, and tested again, and
this issue was gone, result shows that it's fixed.
Attached is the dmesg.

Thanks!
BR.

> -- 
> 2.35.3
> 

--zz+P7kz/bu7wp1J1
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="6.1-rc8_with_jan_patch_fixed_dmesg.log"

[    0.000000] Linux version 6.1.0-rc8-kvm-ext4-2+ (root@xpf.sh.intel.com) (gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10), GNU ld version 2.36.1-2.el8) #16 SMP PRE2
[    0.000000] Command line: console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x207, context size is 840 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3632
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffe0000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000002] kvm-clock: using sched offset of 255876291 cycles
[    0.000337] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.001375] tsc: Detected 1881.600 MHz processor
[    0.008018] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.008033] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.008050] last_pfn = 0x7ffe0 max_arch_pfn = 0x400000000
[    0.008463] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.014275] found SMP MP-table at [mem 0x000f5a90-0x000f5a9f]
[    0.014729] Using GB pages for direct mapping
[    0.015981] ACPI: Early table checksum verification disabled
[    0.016367] ACPI: RSDP 0x00000000000F5870 000014 (v00 BOCHS )
[    0.016767] ACPI: RSDT 0x000000007FFE1959 000034 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.017363] ACPI: FACP 0x000000007FFE1805 000074 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.017957] ACPI: DSDT 0x000000007FFE0040 0017C5 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.018548] ACPI: FACS 0x000000007FFE0000 000040
[    0.018873] ACPI: APIC 0x000000007FFE1879 000080 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.019463] ACPI: HPET 0x000000007FFE18F9 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.020056] ACPI: WAET 0x000000007FFE1931 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
[    0.020643] ACPI: Reserving FACP table memory at [mem 0x7ffe1805-0x7ffe1878]
[    0.021137] ACPI: Reserving DSDT table memory at [mem 0x7ffe0040-0x7ffe1804]
[    0.021616] ACPI: Reserving FACS table memory at [mem 0x7ffe0000-0x7ffe003f]
[    0.022094] ACPI: Reserving APIC table memory at [mem 0x7ffe1879-0x7ffe18f8]
[    0.022573] ACPI: Reserving HPET table memory at [mem 0x7ffe18f9-0x7ffe1930]
[    0.023049] ACPI: Reserving WAET table memory at [mem 0x7ffe1931-0x7ffe1958]
[    0.024059] No NUMA configuration found
[    0.024315] Faking a node at [mem 0x0000000000000000-0x000000007ffdffff]
[    0.024812] NODE_DATA(0) allocated [mem 0x7ffb5000-0x7ffdffff]
[    0.028138] Zone ranges:
[    0.028324]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.028746]   DMA32    [mem 0x0000000001000000-0x000000007ffdffff]
[    0.029169]   Normal   empty
[    0.029367]   Device   empty
[    0.029564] Movable zone start for each node
[    0.029850] Early memory node ranges
[    0.030090]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.030514]   node   0: [mem 0x0000000000100000-0x000000007ffdffff]
[    0.030941] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdffff]
[    0.031737] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.031755] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.036663] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.037277] ACPI: PM-Timer IO Port: 0x608
[    0.037918] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.038308] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.038740] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.039134] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.039544] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.039954] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.040374] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.040807] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.041205] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.041534] TSC deadline timer available
[    0.041775] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.042107] kvm-guest: KVM setup pv remote TLB flush
[    0.042414] kvm-guest: setup PV sched yield
[    0.042706] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.043175] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.043640] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.044105] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.044571] [mem 0x80000000-0xfeffbfff] available for PCI devices
[    0.044947] Booting paravirtualized kernel on KVM
[    0.045240] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.045896] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.046631] percpu: Embedded 62 pages/cpu s217088 r8192 d28672 u1048576
[    0.047072] pcpu-alloc: s217088 r8192 d28672 u1048576 alloc=1*2097152
[    0.047088] pcpu-alloc: [0] 0 1 
[    0.047224] kvm-guest: PV spinlocks enabled
[    0.047496] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.047962] Fallback order for Node 0: 0 
[    0.048221] Built 1 zonelists, mobility grouping on.  Total pages: 515808
[    0.048647] Policy zone: DMA32
[    0.048840] Kernel command line: net.ifnames=0 console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0 thunderbolt.dyndbg
[    0.050108] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.050689] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.051259] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.054329] Memory: 1999736K/2096632K available (30736K kernel code, 4097K rwdata, 7580K rodata, 3636K init, 10496K bss, 96640K reserved, 0K cma-reserved)
[    0.055971] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.056367] kmemleak: Kernel memory leak detector disabled
[    0.056709] ftrace: allocating 67023 entries in 262 pages
[    0.072276] ftrace: allocated 262 pages with 3 groups
[    0.073575] Dynamic Preempt: voluntary
[    0.073865] rcu: Preemptible hierarchical RCU implementation.
[    0.074206] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
[    0.074609]  Trampoline variant of Tasks RCU enabled.
[    0.074908]  Rude variant of Tasks RCU enabled.
[    0.075176]  Tracing variant of Tasks RCU enabled.
[    0.075460] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.075907] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.099076] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16
[    0.099694] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.105764] Console: colour VGA+ 80x25
[    0.106024] printk: console [ttyS0] enabled
[    0.106534] printk: bootconsole [earlyser0] disabled
[    0.107161] ACPI: Core revision 20220331
[    0.107566] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.108191] APIC: Switch to symmetric I/O mode setup
[    0.108627] x2apic enabled
[    0.108936] Switched APIC routing to physical x2apic.
[    0.109259] kvm-guest: setup PV IPIs
[    0.110148] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.110535] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x363e8c91135, max_idle_ns: 881590568389 ns
[    0.111181] Calibrating delay loop (skipped) preset value.. 3763.20 BogoMIPS (lpj=7526400)
[    0.111688] pid_max: default: 32768 minimum: 301
[    0.112094] LSM: Security Framework initializing
[    0.115184] Yama: becoming mindful.
[    0.115531] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.115991] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.117058] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.117593] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.117926] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.118294] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.118808] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.119179] Spectre V2 : Mitigation: Enhanced IBRS
[    0.119459] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.119935] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.120366] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.120850] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.121339] MMIO Stale Data: Unknown: No mitigations
[    0.199619] Freeing SMP alternatives memory: 56K
[    0.200015] smpboot: CPU0: Genuine Intel(R) 0000 (family: 0x6, model: 0xba, stepping: 0x2)
[    0.200652] cblist_init_generic: Setting adjustable number of callback queues.
[    0.201069] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.201441] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.201806] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.202176] Performance Events: Alderlake Hybrid events, full-width counters, Intel PMU driver.
[    0.202950] core: cpu_core PMU driver: 
[    0.203174] ... version:                2
[    0.203174] ... bit width:              48
[    0.203174] ... generic registers:      6
[    0.203174] ... value mask:             0000ffffffffffff
[    0.203177] ... max period:             00007fffffffffff
[    0.203486] ... fixed-purpose events:   3
[    0.203720] ... event mask:             0001000f0000003f
[    0.204078] rcu: Hierarchical SRCU implementation.
[    0.204358] rcu:     Max phase no-delay instances is 1000.
[    0.206962] unchecked MSR access error: WRMSR to 0x38f (tried to write 0x0001000f0000003f) at rIP: 0xffffffff810c30bc (native_write_msr+0xc/0x30)
[    0.207174] Call Trace:
[    0.207174]  <TASK>
[    0.207174]  __intel_pmu_enable_all.constprop.46+0xb5/0x140
[    0.207174]  intel_pmu_enable_all+0x1e/0x30
[    0.207174]  x86_pmu_enable+0x46a/0x5a0
[    0.207174]  ? write_comp_data+0x2f/0x90
[    0.207174]  perf_pmu_enable+0x53/0x70
[    0.207174]  ctx_resched+0xab/0xf0
[    0.207174]  __perf_install_in_context+0x210/0x390
[    0.207174]  ? __sanitizer_cov_trace_pc+0x25/0x60
[    0.207174]  ? perf_duration_warn+0x50/0x50
[    0.207174]  remote_function+0x80/0xa0
[    0.207174]  ? perf_duration_warn+0x50/0x50
[    0.207174]  generic_exec_single+0xea/0x150
[    0.207174]  ? perf_duration_warn+0x50/0x50
[    0.207174]  smp_call_function_single+0x11c/0x240
[    0.207174]  ? perf_duration_warn+0x50/0x50
[    0.207174]  ? __sanitizer_cov_trace_pc+0x25/0x60
[    0.207174]  ? write_comp_data+0x2f/0x90
[    0.207174]  perf_install_in_context+0x292/0x2c0
[    0.207174]  ? ctx_resched+0xf0/0xf0
[    0.207174]  perf_event_create_kernel_counter+0x168/0x200
[    0.207174]  ? find_next_bit+0x30/0x30
[    0.207174]  hardlockup_detector_event_create+0x46/0xd0
[    0.207174]  hardlockup_detector_perf_init+0x18/0x66
[    0.207174]  watchdog_nmi_probe+0x17/0x1d
[    0.207174]  lockup_detector_init+0x40/0xad
[    0.207174]  kernel_init_freeable+0x1b0/0x37a
[    0.207174]  ? rest_init+0xe0/0xe0
[    0.207174]  kernel_init+0x24/0x1e0
[    0.207174]  ? rest_init+0xe0/0xe0
[    0.207174]  ret_from_fork+0x1f/0x30
[    0.207174]  </TASK>
[    0.207255] smp: Bringing up secondary CPUs ...
[    0.207648] x86: Booting SMP configuration:
[    0.207891] .... node  #0, CPUs:      #1
[    0.011051] smpboot: CPU 1 Converting physical 0 to logical die 1
[    0.211212] smp: Brought up 1 node, 2 CPUs
[    0.211467] smpboot: Max logical packages: 2
[    0.211716] smpboot: Total of 2 processors activated (7526.40 BogoMIPS)
[    0.212505] devtmpfs: initialized
[    0.212505] x86/mm: Memory block size: 128MB
[    0.212651] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.212651] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.215254] pinctrl core: initialized pinctrl subsystem

[    0.215825] *************************************************************
[    0.216213] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.216604] **                                                         **
[    0.216992] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    0.217380] **                                                         **
[    0.217770] ** This means that this kernel is built to expose internal **
[    0.218158] ** IOMMU data structures, which may compromise security on **
[    0.218546] ** your system.                                            **
[    0.218934] **                                                         **
[    0.219179] ** If you see this message and you are not debugging the   **
[    0.219566] ** kernel, report this immediately to your vendor!         **
[    0.219954] **                                                         **
[    0.220344] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.220735] *************************************************************
[    0.221158] PM: RTC time: 12:37:23, date: 2022-12-07
[    0.223444] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.224139] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
[    0.224553] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.225000] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.225475] audit: initializing netlink subsys (disabled)
[    0.225819] audit: type=2000 audit(1670416643.794:1): state=initialized audit_enabled=0 res=1
[    0.225819] thermal_sys: Registered thermal governor 'fair_share'
[    0.225819] thermal_sys: Registered thermal governor 'bang_bang'
[    0.225819] thermal_sys: Registered thermal governor 'step_wise'
[    0.225819] thermal_sys: Registered thermal governor 'user_space'
[    0.227188] cpuidle: using governor ladder
[    0.227778] cpuidle: using governor menu
[    0.228292] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.228830] PCI: Using configuration type 1 for base access
[    0.236670] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.443277] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.443676] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.444061] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.444452] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.445458] ACPI: Added _OSI(Module Device)
[    0.445709] ACPI: Added _OSI(Processor Device)
[    0.445969] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.446244] ACPI: Added _OSI(Processor Aggregator Device)
[    0.450542] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.453034] ACPI: Interpreter enabled
[    0.453311] ACPI: PM: (supports S0 S3 S4 S5)
[    0.453562] ACPI: Using IOAPIC for interrupt routing
[    0.453871] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.454394] PCI: Using E820 reservations for host bridge windows
[    0.455191] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.465489] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.465866] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.466338] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    0.466926] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.468467] acpiphp: Slot [3] registered
[    0.468741] acpiphp: Slot [4] registered
[    0.469014] acpiphp: Slot [5] registered
[    0.469295] acpiphp: Slot [6] registered
[    0.469566] acpiphp: Slot [7] registered
[    0.469837] acpiphp: Slot [8] registered
[    0.470109] acpiphp: Slot [9] registered
[    0.470381] acpiphp: Slot [10] registered
[    0.470657] acpiphp: Slot [11] registered
[    0.470939] acpiphp: Slot [12] registered
[    0.471215] acpiphp: Slot [13] registered
[    0.471494] acpiphp: Slot [14] registered
[    0.471770] acpiphp: Slot [15] registered
[    0.472046] acpiphp: Slot [16] registered
[    0.472321] acpiphp: Slot [17] registered
[    0.472597] acpiphp: Slot [18] registered
[    0.472878] acpiphp: Slot [19] registered
[    0.473155] acpiphp: Slot [20] registered
[    0.473430] acpiphp: Slot [21] registered
[    0.473706] acpiphp: Slot [22] registered
[    0.473982] acpiphp: Slot [23] registered
[    0.474262] acpiphp: Slot [24] registered
[    0.474541] acpiphp: Slot [25] registered
[    0.474819] acpiphp: Slot [26] registered
[    0.475095] acpiphp: Slot [27] registered
[    0.475218] acpiphp: Slot [28] registered
[    0.475496] acpiphp: Slot [29] registered
[    0.475771] acpiphp: Slot [30] registered
[    0.476049] acpiphp: Slot [31] registered
[    0.476295] PCI host bridge to bus 0000:00
[    0.476535] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.476932] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.477328] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.477764] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff window]
[    0.478214] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.478660] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.479028] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.481062] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.481838] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.483461] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    0.484378] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.484794] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.485175] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.485593] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.486125] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.486699] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.487127] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.487345] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.488582] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.490240] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.492879] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.493331] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.495659] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.496497] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.497311] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.500259] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.508263] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    0.508859] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.509449] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.510035] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.510504] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    0.511430] iommu: Default domain type: Translated 
[    0.511720] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.512470] SCSI subsystem initialized
[    0.512747] libata version 3.00 loaded.
[    0.512802] ACPI: bus type USB registered
[    0.513073] usbcore: registered new interface driver usbfs
[    0.513407] usbcore: registered new interface driver hub
[    0.513729] usbcore: registered new device driver usb
[    0.514071] pps_core: LinuxPPS API ver. 1 registered
[    0.514358] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.514885] PTP clock support registered
[    0.515180] EDAC MC: Ver: 3.0.0
[    0.515457] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    0.515920] NetLabel: Initializing
[    0.516123] NetLabel:  domain hash size = 128
[    0.516376] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.516726] NetLabel:  unlabeled traffic allowed by default
[    0.551225] PCI: Using ACPI for IRQ routing
[    0.551451] PCI: pci_cache_line_size set to 64 bytes
[    0.551509] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.551515] e820: reserve RAM buffer [mem 0x7ffe0000-0x7fffffff]
[    0.551576] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.551915] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.552250] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.552742] vgaarb: loaded
[    0.553157] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.553454] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    2.592362] clocksource: Switched to clocksource kvm-clock
[    2.592882] VFS: Disk quotas dquot_6.6.0
[    2.593146] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.593647] pnp: PnP ACPI init
[    2.594058] pnp 00:02: [dma 2]
[    2.594954] pnp: PnP ACPI: found 6 devices
[    2.601280] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    2.602076] NET: Registered PF_INET protocol family
[    2.602450] IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    2.603956] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    2.604465] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    2.604925] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    2.605683] TCP bind hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    2.606202] TCP: Hash tables configured (established 16384 bind 16384)
[    2.606618] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    2.607025] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    2.607527] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    2.615252] RPC: Registered named UNIX socket transport module.
[    2.615613] RPC: Registered udp transport module.
[    2.615892] RPC: Registered tcp transport module.
[    2.616172] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.616564] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.616935] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.617305] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    2.617715] pci_bus 0000:00: resource 7 [mem 0x80000000-0xfebfffff window]
[    2.618128] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    2.618692] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    2.619043] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    2.619491] PCI: CLS 0 bytes, default 64
[    2.619741] ACPI: bus type thunderbolt registered
[    2.620268] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x363e8c91135, max_idle_ns: 881590568389 ns
[    2.665041] Initialise system trusted keyrings
[    2.665331] Key type blacklist registered
[    2.665718] workingset: timestamp_bits=36 max_order=19 bucket_order=0
[    2.670128] zbud: loaded
[    2.671100] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.672175] NFS: Registering the id_resolver key type
[    2.672486] Key type id_resolver registered
[    2.672730] Key type id_legacy registered
[    2.673008] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    2.673396] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    2.673921] fuse: init (API version 7.37)
[    2.674337] SGI XFS with ACLs, security attributes, realtime, quota, no debug enabled
[    2.675539] 9p: Installing v9fs 9p2000 file system support
[    2.681388] Key type asymmetric registered
[    2.681620] Asymmetric key parser 'x509' registered
[    2.682400] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    2.682759] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    2.683250] io scheduler mq-deadline registered
[    2.683567] io scheduler bfq registered
[    2.684222] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.684740] IPMI message handler: version 39.2
[    2.685009] ipmi device interface
[    2.686066] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    2.686600] ACPI: button: Power Button [PWRF]
[    2.687330] ERST DBG: ERST support is disabled.
[    2.687883] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.688327] serial 00:04: GPIO lookup for consumer rs485-term
[    2.688335] serial 00:04: using ACPI for GPIO lookup
[    2.688343] acpi PNP0501:00: GPIO: looking up rs485-term-gpios
[    2.688352] acpi PNP0501:00: GPIO: looking up rs485-term-gpio
[    2.688360] serial 00:04: using lookup tables for GPIO lookup
[    2.688367] serial 00:04: No GPIO consumer rs485-term found
[    2.688600] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.692922] Linux agpgart interface v0.103
[    2.693444] ACPI: bus type drm_connector registered
[    2.700367] brd: module loaded
[    2.704074] loop: module loaded
[    2.705111] ata_piix 0000:00:01.1: version 2.13
[    2.705948] scsi host0: ata_piix
[    2.706364] scsi host1: ata_piix
[    2.706633] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[    2.707027] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[    2.707728] mdio_bus fixed-0: GPIO lookup for consumer reset
[    2.707736] mdio_bus fixed-0: using lookup tables for GPIO lookup
[    2.707743] mdio_bus fixed-0: No GPIO consumer reset found
[    2.707928] tun: Universal TUN/TAP device driver, 1.6
[    2.708329] e100: Intel(R) PRO/100 Network Driver
[    2.708603] e100: Copyright(c) 1999-2006 Intel Corporation
[    2.708948] e1000: Intel(R) PRO/1000 Network Driver
[    2.709232] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.784978] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[    2.867364] ata2: found unknown device (class 0)
[    2.867856] ata1: found unknown device (class 0)
[    2.868628] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    2.869124] ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
[    2.869471] ata1.00: 16777216 sectors, multi 16: LBA48 
[    2.870489] scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
[    2.871373] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.59 GB/8.00 GiB)
[    2.871948] sd 0:0:0:0: [sda] Write Protect is off
[    2.872236] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.872262] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.872820] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.873391] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    2.873824] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    2.888139] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.903702] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    3.101281] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    3.101658] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    3.102087] e1000e: Intel(R) PRO/1000 Network Driver
[    3.102375] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.102756] igb: Intel(R) Gigabit Ethernet Network Driver
[    3.103069] igb: Copyright (c) 2007-2014 Intel Corporation.
[    3.103457] PPP generic driver version 2.4.2
[    3.104012] VFIO - User Level meta-driver version: 0.3
[    3.104552] usbcore: registered new interface driver uas
[    3.104882] usbcore: registered new interface driver usb-storage
[    3.105301] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    3.106255] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.106552] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.107040] mousedev: PS/2 mouse device common for all mice
[    3.107649] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    3.108308] rtc_cmos 00:05: RTC can wake from S4
[    3.109193] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input4
[    3.109768] rtc_cmos 00:05: registered as rtc0
[    3.110060] rtc_cmos 00:05: setting system clock to 2022-12-07T12:37:26 UTC (1670416646)
[    3.110530] rtc_cmos 00:05: GPIO lookup for consumer wp
[    3.110537] rtc_cmos 00:05: using ACPI for GPIO lookup
[    3.110546] acpi PNP0B00:00: GPIO: looking up wp-gpios
[    3.110554] acpi PNP0B00:00: GPIO: looking up wp-gpio
[    3.110562] rtc_cmos 00:05: using lookup tables for GPIO lookup
[    3.110569] rtc_cmos 00:05: No GPIO consumer wp found
[    3.110601] rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
[    3.111079] i2c_dev: i2c /dev entries driver
[    3.111357] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    3.112099] device-mapper: uevent: version 1.0.3
[    3.112533] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[    3.113020] intel_pstate: CPU model not supported
[    3.113349] sdhci: Secure Digital Host Controller Interface driver
[    3.113705] sdhci: Copyright(c) Pierre Ossman
[    3.114015] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.114432] ledtrig-cpu: registered to indicate activity on CPUs
[    3.114855] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[    3.115571] drop_monitor: Initializing network drop monitor service
[    3.116280] NET: Registered PF_INET6 protocol family
[    3.117227] Segment Routing with IPv6
[    3.117468] In-situ OAM (IOAM) with IPv6
[    3.117719] NET: Registered PF_PACKET protocol family
[    3.118190] 9pnet: Installing 9P2000 support
[    3.118501] Key type dns_resolver registered
[    3.119340] IPI shorthand broadcast: enabled
[    3.119685] sched_clock: Marking stable (3112126306, 7051050)->(3148765691, -29588335)
[    3.120459] registered taskstats version 1
[    3.120731] Loading compiled-in X.509 certificates
[    3.121137] zswap: loaded using pool lzo/zbud
[    3.121584] Key type .fscrypt registered
[    3.121815] Key type fscrypt-provisioning registered
[    3.122782] Key type encrypted registered
[    3.123030] ima: No TPM chip found, activating TPM-bypass!
[    3.123365] ima: Allocated hash algorithm: sha1
[    3.123641] ima: No architecture policies found
[    3.123925] evm: Initialising EVM extended attributes:
[    3.124221] evm: security.selinux
[    3.124464] evm: security.SMACK64
[    3.124663] evm: security.SMACK64EXEC
[    3.124879] evm: security.SMACK64TRANSMUTE
[    3.125120] evm: security.SMACK64MMAP
[    3.125335] evm: security.apparmor
[    3.125536] evm: security.ima
[    3.125712] evm: security.capability
[    3.125923] evm: HMAC attrs: 0x1
[    3.128014] PM:   Magic number: 2:416:632
[    3.128491] RAS: Correctable Errors collector initialized.
[    3.129004] md: Waiting for all devices to be available before autodetect
[    3.129275] md: If you don't use raid, use raid=noautodetect
[    3.129504] md: Autodetecting RAID arrays.
[    3.129671] md: autorun ...
[    3.129788] md: ... autorun DONE.
[    3.131948] EXT4-fs (sda): INFO: recovery required on readonly filesystem
[    3.132316] EXT4-fs (sda): write access will be enabled during recovery
[    3.144511] EXT4-fs (sda): recovery complete
[    3.146158] EXT4-fs (sda): mounted filesystem with ordered data mode. Quota mode: none.
[    3.146488] VFS: Mounted root (ext4 filesystem) readonly on device 8:0.
[    3.146939] devtmpfs: mounted
[    3.151414] Freeing unused decrypted memory: 2036K
[    3.153066] Freeing unused kernel image (initmem) memory: 3636K
[    3.167367] Write protecting the kernel read-only data: 40960k
[    3.169152] Freeing unused kernel image (text/rodata gap) memory: 2028K
[    3.169624] Freeing unused kernel image (rodata/data gap) memory: 612K
[    3.250124] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.250367] Run /sbin/init as init process
[    3.250518]   with arguments:
[    3.250522]     /sbin/init
[    3.250526]   with environment:
[    3.250529]     HOME=/
[    3.250533]     TERM=linux
[    3.302492] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
[    3.314889] systemd[1]: systemd 239 (239-49.el8) running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +G)
[    3.315859] systemd[1]: Detected virtualization kvm.
[    3.316064] systemd[1]: Detected architecture x86-64.
[    3.371681] systemd[1]: Set hostname to <test>.
[    4.371182] random: crng init done
[    4.435394] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    4.436422] systemd[1]: Created slice User and Session Slice.
[    4.437308] systemd[1]: Created slice system-sshd\x2dkeygen.slice.
[    4.437865] systemd[1]: Reached target Slices.
[    4.438399] systemd[1]: Listening on Journal Socket.
[    4.438935] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.591241] EXT4-fs (sda): re-mounted. Quota mode: none.
[    5.627240] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[    5.627913] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    5.741036] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    5.741562] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[   66.412073] loop0: detected capacity change from 0 to 1024
[   66.412383] =======================================================
               WARNING: The mand mount option has been deprecated and
                        and is ignored by this kernel. Remove the mand
                        option from the mount to silence this warning.
               =======================================================
[   66.413486] EXT4-fs: Ignoring removed bh option
[   66.413662] EXT4-fs: Ignoring removed i_version option
[   66.413908] EXT4-fs: Journaled quota options ignored when QUOTA feature is enabled
[   66.414568] EXT4-fs (loop0): mounted filesystem without journal. Quota mode: writeback.

--zz+P7kz/bu7wp1J1--
