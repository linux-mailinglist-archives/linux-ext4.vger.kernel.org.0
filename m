Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB756FEE9F
	for <lists+linux-ext4@lfdr.de>; Thu, 11 May 2023 11:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjEKJWu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 May 2023 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbjEKJWn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 May 2023 05:22:43 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2053.outbound.protection.outlook.com [40.107.14.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACBA3A90
        for <linux-ext4@vger.kernel.org>; Thu, 11 May 2023 02:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLvaqnm+O/O7+0pdTmqtYurFreCncDxmgZ3+advB7wcoVT1XO304yWGRaqXfhSvlUygt6huXxs76vQEtgESbVpbT3SrpOrcz+kcr6LVJurVYcsbVT/K7UC3BG8iMYZw5BshlEIUz8jkQVdiil4sO4PixYdpyPwNWngbF1/vO/cHNSkl/mYscUz+8xCGwKRBr+x7b1UhbiDNN3nLViG1GaMv1qyOpAK5C+8gr7SP78rI9aRn+oJYKqftkg7trsBE9EBfezmgZFE4fw0+gOwt9dtr4SdvX8uhFbO20K2Ily4RTD68SkWqvr4wFqABWURjFkfNNtKt1iKjHKWa1z0yurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuxQ6GTLFk3Q5cOSrL/K2IoA4OAbteT9S4lP2HJB/N8=;
 b=gvg5S6tTIXjdYgRNGeXhmS5u/gVqge8ocrRhf9FSnc1AjnOiRVc984eEtZv+9o3yOUVIMCes+qR/qqa2T17gv3QZxstUEBFHQ96Qn/KH4my4CRO26pFEoJIOu6kGEQDayN9HoWIEzBkbUDNpiKsaCqx7NxYivfKTbnjnowj9Mf50lK1q8vDXD2mXxEuWoTkpoPhUlccWDCehPHkqCuUK+4vBRlZi7rUW837e+sA1YXU57G2U9AzICOELgEW6fwyPhgelG8MfAYYz/HIM/2wBMtSg0LNCnE/kUyjw5vydQ+6Xn+KGdJotmPjpmegDETEcptlwCkrQxl7WM50GsVpIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=othermo.de; dmarc=pass action=none header.from=othermo.de;
 dkim=pass header.d=othermo.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=othermo.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuxQ6GTLFk3Q5cOSrL/K2IoA4OAbteT9S4lP2HJB/N8=;
 b=sr1tCude8MhdU++FAP4sc9BOFa1E6BEFMc4KCH9BHt8bT+A1IxiKhoCPEgD16CW7F2F4sUFwz0u8MKaH2dusd7dtN9aDpbjRRAk1bchW2c0KXr4k+A+Axo5Q1ZLbIf7gTKquHHtbPi7W2xji7kjcawQEx/yeipGO2sfpwzQDHRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=othermo.de;
Received: from DB9P193MB1644.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2ae::24)
 by AM8P193MB0804.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 09:21:29 +0000
