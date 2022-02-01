Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA80C4A5E1C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Feb 2022 15:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiBAOT7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Feb 2022 09:19:59 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:59714 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239151AbiBAOT7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Feb 2022 09:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1643725197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OZqZ3t57qWxrM/4o0p1+Xnx4kpMG4BFj3uODsp4lRcE=;
        b=XtIqJoUvQ6XaKMBEzCN26Qa1TuPYimzyU9Ea5jrQhBYqLoTJZhw83SWQ7HehhQHn1Rdg8s
        h1c+yaDhtFsDZVEggZTB+CR9htQYxBOK7KzcsUcGm5RUpV7nLjS/3cfaSvPt9/hfCsEdyr
        k2dFbqMvpeJF1yvC3abl+6eI9CGQkmg=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2055.outbound.protection.outlook.com [104.47.0.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-29-kPCjdM7Wd4vzWsZGAmA-1; Tue, 01 Feb 2022 15:19:57 +0100
X-MC-Unique: 29-kPCjdM7Wd4vzWsZGAmA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpukknEPzjUt8wPKppgr/poUBJEahisaT+vDeLByXevRvZ9ywaBbMm4qpJDR4haSdOlKwwCQ0LcPbh6R5Bcpxb8CPOUEr7Z+UrJFh07sxafKAsgcfCMNueHIfYKajzHoaZEOBu6zBEs2yYoRnn4KFZpxCg2p5T+IcW8Q0NOsp2s6CFvm1fRFlQMI5/uImJW2YwMz4AqMk8aCba3W3p9JEusJpn5j2BT44yxEQkWbcucbcuG025ekDwk9V1CrS2Zk30+1oaKSFG3SJAiwjMHTsFnKnICelXA+SPmWiNacq56RRU6hiGkbrEow5+t1/zI88TxLslz41BYgGQcsVLReSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZqZ3t57qWxrM/4o0p1+Xnx4kpMG4BFj3uODsp4lRcE=;
 b=ZMTsHttDz3YEvQUJkoz270F+h0lQwouRtCayi3xSoC6RWAPZwoopBKV4BZaB0BDSTO0aqW0c1Ho9++dGlXg40Fys9NiByC2CXE/iJW8VE57Nz9HtvFDKrG7F27mYhQvWiCgjNSzSOvKyciAtOpt5ch0dGhYUqhRH2UZ1feXTtVDQZXcTR02I1ebOrzETgV08dXhpZPgHa+uc9IMc2eLK0TfmueCh7TVe9Kpd9oskKwhof25ihjRG/4Q4CZjf6RN3EfehSltWfFlQioUKaPEeBavJQzCTlb9epx71QzfnnEaYFjV4BsUq0qN10ZcofcYiCDJutXwHVypl8kvvarSCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Tue, 1 Feb
 2022 14:19:56 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::7cc2:78a3:4d40:9d45]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::7cc2:78a3:4d40:9d45%6]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 14:19:55 +0000
