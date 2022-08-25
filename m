Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4705A1824
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Aug 2022 19:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbiHYRuP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Aug 2022 13:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239089AbiHYRuO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Aug 2022 13:50:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6DA80377
        for <linux-ext4@vger.kernel.org>; Thu, 25 Aug 2022 10:50:13 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PHkj13031632;
        Thu, 25 Aug 2022 17:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RZGEaULiD/xDmnTAe2RPIRxYbcN8I1XQEnD22s3rsog=;
 b=GvlluaxByHWzz8ekAfgpz6F39u/DO4FvtbB9nAPtPgHOYCb0PpuVApJFa1645H1PxUV6
 e7UYtuw5ZsFGo/+P+r/ZSpeTwJI0XjQa2Lrj4UeLy8KlUuSyosG3kJ142NUUIXgfQibK
 4i+VJPU70FQJOBsaqHid2tPLieS+5t3i2UCtGp2fb/CHqbGQZqu2JTgsJy+2MBry607f
 l6NtEkPc8WKq/L1zRvVSz1QhnoLPVe7lZXTAAmncvD0XDQ7KDDUQi+L8nbv6x96ADRBN
 olOiul5yme8eu+q9xYA7++6Imxy8mWnqSrinvEj6mNwQIGgYY0VPcIbZjKOgJODMpAvo gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j6dsg02w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 17:49:59 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27PHmZE0011057;
        Thu, 25 Aug 2022 17:49:59 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j6dsg02v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 17:49:58 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27PHaOrN028181;
        Thu, 25 Aug 2022 17:49:56 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3j2pvjcxpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 17:49:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27PHkpUO41484750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 17:46:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2061E5204F;
        Thu, 25 Aug 2022 17:49:54 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.3.19])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0A69B5204E;
        Thu, 25 Aug 2022 17:49:51 +0000 (GMT)
Date:   Thu, 25 Aug 2022 23:19:48 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Message-ID: <Ywe2IKIvwlca1ab9@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220823134508.27854-1-jack@suse.cz>
 <8e164532-c436-241f-33be-4b41f7f67235@i2se.com>
 <20220824104010.4qvw46zmf42te53n@quack3>
 <20220824141338.ailht7uzm6ihkofb@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824141338.ailht7uzm6ihkofb@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0FlL3krO-8BJTrXtVLKoP5jSPJMHEZzA
X-Proofpoint-ORIG-GUID: 1mQtGBZNr91Ew99wTUPqKUYVRPHOIsv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1011 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 24, 2022 at 04:13:38PM +0200, Jan Kara wrote:
> On Wed 24-08-22 12:40:10, Jan Kara wrote:
> > Hi Stefan!
> > 
> > On Wed 24-08-22 12:17:14, Stefan Wahren wrote:
> > > Am 23.08.22 um 22:15 schrieb Jan Kara:
> > > > Hello,
> > > > 
> > > > So I have implemented mballoc improvements to avoid spreading allocations
> > > > even with mb_optimize_scan=1. It fixes the performance regression I was able
> > > > to reproduce with reaim on my test machine:
> > > > 
> > > >                       mb_optimize_scan=0     mb_optimize_scan=1     patched
> > > > Hmean     disk-1       2076.12 (   0.00%)     2099.37 (   1.12%)     2032.52 (  -2.10%)
> > > > Hmean     disk-41     92481.20 (   0.00%)    83787.47 *  -9.40%*    90308.37 (  -2.35%)
> > > > Hmean     disk-81    155073.39 (   0.00%)   135527.05 * -12.60%*   154285.71 (  -0.51%)
> > > > Hmean     disk-121   185109.64 (   0.00%)   166284.93 * -10.17%*   185298.62 (   0.10%)
> > > > Hmean     disk-161   229890.53 (   0.00%)   207563.39 *  -9.71%*   232883.32 *   1.30%*
> > > > Hmean     disk-201   223333.33 (   0.00%)   203235.59 *  -9.00%*   221446.93 (  -0.84%)
> > > > Hmean     disk-241   235735.25 (   0.00%)   217705.51 *  -7.65%*   239483.27 *   1.59%*
> > > > Hmean     disk-281   266772.15 (   0.00%)   241132.72 *  -9.61%*   263108.62 (  -1.37%)
> > > > Hmean     disk-321   265435.50 (   0.00%)   245412.84 *  -7.54%*   267277.27 (   0.69%)
> > > > 
> > > > Stefan, can you please test whether these patches fix the problem for you as
> > > > well? Comments & review welcome.
> > > 
> > > i tested the whole series against 5.19 and 6.0.0-rc2. In both cases the
> > > update process succeed which is a improvement, but the download + unpack
> > > duration ( ~ 7 minutes ) is not as good as with mb_optimize_scan=0 ( ~ 1
> > > minute ).
> > 
> > OK, thanks for testing! I'll try to check specifically untar whether I can
> > still see some differences in the IO pattern on my test machine.
> 
> I have created the same tar archive as you've referenced (files with same
> number of blocks) and looked at where blocks get allocated with
> mb_optimize_scan=0 and with mb_optimize_scan=1 + my patches. And the
> resulting IO pattern looks practically the same on my test machine. In
> particular in both cases files get allocated only in 6 groups, if I look
> at the number of erase blocks that are expected to be touched by file data
> (for various erase block sizes from 512k to 4MB) I get practically same
> numbers for both cases.
> 
> Ojaswin, I think you've also mentioned you were able to reproduce the issue
> in your setup? Are you still able to reproduce it with the patched kernel?
> Can you help debugging while Stefan is away?
> 
>                 Honza
Hi Jan,

So I ran some more tests on v6.0-rc2 kernel with and without your patches and
here are the details:

Workload:-
  time tar -xf rpi-firmware.tar -C ./test
  time sync

System details:
  - Rpi 3b+ w/ 8G memory card (~4G free)
  - tar is ~120MB compressed

And here is the output of time command for various tests. Since some of them
take some time to complete, I ran them only 2 3 times each so the numbers might
vary but they are indicative of the issue.

v6.0-rc2 (Without patches)

mb_optimize_scan = 0

**tar**
real    1m39.574s
user    0m10.311s
sys     0m2.761s  

**sync**
real    0m22.269s
user    0m0.001s
sys     0m0.005s

mb_optimize_scan = 1

**tar**
real    21m25.288s
user    0m9.607
sys     0m3.026

**sync**
real    1m23.402s
user    0m0.005s
sys     0m0.000s

v6.0-rc2 (With patches)

mb_optimize_scan = 0

* similar to unpatched (~1 to 2mins) *

mb_optimize_scan = 1

**tar**
real    5m7.858s
user    0m11.008s
sys     0m2.739s

**sync**
real    6m7.308s
user    0m0.003s
sys     0m0.001s

At this point, I'm pretty confident that it is the untar operation that is
having most of the regression and no other download/delete operations in
rpi-update are behind the delay. Further, it does seem like your patches
improve the performance but, from my tests, we are still not close to the
mb_optimize_scan=0 numbers.

I'm going to spend some more time trying to collect the perfs and which block 
group the allocations are happening during the untar to see if we can get a better
idea from that data. Let me know if you'd want me to collect anything else.

PS: One question, to find the blocks groups being used I'm planning to take
the dumpe2fs output before and after untar and then see the groups where free blocks
changed (since there is nothing much running on Pi i assume this should give us
a rough idea of allocation pattern of untar), just wanted to check if there's a
better way to get this data.

Regards,
Ojaswin
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
