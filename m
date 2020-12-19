Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644292DED0B
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Dec 2020 05:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgLSEdL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Dec 2020 23:33:11 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:44588 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbgLSEdK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Dec 2020 23:33:10 -0500
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BJ4SpFa011997;
        Sat, 19 Dec 2020 04:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=DAJeQdqktmbb/U1VFjLbh22ku+xKYN+rbhB4DdFjfD8=;
 b=QvzjFQy3EkMFN7nM3t6XuUYBQXFPyR2BHY0+m0NWlivJQSTb78pJPS6f5Kur9dFZs4Fz
 zGrOXwggn8ck7JujbjWwagat8VIGWmhdCQt5/doRdKzSmHvOHM5hWoZa244QvW/boM+D
 edU129rY3SKD8QKcjgUb7Fscf1Zp0hg0zVFzLo3kNm0uY5CpvAhN+tI22nTzEhD1LFri
 VuzBf0SIDS08uKFBytoGwZlYuumrcEDKe6DqoLAA+OIyJTiRScU8/IgjSAUPmJyIa1ei
 tRVHj5ZbX7jtBd4sCuN0VVzXotBtPQ+Rg4/k2wwIZXPBM+L/b+OYb2pmTdCmhdQYdCWD Yw== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com with ESMTP id 35h82p8gxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Dec 2020 04:32:22 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id F2902B7;
        Sat, 19 Dec 2020 04:32:21 +0000 (UTC)
Received: from G9W8668.americas.hpqcorp.net (16.220.49.27) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 19 Dec 2020 04:31:56 +0000
Received: from G4W10205.americas.hpqcorp.net (2002:10cf:520f::10cf:520f) by
 G9W8668.americas.hpqcorp.net (2002:10dc:311b::10dc:311b) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sat, 19 Dec 2020 04:31:56 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W10205.americas.hpqcorp.net (16.207.82.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sat, 19 Dec 2020 04:31:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATypTg5sTEbw9ReZxFLddl0lTGZht9XM8M1ckqkrgvZFuGt3IUkHYAsEJszFJkYhSNL35aZNm3mN/qHWH23oOdGqY3anzfBO2gBb4W45ixABqOSvZjM1OTfciq+P44o3GRa8RvEUf0KLxCc2mnorTgySt9oNXrDMNXBABILO0XIhPcpb5AKBQoepytgIcpf8xIPdCWQl8CzGK5nOIqOfd1AAwfzFexxBVHFDwMT1rBY69O6vV53sckIEabo5OimdaJjpMCiC4GRXEyYhgurfMvLmhx6P3VnD96CyhMybUm3C3ltQr8szMsB2isyzb7oqIk+5bMaxvGrB69ThtcNgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAJeQdqktmbb/U1VFjLbh22ku+xKYN+rbhB4DdFjfD8=;
 b=hKEcPRYQmg2qREPFqRs+T8MamB9kxPVLt2Q5hFjpLZnXNHBDks/pLmA7qzanYNHeR/PJ19N2fExTDOdkWCevfgt1ERe5b3RPsMqKS/nwNYPBpHCFHYvJsJrRvEpsrtwYISciNXdjSKAwhPYs24LP9tQ/2Y4lNuhp/f8mN4p9kq42fGDRowUT5zUjsTrLixiXF8WQOYwwF9yfQuYX4wIgSyNlp+N1k1I7u/tKlIvvcjVhbFK6LGLz3kWWtXN1X1ZmpmHadDJ70ZgFNg0paMxmijzJksHhX4FaFiSe5UnMmN8ESuW30xc/QABhEE13oiorj/lhNfTKt/tueZVSuYSHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1181.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7716::10) by TU4PR8401MB1136.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7712::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Sat, 19 Dec
 2020 04:31:54 +0000
Received: from TU4PR8401MB1181.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fdc8:7994:39c9:b159]) by TU4PR8401MB1181.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fdc8:7994:39c9:b159%7]) with mapi id 15.20.3676.025; Sat, 19 Dec 2020
 04:31:54 +0000
From:   "Lyashkov, Alexey" <alexey.lyashkov@hpe.com>
To:     Andreas Dilger <adilger@dilger.ca>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] libfs: Fix DIO mode aligment
Thread-Topic: [PATCH] libfs: Fix DIO mode aligment
Thread-Index: AQHWqS98Ux7JmHKkRkWLHTDBEn/6w6nMmrSAgABAAwCAAuOigIAuAoiAgACeyQA=
Date:   Sat, 19 Dec 2020 04:31:54 +0000
Message-ID: <1492F08F-A8BD-4F81-B857-99D342031949@hpe.com>
References: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
 <19A3D721-93C0-42F3-ACBA-DE15B4685F9F@gmail.com>
 <20201117191918.GB529216@mit.edu>
 <B8DE3834-1B3F-4E1E-B342-51E04E4FD278@hpe.com>
 <08322694-9793-437D-8CD3-B8A7C5DEACFA@dilger.ca>
