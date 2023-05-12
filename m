Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36A700A3F
	for <lists+linux-ext4@lfdr.de>; Fri, 12 May 2023 16:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbjELOYk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 May 2023 10:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbjELOYj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 May 2023 10:24:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AB22D7C
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 07:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fytA+ykorwuNaq7AufLbtW8oow3yyukbyZJO0RO0I/A3F0QQnPhXYWtFrF8LNzWPpSi2WjYXJ7Mfup0fa+jCmrGR6lk56Qowhue4uAHWBWEpYhkBUkJ7KBF758Maq77PcXDK4Pap/VRPllwHJicdyGUji25LLTTn36Ntkz8GffBoDcM7roCqIfJ/yfsnXt2onjBW5p72GSw2Xt0tYpvacCp5QfTO4yMuDjR6mSxK4OgNryECCjKP44wtq9fkbYEYMOOw1D5SXzF9HXCzVgTrAmoA+jfVHXQf+MdgHIK+ytydcqYf7IhDyrggwFOI5XCnEe9KfMFi1/EmDB3YLJkZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcQBlV6GuSTFZjn3HMnbjzTEcW3zTBrilT6eK6z4R4A=;
 b=IuvKwTIeXt1YUsbra/0AgP1KLA2i2zXINou32otpSpf9/GjX9C2Y1u75X/DIfjLbkt9PenYgcheIl7m072Maq6Joom1XjpXtDr6DvcNazPY8ekrM7NN8glRHl81U6SruFGeQYZ+G7r1VnWi+c8vUWsJQws8E1chbPY99PMikzw8CFUy3BZlMccT/kMwFyaBMEgSV6KdZqLrNPX+Pqe2WcgdAHjcSEzGK3xFqIpgbAkHYTAHOyybP9EcKSd+uiF1YpdHW0kksdVgpqjqKicW1Da8oMlPtyUDDcMfGBdUOAco/eif7iJHb7N+SrF4BgbQMmrvNHTnYYbVgyTn0Megucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=othermo.de; dmarc=pass action=none header.from=othermo.de;
 dkim=pass header.d=othermo.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=othermo.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcQBlV6GuSTFZjn3HMnbjzTEcW3zTBrilT6eK6z4R4A=;
 b=d0bNqQIJL8lRRuiksN2YRjC+2kISTbTNGaZQubbdengyT5o+oLAJnCjywAW/qTiNzZLy1wUmw3W3CArTS4FnyE+gzjJMkTjhfszQZn2s/S5bXi4jbaC06mYxM5XJycWX5/t1F+3X72ZIzrSpruQWZt+T/V2s7t3sTMFe1dSTK+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=othermo.de;
Received: from DB9P193MB1644.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ae::24)
 by DU2P193MB2211.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 14:24:33 +0000
Received: from DB9P193MB1644.EURP193.PROD.OUTLOOK.COM
 ([fe80::f2e8:76f6:1195:9568]) by DB9P193MB1644.EURP193.PROD.OUTLOOK.COM
 ([fe80::f2e8:76f6:1195:9568%4]) with mapi id 15.20.6411.009; Fri, 12 May 2023
 14:24:33 +0000
Message-ID: <114216cf-6dfe-71b3-0ffe-3883296bc144@othermo.de>
Date:   Fri, 12 May 2023 16:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tytso@mit.edu, famzah@icdsoft.com, jack@suse.cz,
        linux-ext4@vger.kernel.org
References: <20230315185711.GB3024297@mit.edu>
 <578c0eb1-5271-b5fe-afa2-e2c1107b8968@othermo.de>
 <2023051249-finalize-sneak-2864@gregkh>
