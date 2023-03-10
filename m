Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919D16B36A3
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 07:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCJG2e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 01:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCJG2G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 01:28:06 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2132.outbound.protection.outlook.com [40.107.215.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AECFA;
        Thu,  9 Mar 2023 22:27:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2DpGI/1x8LSUJ0ZScgYjT2PweDwGrxeQKx/MrupmwHedj/TdyCKek9U+jhYW+ZghL+gWD3UtGiP6V6lrvW4JFvkMG58t17LzrF0VIs3dqjuKmM4552HEabpqWEwIszlHToBilwgYzUEp/TSSvw5bRHucFNE1B3VPqBXzfoa2FTXvqexx0ki/1FI8BX8C6NMcrLTWKrjMnLNaQml1Lmd4cYBEpTJOCHfoe9LV/YWo9fgNmTiYJkJcc8eOzIqRlhdSKKpUlyurNg8Xwtp3+K0CBapBwuezflgx9H5/1Mp+rr8ZbT/sfMOCKVU/x0jtY2b9hMyFEkmRxjSwr0pVRe6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjVxpV20ArgOo02eUY4hMGGHNWvyf5PqqMcak9bjqec=;
 b=bVPL7sagS5OgfW8Hob14ydMxu0X4gpKxyT1cKeBdQ+4Sr6z1SeaCeUoPChmjr3q4ebqDUiQt9jAlkiM8SJCWBy647/Fi9VSjTPH2/Q6vFW70ENWxqQSaOXCrf80KGUi9ws56JWAiNeM7blr7Lmceo+F6pCW8S7tj/zuGKRYc8/3gTeeatIBISZvGhNBIaZahdte+YFnXUgv5mTTA0q7MVqOG8quPPCCday+oK9cCPiM0z/5Ho8YutJRXk9Z23D8SZBNE72k7UI+QwrOP9M4CIv+GsGL5n7tDhSuG1LzdiqhsFVMfXEqkNz8P7EESGASulsnjxgTNfU3+xlBQcNYkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjVxpV20ArgOo02eUY4hMGGHNWvyf5PqqMcak9bjqec=;
 b=hRXrwS0QIaZ+6eurDa5wptbQtjXG7qEPejKEd8NVfj2JqA/KtSq7smx6gcTP+5dZYMpFEKRPVZou+3p2DXcRU5jfKMYoPA6sVaIbOnFaksq51rJ9DzfOggVMUNgB8a+GoNZly++7AomcX9/Rgfi2uYRLKFH7XHlrmZTDmtiOYorMNlzHg6cZJ/DRtcefk5AcNQMjWFTEVy4Hosu3zvk1hSXuFVt3W0mm6V4JkE5DA3deddq919taqxHRGbsE4kFrV3JuyeSBoXxiUSymZa5gQc1RCZ4VpGZZ6cEbTnnOtewrq2r4GIE8FXune6pFnmbvMuf3hBNLy0yNTbHSPvURsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5534.apcprd06.prod.outlook.com (2603:1096:820:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Fri, 10 Mar
 2023 06:27:49 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 06:27:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, hsiangkao@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] ext4: convert to DIV_ROUND_UP() in mpage_process_page_bufs()
Date:   Fri, 10 Mar 2023 14:27:38 +0800
Message-Id: <20230310062738.69663-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ZArLbO1ckmcXwQf0@sol.localdomain>
References: <ZArLbO1ckmcXwQf0@sol.localdomain>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5534:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e0269e-2717-4f47-7b85-08db213091a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVUsYu7rg9dupt3F9hBOh9fDqjp2g5t+L+CE8xM0nSR+CSCVCr90Y5bCLhhGC+VZ489qLq6PA2QYWbs+JkI4vlNhsAl+R1J87VmO+JmVCIq8lYz7McFAuXWzX+otmBJnYwTnwF5y2gzBwZ9Kc3209mgKHj4XUXdUBFJQnyLKInVtZ5tuLPZHcTYTZiPCLkQBeSL+oZrOwqjwejYxkNs99XfAMLGZenduBbnpRGpiDSOklG5ZjaZjYdeCK+D8j7O+IsP0HuZk4iZixB/bvnLUX+WaSbNY6UPTP56PfeL5451eLrPEmWxDjOwbk+nIOXjNPcdY9l3thzAl0ITpXjIIxQl9DMDxiX3N26aKX5wyqtzFYHqdldCtyby9L4YKL34+IF37uNrbeeU44lBh95suSjtYaLZQFvfOheo24NPStpqA/CebLmZKaUw/Ws9TJSSlSn0+4utswJWllK1GexV0uIfO9sp82uWavBthL61i6kmJwVBSSkW6XkQ2BompKo3hF11luMX1abjUUmU5r6l37pQ3EfkIyP/ThAIQTfTpcaP9VImNaMckqyC++jUTOAu5yhAF5U74aLv6SxdmIP9VXWro7TG5LdakBTYhVrOfqC8jqL/MOVpunLAdG10OoAL2SNPPiAgmw5IQgmI8gDvCqJMuGJN+vvxLjy8be+OhO78SJk6S8RUWBXjvS9N3jbvOiu8a4BSsiiaEFH1ViqNK/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199018)(66476007)(66946007)(66556008)(26005)(6512007)(6506007)(38100700002)(1076003)(316002)(8676002)(6666004)(5660300002)(4744005)(8936002)(478600001)(36756003)(2906002)(86362001)(6486002)(52116002)(83380400001)(38350700002)(2616005)(4326008)(41300700001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ao4UfX94nT8y3v1hpJIi4Dvk5eng64tC5F4Qpez+TD1kWgF0/s7VnnRdjbCD?=
 =?us-ascii?Q?DBRyAewjF2V9N0pd6viWjZR0hVT8Ca2QwJKi9g90gNohIgNfQ66/PFKRMX8/?=
 =?us-ascii?Q?wMnmJ5WlbpQ/l0aLk+kENKnmZWggKAobFIj4ksQxax8SPFcIfprMSfzEz3L8?=
 =?us-ascii?Q?luJtqJvNsIH4LVhm2pg3VrCuZUgrCgfYbzpXigLCkVJmp98pFQsURp4fhS1r?=
 =?us-ascii?Q?JuCu7LVJNsaOhtfVAiMfiwd5lsnHyA4nyXhtB9FActAtYySLycdT0RtGcGMc?=
 =?us-ascii?Q?PSzXiDy7gXvaUDQzFHOEWOAzYD5GIVgckfvzDccIdxQy6lEjrrWtMc011d75?=
 =?us-ascii?Q?vs2rSocY2Ay3dub9veQUebAQR/2Otl0bOq8mUmt8Cj219qli0a7cyn74SMpt?=
 =?us-ascii?Q?C14edOW6qz8l2rXYZVSGZ7ZtsXEaMCSjxii4RVRFBzhnc/zURdWgeebfgm93?=
 =?us-ascii?Q?iHz/qfH2PouI+Lsc55Q/ZqjWOJhLr8kOsbfXBYcrx6TbTM4Q3INhg1qh+80S?=
 =?us-ascii?Q?sNEfL1ZEQjoC8h4qm0uSl3ycWL67G48rItNF6ru0DqWGrgK6z4ViTdYbiq8D?=
 =?us-ascii?Q?deuvajspvrrsG9DyYaSG6CplX8a7IxdSGc9QDZ/IoNJ53d0gMwsnzJEkMxa4?=
 =?us-ascii?Q?n0mwRKfK+prse0Zqb0q3v+puZbe+AgI9Ifcr5tT/5gueFGYZaJ9eu4v4yqIi?=
 =?us-ascii?Q?vDccXilhERJKeQOv7Wx0PaGi5/+kde9wT5vZfDDoyIypFNPqEjHKwFYerLWp?=
 =?us-ascii?Q?b8XLtetnAWdVVErCGucBQxHpF9igSIeoLHRcjhFwgeClmbCrwiSsrJlFov5F?=
 =?us-ascii?Q?0ClkktNDS3W1J6r3maJkgMHgKT38JqrIObT62TVyBGAZfl1oCrQfDuKJyMcc?=
 =?us-ascii?Q?GbBfCNDr9SU3wULq2VOCPoUWrwfmRLmca3xqjrGS0XlgmIYhXkiGAzxs21qK?=
 =?us-ascii?Q?Hzu+Ju/pZpUCekCl0+sLnwpeNm68166Ykmyrxhh7q5pHkFwiAQfTIr3ghyoA?=
 =?us-ascii?Q?VQvCKk6ORxV0R8a8ccN4lVw/HcQZUjpGhJr0l4dpWu9Fi3PkZyrEpuOawc7t?=
 =?us-ascii?Q?lha834KzvGui2Kkcfzv2aHYLcZ/3O/5b5l0vBaY/5Yds86XEkz0dd/0Rx2No?=
 =?us-ascii?Q?vANZBSL2/iR0Mz9CxiHRaH7a6jrfFoj1k+aoOldXg5t7hGckZxxXlsREHiAD?=
 =?us-ascii?Q?eoeggJMnU7HHaoFbCs14twuH90TfJSvKrN6oB+8FMFZK6AUYFsBuKi7f7UH5?=
 =?us-ascii?Q?ObTFwMi/T2IQ457kL25rn9mS8/Zeac6UTH6sdCC7rhnuqS6pCXSDOqwSMyW/?=
 =?us-ascii?Q?x/lR9DtkQtQ42F8oM1p+IHYO/2RqAeKuwiNzMldsWXConAw9MtBeQv2WlPPu?=
 =?us-ascii?Q?Fe0htAtd3tX0ZojCCGLs4QeHYgFwvo2fiq4GocR/s+efkPV86MDwFurlD+CO?=
 =?us-ascii?Q?n6FwVBdWfv/f6APZh9hP2AHQKZ+IXOMHnxX15cnj3J7Me91M9RmNDMpcnsZl?=
 =?us-ascii?Q?Z58vKfE3rxKdlf8u8lyh0hS7iM4kIgchUqbycuC7lHH5C3YxcufXfSmjF9Sb?=
 =?us-ascii?Q?UZdFaKcbtmr2pluKo6+W4huYvjvJOFoFs6QoR94T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e0269e-2717-4f47-7b85-08db213091a0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 06:27:49.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeGq3mpujLFBZ24ee9ZXRdo1pFcfDVkq1cZRZrxX1rOZDL4Ejacwh2PJNuwiYf/5T+4YwEbDq+tWhzTOGEUYzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Please don't do this.  This makes the code compile down to a division, which is
> far less efficient.  I've verified this by checking the assembly generated.

How much is the performance impact? So should the following be modified as shift operations as well?

fs/erofs/namei.c:92:    int head = 0, back = DIV_ROUND_UP(dir->i_size, EROFS_BLKSIZ) - 1;
fs/erofs/zmap.c:252:    const unsigned int totalidx = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
fs/erofs/decompressor.c:14:#define LZ4_MAX_DISTANCE_PAGES       (DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE) + 1)
fs/erofs/decompressor.c:56:                                     DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
fs/erofs/decompressor.c:70:     unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
fs/erofs/data.c:84:     nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);

Thx,
Yangtao
