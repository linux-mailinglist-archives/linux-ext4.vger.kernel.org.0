Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB594B7393
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Feb 2022 17:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiBOPxw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Feb 2022 10:53:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiBOPxw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Feb 2022 10:53:52 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB0B9E540;
        Tue, 15 Feb 2022 07:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644940421; x=1676476421;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=NZbW0hsObTGlJUDBe7NPeSF8f8s3Nd9++vvb3nzB1bh0Re4eQWgrdsLi
   tDcNhoCzZKdyft32qqkPASwOhvGqXyCe7PEv0ovJf0fByM8qU5n3Z+mfQ
   2Tp/6IGNfgUxwpUp4GGdkE7jPQHqdU0yYMtUUmvjuUemGA8taJEOAnxBm
   QaFcAk+VXYqVNa5JL9U6E6p86lHikXjyUje7J4xR/JUoEK9TKkR6Lzkg2
   QkucgyyOM0rtlum9gUhQmnQYJb/zqwc3pgf4YRjZcvu8Pyg1V04wUqT2f
   JpExbPuV8dzaJVsY2AMnjqtXMX1F5jRwtCPG+IN60CV11gH2gwg6SwJo/
   g==;
X-IronPort-AV: E=Sophos;i="5.88,371,1635177600"; 
   d="scan'208";a="297122784"
Received: from mail-sn1anam02lp2049.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.49])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2022 23:53:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hs50b/kjdvNYNs7K6GHphUdzAU/UXOgwU5McdNqY/JmQcZM5SRbnLxcDbH7287PJGD0+SlOVxKz6M4x3D6ZF02ziD8Bj+RkF6zRW6Z008Ox2Sv25+h6NGx4QeP7C0YIJAlMY5D5H8AnxqWPXBW872aNRTKENnzvgJA+jXOG4192gqioZhd7x7DhAVRs3kkemBfE/PytiMV6MyEaWJUhAtLtEEeivZrp6iHbtkZNqKQIJX5s5B3dA55mczRzCbHjLVya0ZDxdhWP2xFbdZpEfEQ5+Rqkyi5OXIUCm8vcymZSPDQ5OrrkR0w0t0HJBKupLvadQCWyaX8iCIRUgdem/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=byHysSBJ/IXHEIAjQUqS90Elwn8M19UYeDsfmYiGAzrFVxJQdUwBb5FsQ9qzuwwhg3dOfepuFLwAtoJ52m8ncJcVjUpK2Fwyhziv2pgfouC+bcyg5+gfPcq7Pp8KOw+Vc8uCX5i7rRv5ttjT0CJzKMzMB49I1f4cqDFS63E/irAOI9qyxgB2BS8GC8bufsXFlSGmC3Q/IAE4q0YMFJ7Jj187aEZSqXqhQUkr5NqRtTA19NE0h9USLn0Dwi1b7uo7GCJyFZOmO61R0UMn4qzcAvOLvPd5zSHwg1OXW/KYl6+x+ZiX3BNJPRHmmP6eI0vWaR0R8gci21eFNA6rqUHChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Bm1MzFWETDawoZQ4jB4CaIOH6dqXqh1QI4i5YUBM4bi+ruQ/rwvaz8gYxDwH3HWed9zE8EFbiSZgD/iifRqvDO7Pz1syQLtfPif5W1JmTFRkggCTWEL6s1pRyO2EZWJonMR+xhgq6cKJ7HYqiDrZYKhEpIpFBls4/65yHc4/QQk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8115.namprd04.prod.outlook.com (2603:10b6:610:fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Tue, 15 Feb
 2022 15:53:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 15:53:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2 1/6] common/rc: fix btrfs mixed mode usage in
 _scratch_mkfs_sized
Thread-Topic: [PATCH v2 1/6] common/rc: fix btrfs mixed mode usage in
 _scratch_mkfs_sized
