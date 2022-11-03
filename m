Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99571617BFC
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Nov 2022 12:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiKCLya (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Nov 2022 07:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiKCLy1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Nov 2022 07:54:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FFC12A88;
        Thu,  3 Nov 2022 04:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHZYE8XAL4HxTJF0SlP+CQgPyKdjnp+REbw1CWU0gIyI6oNf1kEUhWCzl3RDDUkEBFZj5QPZAS1g/TRZW+ToYXUUxojvUK62HLxCPvFPyER7Q+ifgXa6lr98RvTXAHboS+ceFXOqM4upfx54Gck4W0xtdT0mpMVMho9jw8SSU2+h3Xhj0D57/yee29//S04+jdiPKecZ34ZLKenN1RzG8Oea14V4nPZqG7KWCdU3iYizUkut38urjl0+apxkEEC942DoZOwdbqfNuLVrwuVC4b+sLfyaBGTTBQyC5gysQgigAiGVfNPFyubEOQnUv5ECcM0pZA6pr+rUJ3wzW/MXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5c2Rj3ZFhLc0CIr/lVkmCHMswtp9I2UucYMrROOE/Q=;
 b=G6pr3mbTZruVAI5VcG5yBWS9eYvZ59syzqc/JLFWrWB3hFTtn+aeeTCUifG0nLjPL3ZOru+bGDZb7DWm4tF4ZUsfhsuwn4sY4xHbYcawLwtTcGPcj/TU2MgvfobppSzZ/dCNHbDx1DujWDKql4nuYJrz+ZhX3JW1FocNZ4mwEIZVs1fkJwQmBtc6Q8ootA+S2044JI2OlnOPwvB2iVVInLLQb3NpeuoPT4sv5G/AaczNsxiWv1rO3eLWni3jH8vxhtP+kRfWKekYXqkKx0Dups/bR3+PNvqtSCC2tGyhgE8phTxgK0Na9qn148Thid6Asl1cXjikzcvcOsfVNlCkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5c2Rj3ZFhLc0CIr/lVkmCHMswtp9I2UucYMrROOE/Q=;
 b=HKq9ELJ8Mg2/yeazYENguQ0v/cHnhsotCHLQtAVKwQ0Nq3/4Mix3HR5l67b1g0IvxD0QZJPCxVHI67LAs+eNUNwQjFEDhGk/fJ4a17mXrXIe5tF1mhgIYhBJfAPWOalpJNFmgXRknKmH4tFR3FzRwa7f3IgerBT+F9UEW6NfeLp0OqolotnHsYjSOGeRDKtR9hvJXWxcWDaE6Jy2kzGruhw2d/ltRE2ZAmmIkfqvQ/ObtgOZWV0REPFzPriP4/0ulS9s+AKMast6T3sgmM8utg5vKjW5z+/98nJWR2J1r4YLakIbGdmGaCBFNHM5SKaU93g0FBSNUs1dSEoLwy+Zdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB8279.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 11:54:22 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833%3]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 11:54:22 +0000
