Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4406A761D28
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 17:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGYPTN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 11:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGYPTM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 11:19:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADFA199D;
        Tue, 25 Jul 2023 08:19:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7oaoL025604;
        Tue, 25 Jul 2023 15:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mmBNDVkdb4ckdTTBjq9ZGzV4KojQ2w+NWkaQrrNB9Bc=;
 b=0OYF/FWN5Og3gkbpAgWMGAYQ2Aw3g/Lzqu3Ukwq+FQkgbHjH0AB8/hLstuEZUGLY+rbD
 zyYmQoaIEGgYA2XgIU29ErE71S20gNAUjz3oAnXazrxHhGWPWsXVX5lEYtvZe1h0TA0I
 TSoMfL2XOzQjlOZ4fI7VAAO2xh5xMGq9MSUsIdty2tq3Ud42doOVEfGSUqFaVHfc5WQR
 R9rtl+zm1jsbKTa+CK9bzMYqZUuVqvGUlwXHgX/pbK7qVumamSljipGartO9bSouy9bY
 Yxdpm0lgsmfLnN4FJxdabjPSBwnukkDyZYnTv0dOc2hlxg04V2qtj3eM8deF95ck5+Hj 5A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nun9c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 15:18:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PEs9xK012075;
        Tue, 25 Jul 2023 15:18:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j55rfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 15:18:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBHssZ/lhJlHRHJAQyE1kJjQpzxqi7J9+IADfX6IoY4z0E1e328r/VWSzQixxctIsTiXub+k8h3MGHPCotGkWYVWc9IGU9vZ7JoYZeEQYKR0vdSiQte6NWlEFvW1oDSnHC0LVH4F0Jjua8P/OTJR0UAfdHS9wyg0sKSNWqEd897eFjZB5jxm4XiUkT57I0gnvrNsSJ6xorKFKtTdtfJ01Jz6KQJ7S0+nofOSQ6bWrs81qz/ilOBf34Ta39Tdw1XL8vd2yNfixzhpOlCY5MaLMdE4nyzUGqCJMyzGN3rsH/hZvTSSUhfAnoNp5slfV3EqXGlojgNF7R8hxL3STNig/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmBNDVkdb4ckdTTBjq9ZGzV4KojQ2w+NWkaQrrNB9Bc=;
 b=oI50MFRiY7swg+U5zDa67I4d8Ghye9BtGKoTk1fTa2E57UxPDW6ncvGIOMTe+s4awtBwWMUbjBekSKZEJEDoR7D9Cf6y0rkkYhH2I3G3sqlHj7hZoSLeV+ZTn0zXXVo4UwRlkgatLj4Gm0ldjfIe6/UJjV/29l/D/EueBXnxIDNwF/oBs+v7BmKZvMsaMF3kOCE9S0rwAHjJ9IcuJopFua8vHfvEZnYqVTiNyU2z6D6+oBnUInjzrx/DCIFQhBHXlicV5Wtki3Q9qwR9W3I1sLj7rx7Ojgy/BBdkkS89owbw/k0aKXhlooXvNDOYvfzppH63yf3fNH4FQR+fg0oiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmBNDVkdb4ckdTTBjq9ZGzV4KojQ2w+NWkaQrrNB9Bc=;
 b=F7PV5sfMqndScvTQQWM56/16a0SxcwY85yaJcesYkA+zr+jPQryATc0fCLTXuFuWkCvXhrSF8e7gX1WpoQ7PQWQc63di6iVDEmuTXSZbtqB9+JYvNhJ1lB3Mq70jymbKywJv3NNDLN4bcrDATNDIqShzKLB4RWNSq+3y9Zdx3xg=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BN0PR10MB5206.namprd10.prod.outlook.com (2603:10b6:408:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 15:18:21 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::6943:17f7:79d0:87ab]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::6943:17f7:79d0:87ab%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:18:21 +0000
