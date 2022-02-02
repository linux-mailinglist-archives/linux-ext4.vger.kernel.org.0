Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EBE4A6CA3
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 09:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbiBBIIL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 03:08:11 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:28462 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243222AbiBBIIJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Feb 2022 03:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1643789288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjzA4N+50K827fUnuqmYFQleHgcUTNl55EyuCcigTzg=;
        b=dyQqK5ceyebWCKsDI/X/sfuXUczRfJKAPwlgA+d9hXWoCSQUz7AgHb+Qix36lW7m+FERZJ
        oxTEVZxtQLzID3W+O5QAF6e6mrLNKdRoU34VB5o1oDe9moe0lFaVWQ2g4ZaNoJ2W2QNvo9
        d8/tBGoljiQEPN4krnhQrBpYiwl7Fdw=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-Kf8AHZPOOFuPP2m1hGSqcA-1; Wed, 02 Feb 2022 09:08:07 +0100
X-MC-Unique: Kf8AHZPOOFuPP2m1hGSqcA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyaoAjLf4wV/E9a7p82SOZ85sUGKFzgnvChGXpjkL5EZdg0i3ZW7QjuYalJp4s6VG9upNRu4sy9zb9eec9AoZqis4QA0aB0kP4eXPhpvpcLYh1fcZ0MwyDZJ3H8pziDpLowEqhJqnKxHkZxeQATQMHJNeWvo/GP8mIhXH75oXBnZKI09EvYku4nKv1YixAeJ/SDAyu+nmwvVh8dg0kFpG8cNabhZhl7fIWn5O/p2Rj27PNq0GlqL4pr8O0RontLUiQTVQhOU6CixGl+9ClnOhpGiBFmVq3ObiAVxKVM/bpStnj+CmMmkFHXNyQHA5uxRZV6PNVQdV5mD0qnxJyhNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjzA4N+50K827fUnuqmYFQleHgcUTNl55EyuCcigTzg=;
 b=nhkK/okZqjkRWLP97H/Z/LAnKmTdFTiMzelqF2HNROZHI0YHet3rLFHxLnAyX+LeC53h3ao0NA+0zaHK1lpRKdjEnXryFSkKoOjELedmLYrmuBC8YjjTnT4neZ9rK8K8gGo6gewKDpJAJmmzSdyaOb6Zz+ffMUblNmqv70F2x1MZulq9y0Jj1cJj8mIJZRcrZ3J7+iohyP1Ax5mzif/JDPsy374ha1sfPj7jdqHTVSNhC4jvYA80Hn0RratVGMzmpMtffSzgF8HWYaMZX8qacGAJuyfdgvHkZX8ct/3IWjHd+Ou1KvY3lz0RMVuySaU2CsWpylCRI9HrxOMBuS5gDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by PAXPR04MB8528.eurprd04.prod.outlook.com (2603:10a6:102:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Wed, 2 Feb
 2022 08:08:06 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::5160:9fd7:9627:cb11]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::5160:9fd7:9627:cb11%5]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 08:08:06 +0000
Message-ID: <d086e0f2-126f-786a-b4af-d606aa0fa8d8@suse.com>
Date:   Wed, 2 Feb 2022 09:08:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: ext4's dependency on crc32c
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <73fc221b-400b-a749-4bca-e6854d361a9a@suse.com>
 <YflV+qAsrKCj8h1U@mit.edu>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <YflV+qAsrKCj8h1U@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::39) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24cc34e5-ad9d-48dd-056b-08d9e6232451
