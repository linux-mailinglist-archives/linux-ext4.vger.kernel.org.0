Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F9A1B2177
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgDUIWe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Apr 2020 04:22:34 -0400
Received: from mail-eopbgr760050.outbound.protection.outlook.com ([40.107.76.50]:47623
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgDUIWd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 Apr 2020 04:22:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2PgLkdxwOSe7YhYwGKGR+ozOKENpInQJA4UWYouYYUUBBFHjmRc/x4nlJdxDT3miCWh23EOVo7POHhjzCHJdhxqJr6IS7s1QRDYd8zYDM9Oiw6QVO0TDhaILlzMmMTChGHdOc6+5j8MY80sGmbD8HHiaDcxdotQ8voh/IAh6nykMxL5DPjAlL4rI1QqGQKiNbot9zg2fMptdsIbQlvziHa4S0tq2IFTbLGKdO9JwCpO/zjsXXGhg3jUfAD0lkO8EM04OTDMwQMLw2zbR5SfKwMDTuAAXlstcWB5iSVU3cbloze55oU7RwYF5ajG9NCGPaIhnEs/GZxETRX+qyIAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76Odtjg56xLGStMkEf+kbcsDs4VCYD5dMx7ycQzGVSU=;
 b=CG8fTCEOVMJr2XL5kJ1rqj2AqoUlAJie7Jaq1264emzeBtuoNjXLNAs/lUKPsNUWK7ChU5ojnWgeX4Cw+HXA3i+28ZCrSS8NfwgSnOkc+NphQ0i4HwVwi7M1L6DY8H3jT20PwWPSz07lTrS914GVX1tbXET1IbE0EBFd5jOieFaK/EeJdtlhB7P68F9frVttDh39aS+mSiUotnFHb8JBu8yNzPu46H7UBb7s6I16FNvswSQE5k65UWQTf2Xq93GxquRxY7LVoFhtrosMB1UGP0Oh3zEpsUHSpF664G+bZsX6piqCNjJkcqNiHdr6Y+JBVTS88RlMfBCTtF9C6IUn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76Odtjg56xLGStMkEf+kbcsDs4VCYD5dMx7ycQzGVSU=;
 b=R7bDdgtyq9OQBssyuLTYqm7R5r2t1Tefx66Wafmev559qm8B2CbXNKa2ToKiKL1eg1Lm6HjYoadC8SDkJIV9ERFyoJzwS08RX5LvB/k+WSSCX2ZsQbmDaJiF+dBC++nrr/FDolFv78ahVe6MVS/g7+fVmi9PxeXWN2ZnGFSCjKA=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (2603:10b6:5:18d::16)
 by DM6PR19MB3945.namprd19.prod.outlook.com (2603:10b6:5:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Tue, 21 Apr
 2020 08:22:30 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4%7]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 08:22:30 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [RFC] improve malloc for large filesystems - limit scanning
Thread-Topic: [RFC] improve malloc for large filesystems - limit scanning
Thread-Index: AQHWF7X/sivHAokacEGsClG4f7iSOQ==
Date:   Tue, 21 Apr 2020 08:22:29 +0000
Message-ID: <D9CC7C2D-65F7-4983-BFFC-E2B5669D2A0F@whamcloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [95.73.42.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4a8dee3-219a-4825-b04e-08d7e5cd222a
x-ms-traffictypediagnostic: DM6PR19MB3945:
x-microsoft-antispam-prvs: <DM6PR19MB394501AAD77D6FA938EB0B76CBD50@DM6PR19MB3945.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(366004)(39850400004)(99936003)(36756003)(66946007)(33656002)(6486002)(66446008)(5660300002)(66616009)(66556008)(66476007)(64756008)(186003)(2616005)(91956017)(76116006)(8936002)(86362001)(6916009)(71200400001)(4744005)(8676002)(6506007)(316002)(2906002)(26005)(6512007)(81156014)(478600001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5YxB1EN5Aow/6Sl6eN2Xxfm18mKaoOXIKEWVQKi06klcsNkZnMGhrWTX/tcNsMOAMPxGMA6o6EgV8ymFTjKme5B6c5ZogI+WC5pBsRWfR8vn/lORWuqRdG5n5RawjwXiDUmzGtiDXXmIou4QDFHjf2Udwz9eHVs6OQpddREsQFoiVSkysNHK9W9D9sG0iNzIqOwfR9ny+AqadzgwCGkAm9wFGR2XDHWtmij3HJPbCv6dgrj9OTRAMJBJn3Fz9Pne7qdqrI9UoK/AjtLnKrylwxK7z46rJ803Sj6B3jugpRHc+TziKO+jn35JM0UctUOT/vcIwglCpESVWgx/Rw75EnrZfnlMCnyWCzk7F45coZvtJ++53qIaQvCAs10tPTR0Z65JdlgWV6hfrFPLrat+tOC8j33rfp5ViO4941McG+6EbDItruuc4LhomY78QWAY
x-ms-exchange-antispam-messagedata: e6Je+9PuTUFtY5mETMRnaq6JG81Dpt66y4Of1YuBuRDYkMUmgOdj9rjKSzDaez9UfrWjC/RES6DwvDbvje+mNaTuatFMTZ34RkPMWmhZqHPg/n7lldCgDVF01WOefQ+OKF6jjrUUJtl5q2uTPyYRBQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_D9CC7C2D65F74983BFFCE2B5669D2A0Fwhamcloudcom_"
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a8dee3-219a-4825-b04e-08d7e5cd222a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 08:22:29.9114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKZf7iH2UePeZYiOEzKuT/wqbnKo7S9A3uUne9LF8KfiTfmMHoAMotfbntZgSqaBoiuPVw3k18wydiv3MgBu8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3945
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--_002_D9CC7C2D65F74983BFFCE2B5669D2A0Fwhamcloudcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA66653E4925F84EB5E38ABEDD686E6F@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64

SGksIHlldCBhbm90aGVyIHBhdGNoLg0KDQpUaGVyZSBpcyBhbiBpc3N1ZSB3aXRoIGN1cnJlbnQg
bWJhbGxvYyBvbiBodWdlIGZpbGVzeXN0ZW1zIC0gd2hlbiBhIHNtYWxsIGFsbG9jYXRpb24gaXMg
cmVxdWVzdGVkLCBtYmFsbG9jIHR1cm5zIGl0IGludG8gYSBncm91cCBwcmVhbGxvY2F0aW9uICg1
MTIgYmxvY2tzIGJ5IGRlZmF1bHQpLA0KdGhlbiBzY2FucyBhbGwgYml0bWFwcyB0byBmaW5kIHRo
aXMgZ29vZCBjaHVuay4gVGhlIHByb2JsZW0gaXMgdGhhdCBzdGFnZXMgMCBhbmQgMSBhcmUgb3B0
aW1pc2VkIGZvciBDUFUgY3ljbGVzIGFuZCBza2lwIG5vdC1pbnRlcmVzdGluZyBncm91cHMsIGJ1
dCB0byBsZWFybg0KdGhlIGdyb3VwIGlzIG5vdCBpbnRlcmVzdGluZyBpdCBzaG91bGQgYmUgaW5p
dGlhbGlzZWQuIElmIGl04oCZcyBub3QgdGhlbiBJTyBpcyByZXF1aXJlZC4gSWYgdGhlIGZpbGVz
eXN0ZW0gaXMgaGlnaGx5IGZyYWdtZW50ZWQgdGhlbiBpdCBtYXkgdGFrZSBob3VycyAobGl0ZXJh
bGx5KSB0byBmaW5kIHRoaXMgZ29vZA0KY2h1bmsuIFRoZSBwcmV2aW91cyBwcmVmZXRjaGluZyBw
YXRjaCBpbXByb3ZlcyB0aGlzLCBidXQgc3RpbGwgbGVhZHMgdG8gbG90cyBvZiBJTyBhbmQgdmVy
eSBleHBlbnNpdmUgYWxsb2NhdGlvbnMgaW4gc29tZSBjYXNlcy4NClRoaXMgcGF0Y2ggY2hhbmdl
cyBtYmFsbG9jIGluIGEgZGlmZmVyZW50IHdheSAtIGFzIHN0YWdlcyAwLzEgYXJlIG9wdGltaXNh
dGlvbnMsIHdlIGNhbiBza2lwIHRoZW0gZm9yIG5vbi1pbml0aWFsaXNlZCBncm91cHMgKGUuZy4g
cmlnaHQgYWZ0ZXIgbW91bnQpIGFuZCBqdXN0IHNjYW4NCmJpdG1hcHMgZm9yIGFsbCBhdmFpbGFi
bGUgYmxvY2tzIChzdGFnZSAyKS4NCg0KUGxlYXNlIHJldmlldy4NCg0KVGhhbmtzLCBBbGV4DQoN
Cg==

--_002_D9CC7C2D65F74983BFFCE2B5669D2A0Fwhamcloudcom_
Content-Type: application/octet-stream;
	name="0001-mballoc-limit-scanning-of-uninitialized-groups.patch"
Content-Description: 0001-mballoc-limit-scanning-of-uninitialized-groups.patch
Content-Disposition: attachment;
	filename="0001-mballoc-limit-scanning-of-uninitialized-groups.patch";
	size=1695; creation-date="Tue, 21 Apr 2020 08:22:29 GMT";
	modification-date="Tue, 21 Apr 2020 08:22:29 GMT"
Content-ID: <22D5527FF97495478C9A9C7EF79D60C4@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBhOGQ1ZWRkZGI3YmYwNmM1MThjNjA2YThjZTg0ZjhlZDk3MmViNTcyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFpodXJhdmxldiA8Ynp6ekB3aGFtY2xvdWQuY29tPgpE
YXRlOiBUdWUsIDIxIEFwciAyMDIwIDExOjExOjI1ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gbWJh
bGxvYyAtIGxpbWl0IHNjYW5uaW5nIG9mIHVuaW5pdGlhbGl6ZWQgZ3JvdXBzCgpTaWduZWQtb2Zm
LWJ5OiBBbGV4IFpodXJhdmxldiA8Ynp6ekB3aGFtY2xvdWQuY29tPgotLS0KIGZzL2V4dDQvbWJh
bGxvYy5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDI0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9leHQ0L21iYWxs
b2MuYyBiL2ZzL2V4dDQvbWJhbGxvYy5jCmluZGV4IGU4NGMyOThlNzM5Yi4uODNlM2U2YWIxMjQw
IDEwMDY0NAotLS0gYS9mcy9leHQ0L21iYWxsb2MuYworKysgYi9mcy9leHQ0L21iYWxsb2MuYwpA
QCAtMTg3Nyw2ICsxODc3LDIxIEBAIGludCBleHQ0X21iX2ZpbmRfYnlfZ29hbChzdHJ1Y3QgZXh0
NF9hbGxvY2F0aW9uX2NvbnRleHQgKmFjLAogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW5saW5l
IGludCBleHQ0X21iX3VuaW5pdF9vbl9kaXNrKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCisJCQkJ
ICAgIGV4dDRfZ3JvdXBfdCBncm91cCkKK3sKKwlzdHJ1Y3QgZXh0NF9ncm91cF9kZXNjICpkZXNj
OworCisJaWYgKCFleHQ0X2hhc19ncm91cF9kZXNjX2NzdW0oc2IpKQorCQlyZXR1cm4gMDsKKwor
CWRlc2MgPSBleHQ0X2dldF9ncm91cF9kZXNjKHNiLCBncm91cCwgTlVMTCk7CisJaWYgKGRlc2Mt
PmJnX2ZsYWdzICYgY3B1X3RvX2xlMTYoRVhUNF9CR19CTE9DS19VTklOSVQpKQorCQlyZXR1cm4g
MTsKKworCXJldHVybiAwOworfQorCiAvKgogICogVGhlIHJvdXRpbmUgc2NhbnMgYnVkZHkgc3Ry
dWN0dXJlcyAobm90IGJpdG1hcCEpIGZyb20gZ2l2ZW4gb3JkZXIKICAqIHRvIG1heCBvcmRlciBh
bmQgdHJpZXMgdG8gZmluZCBiaWcgZW5vdWdoIGNodW5rIHRvIHNhdGlzZnkgdGhlIHJlcQpAQCAt
MjA2MCw3ICsyMDc1LDE1IEBAIHN0YXRpYyBpbnQgZXh0NF9tYl9nb29kX2dyb3VwKHN0cnVjdCBl
eHQ0X2FsbG9jYXRpb25fY29udGV4dCAqYWMsCiAKIAkvKiBXZSBvbmx5IGRvIHRoaXMgaWYgdGhl
IGdycCBoYXMgbmV2ZXIgYmVlbiBpbml0aWFsaXplZCAqLwogCWlmICh1bmxpa2VseShFWFQ0X01C
X0dSUF9ORUVEX0lOSVQoZ3JwKSkpIHsKLQkJaW50IHJldCA9IGV4dDRfbWJfaW5pdF9ncm91cChh
Yy0+YWNfc2IsIGdyb3VwLCBHRlBfTk9GUyk7CisJCWludCByZXQ7CisKKwkJLyogY3I9MC8xIGlz
IGEgdmVyeSBvcHRpbWlzdGljIHNlYXJjaCB0byBmaW5kIGxhcmdlCisJCSAqIGdvb2QgY2h1bmtz
IGFsbW9zdCBmb3IgZnJlZS4gaWYgYnVkZHkgZGF0YSBpcworCQkgKiBub3QgcmVhZHksIHRoZW4g
dGhpcyBvcHRpbWl6YXRpb24gbWFrZXMgbm8gc2Vuc2UgKi8KKworCQlpZiAoY3IgPCAyICYmICFl
eHQ0X21iX3VuaW5pdF9vbl9kaXNrKGFjLT5hY19zYiwgZ3JvdXApKQorCQkJcmV0dXJuIDA7CisJ
CXJldCA9IGV4dDRfbWJfaW5pdF9ncm91cChhYy0+YWNfc2IsIGdyb3VwLCBHRlBfTk9GUyk7CiAJ
CWlmIChyZXQpCiAJCQlyZXR1cm4gcmV0OwogCX0KLS0gCjIuMjEuMQoK

--_002_D9CC7C2D65F74983BFFCE2B5669D2A0Fwhamcloudcom_--