Message-ID: <a3849202-24f9-4ad0-f10c-a4a6f8627e80@oracle.com>
Date:   Tue, 25 Jul 2023 20:48:03 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.4 000/313] 5.4.251-rc1 review
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Chao Yu <chao@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230725104521.167250627@linuxfoundation.org>
 <CA+G9fYuH-jyxJwgEgX4J4+eh=nEEk9aqt4YPNUW9j==mwtw=jA@mail.gmail.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CA+G9fYuH-jyxJwgEgX4J4+eh=nEEk9aqt4YPNUW9j==mwtw=jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BN0PR10MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecfd9a9-beea-4b61-f513-08db8d2261d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIPkJddgmfXCbH5GADmFhAvh+STlQ8wr7RPzttaj8gM1ljlQZzFEWT9g4xDmNpFwAbT9XVDSuIqPB6P3XcAJO3toxa5KyJEDIHYEeY9rM58f5bH4XpCaekHBZUWdD/BOwHOVhtixMMRu5d+m8TISxw5ezYr7sNixF7QzqgETSMP9VjHZ6K/JuUek3RHgUtXiLh3/Fmu+JIbxnEnWpYz8Mn0eWE4tPq3UygXrc86g3nw1NeuG7K5xbjz5I6XXCjVLTmhhSazW17FxnhGeMgn8/y0UUAXzB2fQ4l3BnRqaT5W5WnsZgsZWPpumXqDg3HxKidC4OWusF3lU3j5nCD2psKA57ePK3sFH+226X7EYd7CEczvb5PRxTjzRKQJt0JVgO5kJusAITbuyYngweJFibrRSHGVAuDYDv+//HUaJ/vUa4/tweAoD29MqG6A1WWqqI+boV4tu0pkJ1Umcw2TYXM2CcVNYIO28zVOZvOp+QQxX8oY2Xb6MHeG0q6jT7mlzZK8icqdUbiW354TLtw2PI+pN8TqBzPw8Q39MZBFkR+XPL/m+0mjsLGedlhLZ682no/X9V0xGhdp/AoELRn83FyhJXFB4DydM/EcjKB92IRw17PvzuINr5vtHBnkYYC6gBkpiyXPHWjjxvhuR+VVNqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(31686004)(36756003)(31696002)(86362001)(2906002)(7416002)(83380400001)(186003)(107886003)(53546011)(6506007)(26005)(6666004)(38100700002)(6486002)(54906003)(6512007)(966005)(478600001)(110136005)(4326008)(8936002)(316002)(66476007)(66556008)(2616005)(66946007)(8676002)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enVwcCtzYkkyRWwwRlNzTVBiaExrUXZPNHAzSW1FY0hsN25iRnE5Y011b1gz?=
 =?utf-8?B?alV4NTJEZ2ZKSjg2VVA5NXNDTlpUTnk0M1Z5RVFTTzZ3QXhPTW9vd3J5RFBO?=
 =?utf-8?B?VC9TL1ZsSlVXeDBDMDc2Y0wvaUppMGw3dFlQLytmaUVHNUE1UXRRbVRtTHhF?=
 =?utf-8?B?ZmFDVFNEcVNFVlM0dnh5LzBZcTQ1YVg4RWFDcnZGVzdmNHkxVkVQQmQvWlAv?=
 =?utf-8?B?S1RocUprN2JmR3NkMEo5YzN6aE05Qi9oYjNRaW1vQ3FiRGJ2TGs4cjlIMWFq?=
 =?utf-8?B?TUxoVnhHeXA4Ym5meitMaERWdVNMakM1YU8ydHIxZzkvOUZlV0doYzRaUm8z?=
 =?utf-8?B?RzFCbm0rTzJpUG5LaVpDbWFMZEhJN0dZOVA1dndhWVVBK2FFN0VWVEpaU2xv?=
 =?utf-8?B?RXNaTVljckdHbWdySE1NV25iQ3BqRjhYTTdSTVUzQThvVWdUQlNoRzR0OEpw?=
 =?utf-8?B?VmFCTVFyZVNCcVcyVDlBU0xLS2gvejJyVEZMZ3k2UFFBYkQzbGN6MUMyeWgr?=
 =?utf-8?B?SGt1ZVErR0N1OWx5ejRXVjQ0KzEwVXRqQVJraFJlZU15NFMvcFloUDZ2c1Qv?=
 =?utf-8?B?RHhiN1p5VE5tRU1salllZUVjc1JIcjYrblYrRjMydGRvbDVsYzQxTUVzbjFB?=
 =?utf-8?B?MzFmRElCQzFmVktSZ3lsMm9PQ0phUi9tZ01SaTNJQ1FJMU9RWDRGZ000a0Jx?=
 =?utf-8?B?MDdiV0cwZTBOdE9qU0haZWhMRGttbno1dlVjbkhnaWlzcmw3ODAyKzRyQmZP?=
 =?utf-8?B?Z002ck1Wa1JZbzlpNlArQ09sR3BMNEN4c1pFbkszR1JKeGJETWFwUkNXeGJW?=
 =?utf-8?B?aDRVTzRkTjNwQnMvWDh5SjNncFNsOU04SEwzUXhFM3N2YURYaC9EV0tVT3Y3?=
 =?utf-8?B?UWxSdlNxVDd6Nnh6amdOcU11eDc1STBCWks3aHRvbjZRMjJhaFFCSGFwL1Vn?=
 =?utf-8?B?RllIcnFWSzZpeUVTOUo3ckVsWTFPcEVJakhjdVd2NXU0RjZCcThMMEN2eG5D?=
 =?utf-8?B?Qm8yc3ArME5LMkdqdGdtNlh6bTh5anJ1d2oxQ2pqSjZyc1hDckV2OVd0UHBY?=
 =?utf-8?B?Y0VoTlRCWXhRSi9vaFdLVjVUYXlVbmtPN3dNZ05USUsvT2lQM0JPeUxQYUNO?=
 =?utf-8?B?eWFJQWVNWVI3ejFmNkZkRzNzTExtV0dnbHY2N0FjVndKUnhSRlRrMjBwNWdK?=
 =?utf-8?B?clk1dXgzOWxFcEtiUGFDM0RtdXY3NGxLK1B3ekRiWGpTaU9nU0xidkNiclMx?=
 =?utf-8?B?QTRRRE5PelRKNU9oamJEN1krL2VRZDFHN20zTmxoUCtieFdlL2VIVWhxRVJ0?=
 =?utf-8?B?S0phMUlaSi80b1F2QSsxRlUybHJGOW5oTnhBbURPb1pvSi96YTQyS3p6bkwz?=
 =?utf-8?B?UUlQYlpwRTJOZTBNM1BTWWU2Q1JJUzMxdFlxbENHYU1qSjIreXBEZkVVeUdP?=
 =?utf-8?B?dWJocWRmd05HbU1sWkNwSHBpVVRMaWZFT1BabFcxVkFLblJwSks5QjNNUEtB?=
 =?utf-8?B?VEJIRElBVFZsVk12UGRzWE9FZFRYS21ZS0tVNHF3WGxBb2hBVzh3bEV1Mm50?=
 =?utf-8?B?aWxrTVBGRzB5bGs1T3V6MXlpNWtpLytqaFFzNHdqYnNqRHVxMzdoTWpNajBw?=
 =?utf-8?B?MlE4aFE5SlFzTkFYSlE3anpMTnJoUmc4YWFidjUyZTdOK3dWN05idUFseHll?=
 =?utf-8?B?VmVWUzNManB2WTdUUWZJUjJOMHFxNU9MQ21ITVdQNTBlbG1hZmNNSk45eksr?=
 =?utf-8?B?eDRoV3p1NldUbWY1R3NJTmp4TjhoTTVBSk1Ndzg1YUk1SHQ2UUxUcDhaL0VT?=
 =?utf-8?B?b3JxUDYrakZzQ2tnelFPQkpFOWtlNjR0RGc4NTJLT0tzSjZPczZsUzJOUktw?=
 =?utf-8?B?ZS94aHhMdmdyakh6ZUoyY2pLZ1E3S29SSGY4bE00dUduN3llc3A4MmFGUkF4?=
 =?utf-8?B?Y2duQlp4K25JNW5IR0JCdzhyY1RrMWZHTnE3SExnczRQeVkxdHdlZ0dRL1lD?=
 =?utf-8?B?RDJVekNKNXRpV3hvRlZOVUJtK2xPZGJpUjgzK3RndEFVVFByak1LWmF6dzFE?=
 =?utf-8?B?amVLRS9WUkxQNEYxWS83RHBGNC80T1VZWHljZmxYNGlvREVUcTF3S2VZWEJu?=
 =?utf-8?B?MHpMeHlIdE5WRyt6MXBtSU9PZFcrT2JYU2tuQnRySGFNNDZ0Y25oZUhldi9a?=
 =?utf-8?Q?UaqQX0s6XgIl4U6qTXrP3CY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NkJ6SU42RUtUU1Jod29RVkt3WlRMaUpUVmhPcGJYaXNPREtITFpveXVqNlNk?=
 =?utf-8?B?RXVGNmRLZXI4UERGdjdsMUc3Q096aFI5ckN4SVpVL1pSZ01GaTZxcklFNTV6?=
 =?utf-8?B?SVZJN1pHQjYwellRTEQ3WEdyQ1ZsWi96dFVPemhiY1pWUm1CS2lLRkhQM0ls?=
 =?utf-8?B?ZzdKcjJMQmcwMnQwdDFzaUZxZjlBYTd4ajdSWGZ1ZSs2Ujc5aWJMNHhSSTJF?=
 =?utf-8?B?N3FVdTcrT05aZWczejNzNHV6TlZkanl0OEExc1NYR2NyVUhKRVlwbk5OSlNu?=
 =?utf-8?B?Wng4N040R3Z4aXBqeFR3OVJkYzI1TXc5c1hDN2VIT2dpMDVUdHI3ZndNZUhL?=
 =?utf-8?B?b3NVd2g0WEJLc2R0bU1rTzdqRGJ3ZkwyNDQyTjV3MWEwZW1TV0tqL1piaXl3?=
 =?utf-8?B?bXJRSHQ4VHJnS2NSZFk2OTI5TWFKTUdYOEdHSlYyZlFpUDNBV21GNXhSMkI0?=
 =?utf-8?B?RzFtdXozcHNxbHZva01jREpaazduYnhxRzlzTTJlSi93WVVtUk1yUzJIeTd6?=
 =?utf-8?B?WWplRjRidGtPb1liVVM0a0hQME5QeXRTODJPYlFOQUMxbEVqbDliZ0txZjd5?=
 =?utf-8?B?VFRYZS9saUw4K1llSEZGNDdFWlAxQ3ZtU3J4bURVSGpqK3NKc2NDRmZMSnFi?=
 =?utf-8?B?VW9JelVXdkJVSzE5akYvN25TMFhIdGQ5Z0FCUjVLdEsyUlJqN2Z2ZEJiMmFQ?=
 =?utf-8?B?bzU4QjFrem5qUWFyUjRBVE0rdWRrbjlnVlFyWEhIZ0hoSm1ubXYwT20vUzBo?=
 =?utf-8?B?Wm96UGZCTFZoRGhXRE9TT3lNbWNKYTMyMHliakk3eTVsenVncTBIU1FPSitS?=
 =?utf-8?B?aDQ3RFAzUUR1NUZ3UnRMb3oyZ0hFRXR1OER1TVFZVlNZQTNZc2hDYmNzSmR5?=
 =?utf-8?B?MHAxbkdSWDRMQWlKWWpoN1hkdHBBTW9FZXFGTSs5a0laMFdhTTRHQW9wcXVU?=
 =?utf-8?B?QktZMm1Idi8yRWp4TmIyZXB1WmtlYjRDbnRFTllybnpDa3VDMGZmRjhUNWlH?=
 =?utf-8?B?N0t6clJobUJCakZiNmFJb3RHNWZrWGFmUHN5MnFCL2VVb3grVE9ob3Zkd004?=
 =?utf-8?B?NVJwWWJBVmU5MUhybDVtSG8vNytlSDNBdVd5MnJUeE1scWhCNUN5OGhURTc2?=
 =?utf-8?B?VHUrbjczbGZncDJxUU0ybTBra1ZMb2Y4bHpmRVRyWEkyeDRwa1dCLzRlLzNQ?=
 =?utf-8?B?eWE2dDlLaXMxdFhNQjJReGRKTDViN1BuYXR6cmFrOFErOWIrT0VXby96ait4?=
 =?utf-8?B?NDZRejhWNkN0RVFydlU3TGxWSDEwVjNzem16cXNNcG5ydkpPVmJFekRXa2Vv?=
 =?utf-8?B?MUtqMVVxR2FNbHRKb3ZlVlQxenllanA5VW80dkErbmdjZ1Q4SU91cGg4cXc1?=
 =?utf-8?B?WFZqb1JTZXByaEJyajA2SGxEdnJrc0RQRUJhZzBxbmxhckJINDlCaFdQWmMr?=
 =?utf-8?B?WFo0cGZFdDZPdi9sNExBMDc0K1UvUUNtWUM1K2pDVlVwNzMyeW0yYWxhcmZ5?=
 =?utf-8?B?cjZSK1d2WXY3QkE0bTBGNXA2QTB2RHNVSzVOMUw4UjBRRWozY0tDWGcybzIy?=
 =?utf-8?B?d2cxdEorTzRBU2hpTUNCaUNZWVVKVi9pQUc1emtoQk8yaDB3bE1jUmUzamRu?=
 =?utf-8?B?d3c1MldnT2J6NHJxUnYrTXhWajF5SFo4RXlra2hwZFh1RlVCRFpjTTZQNGla?=
 =?utf-8?Q?z+cTEWupq5nKQ2EoG3zN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecfd9a9-beea-4b61-f513-08db8d2261d8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:18:21.6231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6dk+EkNjLKff8zkzO0Ry3xOkHuBYonIA01sfStN3dMQxtFsEho/0/tW96g0ZOXaS5VuwtapuPlI2WyJMsJiuQQenF3i7v/IM9drv/JxzqqjVQgY1ZoREu9M2X+0HNP9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_08,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250135
