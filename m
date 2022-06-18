Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5501A5503D1
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 11:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiFRJd0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Jun 2022 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiFRJdY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Jun 2022 05:33:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92914DEA2;
        Sat, 18 Jun 2022 02:33:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25I1i2st005310;
        Sat, 18 Jun 2022 09:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2Vq41MJ78XoMoOm2iGLA5+SIuw3DV/OZiY5bNDMqOgU=;
 b=GGw6inyfAwG0Exrr6O+EPzueapRwmy4oovBwFIV6i1O2sJlJ3cAxKZbPI9tmucnvzHX/
 Zr4pGDzndVDQjsTd1yWdsFfAerCJqD/Y+8XM305AG6jjkT/eY4OaQXXrG5wkkvYzdR0y
 Jq+aLwcNnM5f+9/zh2R7C9HqfZmK6bhBm1dF7MvXt66ehQHeW1bmH9NkS8TwMKo/IhkY
 bX95Td9E4gVIX5X8pTtpZOT6dKGE6BPeKKStreKa30E/zIw8QguATXg0px1PAPPDv7fN
 koAdej2XI42hEHtBN7sdHXPKNnLMdlMne6MAOfYm4qF8rEgFdk25IRgtyAMVbzSYCPqL PQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a08bdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jun 2022 09:33:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25I9UEOT025757;
        Sat, 18 Jun 2022 09:33:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gs550avmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jun 2022 09:33:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeMRO8kluqvDPh7Zqd39kvMe742iaQaR+UbbyrBZcEybeec5QK/83L8npccpHg6Swt2TNYV9lEo3p7R/aAxII59W0KaXU/HCPawzI3IsBe5MSPSev22MtpFAPFvH7dTQftpt6wJeKZAlP/ZlQvCuoacYHVebSLlWFAIpaCemLxZzNImJQQArr4rbzRBf5nbdyOXxirfBwoisJ3fKc8vYcvM/R7TXot+3pvlpZVRmCCDvAEzYERPp6edrxlwCZZ9KLld8orHjcx0HJOq2QjWD6KWWsINOCNpaOGFMyI0JYV92ns7HVUDls/NwCIKynAvzj6o2e2SekbyLF4h7SQhPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vq41MJ78XoMoOm2iGLA5+SIuw3DV/OZiY5bNDMqOgU=;
 b=mX7spy6jqRVws/H9J7fTRj+QkU/Pzeo30mHwDfHA78oYekzLXHC5dzToDN22yYg9lecjFcgpEGbjLQpvym3FSmMsA0NZYM53W6y1w6yABuQGyOLeDes5gdtNZGbTHLooRM4W2a2WNVM9gaf6KH1I41kSl07A0n9NJb73OvsjWzWGSSvr9IIEPpLas1iFPN2/WQZhDtwbhdofBRqJc0opUdP7vD+mTo0hruxSeDlYFI+faafx6LYLwgkTYD2uiLZ51h5H7zxlTE1mTYC6v42eh3RPlLqw51pzRvwSj1mifDPe1wQ9ZgMXTh1/BbwzCcEFkZY39EQu0YfPbBXm2DQSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Vq41MJ78XoMoOm2iGLA5+SIuw3DV/OZiY5bNDMqOgU=;
 b=c+6mCHIbCDFLuiI/LryKTf+surUV2pnrdvcMBCWbCAPuViRevrtmCakAKJH+AQjErvhXqewmGG5oVlJ/spPcGBUr21QzNpcsWxxVvOBf150gMJkr/mGy5wF2L0TiLXecT1w0tGMZ5BnR35HJREMe8mxhPU6rxvKUdlefEQNc2gg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2488.namprd10.prod.outlook.com
 (2603:10b6:a02:b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Sat, 18 Jun
 2022 09:33:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.024; Sat, 18 Jun 2022
 09:33:13 +0000
Date:   Sat, 18 Jun 2022 12:33:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] ext4: change variable "count" to signed integer
Message-ID: <Yq2bzesQ5H+DrA47@kili>
References: <20220530100047.537598-1-dingxiang@cmss.chinamobile.com>
 <165552108974.634564.2634497659089601268.b4-ty@mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165552108974.634564.2634497659089601268.b4-ty@mit.edu>
