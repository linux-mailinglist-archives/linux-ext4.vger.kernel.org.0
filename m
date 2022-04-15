Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEF35020F5
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Apr 2022 05:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbiDODpJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Apr 2022 23:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348395AbiDODpJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Apr 2022 23:45:09 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 20:42:42 PDT
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3730C82332
        for <linux-ext4@vger.kernel.org>; Thu, 14 Apr 2022 20:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649994161; x=1681530161;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=vGk1lsnNP86j9OW1R7GOAQ+C1vOQ77SdeFSlNImH6ik=;
  b=bYQECe1IYwLsGhk0wIvuDmgCpDkOS2KjggHR0qdMvIvChAJeZz+TavBR
   e+UQIhlEYUpvOH5fznDNt9hJ1AyjudiEjkRTugyXSGiTaZjav9X0vd9Fc
   L1GifqXLdNSMLe1w71vrQafF+YA2Z6WcsCCPKDODGW8z1ZHZs8+uwtduh
   RcyZW7M8HoGuYriBcBO5CWHOOTbLZSHgS5l50ZcBlPZJWEK5AQsHgg2La
   6XjA6yQd1Czk3kFmog0bTSMJb90pb03cbjvbsX+lgvkNtZS63OPyUkOic
   HhpUk6HSWij7YNSMjbWjohVMT99Sq8o28kLjMtmqGcN5GshnlO2GHrDNu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="62054704"
