Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEDB1BE8CB
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 22:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgD2Ujt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 16:39:49 -0400
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76]:40225
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbgD2Ujt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Apr 2020 16:39:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSATTg0/PNu0aGTjO5TBrIK59T/e+jPDdJ67YPIAbfGtBlxrDMc7SQoe64q7EUE1BAHhGa1nITUMxVplndjUOj2lkXNYcCzch+dHBGQ6pTBx5AgbplKC+Xz/eHqsgmYjicBkxKbCc/yza+CkZ/4UhD/jG8mG5CSqWTethu5OHhL7nXmEkD+M304PriwqgpbYmXq/bC1w1f5Ayjm7yaD3S1O5f4FxcH8YdTD1GcBhnh9/d2GzU5noEs4e27VzLKHlom0Rn4T4A8zqegEQAmc94GwQ0dVGum3VnCRJQ0wTZmm6OYcaB1Qh5AlDi9Pv5FxwnWmbb+K64GTq+LrclKALwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhanQYNEmuBjbcvINItKYXkHoZ4KZ8rBjucaN69JGdA=;
 b=hzV390U7RRPyPPLaTNQRWmWvtmZ7LNFZKgLmq57X7e9btjDOJrCSaLXhlXYM2tsSXHzyk0RTnGqZPVNeNxICVxVVFC/NPubY+8pudAsxlBiA56mu4u+o8WBmWvkyRygRdYpbu7C1gEsLOXpUa1oX9GJf9qML+nT0cFi99pNzZAQ+x+jYKMgrcPTY28Ru9w+04rOLQhwEjqUez/yuCHJQPqCsUD8eHcVaoDYs1EVEGNfsgrZUMRCEsKB4s32Ynzpo06nchAbg75kbBoh2J4lGMIOe8/Moh3hVaez7/X3felkKONIY2zv5pvCwpFuQ9FMfmIf5ju/5+wsVyEXX6yiUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhanQYNEmuBjbcvINItKYXkHoZ4KZ8rBjucaN69JGdA=;
 b=1fvjOtptVJz4lD0TW+IhFlai+i6dlSPux1dOroa9su0PLpmXJEqBHdQTxvFVoEJ+odUCvBaTQTCWbTOeVZd/1h/m7ti12mPRc2bJyrnuzxG3gVHNxC9pcr9IMkykigMBcyNEcbsYMJ6RgJtTV6IHKzC2DrHlkKKx5fEOhCh1bMg=
