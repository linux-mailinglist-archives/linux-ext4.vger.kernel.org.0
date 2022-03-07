Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF64CFD21
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 12:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiCGLj3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Mar 2022 06:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbiCGLj0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Mar 2022 06:39:26 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A148C329B1;
        Mon,  7 Mar 2022 03:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646653111; x=1678189111;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qzMYx7l24Ue264v7dMmIEeNEqMVuLyEYw5sb7myDtVc=;
  b=hAt7/VULWm1T7BsSXz/V8d3dxPqjSL7o6XC0wb5apmkz+OVosApjnq1d
   3FLoTxg7cFWn1iGUWFQkRG7fS++dAtJ7Rlb78H224w7suqEK2/mH8riHu
   wcpR5GjihquxAkoAS1RXkxBOyHLWDU6u98iVMeaIPSWVbVxQmIyKgwIZM
   pRw5cXN/BZ59HXPS/j9JH5dXAqmZ0/O3aASnXEZcEr6b4MsH0I085SNZk
   yj63nA+yL+A0vk50MKnpsp+Oy6ly57Xvvuu/je69gTGf8E4wfyRyxEA0/
   pHOTJAXQInNLrEMRzt0Y/t+OuqhY+5Ax4f3DC/anQ9W/zQh5mZlX9e0Qj
   w==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643644800"; 
   d="scan'208";a="298794695"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 19:38:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JO4fmqML0PqQzshsM1h9gz4d3YNfj7NhxA2CW8X1RoMtobgmkoy1BFx6XCCAom/YJxzZXolM+j9KKQ6+EJfuZnlnzK6uE6yngyUT2x8EmP7dKAeGaRTnAFTN5uVjHXzYmRNutv2JbvYFsMYEFdbNlcRPgNve1c3Ju9RFESlb9LvqQRQN3UnxIKV3DAh6aKCogLImC7TzbcyGrcrPrXGpJiFOeDt8H2DbgzWO8IZWl9kdNEm0r5Sle8M8fs37n6OOjRF98RGiGUa5Je6V8O8S8aSCFIBClH7Q3krTn+fGVFE+I2y3UM6AYhYenUVwoeYaiUaIFnSA1EViIXlG63i4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/psgpexl0H+Tn1TYkW7QCKKOSY881CwqtA6TNpomyA=;
 b=Bsqcqsr8nFF5bJ8sqNGZrzv6OtfKYG/XfkXsNLICdpP3251atsC3aqo3Xp44FcB+w2tGKr05nQ5JYdrcaRFyZsJXMaiaq5I0wKW77Z2I0K4AQemjQyirzlXccWY2oExV/R5FPqx7DvfZFNWFVkiFOa870WPAj5RtqXBe7Mh/p8Zfr87dVUXqaaVxAvTa8A2poJ+wQbcuOwJRinaVWs8JpbvKCxJOZD5QcDb2qYS7WkLxfcB6FdHi1hoIpQmKoZJJmPp0PQvV1rDAOci+U6EfrPJj8b/RIxhgKEB5muSDk/YsQEL7ca44xhvkPk7nCxiPg/JzVrGt+ARTqCffAWS/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/psgpexl0H+Tn1TYkW7QCKKOSY881CwqtA6TNpomyA=;
 b=fCX6UMZhPVQMHDKnVeorkDOqIqXVzqfWPJo1+IMg6d5/W00TDpoJYV+y4ITxiYO2mvmoNhx9iWxUGPfmMvHyTO1Y0LuRwJTno8JmD3ZfyXdqlqmgZu7pD+/jlwTDYTbc5zwi7UeXuUEC7H3tIEhHKx6aci7TD1z5tGXqQnPoLnY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6704.namprd04.prod.outlook.com (2603:10b6:208:1e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 11:38:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 11:38:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: remove bio_devname
Thread-Topic: remove bio_devname
Thread-Index: AQHYL/HalM3iIVsQ8E6UDIHJpvJNVw==
Date:   Mon, 7 Mar 2022 11:38:27 +0000
Message-ID: <PH0PR04MB7416EF31E50382108FEDE5689B089@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220304180105.409765-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8760ae9d-6d76-4b8a-ba18-08da002efef2
x-ms-traffictypediagnostic: MN2PR04MB6704:EE_
x-microsoft-antispam-prvs: <MN2PR04MB670421855839CFDCB304AFB89B089@MN2PR04MB6704.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tZ9451MKGvwAEYMNMy2TaOlFVkODzGnlFk+ACk6F5HfWVFOdC7nmirwIS89ue/50+mnSzDukwB4xHXXsTMLXvXE7uIP39I51SSLZkhEFLQ7lMOlnOhT2Tgq3gGveN+Zpe8yzJjtsv4jQqzersCpifma5nRP8SXEZD3ely69gpjkNnmZy+zMEpycSl7IzxVhqeX+WldMeiE/XoSWwi1irrRuqFD2IwVkxQk1+3bUTruWVr9WWmR5jMYeFOzAekoZflGAkfG5uK+wU8/CKXaLu15tHhk/s8IYQcoA4KnF3SEJ4rWCR1yZA4xsvdrgnRcoAj+uI3eCck2kt50FWof7NU3y4ipd6/0zWU7ZIkQV0tcUf5oWiBWzMKkS8zIUWv3iRpooq9J2rpR5LgvIkMeD93DbRtviMAEVXa3hjP+pw8ykJMukzx3pNGNRp/FDs/1gt60caAwTV8VSaD37GfPvj5GvOBZRTw74SsIaUxHbGNtdEEI2oZAjukgNnJu01Gc37iXEHBkxMWfZfxzDUNatUia5YHzURubQqaUJ8A/MP7k4s5cRS1zU0JCE+2WBxV6uCLk6m/1+rcbfAOkEBjreC6PZ21FODzcQgfhsHS03KnhQ4j0ytYGGFYwdrKFsc1a/BEBdTpJqMVr0J2l48hmUW5JVdByY59TJQfAhQmD7QzoQVSWblJU7OapPvIOLQqOMTx0/c7yVrQyCYMY9ONKbCzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(55016003)(83380400001)(186003)(86362001)(110136005)(33656002)(71200400001)(5660300002)(316002)(4744005)(8936002)(52536014)(91956017)(64756008)(2906002)(8676002)(508600001)(4326008)(122000001)(76116006)(66446008)(66476007)(38070700005)(66946007)(66556008)(38100700002)(9686003)(6506007)(7696005)(53546011)(7116003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+rgAAS0dW1bhRVsud7VuPgFVuAAMTxlHbl8awey/Otxr8Oq3UnTdxORYw1Mv?=
 =?us-ascii?Q?VyudxyjDpeQCZtP1TOCYsiGhFTrcMoAYyUR4zlbIAiHA076J2lQJvPYDnQA1?=
 =?us-ascii?Q?J/VixKhBg7YQmHVWiO45b0q4RjT4tnmR8cxhzMhA28umy9d97Re+b1vn3G7p?=
 =?us-ascii?Q?b1GWC9ftJGfvkoCxFnYv341A0gmcXD3V+1yHASNIr/IyfmKN6W7pZ4KLybM1?=
 =?us-ascii?Q?JwpXdUqlPhX7iiOiJPCWfFl1IJ3eRIfauoZufwrFXRp9EIejOBLvcHvV7kqT?=
 =?us-ascii?Q?PaglLPJsHDiv05FGDWXweKLrlf5BtqCM2MRu5Hl/2ml9lpNUV6TXwXsg6SC3?=
 =?us-ascii?Q?pbQLyvX88rB6NuPbD0J49hpcMs2qvcuSWhM8zuNN5Dc7O60RWWm1v78QsMhA?=
 =?us-ascii?Q?TreazZLW6l6VbvYrtEsWvQNVu8han5R9qOzYblBNiO6kbq6RyeWCkcDeZYqp?=
 =?us-ascii?Q?NsPyHiym+BbrWHAr4s7q0WIhXEiYxnOLZdBB20gVVmB16+loIR3vNBxPUy1V?=
 =?us-ascii?Q?tk40DILzatJyd/6eLpUKBrzTqkZ82qPdNd46km6ny6LOwhqABEK3UE2msvfZ?=
 =?us-ascii?Q?9vMOsgCvU3/7Vq7i9+5QCHA1cVY7Fga6fJtWeAKTAfirznQWzGl0F06Yd3kn?=
 =?us-ascii?Q?Pt8hfGZ07BbfZeCZjFiT3T/Ndg2QkeL/a8QTSR1ZPwAleFGtUT3c0SiU0dcX?=
 =?us-ascii?Q?+5L/swNTcVlszJyIg/GpE1X+G7D5k3dW/ukCpetI958lt5PJ3CKIMspwOGen?=
 =?us-ascii?Q?1oloTBI5eAMlvwzAf+20AgIDuvwW9E8bic/xRzFDU9zteVaxvVNO6L1KfLTP?=
 =?us-ascii?Q?c8kuxVP8BZIeWxzkStDwEoHdvwg1p5jb7zQGFGBxTmYa8Xnm7zRY67lvuyNd?=
 =?us-ascii?Q?VFhPghqd9skJO4w+585QE67CnSBbOvnO5PoTl7RGFl7gilKH7kPspcV8IqHj?=
 =?us-ascii?Q?75Tw7SQ4B9urkgZlAm9Qmkk5BcX5s/Gw51LVO3SSSBDsgKpxuQkNzROfq2t0?=
 =?us-ascii?Q?BrROZ2k74ojSUQXVPci/xAMn73DIQ8AnnbyfTwxyhAJIb0cjAqoQC1Pf3gV3?=
 =?us-ascii?Q?3NB64QmWDJAuR2KJ/SrnsphJN32FQNqlgiMeuKP53HByItPzPY9Mhiag5Lxd?=
 =?us-ascii?Q?h7acYeVlu8e4uOUqJK7kglO7yn0DYIv0R+hVHfBWdaId00HH0oO/4F3W9XuQ?=
 =?us-ascii?Q?EHX4v6a8qS4ErASPOfm7bE73DH+maWf6TWiK1oCJYawLMR1JHEi1msluklyD?=
 =?us-ascii?Q?V7Ya6UlHAF5vQx78lEU1mnjIZCm9MtSCPRAFjIdsn1sTKAbuPNNMMPb2kwzI?=
 =?us-ascii?Q?qE3T6KkuBfBnaLtHpzk2VeDVSpETxnrZ+l95bo2XQW7m94+cH2gaTZb2viiM?=
 =?us-ascii?Q?k7PYfvBrwOB4xweKQCFCsnNQGodqjPy/qFcnPEFXVRy3My8PKzIl2FhRX/Y9?=
 =?us-ascii?Q?4RViFd1PuehvieKhiNGZ3k+eoecBmHE8gWe/cz6+zbKMdyYm3iAPTbjSIALf?=
 =?us-ascii?Q?LBSryrdSZtGhzXSEAIszaVNQ7mHHD+pwPHSqWfky02cFoIrKmwTlaYOiBq2O?=
 =?us-ascii?Q?P+iNOqxcaeCwUTNFpxOCk3Q8H0NCuXViM9z5zUn1n/Qkvk1+xxMfcoehzicM?=
 =?us-ascii?Q?HJzHJZrHTZsQrNf8dASkcC4LCYJif9PxRK/KqhRxNA7HNcgh2bNay21Gp3Y/?=
 =?us-ascii?Q?qIDO7u1PYItfAr0k4UhArNWnqVilSZRlCejEe3Fzu4AvKG8ymUzUeZ/3o1dj?=
 =?us-ascii?Q?cg7B89GIIq2s9gdK/yoPInSwD4SVMpY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8760ae9d-6d76-4b8a-ba18-08da002efef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 11:38:27.0600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMvFTy65qTq4xL1Tv6aN0V6gjKHLhMMg+CwdyzVQJEB3t5aAFTY9q4EBsWnDvoJu2tRzYsAmvfhGS19CxQba9jsDOW6ngd8CuoDqWJugHtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6704
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 04/03/2022 19:01, Christoph Hellwig wrote:=0A=
> Hi Jens,=0A=
> =0A=
> this series removes the bio_devname helper and just switches all users=0A=
> to use the %pg format string directly.=0A=
> =0A=
> Diffstat=0A=
>  block/bio.c               |    6 ------=0A=
>  block/blk-core.c          |   25 +++++++------------------=0A=
>  drivers/block/pktcdvd.c   |    9 +--------=0A=
>  drivers/md/dm-crypt.c     |   10 ++++------=0A=
>  drivers/md/dm-integrity.c |    5 ++---=0A=
>  drivers/md/md-multipath.c |    9 ++++-----=0A=
>  drivers/md/raid1.c        |    5 ++---=0A=
>  drivers/md/raid5-ppl.c    |   13 ++++---------=0A=
>  fs/ext4/page-io.c         |    5 ++---=0A=
>  include/linux/bio.h       |    2 --=0A=
>  10 files changed, 26 insertions(+), 63 deletions(-)=0A=
> =0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
