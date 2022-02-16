Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE54B7D62
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Feb 2022 03:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245749AbiBPCBP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Feb 2022 21:01:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343498AbiBPCBO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Feb 2022 21:01:14 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B71FBA74;
        Tue, 15 Feb 2022 18:01:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhCH+eLT53JEQB4Os3cv93Z7xcUTPg4tMxhK8r01MPvnBotcVh2993+HfZFpeqKgOVb+CXivnOEgGIjtnRyOKaLtJvV/Hav4Wop/gBg6DaSVatF7HzE9NlpBBDaReE7HWiHNrNclfWCzZsoIEmaeBsUGGkkBFOPaHoRH25hUwNvPxEKLF2hs1ETaVFpKkwSomkfUGnKCZPpL20/N9Ssyxs6S+0JZhoYEL12iODxJ0Y9OqGWusL6nW9wXp1O7G1rTNoDrR/NIANhybAThAb+oNU2NV0nJgKUhzUT1uSm2/2Yk2bIHHT1K5LnqApkaWP+qVo+RJcXao6ufMGX0w3DU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ir59coiFA4o8Mc2TnbunvA43EBhA7rZfI6yZK1/hKs=;
 b=Ij4Y0DNU4Cl6t6CJcTJWx1n3Bg1tjT7tcG33vXfbQdGjLzN0CxIWo8YesHl8WvFJ3XSJP21niASZyfowPt5O76jAFkqTPXNhoesuGVMt8xAl+IasAfFKHrMZ/3GkSGsHChcXt33S4a8c7ODcxixGZZ9N0e0sPRknV84YgcCp6ytFqiaGDbiyp3EcQXh6KfzgjqYhqSnQuisjBIJhKJ9sb3dEnpvY+RWbWUh5yHcRnuvO9M2GFOQpj581OwHnrKaLoCVSRPfuiWRDRJOhtvBYgZIlKWuGGuxTWGoWOgUo24BtIBe0eFPhR1SWeiOTMhjPetxwMdwWxeX3d41njsXb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ir59coiFA4o8Mc2TnbunvA43EBhA7rZfI6yZK1/hKs=;
 b=txyKqOkAvBRuxzW23frCe/4kbFXMSbcNg+cCv3JMiftD8dVgIV0O+5DOqR03DYPy6j43pXgZ2sjYpAqdIgOJWF4qDkBaRe+058x+AZ05arccWuWgiGtLJBQuj1M8iMCqDqOV5NIjLxxPItS5lXbyBLAIxyC63RX2aGbEDvtpVxMU1wMH9JMwZ7uxXyP0Ec1WSFu0bd2Rc0x9NJajPJr/uPKunqI4hIKH159EOassmC801Gez5VZDg+REtFbwBKQB5X/A8WLokmvFylCiaQBUOiLTYykeH199oi7R2xOeq8g070kvojIXv7m2eNfux2RBhIb7XF+Lstk9pJQHcazf4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 02:01:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%5]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 02:01:01 +0000
Date:   Tue, 15 Feb 2022 22:01:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        jglisse@redhat.com, apopple@nvidia.com, willy@infradead.org
Subject: Re: [PATCH v6 01/10] mm: add zone device coherent type memory support
Message-ID: <20220216020100.GC4160@nvidia.com>
References: <beb38138-2266-1ff8-cc82-8fe914bed862@redhat.com>
 <f2af73c1-396b-168f-7f86-eb10b3b68a26@redhat.com>
 <a24d82d9-daf9-fa1a-8b9d-5db7fe10655e@amd.com>
 <078dd84e-ebbc-5c89-0407-f5ecc2ca3ebf@redhat.com>
 <20220215144524.GR4160@nvidia.com>
 <20220215183209.GA24409@lst.de>
 <20220215194107.GZ4160@nvidia.com>
 <ac3d5157-9251-f9fb-a973-f268ce58b4e0@amd.com>
 <20220215214749.GA4160@nvidia.com>
 <002ad572-4d32-7133-06f3-aa680c297be2@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002ad572-4d32-7133-06f3-aa680c297be2@amd.com>
