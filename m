Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CF249E2D1
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jan 2022 13:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiA0Mqx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jan 2022 07:46:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56860 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbiA0Mqw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 27 Jan 2022 07:46:52 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20R9uFZ2005670;
        Thu, 27 Jan 2022 12:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Tf04wbWyIaiEQNjHeo/cIHHjVcO06nD0pDHLjoCnQD4=;
 b=Cn7PGEf8sJvD4YNKs0h1uhbMZeXE/myz1Z5kNnqNObQTkODTntCa2B3VPsxejuZIjy6V
 Mezc0MovZOHt/quygaggEXmDfzVlS0cyEIYYhqQJ5jh1t+5v7XbreF8ovBDQH/x5yJeU
 yG5hw0NG8y7GF1LacccZzWyfCBL0zTwMS0Zr4Vx20+Igt19LmevnTqCM6OjFJQCKHuh0
 zEtp2OkWvWfYC1GyILKW7Mt1MbD8l6EV0J1FmK1Us8OPz/Y6pwfZlzKajfEegtgg2QfI
 lfISJdTgvTYhiVVLegC/gfWT2evrT2+vO+wmap8G10aW+Yh+IknBEnAZsbKFdIhEmynZ ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7b1a75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 12:46:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RCkXS3172315;
        Thu, 27 Jan 2022 12:46:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by userp3020.oracle.com with ESMTP id 3drbctakry-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 12:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VD29xpz8W5TuCA7MVXrPQ8Y3Odi3smXGhm3ollz3hJRbXgoS+qfIDWkDt595KGz8Em1tb4/vu5IX5V/IZl9yXhzWYwiDv/xqrsbAeeof7C3/AyMXsR8NfLxh2QVok9tHwG2b6y92WIZpW40uo5zt2CGq9HB1LCEkzBHHFEHHBUlLaGRSrCqTavkYfJmwdAPS3j1IBTPJ0iegvm7od9jB4avi4A9UojoWJhpZdLVj6b296/0dcyGK5Qe8SHlVZMqAXriZ4Jk+Kmx+eK+ZIMhUwTwqtxRMkOirhnoszl8oyiDFpr2UK51NNTIAQvb7w9OLHOk0Trekt+FvpImRAa5OVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tf04wbWyIaiEQNjHeo/cIHHjVcO06nD0pDHLjoCnQD4=;
 b=UHSyqm8eEQBQG5A1ZqscnrZSOroMqzxcXRnM2raCJ0Lj8Wswn/kiYgr/Bp9ZqoE0MvXxtAXqk4Ndtw9J0lp8OK1Qm5YUxMEren9+CPJrECUXf8hP5IVI2w6npKQkRk9fIajS/hdHCHA2maiwLCzHQeaU9UHbE3dpFIRAMw134vP+HWn3m11DzZTedeCZBoMpnmZlJ1/3jEmRoL1hHbT0y3AeHTo7NjDGOeBYQhwT56vXnTrcg+C2fDNDPWajCfjNSYd3Ul9evc8zyRI9zxKnG8cZAPPLgSVmOkB1g/NkeDa8le+OFpTWyNHE2gXnokmuWyeXj/5FvAmbLHy8Gtn1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tf04wbWyIaiEQNjHeo/cIHHjVcO06nD0pDHLjoCnQD4=;
 b=FsklWdKpEgtBt4jiKwJcCHzGaA4KbTf6BRgH0t+fNI4VVN8wYWbLew2zFc9loUP3HbIf6E4f+RBvixovZCnbvf8xda2mxv4F0gkgK0hmFMHxKSI0TtS17kfVG9qgHcLmQTQVOjwKI/lKitH4rkbfKEDYPtCiHJ+bwHGtBckqmFk=
