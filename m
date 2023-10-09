Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9962F7BE6F3
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Oct 2023 18:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377324AbjJIQua (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Oct 2023 12:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377660AbjJIQu1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Oct 2023 12:50:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC039E;
        Mon,  9 Oct 2023 09:50:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EY2t0011918;
        Mon, 9 Oct 2023 16:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4Og6h+UVisSHHFXAKH7vSlXEf3MlaDEahkkmqDkN+nY=;
 b=KoiscqmBk/TuZnL8jsfRkxcxIooZ/05ysN5QBKBwAEDcH3x1UQFd0z8Z7VFMRWUHOZQC
 /dfikQ7YgA/VfErCtFkXk007OfAHY7sG6KtYiufm7PXXfjYNWYtoJaFxtkO/neLBVzH2
 3ZnOHsOqFf+JzKYmWN7RBY6XH0JRKqT+nca7cmGEg4deyrWb4Vff6g0/w+2pKq/ND3vi
 a63BwvEXMsgc2IeTpKaNBfTfBHtMU8l6ClUWGJPg+/AXSjiwVFRp1mBSIbTbSxUUDVLr
 vCKyB2yo19FVc7pRMwMWK92yD3qWiQOrU0xEOLsyN31iHVtxIqDlur5pdVBlDeb29lF9 4A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89rmf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 16:49:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399GWHVs016360;
        Mon, 9 Oct 2023 16:49:57 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws5crvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 16:49:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRBVyM1CqtXIrGp7bWPfdTZwX+csZrguKld4wftoN2b/iGVpNc1iK9/7RzZXgpnMbHMFfjNtp5YbuTh3LhM/iNVBzfJhqU5qvK0RC546wbO2PzZMWZ2WusYyEQaME8d3+jI7B1y1hRtPV45yyFofYn1e29Wm235npV1dVPOW+Sq/ApS6wPwes2vcqfh/uPkb/ulgTgVS5zOk8wsXeB4mmmkxIsozrgr4PToXucr/OSn4q9dfdpR29KGOnTCByhq24wOTLflg22ZTKcE93ykTr2MHJIwQza6oMDLyA08HdwJYCGAyE3EJPONTaCfMCrW/QWe9zBZ1J8In5eqQ/QG7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Og6h+UVisSHHFXAKH7vSlXEf3MlaDEahkkmqDkN+nY=;
 b=loM35crEcDAS0iqhdcPSgVPLXSjLjuLHgXGdoPVoMEpJUQnZtWvrSNchj67o2wOVIHH09rnSEEUEzOpQWnuoUVLybHYyqLIjI3iLsOkv6Xq7KTdc11ozmt2l3LJwfs81MHk8vhH4cDnkdrnoHiYF8hNJVhuqmjcclftTuf6Ztuyknaw+YVtKWNDJIUW/WeFzDTa3EvEZmr655CktKRbO5w8s5yu9CVjy9YCwyTs6yAXTowVHvNW8cFYkfxiIR+EX/sXzEfpXO54hvtmKsUhmjWRhd8RHi1vMSWfMPVNm7JRhjJAHGevzQdup1TaX3mhDxApQtgZocpQiDLknqAc4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Og6h+UVisSHHFXAKH7vSlXEf3MlaDEahkkmqDkN+nY=;
 b=zh6Ccm5kHjIHDgMrVzIU/Mp/USJcF5g6c01aTnJCDqJLeefY0/kM0LwYLgln75D+5d97UtnoriBtXObxBLBXEwqJ0Encno4eheiZXsul76JbApADx83ay9+eooodajIR4m+tbl6tQpwdGB9inmD7VT7tbiIltjKvldybaRxbO5U=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DS7PR10MB5327.namprd10.prod.outlook.com (2603:10b6:5:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 16:49:55 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435%4]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 16:49:55 +0000
Message-ID: <ab7c4f64-c577-4345-86b3-ac544493bafc@oracle.com>
Date:   Mon, 9 Oct 2023 11:49:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Content-Language: en-US
To:     Max Kellermann <max.kellermann@ionos.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
 <20231009144340.418904-1-max.kellermann@ionos.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20231009144340.418904-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:610:cc::11) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DS7PR10MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e62217e-d3c8-40c4-cbc4-08dbc8e7c3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wvVJL9yw5B0ay+c2h29Y4CXMlG8RPlHxofz1Gd58/FADhtQ3yvra1I2Su6LivwzhLkFaeSonK8L7tEzRcjXbUt7D1YwTHa2cIGOICp70KiizDoSQ2oP6ArzaLY1zV504ieUS8HpcvSnFYbMOYe6DHgN+MAMy1UgrTDuyENm4hI50xGv4LaeJTKE39xPkurqoLwSFTtlygj3BNkKQz5z78aoCfmdVjB2a6sSVNmWi9awic+Lq7G5/gt0l2I3T80+DTmVc8esR1EJo2kyNmjCFtAshl4+k0fqwB3jJ0KhIf2Q0/rpIS71aLsPwBIXm4+RFYdgVX6i1A8zxmhoGLhpznoe9Z400tr9mlj/nuNV2LylEo9snuWTeZqPD1RCk8GS7MEbsuQzp1SKKfXky2lx2RSnDdLBGOTfHTsEctPVE+Fx5OtKW4s+AsWmJLLmJkzQy79LykZ5XCb//Y2khVSNwGqvpM12OQU69oaDnjqHHDqhzIC/e/h5MUdZH9XdKDFzxZyshxVwcFfaClXv50Jb3Q/Nq3p8Jl4+4no+FOl9IFTdhWYYg4oSR5YuRDDqsjbn/IQakwf9J35+CfDzP1Pbau832gGV8Vq5Ra92J/c58G55uXp5cgMJyPUb7q+mCBWYD2ngIVZdUdFTotHrTixH+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31696002)(38100700002)(86362001)(36756003)(31686004)(6512007)(2906002)(478600001)(5660300002)(6486002)(966005)(41300700001)(8936002)(8676002)(44832011)(6666004)(6506007)(4326008)(83380400001)(2616005)(66476007)(66946007)(66556008)(316002)(110136005)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEYzcnA5L2Zmb3l4SFNDMUZja0pMR1RWYmJmNE1CQ2ZmbnJYY2puVjVndDNs?=
 =?utf-8?B?Z0MrT1g4OHliVm4rYjZSd2x2VG5RV1BkRm4yZUtlWUI3RXBiQS8yMFdiWGw4?=
 =?utf-8?B?LzFtMjVmR3ZZUWMweTF1Mnh5RExTczRzQzNaUkd5NndPb2xjcmdVd2d2MzhZ?=
 =?utf-8?B?SUlHTGRNellDbVpPNVNudWxOVDFSUzRIdGpSbVJodVBRRlhsMHZ1S0dVNDc5?=
 =?utf-8?B?N2djN0VkcENzVDZGT0xmVWUwVUZiU2hjNzd6cnpWY3EwbGViQyt0MFY0dmtQ?=
 =?utf-8?B?L25SZ1ZzMnZQb29OaGdqejR2Z2lPaU9FR0xXSkNlNGVvK3pKZE91cFVoRDR0?=
 =?utf-8?B?YUtOSzdydXZYRTdLZWNFeDdRREJsRXRaNzVndEo3Vzc0azQ2MENxNFBOY2ZN?=
 =?utf-8?B?eGVkaFVIdU83OEFaQS9BQjhDdUs4Y3FEOVYveThQV29GaUFWZ3dZenlYNk8z?=
 =?utf-8?B?TjdETkcrcTFyVWJEcldiY3V2VkhRV1Uvc0dqTTRVU2tzbFo3UlZsSVBrbW5n?=
 =?utf-8?B?S0psdVprYTNWQkxjTDF5WEJJbTZnQmxjY3FGbXNCTzFvbk9aakptdk1jV25p?=
 =?utf-8?B?YTh5SlVaYTNpQ2JZakFSYXFMT2RnSlRnQjBHUnFPUXRQN05YNEp3R0lLTzVv?=
 =?utf-8?B?RGdBQmVNc2lpMEZRcllZNXdGdUJIM1lOWUpTMllRd3BLNEpJVktXQ0dWUi9n?=
 =?utf-8?B?MVpaNGVRUlhJeGlHVGI3Qk5NZ2s2RXFYRTFkVncwRkluQ1gyMVUwVGVQMzVv?=
 =?utf-8?B?SDdnWG9KV1hQaWdncWY2NXJZM1h5NHM2NDBOeFNwV0ZlZzFiNDZXdVRvKytq?=
 =?utf-8?B?dURXV2tzQjczcVI4bCtFMmZWYU00NWdXNVJkTHcreE1PL2M0cWdaRW92bEYy?=
 =?utf-8?B?ck9HTlZydURCcDNSNnZXMGRrRVAzRjN2c1FvQllxSUJ3TFVmKzRnV1p2clln?=
 =?utf-8?B?S29yZjJ3T3BCNjg0clhXbk5rRksrTHZUUzZKTTJHck91NjRJWkZPbEY4VGJN?=
 =?utf-8?B?RHdFdDhMMmdwaGFGK1pBMUhOS2RQM29yZE9ub0pEYmRITEJHaFl0UGNhWERz?=
 =?utf-8?B?clMrWG1XeUdkbzR3RCtqUCtTUHlldVE1RUoraXpUTktRNm1CczNudU9LMExi?=
 =?utf-8?B?eEhzNk1vbnVQNTc3RVdpYktNbmNFUDJmVWl4M1pkNTZZSzNENnZ6bFI2aTZS?=
 =?utf-8?B?OEJzVWJ6ZVhyWEE0WTV3VC9NYWV6bCtuMW85bXJjbjQ4Z2xrQ0dVNDhlWFE0?=
 =?utf-8?B?WmhGbEkwcXB1OWo3dCtROTZPRU1tUU0wdExRYTFzcGF2Q2pselhSRW9Oa2Vu?=
 =?utf-8?B?ZS9sSElsMHNETWNFbHplNk9NUHl1VUpHMHYxV1dsdmF1ejRldXRkelQ4Ym5r?=
 =?utf-8?B?TGQxK2VsNkQyNG5SQ1E5dEQ5VHhxQXRSWUlMVkRWLy9tSGoyOEZRQUprLzBx?=
 =?utf-8?B?U0VLZ1UvTTdjWUo5emNmWFRsMkM3TjAvdWhBVzRvbVJMWnMrU3ZOL29xY0pS?=
 =?utf-8?B?VU1TS2FVcm5KVGdKd0s3Q01oWlkvaUFxNnlocDBGSXpEdWdjZmFrWk9UVkRQ?=
 =?utf-8?B?RCthNC94N1gyNGY3SE9UaVhTWmZmaVhKeXB6TDI4QzlaYnRYT3V4TjExN01T?=
 =?utf-8?B?RFpaUVB3MnkzbHMrQWNtMlBGdmgwVm52UUFvdzd0Qy9YRnpUYUF5N0ZxcEVk?=
 =?utf-8?B?dUhvUDNqTDdYVjBCV1lzbXVQWFprSUFmSk9oa1lRUVk0VmFwYy83eFdXd3h2?=
 =?utf-8?B?b0NqSXZpZW5KZWMreGRnNkxzVmViNlZpMm1TbnlqWEpYaGNkNzJ6ZXp4R0Zs?=
 =?utf-8?B?cHBrNm1NR3FQTnQwTU12YTBQRzkwZ3d1MG9pUDFHRlJUMm5Hc29DZGYwaXVX?=
 =?utf-8?B?cHRFeU5oN0JueEFZbDUyOXZ3Z1BBZDRpRnREaFVFM0R3dWlQZFhFRndOajk5?=
 =?utf-8?B?WVJIcnpMV3N3elhYYjJPU3A5N1JEZ2hqdndTM1FKT2s1MndTUFJWY3hLektU?=
 =?utf-8?B?YzJNa3hCVHBFRjdFTnZ4SXZGY1dtMHhxeFdsZlYzdWxlZWVTb09TS3BEUTlq?=
 =?utf-8?B?UkNMbzg5WEJMOHFCNEpGK3VTejhFYlNOcnZ0SWsrdjZxOFJHNWFHRWhPL0wy?=
 =?utf-8?B?VlRtWEppWlVIR2NvWlgxN1l3R1laOGtTR1Y2bUkyQVlnNXVOT1JCdjhjS1VQ?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UlY3RFJwTE9KWFZ5ZEloenMvWXh0eEcxMmE2ZG51QjdDTXJyNEdhbmUzbUd4?=
 =?utf-8?B?NVdVN2U4UytyL2Z4SjVHWW85WUIwcVIvUFk0cXBVVTBqV285aEw2OUhQUXAz?=
 =?utf-8?B?WHErR2tVaDNPSFdOR0tudlA4bHo4UUlKZlh4d3RSNGpjcEhqQ1p6UHhqTVU4?=
 =?utf-8?B?UE1jUy9KZnZOVW9LNVBtNkUyK2QxdXMrd2xMeDRCVDlIZE4vT3ZEbVBCUUF1?=
 =?utf-8?B?bTNIcEx1dnFVNVh4QlFtZDZWN1JjZnowdi91NUNWbzhZVTNmNkRsS0hTRzdv?=
 =?utf-8?B?RmQ0TzQvWmdqdGhFVTJLQXBqOSs5ZG9WMXo3NzcrZUFCMTY3QTZuZTROQnFE?=
 =?utf-8?B?dmY1NTEvT2dScjgrbUJ0SUpYTDBXV3NpM3o3QUZaT0hmR2xzY1VNc3hZbk50?=
 =?utf-8?B?VmdYZnlrbi9Nc0JDVmlJbThRbDlzaGxldmFxMzR1Tk5FWTNoV3RGRUZaQkQr?=
 =?utf-8?B?blFrZHVLMjNsYzI3WTBBR0Y1VHArSVIzUlEwZE85VW5JUUZEeUl2cmxJR2dy?=
 =?utf-8?B?VjBCQ2RtdTk0VWRTWk5XZzdjRGxGRUtVREZvVXdvVDc2eDJzTUF2SkxCNyt4?=
 =?utf-8?B?OTF5Tko4aU1sbGtidXVDWE5ORGhzYmEzbTRTUnRxellhZm13L0lXUHEzYk9T?=
 =?utf-8?B?bmRrOEFNL2xQaFlrMzZpeEhSNTJTdjlPY1NOYlpKNVNBWXo3MldyQ1BzdkpJ?=
 =?utf-8?B?U2p2OTUvcGFueGVIVk5jeVZVd1MxVXRZSko4Y2dtUjB2YjBUQkdLNVBKbDhz?=
 =?utf-8?B?bHJKWEtMcmpVMkRxVVF1NStKemZCSjRURUFmcDdZMisxUk45VHI5UGpPYXhj?=
 =?utf-8?B?Z012TnRmV0Y4a1ZObWU0Z0htVEc0eDJxTFlMcFZpbGJ2dnhBUW53N2Vlb0dq?=
 =?utf-8?B?NktCMVB6TytXR0MxYVFxbmIyZnFjWkRBaU9jcmlFZncvOUdqSUJDWHY2MU0y?=
 =?utf-8?B?Ymx6Ym1sU21DaHJRWnJtM1RhbUZGVlY1andldEExMnpBeStPRGZZK0FLQStK?=
 =?utf-8?B?MlRFOCtCNDU3SVFwNWxWSGFnNDhtRVRzeUxGRUQ5cVVGMnZlWEo5clVOalVJ?=
 =?utf-8?B?emdJSk10YjdIdmcwWHhkRkk3aFNBbFRvUjBYL2tRNENlWWJ2R01lMThXUzI4?=
 =?utf-8?B?RG1xMW9aUGt1TGdBajFPb0NIU3V0OUJlMk5vdlB6a3N4d0l4OTZ4czRsOVND?=
 =?utf-8?B?Sm15WWVTWTJPSDNGNlQ3MzhnZ1hQbGtCRjRJam5qRFN0SlJBWUhIWVlXLzFH?=
 =?utf-8?B?RVRGcFFLRSt5YzI4eEFsN0FHZTIvNk5wdWJqZGJqNTVvOUl2QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e62217e-d3c8-40c4-cbc4-08dbc8e7c3c0
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 16:49:55.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cddpRDG+s7Y7uq0rYgo08SCYEYBLf5VVpewLL0vTVwBz8XdAG/YcfYYy6eIx71NHosG5yDcKIMNb28GGwLufwCtiyyNuPEpupp9eZBYnN3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_14,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090138
X-Proofpoint-GUID: zumcbI0Qq6AB5-vX1po3pOPqgPOptNVD
X-Proofpoint-ORIG-GUID: zumcbI0Qq6AB5-vX1po3pOPqgPOptNVD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10/9/23 9:43AM, Max Kellermann wrote:
> One important implementation detail of the posix_acl_create() function
> is that it applies the umask to the "mode" parameter.  If
> CONFIG_FS_POSIX_ACL is disabled, this detail is missing and the umask
> may not get applied.
> 
> This patch adds the missing code to posix_acl_create() and to three
> filesystems that omit the posix_acl_create() call if their individual
> ACL support is disabled (CONFIG_EXT2_FS_POSIX_ACL,
> CONFIG_JFS_POSIX_ACL, CONFIG_CEPH_FS_POSIX_ACL).  If
> posix_acl_create() never gets called, the umask needs to be applied
> anyway.
> 
> This bug used to be exploitable easily with O_TMPFILE (see
> https://bugzilla.kernel.org/show_bug.cgi?id=203625) but that part was
> fixed by commit ac6800e279a2 ("fs: Add missing umask strip in
> vfs_tmpfile") last year.  The bug may not be reachable by userspace
> anymore, but since it is apparently still necessary to apply the umask
> again in posix_acl_create(), there is no reason to assume it's not
> necessary with ACL support is disabled.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>   fs/ceph/super.h           | 6 ++++++
>   fs/ext2/acl.h             | 6 ++++++
>   fs/jfs/jfs_acl.h          | 6 ++++++
>   include/linux/posix_acl.h | 1 +
>   4 files changed, 19 insertions(+)
> 
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 51c7f2b14f6f..58349639bd57 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1194,6 +1194,12 @@ static inline void ceph_forget_all_cached_acls(struct inode *inode)
>   static inline int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
>   				     struct ceph_acl_sec_ctx *as_ctx)
>   {
> +	/* usually, the umask is applied by posix_acl_create(), but if
> +	 * ACL support is disabled at compile time, we need to do it
> +	 * here, because posix_acl_create() will never be called
> +	 */
> +	*mode &= ~current_umask();
> +
>   	return 0;
>   }
>   static inline void ceph_init_inode_acls(struct inode *inode,
> diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
> index 4a8443a2b8ec..0ecaa9c20c0c 100644
> --- a/fs/ext2/acl.h
> +++ b/fs/ext2/acl.h
> @@ -67,6 +67,12 @@ extern int ext2_init_acl (struct inode *, struct inode *);
>   
>   static inline int ext2_init_acl (struct inode *inode, struct inode *dir)
>   {
> +	/* usually, the umask is applied by posix_acl_create(), but if
> +	 * ACL support is disabled at compile time, we need to do it
> +	 * here, because posix_acl_create() will never be called
> +	 */
> +	inode->i_mode &= ~current_umask();
> +
>   	return 0;
>   }
>   #endif
> diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
> index f892e54d0fcd..64a05e663a45 100644
> --- a/fs/jfs/jfs_acl.h
> +++ b/fs/jfs/jfs_acl.h
> @@ -17,6 +17,12 @@ int jfs_init_acl(tid_t, struct inode *, struct inode *);
>   static inline int jfs_init_acl(tid_t tid, struct inode *inode,
>   			       struct inode *dir)
>   {
> +	/* usually, the umask is applied by posix_acl_create(), but if
> +	 * ACL support is disabled at compile time, we need to do it
> +	 * here, because posix_acl_create() will never be called
> +	 */
> +	inode->i_mode &= ~current_umask();
> +
>   	return 0;
>   }
>   
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index 0e65b3d634d9..54bc9b1061ca 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -128,6 +128,7 @@ static inline void cache_no_acl(struct inode *inode)
>   static inline int posix_acl_create(struct inode *inode, umode_t *mode,
>   		struct posix_acl **default_acl, struct posix_acl **acl)
>   {
> +	*mode &= ~current_umask();
>   	*default_acl = *acl = NULL;
>   	return 0;
>   }
