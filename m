Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5C2AF63C
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Nov 2020 17:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgKKQYm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Nov 2020 11:24:42 -0500
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:1632
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbgKKQYl (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 11 Nov 2020 11:24:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp837lmgj3iRA//ZBFcZ0jB6K3c7/msnZ8cjsqyWkqXckrKCiFuEEwRJp23XvxqAJHj71bJMbR0EKtk/vKSctuPwEnC3eg9Thh8/J2i9MK4vWjhvhEtvyGWepEyWE3omuSZU1vwIzqscT4GJqTqw61dQP9tOVhRIr2YByPL52Yr4hk4GAezwU4A5I2rPHawzwHkZUcHZs4m1zWqxlq/FQf7BT39w0Lw2/XabaJgsJ5/RXn6e8V8emYsSHXdu26VhBuF482l1Vi+U3HH1G9++NM5XDZby4ARfkCGERCwdLxTcDvORYNnns3LmESsbwza1NXo2hjDqI9rTy/PC4zWNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLmnittKlrQpwi8UxsdZcf8RkoJlLDQrmN2RuKhJbE4=;
 b=jLalon9swfk6l6Qyc8/jPj3UN+BMG/M9ucXD9CtEpBNYogkGjZcTlDqKAmUiZFlbLA4rzaN+c1d8m2ITC6UMiZY38znLfHhbVUCwbKolN6NBKwvhm3BzZ7Mrlu5Mxshxj1ZmTcMTtctyU4Wet7TBiXRbLR40w7qSaorC5AYJoerkc0VYVUgxN0iaosNcpteNkmFGX5Zq2UPj1lf0nQLH9OAYo2drwpYyaLSMGdQx0lHa05nVCSbu7E5BQBkT15jtEnzWtbOwdBvfh5mZmBW3uOSOCbFq8qYQKeNBJY15AW4uLbc6inwLQ7iGGT+A2aKt06vioMAL+hS+0p8mo6bMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLmnittKlrQpwi8UxsdZcf8RkoJlLDQrmN2RuKhJbE4=;
 b=WHFtNcfeyU+gcV4ns39+u3OmccCACN55ivD+bgCbbonXp0cWZauZnIkMZYTq1gnuYvhgburH/AfKWcOn7hhmCsZQn3U7VJ9O8Uly21l1SZajyQ0eJOFrTNTxg5pwHxs/W/XNAtXCNOTjJyKQbGfeIgAkSgkn3LaY4/gcKMJm8bM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB2855.namprd11.prod.outlook.com (2603:10b6:a02:ca::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 16:24:38 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 16:24:38 +0000
Subject: Re: looking for assistance with jbd2 (and other processes) hung
 trying to write to disk
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
References: <17a059de-6e95-ef97-6e0a-5e52af1b9a04@windriver.com>
 <20201110114202.GF20780@quack2.suse.cz>
 <7fa5a43f-bdd6-9cf1-172a-b2af47239e96@windriver.com>
 <20201111155743.GG28132@quack2.suse.cz>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <654925b2-7c4a-2432-f75e-4fb9ef08a816@windriver.com>
Date:   Wed, 11 Nov 2020 10:24:35 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201111155743.GG28132@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.64.76.237]
X-ClientProxiedBy: BYAPR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:40::25) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.76.237) by BYAPR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:40::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 16:24:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fe19525-a214-4897-77f6-08d8865e48ca
X-MS-TrafficTypeDiagnostic: BYAPR11MB2855:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2855C6EDC81E6B54FE2AC974F6E80@BYAPR11MB2855.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YWnAVlv/fAkbl91NHS2uM42KDAVUy8BnvF1+oGpgCC9eIrm4fYgRM9NUFkBk9W5pu53rsGMOxhRIDZI0pd37nuVMhCVjsnR22YkGeRF5965KFTRVcWw9pB6eMP67uhGoD/300L1d00J+kWw7Dz0G5DD/N+Qk7ovktp1JRfMivI5bJgzBklKwZQAkxYSsbYkZo4Ebq6qdnrnkodac5g1Fc8lo8+yMuwP4RDi6bkA1b2gc89eGOrBOV/zdzUY2xrMJQXzI0IEkvN/+2pI4ey/QZxeSkjgXz7feTWPaxAt8OjBTrxrla9Jdb2Fk5ZEk1rkvRTp0MDj37VfxMuh4PgdPfsUxMl5ssYg9dTOn8a9G8rEwbcpgXUo0UQIFglyhZdD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39850400004)(376002)(136003)(31696002)(44832011)(83380400001)(5660300002)(16526019)(66476007)(66556008)(26005)(186003)(6916009)(8676002)(86362001)(53546011)(31686004)(36756003)(66946007)(8936002)(316002)(16576012)(478600001)(2906002)(52116002)(6486002)(956004)(4326008)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: s1tb4I1kS1RLKqck9gahKQQmeysEfWSajpxDoYQseTviZMuOLEbksq3mG9lXaDJmugCzkfXaX34rcc4kJUfdbud18P/ElYZi+wMmcjT9fM2oolLi3gg3flS4veJm03Ufy8BMdwKrB6uVRhUZWYN9NPVzem7CqpwWkMEsv2Gb5eloM73vozGOkZpawKRW8EPKYMUqEJz1gSUnjq+j4wDLrIqY2ygCz5DQRU9z97YTHMYb3ypDoyPv8i6sNxcNRjp7Pbx1QPXK3ZKvz6knNYnSVV+Ud5z0fNNoSqPvrWzsLA0cSz7Rbixr7Y5K2/Bu7hwO2qA5Lb3Icq74llX4tBRjF8W3gM8DZHYQmvuz/hfXFaFHRikLParpOld4ze3csE/GgriV2O/z6NV7G1ME9yU0GFZvGeoEbvC3sgrjvEPB3rvm/Nshdy03vpu3bnMM0F5sB/L3zFU6Vd7n/bCJ9U3wrzZiIyalBXyNREYN4k6Ghp7V6aGIgNhkv/VEC/MR1OhQjHoatd4P8NBJEbZne6RjOURKxc7JD5UNQSsNf9FoFBh6TALGaY1En6QD5fDrN1wuOsegBZdAKt7vKwWfqzkmO19seKqb1jqIjJ45f/Nx93rleXPolai6ZMLesvaxW7TISYvYjpkW+kC/JHM6n+QDqGwPMWh3rbHNOwGsa9v9UzvjsyG1AAU5kcbiw2+XhN1lNgJ0pzjbbpe7oZ88Zj7t5+yAYcIT7opJDTRn8jjFfWTq6Avu4KX/i6YQW/TaodcWLwyVkdLGmeX0XYCifA06FY4C/JiFj0Bpqjv0Xnxe12JAAafPyBDOu8ZAAOfnzBqPJQauzuH8mzZZw9hVDWZC2yrIbi8eOVa7jxsP+pPcopyZE8soTy92xhYRjgCGlrYEX5mqnKqaLiVeZtxC4Tv4HA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe19525-a214-4897-77f6-08d8865e48ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 16:24:38.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvhzG2RE4zFERZDKK69+p3cy3KMdSu2wsdjkbHV3IgH/1L3t0cTo7hJ4jLtSQCleOvn85TCFzDN3r2834pllG/pWbVmZ7KqHnNIFk9H+wR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2855
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11/11/2020 9:57 AM, Jan Kara wrote:
> On Tue 10-11-20 09:57:39, Chris Friesen wrote:
>> Just to be sure, I'm looking for whoever has the BH_Lock bit set on the
>> buffer_head "b_state" field, right?  I don't see any ownership field the way
>> we have for mutexes.  Is there some way to find out who would have locked
>> the buffer?
> 
> Buffer lock is a bitlock so there's no owner field. If you can reproduce
> the problem at will and can use debug kernels, then it's easiest to add
> code to lock_buffer() (and fields to struct buffer_head) to track lock
> owner and then see who locked the buffer. Without this, the only way is to
> check stack traces of all UN processes and see whether some stacktrace
> looks suspicious like it could hold the buffer locked (e.g. recursing into
> memory allocation and reclaim while holding buffer locked or something like
> that)...

That's what I thought. :)   Debug kernels are doable, but unfortunately 
we can't (yet) reproduce the problem at will.  Naturally it's only shown 
up in a couple of customer sites so far and not in any test labs.

> As Ted wrote the buffer is indeed usually locked because the IO is running
> and that would be the expected situation with the jdb2 stacktrace you
> posted. So it could also be the IO got stuck somewhere in the block layer
> or NVME (frankly, AFAIR NVME was pretty rudimentary with 3.10). To see
> whether that's the case, you need to find 'bio' pointing to the buffer_head
> (through bi_private field), possibly also struct request for that bio and see
> what state they are in... Again, if you can run debug kernels, you can
> write code to simplify this search for you...

Thanks, that's helpful.

Chris