X-MS-TrafficTypeDiagnostic: PAXPR04MB8528:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB852883A18006923F63EBB3CBB3279@PAXPR04MB8528.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sou8l5WUnNtwwuQDZkP+KSrxWRsQ37vgkNBD37EqDcabDoBdc0TxZQtMNdPCWK7/QBss4436GzwnHxNHuYsDEM+RNI4TaEm7c6wjQJNKhazMw01bAR721l+HKYAUuWDGyr2+bsUFd4j4KofbftDh1zwirVKqhAdw5dhxNaWAFKuQ9or3usqHRsQKoTrizkk1rLbdQJY2q58kNvvWOvwDGs2FzOqw51kNHWBemNWVN9r8g4xqSiyzeMgxBVAIDFHnozMBwUSTnUVS2oUi9y+gDfkcfciaUVi+eZxEQsfzOCpwRxEoa1dJD141Arla8aml3nSB9mhRM7CVXYG3Kn8H55XSI8TIomqdT7Yab3Qol7a6lrBRmVchxYfasOg6IVXqFvvZeYgoz/EJqiOOQnXmAE8Qgzf5lHsf/u1jPEtkmF543ZxM8OVP+l4SwYuxMoUvYA57s/db/88BAEnz35gynidXvgZtaVnkTwYkjvG6lPY6OnqC/EGZ+2lzs0j1iYjiQXJSQuMwEDm8ukRUG2ErhYqfdKB1ws4X9YicLriPmVqePxIxPryU8gQfmJw7oAaEjT4uYy9YOY7JdeA4LE4QAWgMacAU75z+StyJ1e+rYUI+jX4F5pRIj0z5qmJ7TJmpmfsFDDzbLtBcOdYUB15e8L6zW1Zg1L8z1Lh+/3godS497f3Sk9YoCmrY2jreL4AVhaT3BgYl9OK1c1KZGguil1/iuQ2gZTQ8GmZ2v6xGUck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(53546011)(6506007)(4326008)(6666004)(8676002)(8936002)(186003)(2616005)(5660300002)(2906002)(66476007)(26005)(6512007)(6486002)(86362001)(66556008)(31696002)(66946007)(38100700002)(83380400001)(31686004)(6916009)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZENra2NXejBmb24zY1F1aVJMdjlJalhQRk1NWWxEK2drR0x6elB0c2lZUkZD?=
 =?utf-8?B?dlFjRldQVkpTUytyZVZzemx6OGNXTTNmdzFzalY4emtpdmk2b29WaldtY3FT?=
 =?utf-8?B?RVlXWDJrWmhueGJHeU9tNjlxenhoUGhaajd0Wmh0UFUwaUxLUURoQzJnclNY?=
 =?utf-8?B?bURIbCs0SE5NOFNBU3Z6N3BXWW9QdndRWVY2eTV5UEJ2ZkNhM29mQ2dOcTcx?=
 =?utf-8?B?MGRzYTQyOEJCandmS3F5cEszSFIvaG82bDlyNTdjSnBWVm5udEJka1U4bjlP?=
 =?utf-8?B?SG1Ed2paeHpPY2d6VEpNL2NEa2lzZWxRNXJ2dWZUWUY2eTBpNDBucnozdnhG?=
 =?utf-8?B?bkJBNzI2MWdpdTQ2dXhYZlJQMWp5ZmJrZ3l1aFRvQmZ5WW0rTUlYcGYzVVFR?=
 =?utf-8?B?NktqRFM1WEVCSVhJRlJVc0ZYQVczekgxZ3VsS0diQndkVzJhOEJ5Z1hnckty?=
 =?utf-8?B?TEtqK0p6a1cwRWVkSjV6RVJyWXpvQXpJUkRIWVNnUUcrODJjTnE5Ujh1bnA4?=
 =?utf-8?B?Qi9hZ1N6dDVNZWlVblNKV2E4cFB0bjJKMTBxY1V3Z25DaGw0eWphQndQMW81?=
 =?utf-8?B?eWdWTGEyN3orUENwWVhyRytPR3ZZVXoxMVUwR2dOSkQ4MEY0a01kdVVlU2Yw?=
 =?utf-8?B?WnE0UVQ5N3k0RWJ5Tmc0MzByaktBQW04TEdMa0xxd0xZeG9wQVRpbXROS25z?=
 =?utf-8?B?ZkVDMVdKdlpRTkhhb3lVRGlWeCtjdVp0YU9EOThmOWJFTHM0UDdIN2tDRDF5?=
 =?utf-8?B?a3B4RmxVOHZvL3ZRMHA3SlBQVmp4TFpleS9GcDJtOFB1V0Jsa1JkcXcwNi9h?=
 =?utf-8?B?YUt2Q3Q3WVdlRzNPbFgvRWtlTElTekVlZXRiQXlYcWlJc3RBYi81TE9WRlVW?=
 =?utf-8?B?S1A2KysxZDY3K2hpOWk2TFVoYXErUGJrY1Zrc0lFa0dOWkRLTTd5aWQzdytR?=
 =?utf-8?B?ck5LZDJQMEQreTIxZEVDTFluTkU4dTBhV3BRWUx0K1hPSjdpWXRzYndiSHBZ?=
 =?utf-8?B?eHBkR0lyMFFnOE52ZklYMzhMN2QxSzRVbzBWSmJHUXZXdDA2dG96aUdnbEJu?=
 =?utf-8?B?bmQvTnJPWFc5RHBFZEtoM1dsTHAzZ1RSQXdGbmM3SFlKWDlGMjdCV09lRXRJ?=
 =?utf-8?B?cVNMSFJUanBXaEVLdTMySDU1SzJWTWk1bUM2WVpLSHdhNkhFN1JUMitMaEts?=
 =?utf-8?B?UWlDellNZlBnMG9wRzlSdTJoUnpua3VaZTBSajRqWU5QSjgzZ0VuWGdDV0Fn?=
 =?utf-8?B?ckEyejhaVGFWbTRTMlBjUWRWd1pYRVAvVHdSeFNDUUhtQ1hlT0R5elMwbEVH?=
 =?utf-8?B?REJhMlJuSHFjVXRCYW5uWlNhTkU5VjNwcC9YQXY4bGUvUGcreHM1TUdIbnov?=
 =?utf-8?B?OUhjQnZLdWM0SkZJNmgvTkE4SmtMcUxzZUJMT0EvNytTWjYvcllTWm80aTBn?=
 =?utf-8?B?MEdMYm5oT3hXWkNZODZsZ1RDS3ZBVUI1cWthaDQ3dCs5eW9taWhRRFpla21J?=
 =?utf-8?B?RkwzYWVjQk0yL2drZS9GSVhpaG5PSFJLOXhpZWtZTENRYTV6V3V3ZlF0WFRm?=
 =?utf-8?B?bGJKK2w1YnJHZDlWK3o3bnRzRU13MkFSZFcybVk3NXQ5UWVrTHNzYzdhYUFP?=
 =?utf-8?B?RmhGdTVmdWpKazBWS0RueWNKNytYRDBqQThxeDQ1SlR4WkR3VDdodjZZd0Ns?=
 =?utf-8?B?cUdmNWhvRFBiZ203SFFJVFBMdjVHQ0VYWE81ZTEvNEs5NXpSb3ZLVVZuWStL?=
 =?utf-8?B?OXdCL2RlRWx5ZHVReStZcnFPazArb1lCb1BLaTRRU0xYU200RlF4cktqN3Fi?=
 =?utf-8?B?QjJ2Nk9VZ2d3OW16d2hOaGluUEhtRTlZZDFvbUUyY3NxbW0zdU1pcWljc1Jq?=
 =?utf-8?B?THlncmo3b2t3eEpkc293YVVNVDFodFFRY21ZdnF5a0lLalpsRk1zaTFpd29v?=
 =?utf-8?B?cTljYXNiUWY3R2pNMHNBQmk1aGVNS21CNWw0Wk53LytLc0pQZm4zTXViZFNx?=
 =?utf-8?B?Tmw1dzljUTVjQ2NBYVNEeW1YUnNiTndEREVrMUc3R01kZmNzVG9BVTk4djd3?=
 =?utf-8?B?MmJwbStmaDNNSWZseGcyUHdveXhveFJyeUxPVWZOak4zTzdCV3BVYWtwdDZl?=
 =?utf-8?B?S01UUm5OYUZaRXBWR3FrT2hFZ2c5TVVwYk5UM0gwSjRTWHM1czBpdHBNL29o?=
 =?utf-8?Q?LF6h9E3RRqMqLiR1GOMG4Hg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cc34e5-ad9d-48dd-056b-08d9e6232451
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 08:08:06.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xC/XFHykZKGmPg1dfGYSOKOVjTyagc+LH+N7PDIckYO2AlDJljX6K1x+wdD4KRALh5OPPGd1TKvoNILoYDzxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8528
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 01.02.2022 16:47, Theodore Ts'o wrote:
> On Tue, Feb 01, 2022 at 03:19:54PM +0100, Jan Beulich wrote:
>> Hello,
>>
>> in 5.16, due to (afaict) adad556efcdd ("crypto: api - Fix built-in
>> testing dependency failures") booting a system with cryptmgr.ko not
>> (perhaps manually) put in the initrd doesn't work when ext4.ko is
>> responsible for / . I've contacted Herbert already after finding
>> this issue with btrfs, but in the case of ext4 another aspect plays
>> into it: I've observed the problem on a system where ext4.ko is used
>> solely to service ext3 partitions (including / ), but aiui crc32c
>> isn't used at all in this case. Yet it's the attempt of loading it
>> which actually causes the mount (and hence booting) to fail.
>>
>> If my understanding is correct, wouldn't it make sense to skip the
>> call to crypto_alloc_shash() unless an ext4 superblock is being
>> processed?
> 
> Sure, there are some subtleties, though.  For example, we would need
> to make sure that sbi->s_chksum_driver() is initialized before we
> attempt to use it.  That's because an malicious attacker (or syzbot
> fuzzer --- is there a difference? :-) could force the file system
> feature bits to be set after we decide whether or not to allocate the
> crypto handle.  This can happen by having a maliciously corrupted file
> system image which sets the file system feature bits as part of the
> journal replay, or simply by writing to the superblock after it is
> mounted.

Can any of this happen for an ext3 partition (without destroying its
ext3 nature)? IOW would it be possible to set sbi->s_chksum_driver
depending on just file system type rather than individual features?

Jan

