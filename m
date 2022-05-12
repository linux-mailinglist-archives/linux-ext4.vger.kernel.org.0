Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1E25257D3
	for <lists+linux-ext4@lfdr.de>; Fri, 13 May 2022 00:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357474AbiELWdz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 May 2022 18:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344848AbiELWdy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 May 2022 18:33:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0922C1B186E;
        Thu, 12 May 2022 15:33:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr1UbEiG8ZlVaYAjrONALb6chMw6UKXYf+j/bSsWrlloqcrZw0pswOKRwZ80izcnDbVaK9fcqkoE2OU8CKZOs946WDQ39yN7BKRUfQGWI6pA89ll6caaO7gXGBIrSu0aFXDne1lyKO8ZOTzwPcLqo7uX3xsXiSnPug9ke4q0YgXmEGY7XHic3+6CCUVJpImp3gfQx2TRZRHC8Lh+d+fbfqJbxj7zexoAqc5+DLS/FdPuswAHLgNsR0kDlxrQI9QG5dTqJgPq573hhCMkVZJZoBDaPzuQV9Jgu6GcH1JZQ8WXMl/hWPg7UzpFRFwznbTw6BEhjxrnuqrX1S9Q245nXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly0WyqM2zsPp20nVo1JCs4tyHCPpWsnBkLndqRTKk9w=;
 b=NduLqa/9nj/73WXBsyuHbh/eKijHnj5qP4p5ZfwyFZIKnY68B3zX/1QB+XltUA8ARnIjHbH7rJ08p2SWruP7V2C0IRwEPoIi3ecgJ5vSgGfMZrNYpjwQxaFH91cIZf5mOikv0wStQ5Xq48TixYrAz1Ehg21a7B5YsQiPXuSyqLnEfBnblddi/dcTSB9wyk7KyFy6PzFcWRQFaTUSahJe8g+dxxmXcL4za08cOHgYx6H5UIsylZJKBClxn9f5qg48489AuIWCRGWeYEQb2f2R+DA9cm9AjXfQ3OchJO8utQ7v5g2Ibv1mFPR575Y1fKnwh6xg1tMcTYq137qI8P7WzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly0WyqM2zsPp20nVo1JCs4tyHCPpWsnBkLndqRTKk9w=;
 b=di9iF2a/TfFtRl8LdLpuS7xmNL64RxC3YX0OYPzAxtzZC0+++mjcnx7WVf3PZzwFk5GctPSzbXbCcGUwbz7HijqhF6WP83U4g2cKjwjIhZT0vgjDjtIYFKw1co0sYAXk5aK81FtP73xEqHCg40hsve9Torek05jx42FXSbVv8Zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29)
 by DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 22:33:48 +0000
Received: from SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::2c05:6d91:e76a:6e24]) by SN6PR12MB2717.namprd12.prod.outlook.com
 ([fe80::2c05:6d91:e76a:6e24%4]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 22:33:48 +0000
Message-ID: <833a5eb1-f64c-0b1e-a318-051bde629ab2@amd.com>
Date:   Thu, 12 May 2022 17:33:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 13/15] mm: handling Non-LRU pages returned by
 vm_normal_pages
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     david@redhat.com, Felix.Kuehling@amd.com, linux-mm@kvack.org,
        rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hch@lst.de, jglisse@redhat.com,
        apopple@nvidia.com, willy@infradead.org, akpm@linux-foundation.org
References: <20220505213438.25064-1-alex.sierra@amd.com>
 <20220505213438.25064-14-alex.sierra@amd.com>
 <20220511185012.GM49344@nvidia.com>
