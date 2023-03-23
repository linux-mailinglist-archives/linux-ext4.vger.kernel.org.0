Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE296C6274
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 09:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjCWIzs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjCWIza (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 04:55:30 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C69236FF0;
        Thu, 23 Mar 2023 01:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKWXqRw6W47flbw/r6wstug0vU0gyPfs06N5YUmbRoJ7xWzVkdVUsdx6BtS+UuLBkGOWaogwDOQZOEqiChuEkYLpX+ivRC3OiFUCbf+IazDrSnIm9RZ0982wNAD9494Z9ZQ5FS/38fEKtQ8jgklz68mKSmscP2WF3xQuIjloCM886Pudg3cHJ9i1E0Ql6F16XJNIYReHlWxjuQHDPBm48b/XwTjTLUzTu1CiIr1Ri+IYt0zhJeCXln4/lbVVFrMSP96Q1Wzf/g+2S/VzS6N+kjXNw9916U1t6PSZ0Gt63OJc6fd0wOZ6KNiZ+OwYuNkg2HkKdyz4XtKnFGjuoKlINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/4soSRX8IL2wA/3cgB3vcDD4G4aWkUf9r7J25EwkHU=;
 b=loM3E442oZcU6/lMnQS1rwWf6GzW+IWkMjknd9jZUWRa9VDXq9KQjJDr2i0qj5LvBgAubeMK4I5Xb18y1bC6kVhbnihEt1wLoESldleBpech8ZoBDlAgzpQwhCYhcTlDE77ThN/U5NFVGXpyawgN18Pl8xuCxeLTKHG5FQzJ1qqh/MdkS+LXPclTibH3lZz6fKyzvNaKeccqvuayH+0qYeOr4IBnFWA6rmcUWPibEdna76gF3gHBFikY0+yyq0zFijtf0T1XzwXWCLAGLh7b4LBtN7tRG+KROMAgjBwh+9bbc4OetkDGaNnYC2b1U0H1XQp7kVhzt9fCMTsxmvXutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/4soSRX8IL2wA/3cgB3vcDD4G4aWkUf9r7J25EwkHU=;
 b=gKfU+l6iYNf69n1zTvxv8mLO60chPF92dg4zGDEhh57FYwHrZ9C5n8EckJgnaOKhWDz/cQNcKaWJFjIUZ0HaL4tpdOOyZQVaAUOOkKa8K3mbbIAT/qc8N0TV18ebSMyR/F5D/A4YpOVBoykYi1dx1maHeFfOCWAVwbCcSm+k0u5tov2wYS5puMvU8aq/t5g2CFa0ag3iQlANXzbIQlEVPytF8WlpL1eH19Ru2+ox0jHVezlphgV0DkwxuwVTzVOOdejVj3y2Aut612muVWAe2+yljkaK7KvxjaBaWFMG0PLkH2gio1+DP/EnVeSyy8ZErN1yC2W74Lj18erpZ8E0Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:54:33 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%7]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 08:54:33 +0000