Message-ID: <73fc221b-400b-a749-4bca-e6854d361a9a@suse.com>
Date:   Tue, 1 Feb 2022 15:19:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
From:   Jan Beulich <jbeulich@suse.com>
Subject: ext4's dependency on crc32c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0096.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::37) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d5618c7-0a9a-4206-9191-08d9e58debaa
X-MS-TrafficTypeDiagnostic: AM7PR04MB6885:EE_
X-Microsoft-Antispam-PRVS: <AM7PR04MB688541793872F69CEA544BA3B3269@AM7PR04MB6885.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23Yvn+ahbG39HTLrQIHqtLLs3jSyl3bkVpCGyXcMa3lM6QrPyBEKVALr5ZIsaEYhmgB0qUVDic18NkiFlCxfwiff36IOMcyewDpFhy62s5ywojkAsq+JhE0TGB5d/9kAsSG7t0mTA2lSlGylTQ3qEo5tA6V8AocxHNoJpps/7sVa+b1H+64BmyhLaEA4YgqHRcrc43i57DBlxFD55JAP7myD7gLi3hQJ1OnM3fSdRTejcFmRGmlSX7LBAKUyQt/UjL1QDAaSqMalnsX4BqMlEEpuUxILiWINUpUj0kAajxnEsiZ0kAvIpQK+XkjgmAyTuxleq8shTwfm4I33ms0ETFixMxyr3OQJXQZ1jXDb3zaInrhTRQfqlFAx6gSvJ9g6htxo6LGzk7WDkyBGd7TMnwdPuyjpBewUmx035aYptYDZukZyJh+u58+Drz3uSAP5MmqvDGCVRpH28d2L3vBuS32WBztatfywfFnajBj4NDu+G28aDVs0GpGaBr3JbUKlVsDUDLGb5fByogvAuyBfIssFtoF7M71GtmCd+Qnlcoe9TCKj6Ngub9/Rdc+ovw2DRrPDePraX/2Y/JqARjkzUMHfegpBlficJe78vBaynDdxrBS9fJ7ecyNu26EwY0yCM9b317X+wXL4JlnXBrFBMUy1Fx3scHUJK+LEnfGX8/lWIDuf7X0E+MMguY6kwdsexOjoQkFGtS/pkXWVoYoQgZLilGLnHgATTdrRCGe7qY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(6486002)(66556008)(508600001)(26005)(2616005)(8676002)(186003)(38100700002)(8936002)(6916009)(36756003)(316002)(2906002)(31696002)(86362001)(5660300002)(83380400001)(4744005)(31686004)(6506007)(6512007)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckdKdjlBSmlnVVFSUkFkbEl0SEVGK08wYWU5cGtkL20xVURSVmwxUStOYjAx?=
 =?utf-8?B?QnVrVkUwTkZqb051bHBMZm9zV3k2aGRvVUsyZGpRa0pPdkI3N2tOclBVdWxG?=
 =?utf-8?B?U2ZHVy9uS2JRR1hFTTZsMmZTc0g1dVI5MHlrRjFhVXlPSkRzY0VWekhYOUJ2?=
 =?utf-8?B?Y2xlL01IMkRKS0FLT2NUZm1Jay9xcjkvTmI0RVNybWNMS0RQYldVelY3SjFG?=
 =?utf-8?B?TG1LNnNjeURCNk1SaVYyYkFwUTl1blVVY0N0NFhiVkRLR1JpKzRLTjhnY2xV?=
 =?utf-8?B?VkNJZ2x1dSs0a05GNzB1V1R2NVhqOEtGVTdkZkU5blcvcE5uQXVEeTkzcHNR?=
 =?utf-8?B?cXhyQ2FER2pMWGRRTWlMYjRLM2U3Y2hoUEwzQXd3cTNMK1JsUTQ0MUZNRzBN?=
 =?utf-8?B?WE1wT0gwSWlQdTNnU2IwQUxwYjVLRUdaVGRWQjhlRDZSYW8wYVU0WHBVU2Jz?=
 =?utf-8?B?c1FXQ3QvNXo2TWgxMkg0YlNLSzNZd1ZVS0ZWZlRUOUt6RDZwdEpHTDZIdWRJ?=
 =?utf-8?B?d1hQZnhsbHcyUk1UbGFQT3BTaVQ3YStDVlNtL0NuSWRDUy9qRUMrOENzZjZx?=
 =?utf-8?B?OEFXMVdtVHgwa1liMUFTM2IwT3Rac00xN0gyS3o2SnJBeHJzRStOcUh0WFpC?=
 =?utf-8?B?L0ZtWEZaU3dYUUN2bHFuTVF0QWx2bjYxU2syL1ViS3VnNzdENzZGc1psMURn?=
 =?utf-8?B?R1ZkajJ6dXZqUFVRdGdEdGpwZnFUakRVeitESUdOQ1FjYStUeUl5eEtFSnRi?=
 =?utf-8?B?WDQzZFI5c1dqUHRpaW01S0w4ekJXaG5lUzAweGJQWDRpVnRrWWlQNzRKSGdB?=
 =?utf-8?B?eEhvRTdhbWx4SDFsdEw2WlpiMURNYzlBbUtSTVZjNEVTN2x4ZEhtTlBJN2hl?=
 =?utf-8?B?YzRkcTZ3SXlFWGJPdU52S081UkZQZGtsRmJ3TzJma2ZicHQ0bjhUbGZNdk5T?=
 =?utf-8?B?WCszeHJmNUVpZTFlTkhaWmRXeGZkbEhXcWRQM1djVzAyZ1BGdTkzYzNEaytV?=
 =?utf-8?B?cjlJeGlBclIybkdaRTgyS0wyaHJ0QTVsQjVmZEFmTk1jK2dsU2lmZVFaQUV1?=
 =?utf-8?B?SGsyRmFoT2lhRVdmcVRYY2RCSG9BODVNY1RQNnFOTFVwQlRuZk1SZXViK1dJ?=
 =?utf-8?B?V2ZCZ2pLUGhXa01jTDN5YklSVUxsbFRaNStpYnA5TWlCUm1WQ0VzZVovcytx?=
 =?utf-8?B?bngwQkppMElIVEZzVWJncnBPbVMxcmR5ZHIzSzJ1aXVCNFlxdjRrT09XMUZI?=
 =?utf-8?B?dFNtaFlRSVlINGlZTTg5Lyt5NWJJcGQ5T09pTkZ4ODh1ZDN4VmU0RlFucFFD?=
 =?utf-8?B?ZGFNUnY1UjVsY0ZqeWxjRjMwRUNBSk5UUEFhMnUwWXZ5YWs3TmVWbk9UZ2pt?=
 =?utf-8?B?VS9BRDlDR21ucDhOZ0pXclNnQzBBS2NSb0JDWFlGaDE2eGNHa0lZUGJOT3o3?=
 =?utf-8?B?RVQrYXJhVk9BbWx6Mjdld2FMeDdXZVJDUFA3SkFUSCtIV3RCUzNFbE5tMkFm?=
 =?utf-8?B?TzNuNU1RNDIvRWttNnl6ckVFZXVVdWhhYzdyellLUkl3Z3Z2dmhaRDQ2Mnlh?=
 =?utf-8?B?WURiTzJaRWRHZHJIQk5lbHNzN2E2TGJoWDFmMG52Y1p1QlJWNGoxMlZtNjg5?=
 =?utf-8?B?NXBaQW1TZjhlY1pPcnhqckQyUEpNb2l5MFNYSWpUK3VuNFl0MHlEYjRDdW56?=
 =?utf-8?B?Uk9XdlYrUGVkR1RIVjB6ZEM3YWFrS0JMTWRJTHBkU3RRQTROcTdyM3d5WE9X?=
 =?utf-8?B?clRmei9xTTBLZjZsQ0V5TEIxVVBoZW5iSkNXK3JtZ2Z3MHh6MnVNM0wxYWlN?=
 =?utf-8?B?T3UrM0pBVUVBdFE1YjNlSTY5ZW9RUWxFS3g4eitmeHBOWGNqaFc4OXRXczVY?=
 =?utf-8?B?SUt4ODNXa1VFRmFhd1pjQVJCbFlnYkhZbzBpbC9PT3FocDEzZjAyVTR4NGVr?=
 =?utf-8?B?QUZzTHp0TFROS0phVFI4OUdRM3doNW1wRXUwTTdaSWZvMkpMUTU1SUJ6MnV5?=
 =?utf-8?B?SDdFOVVOT25INWVFUzFtTHBKdE1tbTNIMDhCMW41N2RIdjBZYkd5cWZ2Qmty?=
 =?utf-8?B?MGt5S1pLVEptRlNPVUkrQ2FLWEpNS2VTK2RBQ3ZBcTI2WmxlMCtITmNGcVd0?=
 =?utf-8?B?YTdwZm9oRVdKT25aZStKWVg0aEpaZGNhSTBXSXJCOHh6ZVV0cUpEeWxFQlB4?=
 =?utf-8?Q?+UHFyaJh7Ssx8HEgJJ3Mh0w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5618c7-0a9a-4206-9191-08d9e58debaa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 14:19:55.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW53XSgUoRMteFirKkSKaqQkGugr4bNfumNi+8jiTjd1B3BMIPt3bcIECPvoY29uVkVdyAUYFfUnT5PE1NRlyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

in 5.16, due to (afaict) adad556efcdd ("crypto: api - Fix built-in
testing dependency failures") booting a system with cryptmgr.ko not
(perhaps manually) put in the initrd doesn't work when ext4.ko is
responsible for / . I've contacted Herbert already after finding
this issue with btrfs, but in the case of ext4 another aspect plays
into it: I've observed the problem on a system where ext4.ko is used
solely to service ext3 partitions (including / ), but aiui crc32c
isn't used at all in this case. Yet it's the attempt of loading it
which actually causes the mount (and hence booting) to fail.

If my understanding is correct, wouldn't it make sense to skip the
call to crypto_alloc_shash() unless an ext4 superblock is being
processed?

Thanks, Jan

