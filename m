Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43A2DCCB8
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 07:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgLQGu1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 01:50:27 -0500
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:42721
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbgLQGu1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 17 Dec 2020 01:50:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXTm8swRlxpSvqMbyoMI4nyII1148pqmBNSa0SmXUPb8xr0tCmqgXuqYTM+r+SDRKLc+5qWi6nhGq8Opu/Xw69M2NJ+qIADnEzkI7sexfA7gUFnQEcPpmz7CnmUTBfPbk0MIdQhlIJ/JOx+e0kVCvYNIdXhty3gGwtwrMuLiUjEnk+Jqezu+1bxVBa9cSe/fa1qI68VtCkvEG37vBkg2/YbcrY+VY4VYQbJcGAHd+UouQupnnmFa/eT6Gy34hNfwcm/HIMj6jwWhA10W6Oh73uNG0SUTRLwGYnT4Esi7N4r9bpvie3HKyLOYHHO1XRldb9QEZv63TWTcStuHIRCQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEPUGKZ1sVdGSKbu52PuQk49+/CdHVr9wZ8SRVet3Gg=;
 b=m2Z/R3nzDu5ByQcwxFzonTbNkJP3hu1DGsDtUxiLjJjUfuykHuLq1sD+2IP7QihHflvrs35XQ6np5z+fHR1TPbv37eBjf+bFWxJQ59eJqpP2iiWWDmGt7pFPH8qFmavHC/hzv86EHhm9MOyZMvjthH0QvdS2t3JHoMMEiRTaclMP0jyg+DgEq2IzNqduQxE345c6XGgVeahCIJvUW/l7ICVhqgdlw2CPtMvdxQxedsUn7nuLgNS8b1G7Ou3j/mRDBBkzr8aCoBUsEa1KYM3zdEs/Jrjs6CS6VHJaCnZfOxJqUoyRsS1zU1j8MwxJ0agRbdzcNgyNitc8tG2nTGnJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEPUGKZ1sVdGSKbu52PuQk49+/CdHVr9wZ8SRVet3Gg=;
 b=HTyOqc5Q8eMbrc1r3qXJrfrZTMpAl+1ks9PYZwTw0ASz6smOFPJKlIm51Jag6r7bL5nYJUoczGV3mMZ0JGPTXri85Yox6faUaNqXg93Druy/L4olF7dIh4WZU3Inp+KD3+NuCscJaAw9hn4zz+LqjawB/NmLwMOJ71fHXQuLnTo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BN7PR11MB2658.namprd11.prod.outlook.com (2603:10b6:406:ae::16)
 by BN8PR11MB3780.namprd11.prod.outlook.com (2603:10b6:408:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.19; Thu, 17 Dec
 2020 06:49:39 +0000
Received: from BN7PR11MB2658.namprd11.prod.outlook.com
 ([fe80::e550:890f:1479:e68f]) by BN7PR11MB2658.namprd11.prod.outlook.com
 ([fe80::e550:890f:1479:e68f%5]) with mapi id 15.20.3654.026; Thu, 17 Dec 2020
 06:49:38 +0000
Subject: Re: [PATCH] ext4: fix -Wstringop-truncation warnings
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201112093324.8052-1-wenlin.kang@windriver.com>
 <X9mLAlWbjrU5iE+r@mit.edu>
From:   Wenlin Kang <wenlin.kang@windriver.com>
Message-ID: <6083a93c-4b21-f366-be04-dd098133f7b9@windriver.com>
Date:   Thu, 17 Dec 2020 15:00:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <X9mLAlWbjrU5iE+r@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0215.apcprd02.prod.outlook.com
 (2603:1096:201:20::27) To BN7PR11MB2658.namprd11.prod.outlook.com
 (2603:10b6:406:ae::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.167] (60.247.85.82) by HK2PR02CA0215.apcprd02.prod.outlook.com (2603:1096:201:20::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 06:49:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cb5a690-2b3e-4043-769d-08d8a257ec97
X-MS-TrafficTypeDiagnostic: BN8PR11MB3780:
X-Microsoft-Antispam-PRVS: <BN8PR11MB37804BD5E054508A50A9F21FE1C40@BN8PR11MB3780.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:203;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdxJCBDwTI4kaSw92SDyuRbd/xwfVKYtK+ABVSgJTkn8aod3nn2kDUOx1DYjRYwfJj4hKQssSzT8m7ygRB03cpvlzB6HnxuNWIDRrMBGYMbkeQ2RFXjLMjvIRdwblyvyOeFCOpDuaVbGfmM1t9UZwOMSL1tPvSYYi3VObIWGUlo5fx4W8wGdaJZ+l0SipHLna/MWEdcBrAZti45mG8vuBNvYfMYjJgvAgZ34WSiOLSTBWY/YB4Nsw/H89aZU7KzxWcYEMgXM3PxoIrwZ8Ohcqzn3kfTJLbLzdW24mt7CwAQG9KlJHXSsglIISHuiUZw4TKBE3m0q2eslhVSjpAkIPtBXEtwCtaOPk+Gn921qEL7J3IiPPYJG45+4cSHrfe2eT5g+QAZ28uwzy1Yif5sN6N+fioU5UxX5zLgY8Va8Skk2ITDwa3GgPVlTYi1agh8QIE6uZA+DfKEq7LG1cmufoFrAVj2sdx59lELeubmo5GGzyljV3y2OD2Kz/Nacmn8GEGjbuJzL4o4WjtYkEYPzUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(346002)(396003)(136003)(2616005)(956004)(6486002)(16576012)(44832011)(66556008)(26005)(8676002)(66946007)(186003)(16526019)(52116002)(83380400001)(66476007)(86362001)(4326008)(2906002)(316002)(36756003)(31686004)(5660300002)(6916009)(8936002)(6706004)(478600001)(31696002)(6666004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SWlJVS91endPTXg3R1g4UHlGcGhiamJLWXlNVi9TY1o0VTJXRVI3YnAxM21h?=
 =?utf-8?B?dTd3QndqNEFleVhyMVo2RDZDZ1VBeDNibndZTjA4VytTUVg2SyszbjFKTysz?=
 =?utf-8?B?ejROTkFjUVJyQUxvTWxFSzJNNW5aVjcwcG5iMzBLTHFwYkUyeHJqQXI3TkhV?=
 =?utf-8?B?dHd0VTNJb3lOeGZZVWd5UStDeDhUUVp5czlIbUdvSnN0ZjBOS1JKaGdOWS9O?=
 =?utf-8?B?T2dQUUVKSWNKeXpuSk5jK2NEejRjSWprUWpmWEZOeXVZZVpabVdZSFcyVlNN?=
 =?utf-8?B?Q1kzdFpQcWp4ckFRNUMwVDQzbFd1WDZBcHVWMWsvbU4yOFpXYkhhckhsQXBO?=
 =?utf-8?B?QXF6Q2FIc241R0tBbFp2SlpIMVVEdFIwa2txSk5pd0RQMHhPYXNXRC9MdlZ0?=
 =?utf-8?B?alJwK2UzN2c1ZmRScnBDMVkwc0RTd2kzVVRJWllVQzhoeGJsdE9VaXNFM2oz?=
 =?utf-8?B?QzZTcHlZdHl1eWo4alNKaHQ0WlhaZjQ3YTNkVWhaUmMzS2xvZEtvK20rS1M2?=
 =?utf-8?B?U0ZobVg3enlJOW9mOHZtaGFMeVB4V1VJczcyTFAyRVpOUk5qcDdoVXJCUkZQ?=
 =?utf-8?B?SlY5ZTZKS29VNThBRVp3UHRRaGE4cE41dWFUcU9PQTRzbnM1anRpcVpVUmhV?=
 =?utf-8?B?VTFlWUNzSDRLTGZqUjRFcXQzai9KeWFCUlNHcnRWWDl2TGsycWRQRUdOdWpD?=
 =?utf-8?B?cVBpYzVoRWtUUnVxMTBtK3J6NGorOHJwaGtVaFRlSzltWExIR1loWUhBRU1l?=
 =?utf-8?B?ZHF4dUl1S1ZsSHdaQldPcUxjaS91NlB4VkF1TG9HbzF4cFpwZWpsQVdCcVhS?=
 =?utf-8?B?VCtzVm1KRmVkdGpuc3R6NmF1QktEdFR5azVoRzVObXYxNHlRakxabS9Lc3ZX?=
 =?utf-8?B?bnRYWjRDZW1nc0dWbHJzdHZENEdrNkp3QkxlNDUzUjY3WmpZNVVKTUhwYm00?=
 =?utf-8?B?UUE3OTRLK0JrazZGU2lLRGFXV2RGd2FTaXpSL2prTUUvSzd1MHR2cVhJTlFp?=
 =?utf-8?B?Vm9TdEZmK3lYVi9uMDBNZWEya0poVWcxZnpobTl3VEpIcWZGY3JrUmlUTjFI?=
 =?utf-8?B?RmJzaXZpR0oxOG53cENFWXdFOGt2bjV5eUxHQVVxdURIVDFqUm9LY1V6Z0Vi?=
 =?utf-8?B?NWk0c3Y1MTR5aHF3QXcxWE0zN3kySGtLL2k3QWpVN0RSZ25kRWpzRmZqMUtT?=
 =?utf-8?B?NUJFVUp6ZHR5M3htQndUUlk1LytQQUVaaFNyd3R6aFZoMFhKWXJHd3Ayemgx?=
 =?utf-8?B?aG9CRWIzZy9lRTJYeC9XR3hmT1FFVHc1SU54ai9JbFFDVnRySGw5NlN3ZEtC?=
 =?utf-8?Q?D5hbAyxcl29RQ=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 06:49:38.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb5a690-2b3e-4043-769d-08d8a257ec97
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5SxkbVmwWRgDAklQ+54P5ybsczsKc9CJ9f2/TqQL/6UP99rqRwrohOipEkh9IWpOJQrw6DI4YJ9v8YJHT/uliNBF813Yw81pvxM3qmSEiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3780
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/12/16 下午12:20, Theodore Y. Ts'o wrote:
> [Please note this e-mail is from an EXTERNAL e-mail address]
>
> On Thu, Nov 12, 2020 at 05:33:24PM +0800, Kang Wenlin wrote:
>> From: Wenlin Kang <wenlin.kang@windriver.com>
>>
>> The strncpy() function may create a unterminated string,
>> use strscpy_pad() instead.
>>
>> This fixes the following warning:
>>
>> fs/ext4/super.c: In function '__save_error_info':
>> fs/ext4/super.c:349:2: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>>    strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> fs/ext4/super.c:353:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>>     strncpy(es->s_first_error_func, func,
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>      sizeof(es->s_first_error_func));
>>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> What compiler are you using?  s_last_error_func is defined to not
> necessarily be NUL terminated.  So strscpy_pad() is not a proper
> replacement for strncpy() in this use case.


My compiler is gcc 8.2.0,  this is found in v4.18, and I see mainline 
codes is
using the same code too,  so sent this patch. But according to your 
instructions,
I just re-check the code, with "__nonstring" attribute, it seems it has 
fixed.
Thank for your explain.


>
>  From Documentation/process/deprecated:
>
>     If a caller is using non-NUL-terminated strings, strncpy() can
>     still be used, but destinations should be marked with the `__nonstring
>     <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
>     attribute to avoid future compiler warnings.
>
> s_{first,last}_error_func is properly annotated with __nonstring in
> fs/ext4/ext4.h.
>
>                                                  - Ted


-- 
Thanks,
Wenlin Kang