Thread-Index: AQHYHbE0AJFeIA/QkkuPACCyimLepw==
Date:   Tue, 15 Feb 2022 15:53:38 +0000
Message-ID: <PH0PR04MB7416AEC26BF1645BDEE557749B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220209123305.253038-1-shinichiro.kawasaki@wdc.com>
 <20220209123305.253038-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d75a2219-3db3-4355-e70d-08d9f09b54f6
x-ms-traffictypediagnostic: CH0PR04MB8115:EE_
x-microsoft-antispam-prvs: <CH0PR04MB8115FF3CD5246E6E858189AE9B349@CH0PR04MB8115.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u1xLT5x6DVUzE4jIm/PbordfBn6l9owtH7Po3ZZwnf3qBxBsgHlVGyCKkUqrY3g0Md3HMiQFZFr7avgi9640bNMmLnGEy+kwzG0J0oXfCMHDqZwD5NaX9kttEKMlNJXbWwBBCv8nrjL2nNwFnxfGKq6Tapo2WIkD3zQQAn4mSbRTQ/jAear2hYpjx7QGVOuZs/emp2jzcdPRGSYqMdBM011Wf3AYp+uOG9OfxhUJTqKpto8HWNGuArwK6V5KUejeGhnvMd4agfdt44yjjGTGOdnILwxGJPnNEpDk4T07x14Kgd0udKPRz2QwKs8tW5v8R30NcMUqie6ojEvdYMeIRx7bNr7LzBA1acg0nixvE7avQXNiz72WD+9spHJpe4BT6eBDF/i5of3IE0okc5ZJoSbsG2HfvSIZ1NcH/UcjoxrURLoAKlinlhg6AgTzHEInvz7JbP8U1s6wOGdoE2xclR9K3sMh779XFdLake6DL/OK1phgCyDEyzJVbajPiGuJ7qVqgchXR3cmYoRR20Aqfjzr1mL4JauDvXd5NXGTAkDalQ5eRNdFHZktQqTCc3tQwoBL5U+4KfOLAEFlOdZAaPelt/jceW/3nUbSxT2Ml4g6W3CaIrvKk9rXswRBrmBlUgsGMfcI+S3t9Dh0DlT2OUPy4zm80wFd0gRQShJl30smFPmpYsMwj6kDc/7IFBI52rmCa5n/hz5lC309IBvNPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(38070700005)(55016003)(316002)(54906003)(508600001)(110136005)(38100700002)(122000001)(76116006)(8936002)(19618925003)(9686003)(52536014)(8676002)(91956017)(450100002)(7696005)(86362001)(6506007)(4326008)(66476007)(66446008)(64756008)(66556008)(66946007)(26005)(186003)(5660300002)(558084003)(2906002)(71200400001)(33656002)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LJpUd6GS2UL+2w4zoh398E8eURglAwsstvtOiXPP0smvtZjm8GfamyXiQVld?=
 =?us-ascii?Q?Ja7LaIuIzlWeK1c+gS5G7pSMw6hV/oOr3GQrkgtq0IxVQ/k90h2x58MBMu8U?=
 =?us-ascii?Q?uujk1idG6guqf85YgB/RrLhHxPBqCz25OjAqZCrYqOUG5yXi/odqjzO8eceF?=
 =?us-ascii?Q?cG1qhMc0Dbcobu4efqlDgVMLdtUoNuzSddu+iQFX8Hi0rwAb38oTopI7nAGm?=
 =?us-ascii?Q?DUdoKPsgdrGv8JeIliS6d0WK+rhu2qs5qSDFF/AZV2A91YRoODQmyeMo/nQQ?=
 =?us-ascii?Q?NQGo632ri/iTczGXIyT8WYovZ7UHBSzCjGkk+mKt36cJLHJQxEWp9GRjBu6/?=
 =?us-ascii?Q?rqryfcFKQvmrrAuL7Fa3bxs+xjqvVLOX15+Ki5HNUd5wnT+qkn0FmuPLoRF2?=
 =?us-ascii?Q?kW7ZBwQ5fnOYD/5V8t4bNHd5P03ptQBW3T2T01rGTcUA36UaramHam0gIoKx?=
 =?us-ascii?Q?BKURp+QQuYRtif0xjWn1/e+CB7F0OIINGTbc4UaAi1v7VtjEDTBNCfjCPupJ?=
 =?us-ascii?Q?9Bf5xffdjUKvdIgvksinRbtj7RXtmlzNrdKpdEUQNQFLrCnl4T/FAVG9r/xC?=
 =?us-ascii?Q?A+poby1XenFIHn9/qUUrUjHRgVLzIWHgf9vGhuyxSMkPRaDIBhFhCj0QE7Cg?=
 =?us-ascii?Q?sPD/sxy9AfrH4t7uTDMG51+Jzxqc4sK7f143hpTj66Sw4uUlLOjBwkYdRax5?=
 =?us-ascii?Q?FjjITtyLHSR1RWv0YpqGhRRj/16i8KfDjAu4jV9ABjNEJIe3hfmJMfNl1SYw?=
 =?us-ascii?Q?+JSHIOI307cW11/46TElvHVAW9V7VHqeVWZBctCMgesq5u0ddNwokfGkszlJ?=
 =?us-ascii?Q?n5WxATE/W5Aam3jFPF+ocV73ZCqoR46GSpx33ZtZQlhezL9xT3oCgOA9We1j?=
 =?us-ascii?Q?WlZNXNz7JUWp9QURjXVf0H/S99F3KVGXVFHSvwiwXrVK3IT/fcU1wUepWSDt?=
 =?us-ascii?Q?bjeWnN235OYfpB/zfXhbuzdLlA5AKzL5grhqUnseKZBpMfr3IvVnCNcnJRQT?=
 =?us-ascii?Q?qJzwUFXyhx/0QCMoaU7vL3P8Bc/uOMOzDJV5ZzqNepVmDWY3sUyI+/tb35xo?=
 =?us-ascii?Q?gaz34nNrK92uuzXfjeQyD3Ei2Lt3AIOj/91/SP6nzaz0enxbSH8SIdA6mSuj?=
 =?us-ascii?Q?Tg5ZY8hK3EStdtwCteLFtiB2LnbjRixNCPllWEOUJtLwh8ILKbuAwVHm8CrK?=
 =?us-ascii?Q?Ixio9jMQlSFOU42xRkdCEblFsaV+F5PdEKUL3JXmH9FSGaC7GtqcFtfEkvD7?=
 =?us-ascii?Q?K+rcWUGy1ooTMLRxEd9fLg184faNEvfIJC7xRAxnLkxcOYlEjgeJDiMf0tDu?=
 =?us-ascii?Q?2j6LxQ4bc/2dGF7QVlgl5Kj3Y2FwSifIr9XS/vXgdci8ylUgP4Qy0F+vAB36?=
 =?us-ascii?Q?CvhX8ohaTL4VcBJ0L06a/L98Pj/7jGA33g52wKoOjdkV0Ae62yT6QVw+v06y?=
 =?us-ascii?Q?N9FjgUACu6NO8JYoYxQ/ld3KKfLA02PhIuEC0Y621GZK9NDeByp/xVV4ECgd?=
 =?us-ascii?Q?nLV+8UUfbjRpzMnTgVMn4yG/5exBt8/vi5icoHILVTHiSu6CzGhvfTfVb18Q?=
 =?us-ascii?Q?t70E9+PZwdA1YzNVEVrZHrGic1bPHtVeaWRFXaoAXxu/WX8U3OhJjxWyX/DF?=
 =?us-ascii?Q?1FzrlaD09AyuO/Yj9vPxESCnVZRq7n90WaBvEICEmxQAoxSyUyRMdePStWIu?=
 =?us-ascii?Q?zmbxuyzdRKH5R5iiu8/7ipS/37E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75a2219-3db3-4355-e70d-08d9f09b54f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 15:53:38.4294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzswQtY3JwUC7vQy6iui0DxV4XuxUHb6P0F66VF0Czc3OdOR5JCobCqnwAPbfrBg6bTegM49jn+KdbasAbgt3kBA+fhflWk+DE4+EwXloVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8115
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