X-ClientProxiedBy: ZR0P278CA0137.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c427cd9-724a-461c-db1b-08da510d90be
X-MS-TrafficTypeDiagnostic: BYAPR10MB2488:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB24885E86C96B4AB4A38BE9918EAE9@BYAPR10MB2488.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dx4XLTVlzX1q2R+V0DhPJxiCvQ8v/QUwdpUwNIAQaPOTxYW+YgdmeGHH6xn6cxiLjeTF4mzQr7wicYt2C7dr7IBEQ2OHSlAhLby7EeK9z6I73DTJCarE9wcBB0oUNmLKwW/qOr0g0eL4Zca6CZc3TIBJha3jKNAM1HzadfTA1zDn2DX3XCrdKTHm1cTqriR/5F+0JEFPnJmDUEErIvjBpQAkOjIT+XUtHY1qCCLNtQB404CMgL7R/VRxmfwbt/gzTrABXiEFLIRQM9OFujY4MgvGqUCA9EG146BaGzjKuqS+Oum6kkQvVTJpKPhiWXRUro/D9CAosaU/tXF5bJ4OBTU2zoljRtYqPeHe3UNnfQ1jMDmeM3dlP09tc2/p80fgJ1Tc5Yn6bVrvnWcCjkZ4Wsuvx4dovhOcDmoqhFha7dKvwBTKocfMhnNyu55JIcn7I8MC1UUBsgcU4+Mw6PmkKwCUXThSRTwZ40OOYgGsie86um3DrBUCYEHpJfwnMJbczr4nnWFEDkVSEsmi4v6Rj09l5kHKwzn9tgDF7PF2xUdTSwtWxV3/w1XQQmvMZqlE9RUoHbf6I0yqE/mScXdROjrXfrH3O/XGr42+iWSZ+xpEXTjf7bNBQzz7TnBKg8tboOlfa3bjsbbfSFaHlml2fUIS0tMrkKaAFQkWCxDVVptchVKEvFbFsTjhDYMTeVgT6exQkUAw9R3+nDFxMWtASevSPH/uP0KiK+lNDZFHEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(66946007)(498600001)(107886003)(6486002)(5660300002)(6916009)(316002)(54906003)(66476007)(4326008)(66556008)(33716001)(8676002)(52116002)(8936002)(2906002)(6512007)(9686003)(26005)(83380400001)(44832011)(6506007)(38350700002)(38100700002)(6666004)(186003)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLU5ryi/6PaOBnfHnIFNlWHoVnTqDeMlScMow5a1UwHOzNkT41NjMePMKELq?=
 =?us-ascii?Q?HPK3zK4l33wOUC/Gk8Td88AINr9EC9FSZSf6T8CWZQOS5l0HwKLe9jBNKXr9?=
 =?us-ascii?Q?t8yfISfh4BoNWatEAIaDcKIekjsR2ok7zhcmjVZCBArv+nR0eIEuluEfIkp0?=
 =?us-ascii?Q?jN9DifjepEdJapZ/5JvBSTNVDOuBQDCZ978D1bVPsSIi1vN9nWqVK2tY2FOT?=
 =?us-ascii?Q?AAMK+zSOJDN8UEKqLcENlQoyKWRNn4DvCPBIDOQiFlF4H9nkwu/JZLqRs00B?=
 =?us-ascii?Q?czNSd+UwpRM6ZaCuNp4dJgZcDfEjsXXrNdYjbvdg4SI7iQak033p+fnaQRnN?=
 =?us-ascii?Q?Ho26wHvJxIe7/8ViatxqhaKqAbBCWL1+Dry5xR4SULlIw6XT4sezMfwx2wfz?=
 =?us-ascii?Q?9gdGuheva3T20JNjvGVbHFM5LQ89BlTS9wmzqZtukbawA9UC2h0nU9mNxazA?=
 =?us-ascii?Q?ZgoGFXaA13W6bN3jpm1tef74CBeLCq95hBh3LvqhSzi45MngCG2MByZy1LnE?=
 =?us-ascii?Q?tKq8/2LhOElZvjk4BLnwDc0CamBBF9AUOK2yBF5ghaSNtnfFmcmOaWzWhRfp?=
 =?us-ascii?Q?xfO8MhVodg29kIPpUo1ddibQFA8nhlootspTfecGMXr//jdx5YYXs+vpDw7H?=
 =?us-ascii?Q?eHALUvksqx4jYqpppRxGhZKEcB+wDn52k+2UHToIBwyPYF9V4NcWM+UEf7YO?=
 =?us-ascii?Q?EXKy7VRDujISHQV0fOADGUPaBYWK5Fi6ZMzDr3bygS6yDZotIvOmUSYpDrX4?=
 =?us-ascii?Q?LdYI9eV570dyyfBqP99fWKDQD2W69ys/oJ010cmIasTy3DrIcvoLwBlgg+l2?=
 =?us-ascii?Q?nQsXqPfzzrrB7yGcrFQ26fGxClpIj3AD6YvksnyrYaW5NMr2PLDntFdmfiMD?=
 =?us-ascii?Q?8GPfGbliXydV3Lhnj2bD2V6UwL8/L8yEJjadx96g3NB+EbdakMaexgbs1AP5?=
 =?us-ascii?Q?Cqmfc/xE/bfujGk2kE0avzoygxVa2b1z4zNq/JK95f61a8WpIUgL8LDMrryj?=
 =?us-ascii?Q?VjCgpJV1MWQ3SRz6TnYwvISmwa+zRzv04NFjyca6ur7/5Hmle0As9I+ru41M?=
 =?us-ascii?Q?NaetB0FOLJ+xkUj1le63pcZqiebKh/T5+DCjF9hN7uZdesFfWNfN7zQEgYl0?=
 =?us-ascii?Q?WX47GtgAucAr03Y7+YDT1EZUY0VNV+/h9z362h6hRVuYTGby1ilYhDLnJt2d?=
 =?us-ascii?Q?rEk0dX2tu7n9HSOOKKna1VEn2ULNFklGcUsE4fCpwZv8RG7tn8MCnsyg50ux?=
 =?us-ascii?Q?qGPdIEeFs42Tun5fnmgRr1buxVzts0sKymURJn4V6D/lyh21pv7UbQ8Cpgtt?=
 =?us-ascii?Q?oC8ldryzGVrGA41L4/Kuh7SxVMroMPiat8U4Y6xlFPEWXhtesR8oyFP6qJSh?=
 =?us-ascii?Q?RiRNkPbzrew1CdI5P4TOpW5+Yi/MB53DGqwma0gF4Nxde8wscxO3lfy77dQC?=
 =?us-ascii?Q?cP8/MrPKA+zFoOLNWcDIrZll6BbH/upodj65yLqGfVsDlNl1nw8Sgp9llE3t?=
 =?us-ascii?Q?sXE2X8FwrPcUMQdvCB4ZsFvhGKTodDX7x0A/P4FQ462MG2ikActNs7j15097?=
 =?us-ascii?Q?w2SsTvkTvyTMCx39eA9VBsWoTW1z8ugn1lMjUzObyxj1RXctZ5koRFdGk02n?=
 =?us-ascii?Q?pTxRYlS0PyZYDoBCS9+Feit/WwH3O3pc9pm/2adyj0KDB74ajWmqYLT0KB5k?=
 =?us-ascii?Q?gbjYsfqDd+T1l2IJkt6+jvRX2mzI4gp9nWjbuV4BCPzQ6wcOhW39SgC7prs5?=
 =?us-ascii?Q?jenWbnpPbg5Ysl8ZBe5TEv7kn6hICgo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c427cd9-724a-461c-db1b-08da510d90be
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 09:33:13.7291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVx3NtkfJeVDXdjWd7iI5IaHkrx+WvnmBELKE3PUlMoIoXNmzCKFF8DKK+lygwuZ/USygav0/lS04MmYWPonT/LKz3l8jXVshqi6bQyyvJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2488
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-18_08:2022-06-17,2022-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206180046
X-Proofpoint-ORIG-GUID: OwB4af0Rind_FDQ5qCte7xWwzAzxyogE
X-Proofpoint-GUID: OwB4af0Rind_FDQ5qCte7xWwzAzxyogE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 17, 2022 at 10:59:01PM -0400, Theodore Ts'o wrote:
> On Mon, 30 May 2022 18:00:47 +0800, Ding Xiang wrote:
> > Since dx_make_map() may return -EFSCORRUPTED now,
> > so change "count" to signed integer.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] ext4: change variable "count" to signed integer
>       commit: fefb759df063599ad483422eb07ef8e14c612cc2
> 

There was some kind of process error here...

1) That commit somehow never made it to linux-next.

2) No Fixes tag.  Presumably Greg searches for Fixes tags before he back
ports patches.  The original commit 46c116b920eb ("ext4: verify dir
block before splitting it") has been back ported to stable already.

3) I don't know why I didn't send a patch for this bug.  I looked at it
on May 23 but never sent a patch.  Sorry?

4) There are a dozen other static checkers which are supposed to have
warned about this.  I search lore.kernel.org for 46c116b920eb
and 46c116b920ebec58031f0a78c5ea9599b0d2a371 but I couldn't find any
static checker warnings.

regards,
dan carpenter