X-ClientProxiedBy: MN2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:208:178::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 432d30b6-42fe-4e78-e68e-08d9f0f02e60
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40907C7B35BEFEF380BFAEECC2359@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4S+Gb9hLTue+GaLJzogd8Mq8yjEAPg/pUGUndTnSn0BVDkY7JT9YIW66nZYEgPjptyynHgrm0EpVqUbMqQO2T+u6seQRb9BaSvSGi8M7lsU+mhoDlR1zLgCaweDlyxn9Krs1UqqmQMfMdAOnzBvtwfadFupN1nVcOT1FfH4UwtHWLCoVXdycaZ2Ab/3tm1YFLZKqdxrI0jjE9bnnQuH2lL6liByX3Tcr+OYetSHJvgP4XBiQw9XoanS25GYmqp3rNCKrtow+y9D/iDf6tITB8SEWWDb0PJp14GyLGQS5vmTtNg5CKB24i3OwBx0YFiOekvoZB3NGbNfhomDv6jFInpifweRXgQEtmpyW0e2ji+tf2bAecXIUga65Zdy8ip8lDwB1alBONmtLB5Lg5y/wop3qSH+YM/XGXWhhmFkzoRz2WPJJAIaieFm9/MXMMJljgVo80JoZKRUyk0CaLhNXY4SN6JINBfJtzB3ld6jmPEvC2PldetNiusIcRyWM/hGIYb/8mne/vhL+w3+qPMxgfMBT8ttxc/y2eqS8+xNfjRIbIhAEQ+RkMnf1CkUbII1D8ekDHL9tYdViFkJkZwKIHYq1C/9ULl7TY5cGog0EzunlS4sVBPoTylo/1ZaMMdEFIsoQ6HYXEkd+XquG6BkUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38100700002)(6916009)(316002)(54906003)(5660300002)(8676002)(508600001)(7416002)(6506007)(66946007)(66476007)(2906002)(66556008)(33656002)(4326008)(6512007)(2616005)(83380400001)(6486002)(186003)(36756003)(8936002)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqxmYfStJQ+alTmZjERLOXnCmiduoC/rHPkbJb56fTkUNFYw7ZMVmw8+6A9H?=
 =?us-ascii?Q?AcQt5mX9HLiww/lZe8RDYBQOp3OAzDD7L4+miXlkDpZ3yMjXcK7unEZol/4A?=
 =?us-ascii?Q?hdJRLkzdC1y/Zrq9kWyuXHBY7e+SoUJUAVvWSu5PQiUYuI3pBMBdK8gKJcTy?=
 =?us-ascii?Q?LiTeteIVWOvE+sR3+T7PSUa4rnU8/EUJNfVe8nNb/RheIGB4TkTHF0CWNTMX?=
 =?us-ascii?Q?fBFD7XdbP5aJAUuOl5qZeAdWeIKzrqJD63+zQmioCTVo1cbaoPoi+EuQUnai?=
 =?us-ascii?Q?hYNZpK/Q8bvYF1zTcJyoLeAjKMjBArcd0nU1dGFOA5jIVV4hwT9kLbP04Imx?=
 =?us-ascii?Q?m3Zi5QQvLZqB9BfGRdNJzhVTW6G9gN3RwJI2j+J872ViKTiB3xppDjCXU1j7?=
 =?us-ascii?Q?N8iJfyB+b/HpAfjN0VavUtQ9mdOBN/sPSiQ9Ha9t0xchQhxBo4KinHVcIy52?=
 =?us-ascii?Q?hPGQG2LybzwJoxU/xzN6Xyueo2wwcKK0f/lSwi6hLg38dPrSCZIdVFU7DF5N?=
 =?us-ascii?Q?NDjyQtgJhU0Tqtn75N9Vu9+oR0HrSwrKeEJFJ9UJ+a6VK0Hx9uixXd87T7Av?=
 =?us-ascii?Q?v0ce9RKP9nkMYwt+SguF4L5E7e8TUJSQp709NC4OtN2hsq2RSruysLMUK+j3?=
 =?us-ascii?Q?CofU8NJKqMlwKqIzF9qo/UZOmVh3JsoNq2+7PEjzWLOH2VOONEY5UOnYQ9FN?=
 =?us-ascii?Q?pPB30+asBsdjpXLiaG4LkQp8gp1a35Nv7rm8fKrHcjVv0K/yrnBLbMH4pK0u?=
 =?us-ascii?Q?1z2CcooC/Z+DiEgqTA01EH5TFTHrl7cISm80s2V5GzGkcBi+Rd/beaOKBBrP?=
 =?us-ascii?Q?mOlsA2aAXZ6TIeeR3/SHLlJFH5AAdCiAnD2YSRvEPDMW11sWnn9QsFSnGRzt?=
 =?us-ascii?Q?J+ZIY31bGF99a1l7G4LHXVB1gB3tZLJi3buC3TXx1MsYhrYP3LOrKoOHAWEv?=
 =?us-ascii?Q?W6c/TpQo6qIR/483vB3fh8GON9i+hmn1zqVPuh5X7XJ0HBUftqK8vT8mKnvL?=
 =?us-ascii?Q?IvLx+9LIp28g2hVbf8uXrM6q6ATNp48/1DYqmN5xxWpL9BoZBBdXfOV5xWNE?=
 =?us-ascii?Q?sozSPOsM7Pk3SlFxTQ/qdxmnLKp/V+jOmcFk0Q0N5MQW+/YfHMl1gzg5YWcw?=
 =?us-ascii?Q?rO0UN61YwycY4vgLtqAKPRvPddLB+eL9p3jLaHFKD6WzPckLTcNf1NMWieS1?=
 =?us-ascii?Q?+FclWZUHEQDQfwmcUpiJuIDH4YuspbC1dLdUObfgDm3rQ3Xay9XzZj9b/5+Y?=
 =?us-ascii?Q?4KwCwjj2ZZji5+YDhhjnI4427aycNXKYSlSo+D0s5ND3nsw0TE2g/BVZMwTp?=
 =?us-ascii?Q?uRYQTtD+3EJxH/eOshE43IZGIpNQ/DaOLu88H8uUVMm4bNCMrTE451B5Z09c?=
 =?us-ascii?Q?c1IJ/ogLRiDfpzssvVaTCIADZye3I+LXGGAi4CED36r8zGHnsqyYTryvbb8D?=
 =?us-ascii?Q?xo1yds0LdPJfKD23BQg3NI12irg1mDr+9EqyIDoA3O6BE7ut19kIdxfLsqpN?=
 =?us-ascii?Q?vo1Hu/IjSbo5wPFKIoxrKijF/ZkDRB7NhOFUFFNH7j+5qrP/IAO3wkXpkqx6?=
 =?us-ascii?Q?4WDdd4MtcAiYN1cEMbM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432d30b6-42fe-4e78-e68e-08d9f0f02e60
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 02:01:01.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmnYE9/kIc6qgO44NMdQQR1Os9oHk1iuCRyel9njb12gDRTQLvuoCCkQRrKFtP2P
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