Message-ID: <20efa539-fca4-f40c-ce00-78d427d35fca@suse.com>
Date:   Thu, 23 Mar 2023 16:54:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: A new special orphan inode 12 in ext4 only?
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <4034e634-59d3-e9a5-a1c5-1f275d8e2832@gmx.com>
 <6cde43c8-3300-9269-7a8a-8ff6e8b1e287@gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <6cde43c8-3300-9269-7a8a-8ff6e8b1e287@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0072.namprd08.prod.outlook.com
 (2603:10b6:a03:117::49) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b188f90-2fd1-43ca-e7cb-08db2b7c38a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05L0G4KiIhbQ0MiaPeocQEmLfYM1/Yj9Lm+oR1DXEYEvzTnbK09fiT3ATKKjmZ3MOurLHFPjKv3LwRclpVwaNg+6Mv/ECsatJEWJqIDXzKW5qUUtsDRJIwIluUKrJOIsvU2GjN4QPpJWxL/3owCZkFPOVLEal69GQL+RHGU3GKCUvB/cMvB7vugde5A08uGRMnpUPnvLBkCGK/GBXXoIOpYweJwRhLOH3qFAI6Muz+MxUcm3R82Js6M/3qF3iJVyACnY7YE0wl1ZTofpNCvru/1uUd21KHVAhGW9IdDPKnphfoaLVL6sDrPtac31YIRoG5Z6z86sx06QC9l9b4woIhCxMOBqhFpksbMy3EJdg3EhaXeSKBYiE1biRsMSwsOQ+Yxj8koWlTIOjW3cHGMmyIvtMIfuERKfplqDXXqq7vFRCVgWdgifInN5Ou9yUv4DnEbLd/+X11bbJhxEfy9ZPLmT1lxBMYeeykzTUiosuPrpAPtgutx5zpz/4UsXgcnTBtI0Psu92T2b4BjByyGVGE2SN5wjCGmM79grdMvwoa9WvcCerQWzD7x+pmIfSTan2btMeAxW05cvksBGsuTOqOFC0X8sZx4d3dYLb+sbSJqkLFmzvCafwoHZ8WFw7N2pXb5xPA612isSQ1HsMMAAVDMeVUiW81+cp3psxRrq9TgI4bO1Gg+TGjYwSh9C6nTilD0xRAJ+7jQe1eXrIPEJCQBxF2lsu3S5wH8iQBDp/lM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199018)(6512007)(6506007)(38100700002)(6666004)(53546011)(2616005)(36756003)(83380400001)(186003)(5660300002)(8936002)(31696002)(86362001)(478600001)(31686004)(110136005)(41300700001)(316002)(6486002)(2906002)(66476007)(66556008)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEs1NE9uTGwzR2JtVFBJNFo3V3ZOb3ZjaXA0OFhCaEtkUkgyT3YwcnlzbUhn?=
 =?utf-8?B?SWdxWitkcjRXVExUUDNrZ0J1ZTVsR0oyQ0ZsdnQ1UDMzUkZjRzhXdnRyVU83?=
 =?utf-8?B?WWFhYXhWSjNmaVNIM0VSUVlGdVlLbUE1WksvZFloZ2tBRjRQWlk3RVkvRDIz?=
 =?utf-8?B?dk5iZG05TWZ6ZkVBWXVtQ0R2Z2JTUWc1d3l5MUlqQjNQOG9uVGJxYXgrbEpU?=
 =?utf-8?B?ZTFIVm1wZlVVV3d3VGxsZUNCa3dWZzVLTzVSWW1ranV2RFRyRDNEQXhrQWlp?=
 =?utf-8?B?ZUxBVTIvR1pDUFZMNTk5UWQ1Njl4WXA0cEdpZzJSL0k4ZUNjNXowMzVnTGZ1?=
 =?utf-8?B?ZE0yaUErbCsyeFF3YjRqSnFIMXRPZGJOQWhJUU9EbkJla1ZlaXpabVRwd3dM?=
 =?utf-8?B?cVphVEtJTzhLUlNxMUtOalZUbk1SRHBqNmd3UTVJRVdJUCt2c1krbHlTUDl0?=
 =?utf-8?B?d0dmb3V5ZGhEWWF2SWlqRm1WTTZlV05IV3NtRzdYdmVuVjkwWVMyZFJkaWdk?=
 =?utf-8?B?MWFHRFo4WWhCRk5lNGEwcmNiTWh2MzV0R0ZWWXZhRThPVENPSy92Um1ZRzcw?=
 =?utf-8?B?T3pkLyttK0hadEhldTIyTEN2TTV4N2EwVVBKc3pwalp6VkRQWVVwTEZJK1oz?=
 =?utf-8?B?MlpweWlLdlIzSk9nZ0d6V2tGNDhZVG1jYUtyQ2NmOFlqeVRIRWY2Z0oxa3FI?=
 =?utf-8?B?azlqcTVTTDVLTC9QSFFpTEw4bkNmWWVGR2tQR0RQY1hIL0FHMFYrQXkwRUh3?=
 =?utf-8?B?Z3pkMDUvQ3NWZCtvbFpBVXhoRStuR3pWUkZENXkzaWpaVVVLb2F2S3dFdE13?=
 =?utf-8?B?QzVtZmRVekRzdENWUURMWHN5YkdYdjM4eDdveWpOMitDaktJblYzQUxuUnYv?=
 =?utf-8?B?L3pLSE0vRkVzcFJNdlZnZTUwQk85YTBnWDJrSFdoU0RINElicnliWmtSVTZO?=
 =?utf-8?B?OW14elBSNUtsRGNDemdaYVhUMzlsblZ3V2wyOXFRaTJJcWpKSGNnQlJhME50?=
 =?utf-8?B?dlBXSUZhNUl0U1MxaVlWN3FGNUQvTHR0MUh1bmVrRDZpNFloaVU3RWhNbStm?=
 =?utf-8?B?UWtTTXlTdjZwbEpKUTZIQ25wRktWbVViNjZWemNjZmVWOHBPY21ubTBEUFdO?=
 =?utf-8?B?M3J5a2tuY3poVXM3enFBNWxqRFB2dmIraVNNYldhUTJmeW9jUWdSL1BUdFNi?=
 =?utf-8?B?SnIrUXNacGNoc3pHVWpSZEcvU3FTYi9QdUFyUktlUjdoRzdaNng4SWRvMWpp?=
 =?utf-8?B?dllKZkk0L2VTN2JHR1JLeEp3RVVTMjlMMG8wSVdxL3REaXg1a3JBcGZTdEk4?=
 =?utf-8?B?REZ1aGcvZkpBNzU4OHZldEZkYnlwTDQ5dU95alVjZzEydDI4RnF6eTllRnUx?=
 =?utf-8?B?ZDZpN3FqT0JvVnRVd1FoN1RyWHlaR0d4NnBXandPU01EZWJ2cHd2a2tyd3BW?=
 =?utf-8?B?ODJVSml6b3FzbXhXWkFOaU4wUXNnd2pPQWhKNVU1TERaUGxXSnNCNCt0YlIy?=
 =?utf-8?B?UStWWW1CdlE1RDErZjkrNUd4eFdhWmdUOWhvTlIxaGE0YWk3N05WSkJQL3RZ?=
 =?utf-8?B?ODVERVBXbEJ2REFwTm9DTUtPb3NOd2Z5REQ5WDVFenhJTVZVamZRZkE1dlA3?=
 =?utf-8?B?Zjltbzg2dEVsVVcvREdpdmZHbUhESXFlTlc3ei9GeTc0L2VrU0lmeTlockpj?=
 =?utf-8?B?S1lsNjhlYWZYYy9jSHhEVkNnV0ZRWlI0dEVJSUUvbXJkSEVpdFhLalZkaGxy?=
 =?utf-8?B?dkR0RVdhOXhJSTN1U2x0MmZJN1ZBdHRGUW1kakF4OGg1K3QwdDFHekRaSkxi?=
 =?utf-8?B?OURmR3ZaNlFaQUVhOWRYNXNhZ21JV0pEcUdUM1F0eGpBMHVjSTlkdEdMQnNm?=
 =?utf-8?B?N2cwUnRSRzc0ZUVWWDFXUVJ2VFVpakpISElNd0VQa1FydVp2UDF1TllNR2Q4?=
 =?utf-8?B?TnpySXROTVQvMzFNaEY0Q1lGQ2dTcWpaZmRNeW50Y3FYTEhjbUUxS3IxQkdK?=
 =?utf-8?B?U1JvMW1xbkdQQXR5TDJneXFYNkhvc1BqdG80V0s3OGJNZS9TU3dDaTlMTlV4?=
 =?utf-8?B?cUlJRnRvem9xeEJnSjhwbTZ4Ukd6QTVMdUJvMjVoTlZ1MHBXWTRldXkrbUx2?=
 =?utf-8?B?RXpkZjhnMVpyTTVIQzRVY2s3c0xoTVdidDhUbyt5Yjg4ZUw3cXlTRnlZVHlv?=
 =?utf-8?Q?lF7UpCUL5Xvg0G1Rxzd6EQA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b188f90-2fd1-43ca-e7cb-08db2b7c38a9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:54:33.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /F2AnkRp5r1PwZN6yBLnexRxjIregj53ehNAwN2rn5cE92QFlzAft9962ZL6J/XN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2023/3/23 01:27, Andrei Borzenkov wrote:
