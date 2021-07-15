Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147E93CA225
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jul 2021 18:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhGOQVV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jul 2021 12:21:21 -0400
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:26293
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230496AbhGOQVT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Jul 2021 12:21:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC+ECfrQmT6+bdUW50jhrhUP2cIURIJTLywhi8iFMFrsB1hW3TU6wyY0UDYR0spPCkuKD7O3UHClJpOgz3qBf45x4UzBPcZbNDoc38qQwVPESlVXzoSGyxXXgQBC5BDJ5nl5UKRzZaVvQlBTDZ4Rd7hkV6Hy8hhzPse2mv/u76CPMJ3wl63LSuLRPAzrf/dMpejae/pTU3C8lpOgnYwIskDXk52HYIm2NOBBjXQgG4M9i2FzT1fT2r+0JiSA72s9X4PIw7p/QsxLXsWHuKxjD6C5LkxF8DEmxEZhbrUhv1Y9tV6O4yrIIHZ24+hvVUxX+ZCZpl+GTs0uN7WFAieN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ+cvs3E2P9oEGcGSEijOz7A5LNG6R/si89Nr5nr8H8=;
 b=C5XYNfIt8UEkpgCxUIZ2BJ/oseKDC4YN0sfTexjO2NLZOS7cOQcU4LeKx8yGk5gummW7HipfXoKwSMHmLdRF8ILi0k5M5y5b/S52JUdNsq70+2rex8RP5qtCtTuUDUghaGrY/IBlW9uIx52W3JFg7aLzKAmLxI1SiXOk47BCyYXKuPdZH62hzdVOyWGDQ6cSLLjtThkiaPNQzN+dqigguGNdA+NXihOMBCit0/hvilIH082QMgYZozK/oG+yIuv1spTXbD2E7IsrClOvHztoa2V3Dhm31hKOzQkELK3ByxHD6YCRrgDRfFYDU7LdXBvmPbcdrjIFIpS7/f6LS6qfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=urjc.es; dmarc=pass action=none header.from=urjc.es; dkim=pass
 header.d=urjc.es; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=urjc.onmicrosoft.com;
 s=selector2-urjc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ+cvs3E2P9oEGcGSEijOz7A5LNG6R/si89Nr5nr8H8=;
 b=o25NEPPFSQ2tdrNuhZZ3VmD42Wn9ABPNQhieID3f2xoCHqsYWZCV2XNmcVs8Gl5y/9B0EsZLOET0QS4HdQM7ke6NjktzcTa3PFlUIhn73lPwP0NKJymYp++JK79U+BOM41yc3zkTEhTANHj9d0v3a4aYrA0IV+Uyho/PULFCKuc=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=urjc.es;
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com (20.177.193.15) by
 DB7PR02MB3948.eurprd02.prod.outlook.com (20.176.238.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.24; Thu, 15 Jul 2021 16:18:24 +0000
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::1048:a385:a5d8:1f0e]) by DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::1048:a385:a5d8:1f0e%7]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 16:18:23 +0000
Date:   Thu, 15 Jul 2021 18:18:21 +0200
From:   Javier Pello <javier.pello@urjc.es>
To:     Jan Kara <jack@suse.cz>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/ext2: Avoid page_address on pages returned by
 ext2_get_page
Message-Id: <20210715181821.3fb4d5d3c5d26049c29f0607@urjc.es>
In-Reply-To: <20210715121730.GA31920@quack2.suse.cz>
References: <20210713165821.8a268e2c1db4fd5cf452acd2@urjc.es>
        <20210713165918.10da0318af5b9b73e599a517@urjc.es>
        <20210713163018.GF24271@quack2.suse.cz>
        <20210713193319.a223cd12e3fb8687f0cae0e8@urjc.es>
        <20210714090013.GA9457@quack2.suse.cz>
        <20210714185448.8707ac239e9f12b3a7f5b9f9@urjc.es>
        <20210714170746.GL3169279@iweiny-DESK2.sc.intel.com>
        <20210715121730.GA31920@quack2.suse.cz>