On Tue, Feb 15, 2022 at 05:49:07PM -0500, Felix Kuehling wrote:

> > Userspace does
> >   1) mmap(MAP_PRIVATE) to allocate anon memory
> >   2) something to trigger migration to install a ZONE_DEVICE page
> >   3) munmap()
> > 
> > Who decrements the refcout on the munmap?
> > 
> > When a ZONE_DEVICE page is installed in the PTE is supposed to be
> > marked as pte_devmap and that disables all the normal page refcounting
> > during munmap().
> > 
> > fsdax makes this work by working the refcounts backwards, the page is
> > refcounted while it exists in the driver, when the driver decides to
> > remove it then unmap_mapping_range() is called to purge it from all
> > PTEs and then refcount is decrd. munmap/fork/etc don't change the
> > refcount.
>
> Hmm, that just means, whether or not there are PTEs doesn't really
> matter.

Yes, that is the FSDAX model

> It should work the same as it does for DEVICE_PRIVATE pages. I'm not sure
> where DEVICE_PRIVATE page's refcounts are decremented on unmap, TBH. But I
> can't find it in our driver, or in the test_hmm driver for that matter.

It is not the same as DEVICE_PRIVATE because DEVICE_PRIVATE uses swap
entries. The put_page for that case is here:

static unsigned long zap_pte_range(struct mmu_gather *tlb,
				struct vm_area_struct *vma, pmd_t *pmd,
				unsigned long addr, unsigned long end,
				struct zap_details *details)
{
[..]
		if (is_device_private_entry(entry) ||
		    is_device_exclusive_entry(entry)) {
			struct page *page = pfn_swap_entry_to_page(entry);

			if (unlikely(zap_skip_check_mapping(details, page)))
				continue;
			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
			rss[mm_counter(page)]--;

			if (is_device_private_entry(entry))
				page_remove_rmap(page, false);

			put_page(page);

However the devmap case will return NULL from vm_normal_page() and won't
do the put_page() embedded inside the __tlb_remove_page() in the
pte_present() block in the same function.

After reflecting for awhile, I think Christoph's idea is quite
good. Just make it so you don't set pte_devmap() on your pages and
then lets avoid pte_devmap for all refcount correct ZONE_DEVICE pages.

Jason
