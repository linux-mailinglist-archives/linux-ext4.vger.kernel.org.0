Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215AD610FFD
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Oct 2022 13:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJ1Ltw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Oct 2022 07:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJ1Ltu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Oct 2022 07:49:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2089D17A93;
        Fri, 28 Oct 2022 04:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtzpSEbKJl9oyC6BZ/uw1ygb88IAXyQs+IHOMUmQdVHzYr3FOl3mMrQB5g2Pj0RwXEHTERyoozUdeLWu4NR2ddyLMXBRQxk58Q29/HOgjwzOJ8toD0aWET2y/yznqPxk9pk3q7Iai/hYcoGxbw5Uws+HSnF/K42nGzRXe42J/nRd4omB29IOa+swMlhNwsMSaaZxHuqvwR9ZI/QNWwaHIR39k3uBoEDoj+6dsASKORPIAvsjGehRxnKSsS10gbueVWZXrqmPHKVEDM+djqIar7Q9aXrKd2dQyeV7hwahjauz9sYJ3SkMw7N0Ch4P4jLKeD/1NKs1R7BkpkP08k1JKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cm6cSj+Dms9K7WSVR3ElNwWity2Wlu99q1l5FUBYFg=;
 b=c+/nGEvh9fY7PcMKfsaGJ9Jk7oqJbQGxrMk+8HnAZUqzLv1wY0srC0y2CE7TGilnrZLuTVzvnx2qkozkL9K1ymU9DJt2A/G3TtQNdF2EZVcQoEfO5SdennqncI9Z3a3WOJpqVezR/ZUBpAXtOedP0nS+ea/yfXhg0qenJ5/Re7N54JP0meJly3lyDVNBjZKkWiHLzNjQL8/XNCmwOYm4pbGwmxR125pxy+1d73wx00SvRYoMZTUj/WBwBIu5DmR/XfeV2Ws2ur5INqKwVnXVtJlxatBEtxzBz0LoJGRMCVsO+s+nx+qYKC4WggbM8mJl3wJWDQsMazwhVTkmCK4b/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cm6cSj+Dms9K7WSVR3ElNwWity2Wlu99q1l5FUBYFg=;
 b=atNbofhGmlVl8I5s+i9JBswKObcHF22PZS/ZIoxS4WewXzWQz4dHe3p7e7o9yXGy6bNg648eAVSvNQQfm+S3N9JTESnQXqppx0kOE8L5UaNjTQslrBleEOOyhYaEWXCH8NEuFsD432sV0Yy83SqTEl9Vw0n+eKE4K7E6DtIzbqA1DHdbnXLa7LuUgYBP4sz1j3SuFHJi1J558HW9DAmXcSBDXPXFGmDEHB4ddygE4Y28ZahTwH1B6aEgD7ymOv1ucwgJ+ZUlCWXpLO4sHhS8vl0dfW+xLXWrM1eKAo/0VJ2NM8ifVYkt+6JSn9FPCbH4cBdPMJblIiTfBE8F3UVFCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM6PR04MB6311.eurprd04.prod.outlook.com (2603:10a6:20b:b7::20)
 by DB9PR04MB8106.eurprd04.prod.outlook.com (2603:10a6:10:24b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 11:49:44 +0000
Received: from AM6PR04MB6311.eurprd04.prod.outlook.com
 ([fe80::2b0d:be6b:edaa:62e7]) by AM6PR04MB6311.eurprd04.prod.outlook.com
 ([fe80::2b0d:be6b:edaa:62e7%4]) with mapi id 15.20.5746.023; Fri, 28 Oct 2022
 11:49:44 +0000
Message-ID: <04aa2fa5-c04d-d2ad-55e4-f78705b513ac@theobroma-systems.com>
Date:   Fri, 28 Oct 2022 13:49:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: ext4 online resize -> EXT4-fs error (device loop0) in
 ext4_update_backup_sb:174: Filesystem failed CRC
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Schulz, Quentin" <quentin.schulz@theobroma-systems.com>
References: <AM6PR04MB63111922B96138C374A39C68C7309@AM6PR04MB6311.eurprd04.prod.outlook.com>
 <Y1tTk5ILKICjJL82@mit.edu>
From:   Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
In-Reply-To: <Y1tTk5ILKICjJL82@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To AM6PR04MB6311.eurprd04.prod.outlook.com
 (2603:10a6:20b:b7::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6311:EE_|DB9PR04MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d30e1b5-f5b2-4d5d-b085-08dab8da8184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTVDc2Y26wiUnc61V17VwMVRyBug7kEbJCBjB9B438+aqg1E90pdGfCW2BxnAYV2akIdzJeZLFV2Sry2XZYJjMei4yHDklboKmtLHv7v2dnWpKNKytVRJpm49CtfovVV9NEQDY1oMBAMRJ51VWoIIDnPh2NiwMn2RF5KhdxZ375CR4kSP8s1rCVSKJEoHlqQrClZsMNXXsANjAAcjvBZEGTCM9al6LmWMqHcyzycw1L/eijKSsrG1lghG2KXyBESpfVN5aZ4qWZn/IlxFfr8eX5Aejss6QU+X4OcxzVEX5HpQ1y4vdWLRlf90r0vt5SKxHRT+tYnAl6nI7r/7hLl14kDXWwXONQ1ISZasypKHRBdCEWB2zw/YMvmI/NhUt5U55vdFqgMaFh8ga7+ybneBtKDCm63ldGJN5Ku/mVRtDjDhJEr2o84GV0TRPpMkST6Tfb+P3NCrgGumiSm8GTfAUqHJYt4xSUVk33BjiU5R7GyDS+xeldjU+x8wo8joVlEo9WdcNUg5DWg2ieIgwpCbotQuCb8juSfZizFZM5Fjk2UssE4W7PWMTeA0C7fQSLt+cROjoZCSiD+V2zh0Yn1N4v4BZXxZak58Ec6Y6qz62H5dM8MDPuuYO2Jgp1m6thtLXFOB8Wo1+GrnqxxAZ4Xxnbq4EO0BcAWczjUh5E4WJz3+X2LncFLt+EIrwkyNAusoBmyqU9SlO2PvUBfht8/WQ+e5KcQ+w0e/Ii+GXlV6sB5zbsop0K5Dircc9xSbTQDpVuAHl8ha7Hd5+gGoNlpFbMFeveb1PAf0gN4kND9/og=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6311.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39850400004)(376002)(346002)(451199015)(2906002)(38100700002)(4744005)(44832011)(36756003)(6916009)(41300700001)(8936002)(6512007)(86362001)(31696002)(8676002)(26005)(6506007)(107886003)(2616005)(53546011)(54906003)(186003)(316002)(478600001)(83380400001)(6486002)(66476007)(66556008)(66946007)(4326008)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enZsTDhvOEhsbGF0K244SU1zTU1yR0s4V0J0THRtZTAvNFpnRmM0RU1BOC9P?=
 =?utf-8?B?WDJYMU1XSys3THZtTzlIT1B1dERoMXBhZEF6RzVVclgzam5jVGRrS1pIVW9L?=
 =?utf-8?B?dHhDVUt3Sm82ZWJORWFjeWVBZUZ3WjFkN0g0OU44VTdRME8reUkzRkNJb2FV?=
 =?utf-8?B?ckUyNnByU3orU1pkVlRGUlJPaXg2TU10Smk1c01FclNRVHYxUnJtVVlkTlBD?=
 =?utf-8?B?ZEJaWG96N2QrZno0NHN3QndoVWhUQ0srakJpRVc4M2F0TFVSYjFabjNKZEFm?=
 =?utf-8?B?YXhTUkNmK0NYcVZCQlg5cTV3cVFWdGwvRGphNDA0MUZCazhzMW94T0xzamRZ?=
 =?utf-8?B?RTk3alhtOGZIeDZhRXBSVXlxMG5OQzZJL1lmTGhsb2k4Y3YrUWQ2Ris2SXV0?=
 =?utf-8?B?TmdvNXhYNFlDMCtiWW9UZnFhaDVHeFV4ZXNiRHNaUC9TODExNkg4Zmo5R0VT?=
 =?utf-8?B?L1FjZUdONXByK01oM0NBbnE5cktJN2tsd2JRc2puZkNobENKQVpGVlJQY3B0?=
 =?utf-8?B?RXBWRmpWNjdkb0xBUU9KN09IaEJyK1NVMFllTUZBRnFTbXliOFVQbHd4eFpj?=
 =?utf-8?B?K2ZabFdwWDhwanRBQ2ZYQTRITFRQR3FXaWY3V2tHYXZEQ3Z5cm1pWmxOMXhB?=
 =?utf-8?B?UFpLaGw2eW5HK1RCOFV0UGRCRFl3Q2pXZDZUSit5SXFHbmxQN1dlQnBqQW1B?=
 =?utf-8?B?MW12Y0QzU2NlNndRYitnajdhakVFL3h5dU9xNXBFdXFiN3U4UkZBK1NxYXZM?=
 =?utf-8?B?b2ZwdStpUmg0cjFpRmpmbUROK1g1dFYyTlpUWEUvNTA4YmxqbHhXV2psY3pj?=
 =?utf-8?B?bGp6MTNZY3JkSVZiRnFMbHUvTitGZWdTcWlmci9pSCtmbUFBMk1nRkJqQ3RN?=
 =?utf-8?B?VllQVTdVRmE2M2YvclphM0o5V1VkYXlGM3NVMXdjSDhIbWFEM2tTRnJtMWpZ?=
 =?utf-8?B?eWw4RU5XUVpQbW5wcEROR2pqSkk0NFZZZGhNVUxLMmF0T3RiNEFCWXd3STVw?=
 =?utf-8?B?c0JLQnlWQTVOZGczdVhRYVBqZ2NnRG1wSkJuUUh6ejN5ZnNQd0NtT0ZqQ2Z0?=
 =?utf-8?B?SVNpSTBhRmIyeHRNRkNLa1lDTzlUbllxM0U4V2NXYnZSTEgzWnRRNlNNbGtp?=
 =?utf-8?B?Q3pLeXBLbnpXSUlZTGl3QlgyaWptY1RWQml1WW5MNHlxbGZFZlhlcWNGYysx?=
 =?utf-8?B?THZ0cTBOTXN2WnM2VktrN2M4WXdFc1BjYXpSa3IvOGx0bmtPTlVJVGlDdUl1?=
 =?utf-8?B?SkJIa1ViRkFrbUphK3drUW43dGZCdFo1QlBSSmhkMk1sSGJkaldQd1RHV0Vi?=
 =?utf-8?B?b3V3WnFwZGR0QXdpT2RQQ2ZVSUlrRythSzVNMzNUOFpuaEdDcHB2SVRwQ0lY?=
 =?utf-8?B?alk5R0RzYjJES3BNQU5ncG9sN2MwT016YWxPeUNMSkU5V29xS29LbzJPSHNo?=
 =?utf-8?B?dUpHdy85V3EwSjhTKzZUaDE0aXNxWVZnc0hZcHROSnFsV1hHZlgzeTFCcTJE?=
 =?utf-8?B?S242bHk3bytSSG90dG9kTDRVWGRDSHdmdnYxRTBaOUoxSkhWZ1lFYUk1ZGdY?=
 =?utf-8?B?NGsrVThZaDlMV2pLZkRsT2k3UUdCSUo1eEVjUmZGTnNCSWM1bjVEWG1HNHhj?=
 =?utf-8?B?ZkdpZHIvandxRmdWS1JBdVhlQnRaellTTzJPcm9kZGc4S1hIVjV4VXd5azF3?=
 =?utf-8?B?RnJnSXpRc1FlRDludUw1RlZOcUtLRzFIalRhUWpZVTBFOVcwWkd6ZXdoNDFE?=
 =?utf-8?B?Z3pjdnlxa05lbDNqaGIrMkhyUjR4YXdJR1pXQXUxT2ZRUy9wTDlMY1dYUW5H?=
 =?utf-8?B?Vnp2ZHBIN1FWbWJNV0ZzWFhhNnNsNGV6dXZ6THRubndOSnVmMFdNbTdnODIw?=
 =?utf-8?B?V0dvdGFoVnRnbG5xRWVCSmdTQ0pmQWdkK0wxTHkzQTU2enByNzB1cjZ5L2sy?=
 =?utf-8?B?L3duVjlxRDljRFIxeUhIeVVJNXNVU21ybEtlR0ZPaUZ0VldIOVVOblFxZEFW?=
 =?utf-8?B?N1JZclU2M000WGxVWjlhRytjMGxpb0Z6OTNMZGNJYy90ak1RbkZrWkh6TU55?=
 =?utf-8?B?bWNKSDhYWmxlbzdyZEVMMXB3ek5XclpCdW8xc0FzWnI0SDBNbEJtS1JXSll0?=
 =?utf-8?B?eVMvcnlKTXlZQzEranI0RVRubExFR0QzNDRNb3k0YWt3Y0RKZ3pIZWdMVU9W?=
 =?utf-8?Q?BDOlVbpig8c2aOX+rWRMvGFdJjHM1nxWjausAmC65071?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d30e1b5-f5b2-4d5d-b085-08dab8da8184
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6311.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 11:49:44.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bA6Djxa5ShB+D1nzgUXr9qZ/WLgHdG9CitT/HxgFVBRs80j19BlxEGqIAyLh0nHHOLwraO7yeLCA5tanOY/xE+fnQ1tzw+ETpGSon01Tc7oZcHw1vRIz79WZvTI0OHVpMDM1YGWhnwymChLBkU50vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 28.10.22 05:59, Theodore Ts'o wrote:
> 
> Thanks for the reproducer!  The following patch should fix things.
> 
>         	       		      		- Ted
> 
>  From 9a8c5b0d061554fedd7dbe894e63aa34d0bac7c4 Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Thu, 27 Oct 2022 16:04:36 -0400
> Subject: [PATCH] ext4: update the backup superblock's at the end of the online
>   resize

Hi Theodore,

I tested the patch on arm64 and it fixes the issue. Now the kernel 
messages are just this:

> [   14.769997] EXT4-fs (mmcblk2p1): resizing filesystem from 139771 to 3888507 blocks
> [   15.020593] EXT4-fs (mmcblk2p1): resized filesystem to 3888507
fsck after the resize is happy too.

Thank you!
Jakob
