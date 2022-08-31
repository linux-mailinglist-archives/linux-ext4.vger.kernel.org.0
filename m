Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37375A7798
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiHaHgn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 03:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiHaHgk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 03:36:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2189B0B3C
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 00:36:37 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V7RErg003083;
        Wed, 31 Aug 2022 07:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=iG6dXHRf+fsI6yA5sborzh2wE5+k4dfYGDJeM6S1PaE=;
 b=SJuU/4BI4SHy0cACOvY+3/o/o70turjOpFVgdX0S15WNKOs2SZsIG86hx3vWMN8iMXSW
 fe70kvxMJIgls/xafQTft/MxOQJswILdHUPH+eZqERWcz6hojltp6I8ykmXmrMCQ6O0m
 itYSRkcdG2z/aOC7nEKjLtniQ5L6vDrCBNK4NHmkAewuUOKDpDmJiYjGIYuYqSJSOQv+
 yV9m/ImGjhX4jJTZpC8v9slm0f+hKq++HQCq2ya26DhvIbD7XDxabhP1Fz06A4YFdfwJ
 vx6utQw925CAshoM9i9DB3scmggB2kFPQVHf6BuWHyXdJh5rSezL0OUNhDFpSPBuBRVJ Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ja3940cgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 07:36:26 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27V7RFpp003120;
        Wed, 31 Aug 2022 07:36:26 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ja3940cf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 07:36:26 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27V7Zoco029434;
        Wed, 31 Aug 2022 07:36:24 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3j7aw94w40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 07:36:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27V7X7HK37749028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 07:33:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B6B34C046;
        Wed, 31 Aug 2022 07:36:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E144C040;
        Wed, 31 Aug 2022 07:36:20 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.126.45])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Aug 2022 07:36:20 +0000 (GMT)
Date:   Wed, 31 Aug 2022 13:06:17 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Message-ID: <Yw8PUAT8wOefQ7jf@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220823134508.27854-1-jack@suse.cz>
 <8e164532-c436-241f-33be-4b41f7f67235@i2se.com>
 <20220824104010.4qvw46zmf42te53n@quack3>
 <743489b4-4f9d-3a4d-d87e-e6bf981027c4@i2se.com>
 <20220825091842.fybrfgdzd56xi53i@quack3>
 <0a01dfee-59bf-7a16-6272-683a886e1299@i2se.com>
 <20220826101522.b552tn646qobrjdx@quack3>
 <Ywor0BFVnLYj2bxH@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20220829090434.sfxv3rrma32apbi2@quack3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829090434.sfxv3rrma32apbi2@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AEnkD-qVtO-Q53w7LYemrwWirVjj85R2
X-Proofpoint-GUID: VSPKk7qjIbY_5gNfM2zXF3yv9_p75w17
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_03,2022-08-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 29, 2022 at 11:04:34AM +0200, Jan Kara wrote:
> On Sat 27-08-22 20:06:00, Ojaswin Mujoo wrote:
> > On Fri, Aug 26, 2022 at 12:15:22PM +0200, Jan Kara wrote:
> > > Hi Stefan,
> > > 
> > > On Thu 25-08-22 18:57:08, Stefan Wahren wrote:
> > > > > Perhaps if you just download the archive manually, call sync(1), and measure
> > > > > how long it takes to (untar the archive + sync) in mb_optimize_scan=0/1 we
> > > > > can see whether plain untar is indeed making the difference or there's
> > > > > something else influencing the result as well (I have checked and
> > > > > rpi-update does a lot of other deleting & copying as the part of the
> > > > > update)? Thanks.
> > > > 
> > > > mb_optimize_scan=0 -> almost 5 minutes
> > > > 
> > > > mb_optimize_scan=1 -> almost 18 minutes
> > > > 
> > > > https://github.com/lategoodbye/mb_optimize_scan_regress/commit/3f3fe8f87881687bb654051942923a6b78f16dec
> > > 
> > > Thanks! So now the iostat data indeed looks substantially different.
> > > 
> > > 			nooptimize	optimize
> > > Total written		183.6 MB	190.5 MB
> > > Time (recorded)		283 s		1040 s
> > > Avg write request size	79 KB		41 KB
> > > 
> > > So indeed with mb_optimize_scan=1 we do submit substantially smaller
> > > requests on average. So far I'm not sure why that is. Since Ojaswin can
> > > reproduce as well, let's see what he can see from block location info.
> > > Thanks again for help with debugging this and enjoy your vacation!
> > > 
> > 
> > Hi Jan and Stefan,
> > 
> > Apologies for the delay, I was on leave yesterday and couldn't find time to get to this.
> > 
> > So I was able to collect the block numbers using the method you suggested. I converted the 
> > blocks numbers to BG numbers and plotted that data to visualze the allocation spread. You can 
> > find them here:
> > 
> > mb-opt=0, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-0-patched.png
> > mb-opt=1, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-1-patched.png
> > mb-opt=1, unpatched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-1-unpatched.png
> > 
> > Observations:
> > * Before the patched mb_optimize_scan=1 allocations were way more spread out in
> >   40 different BGs.
> > * With the patch, we still allocate in 36 different BGs but majority happen in
> >   just 1 or 2 BGs.
> > * With mb_optimize_scan=0, we only allocate in just 7 unique BGs, which could
> >   explain why this is faster.
> 
> Thanks for testing Ojaswin! Based on iostats from Stefan, I'm relatively
> confident the spread between block groups is responsible for the
> performance regression. Iostats show pretty clearly that the write
> throughput is determined by the average write request size which is
> directly related to the number of block groups we allocate from.
> 
> Your stats for patched kernel show that there are two block groups which
> get big part of allocations (these are likely the target block groups) but
> then remaining ~1/3 is spread a lot. I'm not yet sure why that is... I
> guess I will fiddle some more with my test VM and try to reproduce these
> allocation differences (on my test server the allocation pattern on patched
> kernel is very similar with mb_optimize_scan=0/1).
> 
> > Also, one strange thing I'm seeing is that the perfs don't really show any
> > particular function causing the regression, which is surprising considering
> > mb_optimize_scan=1 almost takes 10 times more time.
> 
> Well, the time is not spent by CPU. We spend more time waiting for IO which
> is not visible in perf profiles. You could plot something like offcpu flame
> graphs, there the difference would be visible but I don't expect you'd see
> anything more than just we spend more time in functions waiting for
> writeback to complete.
Ahh I see, that makes sense.
> 
> > Lastly, FWIW I'm not able to replicate the regression when using loop devices
> > and mb_optmize_scan=1 performs similar to mb-opmtimize_scan=0 (without patches
> > as well). Not sure if this is related to the issue or just some side effect of
> > using loop devices.
> 
> This is because eMMC devices seem to be very sensitive to IO pattern (and
> write request size). For loop devices, we don't care about request size
> much so that's why mb_optimize_scan makes no big difference. But can you
> still see the difference in the allocation pattern with the loop device?
So i tested with loop devices and yes I do see a similar allocation
pattern althout the regression is not there.

Thanks,
Ojaswin