From:   "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
In-Reply-To: <20220511185012.GM49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:610:60::11) To SN6PR12MB2717.namprd12.prod.outlook.com
 (2603:10b6:805:68::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2090c243-51ff-438c-333e-08da34677b78
X-MS-TrafficTypeDiagnostic: DM6PR12MB5534:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5534071307A033A7EBABC791FDCB9@DM6PR12MB5534.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkAgP2d6qJgODeyKNd5azmeXlFQGi8tqsGWoUYXGedTSu2xw7N+dChLe1RkMrjwW5uCfXJO4XVdRY/LBBOxgc/4ZdwQzFsH97N6x7hZAz3iK++ZyC+VZ+xrdx5ZZR2dxG1tT1hdNE866jB9FSFCGNq50sWjvHmzHCDjsIhkqm9kYILVY46BOHsOl8v0W66iuYHcrvvDgowXJgXArg+aWToZBt1PS40XCzqIi7YU9XGwxk5XuJIolYCewXkpF/eSrN/kMdsKpubaVcN3MtloJqex2smcNt26yBpOlTLpi5bORHH91Cj5u/OR+KHFaJjOxWxb6ZlvcsxRqArVFIzmjdQy6VS8qGjld3DjJoBQAXgPpi4Is/sVmxXlo9M7jiTIfyKBja03ZZLBFpXcykVZaJ4rDekJ+xu6byDGX/zsMxJsI13czuS8JvhnTp0Sn347NlhT2pJVxrY4V+wmmm6X4Bxqm+Sj1h0eRXDLd60McSclVE1A8EZjbIjsOfK2o3Xt4Va0hx2FTbQFOAK/XFHeyBe0GkEi6QARMLnn+E4w5nHSIPslAXwGiv4d6+gS8t+Nj9B36ttq3siub2udn3ZXHNZLAwSIRZh0JKS+0KP48z3juAf3bnzGTwA4th/QKBpMQ75HQuN/Ru1eS7/vBZ4HKHxBk2j7DZrRx3UF4QRF5A7zwCPYo9lsrXboLoC8+7Cz8JLEGKzG7nfhAO1bj+wk5UWP9H5z2T01QmKd2gzV1iN2uwd75cC1yMEzWFTokK19Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2717.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(31686004)(36756003)(8936002)(66556008)(66476007)(5660300002)(7416002)(6486002)(316002)(508600001)(2906002)(66946007)(6916009)(2616005)(186003)(6506007)(6512007)(53546011)(86362001)(6666004)(31696002)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE01b29wQkRIRG43UGRYTVZtd0owUk9pMVIwY0FDM05yckh5NkNua2g2TTcz?=
 =?utf-8?B?NG1RWFEvSGRDclIvZ0psWFpOTlAwdmxJb0VPUDl4dkFFQncyRVBtalBCcGRs?=
 =?utf-8?B?RHdGRnZ6TkZ3Q2F5RndiZUpRRXkyMnVvY2JkeU9aV3pvOWdDY2lBS2Q1UmlO?=
 =?utf-8?B?M2VQU1RZQVdYaW1hSW1BTlRqbTRvbHV5T2ZON1dIdlJUd05oTExzd3ppeVVL?=
 =?utf-8?B?ajlKd1FuWkw1N1RqbzdYYWRmNHpKS3pZQ0xXVVE1QXdIUHZVRjBDZnNDRVRW?=
 =?utf-8?B?cnovdEJ2cWc2dkhIcUpIVGpkM2NINTNiS0JnVlRaVmEzMURCMFdjekJkNVp2?=
 =?utf-8?B?dElPVmVlcU51N2w0dWo5bEVCVmZiZzNBTzZ0K0VLS0loc2NqK1ZDZS91UDk3?=
 =?utf-8?B?TXJrWmJBQXVhMjU2Rzk3a1pLRmdXOWZZaHkvOXBZaThqbEFIR1Z4YWg0dXIz?=
 =?utf-8?B?N2hmM1VXUWZ0QVViL3RxODNwd21BTmpobzRlOFlBK2FPaUI5ZGoxOVdHelB3?=
 =?utf-8?B?bGtwYkpQZ2tnUG9PV2VVRDNmY3piRnc3UktCL3FVWnNuenZOOExwNEVOVGt3?=
 =?utf-8?B?alczaEFxVnk5MHlXdUphTlJiaU13ZzA1VmR5ZEVnMS8wUzFxTDh5L0R1aFJy?=
 =?utf-8?B?Z1cxY2laOVdTd2VlNEJ0ZCtCSUdKcU5CM1BFemVUYUlBUkd4Z1lPanA5ODQ3?=
 =?utf-8?B?cjNVSGN3VEgxbmNzUjBpYTJkWTIrQjdJTlluTjlkbVBvNXJqdkpBeXFLVmlo?=
 =?utf-8?B?R1ZUc09kQkw0Q0M4SUd1ejUvVzVXUHNFV25ENnlGSmVVR2JpQUd6M0dnN2hv?=
 =?utf-8?B?OHp3UjJWNnZ3OURGeGEyQXlHTVBudFp1ZmQ4VWpvZlZTY3ZvbHNvVE1pUVFV?=
 =?utf-8?B?VERIdTE2MkJCWTVKSEN6OUdSZ2FMckQvTjNheVEvd2QyVDEzU2RBS0dOV1lx?=
 =?utf-8?B?N1VncFRVTUM2T0N1UjBpektxWVVqdHVLZ2VPZU5xVU9CYkp0d1FueS9vcE5T?=
 =?utf-8?B?N3JqcFRUdGlobkpPdGphRlh5cWQvYnYwMTVETFBlNzZTRXY3QXk3cHJ4c2hw?=
 =?utf-8?B?UDFsL1A1S3VLTWlHT01yckk1bE1UQlRtSXFQTXpvSy9HYWh6QXVQSTErRXlD?=
 =?utf-8?B?TzVGZzNWakNwc2tCdng3aVl1NXZkSzZQZERzQUlRalhFOCtFcU5kcWF1OEZy?=
 =?utf-8?B?aFVCeGowbzhFc09Tak92Yk5vTE1QaTNMT2Z2QThRVTNEOWFmVmJqYk9qN1pI?=
 =?utf-8?B?dzAraTVUNnkvUEh4UzhOc3hFaUZUZFA0RTR4cCs3a3Z2bFVJcUVuNmMxUkEx?=
 =?utf-8?B?MTl6clRHNWRQbWswVmg1VTdmMXRPOUhhYjA1WFVLc3poTVhLU25OQ29qWkl5?=
 =?utf-8?B?TXUySTZ2dGorbiswNjlmVXNZY0JwY25zUmVibWFlRDU4b3RWRm9mdjQ4ekxn?=
 =?utf-8?B?ODJ5WmxmaVJtcHpSMmJDZ3VsZ1V1bVZITnAvUEppVUNPL2JSUk9QK0pSY1lL?=
 =?utf-8?B?SFNxQ0UrZ1BCR2NZcjZjZ0V2NG9HTi9vemMwY25pOG9VMjZ2NUMvTW9EY2pk?=
 =?utf-8?B?WWk1d2s1SGxqUTQ5ajdRaDhFL1JsRldoR1h6RWFRZytyTmhaYkx4c2doeW11?=
 =?utf-8?B?dy9mYkZrK1lFbkcxaGt5ZkpualFsMzlKckVGaU1UQVFEMTNVL29UUWprSkdV?=
 =?utf-8?B?ZVZMazAxM3VGNFhlY2FOa1g3SkVaSyswbVFsR2JSWkUwdVQzT25YNTVUa1lv?=
 =?utf-8?B?eE80YnFIUGRTRjdBek1TNE9GTGtTT1R2cXVpWTdNOXIrTGZJbVJsMDlqazZj?=
 =?utf-8?B?eFBHbkxudUxqNFVrNVdlMWdTS1lkb1E2enVQeFQ3Q3l6dHg1Q1VOMzBqMzhQ?=
 =?utf-8?B?NEVUakZzUllPNmdqVnVVL0ZPYkg2eXRNMnNVdlV3MEtoQnNPNkFzUnFSQVVz?=
 =?utf-8?B?eGxCRHhqWnZja3IzelJmbmJwUHdBVmJkajVSN0dKMVh6TkVjc3JETHluWXg1?=
 =?utf-8?B?SHJYS0pJbnpFV3kzQStqRFVnQTMvMGtOa2tuSmRaZVhOdkxwSFU1T0Vmb20x?=
 =?utf-8?B?R3R0eGFrUXdMa3N4NXVrVU42Ulhjbnd1TTFSRnQvRng1VzJUZ1lSOEZwaUVN?=
 =?utf-8?B?UHpJQVllT0cxaXVYNkRKakdKUG0wRk1nc2JtTHR3bTBxQVhhbVRVWnIwMUFh?=
 =?utf-8?B?Rk1FbFBDbXluUkpmMEl6TThjMXpGakpYbXpWVERGaXVLN1FlQ0ZIY2xLY0Uz?=
 =?utf-8?B?OG4vdmZpMFhRbXN0RjY5aVVOczBTUkg5NnduYWdNZWt2VktoZk95TGxFaVEv?=
 =?utf-8?B?ZG96MEtMRlE0d1YzSkZMUU8wZWNSc09EMHpYeXM5Y25ab3ZHamJaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2090c243-51ff-438c-333e-08da34677b78
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2717.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 22:33:48.7690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8xcaQHkTrDrasbC9ePWUJQ09qHBb3YfwFXdMQjbouNuijRuZjrskKw7Qw5320i+9RnalR3DeMqviyvInY8L5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5534
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 5/11/2022 1:50 PM, Jason Gunthorpe wrote:
> On Thu, May 05, 2022 at 04:34:36PM -0500, Alex Sierra wrote:
>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 76e3af9639d9..892c4cc54dc2 100644
>> +++ b/mm/memory.c
>> @@ -621,6 +621,13 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>>   		if (is_zero_pfn(pfn))
>>   			return NULL;
>>   		if (pte_devmap(pte))
>> +/*
>> + * NOTE: Technically this should goto check_pfn label. However, page->_mapcount
>> + * is never incremented for device pages that are mmap through DAX mechanism
>> + * using pmem driver mounted into ext4 filesystem. When these pages are unmap,
>> + * zap_pte_range is called and vm_normal_page return a valid page with
>> + * page_mapcount() = 0, before page_remove_rmap is called.
>> + */
>>   			return NULL;
> ? Where does this series cause device coherent to be returned?
In our case, device coherent pages could be obtained as a result of 
migration(Patches 6/7 of 15), ending up mapped in CPU page tables. Later 
on, these pages might need to be returned by get_user_pages or other 
callers through vm_normal_pages. Our approach in this series, is to 
handle device-coherent-managed pages returned by vm_normal_pages, inside 
each caller. EX. device coherent pages don’t support LRU lists, NUMA 
migration or THP.
>
> Wasn't the plan to not set pte_devmap() ?

amdgpu does not set pte_devmap for our DEVICE_COHERENT pages. DEVMAP 
flags are set by drivers like virtio_fs or pmem, where 
MEMORY_DEVICE_FS_DAX type is used.
This patch series deals with DEVICE_COHERENT pages. My understanding 
was, that the DAX code and DEVICE_GENERIC would be fixed up later by 
someone more familiar with it. Were you expecting that we'd fix the DAX 
usage of pte_devmap flags in this patch series as well?

Regards,
Alex Sierra

>
> Jason
