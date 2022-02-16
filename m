Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED514B7D65
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Feb 2022 03:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbiBPCEM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Feb 2022 21:04:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbiBPCEM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Feb 2022 21:04:12 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521C0FBA49;
        Tue, 15 Feb 2022 18:04:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoqEgQDIUoScYI6lzrGgtdiU2uH/ISDLU7KJnlzMWawxboIjd9CDGrt+Hg/ZC/XPb0hj4sT3W2vhcaXn8gQ+6CUyKO4axdGXlSGDgjeeHwd8iCWMC8TEDSKJ0JcM8ESFBJzi5Df/vQlAcpgTedafn7xBAP0TNS4vr3gRw87BooA/qfMVczBAnUoTdk13A6JECYPSGXgwXKFJek0XiO5KA5OnHulKqt/dXxbzNtd1nmd2cl/9e4SXe5M93oGeEfVLH2rKXEsyELC8Uo3sAHPPKQG8mG0zf069TDfop6IloRTY+AVqSwWngDSS0N8Nh7Q2+G4PdJoCvn0N54kOvy55pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6avp/d3lK++7QpQRE2igUS7/4zN7A3WvAMLq0kBu884=;
 b=SmCtIBx/MRfXSiOSdOji6Bo2OZdwLlaE52h0a422I0XpDK2yFqMNu9tmAc29D3Oi9S4ril9phMB4ctoT94AjFOSuSZ9D8wl2r3x0AMf9vKIb16827P8I22zh+AWtFdd1mUZI4bbsTrlTD+vbXe1h9A+vBERZb40mP7AUVE/rEdV1keRyEUj3EYGHiSZC74M+UdXFrVuciDukThQp366K2kTmCl+oLqhne0LKZjEeVVs6m9M+nZ5moMXYAWP/uWBMfOlJaJl4RG2LrhUHUgswaId+wNxk8efcClXVz/9SoXRRkzE87m4EX3NmrmdE1J6egS6eBwgGs433bQv/lBQuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6avp/d3lK++7QpQRE2igUS7/4zN7A3WvAMLq0kBu884=;
 b=Sg3qh94mSLZPPAzPo6aOT15enEL+mNfelg7ELuBahsVv66aE4m5/yBVTgus3heypMt+/Qd0DyQRGdKZGQkUqJHoaAmmS7SXdEs2eRbTVv03DBhREptG3fuJUqafI8BphoX0lTuPv86FFUeWyeos10N7QxcxvfsHOt5rSgQBbeVxYRneBA0huww8nSAH+IlOfiKM77xkmksyzvUGed4JH6PocqPvVbNhtoq4vWbxWX7sMfcmetgyaCr5N71/NMkwjvsdblheZ8z1Cx2d+EemTrH+6r+0mZK7izAw0mMNnAT8s8bu5GAflm+/HjMbuORF0CwpMVIL84h+svIUZpOB20g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 02:03:59 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%5]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 02:03:59 +0000
Date:   Tue, 15 Feb 2022 22:03:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        jglisse@redhat.com, willy@infradead.org
Subject: Re: [PATCH v6 01/10] mm: add zone device coherent type memory support
Message-ID: <20220216020357.GD4160@nvidia.com>
References: <beb38138-2266-1ff8-cc82-8fe914bed862@redhat.com>
 <f2af73c1-396b-168f-7f86-eb10b3b68a26@redhat.com>
 <a24d82d9-daf9-fa1a-8b9d-5db7fe10655e@amd.com>
 <078dd84e-ebbc-5c89-0407-f5ecc2ca3ebf@redhat.com>
 <20220215144524.GR4160@nvidia.com>
 <20220215183209.GA24409@lst.de>
 <20220215194107.GZ4160@nvidia.com>
 <ac3d5157-9251-f9fb-a973-f268ce58b4e0@amd.com>
 <20220215214749.GA4160@nvidia.com>
 <877d9vd10u.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d9vd10u.fsf@nvdebian.thelocal>