Received: from DB9P193MB1644.EURP193.PROD.OUTLOOK.COM
 ([fe80::f2e8:76f6:1195:9568]) by DB9P193MB1644.EURP193.PROD.OUTLOOK.COM
 ([fe80::f2e8:76f6:1195:9568%4]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 09:21:29 +0000
Message-ID: <578c0eb1-5271-b5fe-afa2-e2c1107b8968@othermo.de>
Date:   Thu, 11 May 2023 11:21:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To:     tytso@mit.edu
Cc:     famzah@icdsoft.com, gregkh@linuxfoundation.org, jack@suse.cz,
        linux-ext4@vger.kernel.org
References: <20230315185711.GB3024297@mit.edu>
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Content-Language: en-US
From:   Marcus Hoffmann <marcus.hoffmann@othermo.de>
In-Reply-To: <20230315185711.GB3024297@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::15) To DB9P193MB1644.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:10:2ae::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P193MB1644:EE_|AM8P193MB0804:EE_
X-MS-Office365-Filtering-Correlation-Id: 7564faf1-fe38-4b05-49ba-08db52011a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3MvfAjlz3bqdRTC+6p0V69ddG55+3bSmJH0NiveogdkeMMfmAzKFOtlsqEZumb3YxswoKlF2GH9O2MB+dsEqlU/XPCsttT0zC7zNdO7GKexNgPox28Ecjr0gyO8xfdD/61+AQWn83AQNbhf8+t9DdCpHKWrk/Ll1kj4IlrgjWsvvO84iSeTwrSS/kt82Ymg8T2Scd6uY7D+pF6SUkJXlLMk4AwuDkDmf1X1n197nquPw4bl1b4N1RQehuXXOFsyFSE0NKOvEHKAj7o8k3vQreyGiC/bKKvcD21QK387bALliWH5BgNTTUQDWEh2kbntUNOijYqtMJ0+1eA9qwmtrusA4ly6DjtSRO2DYMF2A3cSEZrrUnlwa/rrdJJ2zPwVW1gq2CLRahiSdyZHvDvDTwCE1XC6mnt7r1EAgN55bb5BdWZvENZKDWVv+aCRLZ35b77mmAFMIcDyO24rQbsviAUqYXg/o1xfmOxn/FGKjME99Yt4ksLg5gKbJDFDPfYYYRPd1klOsQTRcTlJIZXP2Yi7hFGl2xYciMBFbNruZ4bRYjB7dwGSTwYTIOTrC6DSG7nZZdL7hhEgk+nxLDsZeQwxQOhIFQBgOlPfrsdi/GHLM5pMszWn5xxf+d52PL4oCaHOCEockApqD1AG0bzXow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P193MB1644.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(136003)(396003)(346002)(366004)(376002)(451199021)(186003)(53546011)(6506007)(6512007)(478600001)(83380400001)(31686004)(2616005)(6486002)(316002)(5660300002)(8936002)(38100700002)(41300700001)(86362001)(8676002)(6916009)(66946007)(66556008)(66476007)(4326008)(2906002)(31696002)(36756003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGpaTkdTYU9SVExvS0RLL2dSR1p6YVBCay9RMW03VnJUa0Rvdk5rZnhBejlU?=
 =?utf-8?B?d0Z1amFoZ21WMGtJd1VmOUpLQ2YxRzk1cVNjMUh1aW4ycjFmU25yUDR4Yk1J?=
 =?utf-8?B?ZnBKdDhMRGI3RU5OczdXOHpTVjA4aGYxV0greEhKRG1tbUhRTWZ1YXlBV0Fz?=
 =?utf-8?B?aEEwbjNNY2xnekMvT2ZTNGhNcG12cjFrbzk0UXMxU090eE4zUHFmTkhHbzdX?=
 =?utf-8?B?YUk3K0hJb1RXbnRlNlcwZCtSVllsT1V3STl6dkFtMEtVWEM5RTFxM3YwclpS?=
 =?utf-8?B?NDRHZHJnZnFBOXg2ZjZGTU9sZm1WcWcybjNQdDB6NnUwWUJXdjhIaE9rYlpp?=
 =?utf-8?B?bGhNSFpPNW9NL21WNGVPMkVDem5vRFdxVkNpUDFHT29zeDdWZ1VtVWNIVDlj?=
 =?utf-8?B?cGlZbGt0WXdyMjhCRXgzU0NTdGpPcFRvMjRFNUcwY3I1NFEyd2RhSVpVTVlu?=
 =?utf-8?B?OC9hNmQydVV3V2IrMnI5MTJDemt0bmRITzVDQU1YT0k1MjhSZ0U0RXVBK1hJ?=
 =?utf-8?B?NFFZcjVvemZORW5SU01TRllxK2Y3blIzNzNwYTlSWUpGc08zRHkrNDF0Uk4r?=
 =?utf-8?B?eFM2SlJ4MGl6bXBQR1ozOGd5QTdoR1N3d1JZSGZzK1BVUXhKWVpyd01NclJP?=
 =?utf-8?B?VDFta2xEMkJpQWhrSVNvK2Z6L2F1a2V3N0hyOWErTEk4eXJNaDk3ZXJpMW90?=
 =?utf-8?B?anQ2NVA2dVgvbEhpMk5hZ2g2VjBOWHk0ZlhJNFJlbm4rK09PRVJDUkw2dXFx?=
 =?utf-8?B?ck83L2RSVndoWXNWT3c0T1VOY2w2bUc2NlZlWU1waG9VYURlcy9MdkkrVXNl?=
 =?utf-8?B?VjVWUDJBby9ieTNDMlQ5NWtSN28xalVUNHJRdXV6dWlJRC81ckZiNHpZM3NB?=
 =?utf-8?B?bURyb2xIZ0FKbTluUDRTQ3R1dElCR1AxZUtieUY5VmwrUTVuanV3eC9kdVht?=
 =?utf-8?B?MkI3M050aW5GSU9Sc1VETk91L0oybmVCVlA2blUvcEN4amt1OEFtQzBMMHBD?=
 =?utf-8?B?M1NSdnRjZ2tCbVA5L2QrcVJHalZFRVhFQkwzQnlMY09LdDlja09jNElqNk5G?=
 =?utf-8?B?a0tjNDVSbUl1cENvbnJmOWFtN2o4Z1NUZ1NjUHJyUWpaM1V4TVlJWTN2NHVO?=
 =?utf-8?B?cFRWdDVhMlpmdysxMVBERk1TV0ZNTTJrZGZibGQwSnZtL2FXUlBWV2RRakZE?=
 =?utf-8?B?QjllQmc5WWtQeUhPZ25wVStsbVVOYUUvVUswMmRQTWpvZGRGK2N5aEU2bmIy?=
 =?utf-8?B?cUhHVG0ydXVINWZzMGxGT2E1VWpKT2Z1bDQ4TkliTS9nSWYwaG9YR0RmU2ox?=
 =?utf-8?B?anptemFoOXZBa0xOVXFTTElzSk9TOWZQZGRBYlk1RGRieDErU1FnQVBKQ3Uz?=
 =?utf-8?B?UEV5Mm9TZVZMT1NEaVV6SGUwblJCdVpWM3pnaFlQS05wbmdGRmwxRVdJMFRS?=
 =?utf-8?B?QkdNb2tCcjlUK1JGMlBkLzRwZjMrTDBlZ0JXR1dZTFMvaXVoU29NQXNTRy9t?=
 =?utf-8?B?KytGZHYrSU9QSXVYdEc2NjBzMURTNEJjMStJZ2lialFXK2FtTEYyeXFJdHBz?=
 =?utf-8?B?clNmYzU3czdnWWtmdnFJakdpaC9IUmdIUkZYM25RMS9lckVldDh2R1RNelI0?=
 =?utf-8?B?cnFUb1ByUkptdWsvSExiV3BWdC93YXpGYjZ4cVNXNWxJU2pFb3ZMQXo5M05j?=
 =?utf-8?B?amowRVprL3NsTExsd2lzQWFzRDdvWG9PY0trN09NWWUrRStDa3ZmbjVRTm5P?=
 =?utf-8?B?c0xxRUZUVUlsc1RCdmxBY2hLNUJNNmFGVVJCU2YzRlJiU1hiWDZQTitrQjU2?=
 =?utf-8?B?SDc3OUtBQzVXMU9xbVY1dXhtb1pPTGtpYnRMSVZTd0s2cXpORVZKQWxVczBH?=
 =?utf-8?B?STkvbEVaeVVYZnBVNEc5cGF6czV0bDF6YWlhLzhsK2lmZzE4dkdNTU04dURh?=
 =?utf-8?B?QTZ5aGQ1cUVlUFpFeVd0LzJienJ2OGZwRTJGNnFrMTMwa2FmUGdJQXFxWEV4?=
 =?utf-8?B?QmdVVnowbTJRR3BBNzFmOHJhT2RpM1Q2aENZZkVqSkRqQVp0WEdxcXJObkhP?=
 =?utf-8?B?TXV3Z01FRUVnblA3WWkrbHhhVk5CRXhsUS9GMGZ6b0V1VVpldXUwZ0dCczFH?=
 =?utf-8?B?QU5vQk03cUZ3cUZ0Mkg3UHlBNG51UitEZjllZnlRdk9KbGtjcTNwbzlVT3ls?=
 =?utf-8?B?UFkxeFo0bC9NM0xCU3NzWE1pSHBYU21EbGdsZldZcTJ5cG04VzVOL0Y3RDJt?=
 =?utf-8?B?ZmczSmg4dEpTcm1CbnVkNk1oTzZRPT0=?=
X-OriginatorOrg: othermo.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7564faf1-fe38-4b05-49ba-08db52011a66
X-MS-Exchange-CrossTenant-AuthSource: DB9P193MB1644.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 09:21:29.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 85b1b12b-9424-4d9d-b1a2-39f36faa8bc7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoGXeIslNdDQRug8wAYEA7+xJVgkPBRKUueeErh7BjWlYkzrm4iiRjY55N24AVP1oZFnbJQkIKD4hjjDJDRI76pD9B847djOppm+hAXZo8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0804
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

> On Wed, Mar 15, 2023 at 18:57, Theodore Ts'o wrote:
>
> Yeah, sorry, I didn't see it since it was in an attachment as opposed
> to with an explicit [PATCH] subject line.
>
> And at this point, the data=3Djournal writeback patches have landed in
> the ext4/dev tree, and while we could try to see if we could land this
> before the next merge window, I'm worried about merge or semantic
> conflicts of having both patches in a tree at one time.
>
> I guess we could send it to Linus, let it get backported into stable,
> and then revert it during the merge window, ahead of applying the
> data=3Djournal cleanup patch series.  But that seems a bit ugly.  Or we
> could ask for an exception from the stable kernel folks, after I do a
> full set of xfstests runs on it.  (Of course, I don't think anyone has
> been able to create a reliable reproducer, so all we can do is to test
> for regression failures.)
>
> Jan, Greg, what do you think?

We've noticed this appearing for us as well now (on 5.15 with
data=3Djournaled) and I wanted to ask what the status here is. Did any fix
here make it into a stable kernel yet? If not, I suppose I can still
apply the patch posted above as a quick-fix until this (or another
solution) makes it into the stable tree?

Best,
Marcus
________________________________

othermo GmbH | Sitz der Gesellschaft: Alzenau | Amtsgericht Aschaffenburg: =
HRB 14783 | USt-IdNr.: DE319977978 | Gesch=C3=A4ftsf=C3=BChrung: Dr. Dennis=
 Metz.
