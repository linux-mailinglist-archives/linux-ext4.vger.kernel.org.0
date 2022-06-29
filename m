Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72049560C17
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jun 2022 00:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiF2WIt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 18:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2WIt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 18:08:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1C12C659;
        Wed, 29 Jun 2022 15:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G65dBFzdnPhzVRqJ6BTsPphIaTOd88rx6QUv1+WfYKzufGzJ/wsvG90b5Bc+CdcRS39jzdnh7zpFS0uFterUIYkYTa9nFpBya6SD2kbPqMTZiMX1BIM8gGd3zUoZMI6DGG6sw2UDYiipyzsuBJhe4vsqQ9oFvLYMML1+1F/jKWtdLQ0xZ33PRR4XsirmcHA8wZdfrM3yiagU3nXAhqEOA37rfqmGGzGZS/Hn9aqR8UXZ9bZX/LmOOIMDK/zCK30PaWqyeIIeE4KEUIrlX+D0Sh2Ji4Br0rNMRD/BX5Vv+YWaU3puROlcBdZiiJ380ohdMZpQ8EJvzTbeQumSIofHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6LuPQfP3w8l/8hCk/lHaAkw0HZ+eCgAlwc6Cne55eQ=;
 b=BUeNrDEQNFs5tSg/vRpAV9QCCni67MxVvjm3o/0mEWtJyqXYMNvl2B/JXt6EeeZtzmAy1n9xk8zKEDAnkDc3l7bfBeIJhFE9Gq2J7AhbW1SmzJ15BIf6idFsKVVdM8kaV1Eajz9lJt3N4J0dLYZ2y3byge8gy7vwtd8jskt5sQ/fX7ePSw283MLYX++1PG+NBxNYaIayFKwL55VAuk+so8LRPTEV4BBzA5vtiBN87HPUfBUToaQWtvhRaryitoVv6lIGu9XMN/M9UXOjIhU9wT4HYFDgV5lv/muzDW+CkNP3P+jX1KSde+4/2pBa8xbDBmtLP9DUYEDGdrDcWSgTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6LuPQfP3w8l/8hCk/lHaAkw0HZ+eCgAlwc6Cne55eQ=;
 b=Kd3BzktqZpR7W5SSnFZ6q/XSKNbZPDm6ieo1bwIq5nwZDccxhZfiqx86SnIe0Q2BYvVrdhzgsjW507nyFMaQbs8pkKOj54RpMaYAW1ZNogDYBgCQFjqVc53n3RcUjz74HRuQsbBR33UWSYLig9BVek5HFTIbrtVccMEp36RbPZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 22:08:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 22:08:42 +0000
Message-ID: <575b48a6-e372-acda-9a7c-449f307a588c@amd.com>
Date:   Wed, 29 Jun 2022 18:08:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 01/14] mm: rename is_pinnable_pages to
 is_pinnable_longterm_pages
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
Cc:     linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jglisse@redhat.com, apopple@nvidia.com,
        willy@infradead.org, akpm@linux-foundation.org
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-2-alex.sierra@amd.com>
 <f00f9c93-c115-d222-dc8c-11493ccd2567@redhat.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <f00f9c93-c115-d222-dc8c-11493ccd2567@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65e0837e-01d9-4059-178b-08da5a1bed83
