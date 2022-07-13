Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29E7572F32
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jul 2022 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiGMH1y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jul 2022 03:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGMH1w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jul 2022 03:27:52 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4481E3071;
        Wed, 13 Jul 2022 00:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657697271; x=1689233271;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/kMW6ONtDBqoSd7W/iLPpOsHAIliObM5Zf0xwkGrEac=;
  b=UFYXdxUOj8SP2Afe/cOQss1SOHX3aR84E6TRLRzu2KRhecGOVPVDSazm
   osjQvyyDWCwvPN5jzB01v5vv+F/2JXoneS9/pHI0Rkf0XoL/Z7RRh4CQb
   sSGYUcsAXZxSKgf1tM3Jjy/vl1wgve+c/B8F3TiTj+lAaQmOl/Cm0M9mL
   TZD0bqIJuQdGd1U/D3gjhZO9lGGSEmyAAlEKC4gOPiAiNegi7JjMHjyLb
   bDreVtSnzJqJtn6FTQqMiaqMxxOVPZFbO0XDAa01pWK76KwZJ+gG0c0tk
   kCDbhbVWsNzi/XPdEsiEPR4FyXX4M/jgcud2TcIrnGSoQAD/lOVd81H/i
   w==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="204216986"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 15:27:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJ2cWGb1PMHfIkefC8PlapLmobkb5ZQqID98TDq2Rx4O4kEukKu92QIyHLZiuAFH/u+PH/ft6wgRRfRJP7oxxCd1SmcTx2EhI2ToCCraK98QWtDemdPNRGGgJfZcYNAC89VnX0QD9WqAZNFy4KZnqTMoELct8VlBWfsZJ1Zu+aHD5R5YXZnoHATS5kQdcy25zMgWqxHpOplHsi8lTIp4whfX9YRiKGxcSTEvly709A+th3SHtlh6tOBGBYcmHXzL+FWuJJdPmqItD3hbs0ChjdCB7kGuijsJWDgnV2eGeYM6QpVCayAiDBsxnWp9hG0uDhuxe9f/tm9Cud8A2dsdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kMW6ONtDBqoSd7W/iLPpOsHAIliObM5Zf0xwkGrEac=;
 b=MDQvzwnJ5XvoeEOP/fFuI1zGKn4l8V9BbbjpuOco6W2RLqPz+dc9x/wf5xaED0nKg+fEA+aN1sYJvo8/dLgtP82/EXZG0aGm90lMqQhe7WqyiTnFsS4o7GSq2PZfUn43hucUuQjUw1WGJ6x8CskRxIn62TaRxldKM2BCIJajNI+aYsuM6A59a3aBLayzB+En+XugisPwvxtbAK9nhn9a3uXRhTgZLb+oLd4pBxjFxPpvQqjApDbouEuVXNgffMp2iQlodFCnicvLz/6X9/E1ya8tZ1zskBULj1YzzyynfqHKvMlFIEzyb0b8e3RS1b7adcXnpSSijb424ga0Df/RbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kMW6ONtDBqoSd7W/iLPpOsHAIliObM5Zf0xwkGrEac=;
 b=Tm/Bub9PDzQA9j2DbaH6JTqbFjqUvYJoYsarq14QWgUoPlFTLkJRG0RS9ZkgIoQnGGJYVBBG/08iilhJzWmbHXijsA45Zr6Z9+cvidmKzBuwI430E2NjCV1gpUPfSBaQasgtdcShDv+aGvqcktr8p+3KJsuxRA1HxOZd5xQ/G2Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR0401MB3588.namprd04.prod.outlook.com (2603:10b6:910:90::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 07:27:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 07:27:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     =?iso-8859-1?Q?Christoph_B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Song Liu <song@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: Re: remove bdevname
Thread-Topic: remove bdevname
Thread-Index: AQHYlnzqMl5ChJweqEC+p/d22IGEHQ==
Date:   Wed, 13 Jul 2022 07:27:47 +0000
Message-ID: <PH0PR04MB74168A262A3A77D111C21B5D9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220713055317.1888500-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83e20a89-8b28-44f8-85e5-08da64a12fc0
x-ms-traffictypediagnostic: CY4PR0401MB3588:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 74QtiK2VztPyb+2yguS0HZ6jxKV62fTo3E7PygBFrfxeyY4F8W7CKaTcqTVS4HcO0+RVSjWbSEWQtx6+Eeh4isAtG/TjmCbsCF6TWKlrJhOl4qkx77K4h9ILqEgJdQAhPVydWuJx1ZsXsVZlpQ6Lz+kNzWkwIhcqKijWiWzX/NQzY7QWrA752ZJyVim98tDhD7neU/5fNPOF+YeTZhTxTOGF5LMtHijk6BeliBmx38Yk+xP7OwaliACCnXnstrxsJFoBG+eCzEQH6s7yQoGszRof6Eki7pE80fR8gqJ8eh3RCx0ExRI46tkHw5P3Y9e3rlESDDCo/HsJZJ2nYQlEnhLYoHvs168sr+P3Uri1TJVF1nzxjlLcglwf57PJv4f5tIIGALJxyNsiaRnxWr6FmV0wb9umlUKFuFW2UuFTpt7JQqteWBy5UhGVJqk888yR+PoJzshkc35eDtL5e7PkVOrRd8Pn77T5MgjMZD/A0ADImi3ml2QR/ih5swe+8QWX1gmuQkPBU8WGVMYD7qvtaZhDJcv/b2tjGPs3SUp0nZx9De1bARprZHoNP6Mew9OA6gGX5GSyawSOWY71aNyUMv/lX8Y0SWfdFEk9gGO4i+4rC2IhmjbXegR1oakfWdN7EmznZGHCrJja/QN4MnM5u7hiNAsJQ23qy6Y+FFM+TJXJ+gCQZqznAbPPsOkUAqfk6eYLf6QX3GROzhMnv718AU3nvZRCo4cJeI5nJ8SAhYaYwPw7GFn/GFgwTaZLrKOykkOsoL8sgBSOPGJ3xcMYxmhmcni3ysuJEf0aQfhZehGyUcr9fCT72GQCPluJsatT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(52536014)(4270600006)(33656002)(8936002)(19618925003)(558084003)(2906002)(64756008)(8676002)(55016003)(5660300002)(86362001)(110136005)(66556008)(91956017)(7416002)(66476007)(316002)(54906003)(4326008)(186003)(26005)(66946007)(122000001)(7116003)(76116006)(478600001)(41300700001)(82960400001)(3480700007)(71200400001)(38100700002)(6506007)(66446008)(38070700005)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3NdEf3BkWP4mPQ2KR0lCV9HNC8EhII1+/cneh4Y7+O9d14AG13/dLZpoq7?=
 =?iso-8859-1?Q?EBBJMXi9NXp/SkoUK9xpAp92jHZtRoxQs842PMjt8svbdzxpzi76RClRUH?=
 =?iso-8859-1?Q?Ofq14zTqNQ3GZW89G/Vqxcpe5Qz0pH6zUQUHyEdk+1giqEJB1ZdmSWmWPu?=
 =?iso-8859-1?Q?wek51Bd89QGBPHc9TuGqT7IBC6qauBn6XlD4sv3jREDL2Za7umQSXR4l9X?=
 =?iso-8859-1?Q?3PKbrumA7NtI7TPM/51j51ZG007gp38erZ702cyjvJTO0V3PUp4rPRbk3Y?=
 =?iso-8859-1?Q?qORajEkPZurJyKISPwij4zGpOpjLYgpppwxmh3E40lZGN9MkAEoSTd5SZc?=
 =?iso-8859-1?Q?G6nOZCIDyQWMJWRiVBEnNJoRyRwIxPOfP+F6Nf/cLgMoRP64HHumjuokKM?=
 =?iso-8859-1?Q?Dwy2Gyt0qbifvuDPyAcg36eIu251hfDpB7hugi03NkbhGOL3NLKcYJSn49?=
 =?iso-8859-1?Q?z4byfM05bnuAOS+d6jy5FBtTdm+G9VzZYIUhWkp89EsZaZbyc4o6hp3gOD?=
 =?iso-8859-1?Q?jeQzJA0pG7oqDudky7Q5j/kDYl3TzptvBT+vHG/2qQBVdmNtDC2q04Pnqg?=
 =?iso-8859-1?Q?pdkme60H4CWVnj0j75nqeIN+Lb097DlU7FQ56Mov7ezL+MIRyFswtgBTr6?=
 =?iso-8859-1?Q?4ZJtJO0p2WZwPoqiBbibmYJ4L3aBZvENATXS/+5cifDNacub0dp+t6yCsT?=
 =?iso-8859-1?Q?sMmVQKdW9PuNjQJ67fE78Tk5PalLxnqhepPIj2sKonhMYYlTwsAQ0BGYjZ?=
 =?iso-8859-1?Q?pvSABGtoySsgAL0JGL9gKpsn89azjvU8ClQN/lVJr0kcXTbwxWHzUU5l6Y?=
 =?iso-8859-1?Q?yHfvBNfRbQ7OioPSuV/dPgwfdVQdknkot363s/+bF8G9SGgJ1C3p2OzsIf?=
 =?iso-8859-1?Q?q4vi4oGGnDnATr5XZitBPNY2C9TqlFJrNMiQgheBFDVDV/PQY0goeJIsQJ?=
 =?iso-8859-1?Q?0esTcqwkPb+aPywmZyAtJCXLWCjm73YlOHQsLUwoQeNPgL5eHLriIBFfIb?=
 =?iso-8859-1?Q?SDoY2sY/8MfAp4dCym5GA9WmRdsjU0poFnAiChJITpPjP+hvDYFnxxKN2x?=
 =?iso-8859-1?Q?6R4rwCdpmRsGCpeHUcvmwxsPGbcapQb0Co6VMSDpnJFvKdp3Hy6SKu9Np6?=
 =?iso-8859-1?Q?oYFd4XjfP9+yBXXBjl89w2wk3rV3JG3KaNFX6LqpCJ6kaFvMjplcPZSTmo?=
 =?iso-8859-1?Q?XrB5q5A702IfCEdS2ZS3AbNNf+KUtxELrl9QU8AnJeKgStbSWfnOXTB2E4?=
 =?iso-8859-1?Q?SiUadUTF/Lz2F8bd/+7mbvF3lniyHY3PIN2qk261nV0PFvY3lxOVOTI4ug?=
 =?iso-8859-1?Q?vS2v2V36y0MYJfmwQXolSdTiixmqcTej7AIMd4im6SenyFMbV2cOrr5FBy?=
 =?iso-8859-1?Q?Ox1Zz1KaOxV96d0kLEpwyYrSRwY8WmBduwgj/w+tXUo54/6tTdg09NE6Iv?=
 =?iso-8859-1?Q?ydoWzKihZX50z+2X+pxLZY/j7aVehDq+6KKfZZIHa4eeEQ2jz8zPuwyIPX?=
 =?iso-8859-1?Q?A57H6rJYw3THMQ1xpCs1zhMhMmuzgMcKgVPgRjVs2IphrxP0M0iEODoOAO?=
 =?iso-8859-1?Q?S8/WVLB810IfVbFKc3qSciQbjo/IXF/orhmDCjz4GtjJCPilP9HTndu/hU?=
 =?iso-8859-1?Q?y21l3Wp5dTnjo4GaysDiXxvsu4psqIIg7I61LW/JxP57ixI8dSe9JvtruL?=
 =?iso-8859-1?Q?IOlfNPY+yjDADGcNV1c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e20a89-8b28-44f8-85e5-08da64a12fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 07:27:47.9693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1USNg0u3m1sc/+bXfjQI5YyC5Lj2XibBhghmEgwW7vFv8K1dG6Z2h2ZIiUMNYMbT4NqHwtZrjkhnbGNcT0tI6ppFcg04XxTMXtFOZjpjDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3588
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For the series:=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