X-Proofpoint-ORIG-GUID: _lugnfiEF8_phuj3u6PnPb5UW4B4WgVR
X-Proofpoint-GUID: _lugnfiEF8_phuj3u6PnPb5UW4B4WgVR
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Greg,

On 25/07/23 8:16 pm, Naresh Kamboju wrote:
> On Tue, 25 Jul 2023 at 17:06, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 5.4.251 release.
>> There are 313 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>          https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.251-rc1.gz
>> or in the git tree and branch at:
>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Following commit caused build failures on stable-rc 5.4 and 5.10.
> 
> ext4: fix to check return value of freeze_bdev() in ext4_shutdown()
> commit c4d13222afd8a64bf11bc7ec68645496ee8b54b9 upstream.
> 
> fs/ext4/ioctl.c:595:7: error: incompatible pointer to integer
> conversion assigning to 'int' from 'struct super_block *'
> [-Wint-conversion]
>                  ret = freeze_bdev(sb->s_bdev);
>                      ^ ~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> 

I have seen this error too in 5.4.y build.

Just more information about this.

In 5.4.y:
struct super_block *freeze_bdev(struct block_device *bdev)
{
	...
}

In 5.15.y
int freeze_bdev(struct block_device *bdev)
{
	...
}

This changed in this commit which is in 5.11-rc1,(not in 5.4.y and 5.10.y)
Commit info:
   commit-id              : 040f04bd2e825f1d80b14a0e0ac3d830339eb779
   subject          : fs: simplify freeze_bdev/thaw_bdev


Thanks,
Harshit


> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
