Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E27BF67F
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2019 18:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfIZQOo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Sep 2019 12:14:44 -0400
Received: from mail-eopbgr730087.outbound.protection.outlook.com ([40.107.73.87]:7218
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfIZQOn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 26 Sep 2019 12:14:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by1WYTvxS59ueEBaztMandpivrZGElkoNhDS8p8s7XCGGbZKIiFTYo/JdR926BYdswSBvEa8IucB9j6BR4VcuicmGMszH3Gy/3lyH8htaimpoSesfSwCXIkec7+wyluue56iXR45Nd/mlpGlSDWBu6MG6Ur7zDhWX8HdoCPMEKmIideFwfdknr1B1H/rQ+DfBbdGCt1l8z/3qoy7H8sZ2tfhqgwa4dWdFTlInDcO5k9rXfpqgRAzDKF79tVZZmliodxsNqOoWMKeUUpygPEKp7UtrkgazvUP7D4uIy/VYJVik1flqm0jo0Po/oLKdkFqoQwxJH48P/4dTBfkKpnxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjUyZbEjHBV25Sw3JI4Qa+wbYhiWfOjTSfdJDsGP9Eo=;
 b=Pp3oABXtvQJ3TF8f8Dsx3zLA1TbZ32en8m47UbE8xpQabC4nr8x2eKF5zC/WMXIR5V5kP9/ycIM4cvKDa0WJo3F5TjZUfI8/LpTvbtZDigrzZEFshRuvMs2pYA8bA0yiat898Yi9DS+n3kp1Dlgm+jCYbOK36egwftH3zvrIJ6UXQ02zUjk3WGDaVwn+z6XnlSQfbjYrIOYrNf8waQiWjmsrcxfbTV7jm0KHRKH9h9yE3LcHRyhI7XISlCU3YNboYAOZooXyYJDeW+l8RWx9gwKGlwjWfT7oCOg92AqxUdJPr0IOepl5eizDg30HQ0Vcf6gjQCmFI/9B0KUOtU0xmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjUyZbEjHBV25Sw3JI4Qa+wbYhiWfOjTSfdJDsGP9Eo=;
 b=tFdL1HuWPmDdulKP/YShtscSCdnRIgSvRdnvL+xnAUcN9iZLRvvNbNbcQhGWywnpdfEit/oS7BBxjirnIHl8/s8M7zUCMqmb+TsHmqW5nnbQQTh+9CIvCSTgrMr3e2BmSbS3bmm8X6MU55FOyVZgVuTLW9SgJz49U9jLntPtxsg=
Received: from MN2PR19MB2638.namprd19.prod.outlook.com (20.179.84.18) by
 MN2PR19MB2733.namprd19.prod.outlook.com (20.178.250.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 16:14:40 +0000
Received: from MN2PR19MB2638.namprd19.prod.outlook.com
 ([fe80::6da8:5431:51bb:cf68]) by MN2PR19MB2638.namprd19.prod.outlook.com
 ([fe80::6da8:5431:51bb:cf68%6]) with mapi id 15.20.2284.028; Thu, 26 Sep 2019
 16:14:40 +0000
From:   Sebastien Buisson <sbuisson@ddn.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Backup with encrypted content
Thread-Topic: Backup with encrypted content
Thread-Index: AQHVdIWAJ6ykQjjRP0eJq4GPQXYujQ==
Date:   Thu, 26 Sep 2019 16:14:40 +0000
Message-ID: <7B215AA4-7356-450D-AF24-A228BC6EC623@ddn.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbuisson@ddn.com; 
x-originating-ip: [77.147.201.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2b82a2b-6d7f-4ef7-c807-08d7429ca2a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR19MB2733;
x-ms-traffictypediagnostic: MN2PR19MB2733:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR19MB273359307EA85DCD5CC92225D7860@MN2PR19MB2733.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39850400004)(189003)(199004)(6306002)(316002)(6512007)(4744005)(6486002)(5640700003)(14454004)(3480700005)(71200400001)(71190400001)(305945005)(2351001)(7736002)(5660300002)(966005)(6436002)(66066001)(86362001)(99286004)(102836004)(2616005)(476003)(8936002)(6506007)(3846002)(26005)(478600001)(256004)(2906002)(6916009)(36756003)(25786009)(186003)(2501003)(8676002)(66446008)(76116006)(91956017)(6116002)(66556008)(64756008)(66476007)(66946007)(486006)(33656002)(81156014)(81166006)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR19MB2733;H:MN2PR19MB2638.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vtaWWPNhB9GHy3cErzgz9O/6Vlq/jFaiy16KTd7SP3ySGyoTfbB5OdWE26eQnuaayNpugPzuKe8hqcYALeF2UWR76tcR+jqm2to8aU3W2/HNeAh4fjfL9GRuRhq0LxNQYGhPMaeFQqz/byPp5B7xT2T+1AmUAd898L+8cIIHC782eiROE9oVEyFLWrbptTYTWSbZalAE2/Zg6hE09uwekj8rGJ9zMSvvmT2kX7EOvl9KKu/8EBUHOufVXDSxnjikuyu2tEdjwRLy46w5fiwdMJkN3pUGQOkH+0enIVhwppuj/VDhYyG5+AGB/xnefkhFMX5wA3Jz60JEq5Z1Tp7+BQ1jhYWtHkEVmQwrL+ZePU3qBZlme4SaHP5owIgOeGacJrlBfv/zzmR+LEZzpvQhhQ8Hk0Z5v2btAuo0MZ6EqG1BkfagtRGWqq8cnsQS8mZQNZlCsa0wRvt06yQkCkQP1w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DB67F5A4A21E34DAA4C58FB0D3E6289@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b82a2b-6d7f-4ef7-c807-08d7429ca2a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 16:14:40.5782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+35XDJPpOv7KbVTVJq1/ViPKsiVAp344jrncfI+S8Os6ROWRKwGY3SrfLNJUHPisvj/6NCQEUr3Z1HdKjW/xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2733
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I am currently investigating the possibility to implement encryption for th=
e Lustre file system, thanks to the same fscrypt API that ext4 leverages.
During my investigations the question of backup was raised. So I looked int=
o this aspect for ext4 when encryption is activated for certain directories=
, and the only mention I found dates back from December, 2015.
https://marc.info/?l=3Dlinux-ext4&m=3D145030599010416&w=3D2
And it seems that these patches were never merged.

As of today, what are the recommended ways to properly backup an ext4 file =
system that contains encrypted directories?

Thanks,
Sebastien.=