X-ClientProxiedBy: BL0PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:91::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e76c07f-0d8a-4c3c-3bae-08d9f0f098af
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40904B20A917286CE13A14F0C2359@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpcJ5WSBjpcOB5ywW5eVPX/Kz3fAYse6Gf263ML3/vnkiZE5AEdRmqXY8s3NpV2Aoukaa46U+3uPocLinEp4uXwEOwC6+ZF2xL5Dy+qvWg84WRneWDem1ijx9BdGYe7c0Ppg3lkmYMU6k+IwizsZlqzQuCqI6fVtgHyCwVS58pWFbISWHRenBksGUOAoz5Ots1/NxI9AqkQ/W5ZcqE0B+Lno6YWIuwrRK+QlJGQF0Qx/xwOrOv0pS1sLTn5UBgICjoM72Me8Q1WeCYy4zKCvdkYsJlKeagkWVvYcn/cES1uZwS2HeiZIdE+Ta2DoJmOi5k5cGUlGPmn4gW/ASmP+AfNWN6wiATAkHsGKKqPtSelekaCC9zA4OURlOxkkmwur10qmFqP843At3lKPLlR/RtX12eLliBUZmvUVXrvmb39292c5G56ESOM/aulSkBZ4tUbXAZCREteeVkD4ohBuRbEvnmQHNmdOPwEpzJk8LdljhP9WAVAkG22/bunst7vTbz2K+GM6L0fINU+CwYlkV2pkc5WQn+j3GlQMPsC9cNR6kuJRpcaINO2SLrr88IdoA9WZ9Qfn/RftlEdXTFCODVcpRA96sKFS2KLhdN4sPQh/wN+C2NpNcC+EA5I8Eeoyzj5oQEvQjXTy9ym6tEoUMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(7416002)(66476007)(2906002)(6862004)(66556008)(508600001)(5660300002)(8676002)(4744005)(8936002)(26005)(186003)(36756003)(1076003)(2616005)(33656002)(4326008)(6512007)(6486002)(38100700002)(86362001)(316002)(54906003)(37006003)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X+X44jUd6s9aAwqrxjgIBqLNJuhEbvzBygOlgD97QyHw4GyRkMMkEeS+qdno?=
 =?us-ascii?Q?J3km/ZaUIsuJBg+eL7vQFkSAIl/OXSyplL4lODDtkB8Bau1qcADV771mZO0v?=
 =?us-ascii?Q?1yCdLOdQNuDmg0V+1sgewAU68Qk6YSfgaMk/0QkZDNWlAHYPuyV//s/Cfe/r?=
 =?us-ascii?Q?VcatwNWSlklnDyDLX2u3judaEtsVgPxbOn6Z/7UBYQjeOH7OuFAvBIhSd/O7?=
 =?us-ascii?Q?n3Iu9+jokbrQY5feykeMjYGbBSMGImoOnHtseBx7Jlgnbe+YHjo7ZpjdtAEO?=
 =?us-ascii?Q?4h/odnwWMySvl+ClUm3T7uKUVJWZcsEqlmplk7cqd6OQ7pzS3kqLbx6ctoL0?=
 =?us-ascii?Q?ttIifRFIWfsxyq7AlOBZ9wA8cPLEtwzaHFIAcs2w6MVxoLnxIIHBVGdoJ7Rk?=
 =?us-ascii?Q?qmaY594AY9j5V/mj58z6P+x0tl0u+ZB7OvsJyWEcQ0xWm6dMpJeJXt931LXF?=
 =?us-ascii?Q?t8bZK8IPs9byTM5DeaqSdDX6hSW+IAUZUNGJMDkzlKioK6nlH/TilYhqCjqx?=
 =?us-ascii?Q?XVHzCA6pD6MXijyQArjH3fZUdsJ09UeRfNsMpzpFqQjBD8mVLZ1ZPiDOB5zE?=
 =?us-ascii?Q?ZLonTiqgIRu/Sbwm8zyEJnQetahpMIlda0Qb48IJmU1rOpZxbV1p+CeUN9WQ?=
 =?us-ascii?Q?5pIhbwKl/SpQofYe8/usQ4ySPe7DVS09oFglnYqJdwQXTe9lHkFwkN5kZ3vo?=
 =?us-ascii?Q?Sk/QYzsCOhZ/5PrMVJRUWnfPDrnruE4wcFnZwjv1yr0kBgSf3oQ32BOsZZdO?=
 =?us-ascii?Q?IvtkxNAnxa5SwxBctpb+FmPvidPumLVVk44PBoflu/iO40TrhSWOyL+Uo1jQ?=
 =?us-ascii?Q?aax9Jp9QGOyzcvx0Rz48Tkm3hU8bBC9lIIISmICyLDTIczzfC1P/V2jvh4ud?=
 =?us-ascii?Q?pznfVA0YRkE2p/VGLXEj5JIET0ZkkjXs7CediJvhFjGBQvvZAM9Cp3YqDI4W?=
 =?us-ascii?Q?E/21mPscswym1sl+3i69J8STdtn/90YwYsqb15FgMWFFuPcrjc/RfVknpsWh?=
 =?us-ascii?Q?+/3ZjbjhO3WnTnOcuj8Vslvi7fn8Bwky6PDD1LABhwamosqRTSEM9P9kh/KW?=
 =?us-ascii?Q?qSyo8MZMeSxLUyaMQA79ShyaOXzlsciSmfn98HSlvFZEYQc4bWSRwyTvCQ0v?=
 =?us-ascii?Q?oCICCd2viuyAqeqtwg8Z3zyioa56YBhzx2HIfgv25SlEknfG7Qz+BK73ShHS?=
 =?us-ascii?Q?21syF2RLVMS8ErPp5Sww5RkGiehUV0PF5LbKNeaKlw2xUBnljIcPnN1ozecp?=
 =?us-ascii?Q?vl8IgT57luMRuoFBl9iTMbllY9ZRckxYoaVivztcoZEGIVrwXd+XHvm2nUaP?=
 =?us-ascii?Q?/jJaafUD/eVnyc3dnnNddxNmoeSvefjZAgiJLfNkoVVhGoeLG/Spq6tRuryZ?=
 =?us-ascii?Q?SVM/18RVP3oUs+violb3/cq9/L98UTVfxekS2I40uN5jujEcD3UPYguQXytF?=
 =?us-ascii?Q?+nvWAAIz50SzEhXU1DbAfSZO8gKdxAsS2bnmNJoVuvAszkmM9uz4qgxlFprp?=
 =?us-ascii?Q?UnHvBcLV/pAdna4bWi4tq1+I4lQlGUz9CYINw/28hfKXj1zn2Kswf2otUcxw?=
 =?us-ascii?Q?12RlnEmlTt0Nv6S50qA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e76c07f-0d8a-4c3c-3bae-08d9f0f098af
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 02:03:59.5479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8g5L9MEbzLmXyjUy8BbNEE0InKmQXGE/jZuo6XxvCV62knNSVF7cOrrUj3ee7Zq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 16, 2022 at 12:23:44PM +1100, Alistair Popple wrote:

> Device private and device coherent pages are not marked with pte_devmap and they
> are backed by a struct page. The only way of inserting them is via migrate_vma.
> The refcount is decremented in zap_pte_range() on munmap() with special handling
> for device private pages. Looking at it again though I wonder if there is any
> special treatment required in zap_pte_range() for device coherent pages given
> they count as present pages.

This is what I guessed, but we shouldn't be able to just drop
pte_devmap on these pages without any other work?? Granted it does
very little already..

I thought at least gup_fast needed to be touched or did this get
handled by scanning the page list after the fact?

Jason