Organization: Universidad Rey Juan Carlos
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::36) To DB7PR02MB4663.eurprd02.prod.outlook.com
 (2603:10a6:10:5c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mo-dep2-d036-01.escet.urjc.es (212.128.1.36) by MR2P264CA0120.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:33::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 16:18:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 772b95f2-426f-4c90-5abc-08d947ac2b3c
X-MS-TrafficTypeDiagnostic: DB7PR02MB3948:
X-Microsoft-Antispam-PRVS: <DB7PR02MB3948E4EE4570FC6C0D16C3AF9B129@DB7PR02MB3948.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htKPgaBypefsmZjjenIbnaMHPndGPW0I4/jgyH2nD4605sUjlsJgFUSXT3f5Sf2R+0EcVt4o1QqT4lEKXtOm8bhEj0UV1biRJ7o6pfH6FEGbimPG7fReAosJuSM9EgHogrM1L9scDp1KRZdrmSx6CWtvedeHziq3YMLWBhHdNeA9R7dMDm8UCWB0YF0wiNbcsNBe/q3g93wegSPgGPdyIpbQwgfRC1yVyk20CbDO9t8sT03zTmfznqwCRS1Se0yzybQ6tps6wH2/yFdG31gVfbS9rkX6hLWDTkeZoHx/yLmVCF+4OwysRNjyo+5yh0iVbYblW2CkqAZCAiiudVmg08pAHKMEDBgKf32V56dCPtUYSZxHx69NcfDITt5YF+l+LNO6ox1Or94sHtXVzQr+p3TYXioqoUuwgU8sDJgyxVUVte6LUwTbjfEJoHe0BdP8kZC2CRnp/pJQcal7o/KXu4ATzYvMDPtkDXSemIuJeuqL+1RthD0xBzoYuQ/j+LzU+FhtIfifckKKnkVoMBnEKhM8J8WohnthiLgjEJQh+O3yM87Nrm/HK0Og9czrkL8Pq9Mg3zRAVN2dDsOlxAJD9fVLYUUy66M7rJKVBfilOHTsBNd2OCNPmgr8+UlMShIWwKMxVKVRzg7oL2gOyYtY0ZyXlOC7HZGNpr/g4c0AecH9nfoXre7wo7+itgtWvc9ax7q3s9QXSG09hwSZjV1hcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR02MB4663.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(376002)(39840400004)(366004)(66556008)(83380400001)(86362001)(36916002)(6486002)(52116002)(316002)(26005)(66946007)(38350700002)(38100700002)(7696005)(54906003)(66476007)(786003)(186003)(8936002)(2906002)(1076003)(36756003)(4326008)(478600001)(6916009)(44832011)(2616005)(8676002)(956004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZOTF8tSldxk06/iCyUy/Cp79mQZtYzBrrAK8xeI6twAk9y2WPVB1bZSwBtQS?=
 =?us-ascii?Q?fLlShtQ9yb+zbM+EY3tYo9Dp84aNCMxsz8yZnQPgOlbuJNBtMXSmWszEFHpN?=
 =?us-ascii?Q?9C7UKJqj6RumgAgq7za9zO30ggGxUhtKcKDHh5X3PzLJShp3unfjvDwD6J1b?=
 =?us-ascii?Q?mWAeif57WX5JCRuhqZNDCmhUpPAyIjPLoU/y2XJxQNEvY5t8WFRb8WP7eCmv?=
 =?us-ascii?Q?ONLs0anEChH24QktyH/m5UtftOVoRW4EXnL65Tk4AoIMJb/3hQarHEjKZjSO?=
 =?us-ascii?Q?rPT+pGheClp11vCj19oAI5zTFr98Jvr8ugZe4dAYhh7UCaNlmTjcmVC1x/3B?=
 =?us-ascii?Q?k5TnW89nzJzo5GOUR8fl/zxprR2QCebjuAVCwzbD66Ywmf8BMYaqh71mzC1K?=
 =?us-ascii?Q?xk9/8kF/Y2HTfX9M0Awh126bMMX3KJpBpBXDVf+fonvl63Ztl3xIYyzVnmkj?=
 =?us-ascii?Q?XC36goiLEet3pOjSKSuJoTSHqOnNqPDFBobpOL+f2VsKtby64wIahX2Aam4D?=
 =?us-ascii?Q?xVI1Xy+j6ENkZjWFtZg9yj0Cum2KZZXCWThaJTHtxtpaNQ/rXNtPFnwggCAf?=
 =?us-ascii?Q?uVMnlIj1lOri6aAdjDPgt2MMOY/+thqJu5zEjsCRLCTaJhVl3sEHApppsAc2?=
 =?us-ascii?Q?JQ6zeVqmDfZ6FJrrtB6MfoaozFd86YU9KL+ZFaYkgU11zTN0Sod3Z4aMAveV?=
 =?us-ascii?Q?NkgpqCC1IzXqkX4VW4e5pKrsANKVmxtJBT3VpWKrGq1GbBTpaMtvgTuYk9gp?=
 =?us-ascii?Q?GIyIcUG/Bpc7PZ36SQBLklM3zGYpuOI2si5/ZJXzECc+xz+5uwVgLGhbZdot?=
 =?us-ascii?Q?7pCujUbAi+6FPGnngFyddrOOIjDDK8DMQwR167Y81zXjk3Dg9qtAH5iTJ6w6?=
 =?us-ascii?Q?M2wiHbSlXP/vKqpCSKkAmfwIoNdvZE9ytNTTo8NwXMHi89k8my31hAu/nqFB?=
 =?us-ascii?Q?sBxJFfikaySwN5AKRDsdBVPUpiWOPP2ZSGAS6YO0Scxxo2gU3NcNXibA2xkQ?=
 =?us-ascii?Q?81oS4ryTU+Aeuy6KGKKWO7OIqlCGttjkjCma93qDeAXjCpDxs0pcSfjdUzoB?=
 =?us-ascii?Q?Y4BrshGcY+mr4iDMyrABR7pkoN/2BW0uzX9z3RX2bdNdgwPjTP0hLGCXxEl5?=
 =?us-ascii?Q?rPx9gjVkNKqBeqCU34o7UzExadbBtIcTl/Am90u6hVcpOZwvFvpDFkRibW0P?=
 =?us-ascii?Q?xjZBeWP9WVq5ztzDXLEQ1CJCBQcHdZhJpmSHMS3A3QA6bsp1xopteEjMh773?=
 =?us-ascii?Q?LhxbSZIIRln4UohkiedSo+mzxKoxQ8xelGvW/L3VPNMPUpbllmqxwLOZXwY/?=
 =?us-ascii?Q?uJv13QN4sW+NPh/ax2UPtAt9?=
X-OriginatorOrg: urjc.es
X-MS-Exchange-CrossTenant-Network-Message-Id: 772b95f2-426f-4c90-5abc-08d947ac2b3c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB4663.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:18:23.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5f84c4ea-370d-4b9e-830c-756f8bf1b51f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWDSOSmJ+0eWDq0m3U07F/b1Fj4Ry8M3UNPCeNCothdLvTcuRtKy3PHSTvYZ/5aarF6FskAbgd1ZV18189sNig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3948
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 15 Jul 2021 14:17:30 +0200, Jan Kara wrote:
> On Wed 14-07-21 10:07:46, Ira Weiny wrote:
> > On Wed, Jul 14, 2021 at 06:54:48PM +0200, Javier Pello wrote:
> > > From: Javier Pello <javier.pello@urjc.es>
> > > 
> > > Commit 782b76d7abdf02b12c46ed6f1e9bf715569027f7 ("fs/ext2: Replace
> > > kmap() with kmap_local_page()") replaced the kmap/kunmap calls in
> > > ext2_get_page/ext2_put_page with kmap_local_page/kunmap_local for
> > > efficiency reasons. As a necessary side change, the commit also
> > > made ext2_get_page (and ext2_find_entry and ext2_dotdot) return
> > > the mapping address along with the page itself, as it is required
> > > for kunmap_local, and converted uses of page_address on such pages
> > > to use the newly returned address instead. However, uses of
> > > page_address on such pages were missed in ext2_check_page and
> > > ext2_delete_entry, which triggers oopses if kmap_local_page happens
> > > to return an address from high memory. Fix this now by converting
> > > the remaining uses of page_address to use the right address, as
> > > returned by kmap_local_page.
> > 
> > Again thanks for catching this!
> > 
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> Thanks for the patch and the review. I'de added the patch to my tree.
> 
> 								Honza

Thank you both for dealing with this issue so quickly.

Javier