Received: from MN2PR05MB6381.namprd05.prod.outlook.com (2603:10b6:208:d6::24)
 by MN2PR05MB6575.namprd05.prod.outlook.com (2603:10b6:208:e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.14; Wed, 29 Apr
 2020 20:39:45 +0000
Received: from MN2PR05MB6381.namprd05.prod.outlook.com
 ([fe80::7803:13e7:2e4d:58ff]) by MN2PR05MB6381.namprd05.prod.outlook.com
 ([fe80::7803:13e7:2e4d:58ff%3]) with mapi id 15.20.2958.016; Wed, 29 Apr 2020
 20:39:45 +0000
From:   Ashwin H <ashwinh@vmware.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Steven Rostedt <srostedt@vmware.com>,
        "ashwin.hiranniah@gmail.com" <ashwin.hiranniah@gmail.com>
Subject: Re: [PATCH 0/5] Backport to 4.9- ext4: protect journal inode's blocks
 using block_validity
Thread-Topic: [PATCH 0/5] Backport to 4.9- ext4: protect journal inode's
 blocks using block_validity
Thread-Index: AQHWGi27IFY6BkPAZkC2EaJcZV6qpaiQF5aAgADc4gA=
Date:   Wed, 29 Apr 2020 20:39:45 +0000
Message-ID: <A37B50A5-C978-47A6-9861-048AEA9788EE@vmware.com>
References: <cover.1587713792.git.ashwinh@vmware.com>
 <20200429125909.GA2124190@kroah.com>
In-Reply-To: <20200429125909.GA2124190@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vmware.com;
x-originating-ip: [49.206.2.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7e4b23a-129e-4521-92f5-08d7ec7d73c3
x-ms-traffictypediagnostic: MN2PR05MB6575:|MN2PR05MB6575:|MN2PR05MB6575:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR05MB6575D7499361A44FCB167C19CDAD0@MN2PR05MB6575.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 03883BD916
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W8lrp029bl70BgCA+wCjpFFScCwG0oWHlTrIiwxIcHYpsh9bFicnK9ilJOhE4oQnCKlEQnf+KwN4iRFKdbMOAClIFjUYGcDz8/KT9P3HWJ9r59l9xBzxtqsvwG/S9WUh6GoxeHYm/vxDQlJ+TNvXD9BboF8zbxt9VFHAF6shjZH4pntEnn/8ahUfKIcmV76CrsGzLzYdVxhO/gxpKxfce5zoLp2jlJosCgXmQcrRgM6sIMzr58GsfMz2gv6fI4AvLL/yQLLX7rEJ2CEgy5MMYie6HEkfHa5Khh91WUopU2iEmvLevUAA70fZP8XhLxJo8/mcVLdhthNrYda/I3QLxv/sgjdyNbOfxk3GJKLSoq6aRUKKHEs4Olj/JNc/6p2n8ZVz6I3rBOALwA9Cgzpte2pN5ISrGtSBjF+PjP8qbnwX3RIKIDm8FzPZhK6ujNou
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR05MB6381.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(4326008)(5660300002)(33656002)(8936002)(6486002)(2906002)(6506007)(54906003)(186003)(55236004)(86362001)(4744005)(6916009)(6512007)(8676002)(66476007)(66556008)(66446008)(64756008)(76116006)(91956017)(66946007)(36756003)(478600001)(2616005)(71200400001)(26005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ALwDfcivMyCj4oMNNv5gOVzX7K27GpOL0YzXp1NnVUFH9J1exV3FMJ+QVuww5t3A41K0+sQsEdn1epqx6UzQkl2YVIGQp4M8yzW3b+bGdTI1SmG4Bx/aRTnAz+Wtlrzk322kG/OJitwYu1zb7nzWr02RBemdklF9CVH2adQ56/3pzuAQlLlUyKmMLgbTY2QnbD5YLZqtzd+22THe6qJzYfkWzjwsn1Z842t7nwejISrP4H1fo8Ex24nD0SGhBPNU6hMWn8YmJPVvxeHE7QrADaYK6J3Yv2tTYFqrhbt2UXBO21bLI7I/EL1H4s8W/mws+SYSLIPH7BPQMyl7cGok33+O9+QuNyuauiTvQ7nhAhf3t4WLpTOu0qZadkqU0Ot7jWxevyT3EoHbVgzIfIaDcdIxPf9FTlxPhQPdjsSf+zh9Tkfr9JueOpgQwndUv5M90hM/lafFLT1j8nuQOIuMFRxcFohpM7Sf4vPDijkdCsHD0UxkK0Wc2F5goZEGN/4tAo/SIOvfvMQ8FQDzoUZYNFSF+XEsUwUnJUGxhVFtDnCEypOlzGS3NvPQYLQnkMkmurFTOxeYNKxxTviijndJaqPTHWg2Sss+qx7UxFxoPpOEYei9ZbSa4nFyicrU1Yvi/K2uAONDKlWAaA5xknMEIVufM2wPC4f3gt/7BIFkU9z+zTKpm3ThezkbDGWTTMfYdTo827Ca9XsRWCgusJE+7hqwVY/BFRPKb29vArnmyVKcYOcZxq+Ce9jvg43wZeNFUT2yLE9ILMxIcYZjy1W8IyaqIWlR1XrBRqUZhGMbqw0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62AD4238A6F2F94EBD52FC027CE86A46@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e4b23a-129e-4521-92f5-08d7ec7d73c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 20:39:45.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 514ury8bP5ycbOyOFJO/BCteqyDhUUicboYKKndEr7gMutxAYfhMazYHtVLlRbF5QbZ/yq70lXYeBtn9rv+Tcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6575
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SSBoYXZlIHNlbnQgcGF0Y2hlcyBmb3IgNC4xNCB0cmVlDQoNClRoYW5rcywNCkFzaHdpbg0KDQrv
u79PbiAyOS8wNC8yMCwgNjoyOSBQTSwgIkdyZWcgS0giIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4gd3JvdGU6DQoNCiAgICBPbiBUaHUsIEFwciAzMCwgMjAyMCBhdCAxMjo1MTozNEFNICsw
NTMwLCBhc2h3aW4taCB3cm90ZToNCiAgICA+IFtQQVRDSCAxLzVdIGV4dDQ6IGF2b2lkIGRlY2xh
cmluZyBmcyBpbmNvbnNpc3RlbnQgZHVlIHRvIGludmFsaWQgZmlsZQ0KICAgID4gaGFuZGxlcw0K
ICAgID4gVGhpcyBwYXRjaCBpcyBiYWNrcG9ydGVkIGFzIGZ1bmN0aW9uYWxpdHkgaW4gdGhpcyBj
b21taXQgaXMgdXNlZCBieQ0KICAgID4gUGF0Y2ggMiBpbiB0aGlzIHBhdGNoc2V0Lg0KICAgID4g
DQogICAgPiBbUEFUQ0ggMi81XSBleHQ0OiBwcm90ZWN0IGpvdXJuYWwgaW5vZGUncyBibG9ja3Mg
dXNpbmcgYmxvY2tfdmFsaWRpdHkNCiAgICA+IEJhY2twb3J0IHRvIDQuOQ0KICAgID4gDQogICAg
PiBbUEFUQ0ggMy81XSBleHQ0OiBkb24ndCBwZXJmb3JtIGJsb2NrIHZhbGlkaXR5IGNoZWNrcyBv
biB0aGUgam91cm5hbA0KICAgID4gW1BBVENIIDQvNV0gZXh0NDogZml4IGJsb2NrIHZhbGlkaXR5
IGNoZWNrcyBmb3Igam91cm5hbCBpbm9kZXMgdXNpbmcNCiAgICA+IFtQQVRDSCA1LzVdIGV4dDQ6
IHVuc2lnbmVkIGludCBjb21wYXJlZCBhZ2FpbnN0IHplcm8NCiAgICA+IEZpeGVzIGlzc3VlcyBm
b3VuZCBpbiBQYXRjaCAyIGluIHRoaXMgcGF0Y2hzZXQuDQogICAgPiANCiAgICA+IFRoZXNlIHBh
dGNoZXMgYWRkcmVzc2VzIENWRS0yMDE5LTE5MzE5DQogICAgDQogICAgSSBjYW4ndCB0YWtlIHBh
dGNoZXMgZm9yIDQuOSB0aGF0IGFyZSBub3QgYWxzbyBpbiA0LjE0LCBmb3IgdGhlIG9idmlvdXMN
CiAgICByZWFzb24gdGhhdCB5b3UgbmV2ZXIgd2FudCB0byB1cGdyYWRlIHRvIGEgbmV3ZXIga2Vy
bmVsIGFuZCBnZXQNCiAgICByZWdyZXNzaW9ucy4NCiAgICANCiAgICBTbyBjYW4geW91IHByb3Zp
ZGUgYSBiYWNrcG9ydGVkIHNlcmllcyBmb3IgdGhlIDQuMTQgdHJlZSB0b28/ICBUaGVuIEkNCiAg
ICBjYW4gdGFrZSB0aGVzZS4NCiAgICANCiAgICB0aGFua3MsDQogICAgDQogICAgZ3JlZyBrLWgN
CiAgICANCg0K