Message-ID: <e7c7d42c-bfb9-b015-fcd2-bfb5e6334e06@theobroma-systems.com>
Date:   Thu, 3 Nov 2022 12:54:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: ext4 online resize -> EXT4-fs error (device loop0) in
 ext4_update_backup_sb:174: Filesystem failed CRC
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        "Unterwurzacher, Jakob" <jakob.unterwurzacher@theobroma-systems.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AM6PR04MB63111922B96138C374A39C68C7309@AM6PR04MB6311.eurprd04.prod.outlook.com>
 <Y1tTk5ILKICjJL82@mit.edu>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <Y1tTk5ILKICjJL82@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR05CA0042.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::12) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e236059-63d1-4221-b61f-08dabd92257d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INwJjGcwmueLLt5dttmAjpx7WtiLwC/Xspk5hPkfUfnLTRrx5YJZm+R2ZtSlqepKv8UbPeSdW8yKzrBPZHSInW8+icO4aXtpOMtHT2qe4lbQNK2GEmiMyiuNuKtB39B27v3Jex+i9d28Ciz4HOCu3UtTuI94L94CVY3DqfYJwo19PRMMISJuMbpK+CtBYEnLbKh2IODQS/3GX1d6sMvriAZI9UCVm8RnvoanBnLEWbo4plqksq8ygTRZDHQzc7OhsD0WsV9E/+bmTeWMD6BoU7semVX2v7wYMo3rgL4LUNjfcqYaUe6pVTm4oN2Y2eRufuTb9sGct9+ea+9G0w27r3Vw3M4uH3umHJ9vhvrrz3R49E4jt9TKZi1u5rz6AP5E+MW1CB7Wd3m3KWQ1rclsfBpadztQ+eDyhcfwYGazoZaGJ0z8BXOsvp2d0QJNtcguHhDQk8HAc79sKwa2deyqrQgKqWs/9hfE865Sjb+mC0DSbkR8Y1i4p7abYw9HihfzcixaOYc2Hg4HSHUws4OYL7mU6excKX8OsHMDUHcD4w8EbtY5EjKQg4x2dBJvYE8qdmvG6uBaCSPt39qRuDcaReWGY6F4IGGb7f1N5UvYa+BLhAo/6MVU677Xti0wsVL/mw/PWgh4uuxGr3Vb9hDihiW7BPQp1Nzq2JWzDjqAPWhYBreECTfxgb2eqOnW6sKE3g2LZO9JolCU8jyifW4lkgIdYRn6a1N7KDg835H4gWRDJRS8+bX5+KwqD23oT3UO1aKP+BD13esCfDEnnooaeU94akYWsDZvwrNjAHi9WU0ZEwGkmMjSxWOgTl/Y2lGV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(39850400004)(136003)(346002)(451199015)(31696002)(36756003)(86362001)(31686004)(83380400001)(38100700002)(186003)(6506007)(26005)(53546011)(6486002)(110136005)(966005)(478600001)(6636002)(8676002)(66946007)(4326008)(66476007)(66556008)(41300700001)(316002)(8936002)(6512007)(5660300002)(2906002)(44832011)(54906003)(66899015)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0VodHJ1R2FYUGhhUE9uU1VJaUU4UXNtRitxY0ZRYTRHYVk5SmR5Unp6TE9p?=
 =?utf-8?B?MzhKYjhwdGFyanM2UDZHcDRSSWp1ZjNRaW8rWDR4UGZraGpwZ2R0VWdRMCt2?=
 =?utf-8?B?bWViZFBja2NEUjhxbjJtc2JFWnFKYkFubEVJSFRaWkdvVjdnUmNRWDdHekkz?=
 =?utf-8?B?UHNHMjQxNjZwL3lOajVsNjRsVnlhLzUyR2xUdXUyWEF4S3NsalFScnN3TWpm?=
 =?utf-8?B?OC9uTjltTm80SVB0V1pudUVmUDNPN0JTYldLcDRMMjBOYjQ3S3hoZ2tuZEQx?=
 =?utf-8?B?VFVVVkZVekI2RHZFTkNsWElJdVBLcGtvTTFUSThLcUtvOXljYVcvUjN1bFRm?=
 =?utf-8?B?UjZMTWYzZHBhVENIQTN3bUl4WUZsMys3dVlOZ255c3lVWmlKRkN2NmVWOGVu?=
 =?utf-8?B?WDlWK2YxR0Z5NlNFN3RCSEFycVdLOUtUQ2V2OS9FeDVhTnRBUUlZSnFSSUtO?=
 =?utf-8?B?UUtVUFRkMm8zMVNKUlRSSHVMeTJONEZqUERwcUl0eG85NnY0djZhUEwzRDFx?=
 =?utf-8?B?bjM1Ylk1QkhEOURsTkovWXNQQ1BLV044QmtHY1NnSmhabXBoQ0dITkVhMnlp?=
 =?utf-8?B?S05jZW92RW1lcFhhUnJSTFJCUGh0OFlTdk9NNG52WW50aFJLcnlKOTlIRmdh?=
 =?utf-8?B?cE96SWkrV3ozdUZtNmRUSkpvdEtYbXQ0WVZldzJnQlNjcmg5djBCd1kyWTJm?=
 =?utf-8?B?ZjVSU1lPRjdpQXBCWlBFWjV1TmtiWWYraE1rdDNMSjdWaDBXOHVPZDZCYmRP?=
 =?utf-8?B?ZlU5d3BjSjJyZXN4Qm9vSnFaL3Q3dDltUmdJd3NXQmJjVXdxajk3MCtOd0FK?=
 =?utf-8?B?dlBBaVVyYXB6M0NlYnNrR3dXa095MXhhb0Nyb20zZ2ZraE4vNnZnVWpncktR?=
 =?utf-8?B?Qjl3YzJldnYwMXFnbGxEZFdORVRiWklYS283SXZUOGV3dXU2OGtRZmU2eXpC?=
 =?utf-8?B?ZERlYWpxZG5mZVJUMk5uR3ltaTR3djQyNDlGWWpCYllmOWYvb3ZnYkdrYnhU?=
 =?utf-8?B?ZWgxQkhobldHbWo3eUFCbUdiTC9TMTkvaG5PZ1R5dHFPcjl0bXVzcndTdEVO?=
 =?utf-8?B?eDZWWlY1amN1NkRCd0M2SjZpQjIvRUdLNTloSkhSbUw4dFJmRDFTS1RzblA1?=
 =?utf-8?B?NnhkZEg0aXhYT0xPdVVISXVPelFRRkRIK2dBanhOd1M5bUJTN01MTUdkZVRr?=
 =?utf-8?B?UGNvVVNJeU5BUmVLcStDUys1cUs0ejZGelVjdzRia0srOWNUR0dTMjVXblZZ?=
 =?utf-8?B?a1BCTTU2dWxjdllCck80S0xiVm9LOUFRZ2laWEUrbTZvSmJwcXJuSmNBdFpQ?=
 =?utf-8?B?dXowdUNaTVdpVXJray9Bd0poSnhEZjY5bEwrKzFkbXltVkE5bUdCSitKUEpu?=
 =?utf-8?B?R3dRbFBpN2FFejlNZnIzdWdLSW9FRTluVDJwbzFkM2J1bExsYnBuc0hnWjB5?=
 =?utf-8?B?ek1iL3o3ZnZsQTNlWnFBbW9UcnVyQktsOFFIVXZJQ2FRZHJUNjNta0s0Q3NK?=
 =?utf-8?B?d21QTDlXVW1lT1dyRlZnNHA4QlJwQjYxWnVYcnFZRnBuNkMrZm50MmxVblVz?=
 =?utf-8?B?VnBibjI3enRGMGsrY3YxMzFYbHpHeEE0ak12YWZIYnd6T0ZyVDJiay9hVTVz?=
 =?utf-8?B?UGlHNmwxWTFBV3IwbDJvRTVOREtPSEk3eGN2RXZiUklTeFFzdkpJQythSGI2?=
 =?utf-8?B?Y2wzSzdHdUw4ZUdZME9YLzcrRlZmT1BoQnN3dDN2L1dvb21FcEs0OWlMNWQ3?=
 =?utf-8?B?V0wzR1dYWVdDOTAxREFINUFyUktIMlM2Z21jNUNRSzZ2S3o0aHBoemRzemRE?=
 =?utf-8?B?cmlueHBhTnBsTUNHM2RNaDlKRmh0eFJqVDJ4WTl0enIzQmgxYnV2S2dURzJq?=
 =?utf-8?B?WmEvQlBNbmtSMi85VEdPLytKRkxOS1ZMTHhPU1RsSFNIY3ZxM0REcHUxVDVV?=
 =?utf-8?B?WXYvcEEvd3B1d2FWY2duZ1U4aUxMQXNUSWd0cUR0cWxFeDZ3YkJYcVBscjVT?=
 =?utf-8?B?dVZvY2VqWVQ0dTZIYThqMUptUGhmT1hBOWZPRzJCakdFeEI2NDJKczdnc1FI?=
 =?utf-8?B?R3AyVGo1N2Fkd1NBb3lYTXJPNzFQME9pd3BXbHUrR2o5OXFiVHlibjZxRXBS?=
 =?utf-8?B?aDI1Tnk4YUpQRnZGeFpEWm9ZRzZpTXhqemJMcW90SGNoWEZQTXVIa3R3Y25t?=
 =?utf-8?Q?/f27lpXAPUH1Gl2HFs/787M=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e236059-63d1-4221-b61f-08dabd92257d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 11:54:22.0247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCwicxaH/LcSljCePpFUh1d3bRH72IWohOwkoQy9mV8W1whRXWlMNQNG2un/dW7rWPUOxtb5Z8CaFp+OHFgWunpv2A266FjjsRwNXlkCGB2LSu91Gleey6bcx1STNTfU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8279
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Theodore,