X-IronPort-AV: E=Sophos;i="5.90,261,1643641200"; 
   d="scan'208";a="62054704"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 12:41:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUVIPcdIvSlbxpQDlt8ZQ42Av0J101ylNTlICpFIiXwPHJthgaJSvEO4b/QeEGuMj/XmmP+pJHVCpu6qgsVTywFb+fs0LKzdmO5zQAiwCI+y7K9tP+pEbT1sRJbeRKqE+0WsM2tsGhbTRPvjT6cYmU9TI78o3zYUsKMTU4dVe9f2bHLvWDG2hRy5VC9PetE45aVT326zvYGyoYn3FZpBNiMhOSwXtkZagMofoAuRubt2FrY4TBzikrIPM38VtOcWNjrOpRLVWsAJO6flz0Aw87oM1eFt/IqaQ3c7+tF/C5Mit4h9okst4fdvs12fYELbpu79jQ2ol63y8yvWDwKYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGk1lsnNP86j9OW1R7GOAQ+C1vOQ77SdeFSlNImH6ik=;
 b=P/GF/hSDJoM96QrLJWYCRii5lXCc3uho2XvyOaGne40rwOQfMym/APGJUpIxmhOGm6h/2VAOedjT5FEC2v6SPjJLrjXn0Z2PaKNJ8nxDzXF8YMi8wNpdHJcHC0KCmzyHWL+lhgRG3JzuQEjfozTGI4ZSY//rYu/yhBgYDd+g4Y2jqc/8XXcfipodcCkEioJUSwsWAdtSIGKYjm1/fCcghYS55OagMPzrHF5ETOMh8Hxee/30jpSZb51jefKvO712IWPHu7ZzZMahSCPJymrJPSF0XJZCvNtqLQZNZs3cphlWcBhEAaxSLAiFKVWGgBfliXdlgxNj3p9dExDGCJTl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGk1lsnNP86j9OW1R7GOAQ+C1vOQ77SdeFSlNImH6ik=;
 b=MQhSQTytc9lHI9OeAqDDZ1sRgVg3/NXPEeTNjzFDts76BuJPL/s4mzj4K4DlBSU5fbM0e13pBYmNjbRuNOwtmxVrzXJxI1Aad3kP5ue1RBoqWVvfi4M/fQl9PL2EnxsJXruNgMUiF97vcOTuY3Ep8zfjjEo3tTNznZoQFsfq/p0=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB7028.jpnprd01.prod.outlook.com (2603:1096:400:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 03:41:32 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 03:41:32 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: the question about ext4 noacl mount option
Thread-Topic: the question about ext4 noacl mount option
Thread-Index: AQHYUHqyDoOQ8Mj8M0e9z5OoOeJwrA==
Date:   Fri, 15 Apr 2022 03:41:32 +0000
Message-ID: <6258F7BB.8010104@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b9ecd32-f7c1-4b74-91db-08da1e91d540
x-ms-traffictypediagnostic: TYCPR01MB7028:EE_
x-microsoft-antispam-prvs: <TYCPR01MB70288BC21A3747D19F717F04FDEE9@TYCPR01MB7028.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ehAMDHKs9jhwiiDADScnr5MxEnusKT1yv6GM4BEyYfdJE70PnSRI9aHzvbvGMAzyKd9nwT+q+r8pfDbx8+r2gwXdS8DSRBrbEkLk00BGFSNcYsq/BdqTzGshuBHEsNoJWbitRtAnebESpZ4KrSNymmITkgIm5/QGNabm5sX3vMz8pAtB1tO6Hs7lAnKBYHk511ZgDk1fTGCUhUiSxvZmaYwUz4Ca3Os8AEaWXaNHs9O/mW6kHqV4/6DXid7/kwXgERzd8nHSTSrNJHLZuCFW41FE0TF9nAblLiJzZ9ByhL0hxqcVLQpptbiNg1J/E1vnXMJHnF31NshYg7TT7kVP8UzebtIREDVEozoUdJhf0FUUllISHb8F8PvfBJswfswo+aAxA13HY7OA/zcXcxMGyQBbNl+VSb6E6/RjOFnjMe7g8tsRw3gEmzUTdjtdfDKJ2PuwAjKhUEzGgGaXSIe3vpuctpJOwBTmqXzigowL+1KsrYL0h8SNII2UV0qpNStSutnrs4sEMQroYl3EbJbUg6WDoMC/vaPy8QXut23k7COuWXsUu25+cRJK/XAA6JMBtTxArR6rcMWMHwKt7Zbl1d1faGJSUJqEbcrktldiAxrGdjqUNEM9RaUww7zLKSh6mOVD3aGHIGaI3WR7bwQ2iopJfMJgnj6L52FsbM3JasR1H0NhLCLTWO2lNdyGdUWRt6A7EMAWG5cpQpCjPp4M6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(6916009)(36756003)(85182001)(87266011)(83380400001)(8676002)(38070700005)(66446008)(66946007)(71200400001)(6506007)(6512007)(6486002)(4744005)(508600001)(66556008)(4326008)(316002)(91956017)(64756008)(66476007)(82960400001)(2906002)(76116006)(5660300002)(8936002)(2616005)(86362001)(26005)(38100700002)(186003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eG9CLzN4MlRNY1gvcnVlTmRwZkpXY3Zlajk4cUM4c2NOTEJBbFY0Z3kvWHRH?=
 =?gb2312?B?NFFIRHAxVjVhR0ZiRzJpMnV0RGd0cFV4ZUNxTkFvd3h2UEI3SkpSd01BTldB?=
 =?gb2312?B?emNQRTRyOGZtZ25NTklqb2ExTEpyVXV3eHRvWVppWk1xRTVMa1dnT283L2ZT?=
 =?gb2312?B?OUU1cEhWVmJZU3l6Mkk3V3JGSy9tcU1ZM0VjNXdSd2lmZzFjVG9tZTlhRVlt?=
 =?gb2312?B?RHU3Q0xJU3VpVlB3ODk3dHJSUkdPQmpiWTNVYlBiK1JTNUNwdCt6bzdtRVZK?=
 =?gb2312?B?TXhCUXd4T0FMRGRwRmxaQ1RkdjhhVldTb2xSdlloa1phUkJlK0VnQWhUSUd3?=
 =?gb2312?B?aGtXcko4QXBGbGY0aTZlRUpHREdZWG12cVg2dG9VYk1TU0w5VTZrWXAyckxJ?=
 =?gb2312?B?TEVFTHFDeWhEbm54MGRFem9sMzJNVHh4cUpQTTR2bEV1dHpNOGxQUHBWVlI0?=
 =?gb2312?B?aFdDWS92dzN5cXlRbklxY0JxdEx4Z05Ha2dTbUZiODUwZFkzUnlhUDhTWGx1?=
 =?gb2312?B?aEcwL0xrcGZtZWJ3cys5ZE9hV2dnR3RvMkY3MytkQ1dmUUVBSyt3MklEWExn?=
 =?gb2312?B?U3ZOTDAxQzd5cjBZN05XbTYwWjYzcUh1SGUyNm1yTmkrQmttM2JaUDRoWFRh?=
 =?gb2312?B?QzVZN2t6dUIvbXZhYTQ5NTg3OU16L2FmaUhqWUJUa3YzL2VBMm1MV2E2NTBq?=
 =?gb2312?B?ZTBFeUM3amxVWW5XbTlWWXUreG1zenhzajFldHZhbnhQalhHeG5QYUJUaUxG?=
 =?gb2312?B?Ukgzb05ZTVArNldCSkpiaUV2QWgrL1RUMTVyMnh5ajRzU2FKSWJhN0FVZmJO?=
 =?gb2312?B?TTBaNWpNSDF2RjNSSnY1OWt3RmlhN0l1SVJQSEk1NnRIdVlxTnpQcXRENTRu?=
 =?gb2312?B?T3V3ODhjZUhFT1RLdmNGbkFZbWpjWThJWjd2bUZ0NEFUWjV4aEhldEZPMHBn?=
 =?gb2312?B?UWN0UFgrMloxWWFZcXYyWkpQRzZVM2FQeFN6NEtsM3RvUXRLWWIrR2FlcmVF?=
 =?gb2312?B?NnlNaEZkNDNOZ0JXdFNNYTBJUzZvczJramhublpvY0lCdmtrWnRXQldBMjZM?=
 =?gb2312?B?V2xDL0dHeCtsZS9xVFpZSWRKTjVRQnFvb0pneDB3UTNJUjJGdEd0cy9MS2xG?=
 =?gb2312?B?c3dCVmV5TkgvZTJGNHk1VG9DREhDSzRiL2g2MUYvWHEwRHhFdUdvbGtaOEUw?=
 =?gb2312?B?OXpjY0VCQmxoSnp2RWYwcW9oeFVURzNqRDNicU4wMklwQ0ZVa1BGRy9mYWFs?=
 =?gb2312?B?TGJDalEwVUlWTWpNNFlDbEpaTldRL09kR0UzQTc2RzVYcWh3QjV6SC9CSTNR?=
 =?gb2312?B?NFRzaThSUHU1elJLUEdUZnhNVWhjdkRRMG5EQjlDdVFSMTl3TGVTbHF3aTAz?=
 =?gb2312?B?MjkxbHBzMmQ0d01LRmFUeXpzUEphbkNVZGkzaTR1WEt3WmxTMlRxK2pYNEhm?=
 =?gb2312?B?bzM3QmFwQ25oeGlZU1psRU4vdTBKdFVuUzFNcGppUlJNdnNzVk16djR5alNI?=
 =?gb2312?B?OUdoczRPVXhjcDM1ZmZubE5xMnJLcXpVaTZTN0JmRkhGQlRPdWx3cGxwZDNH?=
 =?gb2312?B?WGR5WVF5bGd4YWJtd2swWm42dklabXlzRkZpTCtHcXg5N0FEMHRqbmJocUw5?=
 =?gb2312?B?RU8yU0FWcjMxZHZ3aGpHbkRxbnZVWXZuM3NzSWZuVitLeFFKWmxJZy9MOHFl?=
 =?gb2312?B?Z0xZNDBtOHF1d1EzTHJ3UllreFY5ZC92Y21ydXlYclNqSWJwUGlQQ2Mxbk1r?=
 =?gb2312?B?QU9PWGgvRDBDc1ZyQ0l6MTBzbTVXY3VHYjY1d2JJcWNMTGZJWjJtaVNISlVh?=
 =?gb2312?B?czVseHc1eHFPck5LUDFlc2NueG02RGVnQlBZT25lb3VQeGZMSU9Ickw2NVZR?=
 =?gb2312?B?cU9JVm5hYnRDTU1WdDkxS21qT0NWelVtTXlDZm9LUVVmZFdkaWpJdzFIc0Rz?=
 =?gb2312?B?NTRaOXU1LzJncldMS3FMYXVQMXc1ckJjNEY4ME5Sc25ScU9vcUt3WWI2NFVj?=
 =?gb2312?B?b0VMUnZDYjQxZkFnUjRBQ20zYTloc3dqT3RDcXJtVFIxd0FsYytpVldXNnl4?=
 =?gb2312?B?YlRTeFk3MnE4Rm11VXBRMFUwQTF0bmdweDE0MFJvb0k0a25mQjJHMkNHRXlH?=
 =?gb2312?B?dWdJeGVOQituUkRWWFRkZk41Tm9FeVJDalgxZTMySm1nYUJPT3Q2dDlFUnYz?=
 =?gb2312?B?RmFxeFFTd0EybFVtQm0yaHNUS29xS0ZOSWgwNmNUMFB4WktBaHBZREdvdXZr?=
 =?gb2312?B?M3ZDVUlkTEh6ZkMzSXI1RDM0V1dzUko1NGhXdzRQeFc1Y2RHTlVVbDArM1FX?=
 =?gb2312?B?MG5aNFpNMzljVUFIOHhBbHl5NzZqaWY2d2E0MjlOZWgxUU9EdCt3MlZRZkwy?=
 =?gb2312?Q?n1VLp9nsSPVCHlIgAyTg27ptO7BgM/yMgkg3v?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <3CDEA066B9D3D14E87C510F3C53BA7EB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9ecd32-f7c1-4b74-91db-08da1e91d540
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 03:41:32.0404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcDwdA02ekwg7p6Rxl+Js5eWacdtYYZ8rXuHnTjO2q31Mca3iBTt/08dZDcr0/GMBKLEjZx/axw0gwEqfTDzpAfz2AsCStpy+W7RIVOVxSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7028
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGkgVGVvDQoNCldoZW4gSSB1c2UgbW91bnQgb3B0aW9uIG5vYWNsIG9uIDUuMTgtcmMyLCBJIGdv
dCB0aGUgZm9sbG93aW5nIHdhcm5pbmcNCg0KWyAgMTc5LjQ0MTUxMV0gRVhUNC1mczogTW91bnQg
b3B0aW9uICJub2FjbCIgd2lsbCBiZSByZW1vdmVkIGJ5IDMuNQ0KICAgICAgICAgICAgICAgQ29u
dGFjdCBsaW51eC1leHQ0QHZnZXIua2VybmVsLm9yZyBpZiB5b3UgdGhpbmsgd2Ugc2hvdWxkDQpr
ZWVwIGl0Lg0KDQpCdXQgbm93IGlzIDUuMTgtcmMyLCBzbyBleHQ0IGRvIHlvdSBwbGFuIHRvIHJl
bW92ZSB0aGlzIG9wdGlvbg0Kb3Iga2VlcCB0aGUgb3B0aW9uIHV0aWwgYSBmaXggdmVyc2lvbiBp
ZSA1LjIwPyBPciwgcmVtb3ZlIGRlcHJlY2F0ZWQNCmZsYWcgZm9yIHRoaXMgbW91bnQgb3B0aW9u
Pw0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHU=
