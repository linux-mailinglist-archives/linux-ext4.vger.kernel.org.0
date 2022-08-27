Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609555A3824
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Aug 2022 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiH0Og0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Aug 2022 10:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH0OgZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 27 Aug 2022 10:36:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AC46F57C
        for <linux-ext4@vger.kernel.org>; Sat, 27 Aug 2022 07:36:24 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27RDHrbj008637;
        Sat, 27 Aug 2022 14:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=QCTHTmMTOqpGtuGxtift5OXItmgGrxhJ9m8IY2zYJmw=;
 b=gdQGVwwbaZ+bt3HzRSIKXEZhuc75EHOKgglXzuLbZEWaiKeeHouwRA28aaCl1aNp/MEJ
 MX4Erf+PyXr6NxXJbzDiAUbLrRkJ4hGeX8GqUMTcY3zReAo30eFjC95W/wf14b6Bf1MH
 7pV3GspRiVrtEjyz0wNcd6H1mDQ+Cc0RJr2YdDTo8H4yARpPTT58E7XpbdAR5uqWC6yC
 MVVdma+aP5PHF8qsxWqdmTSLFqrzHddQAFwEuCEEIDdtGwGOFHgf3zaTPd/M7oQl7CAg
 3cuXaV3F6Ta55+cH1te9jSow24Qb3Sug5MXulZY2nwctsI1EBv2tW5fclvQ9+2H0rKdL aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7m1f90xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Aug 2022 14:36:11 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27REaA6t016864;
        Sat, 27 Aug 2022 14:36:10 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7m1f90x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Aug 2022 14:36:10 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27REa8oQ013270;
        Sat, 27 Aug 2022 14:36:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3j7aw8rb5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Aug 2022 14:36:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27REa5aX40501738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Aug 2022 14:36:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69168AE045;
        Sat, 27 Aug 2022 14:36:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC167AE053;
        Sat, 27 Aug 2022 14:36:03 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.91.223])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 27 Aug 2022 14:36:03 +0000 (GMT)
Date:   Sat, 27 Aug 2022 20:06:00 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Message-ID: <Ywor0BFVnLYj2bxH@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220823134508.27854-1-jack@suse.cz>
 <8e164532-c436-241f-33be-4b41f7f67235@i2se.com>
 <20220824104010.4qvw46zmf42te53n@quack3>
 <743489b4-4f9d-3a4d-d87e-e6bf981027c4@i2se.com>
 <20220825091842.fybrfgdzd56xi53i@quack3>
 <0a01dfee-59bf-7a16-6272-683a886e1299@i2se.com>
 <20220826101522.b552tn646qobrjdx@quack3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826101522.b552tn646qobrjdx@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PMkd3qb65OrixT8YUXrbnEpc2K2ORIp7
X-Proofpoint-ORIG-GUID: oxbd5a-_1bAtkAd0Y0DBBLMdp9ddVnQD
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208270059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 26, 2022 at 12:15:22PM +0200, Jan Kara wrote:
> Hi Stefan,
> 
> On Thu 25-08-22 18:57:08, Stefan Wahren wrote:
> > > Perhaps if you just download the archive manually, call sync(1), and measure
> > > how long it takes to (untar the archive + sync) in mb_optimize_scan=0/1 we
> > > can see whether plain untar is indeed making the difference or there's
> > > something else influencing the result as well (I have checked and
> > > rpi-update does a lot of other deleting & copying as the part of the
> > > update)? Thanks.
> > 
> > mb_optimize_scan=0 -> almost 5 minutes
> > 
> > mb_optimize_scan=1 -> almost 18 minutes
> > 
> > https://github.com/lategoodbye/mb_optimize_scan_regress/commit/3f3fe8f87881687bb654051942923a6b78f16dec
> 
> Thanks! So now the iostat data indeed looks substantially different.
> 
> 			nooptimize	optimize
> Total written		183.6 MB	190.5 MB
> Time (recorded)		283 s		1040 s
> Avg write request size	79 KB		41 KB
> 
> So indeed with mb_optimize_scan=1 we do submit substantially smaller
> requests on average. So far I'm not sure why that is. Since Ojaswin can
> reproduce as well, let's see what he can see from block location info.
> Thanks again for help with debugging this and enjoy your vacation!
> 

Hi Jan and Stefan,

Apologies for the delay, I was on leave yesterday and couldn't find time to get to this.

So I was able to collect the block numbers using the method you suggested. I converted the 
blocks numbers to BG numbers and plotted that data to visualze the allocation spread. You can 
find them here:

mb-opt=0, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-0-patched.png
mb-opt=1, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-1-patched.png
mb-opt=1, unpatched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-1-unpatched.png

Observations:
* Before the patched mb_optimize_scan=1 allocations were way more spread out in
  40 different BGs.
* With the patch, we still allocate in 36 different BGs but majority happen in
  just 1 or 2 BGs.
* With mb_optimize_scan=0, we only allocate in just 7 unique BGs, which could
  explain why this is faster.

Also, one strange thing I'm seeing is that the perfs don't really show any
particular function causing the regression, which is surprising considering
mb_optimize_scan=1 almost takes 10 times more time.

All the perfs can be found here (raw files and perf report/diff --stdio ):
https://github.com/OjaswinM/mbopt-bug/tree/master/perfs

Lastly, FWIW I'm not able to replicate the regression when using loop devices
and mb_optmize_scan=1 performs similar to mb-opmtimize_scan=0 (without patches
as well). Not sure if this is related to the issue or just some side effect of
using loop devices.

Will post here if I have any updates on this.

Regards,
Ojaswin
