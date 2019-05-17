Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2450215D6
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2019 11:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfEQJBh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 May 2019 05:01:37 -0400
Received: from mail-oln040092072057.outbound.protection.outlook.com ([40.92.72.57]:59997
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727338AbfEQJBh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 17 May 2019 05:01:37 -0400
Received: from VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (10.152.18.51) by VE1EUR03HT193.eop-EUR03.prod.protection.outlook.com
 (10.152.19.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.11; Fri, 17 May
 2019 09:01:32 +0000
Received: from AM0PR07MB4417.eurprd07.prod.outlook.com (10.152.18.51) by
 VE1EUR03FT051.mail.protection.outlook.com (10.152.19.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1900.16 via Frontend Transport; Fri, 17 May 2019 09:01:32 +0000
Received: from AM0PR07MB4417.eurprd07.prod.outlook.com
 ([fe80::9046:9a59:4519:d984]) by AM0PR07MB4417.eurprd07.prod.outlook.com
 ([fe80::9046:9a59:4519:d984%3]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 09:01:32 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Theodore Ts'o <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ext4: Variable to signed to check return code
Thread-Topic: [PATCH] ext4: Variable to signed to check return code
Thread-Index: AQHVDI8fQaNXQ8do/UGwypDYgKNBLQ==
Date:   Fri, 17 May 2019 09:01:32 +0000
Message-ID: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:301:3b::45) To AM0PR07MB4417.eurprd07.prod.outlook.com
 (2603:10a6:208:b8::26)
x-incomingtopheadermarker: OriginalChecksum:F16B0D22BC47D86DB5D9EA83D1D5D68F67DFC813D73646B1A05D48369B308D98;UpperCasedChecksum:2EFF49CF8718F76DA200FAC0106DA78E54BF3B166EF1DC234F5B244E216FF27E;SizeAsReceived:7578;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [bBsS1hJfn2xm87r2yL5zy9OZwrndlwdj]
x-microsoft-original-message-id: <20190517090039.15291-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR03HT193;
x-ms-traffictypediagnostic: VE1EUR03HT193:
x-microsoft-antispam-message-info: /dlIyy+K9CtmIL9BLqLIWtjjF0KgXwbA/3C0rB7xXJPjpysRw1NQdr75spKseMSC+k+fvUD8+NLo8nSycfJnGc5y/qk7ITwtYJy1rZ1CjNQ4algq7e0EmpaNbv73ZVcI3/cb96YZkflwMGoDU8PBbNASTTh1SvXezBPLn1lp5+mfkwV2XThpSjc2Y6j66SE1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b5ae78-116f-4226-17fd-08d6daa641bf
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 09:01:32.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT193
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

VmFyaWFibGVzICduJyBhbmQgJ2VycicgYXJlIGJvdGggdXNlZCBmb3IgbGVzcy10aGFuLXplcm8g
ZXJyb3IgY2hlY2tpbmcsDQpob3dldmVyIGJvdGggYXJlIGRlY2xhcmVkIGFzIHVuc2lnbmVkLiBF
bnN1cmUgZXh0NF9tYXBfYmxvY2tzKCkgYW5kDQphZGRfc3lzdGVtX3pvbmUoKSBhcmUgYWJsZSB0
byBoYXZlIHRoZWlyIHJldHVybiB2YWx1ZXMgcHJvcGFnYXRlZA0KY29ycmVjdGx5IGJ5IHJlZGVm
aW5pbmcgdGhlbSBib3RoIGFzIHNpZ25lZCBpbnRlZ2Vycy4NCg0KLi4vZnMvZXh0NC9ibG9ja192
YWxpZGl0eS5jOjE1ODo5OiB3YXJuaW5nOiBjb21wYXJpc29uIG9mIHVuc2lnbmVkDQpleHByZXNz
aW9uIDwgMCBpcyBhbHdheXMgZmFsc2UgWy1XdHlwZS1saW1pdHNdDQogICAgaWYgKG4gPCAwKSB7
DQogICAgICAgIF4NCg0KLi4vZnMvZXh0NC9ibG9ja192YWxpZGl0eS5jOjE3MzoxMjogd2Fybmlu
ZzogY29tcGFyaXNvbiBvZiB1bnNpZ25lZA0KZXhwcmVzc2lvbiA8IDAgaXMgYWx3YXlzIGZhbHNl
IFstV3R5cGUtbGltaXRzXQ0KICAgIGlmIChlcnIgPCAwKQ0KICAgICAgICBeDQoNClNpZ25lZC1v
ZmYtYnk6IFBoaWxpcHBlIE1hemVuYXVlciA8cGhpbGlwcGUubWF6ZW5hdWVyQG91dGxvb2suZGU+
DQotLS0NCiBmcy9leHQ0L2Jsb2NrX3ZhbGlkaXR5LmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4dDQv
YmxvY2tfdmFsaWRpdHkuYyBiL2ZzL2V4dDQvYmxvY2tfdmFsaWRpdHkuYw0KaW5kZXggOTY4ZjE2
M2I1ZmViLi42NzhlOTlhZWVmMWYgMTAwNjQ0DQotLS0gYS9mcy9leHQ0L2Jsb2NrX3ZhbGlkaXR5
LmMNCisrKyBiL2ZzL2V4dDQvYmxvY2tfdmFsaWRpdHkuYw0KQEAgLTE0Miw3ICsxNDIsOCBAQCBz
dGF0aWMgaW50IGV4dDRfcHJvdGVjdF9yZXNlcnZlZF9pbm9kZShzdHJ1Y3Qgc3VwZXJfYmxvY2sg
KnNiLCB1MzIgaW5vKQ0KIAlzdHJ1Y3QgaW5vZGUgKmlub2RlOw0KIAlzdHJ1Y3QgZXh0NF9zYl9p
bmZvICpzYmkgPSBFWFQ0X1NCKHNiKTsNCiAJc3RydWN0IGV4dDRfbWFwX2Jsb2NrcyBtYXA7DQot
CXUzMiBpID0gMCwgZXJyID0gMCwgbnVtLCBuOw0KKwlpbnQgZXJyID0gMCwgbjsNCisJdTMyIGkg
PSAwLCBudW07DQogDQogCWlmICgoaW5vIDwgRVhUNF9ST09UX0lOTykgfHwNCiAJICAgIChpbm8g
PiBsZTMyX3RvX2NwdShzYmktPnNfZXMtPnNfaW5vZGVzX2NvdW50KSkpDQotLSANCjIuMTcuMQ0K
DQo=