In-Reply-To: <08322694-9793-437D-8CD3-B8A7C5DEACFA@dilger.ca>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dilger.ca; dkim=none (message not signed)
 header.d=none;dilger.ca; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [31.28.251.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16862125-d007-46c8-0b0e-08d8a3d703a2
x-ms-traffictypediagnostic: TU4PR8401MB1136:
x-microsoft-antispam-prvs: <TU4PR8401MB11368669B8DEA60BC31288DBF7C20@TU4PR8401MB1136.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nfa0BBR+pBxvHTkdpmtp4/ewDUIbHktrrCffu8rTtgC2qdXj+MPj6HAxfBXvC6BjboQ5UIBFN8qDce3ynzprq0EP2f1pcLsNr6aCToT6yNHhogKO3trl3LrJApaPcgh9RLUgTE4MK353ElUBG4Zey9YqLYxNRe1Rckr/bhte07zQW3nr2F9S8AkDR/FJ8mYoQw0moWbKacHcymA7SpgO4MTLoILSnQG8RO5sh2nDvctpj+pDy98xBzW5Are3mKgmM5KGRRu6xDmNAd9GVxA00GMGDA+eSpQ7YWb26AkoP9el1ZlCk3anKQkHFaBwMQBesFt3wAxVT6cxmfqutaRrClAf0VTZfF4q4tKzTvOnpTu+1hLkTolKsiQEsHxqovALXRcHWHe0TH1z1Kkf20tlxsa3R1UwpFdPNhf6i60Linlinqf005iN7IcAUiGQCBEt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1181.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(366004)(346002)(91956017)(76116006)(71200400001)(2906002)(36756003)(4326008)(53546011)(6916009)(6506007)(6486002)(66446008)(2616005)(86362001)(6512007)(316002)(83380400001)(5660300002)(33656002)(8676002)(26005)(54906003)(66476007)(478600001)(186003)(66946007)(66556008)(64756008)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TUxVd2h1UkRydUx2Wmd3bXJnN1BJY1c1WFUrWVdjcUU5N3FwdmVmaWdYTCsy?=
 =?utf-8?B?QTJuL0FUUTNUUlpUUmdRRnVjTWh0ZHBjazFpMmhPU3o2dVY5RUpOQ0oyWUVS?=
 =?utf-8?B?RTNxckgwZWlDQnl3cnNBbllQUXZKTGV5clZJbGoxUHMrWC9IZHZ1V2FIc0Zt?=
 =?utf-8?B?NUdlbGZjTnFQSjFyUmtLRkpEaU14UWVTa1R6cURpRE1lN1pDMzFieVplcHNt?=
 =?utf-8?B?dm1VdWxnNFJzQ3hJRUo1c0hXb3JrWmhIblg5V0xPMXNJcVlpbjZuZ0lveE93?=
 =?utf-8?B?dXNiTlVyK2lVNnprdEltcTFkMHZ5UTZvRkcwYTZtVE80bDEvT2Y1UzFaWmNr?=
 =?utf-8?B?RGIvV1RjWDdjVEdiUDV3VCs3S25sbFAxV3VQYXYwbUtMZ2RMRWw2VjV5L1dD?=
 =?utf-8?B?dC9yaTJ6elRKR0grbGlGaDlnWUZrRWNPejBkSjVWN0R0SlJlaGpGN3RKYU45?=
 =?utf-8?B?OWZlTnAwWjFRYit5OVJNdDhLODhYaS9WMGZ6Qm91Tm5QTWppM2t3R0xxNmhs?=
 =?utf-8?B?S25RYUVNTU0zSVVTb1ErMXVDZE1wNHQvWFpKbWtUaTh6MWN5M2VXSzA0KzNS?=
 =?utf-8?B?U0hISGJBY1dlQzJNTmJ3aVN6bVo1WlFmdVFyYXdnYytzVDhIcDk1MUhyVlV3?=
 =?utf-8?B?WEhUd3ppWUZyczhZVVcvMGZKZWhtTC8velloT2JzTmpwODhXeE1vMjRIcUt3?=
 =?utf-8?B?SkZxaWp5NWt0SS92OUpvbnJnLzFyd2lNWm1xQTJaeEEyVW1oSnRudTNJeXRU?=
 =?utf-8?B?ekZPTVhRZUZYRTl5K1dNQ2h6SFRDTUhqOW0zL0FsRXd5VjJ6eTVNQ1dNRlJI?=
 =?utf-8?B?RlVpN2wwdHRMdWU2anBmcEZ3YlhRZktpL1NoN3IwWDc1SndiRytiYzErNDVx?=
 =?utf-8?B?UGFuV3VwbEk5M3U3SVErYnY4QkEzSU1LdWNKbXFJaW9YNjBFN0FTUzRLMXFl?=
 =?utf-8?B?Vk5YaTV6OTZzV1JLYXVTVmIwZUhaRHo2WHE0YWhDWmFmeEJ1Sy9KNEdQVStw?=
 =?utf-8?B?U0I0SUdLTCsxYm5UdWFHcXVDNFhtVFE1NTRBaDFiVUVLM1pEUndveGxHeFIz?=
 =?utf-8?B?dndaWGJkTE5HTUhEQWkvS1F5VDBaU2dTanFVNXpheC9ESXFIb2pzNUcwbk9W?=
 =?utf-8?B?VFJKKzRIRlNwTDc3VTREWSs4cHB1YXJIV3NFcDhsZjMxLzNuUTdManZGZWdD?=
 =?utf-8?B?YnZpYy9TazJFZ1BSVTE4bThGYjZNalJBVHptcFZpelNMeU9TaTV6WUdvSE5M?=
 =?utf-8?B?b0J0THVKK1FoTVE0WmpTaVRldzQwRHhicXFLbGFxWlBEc25taUh1L0dRVVk5?=
 =?utf-8?Q?8nZR35jBiORaJP7Fr+3TDmHsUcmf+VZ0i8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F53E1B5F082CEA419E6AAB24DEADCFE7@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1181.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 16862125-d007-46c8-0b0e-08d8a3d703a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2020 04:31:54.5693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGT9QCI2R2d/+9aQfDvcHDK0z65Bbd6Z38+aG5C+VjfCEO5zxk9QxraEbOKdVedU1T2i/c7xlfJx3PwQ4GJoog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB1136
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_14:2020-12-18,2020-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1011
 adultscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012190029
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQoNCu+7v09uIDE5LzEyLzIwMjAsIDAxOjAzLCAiQW5kcmVhcyBEaWxnZXIiIDxhZGlsZ2VyQGRp
bGdlci5jYT4gd3JvdGU6DQoNCiAgICBPbiBOb3YgMTksIDIwMjAsIGF0IDU6MjYgQU0sIEx5YXNo
a292LCBBbGV4ZXkgPGFsZXhleS5seWFzaGtvdkBocGUuY29tPiB3cm90ZToNCiAgICA+IA0KICAg
ID4gVHNvLA0KICAgID4gDQogICAgPiBUaGlzIHNpdHVhdGlvbiBoaXQgd2l0aCBtb2Rlcm4gaGRk
IHdpdGggNGsgYmxvY2sgc2l6ZSBhbmQgZTJpbWFnZSBjaGFuZ2VkIHRvIHVzZSBESVJFQ1QgSU8g
aW5zdGVhZCBvZiBidWZmZXJlZC4NCg0KICAgPiAgSXQgd291bGQgYmUgdXNlZnVsIHRvIGluY2x1
ZGUgdGhpcyBwYXRjaCBmb3IgZTJpbWFnZSBhcyBwYXJ0IG9mIHRoaXMgc3VibWlzc2lvbiwNCiAg
ICA+IHNvIHRoYXQgdGhpcyBjYW4gYmUgdGVzdGVkLiAgSSBzdXNwZWN0IHRoYXQgT19ESVJFQ1Qg
d291bGQgYmUgdXNlZnVsIGZvciBvdGhlcg0KICAgID4gdG9vbHMgKGUuZy4gZTJmc2NrLCBkZWJ1
Z2ZzLCBldGMuKSBzaW5jZSB0aGUgSU8gbWFuYWdlciB3b3VsZCBhdm9pZCBkb3VibGUNCiAgICA+
IGJ1ZmZlcmluZyB0aGUgZGF0YSBpbiBib3RoIHRoZSBrZXJuZWwgYW5kIHVzZXJzcGFjZS4NCg0K
ZGVidWdmcyBoYXZlIGEgLUQgb3B0aW9uIGFscmVhZHkuIEFzIGFib3V0IGUyZnNjayBoYXZlIHJ1
biBpbiBzaW5nbGUgdXNlciBhbmQgc2V2ZXJhbCBsb29wcyBvdmVyIEZTIGV4aXN0Lg0KU28gY2Fj
aGluZyBpcyBnb29kIHRvIGhhdmUgdGhlcmUuIERvbid0IGZvcmdldCAtIGNhY2hpbmcgcGVybWl0
cyBhbiByZWFkYWhlYWQgd29ya3MgLSB3aGljaCBpcyB2ZXJ5IHVzZWZ1bGwgZm9yIHRoZSBsYXJn
ZSBmaWxlc3lzdGVtIG9wZW4uDQoNCg0KDQogICAgPiBlMmZzcHJvZ3MgdHJpZXMgdG8gcmVhZCBh
IHN1cGVyIGxvY2sgb24gb2Zmc2V0IDFrIGFuZCBpdCBjYXVzZWQgdG8gc2V0IEZTIGJsb2NrIHNp
emUgdG8gMWsgYW5kIHNlY29uZCBibG9jayByZWFkaW5nLg0KICAgID4gKG1hbnkgb3RoZXIgcGxh
Y2VzIGV4aXN0LCBidXQgaXQgc2ltcGxlc3QpLg0KDQogPiAgICBBcmUgdGhlcmUgYWN0dWFsbHkg
b3RoZXIgcGxhY2VzIHdoZXJlIGl0IGlzIGRvaW5nIHN1Yi1ibG9jay1zaXplIHJlYWRzIGZyb20g
ZGlzaz8NCk1hbnkgcGxhY2VzLiANCg0KYmFzaC0zLjIkIGdyZXAgLXJuIGlvX2NoYW5uZWxfc2V0
X2Jsa3NpemUgKiB8IGdyZXAgU1VQRVJCTE9DSw0KbGliL2V4dDJmcy91bmRvX2lvLmM6MjIzOglp
b19jaGFubmVsX3NldF9ibGtzaXplKGNoYW5uZWwsIFNVUEVSQkxPQ0tfT0ZGU0VUKTsNCmxpYi9l
eHQyZnMvdW5kb19pby5jOjUwNjoJaW9fY2hhbm5lbF9zZXRfYmxrc2l6ZShjaGFubmVsLCBTVVBF
UkJMT0NLX09GRlNFVCk7DQpsaWIvZXh0MmZzL2Nsb3NlZnMuYzoyMDE6CQlpb19jaGFubmVsX3Nl
dF9ibGtzaXplKGZzLT5pbywgU1VQRVJCTE9DS19PRkZTRVQpOw0KbGliL2V4dDJmcy9vcGVuZnMu
YzoyMTg6CQlpb19jaGFubmVsX3NldF9ibGtzaXplKGZzLT5pbywgU1VQRVJCTE9DS19PRkZTRVQp
Ow0KbWlzYy9ta2UyZnMuYzoyNTczOglpb19jaGFubmVsX3NldF9ibGtzaXplKGNoYW5uZWwsIFNV
UEVSQkxPQ0tfT0ZGU0VUKTsNCm1pc2MvZTJ1bmRvLmM6MTY4Oglpb19jaGFubmVsX3NldF9ibGtz
aXplKGNoYW5uZWwsIFNVUEVSQkxPQ0tfT0ZGU0VUKTsNCg0KYW5kIHNvbWUgcGxhY2VzIHdoZXJl
IHNldF9ibGtzaXplIHdhcyBjYWxsZWQgd2l0aCBvdGhlciBzaXplIGRpZmZlcmVudCB0aGFuIGJs
b2NrIGRldmljZSBzaXplLg0KSW4gdGhlb3J5IHdlIGNhbiBjcmVhdGUgYW4gRlMgd2l0aCAxSyBi
bG9jayBzaXplLCBhbmQgdG9vbHMgc2hvdWxkIGFibGUgdG8gd29yayB3aXRoIGl0Lg0KDQoNCj4g
ICAgSXQgc2VlbXMgc2ltcGxlciB0byBmaXggdGhlIHN1cGVyYmxvY2sgcmVhZCBhdCBvcGVuIHRv
IGFsd2F5cyByZWFkIHRoZSBmaXJzdCA0S0INCj4gICAgaW50byBhIGJ1ZmZlciAoYW5kIHRvIG1h
a2UgaXQgZWFzeSB0byBleHRlbmQgdG8gMTZLQiBvciA2NEtCIGlmIHNlY3RvciBzaXplcyBnZXQN
Cj4gICAgZXZlbiBsYXJnZXIpLCB0aGVuIGZpbmQgdGhlIHN1cGVyYmxvY2sgd2l0aGluIHRoZSBi
dWZmZXIgdG8gZGVjaWRlIHRoZSBibG9ja3NpemUuDQoNCkFuZCBtYWtlIGl0IG9uIG1hbnkgcGxh
Y2VzIGluY2x1ZGluZyBhbiBtZXRhZGF0YSByZWFkaW5nIGluIGNhc2UgRlMgYmxvY2sgc2l6ZSBp
cyAxay4NCg0KDQoNCg0K
