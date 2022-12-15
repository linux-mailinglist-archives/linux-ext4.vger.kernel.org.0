Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562DB64D513
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Dec 2022 02:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLOBsK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 20:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOBsI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 20:48:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB632A26D;
        Wed, 14 Dec 2022 17:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671068885; x=1702604885;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XSRm0cDhackcvSN5MmmqdRuVHVv5BNccziApAS6irMc=;
  b=OdH0Gkcl1vfHMFJjrmSXJu5GGKP1UlT7TvMUHmRsIzUZT+JWcGLN0kfV
   B4UHeIgRvRJAuSdcbZYKWZ3hqAjG7cNjm5wbTosgYBSWPvLezXGjJ36MH
   tqnN48NtHE85JUtzOpVA65Z4GgikU/i5yGGB3dIlwMPLi2QuuPo/3Ruys
   bfcexXVGO+Cj9/b1rpf1svtiKbU4jdi9qjQ21B2WyInEY4bMwfnSmmbUe
   W73II7XPWqSRonrOnqAOY2+OIZj/fWQzgpN+KjqJKZfd6LvMcKdNRfmSj
   Pd7in52A9DxDsIa8qqwxsS1QRgL1QfRxLU6RwuhosEBLxNZBtesZMUcN+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="382863901"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="382863901"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:48:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="894541648"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="894541648"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 14 Dec 2022 17:48:05 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 17:48:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 14 Dec 2022 17:48:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 14 Dec 2022 17:48:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlIzV0AXMD/J0Ft11XdrXau+5PP3iscirqlPUIpUiLRcS83GV8KTYGHbFzXfZp2Vzg6YCSVCWWNn7DHK3atg2Z40M8gis9hYqHXQYPdS9QE2jXgjLpz2s6QsEds31JCxNMFzLMhIO8clQ2gRmO1l3HipIZXeuMcoDSfgp+jhkOmpv16vwMXBI3/TWPjSv1jvHQ5fMfXzLQEwFe/eQytnRV/y86DkeoOJsP1aKiBAimfgkY4BzWuPP/9g29SgcrAN681H++Le6n5VYWp/SlOsJTkJ/SMMozGcIqQkCP0b4MyId61KuBJn1w4hVcr6UHdzOeZIf6GknXSaZmUPY5SINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBnV6Jj7bBkPloigDaV3pFc9GMdcObECevpeM+q0h3s=;
 b=VjfwrhIAOVctNwxY/oIHFpKQp9OvnuFK38XupV9f9pJW+m4LZIKn+r/kjbOR3msgL1dZtqZYmHgy2ov9cvbx7Ll42mW55kLq52u1GgOnJaemsBQtaqe9q1MF3eco5W4k8pgUx3WLgkhjSoLVSa2b7BoXNG2nfIskNx4KZtF7lzgegQwatCygff8O1K9YLar2z28RK6mJx3e+Q49qdidgMPcjbAaIAAkOf5vxS/HGc69Emn4ozYz0aBRaRO6ntPibc1OpIbQovV0jouXc4UHd5l8/oMH1MyVsYI+R1FR7xEM1frjTUnxC1AjQ7XUeQuOFC/iC/FpjI3CQPQjd7h5TRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW4PR11MB7104.namprd11.prod.outlook.com (2603:10b6:303:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 01:48:02 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::226c:31ef:73cb:3a28%4]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 01:48:02 +0000
Date:   Thu, 15 Dec 2022 09:48:41 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <yebin10@huawei.com>, <jack@suse.cz>,
        <linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <heng.su@intel.com>
Subject: Re: [Syzkaller & bisect] There is "possible deadlock in ext4_bmap"
 issue in v6.1 kernel