X-MS-TrafficTypeDiagnostic: PH7PR12MB6609:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8YyzpAUP7LKkEJfY819GjW4Htfj1ZidtneObtGKlSwgdg+pnn4v2mIuTMPNUQuqKC3/PhWAneeZ+dLEKN+eFikh3+mdvsOSbgQ1V6v70sbl+stVWq1I2sCxK4Cjy46yC0gXMXO9BR7B3WqU1bJAZ4St7BFRygMoyoMhjv+bFx5UTJCJ6wQ0HO0LpWuvMp5Cf31cgDnFOnQm+3q2wF40/AIiuS53eOO1y5hnrgjVkTT91DB7JaPC3cDSbQuAPrXiE1uQCKdgaWgnw8T3ndlh7xxIly+yethn7vU/zuWqkxnZeoYpZr/S1DtX3q1+HDBIVdwYU9P/pzuigsA7T5mRta1YymSy/EwMfALBZkhQtDVhU5UBh57fhZCNdd0hplTng8PuClsyIXAOpN32CMIkELC+FCGldAXmLGBjivp+0cBRYWeoOn3GgH1hHS/N/um08I/f4e5WVwAKwJlJ1SjhkZd57CXC6S0/emoKGKyZZ+K57sw325fK6o80qzNRGj6YQLVfJnXV56uIRg+s7B/7khOsNAsA4FSxZFg0676UCHwJjNs21LON8bTGclG3J6EBCmFl7l1lLbnvkMf7V6ojk2F5fUelcxCk4SFtYjiVKIDJeA9Tow/0240HUGPEU+5NfN1rKGE5YtCn3CzBXWC4rTIlg2+U47eL+VjX5iBg08WmjcDrLfDhV0iph9bMj02q24rCknZ6H2zYZA8spuJbwmc3ZKIzYRf/ajsJghOmoz9E0fo3QcFKS/7M2SvhyrnTQHC/sB4t3C/u56Ys587uqrjuGMKIafWyQKPtAPhBMselq11N5YTpQU7O3283+Xzob+ynXrTKpW2uc8R+HVYW8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(53546011)(5660300002)(26005)(41300700001)(66556008)(66476007)(7416002)(6506007)(44832011)(36916002)(4744005)(478600001)(110136005)(2616005)(6512007)(83380400001)(2906002)(8936002)(86362001)(36756003)(31686004)(66946007)(6486002)(4326008)(8676002)(31696002)(316002)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUxDcW4xSko3STlIMGJjZVp1eXc5U3lWOXpSemo5MUdRcXJlM1VjUmsyUEh6?=
 =?utf-8?B?UUV2cTV6UXE2ZUF1VHZVNGRSRVdGMDRHWVduTUp4dFM0M25hTmxLT2JRd3Br?=
 =?utf-8?B?anA0Z3BqTWlnSGp5bTJGSlBzNFpCcGJlSHdPYWQ1NmlocCtscW1UYnZvUU5G?=
 =?utf-8?B?ZkhqUFlxeVlMcTdmejQvTmVIQ3BkdTlhTmpVR0NiNFV0RTNjeW5iWkg5NE9p?=
 =?utf-8?B?dmphTGlHL3p1STZxazBndm9UTjJYTHFKRkhRbzFWbU01cnFZMWlQaTYyWmF0?=
 =?utf-8?B?Ni9RcW96SVQ3VHpBUHhVZ2Z6bU1FcnNhcDgzbnZ2TFpHaFI0WWhBMHRkQVZN?=
 =?utf-8?B?MU9ONTF1T3BUTUFqWGJYSm02a0tONDNiWkhONzhMUzQ0V1VxL3BIRkdWQ1pl?=
 =?utf-8?B?ZmRZZklxSkRPTnNNVU16bFFZaWRsTUxwMTZlblRJZW1mOUozM1Y4dWlnZ05q?=
 =?utf-8?B?eEtQTk5uUTAwcTdLRGNYVkJ1dnBFVlJIZVROZll6aEJQNlNTdkdWY0RPM1VZ?=
 =?utf-8?B?VzU2cndsYStsN3NjVWpmOUxoVFdqd0pGNitKYnZ5UTNVQ0pQQnNnRHRXemJq?=
 =?utf-8?B?bzFzdWFGV3J1czlXeldYdU4vdDUzckRSN2wzUHlITWRqVktMTG9xRVVTMWJ5?=
 =?utf-8?B?cHZPTndWaTBIV1ljTUNuYXhXWkFhazFyalFwd09ta0NCa3NFWU9oL0cybm15?=
 =?utf-8?B?a1lUSTdTRk5YSkRCYjNtcTQrU2VIS2FJclplZExTdnlzV3ZXWmQrdDBJM3ll?=
 =?utf-8?B?bE8yZFBXVS9JY3dhU1FuZ3RRNUczS1ZUc1h6U0lCK0tFbnJ4NUhwOXRPTFov?=
 =?utf-8?B?ZjVDKzFRS3RDUytBbjUxWEY2RjdxNDIranBFdkJZbmZJeWxzUWFwWkNvQ1A1?=
 =?utf-8?B?K2Z6d3NzQ01xQ1pHY3Vkdkk3SjJHbmJiV1NNOXNKaWhSSlZEaE1VbktwK1Zt?=
 =?utf-8?B?ZlFJWkVmV2NXOTFPQllBT0ZuekpWNTByMDhNVFoyeHJlQnlRQlNhT0dCMEN4?=
 =?utf-8?B?a2VRbjZyMTlETHBLYnc4ejNQTWo3bVcxS3pWYm10WlQxVDRzNVVscHN4TkxM?=
 =?utf-8?B?SThjcU9aVUJJMXpVb2xsanZVWFJzOFd4UDd2U0hEbHNxL2Z1UTdrekpTQzZp?=
 =?utf-8?B?THlnUkFFRUNjRWhuRFF2aWgvbTEycGZNUXdWR2dUQytQSXdDQm91WHJlRVVz?=
 =?utf-8?B?TDlHNW5EMEhGK3JEMHF1M0FJbnFhcGkyU29OanJ5M2ZlOUNmeUZCRHJXVm5S?=
 =?utf-8?B?SmJkbTQ0SVpLZE1rODZkeVJqYVVqZ3h4d29sNk9MNXAzZGtDWXJDeFh4Wk5M?=
 =?utf-8?B?eGVVVVA5Y1Mya29CVHJBWmttK3VhZXRVNVUvS2drV2xWN0t5aFR0WjIyVFNV?=
 =?utf-8?B?UGgxUTNzNWpBY2g3RDNKMkZSVDJrbVNpMGY3TWplUURLKzE1WlNTTWtvaVRH?=
 =?utf-8?B?RjBpaHJkcVpXM3RReDk1STFkT0pzRXJWaDJSSU9mUit4bFNqRjQ5YW9iWU1l?=
 =?utf-8?B?YTRLZ2p2VE9Wa3psSVVZaDFZczQvemdFNTI4YWdLa3dFM0ptWFpoY2UrTVNC?=
 =?utf-8?B?RXRudENha3ljTWUrd2Fwck1oQmYrbHh1bHBWR2JqWHZUODVZbDUyT1dOeWgw?=
 =?utf-8?B?cHJVcVprZ2ROdUpTNnVLTWM1SWphM2svcElVNElqZXhBSElDdGJtb1hBMVN4?=
 =?utf-8?B?M1VybmlKSGUxK21UMlV1am9TUGt0VmQ4YWpmRzNKcUYvL240VThpVG0rMzhx?=
 =?utf-8?B?bG1GYjNNRmI0OHI5RFNJa3JQc2l0U0N5YXN0YmhSbjdDZXhKTXdTSHl1RjY3?=
 =?utf-8?B?Q1MwTUNuMnI4NVU4SkNBM01EOWRYdFV5ZUcyaHFuTHhKUDZ5MXQvNnU3NHdC?=
 =?utf-8?B?VHhSamt1MTU0aXdhNWZJcVpRaFNQVzFPTDI5UVZ0NGt0UExCTHdTRVhyZTlm?=
 =?utf-8?B?UUhFZlVna2xJYTVWZjZVaG5iUjlSME1aNUwwbVQ2UE4zOHZrRnd0NkVja3lY?=
 =?utf-8?B?UnFYRis1THpxamZRMDBMKzdCVWpNd1NDSmxkSncyNDYzNmV6Rlh5T2J2VTZi?=
 =?utf-8?B?VlFJNzh0WGFGTXJ1bEFRV0ZzemhNbDJMbUhiOWpFNkh3TUlxQ21HWEZlOTdR?=
 =?utf-8?Q?E6sT7z5tSP5ZrHuu1w+DR4TuC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e0837e-01d9-4059-178b-08da5a1bed83
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:08:42.3629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RSCww2pHaRbsnxVZsESHNvs+oz9f/YyPWRFNO7FvSER7oG2NyKXL3mYP7ZNrbkpGvRkGmb4+/S8hJThlsF8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022-06-29 03:33, David Hildenbrand wrote:
> On 29.06.22 05:54, Alex Sierra wrote:
>> is_pinnable_page() and folio_is_pinnable() were renamed to
>> is_longterm_pinnable_page() and folio_is_longterm_pinnable()
>> respectively. These functions are used in the FOLL_LONGTERM flag
>> context.
> Subject talks about "*_pages"
>
>
> Can you elaborate why the move from mm.h to memremap.h is justified?

Patch 2 adds is_device_coherent_page in memremap.h and updates 
is_longterm_pinnable_page to call is_device_coherent_page. memremap.h 
cannot include mm.h because it is itself included by mm.h. So the choice 
was to move is_longterm_pinnable_page to memremap.h, or move 
is_device_coherent_page and all its dependencies to mm.h. The latter 
would have been a bigger change.


>
> I'd have called it "is_longterm_pinnable_page", but I am not a native
> speaker, so no strong opinion :)

I think only the patch title has the name backwards. The code uses 
is_longterm_pinnable_page.

Regards,
   Felix


>
>