> On 22.03.2023 12:09, Qu Wenruo wrote:
>> Hi,
>>
>> Recently I observed newer mkfs.ext4 seems to create a new orphan inode
>> 12, with some file extents.
>>
>> Which seems to have no direct parent directory, thus tools like
>> btrfs-convert would also follow the ext4 inodes by creating an orphan
>> inode too.
>>
>> On the other hand, if I go mkfs.ext3, the mysterious inode seems to be 
>> gone.
>>
>> Is this inode 12 a known special inode?
> 
> This is orphan file. It is normal file; mke2fs creates first normal 
> inode for lost+found (11) and if enabled creates orphan file next which 
> gets next inode number (12). Inode number is recorded in superblock as 
> s_orphan_file_num.
> 
> /*27c*/ __le16  s_encoding;             /* Filename charset encoding */
>          __le16  s_encoding_flags;       /* Filename charset encoding 
> flags */
>          __le32  s_orphan_file_inum;     /* Inode for tracking orphan 
> inodes */

Thanks for the info.

Now btrfs-convert can skip that orphan file if the COMPAT_ORPHAN_FILE 
feature is enabled.

Thanks,
Qu
> 
> 
>> If so, how can we avoid such special inode?
>> (s_special_ino is still 11, thus checking against that value doesn't
>> seem to help).
>>
>>
>> Some details of btrfs-convert:
>>
>> It goes with ext2fs_open_inode_scan() to iterate all inodes of an ext4.
>>
>> And if we hit an directory inode, we iterate the directory by using
>> ext2fs_dir_iterate2() to insert the dir entries between parent and child
>> inodes.
>>
>> So if we hit an inode without any parent dir, an equivalent btrfs inode
>> would still be created, but btrfs-check would complain about such orphan
>> inode.
>>
>> Thanks,
>> Qu
> 