Message-ID: <Y5p8+TnNzFwrIrCW@xpf.sh.intel.com>
References: <Y5lO7xPYh/c6Qyq/@xpf.sh.intel.com>
 <Y5npZPh6HEUOmtut@mit.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5npZPh6HEUOmtut@mit.edu>
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW4PR11MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdb8c38-9d30-4750-2596-08dade3e66aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSPJ0+jWNIIm2b88iZX17qnBQQgQ7RaSqo2ZIOfLh1Qa3iDNc0c90bBsqA1sqn6n6MS+lW5SUdQlaIgjnbxc3kumT9G1JM1nKV/L/EMCjteX8tced+qdVYFlXJ0esFklCufkRtlYycab68yIQO6o56jVYowH2SXxuLcmiMdd1Q3Q8kWyLUle/TW7fAIET+pptlHXuPS9g6zPFsrfqvd1eiQlINaHk+c0b9KBrzMTrwh3CVfqJ5mFBrUV50NBuUUzKtoNDOGVN+kU14RIjQgZBg0OuabRvwJ+NfyZNWMrrwLM/ObhruIJfGejjKev0UymoMbuUbaLXzqHiNT8/fdRKcarTuRJEFtJb7qkvVqMAkbxkwz636Edu+NVjywvcrQr+2RAH7cC3lp7ATsn18HkyqUry5P8OcD8cLJagJEvGxkR4T1qr95caPMse3z3kwRXqnvlEwkL9TgrGr/2xB6fodq1oeiFX+3ojs5xFZ2qEd3sEBj3ei6LQsleM3WzAOSnMy3gAkF6xDdhn/5Ogmn35ReH20DX4qC9pxc8pijW/Zb0WPJq11WnZwi4SQBaVDAh38jlkD9cRTzEGtXCxLDUag1Uwf/OcDkBCSL+0CDlhbMNGYMX5eYplu5D5xO7eQL7zojOkZoF2oaqd+uw9T+drB2/t3Mic2slEukseBfhL+2vdxQm7EDAx6/g31FuC7tLknv2+7s2FDEFVW4j1WS2bQT2yvtsiDu5fxRnH4XEM0BzfkT41ihvOj3X0C2CWvEp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(86362001)(6506007)(966005)(6916009)(316002)(4744005)(6486002)(107886003)(6512007)(186003)(53546011)(26005)(478600001)(2906002)(41300700001)(8936002)(44832011)(4001150100001)(5660300002)(4326008)(66476007)(82960400001)(8676002)(66556008)(66946007)(6666004)(38100700002)(99710200001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qCKR3H9XBjhlCJ/yLkbri2bcOfWLtqVHqM7VDpnolc2zYBlz7oMqvZR2XVzv?=
 =?us-ascii?Q?CJmKTZXgYgVrfEwoWCcgj6si7NULDiaaP/P7SM0rqtSssidyqA38ou7W+/6B?=
 =?us-ascii?Q?ZHykTvHr2bBqv9oMalU7jFttWzQfq3DWMqETGXOS+MAGOMarHEzwnsM7A/EO?=
 =?us-ascii?Q?w9IxqAkq7AmdSdd/D1wYhAf4zz/cL/aQK9v2+8B3cB3+sdh/RZ/sHqLy+3R7?=
 =?us-ascii?Q?vy7tAmg5zy9hRDe84DeasTso6Po2t6nxbWpD1Aliwqj16j4hzPcA0IsJEZDT?=
 =?us-ascii?Q?AZqHcqlevNb1L+wBvQjiwG4FXwlm8jgXJCDdpsXUqYu7DDJMPQF+RHLEP6jT?=
 =?us-ascii?Q?0DcJLs0ukjfCgENo0C+tCQHg/jFUfUd/M2SNl4qIr3hL1zibccPnZlcRS6CD?=
 =?us-ascii?Q?KOi2/vrLhBluv9D+8bxhDfXZgERE3G20sml8PWLrcR8SqpK5NtBnKTfjNaha?=
 =?us-ascii?Q?cxTzx8EWfPpoR3U269gdRVxAogwANxWFqZdNo6YdYKjhQaEa622032wFrRn3?=
 =?us-ascii?Q?vKm6m5bXBsavCDw0/h0Heo7HevSB+88sN3VZrjNu5bOtTr+HaupXAdk1jUBk?=
 =?us-ascii?Q?bUwf2eDnyZPc+o5DLhdNc3J/67eCM3yAiueN3M7FfqerA34ylEjxWhv0fXu3?=
 =?us-ascii?Q?0shDG4AOnH0g/yPwPck+a+gdbuZFMk10FAK4KgjWOsMgcduAP+Co2yXC1wCi?=
 =?us-ascii?Q?PvkcSssu4wDg9eeUvhOZ/06EqdsLMOxr6G55JJ6TfQE8UUciY08SGABUG4y8?=
 =?us-ascii?Q?95g5VsItPkNkigDF5+qtloZrAmFToeqWDE8pKl8784ljFKCpYZ+TXFUVOLnZ?=
 =?us-ascii?Q?Bs1LpX7CCfAxJzhngAMi914NKFG2HLvS8x6PlLZGNFyGzl3Gnm14Drv/NUlh?=
 =?us-ascii?Q?UjGBUFacOAIiMMogyProgBE5H7UFfEfOIlPytetN5HOsfY27aLiG/jvRZGjO?=
 =?us-ascii?Q?fIFfg+JPAe4xGFuiSKUaTE7YpQyv9kUDIJKD3+nUycXjtsrbr5xpGVEYxlr3?=
 =?us-ascii?Q?5lQlRvCL3XJPYT7pK4QPPXlWXSCgIllU/sO5IVrj6Exlbgxo6bnRPhOtdbKN?=
 =?us-ascii?Q?H8MPDGG2jvGxRsYRV2tDqXGQp8+Ocy12VKSIhOeiHSvw4iNFCO1gAzA5VARN?=
 =?us-ascii?Q?syE8SqWtSk66E7Nbx/WAaqU3UQeMpCR4rYff4r7dw6+g2hus/KummYcYhAMa?=
 =?us-ascii?Q?TpmC88VllQ7g703wbq8C6cYBYoZo0CLUAjTRIPl+4/PJmQQHgCCXiT7LwG86?=
 =?us-ascii?Q?B+srIeKQsKVUY+PltvJnFo8gOUwh0BHoLVT/293amLBZlV6lpVnx7rwdUkSp?=
 =?us-ascii?Q?sjSpgB8bmClw1ZNOSl5vp78N0AyoKnkFFllRrAKrFEVxCC/E1ycgXhPVsVNi?=
 =?us-ascii?Q?8BJ3ieNKrqdm0SjK/6K16yaf9UeKU6m4DWyJ0TwMiCi0qrG0HMaOsQoSwaLt?=
 =?us-ascii?Q?zX3U6DGZFmFUAipnIGNGQ6em1WtOO61SkrnVDwKAY7LVmEq/MDQBcDyvxL+L?=
 =?us-ascii?Q?Bg+q2yGuorT456eW/ZEn0N+Vw7cNBZuxOHz4L9YVlMQ12QQ3/GSTgaWvs3Am?=
 =?us-ascii?Q?OCSUTHl2aYt6dcquJneXiFMqPgiSEVoQ9rrIl8fc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdb8c38-9d30-4750-2596-08dade3e66aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 01:48:02.2309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVBYEL75IALvvfPt3odkgWzYw65C5N7NjpKG6KD0bKeNp9WzFbiL9iIM2mxCpusZ2rFPd0FD0l+4r2rmIc2Ljw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On 2022-12-14 at 10:19:00 -0500, Theodore Ts'o wrote:
> On Wed, Dec 14, 2022 at 12:19:59PM +0800, Pengfei Xu wrote:
> > Hi Ye Bin and ext4 expert,
> 
> Please include the URL to the syzkaller dashboard where these things
> are reported.  The dashboard includes a lot of useful information
> which is not included in your report.
Ah, thanks for suggestion!
I will add the URL from syzkaller dashboard, the link for this issue
is as below?
https://syzkaller.appspot.com/bug?id=e4aaa78795e490421c79f76ec3679006c8ff4cf0

> 
> It's also better if you reply to the syzkaller report that was
> originally sent to LKML and/or the linux-ext4 list.
I will search the LKML and related sub module email list for this issue at
first next.

Thanks!
BR.


> 
> 						- Ted