On 10/28/22 05:59, Theodore Ts'o wrote:
> On Wed, Oct 26, 2022 at 07:49:56PM +0000, Unterwurzacher, Jakob wrote:
>>
>> it looks like I am hitting a similar issue as reported by Borislav Petkov
>> in April 2022 ( https://urldefense.com/v3/__https://lore.kernel.org/lkml/YmqOqGKajOOx90ZY@zn.tnic/__;!!OOPJP91ZZw!kg_tsVkw00-Mf-bC3nyz9aOxZvEowuWZ19B4d-Vzx22Kd8RwNeAb7lEReLYF4ulwcE_OE0im6sdv3zVWHiLXp8Tafu1i$  ).
>>
>> I'm on kernel 6.0.5 and see this on arm64 as well as x86_64.
>> I have a 100% reproducer using a loop mount, here it is:
>>
>> 	truncate -s 16g ext4.img
>> 	mkfs.ext4 ext4.img 500m
>> 	mkdir ext4.mnt
>> 	mount ext4.img ext4.mnt
>> 	resize2fs ext4.img
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
> 
> When expanding a file system using online resize, various fields in
> the superblock (e.g., s_blocks_count, s_inodes_count, etc.) change.
> To update the backup superblocks, the online resize uses the function
> update_backups() in fs/ext4/resize.c.  This function was not updating
> the checksum field in the backup superblocks.  This wasn't a big deal
> previously, because e2fsck didn't care about the checksum field in the
> backup superblock.  (And indeed, update_backups() goes all the way
> back to the ext3 days, well before we had support for metadata
> checksums.)
> 
> However, there is an alternate, more general way of updating
> superblock fields, ext4_update_primary_sb() in fs/ext4/ioctl.c.  This
> function does check the checksum of the backup superblock, and if it
> doesn't match will mark the file system as corrupted.  That was
> clearly not the intent, so avoid to aborting the resize when a bad
> superblock is found.
> 
> In addition, teach update_backups() to properly update the checksum in
> the backup superblocks.  We will eventually want to unify
> updapte_backups() with the infrasture in ext4_update_primary_sb(), but
> that's for another day.
> 
> Note: The problem has been around for a while; it just didn't really
> matter until ext4_update_primary_sb() was added by commit bbc605cdb1e1
> ("ext4: implement support for get/set fs label").  And it became
> trivially easy to reproduce after commit 827891a38acc ("ext4: update
> the s_overhead_clusters in the backup sb's when resizing") in v6.0.
> 
> Cc: stable@kernel.org # 5.17+
> Fixes: bbc605cdb1e1 ("ext4: implement support for get/set fs label")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

I don't see a formal patch on the linux-ext4 mailing list yet though 
your previous mail was sent to the ML. Is there any plan to send a 
formal patch or is your mail enough? I also don't see it on 
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git yet.

Basically asking because we enforce that backporting is only allowed for 
patches that are sent to mailing lists so it's easier to follow progress 
were there any update to the patch warranted by reviews/feedback after 
we backported the patch. (In short, anything that can be fetched with b4 
shazam can be backported).

Let us know if there's anything we can do to help.

Thanks,
Quentin
