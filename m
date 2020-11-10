Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA782AE089
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Nov 2020 21:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKJUOd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Nov 2020 15:14:33 -0500
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:20289
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbgKJUOd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Nov 2020 15:14:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSrQmz/f/lggRTDbaTNveQURErQHXgvoGHV3e5tecWPZaQu3Mf9Rr5J6IFoCmTZ7XaCJZMQa1KDRmZnnW70u3UVF/PS5wZuiniHcjZ4AHk0v1JKcV8Rl6A9WLL+zbCMMwVRv0OR+0KUl8Buu0ECjR9sPbFhF152TCNjos7WDzSgGIbHqOhYALX6a1n9D2IzS83lG5LURAEgyBAuLUCAJnt7nC5Y4m2iwKJXV7ixY/Yj112aQtNez1YIDCRAsEVyf/qtGX6FYUiAgq5GyTCz6HokaBFGZFpKQufr4jW5AIFJ4XThd5mMmqp3uZutZRfa69WgKeiy4RT4mNXfR9yX6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZL2rPROV1RJnwB2zJqErOQk7SqkbQpW7tevPYcaAKw=;
 b=Uri92v3/T5+9tUL1EPegzUj+4xgE3s3cgdScvG44kbiYQWIjEWfXH6lAcn7n64VZtvsOE/ll+U7VG258hTz17/Bw+mtbGflcbt+ev3S+iru52pfizdOUKtmtC7+k/kFhAuWaFuJ8cxKkZcWQKS+93xa/6OTSlxjCiEa9ArD4kUfmu0gu9SeEnPpkHErWsMC6B40GsIbA0rAzJHfZ+qGbF4CBpGP/QqQwzVodQp8nFYydZHzmOixFHLocx9yz/OJ/jrHOxt1xIhA63K8Pm1oDM57yOGxHjPJe0d9yuyuYZOepZFTCxl0UcU/NGsuOEk0Irhd8vhSYyBDsgL76KyaMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZL2rPROV1RJnwB2zJqErOQk7SqkbQpW7tevPYcaAKw=;
 b=VOQM+BPdLqJhK9b0sz/LlBbruBiiwnxkOfX13hB0/tF58cKf+I5DfIu5XSPNGMfOaoT6pcpWesUzD5tzhUTDRud8U6Pezq0EhXpjIJsvNcNl8zi7B4SpBQdiDwOH7N36QIkbTuUMPhcyR364qmFgigWQE3E6x/199iLh6bqruCE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB3432.namprd11.prod.outlook.com (2603:10b6:a03:8a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Tue, 10 Nov
 2020 20:14:29 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 20:14:29 +0000
Subject: Re: looking for assistance with jbd2 (and other processes) hung
 trying to write to disk
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
References: <17a059de-6e95-ef97-6e0a-5e52af1b9a04@windriver.com>
 <20201110114202.GF20780@quack2.suse.cz>
 <7fa5a43f-bdd6-9cf1-172a-b2af47239e96@windriver.com>
 <20201110194623.GC2951190@mit.edu>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <4145280c-3f5e-58aa-62e8-f2a13a9f979e@windriver.com>
Date:   Tue, 10 Nov 2020 14:14:26 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201110194623.GC2951190@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.64.76.237]
X-ClientProxiedBy: BYAPR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:a03:60::31) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.76.237) by BYAPR07CA0054.namprd07.prod.outlook.com (2603:10b6:a03:60::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Tue, 10 Nov 2020 20:14:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be91f6c9-b7c8-4dcd-ef24-08d885b53a7b
X-MS-TrafficTypeDiagnostic: BYAPR11MB3432:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3432F78F55AF28C68A6A7A5DF6E90@BYAPR11MB3432.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgy/HVF3B7XeOFrjopT8ErR6fLlli/qAmujFOyoFjVwG1K4cfVNgjM+wtbXVeLJItSCYZgWy23x1jWeAcgMqE32F0/YsB1r/r63hFAgcW6QV7YhGByj1vrGBTTI72cWofsRFuMctm2s2MU2/lGsXE64dtqH0BVFpD7JZuggvhGvXKfPip8D54jdEBECfmw6oNG8NF8lP19vai83qf63LPvr9iBng0PEj9Xy48PeUR5iJWteOy4iKCdaQvGAFHZUQ0qjV5cYoJoUjWhsElzeZVOXJokU4NY5/I1xo/BE9JQfzkyJbkVqLIKyxlgQRolUS4ku0Zt/qowHVDGaEtXPq5HHRvxOW+80gEyqlO7pXL8vr0/WzZpTJWV4fiJiAcaAH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(346002)(366004)(136003)(186003)(53546011)(478600001)(83380400001)(52116002)(6916009)(26005)(956004)(6486002)(16576012)(31686004)(2616005)(44832011)(66946007)(16526019)(8676002)(4326008)(8936002)(86362001)(316002)(36756003)(2906002)(66556008)(5660300002)(66476007)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OszQzJZrYjPokIvn4npLheohIM7ALL2hv6U7hLrsZlpLQ1wUW75bDVWwm8z9txjhp2mff/jRkbBeoMpGcUXJ7mlFRCwfF8UQ5ApyLSDkmPdS63klAMal2fB4rbl2jzm6ewEi0oNbFaKdhMCfBB6PyyMFSftRynh2MCuiBOJ26o6Kt2L5SKNYxOUuRBF854tESvsdcBbQ4egS5/LRqHqYfQc+7+BeTeNvxTaKTcQQDpgGg2+9hhByJB0JZTIDKHvRxkN4KEbPdDX7onOWn4uVbjKuCUoJK49nmo4IB+C6NI/+13b6Dw0WPefXBk9yE4RXo67gT66zmQTz1yNeVTEzqNLE6hMgTFNdOYhPACXsCopz7GseIJW4pDTmDoRLRfwkdMgn4npsGzjLV/+L7fumi5MQLlQGggU3Z9pSYaD3VmTzF8aDSZwcqWq7vlc4yDY2xpF60vMUlPNsrVeKXdvbYdREXd8niIwzXFeMh77hcCEMiTHBoGp/1jM+bjsY72J1Z8WRoaornChsz9uCmxcLdG903Bdx2X2ar1fdZf1BRm8E9vsrp6HOwuN4Jq7PfHBU650mgogmcoxnWSBvO5BU5HvOT4Bwu7MissWWvblhKW4TibL4UhoOte/0h0DGKg63ensTYnOAihuvSjE0ldrzzaNl3hqzkOb+n4Mt7uAxq+fF6bXyb0VYgJ5Gmp1xFdfvBtSJnJhep7QfuTNNnEnA2/NE0/ucxFtN0pbgrsP7vPgJmcOcNc4f6MD9Z1HJTWUiJ34frVmVynAJgYEEIQiEOJIlbt5CqlNHfO9r/VJPiOssPE4+Qh8ELHP94J6ogUxh7ttHZ/dA/yEoDJY3NNelDUhMS5HL83VmlRWGNODv4SNjh7W1ia7MGXf0bK2Xpf2JLw+ByxDWoRVBpTmhkeYT3Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be91f6c9-b7c8-4dcd-ef24-08d885b53a7b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 20:14:29.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQZDPdI4A6nd4uclZqB0T39berWQUj3wfPXQXFHBQUpYGF9TZwkUfskQ1IyTB3G4EYiDKfY9tgpYsIPGck+pkvrQ5cffPyxSKFMO9KNmIVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3432
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11/10/2020 1:46 PM, Theodore Y. Ts'o wrote:
> [Please note this e-mail is from an EXTERNAL e-mail address]
> 
> On Tue, Nov 10, 2020 at 09:57:39AM -0600, Chris Friesen wrote:

>> Just to be sure, I'm looking for whoever has the BH_Lock bit set on the
>> buffer_head "b_state" field, right?  I don't see any ownership field the way
>> we have for mutexes.  Is there some way to find out who would have locked
>> the buffer?
> 
> It's quite possible that the buffer was locked as part of doing I/O,
> and we are just waiting for the I/O to complete.  An example of this
> is in journal_submit_commit_record(), where we lock the buffer using
> lock_buffer(), and then call submit_bh() to submit the buffer for I/O.
> When the I/O is completed, the buffer head will be unlocked, and we
> can check the buffer_uptodate flag to see if the I/O completed
> successfully.  (See journal_wait_on_commit_record() for an example of
> this.)

Running "ps -m 'jbd2'" in the crashdump shows jbd2/nvme2n1p4- in the 
uninterruptible state, with a "last run" timestamp of over 9 minutes 
before the crash.  Same for a number of jbd2/dm* tasks.  This seems like 
a very long time to wait for I/O to complete, which is why I'm assuming 
something's gone off the rails.

> So the first thing I'd suggest doing is looking at the console output
> or dmesg output from the crashdump to see if there are any clues in
> terms of kernel messages from the device driver before things locked
> up.  This could be as simple as the device falling off the bus, in
> which case there might be some kernel error messages from the block
> layer or device driver that would give some insight.

The timeline looks like this (CPUs 0,1,24,25 are the housekeeping CPUS):

The only device-related issue I see is this, just a bit over 9 minutes 
before the eventual panic.  Prior to this there are no crashdump dmesg 
logs for a couple hours previous.
[119982.636995] WARNING: CPU: 1 PID: 21 at net/sched/sch_generic.c:360 
dev_watchdog+0x268/0x280
[119982.636997] NETDEV WATCHDOG: mh0 (iavf): transmit queue 3 timed out

Then I see rcu_sched self-detecting stalls:
[120024.146369] INFO: rcu_sched self-detected stall on CPU { 25} 
(t=60000 jiffies g=10078853 c=10078852 q=250)
[120203.725976] INFO: rcu_sched self-detected stall on CPU { 25} 
(t=240003 jiffies g=10078853 c=10078852 q=361)
[120383.305584] INFO: rcu_sched self-detected stall on CPU { 25} 
(t=420006 jiffies g=10078853 c=10078852 q=401)

The actual panic is here:
[120536.886219] Kernel panic - not syncing: Software Watchdog Timer expired
[120536.886221] CPU: 1 PID: 21 Comm: ktimersoftd/1 Kdump: loaded 
Tainted: G        W  O   ------------ T 
3.10.0-1127.rt56.1093.el7.tis.2.x86_64 #1


Chris