Received: from DS7PR10MB4878.namprd10.prod.outlook.com (2603:10b6:5:3a8::6) by
 DM5PR10MB1481.namprd10.prod.outlook.com (2603:10b6:3:9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Thu, 27 Jan 2022 12:46:42 +0000
Received: from DS7PR10MB4878.namprd10.prod.outlook.com
 ([fe80::8d35:833d:3048:1e7]) by DS7PR10MB4878.namprd10.prod.outlook.com
 ([fe80::8d35:833d:3048:1e7%8]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 12:46:42 +0000
From:   Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
CC:     "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: RE: [PATCH 2/2] ocfs2: fix a deadlock when commit trans
Thread-Topic: [PATCH 2/2] ocfs2: fix a deadlock when commit trans
Thread-Index: AQHYDpY4QxT3B/KhD0KLG3FGeJTJ0KxwFvKQgAFiiwCABWEEQA==
Date:   Thu, 27 Jan 2022 12:46:41 +0000
Message-ID: <DS7PR10MB487856DF1F951F8ABB7956C8F7219@DS7PR10MB4878.namprd10.prod.outlook.com>
References: <20220121071205.100648-1-joseph.qi@linux.alibaba.com>
 <20220121071205.100648-3-joseph.qi@linux.alibaba.com>
 <DS7PR10MB487883FE7025BE9FD4623C39F75D9@DS7PR10MB4878.namprd10.prod.outlook.com>
 <206899ac-c1af-35bb-820a-62a45d93b52a@linux.alibaba.com>
In-Reply-To: <206899ac-c1af-35bb-820a-62a45d93b52a@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9059e1e4-a962-4013-1f3a-08d9e1931186
x-ms-traffictypediagnostic: DM5PR10MB1481:EE_
x-microsoft-antispam-prvs: <DM5PR10MB1481EC530AE18782B656B753F7219@DM5PR10MB1481.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0UIXLWm+lj4gPqSkmuVcj1bspgepo2qSXphDKg4matqJ+T3tThDkpJBSd4zJ+V19SWeawndLUNv8XjBB7nqHtD4tKKxc62o7pcTzmQa+kMLPenFoHcmeYyDGCKhwCyBLkKHYGWrl8M9mgNw5ljJDEtHTERTXxOb49FzjE5oUNqwlW/tSc6fEsnCDJeVsAhOSSI/tNfiAF2+cwjLeAIJdpk6BdD//LA3za5w+e7xW4N0Xea2ly6+0dIquublS6uVbpm6ieU3zH9jydZmWXsFTOFxzGKIPzHK1yqIMjwewNOsuVGpyFkema5R2bplS+cCcmuWmMD+kaWL6WzlH90RTu4K4okjMaWhyrkLqEg04xvEr1uK4LlUnvoupGdVAhI9HAJkZUaJGAbw+d/WDhHgrW+Yc471dxQQf6PNWbnGMO3p48AhkDXr0I55vmRQSbOcX0YaqOQXs9RZsfACItcmV7U/+aQMqFLVY53G+S+Awy3vH3jQXMii/SjtdIKGZRVa8NUlhKXeWvbKFRJMN0fy4WWop9Fk6ZzxHZHLS+RHWbREAqTnWhsuzi17D8rFKCrJdeuzW0qXFxCwMzE4QH4YpAbZNg3DA+pvqBKjSFjnSiOBprJfq8qfRV9NFORWPhcv2SkapCVls2qyz6r42w3b2C71h6GLBvhT6K0x84GrIvmKlrvFfDG8lz9faXfLF+n3Os63zN0sSiSb4SEiKXHCvVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4878.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(66946007)(186003)(9686003)(44832011)(64756008)(66446008)(6506007)(55016003)(5660300002)(53546011)(66476007)(2906002)(66556008)(8936002)(8676002)(76116006)(52536014)(122000001)(107886003)(110136005)(33656002)(38070700005)(4326008)(83380400001)(7696005)(508600001)(316002)(54906003)(38100700002)(86362001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1NQRWZ3SWFjQU9PMGd4dWpzOGZKa3BmQUFuMHdGR1lmZmZwZW0xWU9Mb2tY?=
 =?utf-8?B?K21qK3pzSlh0R2srMFgxejEvSUZ6SXp4Ny9mTERPaWxvdWVpcmU0N1dLRDkv?=
 =?utf-8?B?T2VCMXhiOEt2V2h5ZVRSUU1iMGlZZm9YQVc5dFRDam5MZ0gzRjFzUk9KL1ly?=
 =?utf-8?B?N2dibms4ZjJQV2p5enRSU1NNeFVYUXlJZHl0YkJMaHk1dmxXdVA4MmlPaHNs?=
 =?utf-8?B?S2VrdGlNRjBJYU9xQW5OdjNNTmxKV0RFOWFiMlRKN25jdUZaOGtUZG1hVFRi?=
 =?utf-8?B?WUZmeXh1T0MwTXJybGxOZmxsL2Q1YVg1RDdDL1U2bkNDWFU4ZDlHRy9ZVGlN?=
 =?utf-8?B?NUJyUlNaN29KbkZiY3BqaTZTYUJiVEpvT3B3d2RHYlhCa25LSnoyRUlQZHdC?=
 =?utf-8?B?SmRhMzhEd0s0TTFadFhOMXNSSXZXb3F0eGorZE12eHNIQnM4eDNHNzNvL3BP?=
 =?utf-8?B?b3QzZW1lSEcrWisxMEcvdDlHaWFZMnB3WnFPLy9MSGdMT0VDRHB6ZW9JUHNY?=
 =?utf-8?B?cVhDZDBidGZaV1VLRWpFKzRRaW81OVJWNllDYTVhemNsRjVGYUc4YWV0Wnly?=
 =?utf-8?B?SVd4VHhtcXYxSDZYckRzWkw0N1pEQWZkc0VZL25kWTkwSXRUZEovM0U5TDVx?=
 =?utf-8?B?U3BOUzNKem5ZMC84ZXdvbzY4RHlRaHpWM0QvMUhHVDFZY2owcW02Y1NYZEU4?=
 =?utf-8?B?bDBHMndkZGkrR1R6QTRqamNNcWZhUnovVnVXUHk5T0duMXJ0RHBudTRZbXZM?=
 =?utf-8?B?cTFsdjE3cUY2bW95Q213K1o2aVhpUVBsM1ROR01wTlN1ZmJyVUVPcFBvbzRy?=
 =?utf-8?B?TjhZQk83R1huenR1S0cyWHZuNUE5Wi95L1NDeUNkWHJ0M09NN1JxcGd3UUww?=
 =?utf-8?B?UllZNklFc05OK2NpS1RnVzJSMHc4WGVNQk5QQ3RoRmdqVXlFTkpkeXR1dXM3?=
 =?utf-8?B?bU81a01hOUhTOXdMQzJSVVYybUJON1NCSU9MSUYrQkdJOGdnbDBWN0NGdysw?=
 =?utf-8?B?ZG1iQkljTlg3c3I3OHpHSnBwTzZyS0VTQmhFQlYwWXNsQUU2dk12cnByOVNI?=
 =?utf-8?B?T3dNWWFxMlc2bjNKcnZwUTJ6blpBektuYjZkVlZPZ1RrZnFLcHZMSFF5MXZq?=
 =?utf-8?B?STIrU3VqWmd2ZEx2b0YwbytkVFBWbVJ6dFJQd1UxZ3p3QnE0ME1PcXpBblZH?=
 =?utf-8?B?NERnQUxZTjZLcnR1OUt3RzVYK093QzF0VkpNbWppWTlhRHZXeFIyK3h5OXNI?=
 =?utf-8?B?amhnM004K2xKVTNXQU5YV2hMbVY1MkdVRVVSOW1ybHdhY2ZmTEpHSHJ4UXBG?=
 =?utf-8?B?WnNWK1dtMUJqRUkvdEVXdjlWV3kyczJ3YVhMRmhWMGwwbXdEQ0xSZURnZjBL?=
 =?utf-8?B?UDNveU1BV3RhODJlcEZicDFJdU13aXBTU0g0UzRtMncwa3ArRUpIRjdreDVV?=
 =?utf-8?B?dlF6alJvb3cxbkRJZ0NKOXlucWkzK2RmWWlaRUhLemVCRlF1eDk4SGhweFN0?=
 =?utf-8?B?R1lCbk1GaThnSWEwdGJmaVpFWXd5TjAyUlJ3a2pDVkwzV2wzL3B4WTMvYVJx?=
 =?utf-8?B?SWJRbkc1UFpyOThpMG5ocUo4SXR0dXc4Z2lCNHpWL09BZWNCb2djOEUwLzNG?=
 =?utf-8?B?VzJ4dlNYY2RzS0xsUkVBVGtJSDdna0pXUHk3OGluVUNQVkZOOTQvS3pNdzJq?=
 =?utf-8?B?WFRXWE9ieldEY3k0Q1FTTUxKcnJxdWptNkJZZGM4a05iSGZVQitKYy91eTFG?=
 =?utf-8?B?UE4wS0djci8xdEFOazVpeDZGQ2ZsQ2o3andQWmtQNGgwdTB0bityWXR3amlp?=
 =?utf-8?B?amlYR3NkNlgwbVhwa254VEM0UXA2MFR5ZkFRQmFSV010djR6RHNzRis2ZUl5?=
 =?utf-8?B?dWxNSlN4N1hHNTdLamI1d201c3pZWnkvREEvWWE0R2N6YlVndnBMRnBIOWwr?=
 =?utf-8?B?MDBOQUJEanp3Y0ZRN1JpTlNFOFU1VlpRa2Qyc21GajY5SmVwd2xRWmM2L0xH?=
 =?utf-8?B?Rno2MXlneFp1V3hWZTc0TUNmWHV2QWgydjRoQ3pJMTJOWTJGZlRUd2FmaGpv?=
 =?utf-8?B?d2pEMjcvWFpEdmVHL2dra1o4THRWbU1JdXlrRDl6b25yVkRURVAvQ2xPOVhx?=
 =?utf-8?B?WnFwYm5vTkY0NXBaVUwrK2ZvUnY3OUIxM2IvSG5xVXQ1Z1pVNGhjc1RWOGZu?=
 =?utf-8?B?US9WNm1rUjB0YTJwNDNUUnpIVlBMSHVJRHEwZ1FPUWsrdDZBMEQwZnUyV0tH?=
 =?utf-8?B?NVgwaG8xMm9wc2EvUlAvTEJNbnc4TjFheVM1VEkwYjFVdWVaeDFNWTNEcXlE?=
 =?utf-8?Q?M5DtolFLP9DI0bE1z0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4878.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9059e1e4-a962-4013-1f3a-08d9e1931186
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 12:46:41.9184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5R+LesgwbSQQLMIfEaH4Sv60H5EDbtFVyD7ImwfmqeA68k7TlDmANto7S7xQVNhFDvEVuUQPvsJxXdF4Dwq6Qhe3Q/K80drDNmBTokHAyIP0f4uvLeB87XuKB/XPhzA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1481
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270076
X-Proofpoint-GUID: OqUQvOOMOTxThjxqx3ARXb-NPRWMyrCi
X-Proofpoint-ORIG-GUID: OqUQvOOMOTxThjxqx3ARXb-NPRWMyrCi
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

WWVzLiBUaGUgcGF0Y2ggaGFzIHJlc29sdmVkIHRoZSBpc3N1ZS4NCg0KVGhhbmtzLA0KR2F1dGhh
bS4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEpvc2VwaCBRaSA8am9zZXBo
LnFpQGxpbnV4LmFsaWJhYmEuY29tPiANClNlbnQ6IE1vbmRheSwgSmFudWFyeSAyNCwgMjAyMiA4
OjA4IEFNDQpUbzogR2F1dGhhbSBBbmFudGhha3Jpc2huYSA8Z2F1dGhhbS5hbmFudGhha3Jpc2hu
YUBvcmFjbGUuY29tPjsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgdHl0c29AbWl0LmVkdTsg
YWRpbGdlci5rZXJuZWxAZGlsZ2VyLmNhDQpDYzogb2NmczItZGV2ZWxAb3NzLm9yYWNsZS5jb207
IGxpbnV4LWV4dDRAdmdlci5rZXJuZWwub3JnOyBTYWVlZCBNaXJ6YW1vaGFtbWFkaSA8c2FlZWQu
bWlyemFtb2hhbW1hZGlAb3JhY2xlLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBvY2Zz
MjogZml4IGEgZGVhZGxvY2sgd2hlbiBjb21taXQgdHJhbnMNCg0KU3VyZSwgd2lsbCBkbyBpdCBp
biB2Mi4NClNvIGNvdWxkIHRoaXMgcGF0Y2ggcmVzb2x2ZSB5b3VyIGlzc3VlPw0KDQpUaGFua3Ms
DQpKb3NlcGgNCg0KT24gMS8yMy8yMiAxOjMxIFBNLCBHYXV0aGFtIEFuYW50aGFrcmlzaG5hIHdy
b3RlOg0KPiBIaSwNCj4gVGhpcyBkZWFkbG9jayB3YXMgb3JpZ2luYWxseSByZXBvcnRlZCBieSBz
YWVlZC5taXJ6YW1vaGFtbWFkaUBvcmFjbGUuY29tICBDb3VsZCB5b3UgcGxlYXNlIGFkZCBTYWVl
ZCBhcyB0aGUgcmVwb3J0ZWRieS4NCj4gDQo+IFRoYW5rcywNCj4gR2F1dGhhbS4NCj4gDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvc2VwaCBRaSA8am9zZXBoLnFpQGxp
bnV4LmFsaWJhYmEuY29tPiANCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDIxLCAyMDIyIDEyOjQy
IFBNDQo+IFRvOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyB0eXRzb0BtaXQuZWR1OyBhZGls
Z2VyLmtlcm5lbEBkaWxnZXIuY2ENCj4gQ2M6IEdhdXRoYW0gQW5hbnRoYWtyaXNobmEgPGdhdXRo
YW0uYW5hbnRoYWtyaXNobmFAb3JhY2xlLmNvbT47IG9jZnMyLWRldmVsQG9zcy5vcmFjbGUuY29t
OyBsaW51eC1leHQ0QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBvY2Zz
MjogZml4IGEgZGVhZGxvY2sgd2hlbiBjb21taXQgdHJhbnMNCj4gDQo+IGNvbW1pdCA2ZjFiMjI4
NTI5YWUgaW50cm9kdWNlcyBhIHJlZ3Jlc3Npb24gd2hpY2ggY2FuIGRlYWRsb2NrIGFzDQo+IGZv
bGxvd3M6DQo+IA0KPiBUYXNrMTogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUYXNrMjoN
Cj4gamJkMl9qb3VybmFsX2NvbW1pdF90cmFuc2FjdGlvbiAgICAgb2NmczJfdGVzdF9iZ19iaXRf
YWxsb2NhdGFibGUNCj4gc3Bpbl9sb2NrKCZqaC0+Yl9zdGF0ZV9sb2NrKSAgICAgICAgamJkX2xv
Y2tfYmhfam91cm5hbF9oZWFkDQo+IF9famJkMl9qb3VybmFsX3JlbW92ZV9jaGVja3BvaW50ICAg
IHNwaW5fbG9jaygmamgtPmJfc3RhdGVfbG9jaykNCj4gamJkMl9qb3VybmFsX3B1dF9qb3VybmFs
X2hlYWQNCj4gamJkX2xvY2tfYmhfam91cm5hbF9oZWFkDQo+IA0KPiBUYXNrMSBhbmQgVGFzazIg
bG9jayBiaC0+Yl9zdGF0ZSBhbmQgamgtPmJfc3RhdGVfbG9jayBpbiBkaWZmZXJlbnQgb3JkZXIs
IHdoaWNoIGZpbmFsbHkgcmVzdWx0IGluIGEgZGVhZGxvY2suDQo+IA0KPiBTbyB1c2UgamJkMl9q
b3VybmFsX1tncmFifHB1dF1fam91cm5hbF9oZWFkIGluc3RlYWQgaW4NCj4gb2NmczJfdGVzdF9i
Z19iaXRfYWxsb2NhdGFibGUoKSB0byBmaXggaXQuDQo+IA0KPiBSZXBvcnRlZC1ieTogR2F1dGhh
bSBBbmFudGhha3Jpc2huYSA8Z2F1dGhhbS5hbmFudGhha3Jpc2huYUBvcmFjbGUuY29tPg0KPiBG
aXhlczogNmYxYjIyODUyOWFlICgib2NmczI6IGZpeCByYWNlIGJldHdlZW4gc2VhcmNoaW5nIGNo
dW5rcyBhbmQgcmVsZWFzZSBqb3VybmFsX2hlYWQgZnJvbSBidWZmZXJfaGVhZCIpDQo+IENjOiA8
c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogSm9zZXBoIFFpIDxqb3Nl
cGgucWlAbGludXguYWxpYmFiYS5jb20+DQo+IC0tLQ0KPiAgZnMvb2NmczIvc3ViYWxsb2MuYyB8
IDI1ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9vY2ZzMi9z
dWJhbGxvYy5jIGIvZnMvb2NmczIvc3ViYWxsb2MuYyBpbmRleCA0ODEwMTdlMWRhYzUuLjE2NmM4
OTE4YzgyNSAxMDA2NDQNCj4gLS0tIGEvZnMvb2NmczIvc3ViYWxsb2MuYw0KPiArKysgYi9mcy9v
Y2ZzMi9zdWJhbGxvYy5jDQo+IEBAIC0xMjUxLDI2ICsxMjUxLDIzIEBAIHN0YXRpYyBpbnQgb2Nm
czJfdGVzdF9iZ19iaXRfYWxsb2NhdGFibGUoc3RydWN0IGJ1ZmZlcl9oZWFkICpiZ19iaCwgIHsN
Cj4gIAlzdHJ1Y3Qgb2NmczJfZ3JvdXBfZGVzYyAqYmcgPSAoc3RydWN0IG9jZnMyX2dyb3VwX2Rl
c2MgKikgYmdfYmgtPmJfZGF0YTsNCj4gIAlzdHJ1Y3Qgam91cm5hbF9oZWFkICpqaDsNCj4gLQlp
bnQgcmV0ID0gMTsNCj4gKwlpbnQgcmV0Ow0KPiAgDQo+ICAJaWYgKG9jZnMyX3Rlc3RfYml0KG5y
LCAodW5zaWduZWQgbG9uZyAqKWJnLT5iZ19iaXRtYXApKQ0KPiAgCQlyZXR1cm4gMDsNCj4gIA0K
PiAtCWlmICghYnVmZmVyX2piZChiZ19iaCkpDQo+ICsJamggPSBqYmQyX2pvdXJuYWxfZ3JhYl9q
b3VybmFsX2hlYWQoYmdfYmgpOw0KPiArCWlmICghamgpDQo+ICAJCXJldHVybiAxOw0KPiAgDQo+
IC0JamJkX2xvY2tfYmhfam91cm5hbF9oZWFkKGJnX2JoKTsNCj4gLQlpZiAoYnVmZmVyX2piZChi
Z19iaCkpIHsNCj4gLQkJamggPSBiaDJqaChiZ19iaCk7DQo+IC0JCXNwaW5fbG9jaygmamgtPmJf
c3RhdGVfbG9jayk7DQo+IC0JCWJnID0gKHN0cnVjdCBvY2ZzMl9ncm91cF9kZXNjICopIGpoLT5i
X2NvbW1pdHRlZF9kYXRhOw0KPiAtCQlpZiAoYmcpDQo+IC0JCQlyZXQgPSAhb2NmczJfdGVzdF9i
aXQobnIsICh1bnNpZ25lZCBsb25nICopYmctPmJnX2JpdG1hcCk7DQo+IC0JCWVsc2UNCj4gLQkJ
CXJldCA9IDE7DQo+IC0JCXNwaW5fdW5sb2NrKCZqaC0+Yl9zdGF0ZV9sb2NrKTsNCj4gLQl9DQo+
IC0JamJkX3VubG9ja19iaF9qb3VybmFsX2hlYWQoYmdfYmgpOw0KPiArCXNwaW5fbG9jaygmamgt
PmJfc3RhdGVfbG9jayk7DQo+ICsJYmcgPSAoc3RydWN0IG9jZnMyX2dyb3VwX2Rlc2MgKikgamgt
PmJfY29tbWl0dGVkX2RhdGE7DQo+ICsJaWYgKGJnKQ0KPiArCQlyZXQgPSAhb2NmczJfdGVzdF9i
aXQobnIsICh1bnNpZ25lZCBsb25nICopYmctPmJnX2JpdG1hcCk7DQo+ICsJZWxzZQ0KPiArCQly
ZXQgPSAxOw0KPiArCXNwaW5fdW5sb2NrKCZqaC0+Yl9zdGF0ZV9sb2NrKTsNCj4gKwlqYmQyX2pv
dXJuYWxfcHV0X2pvdXJuYWxfaGVhZChqaCk7DQo+ICANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0K
PiAtLQ0KPiAyLjE5LjEuNi5nYjQ4NTcxMGINCg==