From:   Marcus Hoffmann <marcus.hoffmann@othermo.de>
In-Reply-To: <2023051249-finalize-sneak-2864@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0439.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::23) To DB9P193MB1644.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:10:2ae::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P193MB1644:EE_|DU2P193MB2211:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d7c139-4f92-4bc6-bb04-08db52f49b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lelx67KYZJQ/fT/NHxpkSmW8Pyi33S3pphDNc3U1kqeMTGwOlI0hyh+Y9GFpDS0oBQu1vpGbxqamVsxCzbovKgOCGFlk5gwtDN0sDw3i8CXcKuRTAM3VpsGp1KHkftIn7UzwHgPbvZ3oXMNBRHq5NG3Rh6iO0r5J8sko4DwaFQ3AYujTSWnY9gVcuk2SY1VfK5LD6Bpv/AsYXjGQiiK8Lr1QcBSaHmCmT+xpqg+Mb/MlnAkfd9ol7PemfZxRg1S3sQgNcoM3f00TlGslk36wavYNipLMfkb6bCM2SHJNNRzKucq4TCK8gGI0Ckozc1aMIlLplLzjmYBrP4FlB6oK2yV0m/dox0i8dBxBZM6CuJ3fTI/QFeoEI8t3xLjh1x/eixP3VeI3QyVuWVxqHnVEj7XjP4LgBzaMHBfGTZ6XsPmpbRQHfD8hcfOjHtRW83lNnmVUvUP649JB/5m4rl9j30SULvN/R0jqMrs5QZooUqkDTpAn5oq81hvlADSV7PpTnI4+sR3TEK8fzA+PsIk4mtFH4azy296ueVW/LdDgg65vRUmG8CgBVE2NkcHXYRlJ6teYMQgkrHa5TzgMC7mIpskm/ceiUDGdf2om3aMKcREsQXE7+lTKwcVvT9WzEv8QkpGoENUIlg1iu+7OC1mjFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P193MB1644.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(346002)(376002)(136003)(396003)(366004)(451199021)(6916009)(86362001)(316002)(36756003)(31696002)(6506007)(186003)(6512007)(66556008)(66946007)(4326008)(66476007)(53546011)(5660300002)(2616005)(83380400001)(8676002)(8936002)(2906002)(44832011)(38100700002)(41300700001)(6486002)(31686004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUc1WERZZ2p6WGt4N2N0N3J4WU5hb1FvSUdYaFl3NjNuSnp5bHUxaXcwS1BE?=
 =?utf-8?B?ejV3T3VoZThCS0MwOEZ6K3JqbmhwNVlGd3p1SVRWblRlSjVqN041SXExSGJU?=
 =?utf-8?B?c0VwQ3BiWmJLaVAzY3QxZHdMd1FENjVOWEJzWFc5WEgwZkNKNlZTYSsxbkk5?=
 =?utf-8?B?SWVxbklHZWV5dExJV0JIYmhZZllETTY2TXBDSThnNUJKWEJiczNDZk9YaHdT?=
 =?utf-8?B?Z1BHSytwZ1JjRlp6U0dRME5URXZyZlEzUVEvcTBjM1hpZndydEFQRG5GV1d3?=
 =?utf-8?B?UUFzcjJoQm03bXBhYk13M0VOdGprNHAvTm1QK1RvZkxBRGt2cmtYR3Nxbm5F?=
 =?utf-8?B?UmZVWUhOZmRUMHMyNGh0U1BRVy9TdDIzQTY0T3RUU2Z4SEpIaDkzZkJSa1NE?=
 =?utf-8?B?bWFVdGlmOHRpZG5BZStDL1hITWZoRVUzVFJ0Y3pQRFVwNnJDOGp0SE16Q0ZT?=
 =?utf-8?B?ZTh2STJxSm1oeXQ0Vmw1NzZDWkU0VkNwNHpUdzlMTjdaNWYvbFVTTGc3bHF2?=
 =?utf-8?B?cS93Vnd0RXR0aFIwZmNZNkJTd21BWFRCaHF5ODAwUGU3ZE9mM3JvSlF4aExx?=
 =?utf-8?B?UlJxRzBiM0R3aGcvY1AvUlVjZUdLTDlJRkI5dWRhdE5wSWdHMFgvOTRVWjZl?=
 =?utf-8?B?c0hkRU1zeWRXVFNpVjNHZzA4MWRvSU9UeDRUSURScjhoVXBBZ0thaGVOVUcw?=
 =?utf-8?B?Q0VRVi9kUEdwR0IyeHQrOTB2WjZ5eFhtWDJLc3RRVXdFYWFEdlZVR0hwcWNi?=
 =?utf-8?B?MSt5NHlyQlVRcFhIeFMxZzVIQmliNVFxTGI2RU5hRTJLSUZBZ2krakZJZ1Zj?=
 =?utf-8?B?aXNCZzJpZFJzM0xUVzQzU2xrNHYvS1p0Mmk2c2VtTEVEMzF2NUdxMWMxd3I2?=
 =?utf-8?B?c0ZwMXo5NU4vKzBpQUk0eG15V0ZGSmRVOXpJREtNdjhxQ0tDNWZ4LzR2M29U?=
 =?utf-8?B?aFAxcTNaRHdPT01PbTZZeHhzVm94d1dLUU52NWZucTBxWXFoT2E4QkN3QzZK?=
 =?utf-8?B?Ky9laExBSzJxVkViNHIxdUxGR24yK3BqU1kvZHU1MGFnRWkwTmR6Q1I4clRz?=
 =?utf-8?B?aCtBWjd2UmVJQ0lBWEF3Y2ZzOVNYMm9vMi9rY3ZkMmlCckxjcEhyZEcxTlVR?=
 =?utf-8?B?bko2cWozT2pGS1FNa01vMTNqT1BVd01TSzQ1OW5VLzdMcDk2MkNhaytGTnhE?=
 =?utf-8?B?MXRGQVl5Y3RoMlZXR0tPUnlsazhzK2k2cDdpbTI0VzdQV0tzL1FzUHpTNUNs?=
 =?utf-8?B?bFNoNFhRMGNsejRCemNkTmNFN05pYW1DRjA0U2dqODRBZmJmd25xVU05NXI1?=
 =?utf-8?B?Q2x3YTFTdEw0WER1L1FZYlFQQ3JweWJvM1Z2SDFrL0RxRFdsdkt0bHBjbDUz?=
 =?utf-8?B?TDhLeVdmNFRLelU3TGxTbnBCNDFJVjNNb0FMbmlsRkkzbzJxMS9lTE1CRjJI?=
 =?utf-8?B?RW96S2hNYlZHaytablBrS3hkY0srRVdBZ1hQdE0rUDRoWFhFcUpVWnhqMSs3?=
 =?utf-8?B?NFI3M2x2cUI1OGxRYmFicmJncjdIaEV3c2hpSS90YXlISzhnYXVJcXBSZlZz?=
 =?utf-8?B?emhMRk1IOXdkVFAvMGlUOEh4cTJZN0hoVlN4V1ZPMS9nM3RZUmwySFZNUEFn?=
 =?utf-8?B?NUpqd202VGdwQjU5NmJST0RRS25XY1hVV2JPQXljS29kQlN2YjdDRHFZS3Vm?=
 =?utf-8?B?VzNLUTE2SE5QRUJaKzB0MVZMVUtVd1pUZ1hvSGt0eGNXRGZmcXFmQnBreWNU?=
 =?utf-8?B?MjZzVmNJQ1Bza0JWcngrbjBHNHprbmVuN0tsSi9kLzBINHpIZUQ5WjBjZlh6?=
 =?utf-8?B?MHoyZEhlNVRsbkxBYlV4Z1ZJVXNuY2VoWVhpZ0NKYlQ5YUtLN3k1aFhBbjZp?=
 =?utf-8?B?cDgzV1BkZkFrSUltenR2djJYRDlQUVNYdFBjZ0orSFU1VzJNZ2ZQN29PVFBK?=
 =?utf-8?B?V0RkUC9Wam5zUVRSdDNacjVuTUl2L3lkUW04am9sWkl0RjUxMTBSTThESGNs?=
 =?utf-8?B?UWppMG9XdmtqRHZtU1NvSGVETERmK2xPKzZkM09QQ2d6Vzh0WDNxaDlsblpm?=
 =?utf-8?B?VXhlUWFZZCtqanRXSGt2MWNmNU1HL1FFUGtlSmd3TlhOR0wxR21mL1QxMjJv?=
 =?utf-8?B?YVZ1N3NtNGptdWZkMHZObGdUNE9zSFRzNG9DSVFxbFBFcERiWlFtUnNmWnJt?=
 =?utf-8?B?YVR2aC8zY1dMbTZZNEtzaVFxSVBZZEg3YnJuZ3N0UHFTTFFrRjNwODdaZXlm?=
 =?utf-8?B?QXFmSDY3cTAzRFhucm55L29wZ0xRPT0=?=
X-OriginatorOrg: othermo.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d7c139-4f92-4bc6-bb04-08db52f49b29
X-MS-Exchange-CrossTenant-AuthSource: DB9P193MB1644.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 14:24:33.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 85b1b12b-9424-4d9d-b1a2-39f36faa8bc7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LH9Ie40zuSQXp0l3cnXS5gwjUaQViPw1p+iSkA8i3HBDorvA2VupV+uexMz+wTo714COcHuVKvO6f/cyJ20xHmCtAl91GBgx745ko7q+XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2211
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 12.05.23 14:19, Greg KH wrote:
> On Thu, May 11, 2023 at 11:21:27AM +0200, Marcus Hoffmann wrote:
>> Hi,
>>
>>> On Wed, Mar 15, 2023 at 18:57, Theodore Ts'o wrote:
>>>
>>> Yeah, sorry, I didn't see it since it was in an attachment as opposed
>>> to with an explicit [PATCH] subject line.
>>>
>>> And at this point, the data=3Djournal writeback patches have landed in
>>> the ext4/dev tree, and while we could try to see if we could land this
>>> before the next merge window, I'm worried about merge or semantic
>>> conflicts of having both patches in a tree at one time.
>>>
>>> I guess we could send it to Linus, let it get backported into stable,
>>> and then revert it during the merge window, ahead of applying the
>>> data=3Djournal cleanup patch series.  But that seems a bit ugly.  Or we
>>> could ask for an exception from the stable kernel folks, after I do a
>>> full set of xfstests runs on it.  (Of course, I don't think anyone has
>>> been able to create a reliable reproducer, so all we can do is to test
>>> for regression failures.)
>>>
>>> Jan, Greg, what do you think?
>>
>> We've noticed this appearing for us as well now (on 5.15 with
>> data=3Djournaled) and I wanted to ask what the status here is. Did any f=
ix
>> here make it into a stable kernel yet? If not, I suppose I can still
>> apply the patch posted above as a quick-fix until this (or another
>> solution) makes it into the stable tree?
>
> Any reason you can't just move to 6.1.y instead?  What prevents that?
>

We will move to 6.1.y soon-ish (we are downstream from the rpi kernel tree)
Is this problem fixed there though? I couldn't really find anything
related to that in the tree?

Best,
Marcus
________________________________

othermo GmbH | Sitz der Gesellschaft: Alzenau | Amtsgericht Aschaffenburg: =
HRB 14783 | USt-IdNr.: DE319977978 | Gesch=C3=A4ftsf=C3=BChrung: Dr. Dennis=
 Metz.
